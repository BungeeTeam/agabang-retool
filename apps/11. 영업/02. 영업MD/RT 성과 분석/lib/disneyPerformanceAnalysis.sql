with rt_tbl as (
    select
        toDate(ord_dt) as rt_start_dt,
        case 
          when ord_id = 'AUTO79' or (reg_tp = 'E' and rt_start_dt = '2025-06-16') then 'Cleave'
          when ord_id not like 'AUTO%' and reg_tp = 'A' then 'Auto'
          else 'RequestByShop'
        end as ord_id,
        toDate(rt_fr_dt) as rt_dt,
        addDays(toDate(rt_fr_dt), 30) as rt_end_dt,
        sty_cd,
        col_cd,
        size_cd,
        to_shop_cd as shop_cd,
        sum(fr_qty) as rt_qty
    from agabang.shrtord
    where ord_fix_yn = 'Y' 
  and date_format(toDate(ord_dt), '%m-%d') >= date_format(DATE '2025-06-01', '%m-%d') 
  and toYear(toDate(ord_dt)) >= 2024
  and date_format(toDate(ord_dt), '%m-%d') <= date_format(subtractDays(today(), 0), '%m-%d')
  and fr_qty > 0
  and substring(sty_cd, 1, 2) = '79'
  group by ord_dt, ord_id, to_shop_cd, sty_cd, col_cd, size_cd, rt_dt
),
sales_stat as (
    select
      ord_id,
      rt_start_dt,
      coalesce(sum(if(A.rt_dt <= B.sale_dt AND A.rt_end_dt >= B.sale_dt, B.sales_qty, NULL)), 0) AS tot_sales_qty,
      coalesce(sum(if(A.rt_dt <= B.sale_dt AND A.rt_end_dt >= B.sale_dt, B.sales_price, NULL)), 0) AS rt_rev
    from rt_tbl as A
    left join (
      select
        sale_dt, shop_cd, sty_cd, col_cd, size_cd, sales_qty, sales_price
      from agabang_dw.daily_shop_sales_by_size
    ) as B
    on A.shop_cd = B.shop_cd and A.sty_cd = B.sty_cd and A.col_cd = B.col_cd and A.size_cd = B.size_cd
    group by rt_start_dt, ord_id
    order by rt_start_dt, ord_id
)
select
    ord_id,
    t1.rt_start_dt as rt_start_dt,
    rt_sty_cnt,
    rt_ord_qty,
    tot_sales_qty,
    rt_rev,
    tot_sales_qty / rt_ord_qty as sales_ratio,
    avg(tot_sales_qty / rt_ord_qty) OVER (ORDER BY rt_start_dt ROWS BETWEEN 7 PRECEDING AND CURRENT ROW) as ma_sales_ratio
from (
    select
        ord_id, rt_start_dt, count(distinct(sty_cd)) as rt_sty_cnt, sum(rt_qty) as rt_ord_qty
    from rt_tbl
    group by rt_start_dt, ord_id
) as t1
left join sales_stat as t2
on t1.rt_start_dt = t2.rt_start_dt and t1.ord_id = t2.ord_id
order by rt_start_dt, ord_id
;