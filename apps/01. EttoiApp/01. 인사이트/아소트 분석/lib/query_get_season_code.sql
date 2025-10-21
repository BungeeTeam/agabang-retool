SELECT *
FROM agabang_dw.code_season
WHERE sesn_cd IN ('0', '1', '3', '5', '7')
ORDER BY year_nm DESC, sesn_cd
LIMIT 20