SELECT DISTINCT small_cat, middle_cat, large_cat
FROM agabang_dw.dim_style S
WHERE S.it NOT IN ('9')
  AND br_cd = '{{ var_brand_code.value }}'
  
  {{
    select_season2.value && select_season2.value.length > 0
      ? `AND (S.year_cd, S.season_cd) IN (${
          select_season2.value.map(
            code => `(substring('${code}', 1, 1), substring('${code}', 2, 1))`
          ).join(',')
        })`
      : ""
  }}