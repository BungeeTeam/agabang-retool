with 
  '07' as brand_code,
SEASON_FIRST_SALE_DATE as (
    select
      B.year_sesn_nm_eng,
      min(A.sale_dt) as first_sale_dt,
      addDays(min(A.sale_dt), {{ numberInput_sale_days.value }}) as last_sale_dt
    from agabang_dw.daily_sales_by_style as A
    join code_season as B
      on concat(A.year_cd, A.sesn_cd) = B.year_sesn_cd
        and B.sesn_cd in ('1', '3', '5', '7')
    where A.sale_qty > 0
      and A.br_cd = brand_code
      and B.year_sesn_nm_eng in ({{ var_season_list.value.map(item => `'${item}'`).join(", ") }} )
    group by 1
),
SEASON_DATA as (
    select
        A.sty_cd,
        B.year_sesn_nm_eng as year_season,
        max(A.sale_dt) as last_sale_dt,
        sum(A.in_qty) as tot_in_qty,
        sum(A.in_amt) as tot_in_amt,
        sum(A.sale_qty) as tot_sale_qty,
        sum(A.sale_amt) as tot_sale_amt
    from agabang_dw.daily_sales_by_style as A
    join code_season as B
      on concat(A.year_cd, A.sesn_cd) = B.year_sesn_cd
        and B.sesn_cd in ('1', '3', '5', '7')
    join SEASON_FIRST_SALE_DATE as C
      on B.year_sesn_nm_eng = C.year_sesn_nm_eng
   where A.sale_dt between C.first_sale_dt and C.last_sale_dt
     and A.br_cd = brand_code
   group by 1, 2
)
select A.year_season       as year_season,
     D.cat_nm            as cat_nm,
     C.item_raw_nm       as item_raw_nm,
     count(A.sty_cd)     as sku,
     sum(A.tot_in_qty)   as tot_in_qty,
     sum(A.tot_in_amt)   as tot_in_amt,
     sum(A.tot_sale_qty) as tot_sale_qty,
     sum(A.tot_sale_amt) as tot_sal_amt
from SEASON_DATA as A
       join agabang_dw.retooldb_item_md_info as C
            on A.sty_cd = C.sty_cd
       join agabang_dw.retooldb_item_md_category as D
            on C.item_md_category_id = D.id
where C.br_cd = brand_code
  and D.br_cd = brand_code
group by 1, 2, 3
order by 1, 2, 3