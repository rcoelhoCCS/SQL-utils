USE [CCS_EbankitMPS]


select * from [dbo].[Transaction] where ContactTransactionId = 1000067


select * from [dbo].[Transaction] where TransactionCode like 'OPENACCOUNTTRSPI'

SELECT * FROM [CCS_EbankitMPS].[dbo].[GenericTableLanguage] where tblName = 'TransactionTranslate' and [description] like '%OPENACCOUNT%'
