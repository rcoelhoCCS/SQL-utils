USE [CCS_EbankitMW]
GO

SET XACT_ABORT ON;
SET NOCOUNT ON;

DECLARE @commit BIT = 0;   -- 0 = preview + rollback, 1 = commit
DECLARE @transactionName VARCHAR(200) = 'FatcaDeclarationTransaction';
DECLARE @mappingField VARCHAR(50) = 'DummyAccountNumber';

DECLARE @contactTransactionID VARCHAR(15);
DECLARE @labelId INT;
DECLARE @contentTypeId INT;

SELECT @contactTransactionID = [ContactTransactionID]
FROM [CCS_EbankitMPS]..[Transaction]
WHERE [TransactionCode] = @transactionName;

SELECT @labelId = [LabelId]
FROM [CCS_EbankitMW].[dbo].[TransactionLabel]
WHERE [TransactionId] = @transactionName AND [MappingField] = @mappingField;

IF @contactTransactionID IS NULL OR @labelId IS NULL
    THROW 50001, 'Transaction or label not found; nothing to delete.', 1;

SELECT @contentTypeId = [contentType_Id]
FROM [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION_LABEL]
WHERE [transaction_Id] = @contactTransactionID AND [transactionLabel_Id] = @labelId;

-- Preview
SELECT 'MW.TransactionLabel' AS [Source], * FROM [CCS_EbankitMW].[dbo].[TransactionLabel]
WHERE [TransactionId] = @transactionName AND [MappingField] = @mappingField;
SELECT 'SC.TB_TRANSACTION_LABEL' AS [Source], * FROM [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION_LABEL]
WHERE [transaction_Id] = @contactTransactionID AND [transactionLabel_Id] = @labelId;
SELECT 'SC.TB_GLOBAL_TYPE_LANG' AS [Source], * FROM [CCS_EbankitSecurityCenter].[dbo].[TB_GLOBAL_TYPE_LANG]
WHERE [contentType_Id] = @contentTypeId;

BEGIN TRANSACTION;

DELETE FROM [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION_LABEL]
WHERE [transaction_Id] = @contactTransactionID AND [transactionLabel_Id] = @labelId;
PRINT 'TB_TRANSACTION_LABEL deleted: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

IF @contentTypeId IS NOT NULL
   AND NOT EXISTS (SELECT 1 FROM [CCS_EbankitSecurityCenter].[dbo].[TB_TRANSACTION_LABEL]
                   WHERE [contentType_Id] = @contentTypeId)
BEGIN
    DELETE FROM [CCS_EbankitSecurityCenter].[dbo].[TB_GLOBAL_TYPE_LANG]
    WHERE [contentType_Id] = @contentTypeId;
    PRINT 'TB_GLOBAL_TYPE_LANG deleted: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

    DELETE FROM [CCS_EbankitSecurityCenter].[dbo].[TB_GLOBAL_CONTENT_TYPE]
    WHERE [contentType_Id] = @contentTypeId;
    PRINT 'TB_GLOBAL_CONTENT_TYPE deleted: ' + CAST(@@ROWCOUNT AS VARCHAR(10));
END

DELETE FROM [CCS_EbankitMW].[dbo].[TransactionLabel]
WHERE [TransactionId] = @transactionName AND [MappingField] = @mappingField;
PRINT 'TransactionLabel deleted: ' + CAST(@@ROWCOUNT AS VARCHAR(10));

IF @commit = 1
    COMMIT TRANSACTION;
ELSE
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Preview only: rolled back. Set @commit = 1 to apply.';
END