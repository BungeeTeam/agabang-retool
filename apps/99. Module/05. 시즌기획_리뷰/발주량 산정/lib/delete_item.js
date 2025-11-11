const code = var_delete_item.value;

var_selected_related_items.setValue(var_selected_related_items.value.filter(item => item.code !== code))