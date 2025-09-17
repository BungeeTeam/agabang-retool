SELECT 
    -- 기본 정보
    D.sty_cd as sty_cd,
    D.sty_nm as sty_nm,
    D.col_nm as col_nm,
    COALESCE(A.plan_qty, 0) as plan_qty,
    D.br_cd,
    COALESCE(A.tot_sale_qty, 0) as tot_sale_qty,
    COALESCE(A.tot_in_qty, 0) as tot_in_qty,
    ROUND(COALESCE(A.tot_sale_qty, 0) / NULLIF(COALESCE(A.tot_in_qty, 0), 0), 2) as sale_per,
    COALESCE(A.int_sale_qty, 0) as int_sale_qty,
    COALESCE(D.fabric, COALESCE(B.fabric_extra, '')) as fabric,
    D.col_nm as col_nm,
    COALESCE(D.designer_nm, COALESCE(B.designer_nm_extra, '')) as designer_nm,
    COALESCE(D.cust_nm, COALESCE(B.prod_comp_extra, '')) as prod_comp,
    COALESCE(D.nation, COALESCE(B.prod_country_extra, '')) as prod_country,
    D.first_out_dt as fout_date,
    D.first_in_dt as fin_date,
    D.plan_dt as plan_date,
    D.tag_price as tag_prce,
    COALESCE(C.final_sale_prce, D.tag_price) as real_prce,
    D.cost_price as cost_prce,
    ROUND(D.tag_price / NULLIF(D.cost_price * 1.1, 0), 2) as markup,
    COALESCE(A.tot_in_tag_amt, 0) as tot_in_tag_amt,
    COALESCE(A.tot_sale_amt, 0) as tot_sale_amt,
    ROUND(COALESCE(A.tot_sale_amt, 0) / NULLIF(COALESCE(A.tot_in_tag_amt, 0), 0), 2) as sale_amt_per,
    ROUND(COALESCE(A.tot_sale_amt, 0) / NULLIF(COALESCE(A.tot_cost_amt, 0) * 1.1, 0), 2) as sale_return_per,
    -- dim_style에서 추가된 카테고리 필드들
    D.large_cat,
    D.middle_cat,
    D.small_cat,
    D.it_nm,
    D.it_gb_nm,
    D.item_nm,
    D.item as item

FROM agabang_dw.dim_style D
-- 판매/재고 정보 LEFT JOIN (데이터가 없어도 기본 정보는 표시)
LEFT JOIN agabang_dw.prod_sales_stock_by_color A 
    ON D.sty_cd = A.sty_cd AND D.col_cd = A.col_cd
-- 현재 판매가 정보 LEFT JOIN (최신 가격 정보 가져오기)
LEFT JOIN (
    SELECT 
        sty_cd,
        col_cd,
        argMax(final_sale_prce, COALESCE(prce_str_dt, info_str_dt, '1900-01-01')) as final_sale_prce
    FROM agabang_dw.prod_final_price
    GROUP BY sty_cd, col_cd
) C ON D.sty_cd = C.sty_cd AND D.col_cd = C.col_cd
-- 추가 상품 정보 LEFT JOIN (보완 정보)
LEFT JOIN (
    SELECT
        sty_cd,
        argMax(fabric, id) as fabric_extra,
        argMax(designer_nm, id) as designer_nm_extra,
        argMax(prod_comp, id) as prod_comp_extra,
        argMax(prod_country, id) as prod_country_extra
    FROM agabang_dw.retooldb_item_md_info
    WHERE sty_cd IS NOT NULL
    GROUP BY sty_cd
) B ON D.sty_cd = B.sty_cd

WHERE D.sty_cd = '{{sel_sty.value?.sty_cd }}'
  AND D.col_cd = '{{sel_sty.value?.col_cd }}'
LIMIT 1