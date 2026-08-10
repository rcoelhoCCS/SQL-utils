use CCS_EbankitMPS
declare @resources table(_module nvarchar(50), _name nvarchar(100), _desc nvarchar(max))

insert into @resources values
	/* DBP-3152 Product Type Category */
	('TRXC1802796', 'TERM', 'Open a GIC'),
	('TRXC1802796', 'Title', 'Open a GIC'),
	('TRXC1802796', 'ConfirmationTitleTERM', 'Open a GIC'),
	('TRXC1802796', 'ResultTitleTERM', 'Open a GIC'),
	('TRXC1802796', 'TitleTERM', 'Open a GIC'),
    ('TRXC1804796', 'TERM', 'Open a GIC'),
    /* DBP-661 UI Form Normalization*/
    ('JS', 'DepositAmountEmpty', 'Enter deposit amount'),
    ('TRXC1802', 'AccountDetails', 'Account details'),
    ('TRXC1802', 'AccountExtraDetails', 'Things we need to ask'),
    /* DBP-646 Settlement Account Education*/
    ('TRXC1802', 'AccountTransferTitle', 'Account to transfer funds from'),
    ('TRXC1802', 'AccountTransferSubtitle', 'Must be same account type as the GIC (e.g. TFSA Savings to TFSA GIC).'),
	('TRXC1802796', 'ddlDefaultText', 'Select an account'),
	('TRXC1802', 'InitialDepositSubtitle', '${0} &ndash; ${1}'),
	/* DBP-4574  Membership capitalize text*/
	('TRXC1802', 'SelectMembership', 'Select a membership'),
	/* DBP-4576 DBP-4577 Error for dropdowns */
	('JS', 'SelectAnOption', 'Select an option')
declare @applicationId SMALLINT = 7;
DECLARE @contentTypeId BIGINT;
declare @isGeneric BIT = 0;
declare @createdBy VARCHAR(50) = '2.5.0';
declare @updatedBy VARCHAR(50) = '2.5.0';
declare @now DATETIME = GETDATE();
declare @lang BIGINT = 2;

declare @module varchar(500);
declare @name varchar(500);
declare @desc varchar(500);

begin tran insert_resources

declare c_resources cursor for select * from @resources
	open c_resources

	fetch next from c_resources into @module, @name, @desc

	while @@fetch_status = 0 begin
		if (@module = 'Generic')
		begin
			set @isGeneric = 1
		end
		else
		begin
			set @isGeneric = 0
		end
		
		set @contentTypeId = (select [contentTypeId] 
								from [Resources] 
							   where [Module] = @module 
								 and [Name] = @name 
								 and [ApplicationId] = @applicationId)
		
		if (@contentTypeId is null)
			begin
				select @contentTypeId = (max([contentType]) + 1) from [ContentType];

				insert into [ContentType] VALUES (@contentTypeId, '', @createdBy, @now, @updatedBy, @now);
				insert into [Resources] values (@applicationId, @isGeneric, @name, @module, @createdBy, @now, @updatedBy, @now, @contentTypeId);
				insert into [ResourceLang] values (@lang, @desc, @createdBy, @now, @updatedBy, @now, @contentTypeId);
			end
		else
			update [ResourceLang] SET 
				[Description] = @desc, 
				[ModifiedBy] = @updatedBy, 
				[Modified] = @now
			WHERE [ContentTypeId] = @contentTypeId AND [idCulture] = @lang

	fetch next from c_resources into @module, @name, @desc
	end

	close c_resources
	deallocate c_resources

commit tran insert_resources