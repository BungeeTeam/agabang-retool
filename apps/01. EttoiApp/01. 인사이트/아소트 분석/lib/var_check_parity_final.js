const _list = {{var_check_parity_raw.value}}
const _size_list = {{query_parity_target_size_list.data}}

const _ret_val = _list.map(item => {
  const _size = _size_list.find(i => i.sty_cd == item.sty_cd && i.col_cd == item.col_cd)

  if(_size) {
    item.size_list = _size.size_list
  }
  
})

return _list