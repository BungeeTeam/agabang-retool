WITH
    toDate('{{dateRange.value?.start }}') as start_date,
    toDate('{{dateRange.value?.end }}') as end_date,
    addYears(start_date, -1) as prev_start_date,
    addYears(end_date, -1) as prev_end_date,
    addYears(start_date, -2) as sale_start_date,
    ({{ bizSelect.value.map(i => `'${i}'`).join(',') }}) as biz_code,
    ({{ brandMultiSelect.value.map(i => `'${i}'`).join(',') }}) as brand_code,
    '{{ varShopSalesSummary.value?.category_name }}' as selected_category_name,
    ({{tabs1.value==='합계' ? `'오프라인', '온라인'`:`'${tabs1.value}'`}}) as selected_onoff_flag,

    RelevantSeasons AS (
        SELECT DISTINCT
            'CURR' as period_type, year_cd, season_cd
        FROM agabang_dw.daily_shop_sales_by_dimension
        WHERE sales_type = '정상'
          AND sale_dt BETWEEN start_date AND end_date 
          AND biz_cd in biz_code
          AND br_cd in brand_code
        UNION ALL
        SELECT DISTINCT
            'PREV' as period_type, year_cd, season_cd
        FROM agabang_dw.daily_shop_sales_by_dimension
        WHERE sales_type = '정상'
          AND sale_dt BETWEEN prev_start_date AND prev_end_date 
          AND biz_cd in biz_code
          AND br_cd in brand_code
    ),

    CategoryMapper AS (
        SELECT 
            '1' as item_code, '시즌언더' as category_name, 2 as sort_order
        UNION ALL SELECT '2', '시즌의류(B)', 0
        UNION ALL SELECT '3', '시즌의류(T)', 1  
        UNION ALL SELECT '4', '파자마', 4
        UNION ALL SELECT '57', '기획언더', 6
        UNION ALL SELECT '5', '기획의류', 5
        UNION ALL SELECT '6', '위탁용품', 7
        UNION ALL SELECT '7', '시즌용품', 3
        UNION ALL SELECT '8', '일반용품', 8
        UNION ALL SELECT '9', '판촉부자재', 9
    ),


    AllOutRtn AS (
        SELECT
            COALESCE(D.shop_cd, A.shop_cd) as shop_cd,
            COALESCE(D.shop_nm, B.shop_nm) as shop_nm,
            CASE 
                WHEN selected_category_name = '총계' THEN '총계'
                ELSE COALESCE(CM.category_name, '기타')
            END as category_name,
                  sum(CASE WHEN RS.period_type = 'CURR' AND toDate(A.wrk_dt) <= toDate(end_date)
                     THEN (CASE WHEN A.io_type = 'O' THEN A.out_qty 
                                WHEN A.rt_yn = 'Y' THEN A.out_qty * -1
                                ELSE 0 END)
                     ELSE 0 END) as cur_out_qty,
            sum(CASE WHEN RS.period_type = 'CURR' AND toDate(A.wrk_dt) <= toDate(end_date)
                     THEN (CASE WHEN A.io_type = 'O' THEN A.out_qty*A.sale_prce 
                                WHEN A.rt_yn = 'Y' THEN A.out_qty*A.sale_prce * -1
                                ELSE 0 END)
                     ELSE 0 END) as cur_sup_amt,
            sum(CASE WHEN RS.period_type = 'PREV' AND toDate(A.wrk_dt) <= toDate(addYears(end_date, -1))
                     THEN (CASE WHEN A.io_type = 'O' THEN A.out_qty 
                                WHEN A.rt_yn = 'Y' THEN A.out_qty * -1
                                ELSE 0 END)
                     ELSE 0 END) as prev_out_qty,
            sum(CASE WHEN RS.period_type = 'PREV' AND toDate(A.wrk_dt) <= toDate(addYears(end_date, -1))
                     THEN (CASE WHEN A.io_type = 'O' THEN A.out_qty*A.sale_prce 
                                WHEN A.rt_yn = 'Y' THEN A.out_qty*A.sale_prce * -1
                                ELSE 0 END)
                     ELSE 0 END) as prev_sup_amt
        FROM agabang.dsoutrtn as A
        JOIN RelevantSeasons RS ON A.year_cd = RS.year_cd AND A.sesn_cd = RS.season_cd
        JOIN ( SELECT DISTINCT shop_cd, shop_nm, br_cd, biz_cd, team_cd, onoff_flag FROM agabang_dw.dim_shop ) AS B ON A.shop_cd = B.shop_cd AND A.br_cd = B.br_cd
        LEFT JOIN agabang_dw.retooldb_shop_handover AS D ON A.shop_cd = D.prev_shop_cd
        LEFT JOIN CategoryMapper CM ON (
            CASE 
                WHEN substring(A.item,1,2) = '57' THEN '57'
                ELSE substring(A.item,1,1) 
            END = CM.item_code
        )
        WHERE
            B.biz_cd in biz_code
            AND A.br_cd in brand_code
            AND substring(A.item,1,1) not in ('6', '8', '9') 
            AND B.onoff_flag in selected_onoff_flag
            AND toDate(A.wrk_dt) >= addYears(start_date, -3)
        GROUP BY shop_cd, shop_nm, category_name
    ),


    AllSales AS (
        SELECT
          shop_cd,
          shop_nm as shop_nm,
          CASE 
                WHEN selected_category_name = '총계' THEN '총계'
                ELSE COALESCE(CM.category_name, '기타')
            END as category_name,
          sum(CASE WHEN sale_dt BETWEEN start_date AND end_date THEN sales_qty ELSE 0 END) as cur_qty,
          sum(CASE WHEN sale_dt BETWEEN prev_end_date AND end_date THEN sales_qty ELSE 0 END) as cur_tot_qty,
          sum(CASE WHEN sale_dt BETWEEN start_date AND end_date THEN sales_price ELSE 0 END) as cur_rev,
          sum(CASE WHEN sale_dt BETWEEN prev_end_date AND end_date THEN sales_price ELSE 0 END) as cur_tot_rev,
          sum(CASE WHEN sale_dt BETWEEN start_date AND end_date THEN sales_qty*tag_price ELSE 0 END) as cur_tag,
          sum(CASE WHEN sale_dt BETWEEN prev_end_date AND end_date THEN sales_qty*tag_price ELSE 0 END) as cur_tot_tag,
          sum(CASE WHEN sale_dt BETWEEN start_date AND end_date THEN cost_price * sales_qty ELSE 0 END) as cur_cost,
          sum(CASE WHEN sale_dt BETWEEN prev_start_date AND prev_end_date THEN sales_qty ELSE 0 END) as prev_qty,
          sum(CASE WHEN sale_dt <= prev_end_date THEN sales_qty ELSE 0 END) as prev_tot_qty,
          sum(CASE WHEN sale_dt BETWEEN prev_start_date AND prev_end_date THEN sales_price ELSE 0 END) as prev_rev,
          sum(CASE WHEN sale_dt <= prev_end_date THEN sales_price ELSE 0 END) as prev_tot_rev,
          sum(CASE WHEN sale_dt BETWEEN prev_start_date AND prev_end_date THEN sales_qty*tag_price ELSE 0 END) as prev_tag,
          sum(CASE WHEN sale_dt <= prev_end_date THEN sales_qty*tag_price ELSE 0 END) as prev_tot_tag,
          sum(CASE WHEN sale_dt BETWEEN prev_start_date AND prev_end_date THEN cost_price * sales_qty ELSE 0 END) as prev_cost
        FROM agabang_dw.daily_shop_sales_by_dimension A
        LEFT JOIN CategoryMapper CM ON (
            CASE 
                WHEN substring(A.item,1,2) = '57' THEN '57'
                ELSE substring(A.item,1,1) 
            END = CM.item_code
        )
        WHERE sale_dt BETWEEN sale_start_date and end_date
          AND sales_type = '정상'
          AND season_cd in ('1','3','5','7','0') AND biz_cd in biz_code
          AND br_cd in brand_code AND onoff_flag in selected_onoff_flag
        GROUP BY shop_cd, shop_nm, category_name
    )


SELECT
    COALESCE(S.shop_cd, O.shop_cd) as shop_cd,
    COALESCE(S.shop_nm, O.shop_nm) as shop_nm,
    COALESCE(S.category_name, O.category_name) as category_name,

    S.cur_qty, S.cur_rev, S.cur_tag, S.cur_cost,
    S.cur_tot_qty, S.cur_tot_rev, S.cur_tot_tag,
    O.cur_out_qty, O.cur_sup_amt,

    CASE WHEN S.cur_tag = 0 THEN 0 ELSE 1 - S.cur_rev / S.cur_tag END as cur_discount_rate,  
    CASE WHEN O.cur_out_qty = 0 THEN 0 ELSE S.cur_tot_qty / O.cur_out_qty END as cur_sale_rate_qty, 
    CASE WHEN O.cur_sup_amt = 0 THEN 0 ELSE S.cur_tot_rev / O.cur_sup_amt END as cur_sale_rate_amt, 

    S.prev_rev, S.prev_tag,S.prev_qty, S.prev_cost, 
    S.prev_tot_rev, S.prev_tot_tag, S.prev_tot_qty,
    O.prev_out_qty, O.prev_sup_amt,

    CASE WHEN O.prev_out_qty = 0 THEN 0 ELSE S.prev_tot_qty / O.prev_out_qty END as prev_sale_rate_qty, 
    CASE WHEN O.prev_sup_amt = 0 THEN 0 ELSE S.prev_tot_rev / O.prev_sup_amt END as prev_sale_rate_amt 

FROM AllSales as S
FULL OUTER JOIN AllOutRtn AS O ON S.shop_cd = O.shop_cd and S.category_name = O.category_name
WHERE S.category_name = selected_category_name
ORDER BY shop_cd, category_name;