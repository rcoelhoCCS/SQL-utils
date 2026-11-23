SELECT * FROM [CCS_EbankitMW].[dbo].[Transaction] WHERE 1 = 1
--AND ContactHistoryId LIKE '2000140'
AND ContactHistoryId in ('1100046', '1100017', '1100031')
--AND [Description] like '%TRXP1214%'
--AND RequiresAuthentication = 0
AND InteractionTypeId = 900
AND ChannelId = 0
--AND ContactHistoryId != 0
order by ContactHistoryId

--TransactionId=2000096

SELECT * FROM [CCS_EbankitMPS].[dbo].[Transaction] WHERE ContactTransactionId in ('1100046', '1100031', '1100017')

SELECT * FROM [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION] WHERE transaction_Id in (1100013, 1100025, 1100017)

SELECT * FROM [CCS_EbankitMPS].[dbo].[Transaction] WHERE 1 = 1  
--AND ContactTransactionId in ('1100031')
--AND TransactionCode like '%Wire%'
AND iIDTransaction = 599
--AND CredentialType = 12
AND idchannel = 0

SELECT DISTINCT iIDTransaction FROM [CCS_EbankitMPS].[dbo].[Transaction] WHERE 1 = 1  
--AND ContactTransactionId in ('1000022')
--AND TransactionCode like '%Wire%'
AND iIDTransaction = 599
--AND CredentialType = 5


SELECT * FROM CCS_EbankitSecurityCenter.[dbo].[TB_TRANSACTION] WHERE transaction_Id in ('2000096')

/*UPDATE [CCS_EbankitMPS].[dbo].[Transaction]
 SET [CredentialType] = 12
 WHERE ContactTransactionId like '1100046'

 UPDATE [CCS_EbankitMW].[dbo].[Transaction]
 SET [RequiresAuthentication] = 0
 WHERE ContactHistoryId like '1100046' */