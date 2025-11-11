select 
  distinct it_gb, it_gb_nm
from agabang_dw.dim_style
where br_cd in ('{{ brandSelect.value.join("', '") }}') 
and it in ('{{ itSelect.value.join("', '") }}') 
and it_gb_nm != ''
order by it_gb