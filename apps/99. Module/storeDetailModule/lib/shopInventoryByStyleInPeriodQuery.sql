WITH
toDate('{{ startDate.value }}') as startDate,
toDate('{{ endDate.value }}') as endDate,
'{{ selectedRow.value?.shop_cd }}' as shopCode,
'{{ invenBrSelect.value }}' as brandCode,

base AS (
  SELECT
    comp_cd, sty_cd,
    sum(CASE WHEN io_type = 'O' AND rt_yn = 'N' THEN out_qty ELSE 0 END) AS in_qty,
    sum(CASE WHEN io_type = 'O' AND rt_yn = 'Y' THEN out_qty ELSE 0 END) AS rt_in_qty,
    sum(CASE WHEN io_type = 'R' AND rt_yn = 'N' THEN out_qty ELSE 0 END) AS wh_rtn_qty,
    sum(CASE WHEN io_type = 'R' AND rt_yn = 'Y' THEN out_qty ELSE 0 END) AS rt_rtn_qty
  FROM agabang.dsoutrtn
  WHERE comp_cd = 'AG001'
    AND shop_cd = shopCode
    AND toDate(wrk_dt) between startDate and endDate
  GROUP BY comp_cd, sty_cd
),
shopCustRqty AS (
  SELECT
    comp_cd, sty_cd,
    sum(CASE WHEN sale_qty > 0 THEN sale_qty ELSE 0 END) as tot_sale_qty,
    sum(CASE WHEN sale_qty < 0 THEN sale_qty ELSE 0 END) * -1 as cust_rqty
  FROM agabang.slpd
  WHERE comp_cd = 'AG001'
    AND shop_cd = shopCode
    AND toDate(sale_dt) between startDate and endDate
  GROUP BY comp_cd, sty_cd
)
SELECT
  A.sty_cd as sty_cd,
  dim.sty_nm as sty_nm,
  A.in_qty as period_in_qty,
  A.rt_in_qty as period_rt_in_qty,
  coalesce(B.tot_sale_qty,0) - coalesce(B.cust_rqty,0) as period_net_sale_qty,
  coalesce(B.tot_sale_qty,0) as period_sale_qty,
  coalesce(B.cust_rqty,0) as period_cust_rqty,
  A.wh_rtn_qty as period_wh_rtn_qty,
  A.rt_rtn_qty as period_rt_rtn_qty,
  A.wh_rtn_qty + A.rt_rtn_qty as period_rtn_qty,
  dim.br_nm,
  dim.year_nm,
  dim.season_nm,
  dim.season_seq,
  dim.it_nm,
  dim.it_gb_nm,
  dim.item_nm
FROM base AS A
LEFT JOIN shopCustRqty AS B ON A.sty_cd = B.sty_cd
LEFT JOIN (
  SELECT
    distinct
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
) AS dim ON A.sty_cd = dim.sty_cd
-- ORDER BY year_nm DESC, season_seq, it_nm, it_gb_nm, item_nm;