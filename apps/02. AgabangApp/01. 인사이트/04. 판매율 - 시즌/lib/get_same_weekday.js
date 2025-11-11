// 올해 마감기준일 날짜 가져오기
const currentYeardate = moment(date_select.value).format('YYYY-MM-DD');

// 1년 전 동일일자 날짜
const same_date = moment(date_select.value).subtract('1', 'years').format('YYYY-MM-DD')


// 1년 전 동일요일 마감기준일 날짜에서 1년전 가장 가까운 같은 요일 날짜 가져오기
let _day_num = moment(date_select.value).day()
let same_weekday = moment(date_select.value).subtract('1', 'years').startOf('weeks').add(_day_num>0 ? _day_num : 7, 'days').format('YYYY-MM-DD'); // 마감기준일이 속한 날짜의 첫번째날(일요일)에서 마감기준일의 요일번호를 더하는데, 마감기준일의 요일번호가 0일때는 7일을 더함



//집계 날짜 기준 표기용
const cur_days = '누계: ~ '+moment(currentYeardate).format('YYYY-MM-DD')+' | 월간: '+ moment(currentYeardate).startOf('month').format('YYYY-MM-DD')+ ' ~ '+moment(currentYeardate).format('YYYY-MM-DD') + ' | 지난주: ' + moment(currentYeardate).subtract('13','days').format('YYYY-MM-DD')  + ' ~ ' + moment(currentYeardate).subtract('7','days').format('YYYY-MM-DD') + ' | 이번주: '+ moment(currentYeardate).subtract('6','days').format('YYYY-MM-DD') + ' ~ ' + moment(currentYeardate).format('YYYY-MM-DD')

const prev_same_date = '누계: ~ '+same_date+
  ' | 월간: '+ moment(same_date).startOf('month').format('YYYY-MM-DD')+ ' ~ '+ same_date + 
  ' | 지난주: ' + moment(same_date).subtract('13','days').format('YYYY-MM-DD')  + ' ~ ' + moment(same_date).subtract('7','days').format('YYYY-MM-DD') + 
  ' | 이번주: '+ moment(same_date).subtract('6','days').format('YYYY-MM-DD') + ' ~ ' + moment(same_date).format('YYYY-MM-DD')

const prev_same_weekday = '누계: ~ '+same_date+
  ' | 월간: '+ moment(same_date).startOf('month').format('YYYY-MM-DD')+ ' ~ '+ same_date + 
  ' | 지난주: ' + moment(same_weekday).subtract('13','days').format('YYYY-MM-DD')  + ' ~ ' + moment(same_weekday).subtract('7','days').format('YYYY-MM-DD') + 
  ' | 이번주: '+ moment(same_weekday).subtract('6','days').format('YYYY-MM-DD') + ' ~ ' + moment(same_weekday).format('YYYY-MM-DD')








return {
  cur_date: currentYeardate,
  same_date: same_date,
  same_weekday: same_weekday,
  cur: cur_days,
  prev: comparison_basis_select.value === 'same_weekday' ? prev_same_weekday : prev_same_date
}