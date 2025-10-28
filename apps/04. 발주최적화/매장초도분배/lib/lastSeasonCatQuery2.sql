select 
  distinct 
    it_nm as large_cat, 
    it_gb_nm as middle_cat, 
    item_nm as small_cat
from agabang_dw.dim_style 
where season_cd = '{{ seasonSelect2.value.slice(1, 2) }}' 
and year_cd = '{{ getPreviousChar(seasonSelect2.value.slice(0, 1)) }}'
