select _category.*
from item_md_category as _category
where cast(_category.br_cd as int) = {{ var_brand_code.value }}
and _category.category_depth = 1
order by _category.item_code = '999' desc
       , _category.item_code asc