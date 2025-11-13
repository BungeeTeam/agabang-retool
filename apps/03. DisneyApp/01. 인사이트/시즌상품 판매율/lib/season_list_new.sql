WITH toYear(toDate('{{date_select.value}}')) AS current_year,
code_season_prev as (
            SELECT
                row_number() OVER(order by year_nm_short desc, sesn_cd desc) AS row_num,
                A.year_sesn_cd as prev_year_sesn_cd,
                A.year_nm as prev_year_nm,
                A.year_cd as prev_year_cd,
                A.year_sesn_nm_kor as prev_year_sesn_nm_kor,
                A.year_sesn_nm_eng as prev_year_sesn_nm_eng
            FROM agabang_dw.code_season AS A
            WHERE year_nm between '2000' and cast(toYear(toDate('{{date_select.value}}')) AS String)
                and sesn_cd in ('1','3','5','7')),
            --ORDER BY year_nm_short desc, sesn_cd desc)
code_season_cur as (
            SELECT
                row_number() OVER(order by year_nm_short desc, sesn_cd desc) AS row_num,
                A.*
            FROM agabang_dw.code_season AS A
            WHERE year_nm between '2000' and cast(toYear(toDate('{{date_select.value}}')) +1 AS String)
                and sesn_cd in ('1','3','5','7'))
            --ORDER BY year_nm_short desc, sesn_cd desc)

SELECT
-- A.row_num,
-- A.year_sesn_cd,
-- B.row_num,
-- B.prev_year_sesn_cd,
A.*,
B.prev_year_nm,
B.prev_year_cd,
B.prev_year_sesn_nm_kor,
B.prev_year_sesn_nm_eng,
B.prev_year_sesn_cd
FROM code_season_cur as A
JOIN code_season_prev AS B on A.row_num = B.row_num
ORDER BY A.row_num