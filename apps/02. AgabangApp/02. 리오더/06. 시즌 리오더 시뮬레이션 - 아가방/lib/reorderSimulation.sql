-- 리오더 시뮬레이션 쿼리
WITH base_data AS (
  -- 기본 판매 데이터
  SELECT DISTINCT
    D.sale_dt,
    concat(D.sty_cd, '_', D.col_cd) AS groupId,
    D.sty_cd,
    D.col_cd,
    P.sty_nm,
    P.col_nm,
    P.item as item_nm,
    P.year_cd,
    P.sesn_cd,
    D.sale_qty,
    P.tot_in_qty,
    P.fout_date,
    sum(D.sale_qty) OVER (
      PARTITION BY D.sty_cd, D.col_cd
      ORDER BY D.sale_dt
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS sale_cumsum,
    round(sum(D.sale_qty) OVER (
      PARTITION BY D.sty_cd, D.col_cd
      ORDER BY D.sale_dt
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) / P.tot_in_qty * 100, 2) AS sale_rate,
    dateDiff('day', P.fout_date, D.sale_dt) AS days_since_outbound,
    -- 재고 정보
    P.tot_stck_qty as current_total_stock,
    P.wh_stck_qty as warehouse_stock,
    P.sh_stck_qty as shop_stock
  FROM agabang_dw.daily_data_by_color AS D
  JOIN agabang_dw.prod_sales_stock_by_color AS P
    ON D.sty_cd = P.sty_cd AND D.col_cd = P.col_cd
  WHERE 
    (D.sty_cd, D.col_cd) IN (
      {{
        selectedReorderItems.value.filter(item => 
          item.reorder_info.groupId === selectedReorderItems.value[0].reorder_info.groupId
        ).map(item =>
          `('${item.reference_info.sty_cd}', '${item.reference_info.col_cd}')`
        ).join(',')
      }}
    )
    AND D.sale_dt >= P.fout_date
)
SELECT 
  *
FROM base_data
ORDER BY sale_dt