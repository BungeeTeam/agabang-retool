WITH
  '{{ sel_sty.value?.sty_cd }}' as style_code,
  '{{ sel_sty.value?.col_cd }}' as color_code

-- 입고 데이터
, SHOP_IN AS (
    SELECT
        shop_cd,
        shop_nm,
        br_cd,
        sty_cd,
        col_cd,
        wrk_dt,
        SUM(SUM(out_qty)) OVER (PARTITION BY shop_cd ORDER BY wrk_dt) AS cum_in_qty
    from agabang.dsoutrtn as A
    LEFT JOIN (
        SELECT distinct shop_cd, shop_nm FROM agabang_dw.dim_shop
    ) as B ON A.shop_cd = B.shop_cd
    WHERE 
-- br_cd = '{{ brand_code.value }}'AND 
      sty_cd = style_code
      AND col_cd = color_code
      AND shop_nm LIKE concat('%', '{{ shop_search_text.value }}', '%')
    GROUP BY 1,2,3,4,5,6
    -- SELECT
    --     shop_cd,
    --     shop_nm,
    --     br_cd,
    --     sty_cd,
    --     col_cd,
    --     wrk_dt,
    --     SUM(SUM(out_qty)) OVER (PARTITION BY shop_cd ORDER BY wrk_dt) AS cum_in_qty
    -- FROM agabang_dw.daily_shop_dsoutrtn_by_size
    -- WHERE br_cd = '{{ brand_code.value }}'
    --   AND sty_cd = style_code
    --   AND col_cd = color_code
    --   AND shop_nm LIKE concat('%', '{{ shop_search_text.value }}', '%')
    -- GROUP BY 1,2,3,4,5,6
)

-- 총 입고량
, SHOP_IN_TOTAL AS (
    SELECT
        shop_cd,
        shop_nm,
        br_cd,
        sty_cd,
        col_cd,
        sum(CASE WHEN A.io_type = 'O' THEN A.out_qty ELSE A.out_qty*(-1)END) as total_in_qty
    from agabang.dsoutrtn as A
    LEFT JOIN (
        SELECT distinct shop_cd, shop_nm FROM agabang_dw.dim_shop
    ) as B ON A.shop_cd = B.shop_cd
    WHERE 
    -- br_cd = '{{ brand_code.value }}'
    --   AND 
        sty_cd = style_code
      AND col_cd = color_code
      AND shop_nm LIKE concat('%', '{{ shop_search_text.value }}', '%')
    GROUP BY 1,2,3,4,5
    -- SELECT
    --     shop_cd,
    --     shop_nm,
    --     br_cd,
    --     sty_cd,
    --     col_cd,
    --     SUM(out_qty) AS total_in_qty
    -- FROM agabang_dw.daily_shop_dsoutrtn_by_size
    -- WHERE br_cd = '{{ brand_code.value }}'
    --   AND sty_cd = style_code
    --   AND col_cd = color_code
    --   AND shop_nm LIKE concat('%', '{{ shop_search_text.value }}', '%')
    -- GROUP BY 1,2,3,4,5
)

-- 누적 매출
, SHOP_SALES AS (
    SELECT
        shop_cd,
        shop_nm,
        br_cd,
        sty_cd,
        col_cd,
        sale_dt,
        SUM(SUM(sales_qty)) OVER (PARTITION BY shop_cd ORDER BY sale_dt) AS cum_sale_qty
    FROM agabang_dw.daily_shop_sales_by_color
    WHERE 
    -- br_cd = '{{ brand_code.value }}'
    --   AND 
        sty_cd = style_code
      AND col_cd = color_code
      AND shop_nm LIKE concat('%', '{{ shop_search_text.value }}', '%')

    GROUP BY 1,2,3,4,5,6
)

-- 총 판매량
, SHOP_SALES_TOTAL AS (
    SELECT
        shop_cd,
        shop_nm,
        sty_cd,
        col_cd,
        SUM(sales_qty) AS total_sale_qty
    FROM agabang_dw.daily_shop_sales_by_color
    WHERE 
    -- br_cd = '{{ brand_code.value }}'
    --   AND 
        sty_cd = style_code
      AND col_cd = color_code
      AND shop_nm LIKE concat('%', '{{ shop_search_text.value }}', '%')
    GROUP BY 1,2,3,4
)

-- 입고 트렌드
, SHOP_IN_TREND AS (
    SELECT
        shop_cd,
        shop_nm,
        sty_cd,
        col_cd,
        arrayMap(
            (day, val) -> concat('{"day":"', toString(day), '", "val":', toString(val), '}'),
            groupArray(wrk_dt),
            groupArray(cum_in_qty)
        ) AS in_trend
    FROM SHOP_IN
    GROUP BY 1,2,3,4
)

-- 매출 트렌드
, SHOP_SALES_TREND AS (
    SELECT
        A.shop_cd,
        A.shop_nm,
        A.sty_cd,
        A.col_cd,
        arrayMap(
            (day, val) -> concat('{"day":"', toString(day), '", "val":', toString(val), '}'),
            groupArray(sale_dt),
            groupArray(A.cum_sale_qty)
        ) AS sale_trend,
        arrayMap(
            (day, val) -> concat('{"day":"', toString(day), '", "val":', toString(val), '}'),
            groupArray(sale_dt),
            -- groupArray(ROUND((A.cum_sale_qty / B.total_in_qty) * 100, 2))
            groupArray(ROUND(coalesce(if(B.total_in_qty = 0, 0, A.cum_sale_qty / B.total_in_qty),0) * 100, 2))
        ) AS sale_per_trend
    FROM SHOP_SALES A
    INNER JOIN SHOP_IN_TOTAL B ON A.shop_cd = B.shop_cd
    GROUP BY 1,2,3,4
)

-- 최종 결과
-- SELECT
--     A.shop_cd,
--     A.shop_nm,
--     A.br_cd,
--     A.sty_cd,
--     A.col_cd,
--     A.total_in_qty,
--     B.total_sale_qty,
--     -- ROUND((B.total_sale_qty / A.total_in_qty) * 100, 2) AS total_sale_per,  
--     ROUND(coalesce(if(A.total_in_qty = 0, 0, B.total_sale_qty / A.total_in_qty),0) * 100, 2) AS total_sale_per,  
--     CONCAT('[', arrayStringConcat(C.in_trend, ','), ']') AS in_trend,
--     CONCAT('[', arrayStringConcat(D.sale_trend, ','), ']') AS sale_trend,
--     CONCAT('[', arrayStringConcat(D.sale_per_trend, ','), ']') AS sale_per_trend
-- FROM SHOP_IN_TOTAL A
-- INNER JOIN SHOP_SALES_TOTAL B
--   ON A.shop_cd = B.shop_cd AND A.sty_cd = B.sty_cd AND A.col_cd = B.col_cd
-- INNER JOIN SHOP_IN_TREND C
--   ON A.shop_cd = C.shop_cd AND A.sty_cd = C.sty_cd AND A.col_cd = C.col_cd
-- INNER JOIN SHOP_SALES_TREND D
--   ON A.shop_cd = D.shop_cd AND A.sty_cd = D.sty_cd AND A.col_cd = D.col_cd
-- ORDER BY total_in_qty DESC;
SELECT
    A.shop_cd,
    A.shop_nm,
    A.br_cd,
    A.sty_cd,
    A.col_cd,
    A.total_in_qty,
    coalesce(B.total_sale_qty,0) as total_sale_qty,
    -- ROUND((B.total_sale_qty / A.total_in_qty) * 100, 2) AS total_sale_per,  
    ROUND(coalesce(if(A.total_in_qty = 0, 0,  coalesce(B.total_sale_qty,0) / A.total_in_qty),0) * 100, 2) AS total_sale_per,  
    CONCAT('[', arrayStringConcat(C.in_trend, ','), ']') AS in_trend,
    CONCAT('[', arrayStringConcat(D.sale_trend, ','), ']') AS sale_trend,
    CONCAT('[', arrayStringConcat(D.sale_per_trend, ','), ']') AS sale_per_trend
FROM SHOP_IN_TOTAL A
left JOIN SHOP_SALES_TOTAL B
  ON A.shop_cd = B.shop_cd AND A.sty_cd = B.sty_cd AND A.col_cd = B.col_cd
left JOIN SHOP_IN_TREND C
  ON A.shop_cd = C.shop_cd AND A.sty_cd = C.sty_cd AND A.col_cd = C.col_cd
left JOIN SHOP_SALES_TREND D
  ON A.shop_cd = D.shop_cd AND A.sty_cd = D.sty_cd AND A.col_cd = D.col_cd
ORDER BY total_in_qty DESC;
