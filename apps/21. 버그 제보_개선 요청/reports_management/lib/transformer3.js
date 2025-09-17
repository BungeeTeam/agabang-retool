const data = {{ formatDataAsArray(get_ticket_number.data) }}

const today = moment();
const startOfWeek = moment().startOf('week');
const startOfLastWeek = moment().subtract(1, 'week').startOf('week');
const endOfLastWeek = moment().subtract(1, 'week').endOf('week');

// 이번 주 합계
const thisWeekCnt = data.reduce((sum, item) => {
  const d = moment(item.dt, 'YYYY-MM-DD');
  if (d.isSameOrAfter(startOfWeek) && d.isSameOrBefore(today)) {
    return sum + Number(item.ticket_cnt);
  }
  return sum;
}, 0);

// 전주 합계
const lastWeekCnt = data.reduce((sum, item) => {
  const d = moment(item.dt, 'YYYY-MM-DD');
  if (d.isSameOrAfter(startOfLastWeek) && d.isSameOrBefore(endOfLastWeek)) {
    return sum + Number(item.ticket_cnt);
  }
  return sum;
}, 0);

return {
  startDate: startOfWeek.format('YYYY-MM-DD'),
  endDate: today.format('YYYY-MM-DD'),
  thisWeekCnt,
  lastWeekCnt
};