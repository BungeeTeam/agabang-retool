SELECT 
    id, 
    group_id, 
    sty_cd, 
    sty_nm, 
    col_cd, 
    col_nm, 
    size_nm, 
    final_reorder_qty, 
    tag_price, 
    modifiable_cost_price, 
    price_reorder_multiple, 
    created_by, 
    created_at + INTERVAL '9 hours' as created_at,  -- 단순히 9시간 추가
    exclude_at_reorder_target_list, 
    md_memo
FROM reorder_md_decision
WHERE sty_cd LIKE '{{var_brand_code.value}}%'
AND type = 'seasonless'
AND created_at >= CURRENT_DATE - INTERVAL '60 days'  -- 최근 60일간의 데이터