WITH
  '07' AS brand_code,
STY_COL AS (
    SELECT
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
            cat_id,
            item_raw_nm,
            coalesce(md_sale_price, 0) AS md_sale_price,
            coalesce(md_sale_price_final, 0) AS md_sale_price_final,
            CASE WHEN md_cost_price_final IS NOT NULL THEN md_cost_price_final ELSE coalesce(md_cost_price, 0) END AS md_cost_price,
            prod_comp
     FROM (
            SELECT
                     C.year_sesn_nm_eng AS year_sesn_nm_eng,
                     A.sty_cd        AS sty_cd,
                     A.col_cd        AS col_cd,
                     dim.sty_nm AS sty_nm,
                     D.col_nm        AS col_nm,
                     dim.fabric AS fabric,
                     E.preview_grade AS preview_grade,
                     E.preview_score AS preview_score,
                     E.opinion       AS opinion,
                     E.item_md_category_id AS cat_id,
                     F.cat_nm        AS cat_nm,
                     E.item_raw_nm   AS item_raw_nm,
                     E.sale_price      AS md_sale_price,
                     E.sale_price_final AS md_sale_price_final,
                     E.cost_price AS md_cost_price,
                     E.cost_price_final AS md_cost_price_final,
                     dim.cust_nm AS prod_comp
              FROM agabang.plcoszcd AS A
                   JOIN agabang_dw.retooldb_code_season AS C
                        ON substring(A.sty_cd, 3, 2) = C.year_sesn_cd
                            AND C.sesn_cd IN (0, 1, 3, 5, 7)
                   JOIN agabang.plcolcd AS D
                        ON A.col_cd = D.col_cd
                   LEFT OUTER JOIN agabang_dw.retooldb_item_md_info AS E
                                   ON A.sty_cd = E.sty_cd
                   LEFT OUTER JOIN agabang_dw.retooldb_item_md_category AS F
                                   ON E.item_md_category_id = F.id
                   LEFT OUTER JOIN (
                       SELECT
                           DISTINCT br_cd,sty_cd,sty_nm,
                                    cust_cd, cust_nm, nation, designer, designer_nm, fabric,
                                    preview_cd, preview_grade, preview_score, opinion,
                                    large_cat, middle_cat, small_cat, item_md_category_id
                       FROM agabang_dw.dim_style
                         )AS dim ON A.sty_cd = dim.sty_cd
            WHERE dim.br_cd = brand_code
                AND C.year_sesn_nm_eng IN ( {{ var_season_list.value?.map(item => `'${item}'`).join(", ") }} )
                AND ('{{ !select_category.value || select_category.value === "" }}' = 'true' OR E.item_md_category_id = '{{ select_category.value }}')
                AND ({{ !select_category_item.value || select_category_item.value.length == 0 }} OR E.item_raw_nm IN splitByString(',', '{{ select_category_item.value?.join(',') }}'))
                AND ({{ !textInput1.value || textInput1.value.trim() === '' }} OR 
                     positionCaseInsensitive(E.sty_nm, '{{ textInput1.value }}') > 0 OR 
                     positionCaseInsensitive(A.sty_cd, '{{ textInput1.value }}') > 0)
              ) AS T
     GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
),
STY_COL_SIZE AS (
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
                    WHERE br_cd = brand_code
                    ORDER BY sty_cd, col_cd, size_cd
                     ) AS T
                GROUP BY sty_cd, col_cd
                )
SELECT
    STY_COL.*,
    STY_COL.sty_cd AS sty_cd,
    STY_COL.sty_nm AS sty_nm,
    STY_COL.col_cd AS col_cd,
    STY_COL.col_nm AS col_nm,            
    A.md_memo AS md_memo,
    A.final_lot AS final_lot,
    A.final_memo AS final_memo,
    A.final_assort AS final_assort,
    B.tag_prce AS tag_prce,
    B.cost_prce AS cost_prce,
    B.tot_in_qty,
    B.tot_sale_qty AS tot_sale_qty,
    STY_COL_SIZE.size_nm_list AS size_nm_list,
    STY_COL_SIZE.size_in_qty_list AS size_in_qty_list,
    CASE 
        WHEN B.tag_prce > 0 THEN B.tag_prce
        WHEN STY_COL.md_sale_price_final > 0 THEN STY_COL.md_sale_price_final
        WHEN STY_COL.md_sale_price > 0 THEN STY_COL.md_sale_price
        ELSE 0
    END AS item_price,
    CASE
        WHEN B.cost_prce > 0 THEN B.cost_prce
        WHEN STY_COL.md_cost_price > 0 THEN STY_COL.md_cost_price
        ELSE 0
    END AS cost_price,
    CASE 
        WHEN B.tot_in_qty > 0  THEN B.tot_in_qty
        WHEN A.final_lot > 0 THEN A.final_lot
        ELSE 0
    END AS tot_in_qty,
    AA.price_memo AS price_memo
FROM STY_COL
LEFT OUTER JOIN agabang_dw.retooldb_item_md_assort AS A
  ON concat(STY_COL.sty_cd, STY_COL.col_cd) = A.sty_col_cd
    AND A.final_check = TRUE
LEFT OUTER JOIN agabang_dw.retooldb_item_md_assort AS AA
  ON concat(STY_COL.sty_cd, STY_COL.col_cd) = AA.sty_col_cd
LEFT OUTER JOIN agabang_dw.prod_sales_stock_by_color AS B
  ON STY_COL.sty_cd = B.sty_cd
    AND STY_COL.col_cd = B.col_cd
LEFT OUTER JOIN STY_COL_SIZE
  ON STY_COL.sty_cd = STY_COL_SIZE.sty_cd
    AND STY_COL.col_cd = STY_COL_SIZE.col_cd
ORDER BY STY_COL.cat_nm, STY_COL.sty_nm;