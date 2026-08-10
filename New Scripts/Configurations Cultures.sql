/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [CCS_EbankitConfigurations].[dbo].[ApplicationCultures]

SELECT * FROM 
  [CCS_EbankitConfigurations].[dbo].[ApplicationCultures]
  WHERE [Application] = 2 
	AND [ISOCode] like 'fr-FR'