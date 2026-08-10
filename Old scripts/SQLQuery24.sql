USE CCS_EbankitSecurityCenter
GO

DECLARE @userName NVARCHAR(100) =null--'mechanicretail'
	,@profileid NVARCHAR(100) =NULL--'11175389'
	,@pan NVARCHAR(100) = null--'26191255'
	,@email NVARCHAR(200) =null--'patrick.guedes@itsector.pt'
	,@mobileNumber VARCHAR(100) = NULL
	,@contractId int=null--6409
	,@segmentId int =null
	,@retailProfile  NVARCHAR(100) =null--'40632199'



SELECT  a.aliasvalue alias,c.user_id as [Contract User ID],uc.Id as [Contract Id],
 us.description aliastatus,
 u.user_id as [User Id],
 a.alias_id as [Alias_Id],
 customer_id AS CustomerId,
 [profile].extendedPropertyValue AS [Profile Id],
 umid.extendedPropertyValue umid,
 pan.extendedPropertyValue pan,
 fullpan.extendedPropertyValue fullpan,
 retail.extendedPropertyValue retailprofile,
 umidretail.extendedPropertyValue umidretail,
 principalMember.extendedPropertyValue as  [Principal Membership],
 phoneType_Id, 
 phone, 
 email,
 contract_id,
 name contractname,
 s.description contractsegment,
 cs.description contractstatus,
 rt.description relationtype,
 rs.description relationstatus,
 rs.userRelationStatus_Id  as [Contract User Relation],
 c.creationDate as [Contract Creation Date]
 ,c.updateDate as [Contract Update Date]
 ,uc.userRelationType_Id 
 ,a.updateDate as [Alias Update Date]
 ,c.segment_Id
 ,profileType_Id
FROM CCS_ebankitsecuritycenter..tb_customer_user u WITH (nolock)
 inner join CCS_ebankitsecuritycenter..tb_user_alias  a WITH (nolock) on u.user_id = a.user_id and a.aliastype_id = 20
 inner join CCS_ebankitsecuritycenter..vw_user_alias_status us WITH (nolock) on us.useraliasstatus_id = a.useraliasstatus_id and us.shortlanguage_id = 'EN'
 left join CCS_ebankitsecuritycenter..tb_contract_user_relation uc WITH (nolock) on a.user_id = uc.user_id AND uc.userRelationType_Id = 6
 left join CCS_ebankitsecuritycenter..TB_GLOBAL_USER gb WITH (nolock) on a.user_id = gb.user_id
 left join CCS_ebankitsecuritycenter..vw_user_relation_type rt WITH (nolock) on rt.userrelationtype_id = uc.userrelationtype_id and rt.shortlanguage_id = 'EN'
 left join CCS_ebankitsecuritycenter..vw_user_relation_status rs WITH (nolock) on rs.userrelationstatus_id = uc.userrelationstatus_id and rs.shortlanguage_id = 'EN'
 left join CCS_ebankitsecuritycenter..tb_contract c WITH (nolock) on c.contractnumber = uc.contract_id
 left join CCS_ebankitsecuritycenter..vw_segment s WITH (nolock) ON  s.segment_id = c.segment_id and s.shortlanguage_id = 'EN'
 left join CCS_ebankitsecuritycenter..vw_contract_status cs WITH (nolock) on cs.contractstatus_id = c.contractstatus_id and cs.shortlanguage_id = 'EN' 
 left join CCS_ebankitsecuritycenter..tb_extended_properties_set_detail pan WITH (nolock) on pan.extendedPropertiesSet_Id = uc.extendedPropertiesSet_Id and pan.extendedProperty_Id = 100
 left join CCS_ebankitsecuritycenter..tb_extended_properties_set_detail [profile] WITH (nolock) on [profile].extendedPropertiesSet_Id = uc.extendedPropertiesSet_Id and [profile].extendedProperty_Id = 101
 left join CCS_ebankitsecuritycenter..tb_extended_properties_set_detail umid WITH (nolock) on umid.extendedPropertiesSet_Id = uc.extendedPropertiesSet_Id and umid.extendedProperty_Id = 103
 left join CCS_ebankitsecuritycenter..tb_extended_properties_set_detail fullpan WITH (nolock) on fullpan.extendedPropertiesSet_Id = uc.extendedPropertiesSet_Id and fullpan.extendedProperty_Id = 102
 left join CCS_ebankitsecuritycenter..tb_extended_properties_set_detail retail WITH (nolock) on retail.extendedPropertiesSet_Id = uc.extendedPropertiesSet_Id and retail.extendedProperty_Id = 104
  left join CCS_ebankitsecuritycenter..tb_extended_properties_set_detail umidretail WITH (nolock) on umidretail.extendedPropertiesSet_Id = uc.extendedPropertiesSet_Id and umidretail.extendedProperty_Id = 105
  left join CCS_ebankitsecuritycenter..tb_extended_properties_set_detail principalMember WITH (nolock) on principalMember.extendedPropertiesSet_Id = uc.extendedPropertiesSet_Id and principalMember.extendedProperty_Id = 106
 left outer join CCS_ebankitsecuritycenter..tb_global_user_phone up WITH (nolock) on u.user_id= up.user_id
 left outer join CCS_ebankitsecuritycenter..tb_phone p WITH (nolock) on p.[phoneValue_Id] = up.[phoneValue_Id]
 left outer join CCS_ebankitsecuritycenter..tb_global_user_email ue WITH (nolock) on u.user_id= ue.user_id
 left outer join CCS_ebankitsecuritycenter..tb_email_validation e WITH (nolock) on e.emailvalue_id = ue.emailvalue_id
 where 1 = 1
and a.useraliasstatus_id = 1--Alias active
and uc.userrelationstatus_id = 1--User contract relation active
and c.contractstatus_id = 2--contract active
AND (
	@username IS NULL
	OR (a.aliasValue = @username)
	)
AND (
	@profileid IS NULL
	OR ([profile].extendedPropertyValue = @profileid)
	)
AND (
	@pan IS NULL
	OR (substring(customer_id, charindex('|', customer_id) + 1, LEN(customer_id)) = @pan)
	)
AND (
	@email IS NULL
	OR (e.email = @email)
	)
AND (
	@mobileNumber IS NULL
	OR (p.phone = @mobileNumber)
	)
AND (
	@contractId IS NULL
	OR (c.contractNumber = @contractId)
	)
AND (
	@segmentId IS NULL
	OR (c.segment_Id = @segmentId)
	)
AND (
	@retailProfile IS NULL
	OR (retail.extendedPropertyValue = @retailProfile)
	)
ORDER BY c.creationDate desc