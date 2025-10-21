const _list = {{formatDataAsArray(season_list.data)}}

// 현재 연도를 가져와 문자열로 저장합니다. (예: "2025")
let _target_year = String(moment().year())

// 현재 계절 코드를 저장할 변수를 선언합니다.
let _target_season

// 현재 월을 콘솔에 출력하여 디버깅에 도움을 줍니다.
// moment().month()는 0(1월)부터 11(12월)까지의 값을 반환합니다.
console.log(moment().month())

// 현재 월에 따라 계절 코드를 결정합니다.
switch(moment().month()) {
  // 11월 (10), 12월 (11), 1월 (0)은 '겨울' (코드 '7')
  case 10:
  case 11:
  case 0:
    _target_season = '7'
    break
  // 2월 (1), 3월 (2), 4월 (3)은 '봄' (코드 '1')
  case 1:
  case 2:
  case 3:
    _target_season = '1'
    break
  // 5월 (4), 6월 (5), 7월 (6)은 '여름' (코드 '3')
  case 4:
  case 5:
  case 6:
    _target_season = '3'
    break
  // 8월 (7), 9월 (8), 10월 (9)은 '가을' (코드 '5')
  case 7:
  case 8:
  case 9:
    _target_season = '5'
    break
  // 위에 해당하지 않는 경우 기본값 '0'
  default:
    _target_season = '0'
}

// _list에서 현재 연도와 현재 계절에 해당하는 데이터를 필터링합니다.
const _year_code = _list
  // 첫 번째 필터: 'year_nm' 속성값이 현재 연도와 일치하는 항목만 선택합니다.
  .filter(item => {
    return item['year_nm'] == String(moment().year())
  })
  // 두 번째 필터: 'sesn_cd' 속성값이 결정된 현재 계절 코드와 일치하는 항목만 선택합니다.
  .filter(item => {
    return item['sesn_cd'] == _target_season
  })

// 최종 필터링된 데이터를 반환합니다.
return _year_code