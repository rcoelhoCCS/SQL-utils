USE [CCS_EbankitMPS]

select * from ResourceLang FULL JOIN Resources on ResourceLang.ContentTypeId = Resources.ContentTypeID 
where 1=1 
--AND [Description] like '%Want to switch%' 
--AND module like 'TRXP0541'
--AND [name] = 'LoginIncorrectDataFTL'