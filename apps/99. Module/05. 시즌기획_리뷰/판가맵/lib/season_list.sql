select
    year_sesn_nm_eng,
    year_sesn_nm_kor,
    year_cd, sesn_cd,
    CAST(year_nm as int)*10 + CAST(sesn_cd as int) as orderidx
from agabang_dw.retooldb_code_season
where sesn_cd in ('0', '1', '3', '5', '7')
and toInt8(substring(year_sesn_nm_eng,1,2)) >= 20
and toInt8(substring(year_sesn_nm_eng,1,2)) < 40
order by orderidx desc;