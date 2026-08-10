select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[LogRequest] 
where machinename like 'ITSDAAS-41183' 
and [level] like 'Error'
--and [Exception] like '%(0x80131904)%'
--and [Message] like '%Invalid Connection Strings - One or more Connection strings are invalid (check errors above)%'
order by EventTime desc

--Catarina: 40408
--Watashi: 41183

select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[TransactionExecution]
where 1=1
and TransactionId like '%CampaignConsentRecord%'
order by EventTime DESC

select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[TransactionExecutionHist]
where 1=1
and TransactionId like '%CampaignConsentRecord%'
--and [SoapIn] like '%http%'
order by EventTime DESC

select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[ServiceRequest]
--where [Action] like '%GetCustomer%'
order by EventTime desc

select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[JsonRequest]
where 1= 1 
-- AND [RequestPath] like '/private/account/GetExternalAccounts'
order by EventTime desc

select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[JsonRequestHist]
where 1= 1 
AND machinename like 'ITSDAAS-41183' 
-- AND [RequestPath] like '/private/account/GetExternalAccounts'
AND SoapOut like '%Campaign%'
order by EventTime desc