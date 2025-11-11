select _tbl.*
from (
         select year_sesn_cd
              , year_cd
              , sesn_cd
              , year_nm
              , year_nm_short
              , sesn_nm_kor
              , year_sesn_nm_kor
              , year_sesn_nm_eng
         from code_season
         where 1 = 1
-- and year_sesn_cd in ('S3','S1','R7','R5','S0','R0','Q0','P0','O0','N0','M0')
           and sesn_cd in ('0')
           and year_sesn_cd >= 'M0'

         union all

         select year_sesn_cd
              , year_cd
              , sesn_cd
              , year_nm
              , year_nm_short
              , sesn_nm_kor
              , year_sesn_nm_kor
              , year_sesn_nm_eng
         from code_season
         where 1 = 1
-- and year_sesn_cd in ('S3','S1','R7','R5','S0','R0','Q0','P0','O0','N0','M0')
           and year_sesn_cd <= 'S3'
           and year_sesn_cd >= 'R5'
           and sesn_cd in ('1', '3', '5', '7')
         ) as _tbl
order by _tbl.sesn_cd = '0', _tbl.year_sesn_cd desc
;