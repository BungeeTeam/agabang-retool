WITH shop_inventory_tbl AS (
    SELECT
        A.sty_cd as sty_cd,
        B.sty_nm as sty_nm,
        A.in_qty as in_qty,
        A.rt_in_qty as rt_in_qty,
        A.sales_qty - A.cust_rqty as net_sales_qty,
        A.sales_qty as sales_qty,
        A.cust_rqty as cust_rqty,
        A.wh_rtn_qty + A.rt_rtn_qty AS rtn_qty,
        A.adjt_qty as adjt_qty,
        A.stock_qty as stock_qty,
        B.br_nm as br_nm,
        B.year_nm as year_nm,
        B.season_nm as season_nm,
        B.season_seq as season_seq,
        B.it_nm as it_nm,
        B.it_gb_nm as it_gb_nm,
        B.item_nm as item_nm,
        C.tot_sales_qty as tot_sales_qty,
        C.tot_stock_qty as tot_stock_qty
    FROM (
        SELECT 
          sty_cd,
          SUM(in_qty) as in_qty,
          SUM(rt_in_qty) as rt_in_qty,
          SUM(sales_qty) as sales_qty,
          SUM(cust_rqty) as cust_rqty,
          SUM(wh_rtn_qty) as wh_rtn_qty,
          SUM(rt_rtn_qty) as rt_rtn_qty,
          SUM(adjt_qty) as adjt_qty,
          SUM(stock_qty) as stock_qty
        FROM agabang.shstksum
        WHERE comp_cd = 'AG001' AND shop_cd = '{{ selectedRow.value.shop_cd }}'
        GROUP BY sty_cd
    ) AS A
    LEFT JOIN (
      SELECT DISTINCT 
          sty_cd, 
          sty_nm,
          br_nm,
          year_nm, 
          season_nm, 
          season_seq,
          it_nm,
          it_gb_nm,
          item_nm
      FROM agabang_dw.dim_style
    ) AS B
    ON A.sty_cd = B.sty_cd
    LEFT JOIN (
        SELECT
            sty_cd,
            -- SUM(in_qty) as tot_in_qty,
            SUM(sales_qty) as tot_sales_qty,
            SUM(stock_qty) as tot_stock_qty
        FROM agabang.shstksum
        WHERE comp_cd = 'AG001'
        GROUP BY sty_cd
    ) as C
    ON A.sty_cd = C.sty_cd
)
SELECT *
FROM shop_inventory_tbl
WHERE in_qty > 0
ORDER BY 
  year_nm DESC, season_seq, it_nm, it_gb_nm, item_nm
;
