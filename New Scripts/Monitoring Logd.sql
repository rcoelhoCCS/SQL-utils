select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[LogRequest] 
where 1 = 1 
and machinename like 'ITSDAAS-41597' 
and [level] like 'Error' -- 'Error' | 'Debug'  | 'INFORMATION' |
--and [Exception] like '%(0x80131904)%'
--and [Message] like '%Invalid Connection Strings - One or more Connection strings are invalid (check errors above)%'
--and [User] like 'karina'
order by EventTime desc

select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[LogRequestHist] 
where 1 = 1 
and machinename like 'ITSDAAS-41597' 
and [level] like 'Error'
--and [Exception] like '%(0x80131904)%'
--and [Message] like '%Consent%'
order by EventTime desc


select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[ServiceRequest]
where 1 = 1
--and [Action] like '%ServicesData%'
--AND [RequestId] like 'a415c954-465f-436e-9b7a-82a34fd19086'
--AND [SoapOut] like '%hyperlink%'
AND [User] like 'karina'
order by EventTime desc

select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[ServiceRequestHist]
where [Action] like '%Overdraft%'
order by EventTime desc

select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[JsonRequest]
where 1 = 1
--AND [RequestPath] like '%Content%'
--and RequestPath like '/Services/Ebankit/EbankitCustomService.svc'
AND RequestUrl like '%/ContentService/Content%'
--AND [User] like 'voxdei'
--AND SoapOut like '%.svg%'
order by EventTime desc

select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[JsonRequestHist]
where 1= 1 
--AND [RequestPath] like '%.svc%'
AND [RequestUrl] like '%/ContentService/Content%'
--AND [User] like 'voxpopuli'
--AND [Application] like 'INTERNETBANKING'
--AND SoapIn like '%FrontChequeImage%'
AND SoapOut like '%.svg%'
order by EventTime desc

select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[TransactionExecution]
where 1=1
and TransactionId like '%ServicesData%'
--and [User] like 'Upgrade'
--and SoapOut like '%submessage%'
order by EventTime DESC

select TOP 100 * from [CCS_EbankitMonitoring].[dbo].[TransactionExecutionHist]
where 1=1
and TransactionId like '%ConsentStatus%'
--and [User] like 'Leninade'
order by EventTime DESC
