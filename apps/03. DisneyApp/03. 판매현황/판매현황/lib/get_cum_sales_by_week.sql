with
'{{ var_brand_code.value }}' as brand_code,
-- 기준 날짜 설정
DATE_PARAMS as (
    select 
        toDate(substring('{{sel_end_date.value}}', 1, 10)) as end_date,
        -- sel_start_date가 있으면 사용, 없으면 end_date에서 16주 전
        case 
            when '{{sel_start_date.value}}' != '' then toDate(substring('{{sel_start_date.value}}', 1, 10))
            else toDate(substring('{{sel_end_date.value}}', 1, 10)) - interval 16 week + interval 1 day
        end as start_date
),
-- 선택된 시즌들의 연도 정보를 동적으로 계산
SEASON_INFO as (
    select distinct
        concat(year_nm_short, sesn_nm_eng) as year_season,
        -- 가장 최근 연도부터의 차이를 계산
        toInt32(substring(max(year_nm_short) over(), 1, 2)) - toInt32(substring(year_nm_short, 1, 2)) as year_offset,
        -- 현재 연도 확인 (25 = 2025년)
        case when concat('20', year_nm_short) = toString(toYear(today())) then 1 else 0 end as is_current_year
    from agabang_dw.retooldb_code_season
    where concat(year_nm_short, sesn_nm_eng) in ('{{var_last_seasons.value.join("', '")}}')
),
-- 실제 판매 데이터를 주차별로 집계
SALES_BY_WEEK as (
    select 
        concat(B.year_nm_short, B.sesn_nm_eng) as year_season,
        case when {{sel_category.value}} = 89 then 89 else coalesce(C.item_md_category_id, 91) end as cat_id,
        -- 주차 계산: start_date의 월요일 기준으로 순방향 계산 (정수로 변환)
        toUInt64(FLOOR(date_diff('day', 
            toMonday((select start_date from DATE_PARAMS)),
            toMonday(A.sale_dt + interval SI.year_offset year)
        )/7) + 1) as weeks,
        sum(A.sale_qty) as sale_qty,
        sum(A.sale_amt) as sale_amt,
        sum(A.sale_qty * E.tag_prce) as sale_tag_amt,
        min(A.sale_dt) as s_date,
        max(A.sale_dt) as f_date
    from agabang_dw.daily_data_by_color as A
    left outer join agabang_dw.retooldb_item_md_info as C
        on A.sty_cd = C.sty_cd
    join agabang_dw.retooldb_code_season as B
        on substring(A.sty_cd, 3, 2) = B.year_sesn_cd
    join agabang_dw.prod_sales_stock_by_color as E
        on A.sty_cd = E.sty_cd
        and A.col_cd = E.col_cd
    join SEASON_INFO as SI
        on concat(B.year_nm_short, B.sesn_nm_eng) = SI.year_season
    where A.br_cd = brand_code
        and concat(B.year_nm_short, B.sesn_nm_eng) in ('{{var_last_seasons.value.join("', '")}}')
        and A.sale_dt between 
            (select start_date from DATE_PARAMS) - interval SI.year_offset year
            and case 
                when SI.is_current_year = 1 then 
                    LEAST((select end_date from DATE_PARAMS), yesterday())
                else 
                    (select end_date from DATE_PARAMS) - interval SI.year_offset year
            end
        -- select_item_type에 따른 필터
        and case 
            when '{{select_item_type.value}}' = 'season' then B.sesn_cd in ('1', '3', '5', '7')
            when '{{select_item_type.value}}' = 'mart' then B.sesn_cd in ('2', '4', '6', '8')
            when '{{select_item_type.value}}' = 'season_less' then B.sesn_cd = '0'
            else true
        end
    group by 1, 2, 3
),
-- 전체 주차 범위 생성
ALL_WEEKS_RANGE as (
    select 
        toUInt64(number + 1) as week_num
    from numbers(100)
    where number < toUInt64(FLOOR(date_diff('day', 
        toMonday((select start_date from DATE_PARAMS)),
        toMonday((select end_date from DATE_PARAMS))
    )/7) + 1)
),
-- 모든 시즌과 주차의 조합 생성
ALL_COMBINATIONS as (
    select 
        SI.year_season,
        SI.year_offset,
        AWR.week_num as weeks,
        -- 각 주차의 날짜 범위 계산
        toMonday((select start_date from DATE_PARAMS)) + ((AWR.week_num - 1) * 7) - interval SI.year_offset year as week_start,
        toMonday((select start_date from DATE_PARAMS)) + ((AWR.week_num - 1) * 7) + 6 - interval SI.year_offset year as week_end
    from SEASON_INFO SI
    cross join ALL_WEEKS_RANGE AWR
)
-- 최종 결과: 모든 주차 포함
select
    AC.year_season,
    case when {{sel_category.value}} = 89 then 89 else 91 end as cat_id,
    AC.weeks,
    concat(toString(AC.week_start), ' - ', toString(AC.week_end)) as date_range,
    SBW.sale_qty as sale_qty_per,
    SBW.sale_amt/1000000 as sale_tag_amt_per,
    SBW.sale_amt/1000000 as sale_amt_per
from ALL_COMBINATIONS AC
left join SALES_BY_WEEK SBW
    on AC.year_season = SBW.year_season
    and AC.weeks = SBW.weeks
WHERE ( ( {{sel_category.value}} = 89 ) or ( {{sel_category.value}} = 89 ) )
ORDER BY AC.year_season, AC.weeks