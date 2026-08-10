DECLARE @transactionId INT = 1000157
DECLARE @transactionName nvarchar(100) = 'WireTransferRequestTransaction'

UPDATE [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL]
	SET transactionLabel_Id = 1000
	WHERE transaction_Id = @transactionId
	AND transactionLabel_Id = (select LabelId From [CCS_EbankitMW]..[TransactionLabel]
		where Transactionid = @transactionName  AND MappingField = 'ThirdPartyNameEntity')

UPDATE [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL]
	SET transactionLabel_Id = 97
	WHERE transaction_Id = @transactionId
	AND transactionLabel_Id = (select LabelId From [CCS_EbankitMW]..[TransactionLabel]
		where Transactionid = @transactionName  AND MappingField = 'ThirdPartyRelationshipCode')

UPDATE [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL]
	SET transactionLabel_Id = 96
	WHERE transaction_Id = @transactionId
	AND transactionLabel_Id = (select LabelId From [CCS_EbankitMW]..[TransactionLabel]
		where Transactionid = @transactionName  AND MappingField = 'ThirdPartyRelationship')

UPDATE [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL]
	SET transactionLabel_Id = 95
	WHERE transaction_Id = @transactionId
	AND transactionLabel_Id = (select LabelId From [CCS_EbankitMW]..[TransactionLabel]
		where Transactionid = @transactionName  AND MappingField = 'ThirdPartLastName')

UPDATE [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL]
	SET transactionLabel_Id = 94
	WHERE transaction_Id = @transactionId
	AND transactionLabel_Id = (select LabelId From [CCS_EbankitMW]..[TransactionLabel]
		where Transactionid = @transactionName  AND MappingField = 'ThirdPartyMiddleName')

UPDATE [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL]
	SET transactionLabel_Id = 93
	WHERE transaction_Id = @transactionId
	AND transactionLabel_Id = (select LabelId From [CCS_EbankitMW]..[TransactionLabel]
		where Transactionid = @transactionName  AND MappingField = 'ThirdPartyFirstName')

UPDATE [CCS_EbankitSecurityCenter]..[TB_TRANSACTION_LABEL]
	SET transactionLabel_Id = 92
	WHERE transaction_Id = @transactionId
	AND transactionLabel_Id = 1000