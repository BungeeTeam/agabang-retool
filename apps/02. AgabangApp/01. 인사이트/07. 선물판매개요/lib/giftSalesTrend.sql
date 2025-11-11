select A.sale_dt, A.gift_yn, A.sales_rev, B.tot_sales_rev, A.sales_rev / B.tot_sales_rev as ratio
from (
  select
    sale_dt, gift_yn, sum(sale_amt) as sales_rev
  from (
    select
        date_format(DATE(sale_dt), '%Y-%m') as sale_dt,
        gift_yn,
        tot_sale_qty as sale_qty,
        tot_sale_amt as sale_amt
    from agabang.slph
    where sale_dt >= '2024-09-01' and gift_yn is not null
  
  )
  group by sale_dt, gift_yn
  order by sale_dt  
) as A
left join (
  select
    sale_dt, sum(sale_amt) as tot_sales_rev
  from (
    select
        date_format(DATE(sale_dt), '%Y-%m') as sale_dt,
        gift_yn,
        tot_sale_qty as sale_qty,
        tot_sale_amt as sale_amt
    from agabang.slph
    where sale_dt >= '2024-09-01' and gift_yn is not null
  
  )
  group by sale_dt
  order by sale_dt  
) as B
on A.sale_dt = B.sale_dt