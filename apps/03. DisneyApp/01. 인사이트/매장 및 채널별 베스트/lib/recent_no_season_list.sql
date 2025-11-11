SELECT *
FROM agabang_dw.code_season
WHERE 1=1
  AND sesn_cd = '0'
  AND year_nm <= '{{moment().year()}}'
ORDER BY year_nm DESC
LIMIT 5