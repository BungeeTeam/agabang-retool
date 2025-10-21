const _list = {{var_check_parity_raw.value}}

const _cd_list = _list.reduce((acc, cur) => {
  acc.push(cur.sty_cd + cur.col_cd)
  return acc
}, [])



return _cd_list.map(item => `'${item}'`).join(', ')