SELECT DISTINCT small_cat, middle_cat, large_cat
FROM agabang_dw.dim_style S
WHERE S.it NOT IN ('9')  -- 문자열로 비교하는 것이 더 안전
    AND br_cd = '{{ var_brand_code.value }}'
    AND S.year_cd = substring('{{ select_season.value }}', 1, 1)
    AND S.season_cd = substring('{{ select_season.value }}', 2, 1)