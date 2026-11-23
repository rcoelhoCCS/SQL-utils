USE [CCS_EbankitMPS]

select * from dbo.Errors 
WHERE 1=1
AND [Message] like '%Not Allowed by Adaptive%'
--AND ErrorCode like '7a7bf180'