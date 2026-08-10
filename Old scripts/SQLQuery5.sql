BEGIN TRAN
	IF EXISTS(SELECT * FROM [CCS_EbankitMPS].[dbo].[GenericTableLanguage] 
					WHERE tblName = 'TransactionTranslate'
					AND [value] = '1000181' AND display = 'TRXC1802796')
	BEGIN
		UPDATE [CCS_EbankitMPS].[dbo].[GenericTableLanguage]
		SET description = 'OPENACCOUNTFHAI',
		LAST_CHANGE_DATE = GETDATE(),
		LAST_CHANGE_USER = 'WinnerUser'
		WHERE tblName = 'TransactionTranslate'
					AND [value] = '1000181' AND display = 'TRXC1802796'
	END
	ELSE
	BEGIN
		INSERT INTO [CCS_EbankitMPS].[dbo].[GenericTableLanguage] 
		VALUES ('TransactionTranslate','en-GB','1000181','TRXC1802796','OPENACCOUNTFHAI',NULL,GETDATE(),'WinnerUser',GETDATE(),'WinnerUser')
	END
COMMIT TRAN