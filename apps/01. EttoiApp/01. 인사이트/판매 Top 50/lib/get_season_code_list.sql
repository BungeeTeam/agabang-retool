WITH
  year(today()) - 4 AS target_year
SELECT *
FROM agabang_dw.code_season
WHERE 1=1
  AND year_nm >= toString(target_year)
  AND sesn_cd IN ('1', '3', '5', '7', '0')