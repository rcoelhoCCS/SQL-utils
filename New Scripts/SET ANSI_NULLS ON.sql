SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER   PROCEDURE [dbo].[usp_CCS_CountUserByProfileIdAndTransactionId]
	@transactionId NUMERIC(18,0),
	@profileid NVARCHAR(50) = NULL
AS
	SELECT 
		COUNT(*) 
	FROM 
		[dbo].[CCS_TransactionAllowList] WITH (NOLOCK) 
	WHERE
		profileId = @profileid
	  AND 
		transaction_id = @transactionId
	  AND 
		campaignId is null;
GO
