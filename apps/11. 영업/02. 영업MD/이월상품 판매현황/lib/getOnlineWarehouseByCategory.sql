WITH
    toDate('{{p_endDate}}') as endDate, --판매 마감일
    toDate('{{ p_seasonEndDate }}') as seasonEndDate, -- 전년도 시즌 종료일: 출고 시작일
    toDate('{{ p_outEndDate }}') as outEndDate, -- 출고 마감일
    '{{ brandMultiSelect2.value }}' as brand_code,
    '{{ yearSelect2.selectedItem.season_cd }}' as season_code,
    '{{ bizMultiSelect2.value }}' as biz_code,
({{ p_year_codes }}) as year_code,
[{{ p_year_codes }}] as year_code_array,
      
    dsmove as (SELECT sty_cd,
                      sum(CASE WHEN in_wh_cd = '3000' THEN fix_qty ELSE 0 END)  as mv_in_qty,
                      sum(CASE WHEN out_wh_cd = '3000' THEN fix_qty ELSE 0 END) as mv_out_qty
               FROM agabang.dsmove as A
               WHERE toDate(move_dt) between seasonEndDate and outEndDate
               group by sty_cd),
    dsin as (SELECT sty_cd,
                    sum(in_qty) as in_qty
            from agabang.dsin
            WHERE wh_cd = '3000'
            and toDate(in_dt) between seasonEndDate and outEndDate
            group by sty_cd)

SELECT
    substring(A.sty_cd,1,2) as br_cd,
    substring(A.sty_cd,3,1) as year_cd,
    substring(A.sty_cd,4,1) as season_cd,
    substring(A.sty_cd,3,2) as year_season_cd,
    coalesce(A.sty_cd, B.sty_cd) as sty_cd,
    CASE WHEN substring(A.sty_cd,5,1) = '1' THEN '시즌언더'
        WHEN substring(A.sty_cd,5,1) = '2' THEN '시즌의류(B)'
        WHEN substring(A.sty_cd,5,1) = '3' THEN '시즌의류(T)'
        WHEN substring(A.sty_cd,5,1) = '4' THEN '파자마'
        WHEN substring(A.sty_cd,5,1) = '5' and substring(A.sty_cd,5,2) = '57' THEN '기획언더'
        WHEN substring(A.sty_cd,5,1) = '5' THEN '기획의류'
        WHEN substring(A.sty_cd,5,1) = '7' THEN '시즌용품'
        ELSE '기타' END as category_name,
    mv_in_qty + coalesce(in_qty,0) as ttl_out_qty,
    (mv_in_qty + coalesce(in_qty,0))*tag_price as ttl_out_tag,
    (mv_in_qty + coalesce(in_qty,0))*sale_price as ttl_out_amt,
    mv_out_qty as ttl_rtn_qty,
    mv_out_qty*tag_price as ttl_rtn_tag,
    mv_out_qty*sale_price as ttl_rtn_amt,
    (mv_in_qty + coalesce(in_qty,0) - mv_out_qty) as net_out_qty,
    (mv_in_qty + coalesce(in_qty,0) - mv_out_qty) * tag_price as net_out_tag,
    (mv_in_qty + coalesce(in_qty,0) - mv_out_qty) * sale_price as net_out_amt
FROM dsmove as A
LEFT JOIN dsin as B ON A.sty_cd = B.sty_cd
JOIN(
    SELECT
        distinct sty_cd, tag_prce as tag_price, f_sale_prce as sale_price
    FROM agabang_dw.prod_sales_stock_by_color
) as C ON A.sty_cd = C.sty_cd
WHERE substring(A.sty_cd,5,1) not in ('6','8','9') 
    and substring(A.sty_cd,3,1) in year_code ;