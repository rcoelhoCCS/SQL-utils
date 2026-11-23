DECLARE @RC int
DECLARE @transactionId numeric(18,0)
DECLARE @profileid nvarchar(50)

SET @transactionId = 1100045
SET @profileid = '40929121'

EXECUTE @RC = [dbo].[usp_CCS_CountUserByProfileIdAndTransactionId] 
   @transactionId
  ,@profileid
GO