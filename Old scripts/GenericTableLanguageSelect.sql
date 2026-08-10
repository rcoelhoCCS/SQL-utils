select * from [CCS_EbankitMPS].dbo.GenericTableLanguage where tblName = 'OcupationTable'-- and [description] = 'EXTERNALACCOUNTMANAGE'
select * from [CCS_EbankitMPS].dbo.GenericTableLanguage where tblName = 'TransactionTranslate' and [description] = '%ACCOUT%'

--BEGIN TRAN
--	IF EXISTS(SELECT * FROM [CCS_EbankitMPS].[dbo].[GenericTableLanguage] 
--					WHERE tblName = 'TransactionTranslate'
--					AND value = '1000179' AND display = 'TRXC1910796')
--	BEGIN
--		UPDATE [CCS_EbankitMPS].[dbo].[GenericTableLanguage]
--		SET description = 'EXTERNALACCOUNTMANAGE',
--		LAST_CHANGE_DATE = GETDATE(),
--		LAST_CHANGE_USER = 'WinnerUser'
--		WHERE tblName = 'TransactionTranslate'
--					AND value = '1000179' AND display = 'TRXC1910796'
--	END
--	ELSE
--	BEGIN
--		INSERT INTO [CCS_EbankitMPS].[dbo].[GenericTableLanguage] 
--		VALUES ('TransactionTranslate','en-GB','1000179','TRXC1910796','EXTERNALACCOUNTMANAGE',NULL,GETDATE(),'WinnerUser',GETDATE(),'WinnerUser')
--	END
--COMMIT TRAN

-- select * from [CCS_EbankitMPS].dbo.GenericTableLanguage where tblName = 'TransactionTranslate' and [description] LIKE '%OPENCONTRACTFHSA%'