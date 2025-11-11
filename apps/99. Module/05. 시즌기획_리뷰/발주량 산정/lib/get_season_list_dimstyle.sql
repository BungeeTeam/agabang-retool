SELECT DISTINCT
    year_cd,
    year_nm,
    season_cd,
    season_nm
FROM agabang_dw.dim_style
WHERE season_cd IN ('0', '1', '2', '3', '4', '5', '6', '7', '8')
  AND year_cd >= 'P'
  AND br_cd = '{{ var_brand_code.value }}'
ORDER BY year_cd DESC, season_cd DESC