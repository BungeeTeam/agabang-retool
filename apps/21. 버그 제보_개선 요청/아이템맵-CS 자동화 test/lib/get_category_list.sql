select * 
  from item_md_category 
 -- where cast(br_cd as int) = {{ var_brand_code.value }}
where br_cd = '01'
  order by id asc