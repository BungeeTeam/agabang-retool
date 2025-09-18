WITH
-- 변수
    '{{ var_brand_code.value }}' as brand_code, 
    '{{season_select.selectedItem.prev_year_sesn_cd}}' as season_code,
      toDate('{{ var_prev_date.value }}') as deadline_date,

    filtered_dim as(
        SELECT
        distinct br_cd,year_cd,season_cd,sty_nm,sty_cd,col_cd,col_nm,large_cat,middle_cat,small_cat,it,it_gb,item,item_md_category_id,cost_price,tag_price
        FROM agabang_dw.dim_style
        WHERE br_cd = brand_code
        and concat(year_cd,season_cd) = season_code
    ),

    fitered_cum_sales as (
        SELECT
        sty_cd,
        max(sty_nm) as sty_nm,
        col_cd,
        max(col_nm) as col_nm,
        max(year_cd) as year_cd,
        max(sesn_cd) as sesn_cd,
        sum(in_qty) as tot_in_qty,
        sum(in_amt) as tot_in_amt,
        sum(out_qty) as tot_out_qty,
        sum(out_amt) as tot_out_amt,
        sum(sale_qty) as tot_sale_qty,
        sum(sale_amt) as tot_sale_amt
        FROM agabang_dw.daily_sales_by_color
        WHERE br_cd = brand_code
            and substring(sty_cd,3,2) = season_code
            and sale_dt <= deadline_date
        GROUP BY sty_cd, col_cd
    ),

    category_inout AS (
        SELECT
        -- CASE 
            -- WHEN max(A.item_md_category_id) = '1' THEN '기초복'
            -- WHEN max(A.item_md_category_id) = '2' THEN '시즌의류'
            -- WHEN max(A.item_md_category_id) = '6' THEN '기초ACC'
            -- WHEN max(A.item_md_category_id) = '7' THEN '정상ACC'
            -- -- WHEN max(A.item_md_category_id) = '22' THEN '시즌의류(T)'
            -- ELSE max(A.large_cat) END as cat_nm,
        max(A.large_cat) as cat_nm,
        max(A.item_md_category_id) as cat_id,

        sum(C.plan_qty) as tot_ord_qty,
        sum(C.plan_tag_amt) as tot_ord_tag,
        -- sum(B.tot_in_qty) / sum(C.plan_qty) as in_rate_tag,
        sum(B.tot_in_amt) / sum(C.plan_tag_amt) as in_rate_tag,
        count(C.plan_qty) as ord_st,
        sum(case when B.tot_in_qty is not null then 1 else 0 end) as in_st,
        count(C.plan_qty) - sum(case when B.tot_in_qty > 0 then 1 else 0 end) as not_in_st,
        sum(case when B.tot_in_qty > 0 then 1 else 0 end)/count(C.plan_qty) as in_st_rate,
        sum(case when B.tot_out_qty > 0 then 1 else 0 end) as out_st,
        sum(case when B.tot_in_qty > 0 then 1 else 0 end) - sum(case when B.tot_out_qty > 0 then 1 else 0 end) as not_out_st,
        sum(case when B.tot_out_qty > 0 then 1 else 0 end)/count(C.plan_qty) as out_st_rate,
        sum(B.tot_in_qty) as tot_in_qty, -- 총입고수량
        sum(B.tot_sale_qty) as tot_sale_qty, -- 누적판매수량
        sum(B.tot_sale_qty)/sum(B.tot_in_qty) as sale_rate_qty, -- 판매율
        sum(B.tot_in_qty*(A.cost_price*1.1)) as tot_in_cost_amt, -- 누적입고구입가
        sum(B.tot_in_amt) as tot_in_tag,
        sum(B.tot_sale_qty*A.tag_price) as tot_sale_tag,
        sum(B.tot_sale_amt) as tot_sale_amt,
        sum(B.tot_sale_qty*A.tag_price)/sum(B.tot_in_amt) as sale_rate_tag,
        sum(B.tot_sale_amt)/sum(B.tot_in_amt) as sale_rate_amt,
        1-(sum(B.tot_sale_amt)/sum(B.tot_sale_qty*A.tag_price)) as discount_rate,
        sum(B.tot_in_qty)-sum(B.tot_sale_qty) as inven_qty,
        sum(B.tot_in_amt)-sum(B.tot_sale_qty*A.tag_price) as inven_tag,
        CASE
            WHEN substring(max(A.sty_cd),5,1) in ('1','2','3','7')
            THEN 1
            WHEN substring(max(A.sty_cd),5,1) = '5'
            THEN 2
            ELSE 3
        END as ttl_index
        FROM filtered_dim as A
        LEFT JOIN fitered_cum_sales AS B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
        LEFT JOIN agabang_dw.prod_sales_stock_by_color as C ON A.sty_cd = C.sty_cd and A.col_cd = C.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
        GROUP BY A.item_md_category_id
        ORDER BY 1
    ),
--
--     category_cum AS(
--         SELECT
--
--         max(B.large_cat) as cat_nm,
--         max(B.item_md_category_id) as cat_id,
--
--         sum(A.in_qty) as tot_in_qty,
--         sum(A.sale_qty) as tot_sale_qty,
--         sum(A.sale_qty)/sum(A.in_qty) as sale_rate_qty,
--         sum((B.cost_price*1.1)*A.in_qty) as tot_in_cost_amt,
--         sum(A.in_amt) as tot_in_tag,
--         sum(A.sale_qty*B.tag_price) as tot_sale_tag,
--         sum(A.sale_amt) as tot_sale_amt,
--         sum(A.sale_qty*B.tag_price)/sum(A.in_amt) as sale_rate_tag,
--         sum(A.sale_amt)/sum(A.in_amt) as sale_rate_amt,
--         1-(sum(A.sale_amt)/sum(A.sale_qty*B.tag_price)) as discount_rate,
--         sum(A.in_qty)-sum(A.sale_qty) as inven_qty,
--         sum(A.in_amt)-sum(A.sale_qty*B.tag_price) as inven_tag
--         FROM agabang_dw.daily_sales_by_color AS A
--         RIGHT JOIN filtered_dim AS B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
--         WHERE A.br_cd = brand_code
--             and substring(A.sty_cd,3,2) = season_code
--             and A.sale_dt <= deadline_date
--         GROUP BY B.item_md_category_id
--         ORDER BY 1
--     ),

    category_monthly AS(
        SELECT

        max(B.large_cat) as cat_nm,
        max(B.item_md_category_id) as cat_id,

        sum(A.sale_qty) as monthly_sale_qty,
        sum(A.sale_qty * B.tag_price) as monthly_sale_tag,
        sum(A.sale_amt) as monthly_sale_amt
        FROM agabang_dw.daily_sales_by_color AS A
        RIGHT JOIN filtered_dim AS B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
            -- and toYear(toDate(A.sale_dt)) = toYear(deadline_date)
            -- and MONTH(toDate(A.sale_dt)) = MONTH(deadline_date)
            -- and A.sale_dt <= deadline_date
            and A.sale_dt between '{{ moment(date_select.value).subtract(1,'years').startOf('month').format('YYYY-MM-DD') }}' and '{{ moment(date_select.value).subtract(1,'years').format('YYYY-MM-DD') }}'
        GROUP BY B.item_md_category_id
        ORDER BY 1
    ),

    category_last_week AS(
        SELECT

        max(B.large_cat) as cat_nm,
        max(B.item_md_category_id) as cat_id,

        sum(A.sale_qty) as last_week_sale_qty,
        sum(A.sale_qty * B.tag_price) as last_week_sale_tag,
        sum(A.sale_amt) as last_week_sale_amt
--         sum(A.sale_qty * B.tag_price)/sum(C.tot_in_amt) as last_week_progress_rate
        FROM agabang_dw.daily_sales_by_color AS A
        JOIN filtered_dim AS B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
        LEFT JOIN fitered_cum_sales AS C ON A.sty_cd = C.sty_cd and A.col_cd = C.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
            and A.sale_dt between deadline_date - 13 and deadline_date - 7
        GROUP BY B.item_md_category_id
        ORDER BY 1
    ),

    category_this_week AS(
        SELECT

        max(B.large_cat)  as cat_nm,
        max(B.item_md_category_id) as cat_id,

        sum(A.sale_qty) as this_week_sale_qty,
        sum(A.sale_qty * B.tag_price) as this_week_sale_tag,
        sum(A.sale_amt) as this_week_sale_amt
--         sum(A.sale_qty * B.tag_price)/sum(C.tot_in_amt) as this_week_progress_rate
        FROM agabang_dw.daily_sales_by_color AS A
        JOIN filtered_dim AS B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
        LEFT JOIN fitered_cum_sales AS C ON A.sty_cd = C.sty_cd and A.col_cd = C.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
            and A.sale_dt between deadline_date - 6 and deadline_date
        GROUP BY B.item_md_category_id
        ORDER BY 1
    )

       SELECT
        -- CASE WHEN A.cat_id = '1' THEN '기초복'
        --      WHEN A.cat_id = '2' THEN '시즌의류'
        --      WHEN A.cat_id = '6' THEN '기초ACC'
        --      WHEN A.cat_id = '7' THEN '정상ACC'
        --     -- WHEN A.cat_id = '22' THEN '시즌의류(T)'
        --     ELSE A.cat_nm END as cat_nm,
        A.cat_nm as cat_nm,
        CAST(A.cat_id as INT) as cat_id,
        -- A.cat_id as cat_id,
        A.tot_ord_qty,
        A.tot_ord_tag,
        A.in_rate_tag,
        A.ord_st,
        A.in_st,
        A.not_in_st,
        A.in_st_rate,
        A.out_st,
        A.not_out_st,
        A.out_st_rate,
        coalesce(A.tot_in_qty,0) as tot_in_qty,
        coalesce(A.tot_sale_qty,0) as tot_sale_qty,
        A.sale_rate_qty,
        A.tot_in_cost_amt,
        A.tot_in_tag/A.tot_in_cost_amt as mark_up,
        coalesce(A.tot_in_tag, 0) as tot_in_tag,
        coalesce(A.tot_sale_tag,0) as tot_sale_tag,
        coalesce(A.tot_sale_amt,0) as tot_sale_amt,
        A.sale_rate_tag,
        A.sale_rate_amt,
        A.discount_rate,
        coalesce(A.inven_qty,0) as inven_qty,
        coalesce(A.inven_tag,0) as inven_tag,
        A.ttl_index,
        coalesce(B.monthly_sale_qty,0) as monthly_sale_qty,
        coalesce(B.monthly_sale_tag,0) as monthly_sale_tag,
        coalesce(B.monthly_sale_amt,0) as monthly_sale_amt,
        coalesce(C.last_week_sale_qty,0) as last_week_sale_qty,
        coalesce(C.last_week_sale_tag,0) as last_week_sale_tag,
        coalesce(C.last_week_sale_amt,0) as last_week_sale_amt,
        coalesce(C.last_week_sale_tag,0)/A.tot_in_tag as last_week_progress_rate,
        coalesce(D.this_week_sale_qty,0) as this_week_sale_qty,
        coalesce(D.this_week_sale_tag,0) as this_week_sale_tag,
        coalesce(D.this_week_sale_amt,0) as this_week_sale_amt,
        coalesce(D.this_week_sale_tag,0) /A.tot_in_tag as this_week_progress_rate
        FROM category_inout as A
        LEFT JOIN category_monthly as B ON A.cat_id = B.cat_id
        LEFT JOIN category_last_week as C ON A.cat_id = C.cat_id
        LEFT JOIN category_this_week as D ON A.cat_id = D.cat_id
        WHERE A.cat_id is not null
--         JOIN category_cum as F ON A.cat_id = F.cat_id
ORDER BY A.ttl_index asc, A.cat_id asc