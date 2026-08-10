use CCS_EbankitMPS

IF EXISTS (SELECT * FROM dbo.GenericTableLanguage WHERE tblName = 'TransactionTranslate' AND [value] ='1000064')
	BEGIN
		UPDATE dbo.GenericTableLanguage SET [description] = 'OPENACCOUNTRSPV' WHERE tblName = 'TransactionTranslate' AND [value] = '1000064'
	END
ELSE 
	BEGIN
		INSERT INTO [CCS_EbankitMPS].dbo.GenericTableLanguage ([tblName], [language], [value], [display], [description], [extraInfo], [CREATION_DATE], [CREATION_USER], [LAST_CHANGE_DATE], [LAST_CHANGE_USER]	)
		VALUES ('TransactionTranslate','en-GB','1000064','TRXC1801796','OPENACCOUNTRSPV', NULL,GETDATE(), 'ccsuser',getdate(),'ccsuser')	
	END
IF EXISTS (SELECT * FROM dbo.GenericTableLanguage WHERE tblName = 'TransactionTranslate' AND [value] ='1000067')
	BEGIN
		UPDATE dbo.GenericTableLanguage SET [description] = 'OPENACCOUNTRSPI' WHERE tblName = 'TransactionTranslate' AND [value] = '1000067'
	END
ELSE 
	BEGIN
		INSERT INTO [CCS_EbankitMPS].dbo.GenericTableLanguage ([tblName], [language], [value], [display], [description], [extraInfo], [CREATION_DATE], [CREATION_USER], [LAST_CHANGE_DATE], [LAST_CHANGE_USER]	)
		VALUES ('TransactionTranslate','en-GB','1000067','TRXC1802796','OPENACCOUNTRSPI', NULL,GETDATE(), 'ccsuser',getdate(),'ccsuser')	
	END