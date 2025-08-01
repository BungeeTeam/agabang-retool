with shop_tbl as (
  select
      shop_cd,
      COUNT(recp_no) as recp_cnt,
      AVG(sale_qty) as avg_selling_qty,
      AVG(sale_amt) as avg_selling_price
  from (
      select
          shop_cd,
          recp_no,
          count(seq_no) as selling_cnt,
          sum(sale_qty) as sale_qty,
          sum(sale_amt) as sale_amt
      from agabang.slpd
      where shop_cd = '{{ selectedRow.value.shop_cd }}'
        and toDate(sale_dt) >= '{{ startDate.value }}' and toDate(sale_dt) <= '{{ endDate.value }}'
      group by shop_cd, sale_dt, recp_no
  )
  group by shop_cd
), 
tot_tbl as (
  select
    AVG(sale_qty) as tot_avg_selling_qty,
    AVG(sale_amt) as tot_avg_selling_price
  from (
      select
          shop_cd,
          recp_no,
          count(seq_no) as selling_cnt,
          sum(sale_qty) as sale_qty,
          sum(sale_amt) as sale_amt
      from agabang.slpd
      where toDate(sale_dt) >= '{{ startDate.value }}' and toDate(sale_dt) <= '{{ endDate.value }}' and shop_cd IN (
      SELECT shop_cd 
      FROM agabang_dw.dim_shop 
      WHERE biz_cd = (
          SELECT biz_cd 
          FROM agabang_dw.dim_shop 
          WHERE shop_cd = '{{ selectedRow.value.shop_cd }}'
          LIMIT 1
      )
    )
    group by shop_cd, sale_dt, recp_no
  )
)
select 
  shop_cd, 
  recp_cnt,
  avg_selling_qty, 
  avg_selling_price,
  tot_avg_selling_qty,
  tot_avg_selling_price
from shop_tbl, tot_tbl
;