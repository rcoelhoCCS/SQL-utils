
USE [CCS_EbankitMPS]

select * from ResourceLang where ContentTypeID = (select TOP 1 ContentTypeID from Resources where module='TRXC0141' and [name]='Notification')

select * from ResourceLang where ContentTypeID = (select TOP 1 ContentTypeID from Resources where module='Breadcrumbs' and [name] like '%ProgressBar%')

select * from Resources where module='TRXC1802' and [name] like '%MaturingOn%'

select * from ResourceLang FULL JOIN Resources on ResourceLang.ContentTypeId = Resources.ContentTypeID where [Description] like '%Sorry, the information you provided doesn''t match our records. If you''re having trouble please try resetting your password.%'

select * from ResourceLang FULL JOIN Resources on ResourceLang.ContentTypeId = Resources.ContentTypeID where [Description] like '%Mobile number%'

select * from ResourceLang FULL JOIN Resources on ResourceLang.ContentTypeId = Resources.ContentTypeID where [Description] like 'Invalid data!'

select * from ResourceLang FULL JOIN Resources on ResourceLang.ContentTypeId = Resources.ContentTypeID where ApplicationId = 13 

select * from ResourceLang FULL JOIN Resources on ResourceLang.ContentTypeId = Resources.ContentTypeID where module like 'TransactionsSuccessMessages'

select * from ResourceLang FULL JOIN Resources on ResourceLang.ContentTypeId = Resources.ContentTypeID where [name] like '%UserAlreadyExistsError%' and module like 'JS'

select * from ResourceLang FULL JOIN Resources on ResourceLang.ContentTypeId = Resources.ContentTypeID where [name] like '%checkoutExplanationMessage%'

select * from ResourceLang FULL JOIN Resources on ResourceLang.ContentTypeId = Resources.ContentTypeID where [Description] like '%Postal/zip code%' and module like 'TRXC0122'

select * from Resources where ContentTypeID = '5102274'

select * from Resources where module = 'VALIDATION'

select * from Errors where TranslatedMessage like '%Could not%'

--delete from Resources where module='VALIDATION' and [ContentTypeId] = '5102386'

select * from Resources where module='TRXC1802796' and [name] like '%ConfirmationTitle%'

