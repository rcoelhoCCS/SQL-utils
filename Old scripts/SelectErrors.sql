USE [CCS_EbankitMPS]

select * from dbo.Errors 
WHERE 1=1
--AND [Message] like '%Data%'
AND ErrorCode like '70c2ac23'