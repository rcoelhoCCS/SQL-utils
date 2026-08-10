USE [CCS_EbankitMPS]

ALTER TABLE [dbo].[CCS_SplashScreenViewHistory]
ALTER COLUMN [Channel] INT NOT NULL

ALTER TABLE [dbo].[CCS_SplashScreenViewHistory] 
DROP CONSTRAINT pkIdentifier

ALTER TABLE [dbo].[CCS_SplashScreenViewHistory] 
ADD PRIMARY key (SplashScreenId, Username, Channel)