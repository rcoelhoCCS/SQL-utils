  USE [CCS_EbankitMW]
  
  UPDATE [dbo].[TransactionLabel]
  SET IsWorkflowVisible = 1
  WHERE TransactionId = 'WireTransferRequestTransaction'
  AND [MappingField] IN ('SenderAddress')