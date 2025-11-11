select
  year_nm_short || sesn_nm_eng as year_season,
  year_sesn_nm_kor
from code_season
where sesn_cd in ('0', '1', '3', '5', '7')
order by year_sesn_cd desc