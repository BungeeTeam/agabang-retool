
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

function transformSalesData(data, groupKeys, sumKeys) {
  const years = [...new Set(data.map(entry => entry.year_unit))].sort((a, b) => b - a);
  const [currentYear, previousYear] = years;

  const grouped = {};

  data.forEach(entry => {
    const key = groupKeys.map(k => entry[k]).join("|");

    if (!grouped[key]) {
      const groupInfo = {};
      groupKeys.forEach(k => groupInfo[k] = entry[k]);
      sumKeys.forEach(k => {
        groupInfo[`cur_${k}`] = 0;
        groupInfo[`prev_${k}`] = 0;
      });
      grouped[key] = groupInfo;
    }

    sumKeys.forEach(k => {
      if (entry.year_unit === currentYear) {
        grouped[key][`cur_${k}`] += entry[k] || 0;
      } else if (entry.year_unit === previousYear) {
        grouped[key][`prev_${k}`] += entry[k] || 0;
      }
    });
  });

  return Object.values(grouped);
}




const data = {{ indexing.value }}
console.log(data)
const sumKeys = ["rev","tag","cost"]
const keys = ["year_unit",
              //"biz_cd",
              //"season_cd","season_nm",
              "category_name", "category_order"]
const groupedArr = groupBySum(data, keys, sumKeys)

console.log(groupedArr)
const _keys = [//"biz_cd",
             // "season_cd","season_nm",
              "category_name", "category_order"]
const result = transformSalesData(groupedArr,_keys,sumKeys);
console.log(result);


  // ... existing code ...
    const totKeys = [//"biz_cd",
                      "season_cd","season_nm"]
    const totSumKeys = ["cur_rev",  "prev_rev",
                        "cur_tag","prev_tag",
                       "cur_cost","prev_cost"]
    const totArr = groupBySum(result, totKeys, totSumKeys)
  
    // groupedArr의 첫 번째 요소의 키를 가져옵니다. (groupedArr가 비어있지 않다고 가정)
//      const groupedArrKeys = groupedArr.length > 0 ? Object.keys(groupedArr[0]) : [];
  
//  const defaultValues = {
//    category_order: '9',
//    category_name: '소계'
//  };

//  totArr.forEach(item => {
//    groupedArrKeys.forEach(key => {
//      if (!(key in item)) {
//        item[key] = defaultValues[key];
//      }
//    });
//  });
  
//      result.push(...totArr)

//  const supply = {{ periodsalesBySupply.value }}

//  result.push(...supply)

const totalSums = {};
// 초기화
totSumKeys.forEach(key => totalSums[key] = 0);

// 합계 계산
result.forEach(item => {
  totSumKeys.forEach(key => {
    totalSums[key] += Number(item[key]) || 0;
  });
});

// 총계 객체 생성
const totalObj = {
  category_order: '-1', // 정렬 순서상 가장 처음 오도록 큰 값 설정
  category_name: '총계',
  ...totalSums // 동적으로 합산된 값들 추가
};

result.push(totalObj);


const totalRow = result.find(item => item.category_name === '총계');
const totalCurRev = totalRow?.cur_rev ?? 0;
const totalPrevRev = totalRow?.prev_rev ?? 0;

// 각 항목에 비중 추가
result.forEach(item => {
  item.cur_sale_rate = totalCurRev > 0 ? item.cur_rev / totalCurRev : 0;
  item.prev_sale_rate = totalPrevRev > 0 ? item.prev_rev / totalPrevRev : 0;
});

return result.sort((a, b) => 
 Number(a.category_order) - Number(b.category_order)
);