select 
  distinct season_cd, season_nm 
from agabang_dw.dim_style
where season_cd in ('0', '1', '3', '5', '7')
order by season_seq
;