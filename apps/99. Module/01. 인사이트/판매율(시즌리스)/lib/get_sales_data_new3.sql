WITH
-- 변수
    '{{brand_code.value}}' as brand_code,
    '{{p_sean_cd}}' as season_code,
    --'5' as sesn_code,
    toDate('{{date_select.value}}') as deadline_date,
    -- 발주, 입고, 누적
    category_inout AS (
        SELECT
        max(cat_raw_nm) as cat_nm,
        B.item_md_category_id as cat_id,
        -- 발주
        sum(A.plan_qty) as tot_ord_qty,
        sum(A.plan_tag_amt) as tot_ord_tag,
        sum(A.tot_in_qty) / sum(A.plan_qty) as in_rate_tag,
        -- 입고
        count(A.plan_qty) as ord_st,
        count(A.in_qty) as in_st,
        count(plan_qty) - count(A.in_qty) as not_in_st,
        count(A.in_qty)/count(plan_qty) as in_st_rate,
        count(A.out_qty) as out_st,
        count(A.in_qty) - count(A.out_qty) as not_out_st,
        count(A.out_qty)/count(A.in_qty) as out_st_rate,
        CASE
            WHEN substring(max(A.sty_cd),5,1) in ('1','2','3','7')
            THEN 1
            WHEN substring(max(A.sty_cd),5,1) in ('4','5') 
            THEN 2
            ELSE 3
        END as ttl_index
        FROM agabang_dw.prod_sales_stock_by_color as A
        JOIN agabang_dw.retooldb_item_md_info as B on A.sty_cd = B.sty_cd
        WHERE A.br_cd = brand_code
            -- and A.year_cd = year_code
            -- and A.sesn_cd = sesn_code
            and concat(A.year_cd,A.sesn_cd) = season_code
        GROUP BY B.item_md_category_id
        ORDER BY 1
    ),
    -- 누계
    category_cum AS(
        SELECT
        max(cat_raw_nm) as cat_nm,
        B.item_md_category_id as cat_id,
        --누계
        sum(A.in_qty) as tot_in_qty,
        sum(A.sale_qty) as tot_sale_qty,
        sum(A.sale_qty)/sum(A.in_qty) as sale_rate_qty,
        sum(C.cost_prce*A.in_qty)*1.1 as tot_in_cost_amt,
        sum(A.in_amt) as tot_in_tag,
        sum(A.sale_qty*C.tag_prce) as tot_sale_tag,
        sum(A.sale_amt) as tot_sale_amt,
        sum(A.sale_qty*C.tag_prce)/sum(A.in_amt) as sale_rate_tag,
        sum(A.sale_amt)/sum(A.in_amt) as sale_rate_amt,
        1-(sum(A.sale_amt)/sum(A.sale_qty*C.tag_prce)) as discount_rate,
        sum(A.in_qty)-sum(A.sale_qty) as inven_qty,
        sum(A.in_amt)-sum(A.sale_qty*C.tag_prce) as inven_tag
        FROM agabang_dw.daily_sales_by_color AS A
        JOIN agabang_dw.retooldb_item_md_info AS B ON A.sty_cd = B.sty_cd
        JOIN agabang_dw.prod_sales_stock_by_color AS C ON A.sty_cd = C.sty_cd and A.col_cd = C.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
            -- and substring(A.sty_cd,4,1) = sesn_code
--             and YEAR(toDate(A.sale_dt)) = YEAR(deadline_date - 6)
--             and MONTH(toDate(A.sale_dt)) = MONTH(deadline_date - 6)
            and A.sale_dt <= deadline_date
        GROUP BY B.item_md_category_id
        ORDER BY 1
    ),
    -- 월간
    category_monthly AS(
        SELECT
        max(cat_raw_nm) as cat_nm,
        B.item_md_category_id as cat_id,
        sum(A.sale_qty) as monthly_sale_qty,
        sum(A.sale_qty * C.tag_prce) as monthly_sale_tag,
        sum(A.sale_amt) as monthly_sale_amt
        FROM agabang_dw.daily_sales_by_color AS A
        JOIN agabang_dw.retooldb_item_md_info AS B ON A.sty_cd = B.sty_cd
        JOIN agabang_dw.prod_sales_stock_by_color AS C ON A.sty_cd = C.sty_cd and A.col_cd = C.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
            -- and substring(A.sty_cd,4,1) = sesn_code
            and YEAR(toDate(A.sale_dt)) = YEAR(deadline_date - 6)
            and MONTH(toDate(A.sale_dt)) = MONTH(deadline_date - 6)
            and A.sale_dt <= deadline_date
        GROUP BY B.item_md_category_id
        ORDER BY 1
    ),
    -- 지난주
    category_last_week AS(
        SELECT
        max(cat_raw_nm) as cat_nm,
        B.item_md_category_id as cat_id,
        sum(A.sale_qty) as last_week_sale_qty,
        sum(A.sale_qty * C.tag_prce) as last_week_sale_tag,
        sum(A.sale_amt) as last_week_sale_amt,
        sum(A.sale_qty * C.tag_prce)/sum(C.tot_in_tag_amt) as last_week_progress_rate
        FROM agabang_dw.daily_sales_by_color AS A
        JOIN agabang_dw.retooldb_item_md_info AS B ON A.sty_cd = B.sty_cd
        JOIN agabang_dw.prod_sales_stock_by_color AS C ON A.sty_cd = C.sty_cd and A.col_cd = C.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
            -- and substring(A.sty_cd,4,1) = sesn_code
            and A.sale_dt between deadline_date - 13 and deadline_date - 7
        GROUP BY B.item_md_category_id
        ORDER BY 1
    ),
    -- 이번주
    category_this_week AS(
        SELECT
        max(cat_raw_nm) as cat_nm,
        B.item_md_category_id as cat_id,
        sum(A.sale_qty) as this_week_sale_qty,
        sum(A.sale_qty * C.tag_prce) as this_week_sale_tag,
        sum(A.sale_amt) as this_week_sale_amt,
        sum(A.sale_qty * C.tag_prce)/sum(C.tot_in_tag_amt) as this_week_progress_rate
        FROM agabang_dw.daily_sales_by_color AS A
        JOIN agabang_dw.retooldb_item_md_info AS B ON A.sty_cd = B.sty_cd
        JOIN agabang_dw.prod_sales_stock_by_color AS C ON A.sty_cd = C.sty_cd and A.col_cd = C.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
            -- and substring(A.sty_cd,4,1) = sesn_code
            and A.sale_dt between deadline_date - 6 and deadline_date
        GROUP BY B.item_md_category_id
        ORDER BY 1
    )

       SELECT
        CASE WHEN E.cat_nm = '수영복/우비' THEN '기획의류'
            ELSE E.cat_nm END as cat_nm,
        A.cat_id as cat_id,
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
        F.tot_in_qty,
        F.tot_sale_qty,
        F.sale_rate_qty,
        F.tot_in_cost_amt,
        F.tot_in_tag/F.tot_in_cost_amt as mark_up,
        F.tot_in_tag,
        F.tot_sale_tag,
        F.tot_sale_amt,
        F.sale_rate_tag,
        F.sale_rate_amt,
        F.discount_rate,
        F.inven_qty,
        F.inven_tag,
        A.ttl_index,
        B.monthly_sale_qty,
        B.monthly_sale_tag,
        B.monthly_sale_amt,
        C.last_week_sale_qty,
        C.last_week_sale_tag,
        C.last_week_sale_amt,
        C.last_week_progress_rate,
        D.this_week_sale_qty,
        D.this_week_sale_tag,
        D.this_week_sale_amt,
        D.this_week_progress_rate
        FROM category_inout as A
        JOIN category_monthly as B ON A.cat_id = B.cat_id
        JOIN category_last_week as C ON A.cat_id = C.cat_id
        JOIN category_this_week as D ON A.cat_id = D.cat_id
        JOIN agabang_dw.retooldb_item_md_category as E on A.cat_id = E.id
        JOIN category_cum as F ON A.cat_id = F.cat_id
ORDER BY A.ttl_index asc, A.cat_id asc