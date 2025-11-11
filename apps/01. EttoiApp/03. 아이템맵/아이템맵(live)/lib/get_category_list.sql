select * 
  from item_md_category 
where cast(br_cd as int) = {{ var_brand_code.value }}
  order by id asc