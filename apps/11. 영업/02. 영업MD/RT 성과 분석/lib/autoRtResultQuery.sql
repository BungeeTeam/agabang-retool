with rt_tbl as (
    select
        toDate(ord_dt) as rt_start_dt,
        toDate(rt_fr_dt) as rt_dt,
        addDays(toDate(rt_fr_dt), 30) as rt_end_dt,
        sty_cd,
        col_cd,
        size_cd,
        to_shop_cd as shop_cd,
        sum(fr_qty) as rt_qty
      from agabang.shrtord
      where ord_fix_yn = 'Y' and substring(sty_cd, 1, 2) = '{{ bizSelect.value }}' and toYear(toDate(ord_dt)) >= toYear(today()) - 1 
  and ord_id in ('AUTO01', 'AUTO07') and fr_qty > 0
      group by ord_dt, to_shop_cd, sty_cd, col_cd, size_cd, rt_dt
),
sales_stat as (
    select
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
    group by rt_start_dt
    order by rt_start_dt
)
select
    t1.rt_start_dt as rt_start_dt,
    rt_sty_cnt,
    rt_ord_qty,
    tot_sales_qty,
    rt_rev,
    tot_sales_qty / rt_ord_qty as sales_ratio,
    avg(tot_sales_qty / rt_ord_qty) OVER (ORDER BY rt_start_dt ROWS BETWEEN 7 PRECEDING AND CURRENT ROW) as ma_sales_ratio
from (
    select
        rt_start_dt, count(distinct(sty_cd)) as rt_sty_cnt, sum(rt_qty) as rt_ord_qty
    from rt_tbl
    group by rt_start_dt
) as t1
left join sales_stat as t2
on t1.rt_start_dt = t2.rt_start_dt
;
