const _data = {{formatDataAsArray(query_get_data.data)}}
const _result = {}
console.log(_data)
const _cat_list = _data.reduce((acc, cur) => {
  acc.push(cur.item_md_category_id)
  return acc
}, [])

const _cat_set = Array.from(new Set(_cat_list))

_cat_set.forEach(_id => {
  console.log(_id)
  const _target_list_best = _data.filter(item => item.item_md_category_id == _id && item.sort == 'BEST')
  const _target_list_worst = _data.filter(item => item.item_md_category_id == _id && item.sort == 'WORST')

  //  console.log(_target_list_best)

  if(_target_list_best.length + _target_list_worst.length > 0) {
    _result[_id] = {}  
  }
  
  _result[_id].best = _target_list_best
  _result[_id].worst = _target_list_worst
})

return _result