select 
  distinct 
    it,
    it_nm as large_cat,
    it_gb,
    it_gb_nm as middle_cat,
    item,
    item_nm as small_cat,
    sty_cd,
    sty_nm,
    size_cd,
    size_nm
from agabang_dw.dim_style
where substr(sty_cd, 3, 2) = '{{ seasonSelect2.value || "-" }}' and br_cd = '{{ brcd2.value }}'