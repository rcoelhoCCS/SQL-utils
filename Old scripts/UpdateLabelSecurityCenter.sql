UPDATE [CCS_EbankitSecurityCenter].[dbo].[TB_GLOBAL_TYPE_LANG]
SET [description] = 'Do you have Mutual Funds or RESPs with us through Worldsource Financial Management?',
[updateDate] = GETDATE() 
WHERE [ContentType_Id] = (SELECT [ContentType_Id] FROM [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION_LABEL] 
    where [transaction_Id] = 1000022 and [TransactionLabel_Id] = 5018)