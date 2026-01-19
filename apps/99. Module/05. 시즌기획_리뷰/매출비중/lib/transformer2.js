// Reference external variables with curly brackets or using JS variables
const data = {{ get_sales_by_tot.data}}

function addRevenueRates(items) {
  const curTotal = items.reduce((sum, it) => sum + (Number(it.cur_rev) || 0), 0);
  const prevTotal = items.reduce((sum, it) => sum + (Number(it.prev_rev) || 0), 0);

  return items.map(it => {
    const cur = Number(it.cur_rev) || 0;
    const prev = Number(it.prev_rev) || 0;

    return {
      ...it,
      cur_rev_rate: curTotal > 0 ? cur / curTotal : 0,
      prev_rev_rate: prevTotal > 0 ? prev / prevTotal : 0,
    };
  });
}

// 사용 예시
const resultWithRates = addRevenueRates(data); // data = 질문에 올린 배열


return resultWithRates