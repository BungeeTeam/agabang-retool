SELECT
    A.sty_cd AS sty_cd,
    A.sty_nm AS sty_nm,
    A.col_cd,
    A.col_nm    
FROM agabang_dw.prod_sales_stock_by_size AS A
LEFT OUTER JOIN (
                    select
                        sty_cd,
                        max(sty_nm) as sty_nm,
                        max(cat_nm) as cat_nm
                    from agabang_dw.retooldb_item_md_info
                    group by 1
                ) as B
    ON A.sty_cd = B.sty_cd
JOIN agabang_dw.plstycd AS C
    ON A.comp_cd = C.comp_cd
    AND A.sty_cd = C.sty_cd
JOIN agabang_dw.cfcode AS D
    ON D.gbn_cd = 'PL003'
    AND C.year_cd = D.ref_cd
JOIN agabang_dw.cfcode AS E
    ON E.gbn_cd = 'PL005'
    AND C.sesn_cd = E.ref_cd
WHERE CONCAT(D.ref_nm, ' ', E.ref_nm) = '{{select_season.value}}'
AND B.cat_nm in ( {{multiselect_category.value.map(item => `'${item}'`).join(", ")}} )
GROUP BY 1, 2, 3, 4
ORDER BY 1, 2, 3
LIMIT 5;