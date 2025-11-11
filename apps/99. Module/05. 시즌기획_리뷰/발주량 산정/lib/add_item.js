const newItem = {
  "code": table_items_related.selectedRow.sty_cd + table_items_related.selectedRow.col_cd,
  "sty_cd": table_items_related.selectedRow.sty_cd,
  "col_cd": table_items_related.selectedRow.col_cd
}

//  if (!var_selected_related_items.value?.some(item => item.code === newItem.code)) {
//    var_selected_related_items.setValue( [...var_selected_related_items.value, newItem]);
//  }

if(var_selected_related_items.value){
  if (!var_selected_related_items.value.some(item => item.code === newItem.code)) {
    var_selected_related_items.setValue( [...var_selected_related_items.value, newItem]);
  }  
}
