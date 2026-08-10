USE [CCS_EbankitMPS]
GO
SET ANSI_NULLS ON 
GO
SET QUOTED_IDENTIFIER ON
GO

BEGIN TRANSACTION
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CCS_SplashScreenViewHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CCS_SplashScreenViewHistory](
SplashScreenId NVARCHAR(100) NOT NULL,
Username nvarchar(50) not null,
IsViewed bit not null default 0,
ViewedDate datetime,
[Application] nvarchar not null,
primary key (SplashScreenId, Username, application))
END
COMMIT