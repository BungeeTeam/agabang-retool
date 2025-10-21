WITH
    '{{brand_code.value}}' as brand_code,
    '{{season_select.value}}' as season_code
      
SELECT
    --substring(A.sty_cd,1,2) AS br_cd
    count(A.sty_cd) AS sty_cd,
    -- A.sty_nm AS sty_nm,
    -- A.col_cd AS col_cd,
    -- A.col_nm AS col_nm,
--     A.size_cd AS size_cd,
--     A.size_nm AS size_nm,
    MAX(E.cat_raw_nm) AS cat_raw_nm, -- 대분류
    -- E.cat_nm as cat_nm, -- 중분류
    -- E.item_raw_nm AS item_raw_nm, -- 소분류
    -- A.tag_prce AS tag_prce, -- 정가
    -- A.cost_prce AS cost_prce, -- 원가(VAT미포함)
    --A.add_no AS add_no,
    sum(A.tot_in_qty) AS tot_in_qty, -- 누적입고수량
    -- A.tot_in_tag_amt AS tot_in_tag_amt, -- 누적입고금액(tag)
    -- A.fin_date AS fin_dt, -- 최초입고일자
    sum(A.plan_qty) AS plan_qty, -- 작지상의 기획수량(발주수량과 상이할 가능성 있음)
    -- A.deli_dt AS deli_dt, -- 납기일=입고예정일
    -- A.ord_dt AS ord_dt, -- 발주일자
    -- A.cust_cd AS cust_cd, -- 생산처코드
    -- D.cust_nm AS cust_nm, -- 생산처이름
    sum(A.tot_in_qty)/sum(A.plan_qty) AS in_rate -- 입고율
-- if(dateDiff('day',A.ord_dt,A.fin_date)>0,dateDiff('day',A.ord_dt,A.fin_date),-1) AS lead_time, -- 리드타임
-- if(dateDiff('day',A.deli_dt,A.fin_date)>0,dateDiff('day',A.deli_dt,A.fin_date),-1) AS delay_days -- 지연일수
FROM agabang_dw.prod_sales_stock_by_color AS A -- 입고 테이블
-- LEFT JOIN agabang.prgodord AS B ON A.sty_cd = B.sty_cd -- 발주테이블
-- JOIN agabang.plcoszqty AS C ON A.sty_cd = C.sty_cd AND A.col_cd = C.col_cd and A.size_cd = C.size_cd --작지테이블
JOIN agabang.prcust AS D ON A.cust_cd = D.cust_cd
LEFT JOIN agabang_dw.retooldb_item_md_info as E ON A.sty_cd = E.sty_cd
WHERE substring(A.sty_cd,1,2) = brand_code
    AND substring(A.sty_cd,3,2) = season_code
    AND A.plan_qty is not null
GROUP BY E.item_md_category_id;