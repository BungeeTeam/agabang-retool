with 
  '{{brand_code.value }}' as brand_code,
STY_COL as (
    select
            year_sesn_nm_eng,
            sty_cd,
            col_cd,
            sty_nm,
            col_nm,
            fabric,
            preview_grade,
            preview_score,
            opinion,
            cat_nm,
            middle_cat,
            cat_id,
            item_raw_nm,
            coalesce(md_sale_price, 0) as md_sale_price,
            coalesce(md_sale_price_final, 0) as md_sale_price_final,
            case when md_cost_price_final is not null then md_cost_price_final else coalesce(md_cost_price, 0) end as md_cost_price,
            prod_comp
     from (select
                     C.year_sesn_nm_eng as year_sesn_nm_eng,
                     A.sty_cd        as sty_cd,
                     A.col_cd        as col_cd,
--                      B.sty_nm        as sty_nm,
                     dim.sty_nm as sty_nm,
                     D.col_nm        as col_nm,
--                      E.fabric        as fabric,
                     dim.fabric as fabric,
                     E.preview_grade as preview_grade,
                     E.preview_score as preview_score,
                     E.opinion       as opinion,
                     E.item_md_category_id as cat_id,
                     dim.large_cat as cat_nm,
                     dim.middle_cat as middle_cat,
                     dim.small_cat as item_raw_nm,
                     -- F.cat_nm        as cat_nm,
                     -- E.item_raw_nm   as item_raw_nm,
                     E.sale_price      as md_sale_price,
                     E.sale_price_final as md_sale_price_final,
                     E.cost_price as md_cost_price,
                     E.cost_price_final as md_cost_price_final,
                     dim.cust_nm as prod_comp
              from agabang.plcoszcd as A
--                    join agabang.plstycd as B
--                         on A.sty_cd = B.sty_cd
                   join agabang_dw.retooldb_code_season as C
                        on substring(A.sty_cd, 3, 2) = C.year_sesn_cd
                            and C.sesn_cd in (0, 1, 3, 5, 7)
                   join agabang.plcolcd as D
                        on A.col_cd = D.col_cd
                   left outer join agabang_dw.retooldb_item_md_info as E
                                   on A.sty_cd = E.sty_cd
                   left outer join agabang_dw.retooldb_item_md_category as F
                                   on E.item_md_category_id = F.id
                   left outer join (
                       SELECT
                           distinct br_cd,sty_cd,sty_nm,
                                    cust_cd, cust_nm, nation, designer, designer_nm, fabric,
                                    preview_cd, preview_grade, preview_score, opinion,
                                    large_cat, middle_cat, small_cat, item_md_category_id
                       FROM agabang_dw.dim_style
                         )as dim ON A.sty_cd = dim.sty_cd
where --B.br_cd = brand_code
        dim.br_cd = brand_code
                and C.year_sesn_nm_eng in ( {{ var_season_list.value?.map(item => `'${item}'`).join(", ") }} )
                and F.id = '{{ select_category.value }}'
                and dim.middle_cat = '{{ select_category_item2.value }}'
                and dim.small_cat in ( {{ select_category_item.value?.map(item => `'${item}'`).join(", ") }} )
              ) as T
     group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,17
),
STY_COL_SIZE as (
                SELECT
                    sty_cd,
                    col_cd,
                    groupArray(size_cd)    AS arr_cd,
                    groupArray(size_nm)    AS size_nm_list,
                    groupArray(tot_in_qty) AS size_in_qty_list
                FROM (
                    SELECT
                    *
                    FROM agabang_dw.prod_sales_stock_by_size
                    where br_cd = brand_code
                    ORDER BY sty_cd, col_cd, size_cd
                     ) AS T
                GROUP BY sty_cd, col_cd
                )
                
select
    STY_COL.*,
    STY_COL.sty_cd as sty_cd,
    STY_COL.sty_nm as sty_nm,
    STY_COL.col_cd as col_cd,
    STY_COL.col_nm as col_nm,            
    A.md_memo as md_memo,
    A.final_lot as final_lot,
    A.final_memo as final_memo,
    A.final_assort as final_assort,
    B.tag_prce as tag_prce,
    B.cost_prce as cost_prce,
    B.tot_in_qty,
    B.tot_sale_qty as tot_sale_qty,
    STY_COL_SIZE.size_nm_list as size_nm_list,
    STY_COL_SIZE.size_in_qty_list as size_in_qty_list,
    case 
        when B.tag_prce > 0 then B.tag_prce
        when STY_COL.md_sale_price_final > 0 then STY_COL.md_sale_price_final
        when STY_COL.md_sale_price > 0 then STY_COL.md_sale_price
        else 0
    end as item_price,
    case
        when B.cost_prce > 0 then B.cost_prce
        when STY_COL.md_cost_price > 0 then STY_COL.md_cost_price
        else 0
    end as cost_price,
    case 
        when B.tot_in_qty > 0  then B.tot_in_qty
        when A.final_lot > 0 then A.final_lot
        else 0
    end as tot_in_qty,
    AA.price_memo as price_memo
from STY_COL
left outer join agabang_dw.retooldb_item_md_assort as A
  on concat(STY_COL.sty_cd, STY_COL.col_cd) = A.sty_col_cd
    and A.final_check = TRUE
left outer join agabang_dw.retooldb_item_md_assort as AA
  on concat(STY_COL.sty_cd, STY_COL.col_cd) = AA.sty_col_cd
left outer join agabang_dw.prod_sales_stock_by_color as B
  on STY_COL.sty_cd = B.sty_cd
    and STY_COL.col_cd = B.col_cd
left outer join STY_COL_SIZE
  on STY_COL.sty_cd = STY_COL_SIZE.sty_cd
    and STY_COL.col_cd = STY_COL_SIZE.col_cd
-- where A.br_cd = brand_code
order by STY_COL.cat_nm, STY_COL.sty_nm;