select *
from item_md_assort
where substring(sty_col_cd, 1,2)='{{var_brand_code.value }}'