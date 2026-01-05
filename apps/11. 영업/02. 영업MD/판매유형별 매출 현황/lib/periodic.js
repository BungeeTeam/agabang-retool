
function groupBySum(arr, groupKeys, sumKeys) {
  return Object.values(
    arr.reduce((acc, item) => {
      const key = groupKeys.map(k => item[k]).join("-");

      if (!acc[key]) {
        acc[key] = Object.fromEntries(groupKeys.map(k => [k, item[k]]));
        sumKeys.forEach(sumKey => {
          acc[key][sumKey] = Number(item[sumKey]) || 0;
        });
      } else {
        sumKeys.forEach(sumKey => {
          acc[key][sumKey] += Number(item[sumKey]) || 0;
        });
      }
      return acc;
    }, {})
  );
}

function calculateSaleRates(result) {
  // 총계 행 찾기 (sales_type이 '총계'인 행)
  const totalRow = result.find(item => item.sales_type === '총계');
  
  if (!totalRow) {
    // 총계가 없으면 비중을 0으로 설정
    result.forEach(item => {
      item.cur_sale_rate = 0;
      item.prev_sale_rate = 0;
    });
    return;
  }

  const totalCurRev = Number(totalRow.cur_rev) || 0;
  const totalPrevRev = Number(totalRow.prev_rev) || 0;

  // 각 항목에 비중 계산
  result.forEach(item => {
    item.cur_sale_rate = totalCurRev > 0 ? (Number(item.cur_rev) || 0) / totalCurRev : 0;
    item.prev_sale_rate = totalPrevRev > 0 ? (Number(item.prev_rev) || 0) / totalPrevRev : 0;
  });
}

const data = {{ monthly.value }}
console.log(data)
const sumKeys = [
  "target_sales", "cur_rev", "prev_rev",
  "cur_tag", "prev_tag", "cur_cost", "prev_cost"
];
const keys = [//"year_unit",
             // "quarter_unit",
              "season_cd","season_nm",
              "sales_type"]
const groupedArr = groupBySum(data, keys, sumKeys)

calculateSaleRates(groupedArr)

return groupedArr.sort((a, b) => {
 // 1차: sales_type 기준 (문자열 오름차순)
 const typeCompare = b.sales_type.localeCompare(a.sales_type);
 if (typeCompare !== 0) return typeCompare;

 // 2차: season_cd 기준 (숫자 내림차순)
 return Number(a.season_cd) - Number(b.season_cd);
});