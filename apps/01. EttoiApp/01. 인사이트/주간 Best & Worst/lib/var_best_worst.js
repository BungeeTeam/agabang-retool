const _data = {{formatDataAsArray(query_get_data.data)}}
const _result = {}

const _cat_list = _data.reduce((acc, cur) => {
  acc.push(cur.new_cat)
  return acc
}, [])

const _cat_set = Array.from(new Set(_cat_list))

_cat_set.forEach(cat => {
  console.log(cat)
  const _target_list_best = _data.filter(item => item.new_cat == cat && item.sort == 'BEST')
  const _target_list_worst = _data.filter(item => item.new_cat == cat && item.sort == 'WORST')

  //  console.log(_target_list_best)

  if(_target_list_best.length + _target_list_worst.length > 0) {
    _result[cat] = {}  
  }
  
  _result[cat].best = _target_list_best
  _result[cat].worst = _target_list_worst
})

return _result