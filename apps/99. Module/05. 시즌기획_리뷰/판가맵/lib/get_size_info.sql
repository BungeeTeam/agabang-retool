select
  size_tp, size_cd, size_nm
from agabang.plsizegrd
where br_cd = '{{brand_code.value }}'
order by size_tp, ord_seq