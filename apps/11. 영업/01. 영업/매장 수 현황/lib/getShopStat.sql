WITH
 toDate('{{referenceDate.value}}') as select_date,
toYear(select_date) as select_year,
addYears(select_date,-1) as last_year_select_date,
toYear(last_year_select_date) as last_year_select_year,

saleTbl as (
    SELECT
        shop_cd, shop_nm,
        biz_cd, biz_nm,
        tp_cd, tp_nm,
        onoff_flag,
        sum(CASE WHEN YEAR(sale_dt) = select_year THEN sales_price ELSE 0 END) as rev_01,
        sum(CASE WHEN YEAR(sale_dt) = last_year_select_year THEN sales_price ELSE 0 END) as rev_02
        -- sum(CASE WHEN YEAR(sale_dt) = last_year_select_year - 1 THEN sales_price ELSE 0 END) as rev_03
    FROM agabang_dw.daily_shop_sales_by_dimension
    WHERE date_format(sale_dt, '%m-%d') <= date_format(select_date, '%m-%d')
   and year(sale_dt) >= last_year_select_year --and team_cd != '60'
    GROUP BY
        shop_cd, shop_nm,
        biz_cd, biz_nm,
        tp_cd, tp_nm,
        onoff_flag
),

shopInfoTbl as (
    SELECT
        shop_cd, shop_nm, close_dt, open_dt,
        -- YEAR(open_dt) as open_yr, YEAR(close_dt) as close_yr,
        -- CASE WHEN select_date between open_dt and close_dt THEN 1 ELSE 0 END as curr_open,
        -- CASE WHEN last_year_select_date between open_dt and close_dt THEN 1 ELSE 0 END as prev_open,
        CASE WHEN select_date between open_dt and close_dt THEN
            (CASE WHEN YEAR(open_dt) = select_year THEN '금년 오픈'
                  WHEN YEAR(open_dt) != select_year THEN '기존 운영'  END)
        ELSE
            (CASE WHEN YEAR(close_dt) = select_year THEN '금년 폐점'
                  WHEN YEAR(close_dt) != select_year THEN '과거 폐점' END)
        END as stat
    FROM (
        SELECT
            DISTINCT
            coalesce(handover.shop_cd, shop_cd) as shop_cd,
            coalesce(handover.shop_nm, shop_nm) as shop_nm,
            min(open_dt) as open_dt ,max(close_dt) as close_dt
        FROM agabang_dw.dim_shop
        LEFT JOIN agabang_dw.retooldb_shop_handover as handover on dim_shop.shop_cd = handover.prev_shop_cd
        GROUP BY shop_cd, shop_nm
    )
)

SELECT
    A.shop_cd as shop_cd, A.shop_nm as shop_nm,
    A.biz_cd as biz_cd, A.biz_nm as biz_nm,
    A.tp_cd as tp_cd, A.tp_nm as tp_nm,

    A.rev_01 as rev_01,
    A.rev_02 as rev_02,
    
    B.open_dt as open_dt,
    B.close_dt as close_dt, stat, --curr_open, prev_open,
    CASE
    WHEN select_date BETWEEN B.open_dt AND B.close_dt
         AND A.rev_01 != 0 THEN 1 ELSE 0 END AS curr_open,
  CASE
    WHEN last_year_select_date BETWEEN B.open_dt AND B.close_dt
         AND A.rev_02 != 0 THEN 1 ELSE 0 END AS prev_open,
    CASE WHEN stat = '금년 오픈' AND A.rev_01 != 0 THEN 1 ELSE 0 END as new_opened,
    CASE WHEN stat = '기존 운영' AND A.rev_01 != 0 THEN 1 ELSE 0 END as opened,
    CASE WHEN stat = '금년 폐점' AND A.rev_01 != 0 THEN 1 ELSE 0 END as new_closed,
    CASE WHEN stat = '과거 폐점' AND A.rev_01 != 0 THEN 1 ELSE 0 END as closed
FROM saleTbl as A
LEFT JOIN shopInfoTbl as B ON A.shop_cd = B.shop_cd
WHERE A.onoff_flag = '오프라인';