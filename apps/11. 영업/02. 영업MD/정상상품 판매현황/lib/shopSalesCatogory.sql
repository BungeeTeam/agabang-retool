WITH
    toDate('{{dateRange.value?.start }}') as start_date,
    toDate('{{dateRange.value?.end }}') as end_date,
    addYears(start_date, -1) as prev_start_date,
    addYears(end_date, -1) as prev_end_date,
    addYears(start_date, -2) as sale_start_date,
    {{ bizSelect.value.map(i => `'${i}'`).join(',') }} as biz_code,
    {{ brandMultiSelect.value.map(i => `'${i}'`).join(',') }} as brand_code,
    '{{ varShopSalesCatogory.value?.category_name }}' as selected_category_name,
    '{{ varShopSalesCatogory.value?.season_nm }}' as selected_season_nm,
    {{tabs1.value==='합계' ? `'오프라인', '온라인'`:`'${tabs1.value}'`}} as selected_onoff_flag,

    RelevantSeasons AS (
        SELECT DISTINCT
            'CURR' as period_type, year_cd, season_cd
        FROM agabang_dw.daily_shop_sales_by_dimension
        WHERE sales_type = '정상'
          AND sale_dt BETWEEN start_date AND end_date 
          AND biz_cd in (biz_code)
          AND br_cd in (brand_code)
        UNION ALL
        SELECT DISTINCT
            'PREV' as period_type, year_cd, season_cd
        FROM agabang_dw.daily_shop_sales_by_dimension
        WHERE sales_type = '정상'
          AND sale_dt BETWEEN prev_start_date AND prev_end_date 
          AND biz_cd in (biz_code)
          AND br_cd in (brand_code)
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
            sesn_cd as season_cd,
            CASE 
                WHEN selected_category_name = '소계' THEN '소계'
                ELSE COALESCE(CM.category_name, '기타')
            END as category_name,
            sum(CASE WHEN RS.period_type = 'CURR' AND toDate(A.wrk_dt) <= toDate(end_date)
                     THEN (CASE WHEN A.io_type = 'O' THEN A.out_qty 
                                WHEN A.rt_yn = 'Y' THEN  A.out_qty * -1 
                                ELSE 0 END)
                     ELSE 0 END) as cur_out_qty,
            sum(CASE WHEN RS.period_type = 'CURR' AND toDate(A.wrk_dt) <= toDate(end_date)
                     THEN (CASE WHEN A.io_type = 'O' THEN (A.out_qty*A.sale_prce) 
                                WHEN A.rt_yn = 'Y' THEN (A.out_qty*A.sale_prce * -1)
                                ELSE 0 END)
                     ELSE 0 END) as cur_sup_amt,
            sum(CASE WHEN RS.period_type = 'PREV' AND toDate(A.wrk_dt) <= toDate(addYears(end_date, -1))
                     THEN (CASE WHEN A.io_type = 'O' THEN A.out_qty 
                                WHEN A.rt_yn = 'Y' THEN  A.out_qty * -1 
                                ELSE 0 END)
                     ELSE 0 END) as prev_out_qty,
            sum(CASE WHEN RS.period_type = 'PREV' AND toDate(A.wrk_dt) <= toDate(addYears(end_date, -1))
                     THEN (CASE WHEN A.io_type = 'O' THEN (A.out_qty*A.sale_prce) 
                                WHEN A.rt_yn = 'Y' THEN (A.out_qty*A.sale_prce * -1)
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
            B.biz_cd in (biz_code)
            AND A.br_cd in (brand_code)
            AND substring(A.item,1,1) not in ('6', '8', '9') 
            AND B.onoff_flag in (selected_onoff_flag)
            AND toDate(A.wrk_dt) >= addYears(start_date, -3)
        GROUP BY shop_cd, shop_nm, sesn_cd, category_name
    ),


    AllSales AS (
        SELECT
          shop_cd,
          shop_nm as shop_nm,
          season_cd,
          season_nm,
          CASE 
                WHEN selected_category_name = '소계' THEN '소계'
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
        FROM agabang_dw.daily_shop_sales_by_dimension as A
        LEFT JOIN CategoryMapper CM ON (
            CASE 
                WHEN substring(A.item,1,2) = '57' THEN '57'
                ELSE substring(A.item,1,1) 
            END = CM.item_code
        )
         WHERE sale_dt BETWEEN sale_start_date and end_date
          AND sales_type = '정상'
          AND season_cd in ('1','3','5','7','0') AND biz_cd in biz_code
          AND br_cd in brand_code AND onoff_flag in (selected_onoff_flag)
        GROUP BY shop_cd, shop_nm, season_cd, season_nm, category_name
    )


SELECT
    COALESCE(S.shop_cd, O.shop_cd) as shop_cd,
    COALESCE(S.shop_nm, O.shop_nm) as shop_nm,
    COALESCE(S.category_name, O.category_name) as category_name,

    S.cur_qty, S.cur_rev, S.cur_tag, S.cur_cost,
    S.cur_tot_qty, S.cur_tot_rev,
    O.cur_out_qty, O.cur_sup_amt,

    CASE WHEN S.cur_tag = 0 THEN 0 ELSE 1 - S.cur_rev / S.cur_tag END as cur_discount_rate,  -- 할인율
    CASE WHEN O.cur_out_qty = 0 THEN 0 ELSE S.cur_tot_qty / O.cur_out_qty END as cur_sale_rate_qty, -- 금년 수량기준 판매율
    CASE WHEN O.cur_sup_amt = 0 THEN 0 ELSE S.cur_tot_rev / O.cur_sup_amt END as cur_sale_rate_amt, -- 금년 실판가 기준 판매율

    S.prev_rev, S.prev_qty, S.prev_tag, S.prev_cost, 
    S.prev_tot_rev, S.prev_tot_qty,
    O.prev_out_qty, O.prev_sup_amt,

    CASE WHEN O.prev_out_qty = 0 THEN 0 ELSE S.prev_tot_qty / O.prev_out_qty END as prev_sale_rate_qty, -- 작년 수량기준 판매율
    CASE WHEN O.prev_sup_amt = 0 THEN 0 ELSE S.prev_tot_rev / O.prev_sup_amt END as prev_sale_rate_amt -- 작년 실판가 기준 판매율

FROM AllSales as S
FULL OUTER JOIN AllOutRtn AS O ON S.shop_cd = O.shop_cd and S.category_name = O.category_name and O.season_cd = S.season_cd
WHERE S.category_name = selected_category_name
and season_nm = selected_season_nm
ORDER BY cur_rev desc;

-- WITH
--     '{{dateRange.value?.start }}' as start_date,
--     '{{dateRange.value?.end }}' as end_date,
--     ({{ bizSelect.value.map(i => `'${i}'`).join(',') }}) as biz_code,
--     ({{ brandMultiSelect.value.map(i => `'${i}'`).join(',') }}) as brand_code,

--     RelevantSeasons AS (
--         SELECT DISTINCT
--             'CURR' as period_type, year_cd, season_cd
--         FROM agabang_dw.daily_shop_sales_by_dimension
--         WHERE (sale_dt <= season_end_dt OR (season_cd = '0' AND cast(replace(year_nm, '이하', '') as int) >= toYear(sale_dt) - 2))
--           AND sale_dt BETWEEN toDate(start_date) AND toDate(end_date) AND biz_cd in biz_code AND team_cd != '05'
--           AND br_cd in brand_code AND it not in ('6', '8', '9')
--         UNION ALL
--         SELECT DISTINCT
--             'PREV' as period_type, year_cd, season_cd
--         FROM agabang_dw.daily_shop_sales_by_dimension
--         WHERE (sale_dt <= season_end_dt OR (season_cd = '0' AND cast(replace(year_nm, '이하', '') as int) >= toYear(sale_dt) - 2))
--           AND sale_dt BETWEEN toDate(addYears(start_date, -1)) AND toDate(addYears(end_date, -1)) AND biz_cd in biz_code AND team_cd != '05'
--           AND br_cd in brand_code AND it not in ('6', '8','9')-- AND team_cd != '60'
--     ),


--     AllOutRtn AS (
--         SELECT
--             COALESCE(D.shop_cd, A.shop_cd) as shop_cd,
--             MAX(COALESCE(D.shop_nm, B.shop_nm)) as shop_nm,
--             sesn_cd as season_cd,
--             {{ varShopSalesCatogory.value?.category_name === '소계' ? `'소계'` :  `CASE WHEN substring(item,1,1) = '1' THEN '시즌언더'
--     WHEN substring(item,1,1) = '2' THEN '시즌의류(B)'
--     WHEN substring(item,1,1) = '3' THEN '시즌의류(T)'
--     WHEN substring(item,1,1) = '4' THEN '파자마'
--     WHEN substring(item,1,1) = '5' AND substring(item,1,2) = '57' THEN '기획언더'
--     WHEN substring(item,1,1) = '5' THEN '기획의류'
--     WHEN substring(item,1,1) = '6' THEN '위탁용품'
--     WHEN substring(item,1,1) = '7' THEN '시즌용품'
--     WHEN substring(item,1,1) = '8' THEN '일반용품'
--     WHEN substring(item,1,1) = '9' THEN '판촉부자재'
--   ELSE '기타' END` }} as category_name,
--             sum(CASE WHEN RS.period_type = 'CURR' AND toDate(A.wrk_dt) <= toDate(end_date)
--                      THEN (CASE WHEN A.io_type = 'O' THEN A.out_qty 
--                                 WHEN A.rt_yn = 'Y' THEN  A.out_qty * -1 
--                                 ELSE 0 END)
--                      ELSE 0 END) as cur_out_qty,
--             sum(CASE WHEN RS.period_type = 'CURR' AND toDate(A.wrk_dt) <= toDate(end_date)
--                      THEN (CASE WHEN A.io_type = 'O' THEN (A.out_qty*A.sale_prce) 
--                                 WHEN A.rt_yn = 'Y' THEN (A.out_qty*A.sale_prce * -1)
--                                 ELSE 0 END)
--                      ELSE 0 END) as cur_sup_amt,
--             sum(CASE WHEN RS.period_type = 'PREV' AND toDate(A.wrk_dt) <= toDate(addYears(end_date, -1))
--                      THEN (CASE WHEN A.io_type = 'O' THEN A.out_qty 
--                                 WHEN A.rt_yn = 'Y' THEN  A.out_qty * -1 
--                                 ELSE 0 END)
--                      ELSE 0 END) as prev_out_qty,
--             sum(CASE WHEN RS.period_type = 'PREV' AND toDate(A.wrk_dt) <= toDate(addYears(end_date, -1))
--                      THEN (CASE WHEN A.io_type = 'O' THEN (A.out_qty*A.sale_prce) 
--                                 WHEN A.rt_yn = 'Y' THEN (A.out_qty*A.sale_prce * -1)
--                                 ELSE 0 END)
--                      ELSE 0 END) as prev_sup_amt
--         FROM agabang.dsoutrtn as A
--         JOIN RelevantSeasons RS ON A.year_cd = RS.year_cd AND A.sesn_cd = RS.season_cd
--         JOIN ( SELECT DISTINCT shop_cd, shop_nm, br_cd, biz_cd, team_cd, onoff_flag FROM agabang_dw.dim_shop ) AS B ON A.shop_cd = B.shop_cd AND A.br_cd = B.br_cd
--         LEFT JOIN agabang_dw.retooldb_shop_handover AS D ON A.shop_cd = D.prev_shop_cd
--         WHERE 
--             B.biz_cd in biz_code AND B.team_cd != '05' AND A.br_cd in brand_code
--             AND substring(item,1,1) not in ('6', '8','9') AND B.onoff_flag in ({{tabs1.value==='합계' ? `'오프라인', '온라인'`:`'${tabs1.value}'`}}) 
--             AND toDate(wrk_dt) >= toDate(addYears(start_date, -3))
--         GROUP BY shop_cd, sesn_cd, category_name
--     ),


--     AllSales AS (
--         SELECT
--           shop_cd,
--           shop_nm as shop_nm,
--           season_cd,
--           season_nm,
--           {{ varShopSalesCatogory.value?.category_name === '소계' ? `'소계'` :  `CASE WHEN substring(item,1,1) = '1' THEN '시즌언더'
--     WHEN substring(item,1,1) = '2' THEN '시즌의류(B)'
--     WHEN substring(item,1,1) = '3' THEN '시즌의류(T)'
--     WHEN substring(item,1,1) = '4' THEN '파자마'
--     WHEN substring(item,1,1) = '5' AND substring(item,1,2) = '57' THEN '기획언더'
--     WHEN substring(item,1,1) = '5' THEN '기획의류'
--     WHEN substring(item,1,1) = '6' THEN '위탁용품'
--     WHEN substring(item,1,1) = '7' THEN '시즌용품'
--     WHEN substring(item,1,1) = '8' THEN '일반용품'
--     WHEN substring(item,1,1) = '9' THEN '판촉부자재'
--   ELSE '기타' END` }} as category_name,
--           cast(sum(CASE WHEN sale_dt BETWEEN toDate(start_date) AND toDate(end_date) THEN sales_qty ELSE 0 END) as int) as cur_qty,
--           cast(sum(CASE WHEN sale_dt BETWEEN toDate(start_date) AND toDate(end_date) THEN sales_price ELSE 0 END) as int) as cur_rev,
--           cast(sum(CASE WHEN sale_dt BETWEEN toDate(start_date) AND toDate(end_date) THEN sales_qty*tag_price ELSE 0 END) as int) as cur_tag,
--           cast(sum(CASE WHEN sale_dt BETWEEN toDate(start_date) AND toDate(end_date) THEN cost_price * sales_qty ELSE 0 END) as int) as cur_cost,
--           cast(sum(CASE WHEN sale_dt BETWEEN toDate(addYears(end_date, -1)) AND toDate(end_date) THEN sales_qty ELSE 0 END) as int) as cur_tot_qty,
--           cast(sum(CASE WHEN sale_dt BETWEEN toDate(addYears(end_date, -1)) AND toDate(end_date) THEN sales_price ELSE 0 END) as int) as cur_tot_rev,
--           cast(sum(CASE WHEN sale_dt BETWEEN toDate(addYears(start_date, -1)) AND toDate(addYears(end_date, -1)) THEN sales_qty ELSE 0 END) as int) as prev_qty,
--           cast(sum(CASE WHEN sale_dt BETWEEN toDate(addYears(start_date, -1)) AND toDate(addYears(end_date, -1)) THEN sales_price ELSE 0 END) as int) as prev_rev,
--           cast(sum(CASE WHEN sale_dt BETWEEN toDate(addYears(start_date, -1)) AND toDate(addYears(end_date, -1)) THEN sales_qty*tag_price ELSE 0 END) as int) as prev_tag,
--           cast(sum(CASE WHEN sale_dt BETWEEN toDate(addYears(start_date, -1)) AND toDate(addYears(end_date, -1)) THEN cost_price * sales_qty ELSE 0 END) as int) as prev_cost,
--           cast(sum(CASE WHEN sale_dt <= toDate(addYears(end_date, -1)) THEN sales_qty ELSE 0 END) as int) as prev_tot_qty,
--           cast(sum(CASE WHEN sale_dt <= toDate(addYears(end_date, -1)) THEN sales_price ELSE 0 END) as int) as prev_tot_rev
--         FROM agabang_dw.daily_shop_sales_by_dimension
--         WHERE sale_dt BETWEEN toDate(addYears(start_date, -2)) and toDate(end_date)
--           -- AND it not in ('6', '8','9')
--           -- AND (sale_dt <= season_end_dt OR (season_cd = '0' AND cast(replace(year_nm, '이하', '') as int) >= toYear(sale_dt) - 2))
--           AND sales_type = '정상'
--           AND season_cd in ('1','3','5','7','0') AND biz_cd in biz_code
--           AND br_cd in brand_code AND onoff_flag in ({{tabs1.value==='합계' ? `'오프라인', '온라인'`:`'${tabs1.value}'`}}) 
--         GROUP BY shop_cd, shop_nm, season_cd, season_nm, category_name
--     )


-- SELECT
--     COALESCE(S.shop_cd, O.shop_cd) as shop_cd,
--     COALESCE(S.shop_nm, O.shop_nm) as shop_nm,
--     COALESCE(S.category_name, O.category_name) as category_name,

--     S.cur_qty, S.cur_rev, S.cur_tag, S.cur_cost,
--     S.cur_tot_qty, S.cur_tot_rev,
--     O.cur_out_qty, O.cur_sup_amt,

--     CASE WHEN S.cur_tag = 0 THEN 0 ELSE 1 - S.cur_rev / S.cur_tag END as cur_discount_rate,  -- 할인율
--     CASE WHEN O.cur_out_qty = 0 THEN 0 ELSE S.cur_tot_qty / O.cur_out_qty END as cur_sale_rate_qty, -- 금년 수량기준 판매율
--     CASE WHEN O.cur_sup_amt = 0 THEN 0 ELSE S.cur_tot_rev / O.cur_sup_amt END as cur_sale_rate_amt, -- 금년 실판가 기준 판매율

--     S.prev_rev, S.prev_qty, S.prev_tag, S.prev_cost, 
--     S.prev_tot_rev, S.prev_tot_qty,
--     O.prev_out_qty, O.prev_sup_amt,

--     CASE WHEN O.prev_out_qty = 0 THEN 0 ELSE S.prev_tot_qty / O.prev_out_qty END as prev_sale_rate_qty, -- 작년 수량기준 판매율
--     CASE WHEN O.prev_sup_amt = 0 THEN 0 ELSE S.prev_tot_rev / O.prev_sup_amt END as prev_sale_rate_amt -- 작년 실판가 기준 판매율

-- FROM AllSales as S
-- FULL OUTER JOIN AllOutRtn AS O ON S.shop_cd = O.shop_cd and S.category_name = O.category_name and O.season_cd = S.season_cd
-- WHERE S.category_name = '{{ varShopSalesCatogory.value?.category_name }}' and season_nm = '{{ varShopSalesCatogory.value?.season_nm }}'
-- ORDER BY cur_rev desc;


-- -- WITH
-- --     dsoutrtnBase as (SELECT distinct COALESCE(D.new_shop_cd, A.shop_cd) as shop_cd,
-- --                                      COALESCE(D.new_shop_nm, B.shop_nm) as shop_nm,
-- --   A.sesn_cd as season_cd,
-- --                                         {{ varShopSalesCatogory.value?.category_name === '소계' ? `'소계'` :  `CASE WHEN substring(item,1,1) = '1' THEN '시즌언더'
-- --     WHEN substring(item,1,1) = '2' THEN '시즌의류(B)'
-- --     WHEN substring(item,1,1) = '3' THEN '시즌의류(T)'
-- --     WHEN substring(item,1,1) = '4' THEN '파자마'
-- --     WHEN substring(item,1,1) = '5' AND substring(item,1,2) = '57' THEN '기획언더'
-- --     WHEN substring(item,1,1) = '5' THEN '기획의류'
-- --     WHEN substring(item,1,1) = '6' THEN '위탁용품'
-- --     WHEN substring(item,1,1) = '7' THEN '시즌용품'
-- --     WHEN substring(item,1,1) = '8' THEN '일반용품'
-- --     WHEN substring(item,1,1) = '9' THEN '판촉부자재'
-- --   ELSE '기타' END` }} as category_name,
-- --                                      sum(CASE WHEN io_type = 'O' THEN out_qty ELSE out_qty * (-1) END) as out_qty,
-- --                                      sum(CASE WHEN io_type = 'O' THEN sup_amt ELSE sup_amt * (-1) END) as sup_amt
-- --                      FROM agabang.dsoutrtn as A
-- --                               JOIN (
-- --                          SELECT DISTINCT shop_cd,
-- --                                          shop_nm,
-- --                                          br_cd,
-- --                                          br_nm,
-- --                                          CASE
-- --                                              WHEN biz_cd = 'A2' THEN 'A1'
-- --                                              ELSE biz_cd
-- --                                              END as biz_cd,
-- --                                          CASE
-- --                                              WHEN biz_nm = '디어베이비사업부' THEN '아가방사업부'
-- --                                              ELSE biz_nm
-- --                                              END as biz_nm,
-- --                                          tp_cd,
-- --                                          tp_nm,
-- --                                          team_cd,
-- --                                          onoff_flag
-- --                          FROM agabang_dw.dim_shop
-- --                          ) AS B ON A.shop_cd = B.shop_cd AND A.br_cd = B.br_cd
-- --                         LEFT JOIN (
-- --                          SELECT DISTINCT shop_cd as new_shop_cd,
-- --                                          shop_nm as new_shop_nm,
-- --                                          prev_shop_cd,
-- --                                          prev_shop_nm
-- --                          FROM agabang_dw.retooldb_shop_handover) AS D ON A.shop_cd = D.prev_shop_cd

-- --                      WHERE
-- --                        -- 판매 마감일로부터 1년치 입출고량 가져오기
-- --                          toDate(wrk_dt) between toDate(addYears('{{dateRange.value?.end }}', -1)) and toDate('{{dateRange.value?.end }}')
-- --                        -- biz_cd
-- --                        AND B.biz_cd in ({{ bizSelect.value.map(i => `'${i}'`).join(',') }})
-- --                        AND B.team_cd != '05'
-- --                        -- 브랜드코드
-- --                        AND A.br_cd in ({{ brandMultiSelect.value.map(i => `'${i}'`).join(',') }})
-- --                        -- 용품 제거
-- --                        AND substring(item,1,1) not in ('6', '8')
-- --                        -- 정상 판매에 해당하는 year_cd
-- --                        AND A.year_cd IN (SELECT distinct year_cd
-- --                                          FROM agabang_dw.daily_shop_sales_by_dimension
-- --                                          WHERE (sale_dt <= season_end_dt OR (season_cd = '0' AND
-- --                                                                              cast(replace(year_nm, '이하', '') as int) >=
-- --                                                                              toYear(sale_dt) - 2))
-- --                                            AND sale_dt BETWEEN toDate('{{dateRange.value?.start }}') AND toDate('{{dateRange.value?.end }}'))
-- --                        -- 정상 판매에 해당하는 season_cd
-- --                        AND A.sesn_cd IN (SELECT distinct season_cd
-- --                                          FROM agabang_dw.daily_shop_sales_by_dimension
-- --                                          WHERE (sale_dt <= season_end_dt OR (season_cd = '0' AND
-- --                                                                              cast(replace(year_nm, '이하', '') as int) >=
-- --                                                                              toYear(sale_dt) - 2))
-- --                                            AND sale_dt BETWEEN toDate('{{dateRange.value?.start }}') AND toDate('{{dateRange.value?.end }}'))
-- --                         AND onoff_flag in ({{tabs1.value==='합계' ? `'오프라인', '온라인'`:`'${tabs1.value}'`}})

-- --                      GROUP BY shop_cd, shop_nm, category_name,season_cd),
                       
-- --     base_tbl as (SELECT
-- --   YEAR(sale_dt) as year_unit,
-- --   sum(sales_qty) as qty,                     
-- --   sum(sales_price) as rev,
-- --   sum(sales_qty*tag_price) as tag,
-- --   sum(cost_price) as cost,
-- --   shop_cd,
-- --   shop_nm,
-- --   season_cd,
-- --   season_nm,
-- --   -- CASE WHEN it in ('1','4') THEN '기초정상'
-- --   --   WHEN it = '5' AND it_gb = '57' THEN '기획내의'
-- --   --   WHEN it = '5' THEN '기획의류'
-- --   --   WHEN it = '7' THEN '시즌용품'
-- --   --   WHEN it in ('2','3') THEN '정상의류'
-- --   --   WHEN it = '9' THEN '판촉물/부자재'
-- --   -- ELSE '기타' END as category_name
-- --      {{ varShopSalesCatogory.value?.category_name === '소계' ? `'소계'` :  `CASE WHEN it = '1' THEN '시즌언더'
-- --     WHEN it = '2' THEN '시즌의류(B)'
-- --     WHEN it = '3' THEN '시즌의류(T)'
-- --     WHEN it = '4' THEN '파자마'
-- --     WHEN it = '5' AND it_gb = '57' THEN '기획언더'
-- --     WHEN it = '5' THEN '기획의류'
-- --     WHEN it = '6' THEN '위탁용품'
-- --     WHEN it = '7' THEN '시즌용품'
-- --     WHEN it = '8' THEN '일반용품'
-- --     WHEN it = '9' THEN '판촉부자재'
-- --   ELSE '기타' END` }} as category_name
-- -- FROM agabang_dw.daily_shop_sales_by_dimension
-- -- WHERE
-- --   sale_dt BETWEEN toDate('{{dateRange.value.start }}') AND toDate('{{dateRange.value.end}}')
-- -- AND team_cd != '05'
-- -- AND it not in ('6', '8') AND (sale_dt <= season_end_dt OR  (season_cd = '0' AND cast(replace(year_nm, '이하', '') as int) >= toYear(sale_dt) - 2))
-- -- AND it not in ('6','8')
-- -- AND season_cd in ('1','3','5','7','0')
-- -- AND biz_cd in ({{ bizSelect.value.map(i => `'${i}'`).join(',') }})
-- -- AND br_cd in ({{ brandMultiSelect.value.map(i => `'${i}'`).join(',') }})
-- -- AND onoff_flag in ({{tabs1.value==='합계' ? `'오프라인', '온라인'`:`'${tabs1.value}'`}})
-- -- GROUP BY
-- --   year_unit,
-- --   shop_cd,
-- --   shop_nm,
-- --   season_cd,
-- --   season_nm,
-- --   category_name),
  
-- -- prev_tbl AS (SELECT
-- --   YEAR(sale_dt) as year_unit,
-- --   sum(sales_price) as rev,
-- --   sum(sales_qty*tag_price) as tag,
-- --   sum(cost_price) as cost,
-- --   shop_cd,
-- --   shop_nm,
-- --   season_cd,
-- --   season_nm,
-- --   -- CASE WHEN it in ('1','4') THEN '기초정상'
-- --   --   WHEN it = '5' AND it_gb = '57' THEN '기획내의'
-- --   --   WHEN it = '5' THEN '기획의류'
-- --   --   WHEN it = '7' THEN '시즌용품'
-- --   --   WHEN it in ('2','3') THEN '정상의류'
-- --   --   WHEN it = '9' THEN '판촉물/부자재'
-- --   -- ELSE '기타' END as category_name
-- --        {{ varShopSalesCatogory.value?.category_name === '소계' ? `'소계'` :  `CASE WHEN it = '1' THEN '시즌언더'
-- --     WHEN it = '2' THEN '시즌의류(B)'
-- --     WHEN it = '3' THEN '시즌의류(T)'
-- --     WHEN it = '4' THEN '파자마'
-- --     WHEN it = '5' AND it_gb = '57' THEN '기획언더'
-- --     WHEN it = '5' THEN '기획의류'
-- --     WHEN it = '6' THEN '위탁용품'
-- --     WHEN it = '7' THEN '시즌용품'
-- --     WHEN it = '8' THEN '일반용품'
-- --     WHEN it = '9' THEN '판촉부자재'
-- --   ELSE '기타' END` }} as category_name

-- -- FROM agabang_dw.daily_shop_sales_by_dimension
-- -- WHERE
-- --   sale_dt BETWEEN toDate(addYears('{{dateRange.value.start }}', -1)) AND toDate(addYears('{{dateRange.value.end}}', -1))
-- -- AND team_cd != '05'
-- -- AND it not in ('6', '8') AND (sale_dt <= season_end_dt OR  (season_cd = '0' AND cast(replace(year_nm, '이하', '') as int) >= toYear(sale_dt) - 2))
-- -- AND it not in ('6','8')
-- -- AND season_cd in ('1','3','5','7','0')
-- -- AND biz_cd in ({{ bizSelect.value.map(i => `'${i}'`).join(',') }})
-- -- AND br_cd in ({{ brandMultiSelect.value.map(i => `'${i}'`).join(',') }})
-- -- AND onoff_flag in ({{tabs1.value==='합계' ? `'오프라인', '온라인'`:`'${tabs1.value}'`}})
-- -- GROUP BY
-- --   year_unit,
-- --   shop_cd,
-- --   shop_nm,
-- --   season_cd,
-- --   season_nm,
-- --   category_name
-- -- )
-- -- SELECT
-- --     A.shop_cd as shop_cd,
-- --     A.shop_nm as shop_nm,
-- --     A.category_name as category_name,
-- --     A.season_nm as season_nm,
-- --     A.qty as cur_qty,
-- --     A.rev as cur_rev,
-- --     A.rev/{{ varShopSalesCatogory.value?.cur_rev }} as cur_rev_rate,
-- --     B.rev as prev_rev,
-- --     A.tag as cur_tag,
-- --     B.tag as prev_tag,
-- --     A.cost as cur_cost,
-- --     B.cost as prev_cost,
-- --     CASE WHEN C.out_qty = 0 THEN 0 ELSE A.qty/C.out_qty END as sale_rate_qty,
-- --     CASE WHEN C.sup_amt = 0 THEN 0 ELSE A.rev/C.sup_amt END as sale_rate_amt
-- -- FROM base_tbl as A
-- -- full outer JOIN prev_tbl AS B ON A.shop_cd = B.shop_cd and A.category_name = B.category_name and A.season_nm = B.season_nm
-- -- full outer JOIN dsoutrtnBase AS C ON A.shop_cd = C.shop_cd and A.category_name = C.category_name and A.season_cd = C.season_cd
-- -- WHERE A.category_name = '{{ varShopSalesCatogory.value?.category_name }}'
-- -- and A.season_nm = '{{ varShopSalesCatogory.value?.season_nm }}'
-- -- ORDER BY A.rev asc

-- -- -- WITH
-- -- --     base_tbl as (SELECT
-- -- --   YEAR(sale_dt) as year_unit,
-- -- --   sum(sales_price) as rev,
-- -- --   sum(sales_qty*tag_price) as tag,
-- -- --   sum(cost_price) as cost,
-- -- --   shop_cd,
-- -- --   shop_nm,
-- -- --   season_nm,
-- -- --   -- CASE WHEN it in ('1','4') THEN '기초정상'
-- -- --   --   WHEN it = '5' AND it_gb = '57' THEN '기획내의'
-- -- --   --   WHEN it = '5' THEN '기획의류'
-- -- --   --   WHEN it = '7' THEN '시즌용품'
-- -- --   --   WHEN it in ('2','3') THEN '정상의류'
-- -- --   --   WHEN it = '9' THEN '판촉물/부자재'
-- -- --   -- ELSE '기타' END as category_name
-- -- --      {{ varShopSalesCatogory.value?.category_name === '소계' ? `'소계'` :  `CASE WHEN it = '1' THEN '시즌언더'
-- -- --     WHEN it = '2' THEN '시즌의류(B)'
-- -- --     WHEN it = '3' THEN '시즌의류(T)'
-- -- --     WHEN it = '4' THEN '파자마'
-- -- --     WHEN it = '5' AND it_gb = '57' THEN '기획언더'
-- -- --     WHEN it = '5' THEN '기획의류'
-- -- --     WHEN it = '6' THEN '위탁용품'
-- -- --     WHEN it = '7' THEN '시즌용품'
-- -- --     WHEN it = '8' THEN '일반용품'
-- -- --     WHEN it = '9' THEN '판촉부자재'
-- -- --   ELSE '기타' END` }} as category_name
-- -- -- FROM agabang_dw.daily_shop_sales_by_dimension
-- -- -- WHERE
-- -- --   sale_dt BETWEEN toDate('{{dateRange.value.start }}') AND toDate('{{dateRange.value.end}}')
-- -- -- AND team_cd != '05'
-- -- -- AND it not in ('6', '8') AND (sale_dt <= season_end_dt OR  (season_cd = '0' AND cast(replace(year_nm, '이하', '') as int) >= toYear(sale_dt) - 2))
-- -- -- AND it not in ('6','8')
-- -- -- AND season_cd in ('1','3','5','7','0')
-- -- -- AND biz_cd in ({{ bizSelect.value.map(i => `'${i}'`).join(',') }})
-- -- -- AND br_cd in ({{ brandMultiSelect.value.map(i => `'${i}'`).join(',') }})
-- -- -- AND onoff_flag in ({{tabs1.value==='합계' ? `'오프라인', '온라인'`:`'${tabs1.value}'`}})
-- -- -- GROUP BY
-- -- --   year_unit,
-- -- --   shop_cd,
-- -- --   shop_nm,
-- -- --   season_nm,
-- -- --   category_name),
  
-- -- -- prev_tbl AS (SELECT
-- -- --   YEAR(sale_dt) as year_unit,
-- -- --   sum(sales_price) as rev,
-- -- --   sum(sales_qty*tag_price) as tag,
-- -- --   sum(cost_price) as cost,
-- -- --   shop_cd,
-- -- --   shop_nm,
-- -- --   season_nm,
-- -- --   -- CASE WHEN it in ('1','4') THEN '기초정상'
-- -- --   --   WHEN it = '5' AND it_gb = '57' THEN '기획내의'
-- -- --   --   WHEN it = '5' THEN '기획의류'
-- -- --   --   WHEN it = '7' THEN '시즌용품'
-- -- --   --   WHEN it in ('2','3') THEN '정상의류'
-- -- --   --   WHEN it = '9' THEN '판촉물/부자재'
-- -- --   -- ELSE '기타' END as category_name
-- -- --        {{ varShopSalesCatogory.value?.category_name === '소계' ? `'소계'` :  `CASE WHEN it = '1' THEN '시즌언더'
-- -- --     WHEN it = '2' THEN '시즌의류(B)'
-- -- --     WHEN it = '3' THEN '시즌의류(T)'
-- -- --     WHEN it = '4' THEN '파자마'
-- -- --     WHEN it = '5' AND it_gb = '57' THEN '기획언더'
-- -- --     WHEN it = '5' THEN '기획의류'
-- -- --     WHEN it = '6' THEN '위탁용품'
-- -- --     WHEN it = '7' THEN '시즌용품'
-- -- --     WHEN it = '8' THEN '일반용품'
-- -- --     WHEN it = '9' THEN '판촉부자재'
-- -- --   ELSE '기타' END` }} as category_name

-- -- -- FROM agabang_dw.daily_shop_sales_by_dimension
-- -- -- WHERE
-- -- --   sale_dt BETWEEN toDate(addYears('{{dateRange.value.start }}', -1)) AND toDate(addYears('{{dateRange.value.end}}', -1))
-- -- -- AND team_cd != '05'
-- -- -- AND it not in ('6', '8') AND (sale_dt <= season_end_dt OR  (season_cd = '0' AND cast(replace(year_nm, '이하', '') as int) >= toYear(sale_dt) - 2))
-- -- -- AND it not in ('6','8')
-- -- -- AND season_cd in ('1','3','5','7','0')
-- -- -- AND biz_cd in ({{ bizSelect.value.map(i => `'${i}'`).join(',') }})
-- -- -- AND br_cd in ({{ brandMultiSelect.value.map(i => `'${i}'`).join(',') }})
-- -- -- AND onoff_flag in ({{tabs1.value==='합계' ? `'오프라인', '온라인'`:`'${tabs1.value}'`}})
-- -- -- GROUP BY
-- -- --   year_unit,
-- -- --   shop_cd,
-- -- --   shop_nm,
-- -- --   season_nm,
-- -- --   category_name
-- -- -- )
-- -- -- SELECT
-- -- --     A.shop_cd as shop_cd,
-- -- --     A.shop_nm as shop_nm,
-- -- --     A.category_name as category_name,
-- -- --     A.season_nm as season_nm,
-- -- --     A.rev as cur_rev,
-- -- --     A.rev/{{ varShopSalesCatogory.value?.cur_rev }} as cur_rev_rate,
-- -- --     B.rev as prev_rev,
-- -- --     A.tag as cur_tag,
-- -- --     B.tag as prev_tag,
-- -- --     A.cost as cur_cost,
-- -- --     B.cost as prev_cost
-- -- -- FROM base_tbl as A
-- -- -- INNER JOIN prev_tbl AS B ON A.shop_cd = B.shop_cd and A.category_name = B.category_name and A.season_nm = B.season_nm
-- -- -- WHERE A.category_name = '{{ varShopSalesCatogory.value?.category_name }}'
-- -- -- and A.season_nm = '{{ varShopSalesCatogory.value?.season_nm }}'
-- -- -- ORDER BY A.rev asc