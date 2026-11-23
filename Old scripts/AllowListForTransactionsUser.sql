
SELECT*
  FROM [CCS_EbankitMPS].[dbo].[CCS_TransactionAllowList]
  where 1 = 1
  AND transaction_id = 1100046
  AND profileId = '40929121'

  update [CCS_EbankitMPS].[dbo].[CCS_TransactionAllowList]
  set ExpiryDate = null, campaignId = null
  where transaction_id = 1100045
  and profileId = '40929121'


  INSERT INTO [CCS_EbankitMPS].[dbo].[CCS_TransactionAllowList] 
  values ('KARINA', 1100045, '40929121', null , null)

  --Karina: 40929121
  --HansCapon: 40929123