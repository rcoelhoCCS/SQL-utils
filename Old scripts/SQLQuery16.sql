USE [CCS_EbankitSecurityCenter]
select * from TB_LIMIT_DETAIL
--WHERE [transaction_Id] = 1000019

UPDATE TB_LIMIT_DETAIL
SET [limitValue] = 10000.00
WHERE [transaction_Id] = 1000019

select * from TB_LIMIT_DETAIL