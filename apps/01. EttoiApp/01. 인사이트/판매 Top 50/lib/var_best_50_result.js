const _list = {{get_best_50.data}}

const _ret_val = _list.map((item, index) => {

  item.rank_diff = item.sale_rank_prev - item.sale_rank

  return item
  
})

return _ret_val