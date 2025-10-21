SELECT *
FROM agabang_dw.code_season
WHERE 1=1
  AND year_nm <= '{{moment().add('month', 3).year()}}'
  AND sesn_cd IN ('0', '1', '3', '5', '7')
ORDER BY year_nm DESC, sesn_cd DESC