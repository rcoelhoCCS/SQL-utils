DECLARE @transactionId INT = 1100000

--SELECT * FROM [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL]
--	WHERE transaction_Id = @transactionId --AND transactionLabel_Id = 88


DECLARE @transactionName nvarchar(100) = '%MULTIPLE%'

SELECT * FROM [CCS_EbankitMW]..[TransactionLabel]
where Transactionid like @transactionName 
-- AND MappingField = 'ExtendedParameterString_L2'

select * from [CCS_EbankitSecurityCenter].[dbo].[TB_GLOBAL_TYPE_LANG] where contentType_Id in (select contentType_Id from [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL]
				WHERE transaction_Id = @transactionId
				AND transactionLabel_Id = (select LabelId From [CCS_EbankitMW]..[TransactionLabel]
				where Transactionid = @transactionName  
				AND MappingField = 'ThirdPartyRelationship'
				))