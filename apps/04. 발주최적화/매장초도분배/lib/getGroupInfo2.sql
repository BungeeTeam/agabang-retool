select distinct grp_id, grp_nm from agabang.cfshgrph
where biz_div = 'A4' and use_yn = 'Y'
order by updt_dt desc
;