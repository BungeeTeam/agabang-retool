select _season.year_cd
    , _season.year_nm
from code_season as _season
where _season.year_cd = '{{ p_code }}'
group by _season.year_cd, _season.year_nm
order by _season.year_cd desc, _season.year_nm desc
limit 1
;