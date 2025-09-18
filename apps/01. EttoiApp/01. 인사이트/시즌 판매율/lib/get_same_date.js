//  const date = new Date(date_select.value);
//  let _date = new Date(date);
//  _date.setFullYear(date.getFullYear() - 1);

//  console.log(date);
//  console.log(date.toString());
//  console.log(_date);
//  console.log(_date.toString());

// date_select.value에서 날짜 가져오기 (예: "2025-03-13")
const date_this_yr = { value: date_select.value}; // 테스트용
const date = new Date(date_this_yr.value);

// 현재 날짜의 요일 구하기 (0=일요일, 6=토요일)
const currentDay = date.getDay();
console.log('오늘 날짜의 요일 번호',currentDay)
// 1년 전으로 설정
let previousYearDate = new Date(date);
previousYearDate.setFullYear(date.getFullYear() - 1);
console.log('1년전 날짜',previousYearDate.toISOString().split("T")[0])
// 요일 차이 계산
//  const previousDay = previousYearDate.getDay();
//  console.log('1년전 날짜의 요일번호',previousDay)
//  const dayDifference = currentDay - previousDay;
//  console.log('요일번호 차이',dayDifference)
//  // 요일이 같아지도록 조정
//  if (dayDifference !== 0) {
//      previousYearDate.setDate(previousYearDate.getDate() + dayDifference);
//  }
//  // 결과 출력 (YYYY-MM-DD 형식)
//  console.log("현재 날짜:", date.toISOString().split("T")[0]);       // "2025-03-13"
//  console.log("전년도 같은 요일 날짜:", previousYearDate.toISOString().split("T")[0]);// "2024-03-14"
//  console.log(moment(previousYearDate).format('YYYY-MM-DD'))
//  //  return previousYearDate.toISOString().split("T")[0]

const cur_days = '누계: ~ '+moment(date).format('YYYY-MM-DD')+' | 월간: '+ moment(date).startOf('month').format('YYYY-MM-DD')+ ' ~ '+moment(date).format('YYYY-MM-DD') + ' | 지난주: ' + moment(date).subtract('13','days').format('YYYY-MM-DD')  + ' ~ ' + moment(date).subtract('7','days').format('YYYY-MM-DD') + ' | 이번주: '+ moment(date).subtract('6','days').format('YYYY-MM-DD') + ' ~ ' + moment(date).format('YYYY-MM-DD')

const prev_days = '누계: ~ '+moment(previousYearDate).format('YYYY-MM-DD')+' | 월간: '+ moment(date).subtract(1,'years').startOf('month').format('YYYY-MM-DD')+ ' ~ '+moment(date).subtract(1,'years').format('YYYY-MM-DD') + ' | 지난주: ' + moment(previousYearDate).subtract('13','days').format('YYYY-MM-DD')  + ' ~ ' + moment(previousYearDate).subtract('7','days').format('YYYY-MM-DD') + ' | 이번주: '+ moment(previousYearDate).subtract('6','days').format('YYYY-MM-DD') + ' ~ ' + moment(previousYearDate).format('YYYY-MM-DD')

//  const cur_days = moment(date).startOf().

console.log(cur_days)

return {
  prev_date: moment(previousYearDate).format('YYYY-MM-DD'),
  cur: cur_days,
  prev: prev_days
}