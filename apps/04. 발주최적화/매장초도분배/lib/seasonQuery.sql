select
  distinct year_cd, season_cd, concat(year_cd, season_cd) as collection_cd
from (
  select
      substr(sty_cd, 1, 2) as br_cd,
      substr(sty_cd, 3, 1) as year_cd,
      substr(sty_cd, 4, 1) as season_cd
  from agabang.plcoszqty
  where season_cd != '0' and season_cd in ('1', '3', '5', '7') and br_cd = '{{ brcd.value }}'
)
order by year_cd desc, season_cd desc
limit 4;