WITH
  '{{dateRange.value?.start}}' AS start_date,
  '{{dateRange.value?.end}}' AS end_date,
  '{{ var_brand_code.value }}' AS brand_code,
sale_raw AS (
    SELECT 
      A.shop_cd,
      A.shop_nm,
      B.channel_gb,
      A.sty_cd           AS sty_cd,
      A.col_cd           AS col_cd,
      max(A.sty_nm)      AS sty_nm,
      max(A.col_nm)      AS col_nm,
      sum(A.sales_qty)   as sale_qty,
      sum(A.sales_price) as sale_price
    FROM agabang_dw.daily_shop_sales_by_color AS A
    inner join (
        SELECT
            distinct shop_cd, shop_nm,
                    CASE
                        WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm not like '%팝업%' THEN 'disney_only'
                        WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm like '%팝업%' THEN 'disney_popup'
                        WHEN is_flex = True THEN 'flex'
                        ELSE tp_cd
                    END as channel_cd,
                    CASE
                        WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm not like '%팝업%' THEN '디즈니단독'
                        WHEN br_cd = '79' AND shop_nm like '%디즈니%' AND shop_nm like '%팝업%' THEN '디즈니팝업'
                        WHEN is_flex = True THEN '플렉스'
                        ELSE tp_nm
                    END as channel_gb
        FROM agabang_dw.dim_shop
    WHERE br_cd = '79') as B
        on B.shop_cd = A.shop_cd
    WHERE 1 = 1
    AND sale_dt BETWEEN start_date AND end_date
    --         AND concat(A.year_cd, A.sesn_cd) IN ('S1')
    AND substring(A.sty_cd, 3, 2) IN ({{var_target_season_code?.value}})
    AND A.br_cd = brand_code
    AND case when {{ select_main_type.value === 'shop' }} then A.shop_cd = '{{ select_sub_type.value }}'
             when {{ select_main_type.value === 'channel' }} then B.channel_cd = '{{ select_sub_type.value }}'
             else true end 
    GROUP BY A.shop_cd, A.shop_nm, B.channel_gb, A.sty_cd, A.col_cd
),
sale_item AS (
    SELECT
        A.*,
        B.item_md_category_id,
        B.cat_raw_nm AS cat_raw_nm,
        B.cat_nm AS cat_nm
    FROM sale_raw AS A
    JOIN agabang_dw.retooldb_item_md_info AS B
      ON A.sty_cd = B.sty_cd
      AND B.br_cd = brand_code
),
dsrealsum AS (
    SELECT
        A.shop_cd AS shop_cd,
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        parseDateTimeBestEffort(coalesce(max(A.fin_date),'19700101')) AS fin_date,
        parseDateTimeBestEffort(coalesce(max(A.fsale_date),'19700101')) AS fsale_date,
        coalesce(sum(A.in_qty), 0) + coalesce(sum(A.rt_in_qty), 0) - coalesce(sum(A.rt_rtn_qty), 0) as net_in_qty,
        coalesce(sum(A.in_qty), 0) AS tot_in_qty,
        coalesce(sum(A.rt_in_qty), 0) AS tot_rt_in_qty,
        coalesce(sum(A.sales_qty), 0) AS tot_sales_qty,
        coalesce(sum(A.cust_rqty), 0) AS tot_cust_rqty,
        coalesce(sum(A.wh_rtn_qty), 0) AS tot_wh_rtn_qty,
        coalesce(sum(A.rt_rtn_qty), 0) AS tot_rt_rtn_qty,
        coalesce(sum(A.adjt_qty), 0) AS tot_adjt_qty,
        coalesce(sum(A.stock_qty), 0) AS tot_stock_qty
    FROM agabang.shstksum as A
    WHERE 1=1
        AND A.comp_cd = 'AG001'
        AND substring(A.sty_cd,1,2) = brand_code
    GROUP BY A.shop_cd,A.sty_cd, A.col_cd
),

slstysum AS (
    SELECT
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        sum(A.sale_qty) AS tot_sale_qty,
        sum(A.sale_amt) AS tot_sale_amt
    FROM agabang.slstysum AS A
    WHERE 1=1
        AND A.comp_cd = 'AG001'
        AND substring(A.sty_cd, 1, 2) = lpad(cast({{ var_brand_code.value }} as text), 2, '0')
    GROUP BY A.sty_cd, A.col_cd
),

final AS (
    SELECT
        A.channel_gb,
        A.item_md_category_id,
        A.cat_raw_nm AS cat_raw_nm,
        A.cat_nm AS cat_nm,

        A.sty_cd AS sty_cd,
        A.sty_nm AS sty_nm,
        A.col_cd AS col_cd,
        A.col_nm AS col_nm,
        sum(A.sale_qty) AS int_sale_qty,
        -- sum(A.sale_qty) / nullif(sum(B.tot_in_qty), 1) AS int_sale_rate,
        CASE WHEN coalesce(sum(B.net_in_qty), 0) = 0 THEN 0 
            ELSE sum(A.sale_qty) / sum(B.net_in_qty) END AS int_sale_rate, -- 누적판매율
        --B.tot_in_qty AS tot_in_qty,
        sum(D.tot_sale_qty) AS tot_sale_qty,
        sum(D.tot_sale_amt) AS tot_sale_amt,
        toDate(min(B.fin_date)) AS fin_date,
        toDate(min(B.fsale_date)) AS fsale_date,
        SUM(B.tot_in_qty) AS tot_in_qty,
        SUM(B.tot_rt_in_qty) AS tot_rt_in_qty,
        SUM(B.tot_sales_qty) AS tot_sales_qty,
        SUM(B.tot_cust_rqty) AS tot_cust_rqty,
        SUM(B.tot_wh_rtn_qty) AS tot_wh_rtn_qty,
        SUM(B.tot_rt_rtn_qty) AS tot_rt_rtn_qty,
        SUM(B.tot_adjt_qty) AS tot_adjt_qty,
        SUM(B.tot_stock_qty) AS tot_stock_qty

    FROM sale_item AS A
      LEFT JOIN dsrealsum AS B
        ON A.shop_cd = B. shop_cd and A.sty_cd = B.sty_cd AND A.col_cd = B.col_cd
      LEFT JOIN slstysum AS D
        ON A.sty_cd = D.sty_cd AND A.col_cd = D.col_cd
    WHERE A.item_md_category_id = {{ sel_category.value }}
    GROUP BY A.channel_gb, A.item_md_category_id, A.cat_raw_nm, A.cat_nm, A.sty_cd, A.sty_nm, A.col_cd, A.col_nm
),
best AS (
  SELECT *
  FROM (
      SELECT
          row_number() OVER (PARTITION BY item_md_category_id ORDER BY int_sale_qty DESC) AS sale_rank,
          *
      FROM final AS A
      WHERE 1=1
          AND A.int_sale_qty > 0
  )
  WHERE 1=1
      AND sale_rank <= {{ select_best_list_count.value }}
),
worst AS (
  SELECT *
  FROM (
      SELECT
          row_number() OVER (PARTITION BY item_md_category_id ORDER BY int_sale_qty ASC) AS sale_rank,
          *
      FROM final AS A
      WHERE 1=1
      AND (tot_sale_qty / nullif(tot_in_qty, 0)) < {{ select_exclude_rate.value }} -- tot_sale_qty(누적 판매율), tot_in_qty(입고량)
        AND date_diff('day', fin_date, today(), 'Asia/Seoul') >= {{ select_exclude_day.value }}  -- fout_date(출고일)
          -- AND tot_sale_qty / nullif(tot_in_qty, 0) < 0.5 -- tot_sale_qty(누적 판매율), tot_in_qty(입고량)
          -- AND date_diff('day', fout_date, today(), 'Asia/Seoul') >= 20  -- fout_date(출고일)
  )
  WHERE 1=1
      AND sale_rank <= {{ select_worst_list_count.value }}
  EXCEPT
  SELECT * FROM best
)
SELECT
  'BEST' AS sort,
  *
FROM best
UNION ALL
SELECT
  'WORST' AS sort,
  *
FROM worst