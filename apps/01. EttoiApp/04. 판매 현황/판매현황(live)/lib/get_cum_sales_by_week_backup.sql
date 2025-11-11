with
'{{ var_brand_code.value }}' as brand_code,
    FIRST_OUT_DAY as (
   select
        concat(B.year_nm_short, B.sesn_nm_eng) as year_season,
        case when {{sel_category.value}} = 19 then 19 else  coalesce(C.item_md_category_id, 18) end as cat_id,
        min(sale_dt) as first_out_day
    from agabang_dw.daily_data_by_style as A
    join agabang_dw.retooldb_code_season as B
    on substring(A.sty_cd, 3, 2) = B.year_sesn_cd
    left outer join agabang_dw.retooldb_item_md_info as C
    on A.sty_cd = C.sty_cd
    left outer join agabang_dw.retooldb_item_md_category as D
    on C.item_md_category_id = D.id

    where A.br_cd = brand_code
    and concat(B.year_nm_short, B.sesn_nm_eng) in ('{{var_last_seasons.value.join("', '")}}')
    and ( ( coalesce(C.item_md_category_id, 18) = {{sel_category.value}} ) or ( {{sel_category.value}} = 19 ) )
    and A.out_qty > 0
    group by 1,2
),
    FIRST_SALE_DAY as (Select
        concat(B.year_nm_short, B.sesn_nm_eng) as year_season,
        case when {{sel_category.value}} = 19 then 19 else  coalesce(C.item_md_category_id, 18) end as cat_id,
        min(sale_dt) as first_sale_day
    from agabang_dw.daily_data_by_style as A
    join agabang_dw.retooldb_code_season as B
    on substring(A.sty_cd, 3, 2) = B.year_sesn_cd
    left outer join agabang_dw.retooldb_item_md_info as C
    on A.sty_cd = C.sty_cd
    left outer join agabang_dw.retooldb_item_md_category as D
    on C.item_md_category_id = D.id
    JOIN FIRST_OUT_DAY as E
        on concat(B.year_nm_short, B.sesn_nm_eng) = E.year_season and
           case when {{sel_category.value}} = 19 then 19 else  coalesce(C.item_md_category_id, 18) end = E.cat_id
    
    where A.br_cd = brand_code
    and concat(B.year_nm_short, B.sesn_nm_eng) in ('{{var_last_seasons.value.join("', '")}}')
    --and ( ( coalesce(C.item_md_category_id, 90) = {{sel_category.value}} ) or ( {{sel_category.value}} = 55 ) )
    and A.sale_qty > 0 and A.sale_dt > E.first_out_day
    group by 1,2
),
  
WEEK_DATA as (
    select concat(B.year_nm_short, B.sesn_nm_eng)                         as year_season,
        case when {{sel_category.value}} = 19 then 19 else  coalesce(C.item_md_category_id, 18) end as cat_id,
        FIRST_SALE_DAY.first_sale_day                                  as first_sale_day,
        FLOOR(date_diff('day', FIRST_SALE_DAY.first_sale_day, A.sale_dt)/7)+1    as weeks,
        sum(A.sale_qty)                                                as sale_qty,
        sum(A.sale_amt)                                                as sale_amt,
        sum(A.sale_qty*E.tag_prce)                                     as sale_tag_amt,
        min(A.sale_dt) as s_date,
        max(A.sale_dt) as f_date
    from agabang_dw.daily_data_by_color as A
    left outer join agabang_dw.retooldb_item_md_info as C
       on A.sty_cd = C.sty_cd
    join agabang_dw.retooldb_code_season as B
       on substring(A.sty_cd, 3, 2) = B.year_sesn_cd
    join FIRST_SALE_DAY
       on concat(B.year_nm_short, B.sesn_nm_eng) = FIRST_SALE_DAY.year_season
       and case when {{sel_category.value}} = 19 then 19 else coalesce(C.item_md_category_id, 18) end = FIRST_SALE_DAY.cat_id
    join agabang_dw.prod_sales_stock_by_color as E
    on A.sty_cd = E.sty_cd
    and A.col_cd = E.col_cd
    where A.br_cd = brand_code
        and concat(B.year_nm_short, B.sesn_nm_eng) in ('{{var_last_seasons.value.join("', '")}}')
        and A.sale_dt >= FIRST_SALE_DAY.first_sale_day
        and datediff('day', FIRST_SALE_DAY.first_sale_day, A.sale_dt) <= 301
    group by 1, 2, 3, 4
)
select
    year_season,
    cat_id,
    weeks,
    concat(s_date,' - ',f_date) as date_range,
    sum(sale_qty) as sale_qty_per,
    sum(sale_amt)/1000000 as sale_tag_amt_per,
    sum(sale_tag_amt)/1000000 as sale_amt_per
FROM WEEK_DATA
WHERE ( ( cat_id = {{sel_category.value}} ) or ( {{sel_category.value}} = 19 ) )
GROUP BY 1, 2, 3, 4
ORDER BY 1, 2, 3, 4