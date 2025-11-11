// season_list 쿼리 결과 가져오기 
const _list = {{formatDataAsArray(season_list.data)}}

// 현재 날짜 정보
const currentDate = moment();
const currentMonth = currentDate.month() + 1; // moment는 0부터 시작하므로 +1
const currentDay = currentDate.date();

// 현재 날짜에 해당하는 시즌 찾기
let _target_year = String(moment().year());
let _target_season = '0'; // 기본값

// _list를 순회하며 현재 날짜에 해당하는 시즌 찾기
for (const season of _list) {
  const seasonMonth = season.start_month;
  const seasonDay = season.start_day;
  
  // 시즌 시작일을 moment 객체로 생성
  // 연도 처리: 시즌 시작월이 10-12월인 경우 전년도로 설정
  let seasonYear = parseInt(season.year_nm);
  if (seasonMonth >= 10) {
    seasonYear = seasonYear - 1;
  }
  
  const seasonStartMoment = moment()
    .year(seasonYear)
    .month(seasonMonth - 1)  // moment는 0부터 시작
    .date(seasonDay);
  
  // 현재 날짜가 이 시즌 시작일 이후인지 확인
  if (currentDate.isSameOrAfter(seasonStartMoment)) {
    _target_year = season.year_nm;
    _target_season = season.sesn_cd;
    break;
  }
}

// season_list 전체 데이터에서 선택된 연도와 시즌에 해당하는 데이터만 필터링
// (이미 쿼리에서 현재 브랜드의 데이터만 가져왔으므로 year_nm과 sesn_cd만 체크)
const _year_code = _list
  .filter(item => {
    return item['year_nm'] == _target_year
  })
  .filter(item => {
    return item['sesn_cd'] == _target_season
  })

// 최종 필터링된 데이터를 반환합니다.
return _year_code