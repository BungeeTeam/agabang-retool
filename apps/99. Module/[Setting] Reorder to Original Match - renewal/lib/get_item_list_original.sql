select
 distinct A.sty_cd, A.sty_nm
from agabang_dw.dim_style as A
where A.br_cd = '{{brand_code.value}}' 
and concat(A.sty_nm,' ',A.sty_cd) like '%{{reorder_sty_cd_select.inputValue }}%'

order by year_cd desc
  
limit 100