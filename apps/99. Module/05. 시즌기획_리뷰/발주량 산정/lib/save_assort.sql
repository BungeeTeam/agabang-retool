INSERT INTO item_md_assort 
(sty_col_cd, lot, assort, related_items, md_memo, br_cd)
VALUES
('{{ var_main_item_info.value.sty_cd }}{{ var_main_item_info.value.col_cd }}', '{{ lot_qty.value }}', '{{ JSON.stringify(var_assort.value) }}', '{{ JSON.stringify(var_selected_related_items.value) }}',
'{{ md_memo.value}}', '{{var_brand_code.value }}')
ON CONFLICT (sty_col_cd)
DO UPDATE SET
  lot = EXCLUDED.lot,
  assort = EXCLUDED.assort,
  related_items = EXCLUDED.related_items,
  md_memo = EXCLUDED.md_memo,
  br_cd = EXCLUDED.br_cd
