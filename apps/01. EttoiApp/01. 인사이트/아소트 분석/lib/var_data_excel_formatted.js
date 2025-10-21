const _table = {{table_main2.data}}

const _size_type_col = ['3m', '6m', '12m', '18m', '2y', '3y', '4y']

const _size_label_list = {
  size_3m: ["3M", "3M", "70", "FREE", "100", "FREE"],
  size_6m: ["6M", "6M", "75", "42", "115", "7-8"],
  size_12m: ["12M", "12M", "80", "44", "125", "9-10"],
  size_18m: ["18M", "18M", "90", "46", "130", "11-12"],
  size_2y: ["2Y", "2T", "100", "48", "140", "13-14"],
  size_3y: ["3Y", "3T", "110", "50", "150", "15-16"],
  size_4y: ["4Y", "4T", "120", "52", "", ""]
}

const _other_label_list = {
  sale_dt: '기준일자',
  sty_cd: '품번',
  col_cd: '칼라코드',
  col_nm: '칼라',
  sty_nm: '제품명',
  color_plan_qty: '기획량',
  color_cum_in_qty: '입고량',
  tot_in_rate: '입고비중',
  color_cum_sale_qty: '판매량',
  tot_size_sale_rate: '판매비중',
  color_sale_rate: '소진율'
}

function _find_size_label(key, idx) {
  const _size = _size_type_col.find(col => key.includes(col))
  const _size_label = _size_label_list[`size_${_size}`]

  if(_size_label) {
    return _size_label[idx]
  }
  
  return null
}

const _result = []

// 첫번째 행은 _other_label_list도 봐야함

for(let i=0; i<6; i++) {

  const _row = {}
  
  Object.keys(_table[0]).forEach(key => {
    
    const _size = _find_size_label(key, i)
    const _other = (i == 0 ? _other_label_list[key] : null)
    
    if(_other) {
      _row[key] = _other
    } else if(_size) {
      _row[key] = _size
    } else {
      _row[key] = ''
    }
  })
  
  _result.push(_row)
}

_result.push(..._table)

return _result