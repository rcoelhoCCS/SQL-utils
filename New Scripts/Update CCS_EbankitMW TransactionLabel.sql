DECLARE @transactionName nvarchar(100) = 'WireTransferRequestTransaction'

UPDATE [CCS_EbankitMW]..[TransactionLabel]
SET LabelId = 1000
where Transactionid = @transactionName  AND MappingField = 'ThirdPartyNameEntity'

UPDATE [CCS_EbankitMW]..[TransactionLabel]
SET LabelId = 97
where Transactionid = @transactionName  AND MappingField = 'ThirdPartyRelationshipCode'

UPDATE [CCS_EbankitMW]..[TransactionLabel]
SET LabelId = 96
where Transactionid = @transactionName  AND MappingField = 'ThirdPartyRelationship'

UPDATE [CCS_EbankitMW]..[TransactionLabel]
SET LabelId = 95
where Transactionid = @transactionName  AND MappingField = 'ThirdPartLastName'

UPDATE [CCS_EbankitMW]..[TransactionLabel]
SET LabelId = 94
where Transactionid = @transactionName  AND MappingField = 'ThirdPartyMiddleName'

UPDATE [CCS_EbankitMW]..[TransactionLabel]
SET LabelId = 93
where Transactionid = @transactionName  AND MappingField = 'ThirdPartyFirstName'

UPDATE [CCS_EbankitMW]..[TransactionLabel]
SET LabelId = 92
where Transactionid = @transactionName  AND MappingField = 'ThirdPartyNameEntity'