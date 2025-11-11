SELECT DISTINCT
    S.sty_cd as sty_cd,
    S.sty_nm as sty_nm,
    S.col_cd as col_cd,
    S.col_nm as col_nm,
    S.fabric as fabric,
    S.large_cat as large_cat,
    S.middle_cat as middle_cat,
    S.small_cat as small_cat,
    S.year_cd as year_cd,
    S.season_cd as season_cd,
    S.year_nm as year_nm,
    S.season_nm as season_nm,
    concat(S.year_cd, S.season_cd) as year_sesn_nm_eng,
    A.tot_sale_qty as tot_sale_qty,
    A.tot_in_qty as tot_in_qty,
    round(A.tot_sale_qty/A.tot_in_qty, 2) as sale_per,
    round(A.tot_sale_amt/A.tot_in_tag_amt, 2) as sale_amt_per
FROM agabang_dw.prod_sales_stock_by_color as A
JOIN agabang_dw.dim_style as S
    ON A.sty_cd = S.sty_cd
    AND A.col_cd = S.col_cd
WHERE S.br_cd = '{{ var_brand_code.value }}'
    AND A.tot_sale_qty/A.tot_in_qty >= {{ sale_per.value }}
    AND A.tot_sale_qty > 0
    -- 연도시즌 필터 (수정됨)
    {{
      select_season2.value && select_season2.value.length > 0
        ? `AND (S.year_cd, S.season_cd) IN (${
            select_season2.value.map(
              code => `('${code.substring(0, 1)}', '${code.substring(1, 2)}')`
            ).join(',')
          })`
        : ""
    }}
    -- 대분류 필터 (select_large_cat2)
    {{ (!select_large_cat2.value || select_large_cat2.value.length === 0 || select_large_cat2.value.includes("전체")) 
        ? "" 
        : "AND (" + 
          (select_large_cat2.value.includes("복종X") 
            ? "(S.large_cat IS NULL" + (select_large_cat2.value.filter(v => v !== "복종X").length > 0 
                ? " OR S.large_cat IN ('" + select_large_cat2.value.filter(v => v !== "복종X").join("','") + "')" 
                : "") + ")"
            : "S.large_cat IN ('" + select_large_cat2.value.join("','") + "')")
          + ")"
    }}
    -- 중분류 필터 (select_middle_cat2)
    {{ select_middle_cat2.value && select_middle_cat2.value.length > 0 
        ? "AND S.middle_cat IN ('" + select_middle_cat2.value.join("','") + "')" 
        : "" 
    }}
    -- 소분류 필터 (select_small_cat2)
    {{ select_small_cat2.value && select_small_cat2.value.length > 0 
        ? "AND S.small_cat IN ('" + select_small_cat2.value.join("','") + "')" 
        : "" 
    }}
ORDER BY S.sty_cd DESC, S.col_cd