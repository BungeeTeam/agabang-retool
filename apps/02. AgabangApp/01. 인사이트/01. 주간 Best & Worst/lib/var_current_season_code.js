const _list = {{formatDataAsArray(season_list.data)}}

let _target_year = String(moment().year())

let _target_season
console.log(moment().month())

switch(moment().month()) {
  case 12:
  case 1:
  case 2:
    _target_season = '7'
    break
  case 3:
  case 4:
  case 5:
    _target_season = '1'
    break
  case 6:
  case 7:
  case 8:
    _target_season = '3'
    break
  case 9:
  case 10:
  case 11:
    _target_season = '5'
    break
  default:
    _target_season = '0'
}

const _year_code = _list
  .filter(item => {
    return item['year_nm'] == String(moment().year())
  })
  .filter(item => {
    return item['sesn_cd'] == _target_season
  })

return _year_code