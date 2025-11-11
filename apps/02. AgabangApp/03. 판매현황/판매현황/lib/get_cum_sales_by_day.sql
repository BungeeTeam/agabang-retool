-- get_cum_sales_by_day (첫 출고일 기준 수정)

with
    '{{ var_brand_code.value }}' as brand_code,
    FIRST_OUT_DAY as (
   select
        concat(B.year_nm_short, B.sesn_nm_eng) as year_season,
        case when {{sel_category.value}} = 55 then 55 else  coalesce(C.item_md_category_id, 90) end as cat_id,
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
    and ( ( coalesce(C.item_md_category_id, 90) = {{sel_category.value}} ) or ( {{sel_category.value}} = 55 ) )
    and A.out_qty > 0
    group by 1,2
),
    -- 전체 시즌 중 가장 빠른 월일 찾기 (연도 제외)
    GLOBAL_FIRST_MONTH_DAY as (
        select 
            min(formatDateTime(first_out_day, '%m-%d')) as global_first_month_day,
            argMin(first_out_day, formatDateTime(first_out_day, '%m-%d')) as absolute_first_out_day
        from FIRST_OUT_DAY
    ),
    FIRST_SALE_DAY as (Select
        concat(B.year_nm_short, B.sesn_nm_eng) as year_season,
        case when {{sel_category.value}} = 55 then 55 else  coalesce(C.item_md_category_id, 90) end as cat_id,
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
           case when {{sel_category.value}} = 55 then 55 else  coalesce(C.item_md_category_id, 90) end = E.cat_id
    
    where A.br_cd = brand_code
    and concat(B.year_nm_short, B.sesn_nm_eng) in ('{{var_last_seasons.value.join("', '")}}')
    and A.sale_qty > 0 and A.sale_dt > E.first_out_day
    group by 1,2
), TOTAL_IN as (
    select
        concat(B.year_nm_short, B.sesn_nm_eng) as year_season,
        case when {{sel_category.value}} = 55 then 55 else  coalesce(C.item_md_category_id, 90) end as cat_id,
        sum(A.tot_in_qty) as tot_in_qty,
        sum(A.tot_in_tag_amt) as tot_in_tag_amt,
        sum(A.tot_sale_amt) as tot_sale_amt,
        sum(A.tot_in_cost_amt) as tot_in_cost_amt
    from agabang_dw.prod_sales_stock_by_size as A
    join agabang_dw.retooldb_code_season as B
    on substring(A.sty_cd, 3, 2) = B.year_sesn_cd
    left outer join agabang_dw.retooldb_item_md_info as C
    on A.sty_cd = C.sty_cd
    where A.br_cd = brand_code
    and concat(B.year_nm_short, B.sesn_nm_eng) in ('{{var_last_seasons.value.join("', '")}}')
    and ( ( coalesce(C.item_md_category_id, 90) = {{sel_category.value}} ) or ( {{sel_category.value}} = 55 ) )
    group by 1,2
),
DAY_DATA as (
    select concat(B.year_nm_short, B.sesn_nm_eng)                         as year_season,
        case when {{sel_category.value}} = 55 then 55 else  coalesce(C.item_md_category_id, 90) end as cat_id,
        FIRST_OUT_DAY.first_out_day                                    as first_out_day,
        FIRST_SALE_DAY.first_sale_day                                  as first_sale_day,
        GLOBAL_FIRST_MONTH_DAY.global_first_month_day                  as global_first_month_day,
        GLOBAL_FIRST_MONTH_DAY.absolute_first_out_day                  as absolute_first_out_day,
        A.sale_dt                                                      as sale_dt,
        -- 원본: 각 시즌별 첫판매일 기준 경과일
        date_diff('day', FIRST_SALE_DAY.first_sale_day, A.sale_dt)     as days,
        MAX(TOTAL_IN.tot_in_qty)                                       as tot_in_qty,
        MAX(TOTAL_IN.tot_in_cost_amt)                                  as tot_in_cost_amt,
        MAX(TOTAL_IN.tot_in_tag_amt)                                   as tot_in_tag_amt,
        MAX(TOTAL_IN.tot_sale_amt)                                     as tot_sale_amt,
        sum(A.sale_qty)                                                as sale_qty,
        SUM(SUM(A.sale_qty)) OVER (PARTITION BY (concat(B.year_nm_short, B.sesn_nm_eng), case when {{sel_category.value}} = 55 then 55 else coalesce(C.item_md_category_id, 90) end ) ORDER BY A.sale_dt)                AS cumulative_sale_qty,
        sum(A.sale_amt)                                                as sale_amt,
        SUM(SUM(A.sale_amt)) OVER (PARTITION BY (concat(B.year_nm_short, B.sesn_nm_eng), case when {{sel_category.value}} = 55 then 55 else coalesce(C.item_md_category_id, 90) end  ) ORDER BY A.sale_dt)                 AS cumulative_sale_amt,
        sum(A.sale_qty*E.tag_prce)                                     as sale_tag_amt,
        SUM(SUM(A.sale_qty * E.tag_prce)) OVER (PARTITION BY (concat(B.year_nm_short, B.sesn_nm_eng), case when {{sel_category.value}} = 55 then 55 else coalesce(C.item_md_category_id, 90) end ) ORDER BY A.sale_dt)      AS cumulative_tag_sale_amt
    from agabang_dw.daily_data_by_color as A
    left outer join agabang_dw.retooldb_item_md_info as C
       on A.sty_cd = C.sty_cd
    join agabang_dw.retooldb_code_season as B
       on substring(A.sty_cd, 3, 2) = B.year_sesn_cd
    join FIRST_OUT_DAY
       on concat(B.year_nm_short, B.sesn_nm_eng) = FIRST_OUT_DAY.year_season
       and case when {{sel_category.value}} = 55 then 55 else coalesce(C.item_md_category_id, 90) end = FIRST_OUT_DAY.cat_id
    join FIRST_SALE_DAY
       on concat(B.year_nm_short, B.sesn_nm_eng) = FIRST_SALE_DAY.year_season
       and case when {{sel_category.value}} = 55 then 55 else coalesce(C.item_md_category_id, 90) end = FIRST_SALE_DAY.cat_id
    join TOTAL_IN
       on concat(B.year_nm_short, B.sesn_nm_eng) = TOTAL_IN.year_season
       and case when {{sel_category.value}} = 55 then 55 else coalesce(C.item_md_category_id, 90) end = TOTAL_IN.cat_id
    cross join GLOBAL_FIRST_MONTH_DAY
    join agabang_dw.prod_sales_stock_by_color as E
    on A.sty_cd = E.sty_cd
    and A.col_cd = E.col_cd
    where A.br_cd = brand_code
        and concat(B.year_nm_short, B.sesn_nm_eng) in ('{{var_last_seasons.value.join("', '")}}')
        and A.sale_dt >= FIRST_SALE_DAY.first_sale_day
        and datediff('day', FIRST_SALE_DAY.first_sale_day, A.sale_dt) <= 300
    group by 1, 2, 3, 4, 5, 6, 7, 8
    order by 1, 2, 3, 4, 5, 6, 7, 8
)
select
    year_season,
    cat_id,
    first_out_day,
    first_sale_day,
    global_first_month_day,
    absolute_first_out_day,
    days,
    sale_dt,
    round(cumulative_sale_qty/tot_in_qty, 2)*100 as sale_qty_per,
    round(cumulative_tag_sale_amt/tot_in_tag_amt, 2)*100 as sale_tag_amt_per,
    round(cumulative_sale_amt/tot_in_tag_amt, 2)*100 as sale_amt_per
FROM DAY_DATA
WHERE ( ( cat_id = {{sel_category.value}} ) or ( {{sel_category.value}} = 55 ) )

ORDER BY 1,2,3,4,5,6