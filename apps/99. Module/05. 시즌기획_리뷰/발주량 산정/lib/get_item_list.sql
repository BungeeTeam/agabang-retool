WITH 
  '{{var_brand_code.value }}' as brand_code,
'2000-01-01' as start_date,
'{{  new Date().toISOString().split('T')[0] }}' as end_date,
STY_SEASON AS (
  SELECT 
    A.sty_cd,
    A.sty_nm,
    case
       when A.year_season is not null then A.year_season
       when B.sesn_cd in (1, 3, 5, 7) then B.year_sesn_nm_eng
       when (B.sesn_nm_eng = 'NO' and substring(A.sty_cd, 5, 1) = '8' and
             A.item_raw_nm not in ('손싸개', '속싸보', '턱받이')) then 'BIRTH'
       else 'NO'
       end                      year_season_cd,
    A.year_season             as md_info_year_season,
    B.year_sesn_nm_eng        as cod_year_season,
    substring(A.sty_cd, 5, 1) as category_code,
    A.item_raw_nm
  FROM agabang_dw.retooldb_item_md_info as A
  JOIN agabang_dw.code_season as B
    ON substring(A.sty_cd, 3, 2) = concat(B.year_cd, B.sesn_cd)
  WHERE A.br_cd = brand_code
),
FIRST_DATE AS (
    SELECT
        A.sty_cd as sty_cd,
        A.col_cd as col_cd,
        min(A.sale_dt) as first_sale_dt,
        round(min(A.cum_sale_qty / B.tot_in_qty),2) as sale_per
    FROM (
        SELECT
            sty_cd,
            col_cd,
            sale_dt,
            SUM(SUM(sale_qty)) OVER (PARTITION BY sty_cd, col_cd ORDER BY sale_dt ASC) AS cum_sale_qty
        FROM agabang_dw.daily_sales_by_color
        WHERE CONCAT(sty_cd, col_cd) in ( {{ var_selected_related_items.value.map(item => `'${item.code}'`).join(',') }} )
          AND br_cd = brand_code
        GROUP BY 1, 2, 3
    ) as A
    JOIN prod_sales_stock_by_color as B
      on A.sty_cd = B.sty_cd
        and A.col_cd = B.col_cd
    WHERE ( A.cum_sale_qty / B.tot_in_qty ) > {{ sale_per.value }}
      AND B.br_cd = brand_code
      AND B.tot_sale_qty > 0
    GROUP BY 1, 2
),
SIZE_DATA_EACH AS (
    SELECT
        A.sty_cd as sty_cd,
        A.col_cd as col_cd,
        A.size_cd as size_cd,
        sum(A.sale_qty) as sale_qty,
        sum(A.sale_amt) as sale_amt,
        max(B.sale_per) as total_sale_per,
        min(A.sale_dt) as first_sale_dt,
        max(A.sale_dt) as over_first_dt
    FROM agabang_dw.daily_sales_by_size as A
    JOIN FIRST_DATE as B
      on A.sty_cd = B.sty_cd
        and A.col_cd = B.col_cd
    WHERE A.sale_dt <= B.first_sale_dt
      AND A.br_cd = brand_code
    GROUP BY 1, 2, 3
),
SIZE_IN_SHOP AS (
    select A.sty_cd,
           A.col_cd,
           A.size_cd,
           count(distinct A.shop_cd) as in_shop_cnt
    from agabang_dw.daily_shop_dsoutrtn_by_size as A
    JOIN FIRST_DATE as B
      on A.sty_cd = B.sty_cd
        and A.col_cd = B.col_cd
    WHERE A.wrk_dt <= B.first_sale_dt
      and A.out_qty > 0
      and A.br_cd = brand_code
    -- where A.out_qty > 0 
    group by 1,2,3
),
SIZE_SALE_SHOP AS (
    select
        A.sty_cd,
        A.col_cd,
        A.size_cd,
        count(distinct A.shop_cd) as sale_shop_cnt
    from (
             select sty_cd,
                    col_cd,
                    size_cd,
                    shop_cd,
                    sale_dt,
                    sum(sales_qty) as total_sale_qty
             from agabang_dw.daily_shop_sales_by_size
             where br_cd = brand_code
             group by 1, 2, 3, 4,5
    ) as A
    JOIN FIRST_DATE as B
      on A.sty_cd = B.sty_cd
        and A.col_cd = B.col_cd
    WHERE A.sale_dt <= B.first_sale_dt
      and A.total_sale_qty > 0
      
    -- where A.total_sale_qty > 0
    group by 1, 2, 3
),
SIZE_DATA AS (
    SELECT
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        A.col_nm AS col_nm,
        '[' || arrayStringConcat(
            arrayMap(
                x -> concat(
                    '{"size_cd":"', x.1,
                    '","size_nm":"', x.2,
                    '","tot_in_qty":', x.3,
                    ',"tot_sale_qty":', x.4,
                    ',"in_shop_cnt":', x.5,
                    ',"sale_shop_cnt":', x.6,
                    '}'
                ),
                groupArray((
                    A.size_cd,
                    A.size_nm,
                    toString(A.tot_in_qty),
                    toString(coalesce(B.sale_qty,0)),
                    C.in_shop_cnt,
                    D.sale_shop_cnt
                ))
            ),
            ','
        ) || ']' AS size_data,
        sum(coalesce(B.sale_qty,0)) as tot_sale_qty,
        sum(coalesce(B.sale_amt,0)) as tot_sale_amt,
        min(B.first_sale_dt) as first_sale_dt,
        min(B.over_first_dt) as over_first_dt
    FROM agabang_dw.prod_sales_stock_by_size AS A
    LEFT OUTER JOIN SIZE_DATA_EACH as B
      ON A.sty_cd = B.sty_cd
        AND A.col_cd = B.col_cd
        AND A.size_cd = B.size_cd
    JOIN SIZE_IN_SHOP as C
      ON A.sty_cd = C.sty_cd
        AND A.col_cd = C.col_cd
        AND A.size_cd = C.size_cd
    LEFT OUTER JOIN SIZE_SALE_SHOP as D
      ON A.sty_cd = D.sty_cd
        AND A.col_cd = D.col_cd
        AND A.size_cd = D.size_cd
    WHERE A.br_cd = brand_code
    GROUP BY 1, 2, 3
),

SALE_GB_DATA as (
    select
        sty_cd,
        col_cd,
        sum(case when sale_gb = '온라인판매' then sales_qty else 0 end) as online_sale_qty,
        sum(case when sale_gb = '매장판매' then sales_qty else 0 end) as offline_sale_qty,
        sum(sales_qty) as total_sale_qty
    from agabang_dw.daily_shop_sales_by_color as A
    join FIRST_DATE as B
      on A.sty_cd = B.sty_cd
        and A.col_cd = B.col_cd
        and concat(A.sty_cd, A.col_cd) IN ( {{ var_selected_related_items.value.map(item => `'${item.code}'`).join(',') }} )
    WHERE A.sale_dt <= B.first_sale_dt
      AND A.br_cd = brand_code
    group by 1,2
),
SHOP_GINI AS (
    SELECT
        sty_cd,
        col_cd,
        ROUND(
            1 - 2 * SUM( (rank - 0.5) * shop_sales_ratio ) / COUNT(), 4
        ) AS gini
    FROM (
        SELECT
            sty_cd,
            col_cd,
            shop_cd,
            shop_sales_qty,
            shop_sales_qty / SUM(shop_sales_qty) OVER (PARTITION BY sty_cd, col_cd) AS shop_sales_ratio,
            ROW_NUMBER() OVER (PARTITION BY sty_cd, col_cd ORDER BY shop_sales_qty DESC) AS rank
        FROM (
            SELECT
                sty_cd,
                col_cd,
                shop_cd,
                SUM(sales_qty) AS shop_sales_qty
            FROM agabang_dw.daily_shop_sales_by_color AS A
            join FIRST_DATE as B
              on A.sty_cd = B.sty_cd
                and A.col_cd = B.col_cd
                and concat(A.sty_cd, A.col_cd) IN ( {{ var_selected_related_items.value.map(item => `'${item.code}'`).join(',') }} )
            WHERE A.sale_dt <= B.first_sale_dt
              AND A.sales_qty > 0
              AND A.br_cd = brand_code
            GROUP BY sty_cd, col_cd, shop_cd
        ) AS T1
    ) AS T2
    GROUP BY sty_cd, col_cd
)
SELECT
    A.sty_cd AS sty_cd,
    A.col_cd AS col_cd,
    C.sty_nm AS sty_nm,
    B.col_nm AS col_nm,
    D.deli_dt AS deli_dt,
    B.fin_date as fin_date,
    B.tag_prce as tag_prce,
    B.f_sale_prce as f_sale_prce,
    B.cost_prce as cost_prce,
    round(B.tag_prce / (B.cost_prce*1.1), 1) as mark_up,
    B.plan_qty as plan_qty,
    B.fout_date as fout_date,
    B.tot_in_qty as tot_in_qty,
    A.tot_sale_qty as tot_sale_qty,
    case when B.tot_in_qty > 0 then round((A.tot_sale_qty / B.tot_in_qty) * 100, 1) else 0 end as tot_sale_qty_per,
    B.tot_in_tag_amt as tot_in_tag_amt,
    A.tot_sale_amt as tot_sale_amt,
    case when B.tot_in_tag_amt > 0 then round((A.tot_sale_amt / B.tot_in_tag_amt) * 100, 1) else 0 end as tot_sale_amt_per,
    D.designer_nm as designer_nm,
    D.preview_grade as preview_grade,
    case when D.preview_score > 0 then round(D.preview_score, 1) else NULL end as preview_score,
    case when B.tot_in_qty > 0 then round((B.tot_sale_amt / (B.cost_prce * B.tot_in_qty)) * 100, 0) else NULL end as return_per,
    D.prod_comp as prod_comp,
    D.prod_country as prod_country,
    D.fabric as fabric,
    A.size_data,
    F.sale_1 as sale_week_1,
    F.sale_2 as sale_week_2,
    D.memo as memo,
    coalesce(E.cat_nm, '복종X') as cat_nm,
    case 
      when {{select_category_reference.value}} = 19 then '전체'
      else coalesce(D.item_raw_nm, '아이템X') 
    end as item_nm,
    G.year_sesn_cd as year_sesn_cd,
    G.year_sesn_nm_kor as year_sesn_nm_kor,
    D.memo,
    I.int_sale_qty as week_sale_qty,
    ROUND((GB.online_sale_qty/GB.total_sale_qty),2) as online_sale_per,
    SG.gini as gini,
    A.over_first_dt as over_first_dt,
    A.first_sale_dt as first_sale_dt
FROM SIZE_DATA as A
JOIN agabang_dw.prod_sales_stock_by_color as B
    ON A.sty_cd = B.sty_cd
    AND A.col_cd = B.col_cd
JOIN agabang.plstycd as C
    ON A.sty_cd = C.sty_cd
JOIN agabang_dw.weekly_sales as F
    ON A.sty_cd = F.sty_cd
    AND A.col_cd = F.col_cd
JOIN agabang_dw.retooldb_code_season as G
    ON substring(A.sty_cd,3,2) = G.year_sesn_cd
JOIN STY_SEASON as H
    ON A.sty_cd = H.sty_cd
JOIN agabang_dw.prod_sales_stock_by_color as I
    ON A.sty_cd = I.sty_cd
    AND A.col_cd = I.col_cd
LEFT OUTER JOIN agabang_dw.retooldb_item_md_info as D
    ON A.sty_cd = D.sty_cd
LEFT OUTER JOIN agabang_dw.retooldb_item_md_category as E
    ON D.item_md_category_id = E.id
LEFT JOIN SALE_GB_DATA as GB
    ON A.sty_cd = GB.sty_cd
    AND A.col_cd = GB.col_cd
LEFT JOIN SHOP_GINI as SG
    ON A.sty_cd = SG.sty_cd
    AND A.col_cd = SG.col_cd
WHERE 
  concat(A.sty_cd, A.col_cd) in ( {{ var_selected_related_items.value?.map(item => `'${item.code}'`).join(',') }} )
  AND D.br_cd = brand_code
;
