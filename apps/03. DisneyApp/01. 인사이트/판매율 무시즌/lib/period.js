// 마감기준일 날짜 가져오기
const currentYeardate = moment(date_select.value).format('YYYY-MM-DD');
// 마감기준일 날짜에서 1년전 가장 가까운 같은 요일 날짜 가져오기
let _day_num = moment(date_select.value).day()
let previousYearDate_01 = moment(date_select.value).subtract('1', 'years').startOf('weeks').add(_day_num>0 ? _day_num : 7, 'days').format('YYYY-MM-DD'); // 마감기준일이 속한 날짜의 첫번째날(일요일)에서 마감기준일의 요일번호를 더하는데, 마감기준일의 요일번호가 0일때는 7일을 더함
//  let previousYearDate_02 = moment(date_select.value).subtract('2', 'years').startOf('weeks').add(_day_num>0 ? _day_num : 7, 'days').format('YYYY-MM-DD');
//  let previousYearDate_03 = moment(date_select.value).subtract('3', 'years').startOf('weeks').add(_day_num>0 ? _day_num : 7, 'days').format('YYYY-MM-DD');

//집계 날짜 기준 표기용
const cur_days = '누계: ~ '+moment(currentYeardate).format('YYYY-MM-DD')+' | 월간: '+ moment(currentYeardate).startOf('month').format('YYYY-MM-DD')+ ' ~ '+moment(currentYeardate).format('YYYY-MM-DD') + ' | 지난주: ' + moment(currentYeardate).subtract('13','days').format('YYYY-MM-DD')  + ' ~ ' + moment(currentYeardate).subtract('7','days').format('YYYY-MM-DD') + ' | 이번주: '+ moment(currentYeardate).subtract('6','days').format('YYYY-MM-DD') + ' ~ ' + moment(currentYeardate).format('YYYY-MM-DD')

const prev_days_01 = '누계: ~ '+moment(previousYearDate_01).format('YYYY-MM-DD')+' | 월간: '+ moment(previousYearDate_01).startOf('month').format('YYYY-MM-DD')+ ' ~ '+moment(currentYeardate).subtract('1','years').format('YYYY-MM-DD') + ' | 지난주: ' + moment(previousYearDate_01).subtract('13','days').format('YYYY-MM-DD')  + ' ~ ' + moment(previousYearDate_01).subtract('7','days').format('YYYY-MM-DD') + ' | 이번주: '+ moment(previousYearDate_01).subtract('6','days').format('YYYY-MM-DD') + ' ~ ' + moment(previousYearDate_01).format('YYYY-MM-DD')

//  const prev_days_02 = '누계: ~ '+moment(previousYearDate_02).format('YYYY-MM-DD')+' | 월간: '+ moment(previousYearDate_02).startOf('month').format('YYYY-MM-DD')+ ' ~ '+moment(currentYeardate).subtract('1','years').format('YYYY-MM-DD') + ' | 지난주: ' + moment(previousYearDate_02).subtract('13','days').format('YYYY-MM-DD')  + ' ~ ' + moment(previousYearDate_02).subtract('7','days').format('YYYY-MM-DD') + ' | 이번주: '+ moment(previousYearDate_02).subtract('6','days').format('YYYY-MM-DD') + ' ~ ' + moment(previousYearDate_02).format('YYYY-MM-DD')

//  const prev_days_03 = '누계: ~ '+moment(previousYearDate_03).format('YYYY-MM-DD')+' | 월간: '+ moment(previousYearDate_03).startOf('month').format('YYYY-MM-DD')+ ' ~ '+moment(currentYeardate).subtract('1','years').format('YYYY-MM-DD') + ' | 지난주: ' + moment(previousYearDate_03).subtract('13','days').format('YYYY-MM-DD')  + ' ~ ' + moment(previousYearDate_03).subtract('7','days').format('YYYY-MM-DD') + ' | 이번주: '+ moment(previousYearDate_03).subtract('6','days').format('YYYY-MM-DD') + ' ~ ' + moment(previousYearDate_03).format('YYYY-MM-DD')




//  const cur_days = moment(date).startOf().

console.log(`...`)
console.log(cur_days)

return {
  prev_date: moment(previousYearDate_01).format('YYYY-MM-DD'),
  cur: cur_days,
  prev_01: prev_days_01
  //  prev_02: prev_days_02,
  //  prev_03: prev_days_03,
}