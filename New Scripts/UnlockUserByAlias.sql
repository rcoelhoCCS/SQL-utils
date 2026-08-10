USE CCS_EbankitMembership
GO
 
UPDATE [dbo].[TB_ACCESS_CODE]
SET failure = 0, accessCodeStatus_Id = 1, resetCount = 0
WHERE useraccesscode_id IN (
		SELECT [userAccessCode_Id]
		FROM [dbo].[TB_USER_ACCESS_CODE]
		WHERE useraccesscode_Id IN (
				SELECT [userAccessCode_Id]
				FROM [dbo].[TB_USER_ACCESS]
				WHERE user_id IN (
						SELECT user_id
						FROM CCS_EbankitSecurityCenter..tb_user_alias
						WHERE aliasValue = 'STERBEN'
						)
				)
		)