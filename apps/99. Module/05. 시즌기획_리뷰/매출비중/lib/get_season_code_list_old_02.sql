select *
from code_season
where year_sesn_cd <= 'Q3' and year_sesn_cd >= 'K3'
and sesn_cd in ('1','3','5','7')
order by year_sesn_cd desc;