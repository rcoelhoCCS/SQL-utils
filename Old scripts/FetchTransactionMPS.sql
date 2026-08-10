USE CCS_EbankitMPS

SELECT * FROM [dbo].[Transaction] WHERE 1=1 
--AND ContactTransactionID LIKE '1000172'
--AND iIDTransaction = 606
order by ContactTransactionID


--SELECT * FROM [dbo].[Transaction] WHERE ContactTransactionID LIKE '1100002'
--order by ContactTransactionID

--select * from [dbo].[Transaction] where TransactionName like '%TFSATermAccountOpeningTransaction%'
--SELECT * FROM [dbo].[Transaction] WHERE ContactTransactionID LIKE '2000050'

--SELECT * FROM [dbo].[Transaction] WHERE ContactTransactionID LIKE '1000039'

--1000167
--1100009
--1100010