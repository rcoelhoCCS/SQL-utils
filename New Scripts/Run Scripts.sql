SELECT TOP (1000) [Id]
      ,[ReleaseVersion]
      ,[Version]
      ,[MinorVersion]
      ,[Description]
      ,[ExecutionDate]
      ,[UserLogin]
      ,[Hostname]
      ,[Author]
  FROM [CCS_EbankitMPS].[dbo].[DBScriptsPRJ]
  WHERE [ReleaseVersion] = '4.6.0'
  and [Version] = '1'