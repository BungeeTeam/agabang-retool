SELECT DISTINCT
    S.sty_cd,
    S.col_cd,
    S.sty_nm,
    S.col_nm,
    S.fabric,
    S.preview_grade,
    S.preview_score,
    S.opinion,
    S.large_cat,
    S.middle_cat,
    S.small_cat,
    S.size_tp
FROM agabang_dw.dim_style AS S
WHERE S.br_cd = '{{ var_brand_code.value }}'
    AND S.season_cd = substring('{{ select_season.value }}', 2, 1)
    AND S.year_cd = substring('{{ select_season.value }}', 1, 1)
    {{ select_large_cat.value && select_large_cat.value.length > 0 ? "AND S.large_cat IN ('" + select_large_cat.value.join("','") + "')" : "" }}
    {{ select_middle_cat.value && select_middle_cat.value.length > 0 ? "AND S.middle_cat IN ('" + select_middle_cat.value.join("','") + "')" : "" }}
    {{ select_small_cat.value && select_small_cat.value.length > 0 ? "AND S.small_cat IN ('" + select_small_cat.value.join("','") + "')" : "" }}
ORDER BY S.large_cat, S.middle_cat, S.small_cat, S.sty_nm;