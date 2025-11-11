update item_md_assort SET
  final_lot = '{{ lot_qty_final.value }}',
  final_assort = '{{ JSON.stringify(var_assort_final.value) }}',
  final_memo = '{{ final_memo.value }}',
  price_memo = '{{ price_memo.value }}',
  final_check = TRUE
where sty_col_cd = '{{ var_main_item_info.value.sty_cd }}{{ var_main_item_info.value.col_cd }}'
and br_cd='{{var_brand_code.value }}'