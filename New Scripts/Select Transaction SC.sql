USE [CCS_EbankITSecurityCenter]

select * from [dbo].[TB_GLOBAL_TYPE_LANG]
WHERE contentType_Id = (select TOP 1 TbTrx.contentType_Id from [dbo].[TB_GLOBAL_TYPE_LANG] as TLang
                            FULL JOIN [dbo].[TB_TRANSACTION] as TbTrx
                            ON TLang.[contentType_Id] = TbTrx.[contentType_Id]
                            WHERE TbTrx.transaction_Id = 2000139)

select * from [dbo].[TB_GLOBAL_TYPE_LANG] where description like '%RC158%'

select * from [dbo].[TB_GLOBAL_TYPE_LANG] as TLang
                            FULL JOIN [dbo].[TB_TRANSACTION] as TbTrx
                            ON TLang.[contentType_Id] = TbTrx.[contentType_Id]
                            WHERE TLang.description like '%RC158%'