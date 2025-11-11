WITH
  toDate('{{date_select.value}}') as end_dt,
  toDate('{{ comparison_basis_select.value === 'same_weekday' ? get_same_weekday.data.same_weekday : get_same_weekday.data.same_date}}') as last_year_end_dt,
  '{{var_brand_code.value}}' as brand_code,
  '{{ season_select.selectedItem.year_cd}}' AS this_year_code,
  '{{ season_select.selectedItem.prev_year_cd}}' AS last_year_code,
  ('{{ season_select.selectedItem.sesn_cd}}','{{ Number(season_select.selectedItem.sesn_cd)+1}}') AS season_codes,

saleTbl as (
    SELECT
        B.sty_cd as sty_cd, B.sty_nm as sty_nm,
        B.col_cd as col_cd, B.col_nm as col_nm,
        B.year_cd as year_cd, B.year_nm as year_nm,
        B.season_cd as season_cd, B.season_nm as season_nm,
        coalesce(CASE WHEN CAST(B.season_cd as int) % 2 = 0 THEN '마트전용' ELSE B.large_cat END,'미분류') as large_cat, 
        B.middle_cat as middle_cat, B.small_cat as small_cat,
        B.it as it, B.it_gb as it_gb, B.item as item,
        CASE WHEN CAST(B.season_cd as int) % 2 = 0 THEN '마트전용' 
        ELSE
          CASE WHEN B.it = '5' THEN '기획' 
             WHEN B.it = '4' THEN '파자마'  ELSE '정상' END 
        END as cat_group,
        B.tag_price as tag_price,
        1 as st_count,
        -- CASE WHEN sum(A.in_qty) > 0 THEN 1 ELSE 0 END as in_st_count,
        CASE WHEN sum(CASE WHEN A.year_cd = last_year_code AND A.sale_dt > addYears(end_dt, -1) THEN 0 ELSE A.in_qty END) > 0 THEN 1 ELSE 0 END as in_st_count,
    CASE WHEN sum(CASE WHEN A.year_cd = last_year_code AND A.sale_dt > addYears(end_dt, -1) THEN 0 ELSE A.out_qty END) > 0 THEN 1 ELSE 0 END as out_st_count,
        -- [수정] 전년도 누적 집계 시, 2024-06-19까지만 포함하도록 CASE문 추가
        -- sum(CASE WHEN A.year_cd = last_year_code AND A.sale_dt > addYears(end_dt, -1) THEN 0 ELSE A.in_qty END) as tot_in_qty,
        -- sum(CASE WHEN A.year_cd = last_year_code AND A.sale_dt > addYears(end_dt, -1) THEN 0 ELSE A.in_qty*B.cost_price*1.1 END) as tot_in_cost,
        -- sum(CASE WHEN A.year_cd = last_year_code AND A.sale_dt > addYears(end_dt, -1) THEN 0 ELSE A.in_amt END) as tot_in_tag,
        -- sum(CASE WHEN A.year_cd = last_year_code AND A.sale_dt > addYears(end_dt, -1) THEN 0 ELSE A.sale_qty END) as tot_sale_qty,
        -- sum(CASE WHEN A.year_cd = last_year_code AND A.sale_dt > addYears(end_dt, -1) THEN 0 ELSE A.sale_qty*B.tag_price END) as tot_sale_tag,
        -- sum(CASE WHEN A.year_cd = last_year_code AND A.sale_dt > addYears(end_dt, -1) THEN 0 ELSE A.sale_amt END) as tot_sale_amt,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt <= end_dt THEN A.in_qty
        WHEN A.year_cd = last_year_code AND A.sale_dt <= addYears(end_dt, -1) THEN A.in_qty
        ELSE 0
        END
        ) as tot_in_qty,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt <= end_dt THEN A.in_qty*B.cost_price*1.1
        WHEN A.year_cd = last_year_code AND A.sale_dt <= addYears(end_dt, -1) THEN A.in_qty*B.cost_price*1.1
        ELSE 0
        END
        ) as tot_in_cost,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt <= end_dt THEN A.in_amt
        WHEN A.year_cd = last_year_code AND A.sale_dt <= addYears(end_dt, -1) THEN A.in_amt
        ELSE 0
        END
        ) as tot_in_tag,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt <= end_dt THEN A.sale_qty
        WHEN A.year_cd = last_year_code AND A.sale_dt <= addYears(end_dt, -1) THEN A.sale_qty
        ELSE 0
        END
        ) as tot_sale_qty,
        sum(
        CASE
          WHEN A.year_cd = this_year_code AND A.sale_dt <= end_dt THEN A.sale_qty*B.tag_price
          WHEN A.year_cd = last_year_code AND A.sale_dt <= addYears(end_dt, -1) THEN A.sale_qty*B.tag_price
          ELSE 0
        END) as tot_sale_tag,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt <= end_dt THEN A.sale_amt
        WHEN A.year_cd = last_year_code AND A.sale_dt <= addYears(end_dt, -1) THEN A.sale_amt
        ELSE 0
        END
        ) as tot_sale_amt,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN date_trunc('month', end_dt) AND end_dt THEN A.sale_qty
        WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addYears(date_trunc('month', end_dt), -1) AND addYears(end_dt, -1) THEN A.sale_qty
        ELSE 0
        END
        ) as month_sale_qty,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN date_trunc('month', end_dt) AND end_dt THEN A.sale_qty * B.tag_price
        WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addYears(date_trunc('month', end_dt), -1) AND addYears(end_dt, -1) THEN A.sale_qty * B.tag_price
        ELSE 0
        END
        ) as month_sale_tag,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN date_trunc('month', end_dt) AND end_dt THEN A.sale_amt
        WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addYears(date_trunc('month', end_dt), -1) AND addYears(end_dt, -1) THEN A.sale_amt
        ELSE 0
        END
        ) as month_sale_amt,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -13) AND addDays(end_dt, -7) THEN A.sale_qty
        WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -13) AND addDays(last_year_end_dt, -7) THEN A.sale_qty
        ELSE 0
        END
        ) as p_week_sale_qty,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -13) AND addDays(end_dt, -7) THEN A.sale_qty * B.tag_price
        WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -13) AND addDays(last_year_end_dt, -7) THEN A.sale_qty * B.tag_price
        ELSE 0
        END
        ) as p_week_sale_tag,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -13) AND addDays(end_dt, -7) THEN A.sale_amt
        WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -13) AND addDays(last_year_end_dt, -7) THEN A.sale_amt
        ELSE 0
        END
        ) as p_week_sale_amt,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -6) AND end_dt THEN A.sale_qty
        WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -6) AND last_year_end_dt THEN A.sale_qty
        ELSE 0
        END
        ) as week_sale_qty,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -6) AND end_dt THEN A.sale_qty * B.tag_price
        WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -6) AND last_year_end_dt THEN A.sale_qty * B.tag_price
        ELSE 0
        END
        ) as week_sale_tag,
        sum(
        CASE
        WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -6) AND end_dt THEN A.sale_amt
        WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -6) AND last_year_end_dt THEN A.sale_amt
        ELSE 0
        END
        ) as week_sale_amt
    FROM agabang_dw.daily_sales_by_color as A
    RIGHT JOIN (
    SELECT
    distinct br_cd, sty_cd, sty_nm, col_cd, col_nm, year_cd, year_nm, season_cd, season_nm, large_cat, middle_cat, small_cat, 
    CASE WHEN (year_cd = 'R' and it = '5' and large_cat = '시즌언더') THEN '1'
                 WHEN (year_cd = 'R' and it = '5' and large_cat = '시즌의류') THEN '2'
                ELSE it END as it,
    it_gb, item, tag_price, cost_price
    FROM agabang_dw.dim_style
    WHERE br_cd = brand_code
    AND it != '9'
    AND (year_cd = this_year_code OR year_cd = last_year_code)
    AND season_cd in season_codes
    ) as B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
    WHERE
    -- (
    --     (A.year_cd = this_year_code AND A.sale_dt BETWEEN addYears(end_dt, -1) AND end_dt)
    --     OR
    --     -- [수정] 전년도 데이터 조회 기간을 2024-06-20까지로 확장
    --     (A.year_cd = last_year_code AND A.sale_dt BETWEEN addYears(end_dt, -2) AND last_year_end_dt)
    -- )
    -- AND 
    B.br_cd = brand_code
    AND B.it != '9'
    AND (B.year_cd = this_year_code OR B.year_cd = last_year_code)
    AND B.season_cd in season_codes
    GROUP BY
        B.sty_cd, B.sty_nm,
        B.col_cd, B.col_nm,
        B.year_cd, B.year_nm,
        B.season_cd, B.season_nm,
        B.large_cat, B.middle_cat, B.small_cat,
        B.it, B.it_gb, B.item,
        B.tag_price
    ),

shop_tbl as (
  SELECT
    sty_cd, col_cd, shop_cd, sale_gb, SUM(sales_qty) AS shop_sales_qty
  FROM agabang_dw.daily_shop_sales_by_color
  WHERE
    -- (
    --     (substring(sty_cd, 3, 1) = this_year_code AND sale_dt BETWEEN addYears(end_dt, -1) AND end_dt)
    --     OR
    --     -- [수정] 전년도 데이터 조회 기간을 2024-06-20까지로 확장
    --     (substring(sty_cd, 3, 1) = last_year_code AND sale_dt BETWEEN addYears(end_dt, -2) AND last_year_end_dt)
    -- )
    -- AND 
    br_cd = brand_code
    AND substring(sty_cd, 5, 1) != '9'
    AND (substring(sty_cd, 3, 1) = this_year_code OR substring(sty_cd, 3, 1) = last_year_code)
    AND substring(sty_cd, 4, 1) in season_codes
  GROUP BY sty_cd, col_cd, shop_cd, sale_gb
),

shop_online as (
  SELECT
    sty_cd as s_sty_cd, col_cd as s_col_cd,
    SUM(case when sale_gb = '온라인판매' then shop_sales_qty else 0 end) as online_sale_qty,
    SUM(case when sale_gb = '매장판매' then shop_sales_qty else 0 end) as offline_sale_qty
  FROM shop_tbl
  GROUP BY sty_cd, col_cd
),

shop_gini as (
  SELECT
    sty_cd as s_sty_cd, col_cd as s_col_cd, ROUND(1 - 2 * SUM((rank - 0.5) * shop_sales_ratio) / COUNT(), 4) AS gini
  FROM (
    SELECT
      sty_cd, col_cd, shop_cd, shop_sales_qty,
      shop_sales_qty / SUM(shop_sales_qty) OVER (PARTITION BY sty_cd, col_cd) AS shop_sales_ratio,
      ROW_NUMBER() OVER (PARTITION BY sty_cd, col_cd ORDER BY shop_sales_qty DESC) AS rank
    FROM (
      SELECT
        sty_cd, col_cd, shop_cd, SUM(shop_sales_qty) AS shop_sales_qty
      FROM shop_tbl
      GROUP BY sty_cd, col_cd, shop_cd
    )
  )
  GROUP BY sty_cd, col_cd
)

SELECT
  A.*,
  E.plan_qty as ord_qty,
  E.plan_tag_amt as ord_tag_amt,
  -- CASE WHEN E.out_qty > 0 THEN 1 ELSE 0 END as out_st_count,
  gini as gini,
  online_sale_qty / tot_sale_qty as online_sales_ratio
FROM saleTbl as A
LEFT JOIN shop_online as C
  ON A.sty_cd = C.s_sty_cd AND A.col_cd = C.s_col_cd
LEFT JOIN shop_gini as D
  ON A.sty_cd = D.s_sty_cd AND A.col_cd = D.s_col_cd
LEFT JOIN (
SELECT
sty_cd as _sty_cd, col_cd as _col_cd, plan_qty, plan_tag_amt, out_qty
FROM agabang_dw.prod_sales_stock_by_color
) as E ON A.sty_cd = E._sty_cd and A.col_cd = E._col_cd;

-- saleTbl as (
--     SELECT
--     B.sty_cd as sty_cd, B.sty_nm as sty_nm,
--     B.col_cd as col_cd, B.col_nm as col_nm,
--     B.year_cd as year_cd, B.year_nm as year_nm,
--     B.season_cd as season_cd, B.season_nm as season_nm,
--     B.large_cat as large_cat, B.middle_cat as middle_cat, B.small_cat as small_cat,
--     B.it as it, B.it_gb as it_gb, B.item as item,
--     '총계' as total,
--     CASE WHEN B.it = '5' THEN '기획' ELSE '정상' END as cat_group,
--     CASE WHEN B.it in('2','3') THEN '시즌의류' ELSE B.large_cat END as apparel_group,
--     B.tag_price as tag_price,
--     1 as st_count,
--     CASE WHEN sum(A.in_qty) > 0 THEN 1 ELSE 0 END as in_st_count,
--     sum(A.in_qty) as tot_in_qty,
--     sum(A.in_qty*B.cost_price*1.1) as tot_in_cost,
--     sum(A.in_amt) as tot_in_tag,
--     sum(A.sale_qty) as tot_sale_qty,
--     sum(A.sale_qty*B.tag_price) as tot_sale_tag,
--     sum(A.sale_amt) as tot_sale_amt,
--     sum(
--     CASE
--     WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN date_trunc('month', end_dt) AND end_dt THEN A.sale_qty
--     WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addYears(date_trunc('month', end_dt), -1) AND addYears(end_dt, -1) THEN A.sale_qty
--     ELSE 0
--     END
--     ) as month_sale_qty,
--         sum(
--     CASE
--     WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN date_trunc('month', end_dt) AND end_dt THEN A.sale_qty * B.tag_price
--     WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addYears(date_trunc('month', end_dt), -1) AND addYears(end_dt, -1) THEN A.sale_qty * B.tag_price
--     ELSE 0
--     END
--     ) as month_sale_tag,
--         sum(
--     CASE
--     WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN date_trunc('month', end_dt) AND end_dt THEN A.sale_amt
--     WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addYears(date_trunc('month', end_dt), -1) AND addYears(end_dt, -1) THEN A.sale_amt
--     ELSE 0
--     END
--     ) as month_sale_amt,
--         sum(
--     CASE
--     WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -13) AND addDays(end_dt, -7) THEN A.sale_qty
--     WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -13) AND addDays(last_year_end_dt, -7) THEN A.sale_qty
--     ELSE 0
--     END
--     ) as p_week_sale_qty,
--         sum(
--     CASE
--     WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -13) AND addDays(end_dt, -7) THEN A.sale_qty * B.tag_price
--     WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -13) AND addDays(last_year_end_dt, -7) THEN A.sale_qty * B.tag_price
--     ELSE 0
--     END
--     ) as p_week_sale_tag,
--         sum(
--     CASE
--     WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -13) AND addDays(end_dt, -7) THEN A.sale_amt
--     WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -13) AND addDays(last_year_end_dt, -7) THEN A.sale_amt
--     ELSE 0
--     END
--     ) as p_week_sale_amt,
--         sum(
--     CASE
--     WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -6) AND end_dt THEN A.sale_qty
--     WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -6) AND last_year_end_dt THEN A.sale_qty
--     ELSE 0
--     END
--     ) as week_sale_qty,
--         sum(
--     CASE
--     WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -6) AND end_dt THEN A.sale_qty * B.tag_price
--     WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -6) AND last_year_end_dt THEN A.sale_qty * B.tag_price
--     ELSE 0
--     END
--     ) as week_sale_tag,
--         sum(
--     CASE
--     WHEN A.year_cd = this_year_code AND A.sale_dt BETWEEN addDays(end_dt, -6) AND end_dt THEN A.sale_amt
--     WHEN A.year_cd = last_year_code AND A.sale_dt BETWEEN addDays(last_year_end_dt, -6) AND last_year_end_dt THEN A.sale_amt
--     ELSE 0
--     END
--     ) as week_sale_amt
--     FROM agabang_dw.daily_sales_by_color as A
--     RIGHT JOIN (
--     SELECT
--     distinct br_cd, sty_cd, sty_nm, col_cd, col_nm, year_cd, year_nm, season_cd, season_nm, large_cat, middle_cat, small_cat, it, it_gb, item, tag_price, cost_price
--     FROM dim_style
--     WHERE br_cd = brand_code
--     AND it != '9'
--     AND (year_cd = this_year_code OR year_cd = last_year_code)
--     AND season_cd in season_codes
--     ) as B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
--     WHERE
--     (
--     -- 올해 시즌 상품('S')은 올해 기간의 매출만 집계
--     (year_cd = this_year_code AND sale_dt BETWEEN addYears(end_dt, -1) AND end_dt)
--     OR
--     -- 작년 시즌 상품('R')은 작년 동기간의 매출만 집계
--     (year_cd = last_year_code AND sale_dt BETWEEN addYears(end_dt, -2) AND addYears(end_dt, -1))
--     )
--     AND B.br_cd = brand_code
--     AND B.it != '9'
--     AND (year_cd = this_year_code OR year_cd = last_year_code)
--     AND sesn_cd in season_codes
--     GROUP BY
--     B.sty_cd, B.sty_nm,
--     B.col_cd, B.col_nm,
--     B.year_cd, B.year_nm,
--     B.season_cd, B.season_nm,
--     B.large_cat, B.middle_cat, B.small_cat,
--     B.it, B.it_gb, B.item,
--     B.tag_price
--     ),

-- shop_tbl as (
--   SELECT
--     sty_cd, col_cd, shop_cd, sale_gb, SUM(sales_qty) AS shop_sales_qty
--   FROM agabang_dw.daily_shop_sales_by_color
--   WHERE
--         (
--     -- 올해 시즌 상품('S')은 올해 기간의 매출만 집계
--     (substring(sty_cd, 3, 1) = this_year_code AND sale_dt BETWEEN addYears(end_dt, -1) AND end_dt)
--     OR
--     -- 작년 시즌 상품('R')은 작년 동기간의 매출만 집계
--     (substring(sty_cd, 3, 1) = last_year_code AND sale_dt BETWEEN addYears(end_dt, -2) AND addYears(end_dt, -1))
--     )
--     AND br_cd = brand_code
--     AND substring(sty_cd, 5, 1) != '9'
--     AND (substring(sty_cd, 3, 1) = this_year_code OR substring(sty_cd, 3, 1) = last_year_code)
--     AND substring(sty_cd, 4, 1) in season_codes
--   GROUP BY sty_cd, col_cd, shop_cd, sale_gb
-- ),

-- shop_online as (
--   SELECT
--     sty_cd as s_sty_cd, col_cd as s_col_cd,
--     SUM(case when sale_gb = '온라인판매' then shop_sales_qty else 0 end) as online_sale_qty,
--     SUM(case when sale_gb = '매장판매' then shop_sales_qty else 0 end) as offline_sale_qty
--   FROM shop_tbl
--   GROUP BY sty_cd, col_cd
-- ),

-- shop_gini as (
--   SELECT
--     sty_cd as s_sty_cd, col_cd as s_col_cd, ROUND(1 - 2 * SUM((rank - 0.5) * shop_sales_ratio) / COUNT(), 4) AS gini
--   FROM (
--     SELECT
--       sty_cd, col_cd, shop_cd, shop_sales_qty,
--       shop_sales_qty / SUM(shop_sales_qty) OVER (PARTITION BY sty_cd, col_cd) AS shop_sales_ratio,
--       ROW_NUMBER() OVER (PARTITION BY sty_cd, col_cd ORDER BY shop_sales_qty DESC) AS rank
--     FROM (
--       SELECT
--         sty_cd, col_cd, shop_cd, SUM(shop_sales_qty) AS shop_sales_qty
--       FROM shop_tbl
--       GROUP BY sty_cd, col_cd, shop_cd
--     )
--   )
--   GROUP BY sty_cd, col_cd
-- )

-- SELECT
--   A.*,
--   E.plan_qty as ord_qty,
--   E.plan_tag_amt as ord_tag_amt,
--   CASE WHEN E.out_qty > 0 THEN 1 ELSE 0 END as out_st_count,
--   gini as gini,
--   online_sale_qty / tot_sale_qty as online_sales_ratio
-- FROM saleTbl as A
-- LEFT JOIN shop_online as C
--   ON A.sty_cd = C.s_sty_cd AND A.col_cd = C.s_col_cd
-- LEFT JOIN shop_gini as D
--   ON A.sty_cd = D.s_sty_cd AND A.col_cd = D.s_col_cd
-- LEFT JOIN (
-- SELECT
-- sty_cd as _sty_cd, col_cd as _col_cd, plan_qty, plan_tag_amt, out_qty
-- FROM agabang_dw.prod_sales_stock_by_color
-- ) as E ON A.sty_cd = E._sty_cd and A.col_cd = E._col_cd;