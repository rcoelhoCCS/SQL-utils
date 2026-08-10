SELECT
u.customer_Id, 
a.aliasvalue alias,
 us.description aliastatus,
 [profile].extendedPropertyValue profileid,
 umid.extendedPropertyValue umid,
 pan.extendedPropertyValue pan,
 fullpan.extendedPropertyValue fullpan,
 retail.extendedPropertyValue retailprofile,
 umidretail.extendedPropertyValue umidretail,
 membership.extendedPropertyValue membership,
 phoneType_Id, 
 phone, 
 email,
 contract_id,
 name contractname,
 s.description contractsegment,
 cs.description contractstatus,
 rt.description relationtype,
 rs.description relationstatus,
 uc.lastAccessDate
FROM ccs_ebankitsecuritycenter..tb_customer_user u
 inner join ccs_ebankitsecuritycenter..tb_user_alias a on u.user_id = a.user_id and a.aliastype_id = 20
 inner join ccs_ebankitsecuritycenter..vw_user_alias_status us on us.useraliasstatus_id = a.useraliasstatus_id and us.shortlanguage_id = 'EN'
 left join ccs_ebankitsecuritycenter..tb_contract_user_relation uc on a.user_id = uc.user_id
 left join ccs_ebankitsecuritycenter..TB_GLOBAL_USER gb on a.user_id = gb.user_id
 left join ccs_ebankitsecuritycenter..vw_user_relation_type rt on rt.userrelationtype_id = uc.userrelationtype_id and rt.shortlanguage_id = 'EN'
 left join ccs_ebankitsecuritycenter..vw_user_relation_status rs on rs.userrelationstatus_id = uc.userrelationstatus_id and rs.shortlanguage_id = 'EN'
 left join ccs_ebankitsecuritycenter..tb_contract c on c.contractnumber = uc.contract_id
 left join ccs_ebankitsecuritycenter..vw_segment s on s.segment_id = c.segment_id and s.shortlanguage_id = 'EN'
 left join ccs_ebankitsecuritycenter..vw_contract_status cs on cs.contractstatus_id = c.contractstatus_id and cs.shortlanguage_id = 'EN'
 left join ccs_ebankitsecuritycenter..tb_extended_properties_set_detail pan on pan.extendedPropertiesSet_Id = gb.extendedPropertiesSet_Id and pan.extendedProperty_Id = 100
 left join ccs_ebankitsecuritycenter..tb_extended_properties_set_detail [profile] on [profile].extendedPropertiesSet_Id = gb.extendedPropertiesSet_Id and [profile].extendedProperty_Id = 101
 left join ccs_ebankitsecuritycenter..tb_extended_properties_set_detail umid on umid.extendedPropertiesSet_Id = gb.extendedPropertiesSet_Id and umid.extendedProperty_Id = 103
 left join ccs_ebankitsecuritycenter..tb_extended_properties_set_detail fullpan on fullpan.extendedPropertiesSet_Id = gb.extendedPropertiesSet_Id and fullpan.extendedProperty_Id = 102
 left join ccs_ebankitsecuritycenter..tb_extended_properties_set_detail retail on retail.extendedPropertiesSet_Id = gb.extendedPropertiesSet_Id and retail.extendedProperty_Id = 104
 left join ccs_ebankitsecuritycenter..tb_extended_properties_set_detail umidretail on umidretail.extendedPropertiesSet_Id = gb.extendedPropertiesSet_Id and umidretail.extendedProperty_Id = 105
 left join ccs_ebankitsecuritycenter..tb_extended_properties_set_detail membership on membership.extendedPropertiesSet_Id = gb.extendedPropertiesSet_Id and membership.extendedProperty_Id = 106
 
 left outer join ccs_ebankitsecuritycenter..tb_global_user_phone up on u.user_id= up.user_id
 left outer join ccs_ebankitsecuritycenter..tb_phone p on p.[phoneValue_Id] = up.[phoneValue_Id]
 left outer join ccs_ebankitsecuritycenter..tb_global_user_email ue on u.user_id= ue.user_id
 left outer join ccs_ebankitsecuritycenter..tb_email_validation e on e.emailvalue_id = ue.emailvalue_id
 where 1 = 1
--and a.aliasvalue like '%alastor%'
--and pan.extendedPropertyValue = '27395251'
--and profile.extendedPropertyValue = '40840863'
--and retail.extendedPropertyValue = '611798'
--and contract_id = 6253
and c.contractStatus_Id = 2
and a.userAliasStatus_Id = 1
ORDER BY u.creationDate DESC