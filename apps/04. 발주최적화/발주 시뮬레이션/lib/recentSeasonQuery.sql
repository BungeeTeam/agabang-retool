select 
  distinct 
    year_cd, 
    season_cd, 
    concat(year_cd, season_cd) as season_alias
from agabang_dw.seasonal_order_optimization
order by year_cd desc, season_cd