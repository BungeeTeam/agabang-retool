const _data = {{formatDataAsArray(query_get_threshold.data)}}

function each_sum(obj, target) {
  let _sum = 0
  
  for(const [key, value] of Object.entries(obj)) {
  
    const _key_split = key.split('_')
    const _key_format = _key_split
      .splice(0, _key_split.length - 1).join('_')
    
    if(_key_format == target) {
     _sum += value
    }
  }

  return _sum
}

const _sum_list = ['plan_qty', 'in_qty', 'in_rate', 'sale_qty', 'size_sale_rate', 'size_sale_rate_color']

const _ret_val = _data.map(item => {

  _sum_list.forEach(_sum => {
   item[`each_sum_${_sum}`] = each_sum(item, _sum)
  })

  item.check_sum_plan_qty = (item.each_sum_plan_qty !== item.color_plan_qty)

  item.check_in_qty = (item.each_sum_in_qty !== item.color_cum_in_qty)

  item.check_sale_qty = (item.each_sum_sale_qty !== item.color_cum_sale_qty)

  item.check_in_rate = (Math.abs(item.each_sum_in_rate - 1) > 0.01)

  item.check_sale_rate_color = (Math.abs(item.each_sum_size_sale_rate_color - 1) > 0.01)
  
  return item
  
})

const _filtered = _ret_val.filter(item => {
  return item.check_sum_plan_qty
    || item.check_in_qty
    || item.check_sale_qty
    || item.check_in_rate
    || item.check_sale_rate_color
})

return _filtered