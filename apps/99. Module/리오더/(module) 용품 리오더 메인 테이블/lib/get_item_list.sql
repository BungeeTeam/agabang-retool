-- get_item_list
WITH base_products AS
(
  SELECT DISTINCT
    S.comp_cd,
    S.sty_cd,
    S.sty_nm,
    S.col_cd,
    S.col_nm,
    S.size_cd,
    S.size_nm,
    S.large_cat,
    S.middle_cat,
    S.small_cat,
    S.it,
    S.it_nm,
    S.it_gb,
    S.it_gb_nm,
    S.item,
    S.item_nm,
    S.tag_price,  -- 판매가
    S.cost_price, -- 원가
    S.br_cd,
    S.br_nm,
    S.season_cd,
    S.season_nm,
    S.first_sales_dt, -- 최초 판매일
    S.first_out_dt, -- 최초 출고일
    S.cust_cd,    -- 생산처코드
    S.cust_nm,    -- 생산처명
    S.fabric,     -- 소재
    'series_name_placeholder' AS series_name
  FROM dim_style S
  INNER JOIN prod_sales_stock_by_color P ON S.sty_cd = P.sty_cd AND S.col_cd = P.col_cd
  WHERE S.season_cd = '0'
    AND S.it IN (6, 8)
    AND ( -- select_item.value 조건 그룹 시작
        '{{ select_item.value }}' = 'all'
        OR          
        '{{ select_item.value }}' = ''
        OR          
        S.item IN (splitByChar(',', '{{ select_item.value }}'))
    ) -- select_item.value 조건 그룹 끝

    AND ( -- var_brand_code.value 및 select_brand.value 조건 그룹 시작
          ('{{ var_brand_code.value }}' = '01'
          AND COALESCE(S.sub_br_nm, '') != '스토케'
          AND substring(S.sty_cd, 3, 1) >= 'J'
          AND ( -- '01' 브랜드의 select_brand.value 조건 그룹 시작
            ('{{ select_brand.value }}' = 'all' AND
              S.br_cd IN ('01', '02', '58', '71', '72', '73', '74', '75', '76', '77'))
            OR
            ('{{ select_brand.value }}' = 'agabang' AND
              S.br_cd = '01')
            OR
            ('{{ select_brand.value }}' = 'etc' AND
              S.br_cd IN ('02', '58', '71', '72', '73', '74', '75', '76', '77'))
          )) -- '01' 브랜드의 select_brand.value 조건 그룹 끝
        OR
          ('{{ var_brand_code.value }}' = '07'
          AND substring(S.sty_cd, 3, 1) >= 'M'
          AND S.br_cd = '07'
          AND (S.sub_br_nm IS NULL OR S.sub_br_nm != '부가부')
          AND S.sty_nm NOT LIKE '%요요%'
          AND S.sty_nm NOT LIKE '%소피라지라프%'
          AND S.sty_nm NOT LIKE '%두나%'
          AND ( -- '07' 브랜드의 select_brand.value 조건 그룹 시작
            '{{ select_brand.value }}' = 'all'
            OR
            ('{{ select_brand.value }}' = 'liewood' AND
              S.sub_br_nm IN ('리우드', '오비디자인스', '노바디노즈')
            )
            OR
            ('{{ select_brand.value }}' = 'ettoi' AND
              (S.sub_br_nm IS NULL OR S.sub_br_nm NOT IN ('리우드', '오비디자인스', '노바디노즈'))
            )
          )) -- '07' 브랜드의 select_brand.value 조건 그룹 끝
    ) -- var_brand_code.value 및 select_brand.value 조건 그룹 끝
), -- WITH 절의 base_products 괄호 닫힘
  
shop_count_data AS (
  SELECT count(distinct shop_cd) AS active_shop_count
  FROM agabang_dw.daily_shop_sales_by_dimension S
  LEFT JOIN agabang_dw.prod_sales_stock_by_color P ON S.sty_cd = P.sty_cd
  WHERE sale_dt > date_sub(now(), interval 1 year)
    AND sale_gb = '매장판매'
    AND S.season_cd = '0'
    AND substring(S.sty_cd, 3, 1) >= 'M'
    AND S.it IN (6, 8)
    AND P.tot_in_qty > 0
        AND (
        '{{ select_item.value }}' = 'all' -- select_item.value가 'all'이라면
        OR          
        '{{ select_item.value }}' = '' -- select_item.value가 'all'이라면
        OR          
        S.item IN (splitByChar(',', '{{ select_item.value }}')) -- S.item이 값 목록 안에 있다면
    )
    AND (
      ('{{ var_brand_code.value }}' = '01'
      AND substring(S.sty_cd, 3, 1) >= 'J'
      AND (
        ('{{ select_brand.value }}' = 'all' AND 
          S.br_cd IN ('01', '02', '58', '71', '72', '73', '74', '75', '76', '77'))
        OR
        ('{{ select_brand.value }}' = 'agabang' AND 
          S.br_cd = '01')
        OR
        ('{{ select_brand.value }}' = 'etc' AND 
        COALESCE(S.sub_br_nm, '') != '스토케' AND 
        S.br_cd IN ('01', '02', '58', '71', '72', '73', '74', '75', '76', '77'))
      ))
    OR
      ('{{ var_brand_code.value }}' = '07'
      AND substring(S.sty_cd, 3, 1) >= 'M'
      AND S.br_cd = '07'
      AND (S.sub_br_nm IS NULL OR S.sub_br_nm != '부가부')
      AND S.sty_nm NOT LIKE '%요요%'
      AND S.sty_nm NOT LIKE '%소피라지라프%'
      AND S.sty_nm NOT LIKE '%두나%'
      AND (
        '{{ select_brand.value }}' = 'all'
        OR
        ('{{ select_brand.value }}' = 'liewood' AND 
          S.sub_br_nm IN ('리우드', '오비디자인스', '노바디노즈')
        )
        OR
        ('{{ select_brand.value }}' = 'ettoi' AND
          (S.sub_br_nm IS NULL OR S.sub_br_nm NOT IN ('리우드', '오비디자인스', '노바디노즈'))
        )
      ))
    )
),
  

stock_info AS
(
  SELECT
    P.sty_cd, P.col_cd, P.size_cd, P.tot_in_qty, P.tot_sale_qty,
    (P.tot_in_qty - P.tot_sale_qty) AS current_stock_qty,
    P.tag_prce, P.cost_prce, P.wh_stck_qty, P.sh_stck_qty
  FROM agabang_dw.prod_sales_stock_by_size P
  WHERE P.br_cd IN ('01', '02', '07', '58', '71', '72', '73', '74', '75', '76', '77') AND P.tot_in_qty > 0
),

inventory_dates AS
(
  SELECT
    D.sty_cd,
    D.col_cd,
    D.size_cd,
    min(D.sale_dt) AS first_inventory_date,
    max(D.sale_dt) AS last_inventory_date
  FROM agabang_dw.daily_data_by_size D
  WHERE D.br_cd IN ('01', '02', '07', '58', '71', '72', '73', '74', '75', '76', '77')
    AND D.in_qty > 0
  GROUP BY D.sty_cd, D.col_cd, D.size_cd
),

large_inventory_days AS
(
  SELECT
    sty_cd,
    col_cd,
    size_cd,
    sale_dt
  FROM agabang_dw.daily_data_by_size
  WHERE br_cd IN ('01', '02', '07', '58', '71', '72', '73', '74', '75', '76', '77')
    AND in_qty >= 50
),

reorder_counts AS
(
  SELECT
    LI.sty_cd,
    LI.col_cd,
    LI.size_cd,
    count(*) AS total_reorder_count
  FROM large_inventory_days LI
  JOIN inventory_dates ID ON
    LI.sty_cd = ID.sty_cd AND
    LI.col_cd = ID.col_cd AND
    LI.size_cd = ID.size_cd
  WHERE LI.sale_dt > ID.first_inventory_date
  GROUP BY LI.sty_cd, LI.col_cd, LI.size_cd
),

daily_data_aggregated AS (
    SELECT
        sty_cd,
        col_cd,
        size_cd,
        
        -- inventory_dates
        min(if(in_qty > 0, sale_dt, NULL)) AS first_inventory_date,
        max(if(in_qty > 0, sale_dt, NULL)) AS last_inventory_date,
        
        -- all_sales_periods & all_time_sales
        min(if(sale_qty > 0, sale_dt, NULL)) AS first_sale_date_all,
        max(if(sale_qty > 0, sale_dt, NULL)) AS last_sale_date_all,
        sum(if(sale_qty > 0, sale_qty, 0)) AS total_all_time_sale_qty,
        
        -- daily_sales (30d, 180d, 365d)
        sum(if(sale_dt >= addDays(today(), -30) AND sale_dt < today(), sale_qty, 0)) AS total_30d_sale_qty,
        sum(if(sale_dt >= addDays(today(), -180) AND sale_dt < today(), sale_qty, 0)) AS total_180d_sale_qty,
        sum(if(sale_dt >= addDays(today(), -365) AND sale_dt < today(), sale_qty, 0)) AS total_365d_sale_qty,
        
        -- monthly_sales_pivoted
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), 0)), sale_qty, 0)) AS month_1_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -1)), sale_qty, 0)) AS month_2_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -2)), sale_qty, 0)) AS month_3_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -3)), sale_qty, 0)) AS month_4_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -4)), sale_qty, 0)) AS month_5_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -5)), sale_qty, 0)) AS month_6_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -6)), sale_qty, 0)) AS month_7_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -7)), sale_qty, 0)) AS month_8_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -8)), sale_qty, 0)) AS month_9_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -9)), sale_qty, 0)) AS month_10_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -10)), sale_qty, 0)) AS month_11_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -11)), sale_qty, 0)) AS month_12_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -12)), sale_qty, 0)) AS month_13_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -13)), sale_qty, 0)) AS month_14_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -14)), sale_qty, 0)) AS month_15_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -15)), sale_qty, 0)) AS month_16_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -16)), sale_qty, 0)) AS month_17_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -17)), sale_qty, 0)) AS month_18_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -18)), sale_qty, 0)) AS month_19_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -19)), sale_qty, 0)) AS month_20_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -20)), sale_qty, 0)) AS month_21_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -21)), sale_qty, 0)) AS month_22_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -22)), sale_qty, 0)) AS month_23_sale_qty,
        sum(if(toStartOfMonth(sale_dt) = toStartOfMonth(addMonths(today(), -23)), sale_qty, 0)) AS month_24_sale_qty

    FROM agabang_dw.daily_data_by_size
    WHERE br_cd IN ('01', '02', '07', '58', '71', '72', '73', '74', '75', '76', '77')
      AND sale_dt >= addMonths(toStartOfMonth(today()), -24) -- Pivot을 위해 24개월 데이터 필요
    GROUP BY sty_cd, col_cd, size_cd
),

final_metrics AS (
    SELECT
        sty_cd, col_cd, size_cd,
        first_inventory_date, last_inventory_date,
        first_sale_date_all, last_sale_date_all,
        total_all_time_sale_qty,
        total_30d_sale_qty,
        total_180d_sale_qty,
        total_365d_sale_qty,
        
        -- 월별 판매량
        month_1_sale_qty, month_2_sale_qty, month_3_sale_qty, month_4_sale_qty, month_5_sale_qty, month_6_sale_qty,
        month_7_sale_qty, month_8_sale_qty, month_9_sale_qty, month_10_sale_qty, month_11_sale_qty, month_12_sale_qty,
        month_13_sale_qty, month_14_sale_qty, month_15_sale_qty, month_16_sale_qty, month_17_sale_qty, month_18_sale_qty,
        month_19_sale_qty, month_20_sale_qty, month_21_sale_qty, month_22_sale_qty, month_23_sale_qty, month_24_sale_qty
        
    FROM daily_data_aggregated
),

color_totals AS
(
  SELECT
    sty_cd,
    col_cd,
    sum(tot_in_qty) AS color_tot_in_qty,
    sum(tot_sale_qty) AS color_tot_sale_qty,
    sum(current_stock_qty) AS color_current_stock,
    sum(wh_stck_qty) AS color_wh_stck_qty,
    sum(sh_stck_qty) AS color_sh_stck_qty
  FROM stock_info
  GROUP BY sty_cd, col_cd
)

SELECT
  B.sty_cd AS sty_cd, B.sty_nm AS sty_nm, B.col_cd AS col_cd, B.col_nm AS col_nm, B.size_cd AS size_cd, B.size_nm AS size_nm,
  B.series_name AS series_name, B.tag_price AS tag_price, B.cost_price AS cost_price, B.large_cat AS large_cat,
  B.middle_cat AS middle_cat, B.small_cat AS small_cat, B.it AS it, B.it_nm AS it_nm, B.it_gb AS it_gb, B.it_gb_nm AS it_gb_nm,
  B.item AS item, B.item_nm AS item_nm, B.first_sales_dt AS first_sales_dt, B.first_out_dt AS first_out_dt, B.cust_cd AS cust_cd, B.cust_nm AS cust_nm,
  B.br_nm AS br_nm, B.fabric AS fabric,

  SI.tot_in_qty AS tot_in_qty, SI.tot_sale_qty AS tot_sale_qty, SI.current_stock_qty AS current_stock_qty,
  SI.wh_stck_qty AS wh_stck_qty, SI.sh_stck_qty AS sh_stck_qty,

  CT.color_tot_in_qty AS color_tot_in_qty, CT.color_tot_sale_qty AS color_tot_sale_qty, CT.color_current_stock AS color_current_stock,
  CT.color_wh_stck_qty AS color_wh_stck_qty, CT.color_sh_stck_qty AS color_sh_stck_qty,

  FM.first_inventory_date AS first_inventory_date, FM.last_inventory_date AS last_inventory_date,
  B.first_out_dt AS first_outbound_date,
  COALESCE(RC.total_reorder_count, 0) AS total_reorder_count,

  COALESCE(FM.total_all_time_sale_qty, 0) AS total_all_time_sale_qty, 
  FM.first_sale_date_all AS first_sale_date_all, 
  FM.last_sale_date_all AS last_sale_date_all,

  COALESCE(FM.total_30d_sale_qty, 0) AS sales_qty_30d,
  COALESCE(FM.total_180d_sale_qty, 0) AS sales_qty_180d,
  COALESCE(FM.total_365d_sale_qty, 0) AS sales_qty_365d,

  CASE WHEN SI.tot_in_qty > 0 THEN SI.tot_sale_qty / SI.tot_in_qty ELSE 0 END AS sale_rate,

  COALESCE(FM.month_1_sale_qty, 0) AS month_1_sale_qty, COALESCE(FM.month_2_sale_qty, 0) AS month_2_sale_qty,
  COALESCE(FM.month_3_sale_qty, 0) AS month_3_sale_qty, COALESCE(FM.month_4_sale_qty, 0) AS month_4_sale_qty,
  COALESCE(FM.month_5_sale_qty, 0) AS month_5_sale_qty, COALESCE(FM.month_6_sale_qty, 0) AS month_6_sale_qty,
  COALESCE(FM.month_7_sale_qty, 0) AS month_7_sale_qty, COALESCE(FM.month_8_sale_qty, 0) AS month_8_sale_qty,
  COALESCE(FM.month_9_sale_qty, 0) AS month_9_sale_qty, COALESCE(FM.month_10_sale_qty, 0) AS month_10_sale_qty,
  COALESCE(FM.month_11_sale_qty, 0) AS month_11_sale_qty, COALESCE(FM.month_12_sale_qty, 0) AS month_12_sale_qty,
  COALESCE(FM.month_13_sale_qty, 0) AS month_13_sale_qty, COALESCE(FM.month_14_sale_qty, 0) AS month_14_sale_qty,
  COALESCE(FM.month_15_sale_qty, 0) AS month_15_sale_qty, COALESCE(FM.month_16_sale_qty, 0) AS month_16_sale_qty,
  COALESCE(FM.month_17_sale_qty, 0) AS month_17_sale_qty, COALESCE(FM.month_18_sale_qty, 0) AS month_18_sale_qty,
  COALESCE(FM.month_19_sale_qty, 0) AS month_19_sale_qty, COALESCE(FM.month_20_sale_qty, 0) AS month_20_sale_qty,
  COALESCE(FM.month_21_sale_qty, 0) AS month_21_sale_qty, COALESCE(FM.month_22_sale_qty, 0) AS month_22_sale_qty,
  COALESCE(FM.month_23_sale_qty, 0) AS month_23_sale_qty, COALESCE(FM.month_24_sale_qty, 0) AS month_24_sale_qty,

  (SELECT active_shop_count FROM shop_count_data) AS active_shop_count

FROM base_products B
LEFT JOIN stock_info SI ON B.sty_cd = SI.sty_cd AND B.col_cd = SI.col_cd AND B.size_cd = SI.size_cd
LEFT JOIN color_totals CT ON B.sty_cd = CT.sty_cd AND B.col_cd = CT.col_cd
LEFT JOIN inventory_dates ID ON B.sty_cd = ID.sty_cd AND B.col_cd = ID.col_cd AND B.size_cd = ID.size_cd
LEFT JOIN reorder_counts RC ON B.sty_cd = RC.sty_cd AND B.col_cd = RC.col_cd AND B.size_cd = RC.size_cd
LEFT JOIN final_metrics FM ON B.sty_cd = FM.sty_cd AND B.col_cd = FM.col_cd AND B.size_cd = FM.size_cd

WHERE SI.current_stock_qty >= 0