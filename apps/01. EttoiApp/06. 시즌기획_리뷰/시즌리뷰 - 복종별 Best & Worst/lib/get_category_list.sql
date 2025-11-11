select * from item_md_category 
where cast(br_cd as int) = cast({{ var_brand_code.value }} as int)
order by id asc