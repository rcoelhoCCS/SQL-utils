USE [CCS_EbankitMW]

-- Insert Label
-- Note: it's calling 2 DB (SC and MW) 

-- SC label type
--labelType_Id	description
--1				bigint
--2				int
--3				smallint
--4				tinyint
--5				bit
--6				decimal
--7				numeric
--8				money
--9				smallmoney
--10			float
--11			real
--12			datetime
--13			smalldatetime
--14			char
--15			varchar
--16			text
--17			nchar
--18			nvarchar
--19			ntext
--20			binary
--21			varbinary
--22			image
--23			cursor
--24			timestamp
--25			uniqueidentifier
--26			double
--27			hora
--28			string
--29			data
--30			short
--31			boolean
--32			long


--MW label type
--TransactionLabelTypeId	TransactionLabelType
--0							Default
--1							AccountNumber
--2							Currency
--3							Amount
--4							BeneficiaryAccountNumber
--5							DateTime
--6							Percent
--7							TransactionUserDescription

SET NUMERIC_ROUNDABORT OFF
SET NOCOUNT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

DECLARE @pv binary(16)

BEGIN TRANSACTION

GO

declare @labels table(_transactionName VARCHAR(200), _mappingField VARCHAR(50), _fieldDescription NVARCHAR(3000), _labelType_Id tinyint, _length smallint, _labelTypeMW int)

DECLARE @MPStransactionName VARCHAR(200) = 'ExternalAccountTransferTransaction';
DECLARE @contactTransactionID VARCHAR(15);
DECLARE @newLabelId int;
DECLARE @newContentType int;
DECLARE @labelOrder int;

insert into @labels values
	(@MPStransactionName, 'TransferFrom',  'Transfer from', 28, 100, 0),
	(@MPStransactionName, 'Institution',  'Institution', 28, 100, 0),
	(@MPStransactionName, 'Transit',  'Transit', 28, 100, 0),
	(@MPStransactionName, 'TransferTo',  'Deposit funds to', 28, 100, 0),
	(@MPStransactionName, 'Amount',  'Amount', 6, 100, 3),
	(@MPStransactionName, 'InitiateOn',  'Initiate transfer on', 28, 100, 0),
	(@MPStransactionName, 'ReceiveFirstOn',  'Initiate first transfer on', 28, 100, 0),
	(@MPStransactionName, 'EndDate',  'End date', 28, 100, 0),
	(@MPStransactionName, 'Frequency',  'Transfer frequency', 28, 100, 0),
	(@MPStransactionName, 'PurposeTransfer',  'Purpose of transfer', 28, 100, 0),
	(@MPStransactionName, 'Memo',  'Memo', 28, 100, 0),
	(@MPStransactionName, 'MemberName',  'Member name', 28, 100, 0),
	(@MPStransactionName, 'DebitAccountNumber',  'Debit account number', 28, 100, 1),
	(@MPStransactionName, 'Currency',  'Currency', 28, 100, 2)



SELECT @contactTransactionID = [ContactTransactionID] FROM [CCS_EbankitMPS]..[Transaction] WHERE [TransactionCode] = @MPStransactionName;


declare @transactionName VARCHAR(200);
declare @mappingField VARCHAR(50);
declare @fieldDescription NVARCHAR(3000);
declare @labelType_Id tinyint;
declare @length smallint;
declare @labelTypeMW int;


begin tran insert_labels

declare c_labels cursor for select * from @labels
	open c_labels

	fetch next from c_labels into @transactionName, @mappingField, @fieldDescription, @labelType_Id, @length, @labelTypeMW

	while @@fetch_status = 0 
	begin
		IF NOT EXISTS (SELECT 1 FROM [CCS_EbankitMW]..[TransactionLabel] where [MappingField] = @mappingField and [TransactionId] = @transactionName)
		BEGIN
			INSERT INTO [CCS_EbankitSecurityCenter]..[TB_GLOBAL_CONTENT_TYPE] VALUES (1, GETDATE());

			SELECT @newContentType = @@IDENTITY;

			PRINT N'Adding new ContentType ' + CAST(@newContentType AS VARCHAR) + ' for the label [' + @mappingField + ']';

			INSERT INTO [CCS_EbankitSecurityCenter]..[TB_GLOBAL_TYPE_LANG] VALUES (@newContentType, 'EN', 1, @fieldDescription, 'TB_TRANSACTION_LABEL', 1, GETDATE(), GETDATE());
		
			SELECT @newLabelId = (MAX([LabelId]) + 1) FROM [CCS_EbankitMW]..[TransactionLabel] WHERE [TransactionId] = @transactionName;

			IF(@newLabelId is null)
			BEGIN
				SET @newLabelId = 1
			END

			SELECT @labelOrder = (MAX([order]) + 1) FROM [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL] where [transaction_Id] = @contactTransactionID;

			IF(@labelOrder is null)
			BEGIN
				SET @labelOrder = 1
			END

			INSERT INTO [dbo].[TransactionLabel] VALUES (@transactionName, @labelTypeMW, @newLabelId, @mappingField, 1, 1, 0, NULL, 'Banking');		

			if((select top(1) [transaction_Id] from [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION_LABEL] where transaction_Id = @contactTransactionID and transactionLabel_Id = @newLabelId) is null)
			begin
				INSERT INTO [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION_LABEL] VALUES (@contactTransactionID, @newLabelId, 1, 1, NULL, NULL, @labelOrder, 1, @newContentType, @labelType_Id, @length, 3, 0, 1, GETDATE(), GETDATE(), 0, 1);
			end			

			IF @@ERROR <> 0
				BEGIN
					PRINT N'Failed to add ContentType ' + CAST(@newContentType AS VARCHAR) + ' for the label [' + @mappingField + ']';
				END
			ELSE
				BEGIN
					PRINT N'Added ContentType ' + CAST(@newContentType AS VARCHAR) + ' for the label [' + @mappingField + ']';
				END
		END
		ELSE IF NOT EXISTS(select top(1) * from [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION_LABEL] where transaction_Id = @contactTransactionID and transactionLabel_Id = (select top(1) LabelId from [CCS_EbankitMW].[dbo].[TransactionLabel] where TransactionId = @transactionName and MappingField = @mappingField))
		BEGIN
			INSERT INTO [CCS_EbankitSecurityCenter]..[TB_GLOBAL_CONTENT_TYPE] VALUES (1, GETDATE());

			SELECT @newContentType = @@IDENTITY;

			PRINT N'Adding new ContentType ' + CAST(@newContentType AS VARCHAR) + ' for the label [' + @mappingField + ']';

			INSERT INTO [CCS_EbankitSecurityCenter]..[TB_GLOBAL_TYPE_LANG] VALUES (@newContentType, 'EN', 1, @fieldDescription, 'TB_TRANSACTION_LABEL', 1, GETDATE(), GETDATE());
		
			select top(1) @newLabelId = LabelId from [CCS_EbankitMW].[dbo].[TransactionLabel] where TransactionId = @transactionName and MappingField = @mappingField

			SELECT @labelOrder = (MAX([order]) + 1) FROM [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL] where [transaction_Id] = @contactTransactionID;

			IF(@labelOrder is null)
			BEGIN
				SET @labelOrder = 1
			END

			if((select top(1) [transaction_Id] from [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION_LABEL] where transaction_Id = @contactTransactionID and transactionLabel_Id = @newLabelId) is null)
			begin
				INSERT INTO [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION_LABEL] VALUES (@contactTransactionID, @newLabelId, 1, 1, NULL, NULL, @labelOrder, 1, @newContentType, @labelType_Id, @length, 3, 0, 1, GETDATE(), GETDATE(), 0, 1);
			end	
		END
		ELSE
		BEGIN
			UPDATE [CCS_EbankitSecurityCenter].[dbo].[TB_GLOBAL_TYPE_LANG]
			SET [description] = @fieldDescription
			WHERE contentType_Id =
				(select contentType_Id from [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL]
				WHERE transaction_Id = @contactTransactionID
				AND transactionLabel_Id = (select LabelId From [CCS_EbankitMW]..[TransactionLabel]
				where Transactionid = @transactionName  AND MappingField = @mappingField))
		END

	fetch next from c_labels into @transactionName, @mappingField, @fieldDescription, @labelType_Id, @length, @labelTypeMW
	end
		
	close c_labels
	deallocate c_labels

commit tran insert_labels


GO

COMMIT TRANSACTION