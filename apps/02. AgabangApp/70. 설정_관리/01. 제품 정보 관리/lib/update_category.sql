update item_md_info
set cat_nm = '{{item_table.changesetArray[0].category }}'
where id = '{{ item_table.changesetArray[0].id }}'