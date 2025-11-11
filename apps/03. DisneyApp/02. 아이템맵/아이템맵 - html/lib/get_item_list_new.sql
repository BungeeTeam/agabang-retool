WITH 
'{{segmentedControl_date_mode.value == "cumulative" ? "2000-01-01": sel_start_date.value.substring(0,10)}}' as start_date,
'{{segmentedControl_date_mode.value == "cumulative" ? new Date().toISOString().split('T')[0] : sel_end_date.value.substring(0,10)}}' as end_date,
  
dim_style_color as(
    SELECT
    max(comp_cd) as comp_cd,
    sty_cd,
    max(sty_nm) as sty_nm,
    col_cd,
    max(col_nm) as col_nm,
    max(size_cd) as size_cd,
    max(size_nm) as size_nm,
    max(br_cd) as br_cd,
    max(br_nm) as br_nm,
    max(nation) as nation,
    max(cust_cd) as cust_cd,
    max(cust_nm) as cust_nm,
    max(cust_tp_cd) as cust_tp_cd,
    max(cust_tp_nm) as cust_tp_nm,
    max(designer) as designer,
    max(year_cd) as year_cd,
    max(year_nm) as year_nm,
    max(season_cd) as season_cd,
    max(season_nm) as season_nm,
    max(sex_nm) as sex_nm,
    max(fabric) as fabric,
    max(designer_nm) as designer_nm,
    max(preview_cd) as preview_cd,
    max(concept) as concept,
    max(colab_yn) as colab_yn,
    max(it) as it,
    max(it_nm) as it_nm,
    max(it_gb) as it_gb,
    max(it_gb_nm) as it_gb_nm,
    max(item) as item,
    max(item_nm) as item_nm,
    max(ex_tag_price) as ex_tag_price,
    max(tag_price) as tag_price,
    max(sub_br_cd) as sub_br_cd,
    max(sub_br_nm) as sub_br_nm,
    max(cost_price) as cost_price
    FROM dim_style as A
    WHERE 
    CASE 
      WHEN '{{ select_season_type.value }}' = 'yongpum' then substring(sty_cd,1,2) in ('{{ season_select_new.value.join("', '") }}')
      ELSE substring(sty_cd,1,2) = '79'
      END
    and CASE 
        WHEN '{{ select_season_type.value }}' = 'yongpum' then substring(A.sty_cd,5,1) in ('6','8')
        ELSE substring(A.sty_cd,5,1) in ('1','2','3','4','5','7')
        END
    and CASE WHEN '{{ select_season_type.value }}' = 'yongpum' THEN true
        ELSE substring(A.sty_cd,3,2) in ('{{ season_select_new.value.join("', '") }}') END
    GROUP BY sty_cd, col_cd

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
        and CASE 
          WHEN '{{ select_season_type.value }}' = 'yongpum' then substring(sty_cd,1,2) in ('{{ season_select_new.value.join("', '") }}')
          ELSE substring(sty_cd,1,2) = '79'
          END
        and CASE 
            WHEN '{{ select_season_type.value }}' = 'yongpum' then substring(sty_cd,5,1) in ('6','8')
            ELSE substring(sty_cd,5,1) in ('1','2','3','4','5','7')
            END
        and CASE WHEN '{{ select_season_type.value }}' = 'yongpum' THEN true
            ELSE substring(sty_cd,3,2) in ('{{ season_select_new.value.join("', '") }}') END
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
    GROUP BY A.sty_cd, A.col_cd, A.size_cd
),
SIZE_DATA_EACH_TOT AS (
  select
      br_cd, sty_cd, col_cd, size_cd,
      SUM(sales_qty) as sale_qty,
      SUM(sales_price) as sale_amt
  from agabang_dw.daily_shop_sales_by_size as A
  WHERE A.sale_dt >= toDate(addYears(now(), -5)) and A.sale_dt <= toDate(now()) 
    and       CASE 
      WHEN '{{ select_season_type.value }}' = 'yongpum' then substring(sty_cd,1,2) in ('{{ season_select_new.value.join("', '") }}')
      ELSE substring(sty_cd,1,2) = '79'
      END
    and CASE 
        WHEN '{{ select_season_type.value }}' = 'yongpum' then substring(A.sty_cd,5,1) in ('6','8')
        ELSE substring(A.sty_cd,5,1) in ('1','2','3','4','5','7')
        END
    and CASE WHEN '{{ select_season_type.value }}' = 'yongpum' THEN true
        ELSE substring(A.sty_cd,3,2) in ('{{ season_select_new.value.join("', '") }}') END
  group by 1,2,3,4
    
),
SIZE_DATA_EACH AS (
    select
        br_cd,
        sty_cd, col_cd, size_cd,
        SUM(sales_qty) as sale_qty,
        SUM(sales_price) as sale_amt
    from agabang_dw.daily_shop_sales_by_size as A
    where A.sale_dt >= start_date and A.sale_dt <= end_date
    and        CASE 
      WHEN '{{ select_season_type.value }}' = 'yongpum' then substring(sty_cd,1,2) in ('{{ season_select_new.value.join("', '") }}')
      ELSE substring(sty_cd,1,2) = '79'
      END
    and CASE 
        WHEN '{{ select_season_type.value }}' = 'yongpum' then substring(A.sty_cd,5,1) in ('6','8')
        ELSE substring(A.sty_cd,5,1) in ('1','2','3','4','5','7')
        END
    and CASE WHEN '{{ select_season_type.value }}' = 'yongpum' THEN true
        ELSE substring(A.sty_cd,3,2) in ('{{ season_select_new.value.join("', '") }}') END
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
                    ',"plan_qty":', x.5,
                    ',"week_sale_qty":', x.6,
                    ',"cum_in_qty":', x.7,
                    '}'
                ),
                groupArray((
                    A.size_cd,
                    A.size_nm,
                    -- period 모드일 때는 cum_in_qty 사용, cumulative 모드일 때는 기존 tot_in_qty 사용
                    case when '{{ segmentedControl_date_mode.value }}' = 'period' then toString(coalesce(D.cum_in_qty, 0))
                         else toString(A.tot_in_qty) end,
                    toString(coalesce(C.sale_qty,0)),
                    toString(A.plan_qty),
                    case when '{{ segmentedControl_date_mode.value }}' = 'cumulative' then toString(A.int_sale_qty) 
                         else toString(coalesce(B.sale_qty,0)) end,
                    toString(coalesce(D.cum_in_qty, 0))
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
    LEFT OUTER JOIN SIZE_DATA_EACH_TOT as C
      ON A.sty_cd = C.sty_cd
        AND A.col_cd = C.col_cd
        AND A.size_cd = C.size_cd
    LEFT OUTER JOIN CUM_IN_DATA as D
      ON A.sty_cd = D.sty_cd
        AND A.col_cd = D.col_cd
        AND A.size_cd = D.size_cd
    WHERE 
    CASE 
      WHEN '{{ select_season_type.value }}' = 'yongpum' then substring(A.sty_cd,1,2) in ('{{ season_select_new.value.join("', '") }}')
      ELSE substring(A.sty_cd,1,2) = '79'
      END
    and CASE 
        WHEN '{{ select_season_type.value }}' = 'yongpum' then substring(A.sty_cd,5,1) in ('6','8')
        ELSE substring(A.sty_cd,5,1) in ('1','2','3','4','5','7')
        END
    and CASE WHEN '{{ select_season_type.value }}' = 'yongpum' THEN true
        ELSE substring(A.sty_cd,3,2) in ('{{ season_select_new.value.join("', '") }}') END
    GROUP BY 1, 2, 3, 4
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
)
  
SELECT
    A.br_cd AS br_cd,
    A.sty_cd AS sty_cd,
    A.col_cd AS col_cd,
    dim.sty_nm AS sty_nm,
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
    D.preview_grade as preview_grade,
    case when D.preview_score > 0 then round(D.preview_score, 1) else NULL end as preview_score,
    -- return_per 계산도 period 모드 반영
    case when '{{ segmentedControl_date_mode.value }}' = 'period' 
         then case when coalesce(E.cum_in_qty, 0) > 0 
              then round((A.tot_sale_amt / (B.cost_prce * E.cum_in_qty)) * 100, 0) 
              else NULL end
         else case when B.tot_in_qty > 0 then round((A.tot_sale_amt / (B.cost_prce * B.tot_in_qty)) * 100, 0) else NULL end
    end as return_per,
    dim.designer_nm as designer_nm,
    dim.cust_nm as cust_nm,
    dim.nation as prod_country,
    dim.fabric as fabric,
    A.size_data,
    F.sale_1 as sale_week_1,
    F.sale_2 as sale_week_2,
    D.memo as memo,
    coalesce(D.cat_nm , '복종X') as cat_nm,
    case
      when {{sel_category.value}} = 19 then '전체'
      else coalesce(D.item_raw_nm, '아이템X')
    end as item_nm,
    concat(dim.year_cd,dim.season_cd) as year_sesn_cd,
    concat(dim.year_nm,dim.season_nm) as year_sesn_nm_kor,
    D.memo,
    B.int_sale_qty as week_sale_qty,
    D.sex_nm as sex_nm
    
FROM SIZE_DATA as A
JOIN dim_style_color as dim ON A.sty_cd = dim.sty_cd and A.col_cd = dim.col_cd
JOIN agabang_dw.prod_sales_stock_by_color as B
    ON A.sty_cd = B.sty_cd
    AND A.col_cd = B.col_cd
JOIN agabang_dw.weekly_sales as F
    ON A.sty_cd = F.sty_cd
    AND A.col_cd = F.col_cd
LEFT OUTER JOIN agabang_dw.retooldb_item_md_info as D
    ON A.sty_cd = D.sty_cd
LEFT OUTER JOIN CUM_IN_COLOR_DATA as E
    ON A.sty_cd = E.sty_cd
    AND A.col_cd = E.col_cd
WHERE 
concat(dim.sty_nm,' ',dim.sty_cd,' ',dim.fabric,' ',dim.col_nm,' ',cat_nm,' ',item_nm) like '%{{search_text.value}}%'
  AND case when ({{sel_category.value ?? 0}} = 91) then D.item_md_category_id is null -- 복종X
           when ({{sel_category.value ?? 0}} = 89) then true -- 전체:89
           when '{{ select_season_type.value }}' = 'yongpum' and ({{sel_category.value ?? 0}} = 61) then substring(dim.sty_cd,5,2) in ('61','81') -- 용품: 발육
           when '{{ select_season_type.value }}' = 'yongpum' and ({{sel_category.value ?? 0}} = 62) then substring(dim.sty_cd,5,2) in ('62','82') -- 용품: 수유
           when '{{ select_season_type.value }}' = 'yongpum' and ({{sel_category.value ?? 0}} = 63) then substring(dim.sty_cd,5,2) in ('63','83') -- 용품: 완구/기타
           when '{{ select_season_type.value }}' = 'yongpum' and ({{sel_category.value ?? 0}} = 64) then substring(dim.sty_cd,5,2) in ('64','84') -- 용품: 섬유1
           when '{{ select_season_type.value }}' = 'yongpum' and ({{sel_category.value ?? 0}} = 65) then substring(dim.sty_cd,5,2) in ('65','85') -- 용품: 섬유2
           when '{{ select_season_type.value }}' = 'yongpum' and ({{sel_category.value ?? 0}} = 66) then substring(dim.sty_cd,5,2) in ('66','86') -- 용품: 위생
           when '{{ select_season_type.value }}' = 'yongpum' and ({{sel_category.value ?? 0}} = 68) then substring(dim.sty_cd,5,2) in ('68','88') -- 용품: 화장품
           
           when ({{sel_category.value ?? 0}} = 2) then substring(dim.sty_cd,5,1) = '2' -- 사계절: 시즌의류
           when ({{sel_category.value ?? 0}} = 1) then substring(dim.sty_cd,5,1) = '1' -- 사계절: 시즌언더
           when ({{sel_category.value ?? 0}} = 7) then substring(dim.sty_cd,5,1) = '7' -- 사계절: 시즌용품
           when ({{sel_category.value ?? 0}} = 4) then substring(dim.sty_cd,5,1) = '4' -- 사계절: 파자마
           when ({{sel_category.value ?? 0}} = 5) then substring(dim.sty_cd,5,1) = '5' -- 사계절: 기획
           when ({{sel_category.value ?? 0}} = 8) then substring(dim.sty_cd,5,1) = '8' -- 사계절: 출산용품
           else {{sel_category.value ?? 0}} = D.item_md_category_id end
AND substring(A.sty_cd, 5, 1) != '9'

ORDER BY A.sty_cd asc
limit 300;