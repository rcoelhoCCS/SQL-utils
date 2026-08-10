SELECT * FROM [CCS_EbankitMW].[dbo].[Transaction] WHERE 1 = 1
--AND ContactHistoryId LIKE '2000140'
--AND ContactHistoryId in ('1100029')
--AND [Description] like '%TRXP1214%'
--AND RequiresAuthentication = 0
--AND InteractionTypeId = 900
AND ChannelId = 0
AND ContactHistoryId != 0
order by ContactHistoryId

--TransactionId=2000096

SELECT * FROM [CCS_EbankitMPS].[dbo].[Transaction] WHERE ContactTransactionId in ('1100013', '1100031', '1100017')

SELECT * FROM [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION] WHERE transaction_Id in (1100013, 1100025, 1100017)

SELECT * FROM [CCS_EbankitMPS].[dbo].[Transaction] WHERE 1 = 1  
AND ContactTransactionId in ('2000139')
--AND TransactionCode like '%Wire%'
--AND iIDTransaction = 511


SELECT * FROM CCS_EbankitSecurityCenter.[dbo].[TB_TRANSACTION] WHERE transaction_Id in ('2000096')

-- UPDATE [CCS_EbankitMPS].[dbo].[Transaction]
-- SET [IsEnable] = 1
-- WHERE ContactTransactionId like '1001021'