use CCS_EbankitMPS

declare @transactions table(transactionID integer, umbracoNode varchar(100))

insert into @transactions values
('1000067','OPENACCOUNTRSPI'),
('1000064','OPENACCOUNTRSPV')

declare @transactionID integer
declare @umbracoNode varchar(100)
declare @transactionNameDNA varchar(50)

begin tran insert_transactions

declare c_transactions cursor for 

select 
	case when dna.vcTransactionName is null then 'DummyTransaction' else CONVERT(varchar, dna.vcTransactionName) +  CONVERT(varchar, dna.ProjectID) end as transactionNameDNA,
	mps.ContactTransactionID,
	t.umbracoNode

	from [Transaction] mps

	INNER JOIN @transactions t on 
	t.transactionID = mps.ContactTransactionID

	LEFT JOIN [CCS_EbankitDNA].[dbo].[tblDSGNTransactions] dna ON
	mps.iIDTransaction= dna.iIDTransaction 

	open c_transactions

	fetch next from c_transactions into @transactionNameDNA, @transactionID, @umbracoNode

	while @@fetch_status = 0 begin

	IF NOT EXISTS (SELECT * FROM [CCS_EbankitMPS].dbo.GenericTableLanguage WHERE tblName = 'TransactionTranslate' AND [value] = @transactionID)
	BEGIN
		INSERT INTO [CCS_EbankitMPS].dbo.GenericTableLanguage ([tblName], [language], [value], [display], [description], [extraInfo], [CREATION_DATE], [CREATION_USER], [LAST_CHANGE_DATE], [LAST_CHANGE_USER]	)
		VALUES ('TransactionTranslate','en-GB',@transactionID,@transactionNameDNA,@umbracoNode, NULL,GETDATE(), 'ccsuser',getdate(),'ccsuser')
	END
	ELSE
	BEGIN
		UPDATE [CCS_EbankitMPS].dbo.GenericTableLanguage SET [description] = @umbracoNode WHERE tblName = 'TransactionTranslate' AND [value] = @transactionID
	END

	fetch next from c_transactions into @transactionNameDNA, @transactionID, @umbracoNode
	end

	close c_transactions
	deallocate c_transactions

commit tran insert_transactions