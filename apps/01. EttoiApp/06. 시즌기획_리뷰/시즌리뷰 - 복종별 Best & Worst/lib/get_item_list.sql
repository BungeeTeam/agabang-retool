WITH
'{{sel_start_date.value.substring(0,10)}}' as start_date,
'{{sel_end_date.value.substring(0,10)}}' as end_date,
STY_SEASON AS (
  SELECT
    A.sty_cd,
    A.sty_nm,
    case
       when A.year_season is not null then A.year_season
       when B.sesn_cd in (1, 3, 5, 7) then B.year_sesn_nm_eng
       when (B.sesn_nm_eng = 'NO' and substring(A.sty_cd, 5, 1) = '8' and
             A.item_raw_nm not in ('속싸개', '손싸보')) then 'BIRTH'
       else 'NO'
       end                      year_season_cd,
    A.year_season             as md_info_year_season,
    B.year_sesn_nm_eng        as cod_year_season,
    substring(A.sty_cd, 5, 1) as category_code,
    A.item_raw_nm
  FROM agabang_dw.retooldb_item_md_info as A
  JOIN agabang_dw.code_season as B
  ON substring(A.sty_cd, 3, 2) = concat(B.year_cd, B.sesn_cd)
  WHERE cast(A.br_cd as int) = cast({{ var_brand_code.value }} as int)
),
SALE_DATA AS (
    select
        sty_cd, col_cd, col_nm,
        sum(sale_qty) as sale_qty
    from agabang_dw.daily_data_by_color
    where sale_dt >= start_date and sale_dt <= end_date
    group by 1,2,3
)
SELECT
    A.sty_cd AS sty_cd,
    A.col_cd AS col_cd,
    concat(C.sty_nm, '-', A.col_nm) AS sty_nm,
    B.col_nm AS col_nm,
    B.tag_prce as tag_prce,
    B.tot_in_qty as tot_in_qty,
    B.fin_date as fin_date,
    A.sale_qty as sale_qty,
    B.fout_date as fout_date,
    case when B.tot_in_qty > 0 then round((A.sale_qty / B.tot_in_qty) * 100, 1) else 0 end as sale_qty_per,
    B.cost_prce as cost_prce,
    round(B.tag_prce/B.cost_prce, 1) as mark_up,
    D.memo,
    coalesce(E.cat_nm, '복종X') as cat_nm,
    coalesce(D.item_raw_nm, '아이템X') as item_nm
FROM SALE_DATA as A
JOIN agabang_dw.prod_sales_stock_by_color as B
    ON A.sty_cd = B.sty_cd
    AND A.col_cd = B.col_cd
JOIN agabang.plstycd as C
    ON A.sty_cd = C.sty_cd
JOIN agabang_dw.retooldb_code_season as G
    ON substring(A.sty_cd,3,2) = G.year_sesn_cd
JOIN STY_SEASON as H
    ON A.sty_cd = H.sty_cd
LEFT OUTER JOIN agabang_dw.retooldb_item_md_info as D
    ON A.sty_cd = D.sty_cd
LEFT OUTER JOIN agabang_dw.retooldb_item_md_category as E
    ON D.item_md_category_id = E.id
WHERE cast(D.br_cd as int) = cast({{ var_brand_code.value }} as int)
 AND ( H.year_season_cd = '{{ select_season.value }}' OR '{{ select_season.value }}' = '' )
 AND ( ( coalesce(D.item_md_category_id, 18) = {{ sel_category.value }} ) or ( H.year_season_cd = 'BIRTH' ) )
ORDER BY (A.sale_qty / B.tot_in_qty) desc;
