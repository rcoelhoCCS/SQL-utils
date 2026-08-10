
SELECT*
  FROM [CCS_EbankitMPS].[dbo].[CCS_TransactionAllowList]
  where 1 = 1
  AND transaction_id = 1000157
  AND profileId = 40983310


  INSERT INTO [CCS_EbankitMPS].[dbo].[CCS_TransactionAllowList] 
  values ('ALASTOR', 1000157, '40983310', '' , '')