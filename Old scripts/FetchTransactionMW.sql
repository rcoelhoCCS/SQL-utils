USE CCS_EbankitMW

select * from [dbo].[Transaction] 
where 1 = 1
and ContactHistoryId IN ('1100017', '1000019')
--and TransactionId like 'ViewT5Transaction'
--and TransactionId like '%EBMKInteracETransfers%'
--and (ContactHistoryId like '1000040' or ContactHistoryId LIKE '1000182')
--and TransactionId like '%CCSViewEStatementsTransaction%' or TransactionId like '%PayBills%' or ContactHistoryId LIKE '1000182' or ContactHistoryId LIKE '1000179'