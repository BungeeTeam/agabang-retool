WITH 
toYear(toDate('{{date_select.value}}')) as year_1st,
toYear(toDate('{{date_select.value}}')) - 4 as year_last

SELECT
max(A.year_cd) as year_cd,
min(A.year_sesn_cd) as year_sesn_cd,
A.year_nm as year_nm
-- ,toYear(toDate('{{date_select.value}}')) as year_,
-- toYear(toDate('{{date_select.value}}')) - 4 as year__
FROM agabang_dw.code_season as A
WHERE year_nm between cast(toYear(toDate('{{date_select.value}}')) -4 AS String) and cast(toYear(toDate('{{date_select.value}}')) AS String)
GROUP BY year_nm
ORDER BY year_nm desc