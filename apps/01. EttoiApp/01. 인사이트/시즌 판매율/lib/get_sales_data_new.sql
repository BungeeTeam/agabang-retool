WITH
-- 변수
    '01' as brand_code,
    '{{season_select.value}}' as season_code,
    --'5' as sesn_code,
    toDate('{{date_select.value}}') as deadline_date,
    -- {{ p_season_code }} as season_code,
    -- toDate('{{ moment(p_deadline_date).format('YYYY-MM-DD') }}') as deadline_date,
    -- 시즌 상품 리스트 가져오기
    filtered_data as(
        SELECT
        distinct br_cd, sty_cd,col_cd,it,it_gb,item_md_category_id,cost_price,tag_price,
        CASE WHEN it_gb = '57' THEN '57' ELSE it END as cat_index
        FROM agabang_dw.dim_style
        WHERE br_cd = brand_code
        and concat(year_cd,season_cd) = season_code
    ),
    -- 마감기준일 기준 누적 입고, 출고 판매 수량/금액
    cum_sale_data as (
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
    -- 발주, 입고, 누적
    category_inout AS (
        SELECT
        -- 카테고리 이름 지정
        CASE WHEN A.cat_index = '1' THEN '시즌언더'
            WHEN A.cat_index = '2' THEN '시즌의류(B)'
            WHEN A.cat_index = '3' THEN '시즌의류(T)'
            WHEN A.cat_index = '5' THEN '기획의류'
            WHEN A.cat_index = '57' THEN '기획언더'
            WHEN A.cat_index = '6' THEN '출산용품(자체생산)'
            WHEN A.cat_index = '7' THEN '시즌용품'
            WHEN A.cat_index = '8' THEN '출산용품'
            WHEN A.cat_index = '9' THEN '판촉/부자재' ELSE '카테고리없음' END as cat_nm,
        max(A.item_md_category_id) as cat_id,
        -- 발주
        sum(C.plan_qty) as tot_ord_qty,
        sum(C.plan_tag_amt) as tot_ord_tag,
        sum(B.tot_in_qty) / sum(C.plan_qty) as in_rate_tag,
        count(C.plan_qty) as ord_st,
        -- 입/출고 스타일 카운트 방법 수정: 0이면 카운트 안되도록
        sum(case when B.tot_in_qty is not null then 1 else 0 end) as in_st,
        count(C.plan_qty) - sum(case when B.tot_in_qty > 0 then 1 else 0 end) as not_in_st,
        sum(case when B.tot_in_qty > 0 then 1 else 0 end)/count(C.plan_qty) as in_st_rate,
        sum(case when B.tot_out_qty > 0 then 1 else 0 end) as out_st,
        sum(case when B.tot_in_qty > 0 then 1 else 0 end) - sum(case when B.tot_out_qty > 0 then 1 else 0 end) as not_out_st,
        sum(case when B.tot_out_qty > 0 then 1 else 0 end)/sum(case when B.tot_in_qty > 0 then 1 else 0 end) as out_st_rate,
        -- 정상/기획 인덱스 부여
        CASE
            WHEN substring(max(A.sty_cd),5,1) in ('1','2','3','7')
            THEN 1 -- 정상
            WHEN substring(max(A.sty_cd),5,1) = '5'
            THEN 2 -- 기획
            ELSE 3 -- 나머지
        END as ttl_index
        FROM filtered_data as A
        LEFT JOIN cum_sale_data AS B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
        JOIN agabang_dw.prod_sales_stock_by_color as C ON A.sty_cd = C.sty_cd and A.col_cd = C.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
        GROUP BY A.cat_index
        ORDER BY 1
    ),
    -- 누적 판매 데이터
    category_cum AS(
        SELECT
        -- 카테고리 이름 지정
        CASE WHEN B.cat_index = '1' THEN '시즌언더'
            WHEN B.cat_index = '2' THEN '시즌의류(B)'
            WHEN B.cat_index = '3' THEN '시즌의류(T)'
            WHEN B.cat_index = '5' THEN '기획의류'
            WHEN B.cat_index = '57' THEN '기획언더'
            WHEN B.cat_index = '6' THEN '출산용품(자체생산)'
            WHEN B.cat_index = '7' THEN '시즌용품'
            WHEN B.cat_index = '8' THEN '출산용품'
            WHEN B.cat_index = '9' THEN '판촉/부자재' ELSE '카테고리없음' END as cat_nm,
        max(B.item_md_category_id) as cat_id,
        -- 판매개시 이래로 누적 입고, 판매
        sum(A.in_qty) as tot_in_qty,
        sum(A.sale_qty) as tot_sale_qty,
        sum(A.sale_qty)/sum(A.in_qty) as sale_rate_qty,
        sum(B.cost_price*A.in_qty)*1.1 as tot_in_cost_amt,
        sum(A.in_amt) as tot_in_tag,
        sum(A.sale_qty*B.tag_price) as tot_sale_tag,
        sum(A.sale_amt) as tot_sale_amt,
        sum(A.sale_qty*B.tag_price)/sum(A.in_amt) as sale_rate_tag,
        sum(A.sale_amt)/sum(A.in_amt) as sale_rate_amt,
        1-(sum(A.sale_amt)/sum(A.sale_qty*B.tag_price)) as discount_rate,
        sum(A.in_qty)-sum(A.sale_qty) as inven_qty,
        sum(A.in_amt)-sum(A.sale_qty*B.tag_price) as inven_tag
        FROM agabang_dw.daily_sales_by_color AS A
        JOIN filtered_data AS B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
            and A.sale_dt <= deadline_date
        GROUP BY B.cat_index
        ORDER BY 1
    ),
    -- 마감기준일이 포함된 월의 누적 매출
    category_monthly AS(
        SELECT
        -- 카테고리 이름 부여
        CASE WHEN B.cat_index = '1' THEN '시즌언더'
            WHEN B.cat_index = '2' THEN '시즌의류(B)'
            WHEN B.cat_index = '3' THEN '시즌의류(T)'
            WHEN B.cat_index = '5' THEN '기획의류'
            WHEN B.cat_index = '57' THEN '기획언더'
            WHEN B.cat_index = '6' THEN '출산용품(자체생산)'
            WHEN B.cat_index = '7' THEN '시즌용품'
            WHEN B.cat_index = '8' THEN '출산용품'
            WHEN B.cat_index = '9' THEN '판촉/부자재' ELSE '카테고리없음' END as cat_nm,
        max(B.item_md_category_id) as cat_id,
        -- 월 누적 판매
        sum(A.sale_qty) as monthly_sale_qty,
        sum(A.sale_qty * B.tag_price) as monthly_sale_tag,
        sum(A.sale_amt) as monthly_sale_amt
        FROM agabang_dw.daily_sales_by_color AS A
        JOIN filtered_data AS B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
            and toYear(toDate(A.sale_dt)) = toYear(deadline_date)
            and MONTH(toDate(A.sale_dt)) = MONTH(deadline_date)
            and A.sale_dt <= deadline_date
        GROUP BY B.cat_index
        ORDER BY 1
    ),
    -- 마감기준일 2주전 매출
    category_last_week AS(
        SELECT
        -- 카테고리 이름 부여
        CASE WHEN B.cat_index = '1' THEN '시즌언더'
            WHEN B.cat_index = '2' THEN '시즌의류(B)'
            WHEN B.cat_index = '3' THEN '시즌의류(T)'
            WHEN B.cat_index = '5' THEN '기획의류'
            WHEN B.cat_index = '57' THEN '기획언더'
            WHEN B.cat_index = '6' THEN '출산용품(자체생산)'
            WHEN B.cat_index = '7' THEN '시즌용품'
            WHEN B.cat_index = '8' THEN '출산용품'
            WHEN B.cat_index = '9' THEN '판촉/부자재' ELSE '카테고리없음' END as cat_nm,
        max(B.item_md_category_id) as cat_id,
        -- 주간 매출
        sum(A.sale_qty) as last_week_sale_qty,
        sum(A.sale_qty * B.tag_price) as last_week_sale_tag,
        sum(A.sale_amt) as last_week_sale_amt,
        sum(A.sale_qty * B.tag_price)/sum(A.in_amt) as last_week_progress_rate
        FROM agabang_dw.daily_sales_by_color AS A
        JOIN filtered_data AS B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
            and A.sale_dt between deadline_date - 13 and deadline_date - 7
        GROUP BY B.cat_index
        ORDER BY 1
    ),
    -- 마감기준일 포함 1주일 매출
    category_this_week AS(
        SELECT
        -- 카테고리 이름 부여
        CASE WHEN B.cat_index = '1' THEN '시즌언더'
            WHEN B.cat_index = '2' THEN '시즌의류(B)'
            WHEN B.cat_index = '3' THEN '시즌의류(T)'
            WHEN B.cat_index = '5' THEN '기획의류'
            WHEN B.cat_index = '57' THEN '기획언더'
            WHEN B.cat_index = '6' THEN '출산용품(자체생산)'
            WHEN B.cat_index = '7' THEN '시즌용품'
            WHEN B.cat_index = '8' THEN '출산용품'
            WHEN B.cat_index = '9' THEN '판촉/부자재' ELSE '카테고리없음' END as cat_nm,
        max(B.item_md_category_id) as cat_id,
        -- 주간매출
        sum(A.sale_qty) as this_week_sale_qty,
        sum(A.sale_qty * B.tag_price) as this_week_sale_tag,
        sum(A.sale_amt) as this_week_sale_amt,
        sum(A.sale_qty * B.tag_price)/sum(A.in_amt) as this_week_progress_rate
        FROM agabang_dw.daily_sales_by_color AS A
        JOIN filtered_data AS B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
        WHERE A.br_cd = brand_code
            and substring(A.sty_cd,3,2) = season_code
            and A.sale_dt between deadline_date - 6 and deadline_date
        GROUP BY B.cat_index
        ORDER BY 1
    )

       SELECT
        A.cat_nm as cat_nm,
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
        JOIN category_cum as F ON A.cat_id = F.cat_id
ORDER BY A.ttl_index asc, A.cat_id asc