const no_list = {{recent_no_season_list.data.year_sesn_cd}}
const _select = {{select_season.value}}

const _tf = {{checkbox1.value}}

const no_str = no_list.reduce((acc, cur) => {
  const str = `'${cur}'`
  acc.push(str)
  return acc
}, []).join(', ')

if(_tf) {
  return no_str
} else {
  return `'${_select}'`
}