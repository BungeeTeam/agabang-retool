WITH
    ({{ select_item_type.value === 'yongpum' ?
  select_brand.value.map(i => `'${i}'`).join(',')
  :`'${brand_code.value}'` }}) as brand_code,
    '{{season_select.value}}' as season_code,
    '{{category_select.value}}' as sel_category,
    '{{new Date().toISOString().split('T')[0]}}' as today,
      
    item_base AS(
        SELECT
            distinct br_cd, sty_cd, col_cd,
                    large_cat, middle_cat, small_cat,item_md_category_id,
                    cust_cd, cust_nm,
            CASE WHEN season_cd in ('2','4','6','8') THEN 'mart'
                WHEN season_cd = '0' and it in ('6','8') THEN 'yongpum'
                WHEN season_cd = '0' and it in ('1','2','3','5','7') THEN 'season_less'
                ELSE 'season' END as index
        FROM agabang_dw.dim_style
        WHERE br_cd in brand_code and concat(year_cd,season_cd) = season_code and it != '9'
    )


SELECT
    CASE
        WHEN A.fin_date is null and dateDiff('day',toDate(A.deli_dt),toDate(today)) >= 0
        THEN 1
        WHEN A.fin_date is not null and dateDiff('day',toDate(A.deli_dt),toDate(A.fin_date)) > 0
        THEN 2
        ELSE 5
    END AS ord,
    A.br_cd as br_cd,
    A.sty_cd AS sty_cd,
    A.sty_nm AS sty_nm,
    A.col_cd AS col_cd,
    A.col_nm AS col_nm,
    E.large_cat AS first_cat_nm, -- 대분류
    E.middle_cat as second_cat_nm, -- 중분류
    E.small_cat AS third_cat_nm, -- 소분류
    A.tag_prce AS tag_prce, -- 정가
    A.cost_prce AS cost_prce, -- 원가(VAT미포함)
    A.tot_in_qty AS tot_in_qty, -- 누적입고수량
    A.tot_in_tag_amt AS tot_in_tag_amt, -- 누적입고금액(tag)
    A.fin_date AS fin_dt, -- 최초입고일자
    A.plan_qty AS plan_qty, -- 작지상의 기획수량(발주수량과 상이할 가능성 있음)
    A.deli_dt AS deli_dt, -- 납기일=입고예정일
    A.ord_dt AS ord_dt, -- 발주일자
    E.cust_cd AS cust_cd, -- 생산처코드
    E.cust_nm AS cust_nm, -- 생산처이름
    coalesce(coalesce(A.tot_in_qty,0)/A.plan_qty,0) AS in_rate, -- 입고율
    A.plan_qty-A.tot_in_qty AS shortfall_qty,
      CASE
      WHEN dateDiff('day',A.ord_dt,A.fin_date)>0
      THEN CAST(dateDiff('day',A.ord_dt,A.fin_date) as VARCHAR)
      WHEN A.fin_date is null THEN '입고전'
      ELSE '-'
    END AS lead_time, --리드타임
      -- CASE
      --   WHEN A.fin_date is null and dateDiff('day',toDate(A.deli_dt),toDate(today)) < 0
      --   THEN '입고전'
      --   WHEN A.fin_date is null and dateDiff('day',toDate(A.deli_dt),toDate(today)) >= 0
      --   THEN toString(dateDiff('day',toDate(A.deli_dt),toDate(today)))
      --   WHEN A.fin_date is not null and dateDiff('day',toDate(A.deli_dt),toDate(A.fin_date)) <= 0
      --   THEN '정상입고'
      --   WHEN A.fin_date is not null and dateDiff('day',toDate(A.deli_dt),toDate(A.fin_date)) > 0
      --   THEN toString(dateDiff('day',toDate(A.deli_dt),toDate(A.fin_date)))
      --   ELSE '입고예정일 없음'
      -- END as delay_days --지연일수
      CASE
        WHEN A.fin_date is null and dateDiff('day',toDate(A.deli_dt),toDate(today)) < 0
        THEN '미입고'
        WHEN A.fin_date is null and dateDiff('day',toDate(A.deli_dt),toDate(today)) >= 0
        THEN '미입고'
        WHEN A.fin_date is not null and dateDiff('day',toDate(A.deli_dt),toDate(A.fin_date)) <= 0
        THEN '입고'
        WHEN A.fin_date is not null and dateDiff('day',toDate(A.deli_dt),toDate(A.fin_date)) > 0
        THEN '입고'
        ELSE '입고예정일 없음'
      END as in_state,
      CASE
        WHEN A.fin_date is null and dateDiff('day',toDate(A.deli_dt),toDate(today)) < 0
        THEN '입고전'
        WHEN A.fin_date is null and dateDiff('day',toDate(A.deli_dt),toDate(today)) >= 0
        THEN '지연'
        WHEN A.fin_date is not null and dateDiff('day',toDate(A.deli_dt),toDate(A.fin_date)) <= 0
        THEN '정상입고'
        WHEN A.fin_date is not null and dateDiff('day',toDate(A.deli_dt),toDate(A.fin_date)) > 0
        THEN '지연입고'
        ELSE '입고예정일 없음'
      END as delay_state,
  coalesce(dateDiff('day',toDate(A.deli_dt),toDate(A.fin_date)) ,dateDiff('day',toDate(A.deli_dt),toDate(today)))  as delay_days,
CASE WHEN fwrk_dt is null and A.fin_date is null THEN '입고전'
      WHEN fwrk_dt is null and A.fin_date is not null THEN '미출고'
      ELSE '출고' END as out_state, -- 출고 상태
fwrk_dt, -- 초출고일
coalesce(tot_out_qty,0) as tot_out_qty, -- 총출고수량
coalesce(coalesce(tot_out_qty,0)/A.tot_in_qty,0) as out_rate
FROM agabang_dw.prod_sales_stock_by_color AS A
RIGHT JOIN item_base as E ON A.sty_cd = E.sty_cd and A.col_cd = E.col_cd -- MD 구분 카테고리 가져오기
LEFT JOIN (
    SELECT
    sty_cd, col_cd,
    min(wrk_dt) as fwrk_dt,
    sum(out_qty) as tot_out_qty
    FROM agabang_dw.daily_dsoutrtn
    GROUP BY sty_cd, col_cd
) as C ON A.sty_cd = C.sty_cd and A.col_cd = C.col_cd
WHERE A.plan_qty is not null
      AND case when ({{category_select.value ?? 0}} = 999) then true -- 전체
             when ({{category_select.value ?? 0}} = 91) THEN E.item_md_category_id is null -- 복종X:91
             when ({{category_select.value ?? 0}} = 61) then substring(A.sty_cd,5,2) in ('61','81') -- 용품: 발육
             when ({{category_select.value ?? 0}} = 62) then substring(A.sty_cd,5,2) in ('62','82') -- 용품: 발육
             when ({{category_select.value ?? 0}} = 63) then substring(A.sty_cd,5,2) in ('63','83') -- 용품: 발육
             when ({{category_select.value ?? 0}} = 64) then substring(A.sty_cd,5,2) in ('64','84') -- 용품: 발육
             when ({{category_select.value ?? 0}} = 65) then substring(A.sty_cd,5,2) in ('65','85') -- 용품: 발육
             when ({{category_select.value ?? 0}} = 66) then substring(A.sty_cd,5,2) in ('66','86') -- 용품: 발육
             when ({{category_select.value ?? 0}} = 68) then substring(A.sty_cd,5,2) in ('68','88') -- 용품: 발육
           else '{{category_select.value ?? 0}}' = E.item_md_category_id end
and E.index = '{{ select_item_type.value }}'
ORDER BY 1 asc, in_rate asc