WITH
    toDate('{{p_endDate}}') as endDate, --판매 마감일
    toDate('{{ p_seasonEndDate }}') as seasonEndDate, -- 전년도 시즌 종료일: 출고 시작일
    toDate('{{ p_outEndDate }}') as outEndDate, -- 출고 마감일
    '{{ brandMultiSelect2.value }}' as brand_code,
    '{{ yearSelect2.selectedItem.season_cd }}' as season_code,
    '{{ bizMultiSelect2.value }}' as biz_code,
({{ p_year_codes }}) as year_code,
[{{ p_year_codes }}] as year_code_array,
      

    dsmove as (SELECT sty_cd, col_cd,
                      sum(CASE WHEN in_wh_cd = '3000' THEN fix_qty ELSE 0 END)  as mv_in_qty,
                      sum(CASE WHEN out_wh_cd = '3000' THEN fix_qty ELSE 0 END) as mv_out_qty
               FROM agabang.dsmove as A
               WHERE toDate(move_dt) between seasonEndDate and endDate
               group by sty_cd, col_cd),
    dsin as (SELECT sty_cd, col_cd,
                    sum(in_qty) as in_qty
            from agabang.dsin
            WHERE wh_cd = '3000'
            and toDate(in_dt) between seasonEndDate and endDate
            group by sty_cd, col_cd),
    itemBase as(
           SELECT
            distinct
            sty_cd, sty_nm,
            col_cd, col_nm,
            tag_price, cost_price,
            br_cd, br_nm,
            year_nm, year_cd,
            season_cd, season_nm,
            concat(year_cd, season_cd) as year_season_cd,
           CASE WHEN year_cd = year_code_array[1] THEN 'B'
                WHEN year_cd = year_code_array[2] THEN 'C'
                WHEN year_cd = year_code_array[3] THEN 'D'
               ELSE 'under D' END as item_grade,
           CASE WHEN it = '1' THEN '시즌언더'
    WHEN it = '2' THEN '시즌의류(B)'
    WHEN it = '3' THEN '시즌의류(T)'
    WHEN it = '4' THEN '파자마'
    WHEN it = '5' AND it_gb = '57' THEN '기획언더'
    WHEN it = '5' THEN '기획의류'
    WHEN it = '6' THEN '위탁용품'
    WHEN it = '7' THEN '시즌용품'
    WHEN it = '8' THEN '일반용품'
    WHEN it = '9' THEN '판촉부자재'
  ELSE '기타' END AS category_name,
          CASE WHEN it = '1' THEN '2'
    WHEN it = '2' THEN '0'
    WHEN it = '3' THEN '1'
    WHEN it = '4' THEN '3'
    WHEN it = '5' AND it_gb = '57' THEN '6'
    WHEN it = '5' THEN '5'
    WHEN it = '6' THEN '7'
    WHEN it = '7' THEN '4'
    WHEN it = '8' THEN '8'
    WHEN it = '9' THEN '9'
  ELSE '기타' END AS category_order
        FROM agabang_dw.dim_style
        WHERE
            year_cd in year_code
            and it in ('1','2','3','4','5','7')
            and br_cd in (brand_code)
            and season_cd = season_code
        )

SELECT
    D.br_cd as br_cd,D.br_nm as br_nm,
    D.year_cd as year_cd, D.year_nm as year_nm,
    D.season_cd as season_cd, D.season_nm as season_nm,
    D.year_season_cd as year_season_cd,
    A.sty_cd as sty_cd,
    D.category_name as category_name, D.category_order, D.item_grade, '온라인' as onoff_flag,
    mv_in_qty + coalesce(in_qty,0) as ttl_out_qty,
    (mv_in_qty + coalesce(in_qty,0))*C.tag_price as ttl_out_tag,
    (mv_in_qty + coalesce(in_qty,0))*sale_price as ttl_out_amt,
    mv_out_qty as ttl_rtn_qty,
    mv_out_qty*C.tag_price as ttl_rtn_tag,
    mv_out_qty*sale_price as ttl_rtn_amt,
    (mv_in_qty + coalesce(in_qty,0) - mv_out_qty) as net_out_qty,
    (mv_in_qty + coalesce(in_qty,0) - mv_out_qty) * C.tag_price as net_out_tag,
    (mv_in_qty + coalesce(in_qty,0) - mv_out_qty) * sale_price as net_out_amt
FROM dsmove as A
LEFT JOIN dsin as B ON A.sty_cd = B.sty_cd and A.col_cd = B.col_cd
JOIN(
    SELECT
        distinct sty_cd, tag_prce as tag_price, f_sale_prce as sale_price
    FROM agabang_dw.prod_sales_stock_by_color
) as C ON A.sty_cd = C.sty_cd
LEFT JOIN itemBase as D ON A.sty_cd = D.sty_cd and A.col_cd = D.col_cd
WHERE substring(A.sty_cd,5,1) not in ('6','8','9')
and substring(A.sty_cd,3,1) in year_code ;