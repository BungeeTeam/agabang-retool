UPDATE item_md_assort 
SET price_memo = '{{ var_price_memo.value }}'
WHERE sty_col_cd = '{{ var_selected_item.value.sty_cd }}{{ var_selected_item.value.col_cd }}'