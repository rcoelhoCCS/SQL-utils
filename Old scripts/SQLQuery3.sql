USE [CCS_EbankitMPS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CCS_UpdateLockByKey]    Script Date: 10/08/2021 17:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_CCS_ResetContractSplashScreenViewHistory]
	@splashScreenId NVARCHAR(100)
AS
BEGIN
			UPDATE [CCS_EbankitMPS].[dbo].[CCS_SplashScreenViewHistory] 
			SET [IsViewed] = 0, [ViewedDate] = NULL
			WHERE [SplashScreenId] = @splashScreenId
		
			IF (@@rowcount > 0)
			BEGIN
				RETURN 1;
			END
			ELSE 
				RETURN 0;
	
END
