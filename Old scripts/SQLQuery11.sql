select * from [CCS_EbankitMonitoring].[dbo].[TransactionExecution]
where 1=1
and TransactionId like '%External%'
order by EventTime DESC