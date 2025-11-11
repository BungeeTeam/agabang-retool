select 
  sale_dt, 
  gift_yn, 
  sum(sale_qty) as sale_qty, 
  sum(sale_amt) as sale_amt
from (
  select
      date_format(DATE(sale_dt), '%Y-%m') as sale_dt,
      coalesce(gift_yn, 'NA') as gift_yn,
      tot_sale_qty as sale_qty,
      tot_sale_amt as sale_amt
  from agabang.slph
  where sale_dt >= '2024-01-01'
)
group by sale_dt, gift_yn
order by sale_dt
;