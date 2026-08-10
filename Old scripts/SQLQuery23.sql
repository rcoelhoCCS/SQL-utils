USE [CCS_EbankitSecurityCenter]
GO
/****** Object:  StoredProcedure [dbo].[usp_CCS_GetContractRelationByCustomerId]    Script Date: 9/13/2023 5:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_CCS_GetContractRelationByCustomerId] 
	@customerId nvarchar(36)
AS
BEGIN
	SELECT cur.Id AS RelationId, cur.user_Id as UserId FROM TB_CONTRACT_USER_RELATION cur
		JOIN TB_CUSTOMER_USER cu ON cu.user_Id = cur.user_Id
		JOIN TB_CONTRACT c ON c.contractNumber = cur.contract_Id
	WHERE cu.customer_Id = @customerId
		AND cur.userRelationType_Id = 5
		AND c.contractStatus_Id = 2
END

