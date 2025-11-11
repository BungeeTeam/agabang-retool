// Reference external variables with curly brackets or using JS variables
// 마감기준일 날짜 가져오기
let _select_date = {{ date_select.value }}
const currentYeardate = moment(_select_date).format('YYYY-MM-DD');
// 마감기준일 날짜에서 1년전 가장 가까운 같은 요일 날짜 가져오기
let _day_num = moment(_select_date).day()
let previousYearDate_01 = moment(_select_date).subtract('1', 'years').startOf('weeks').add(_day_num>0 ? _day_num : 7, 'days').format('YYYY-MM-DD'); // 마감기준일이 속한 날짜의 첫번째날(일요일)에서 마감기준일의 요일번호를 더하는데, 마감기준일의 요일번호가 0일때는 7일을 더함
const prev_days_01 = '누계: ~ '+moment(previousYearDate_01).format('YYYY-MM-DD')+' | 월간: '+ moment(previousYearDate_01).startOf('month').format('YYYY-MM-DD')+ ' ~ '+moment(currentYeardate).subtract('1','years').format('YYYY-MM-DD') + ' | 지난주: ' + moment(previousYearDate_01).subtract('13','days').format('YYYY-MM-DD')  + ' ~ ' + moment(previousYearDate_01).subtract('7','days').format('YYYY-MM-DD') + ' | 이번주: '+ moment(previousYearDate_01).subtract('6','days').format('YYYY-MM-DD') + ' ~ ' + moment(previousYearDate_01).format('YYYY-MM-DD')

console.log(`...`)
//  console.log(cur_days)

return prev_days_01