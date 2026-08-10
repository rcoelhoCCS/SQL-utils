USE [CCS_EbankitMPS]
UPDATE [dbo].[CCS_SplashScreenViewHistory]
SET isViewed = 0, ViewedDate = null
where username = 'minimatesv2' and SplashScreenId='LOCKCARD'
