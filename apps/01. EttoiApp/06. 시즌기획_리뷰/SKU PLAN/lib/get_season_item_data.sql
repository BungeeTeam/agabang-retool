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
      and B.year_sesn_nm_eng in ('24WT', '23WT', '22WT' )
    group by 1
),
SEASON_DATA as (
    select
        A.sty_cd,
        B.year_sesn_nm_eng as year_season,
        min(A.sale_dt) as first_sale_dt,
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
    where A.sale_dt between addDays(C.first_sale_dt, -180) and addDays(C.last_sale_dt, 180)
      and A.br_cd = brand_code
    group by 1, 2
)
select
      F.sty_nm as "상품명",
      A.sty_cd as "상품코드",
      A.first_sale_dt as "첫 판매일",
      A.last_sale_dt as "마지막 판매일",
      A.tot_in_qty as "입고수량",
      A.tot_in_amt as "입고금액",
      A.tot_sale_qty as "판매수량",
      A.tot_sale_amt as "실판매금액",
      D.cat_nm as "소분류",
      C.item_raw_nm as "상품종류",
      C.fabric as "상품소재",
      A.tot_sale_amt / A.tot_in_amt as "판매율",
      -- C.cost_price as "제조금액",
      -- C.prod_comp as "제조회사",
      C.prod_country as "제조국가",
      F.tag_price as "판매금액"
from SEASON_DATA as A
join agabang_dw.retooldb_item_md_info as C
  on A.sty_cd = C.sty_cd
join agabang_dw.retooldb_item_md_category as D
  on C.item_md_category_id = D.id
join (
    select
        sty_cd,
        max(sty_nm) as sty_nm,
        max(tag_prce) as tag_price
    from agabang_dw.prod_sales_stock_by_size
    where br_cd = brand_code
    group by 1
) as F
  on A.sty_cd = F.sty_cd
where D.cat_nm = '{{ var_select_category.value }}'
  and C.br_cd = brand_code
  and D.br_cd = brand_code