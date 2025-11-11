select * from item_md_category 
where cast(br_cd as int) = cast({{ localStorage.values.br_cd }} as int)
  and category_depth=1
order by id asc