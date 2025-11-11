select 
  distinct it, it_nm
from agabang_dw.dim_style
where br_cd in ('{{ brandSelect.value.join("', '") }}') 
and it_nm != ''
order by it_nm