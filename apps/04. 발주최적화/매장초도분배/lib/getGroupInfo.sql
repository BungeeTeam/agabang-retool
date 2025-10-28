select distinct grp_id, grp_nm from agabang.cfshgrph
where biz_div = '{{ bizcd.value }}' and use_yn = 'Y'
order by updt_dt desc
;