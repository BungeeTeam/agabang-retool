WITH 
'{{segmentedControl_date_mode.value == "cumulative" ? "2020-01-01": sel_start_date.value.substring(0,10)}}' as start_date,
'{{segmentedControl_date_mode.value == "cumulative" ? new Date().toISOString().split('T')[0] : sel_end_date.value.substring(0,10)}}' as end_date,
  '07' as brand_code,
STY_SEASON AS (
  SELECT 
    A.sty_cd,
    A.sty_nm,
    case
       when A.year_season is not null then A.year_season
       -- when B.sesn_cd in (1, 3, 5, 7) then B.year_sesn_nm_eng
      when (B.sesn_nm_eng = 'NO' and substring(A.sty_cd, 5, 1) = '8' and
             A.item_raw_nm not in ('손싸개', '속싸보', '턱받이')) then 'BIRTH'
      when B.sesn_cd in (0, 1, 3, 5, 7) then B.year_sesn_cd
       else 'NO'
       end                      year_season_cd,
    A.year_season             as md_info_year_season,
    B.year_sesn_nm_eng        as cod_year_season,
    substring(A.sty_cd, 5, 1) as category_code,
    A.item_raw_nm
  FROM agabang_dw.retooldb_item_md_info as A
  -- JOIN agabang_dw.code_season as B
  JOIN agabang_dw.retooldb_code_season as B
  ON substring(A.sty_cd, 3, 2) = concat(B.year_cd, B.sesn_cd)
  WHERE A.br_cd = brand_code
),
-- 첫 입고일 계산
FIRST_IN_DATE AS (
    SELECT 
        sty_cd,
        col_cd,
        size_cd,
        MIN(sale_dt) as first_in_dt
    FROM agabang_dw.daily_sales_by_size
    WHERE cum_in_qty > 0
        and br_cd = brand_code
    GROUP BY sty_cd, col_cd, size_cd
),
-- period 모드일 때 종료일 기준 누적 입고 데이터
CUM_IN_DATA AS (
    SELECT 
        A.sty_cd,
        A.col_cd,
        A.size_cd,
        argMax(A.cum_in_qty, A.sale_dt) as cum_in_qty,
        argMax(A.cum_in_amt, A.sale_dt) as cum_in_amt
    FROM agabang_dw.daily_sales_by_size A
    INNER JOIN FIRST_IN_DATE F ON A.sty_cd = F.sty_cd AND A.col_cd = F.col_cd AND A.size_cd = F.size_cd
    WHERE A.sale_dt <= toDate(end_date)
        and A.sale_dt >= F.first_in_dt
        and A.br_cd = brand_code
    GROUP BY A.sty_cd, A.col_cd, A.size_cd
),
-- period 모드일 때 컬러별 누적 입고 데이터
CUM_IN_COLOR_DATA AS (
    SELECT 
        sty_cd,
        col_cd,
        SUM(cum_in_qty) as cum_in_qty,
        SUM(cum_in_amt) as cum_in_amt
    FROM CUM_IN_DATA
    GROUP BY sty_cd, col_cd
),
-- 전체 기간 판매 데이터 (판매비중 계산용)
SIZE_DATA_EACH_TOT AS (
    select
        br_cd, 
        sty_cd, col_cd, size_cd,
        SUM(sale_qty) as sale_qty,
        SUM(sale_amt) as sale_amt
    from agabang_dw.daily_data_by_size as A
    where A.sale_dt >= toDate(addYears(now(), -5)) and A.sale_dt <= toDate(now())
      and A.br_cd = brand_code
    group by 1,2,3,4
),
SIZE_DATA_EACH AS (
    select
        br_cd, 
        sty_cd, col_cd, size_cd,
        SUM(sale_qty) as sale_qty,
        SUM(sale_amt) as sale_amt
    from agabang_dw.daily_data_by_size as A
    where A.sale_dt >= start_date and A.sale_dt <= end_date
      and A.br_cd = brand_code
    group by 1,2,3,4
),
SIZE_DATA AS (
    SELECT
        A.br_cd AS br_cd,
        A.sty_cd AS sty_cd,
        A.col_cd AS col_cd,
        A.col_nm AS col_nm,
        '[' || arrayStringConcat(
            arrayMap(
                x -> concat(
                    '{"size_cd":"', x.1,
                    '","size_nm":"', x.2,
                    '","tot_in_qty":', x.3,
                    ',"tot_sale_qty":', x.4,
                    ',"cum_in_qty":', x.5,
                    ',"period_sale_qty":', x.6,
                    '}'
                ),
                groupArray((
                    A.size_cd,
                    A.size_nm,
                    -- period 모드일 때는 cum_in_qty 사용, cumulative 모드일 때는 기존 tot_in_qty 사용
                    case when '{{ segmentedControl_date_mode.value }}' = 'period' then toString(coalesce(D.cum_in_qty, 0))
                         else toString(A.tot_in_qty) end,
                    -- 누적 판매수량
                    toString(coalesce(C.sale_qty,0)),
                    -- 누적 입고수량 (period 모드용)
                    toString(coalesce(D.cum_in_qty, 0)),
                    -- 기간 판매수량 (period 모드용)
                    toString(coalesce(B.sale_qty,0))
                ))
            ),
            ','
        ) || ']' AS size_data,
        sum(coalesce(B.sale_qty,0)) as tot_sale_qty,
        sum(coalesce(B.sale_amt,0)) as tot_sale_amt
    FROM agabang_dw.prod_sales_stock_by_size AS A
    LEFT OUTER JOIN SIZE_DATA_EACH as B
    ON A.sty_cd = B.sty_cd
    AND A.col_cd = B.col_cd
    AND A.size_cd = B.size_cd
    and A.br_cd = brand_code
    LEFT OUTER JOIN SIZE_DATA_EACH_TOT as C
    ON A.sty_cd = C.sty_cd
    AND A.col_cd = C.col_cd
    AND A.size_cd = C.size_cd
    LEFT OUTER JOIN CUM_IN_DATA as D
    ON A.sty_cd = D.sty_cd
    AND A.col_cd = D.col_cd
    AND A.size_cd = D.size_cd
    GROUP BY 1, 2, 3,4
)
SELECT
    A.br_cd AS br_cd,
    A.sty_cd AS sty_cd,
    A.col_cd AS col_cd,
    C.sty_nm AS sty_nm,
    B.col_nm AS col_nm,
    D.deli_dt AS deli_dt,
    B.fin_date as fin_date,
    B.tag_prce as tag_prce,
    B.f_sale_prce as f_sale_prce,
    B.cost_prce as cost_prce,
    round(B.tag_prce / (B.cost_prce*1.1), 1) as mark_up,
    B.plan_qty as plan_qty,
    B.fout_date as fout_date,
    -- period 모드일 때는 CUM_IN_DATA의 합계, cumulative 모드일 때는 기존 값
    case when '{{ segmentedControl_date_mode.value }}' = 'period' 
         then coalesce(E.cum_in_qty, 0)
         else B.tot_in_qty 
    end as tot_in_qty,
    A.tot_sale_qty as tot_sale_qty,
    -- 판매율 계산
    case when '{{ segmentedControl_date_mode.value }}' = 'period' 
         then case when coalesce(E.cum_in_qty, 0) > 0 
              then round((A.tot_sale_qty / E.cum_in_qty) * 100, 1) 
              else 0 end
         else case when B.tot_in_qty > 0 then round((A.tot_sale_qty / B.tot_in_qty) * 100, 1) else 0 end
    end as tot_sale_qty_per,
    -- period 모드일 때는 누적입고금액, cumulative 모드일 때는 기존 값
    case when '{{ segmentedControl_date_mode.value }}' = 'period' 
         then coalesce(E.cum_in_amt, 0)
         else B.tot_in_tag_amt 
    end as tot_in_tag_amt,
    A.tot_sale_amt as tot_sale_amt,
    -- 실판매율(금액) 계산
    case when '{{ segmentedControl_date_mode.value }}' = 'period' 
         then case when coalesce(E.cum_in_amt, 0) > 0 then round((A.tot_sale_amt / E.cum_in_amt) * 100, 1) else 0 end
         else case when B.tot_in_tag_amt > 0 then round((A.tot_sale_amt / B.tot_in_tag_amt) * 100, 1) else 0 end
    end as tot_sale_amt_per,
    D.designer_nm as designer_nm,
    D.preview_grade as preview_grade,
    case when D.preview_score > 0 then round(D.preview_score, 1) else NULL end as preview_score,
    -- return_per 계산도 period 모드 반영
    case when '{{ segmentedControl_date_mode.value }}' = 'period' 
         then case when coalesce(E.cum_in_qty, 0) > 0 
              then round((A.tot_sale_amt / (B.cost_prce * 1.1 * E.cum_in_qty)) * 100, 0) 
              else NULL end
         else case when B.tot_in_qty > 0 then round((B.tot_sale_amt / (B.cost_prce * 1.1 * B.tot_in_qty)) * 100, 0) else NULL end
    end as return_per,
    D.prod_comp as prod_comp,
    D.prod_country as prod_country,
    D.fabric as fabric,
    A.size_data,
    F.sale_1 as sale_week_1,
    F.sale_2 as sale_week_2,
    D.memo as memo,
    coalesce(E_cat.cat_nm, '복종X') as cat_nm,
    case 
      when {{sel_category.value}} = 19 then '전체'
      else coalesce(D.item_raw_nm, '아이템X') 
    end as item_nm,
    G.year_sesn_cd as year_sesn_cd,
    G.year_sesn_nm_kor as year_sesn_nm_kor,
    D.memo,
    I.int_sale_qty as week_sale_qty
FROM SIZE_DATA as A
JOIN agabang_dw.prod_sales_stock_by_color as B
    ON A.sty_cd = B.sty_cd
    AND A.col_cd = B.col_cd
JOIN agabang.plstycd as C
    ON A.sty_cd = C.sty_cd
JOIN agabang_dw.weekly_sales as F
    ON A.sty_cd = F.sty_cd
    AND A.col_cd = F.col_cd
JOIN agabang_dw.retooldb_code_season as G
    ON substring(A.sty_cd,3,2) = G.year_sesn_cd
JOIN STY_SEASON as H
    ON A.sty_cd = H.sty_cd
JOIN agabang_dw.prod_sales_stock_by_color as I
    ON A.sty_cd = I.sty_cd
    AND A.col_cd = I.col_cd
LEFT OUTER JOIN agabang_dw.retooldb_item_md_info as D
    ON A.sty_cd = D.sty_cd
LEFT OUTER JOIN agabang_dw.retooldb_item_md_category as E_cat
    ON D.item_md_category_id = E_cat.id
LEFT OUTER JOIN CUM_IN_COLOR_DATA as E
    ON A.sty_cd = E.sty_cd
    AND A.col_cd = E.col_cd
WHERE (
    ( '{{ select_season.value }}' LIKE '콜라보-%' AND 
      D.colab_nm = splitByChar('-', '{{ select_season.value[0] }}')[2]
    ) OR (
        H.year_season_cd IN ('{{ select_season.value.join("', '") }}')
    ) OR '{{ select_season.value[0] }}' = ''
)
AND A.br_cd = brand_code
AND (( C.sty_nm like '%{{ search_text.value }}%' )
OR ( A.sty_cd like '%{{ search_text.value }}%' )
OR ( D.fabric like '%{{ search_text.value }}%' )
OR ( B.col_nm like '%{{ search_text.value }}%' )
OR ( E_cat.cat_nm like '%{{ search_text.value }}%' )
OR ( item_nm like '%{{ search_text.value }}%' ))
AND ( ( coalesce(D.item_md_category_id, 18) = {{ sel_category.value }} ) or ( H.year_season_cd = 'BIRTH' )  or ( {{sel_category.value}} == 19 ) )
AND substring(A.sty_cd, 5, 1) != '9'
AND (B.sty_nm not like '%부가부%' and B.sty_nm not like '%두나%' and B.sty_nm not like '%디트로네%' and B.sty_nm not like '%리우드%' and B.sty_nm not like '%노바디노즈%' and B.sty_nm not like '%콩제슬레드%')
ORDER BY A.sty_cd asc, A.col_cd
limit 300;