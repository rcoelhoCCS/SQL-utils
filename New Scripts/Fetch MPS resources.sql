USE [CCS_EbankitMPS]

select * from ResourceLang FULL JOIN Resources on ResourceLang.ContentTypeId = Resources.ContentTypeID 
where 1=1 
--AND [Description] like '%For your security%' 
--AND module like 'Countries'
AND [name] like '%Countries%'