select *
from ai_sku_plan
where br_cd = '07'
and year_season = '{{ select_season.value }}'
and category = '{{ var_select_category.value }}'
order by id desc