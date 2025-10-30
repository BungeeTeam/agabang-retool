
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
  const monthlyTotals = {};

  result.forEach(item => {
    if (item.sales_type === '총계') {
      const month = item.month_unit;
      monthlyTotals[month] = {
        cur_rev: Number(item.cur_rev) || 0,
        prev_rev: Number(item.prev_rev) || 0
      };
    }
  });

  result.forEach(item => {
    const { cur_rev, prev_rev } = monthlyTotals[item.month_unit] || {};
    item.cur_sale_rate = cur_rev > 0 ? item.cur_rev / cur_rev : 0;
    item.prev_sale_rate = prev_rev > 0 ? item.prev_rev / prev_rev : 0;
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



// function groupBySum(arr, groupKeys, sumKeys) {
//   return Object.values(
//     arr.reduce((acc, item) => {
//       const key = groupKeys.map(k => item[k]).join("-");

//       if (!acc[key]) {
//         acc[key] = Object.fromEntries(groupKeys.map(k => [k, item[k]]));
//         sumKeys.forEach(k => acc[key][k] = Number(item[k]) || 0);
//       } else {
//         sumKeys.forEach(k => acc[key][k] += Number(item[k]) || 0);
//       }

//       return acc;
//     }, {})
//   );
// }

// function transformSalesData(data, groupKeys, sumKeys) {
//   const years = [...new Set(data.map(d => d.year_unit))].sort((a, b) => b - a);
//   const [currentYear, previousYear] = years;
//   const grouped = {};

//   data.forEach(entry => {
//     const key = groupKeys.map(k => entry[k]).join("|");

//     if (!grouped[key]) {
//       grouped[key] = Object.fromEntries(groupKeys.map(k => [k, entry[k]]));
//       sumKeys.forEach(k => {
//         grouped[key][`cur_${k}`] = 0;
//         grouped[key][`prev_${k}`] = 0;
//       });
//     }

//     sumKeys.forEach(k => {
//       if (entry.year_unit === currentYear) {
//         grouped[key][`cur_${k}`] += entry[k] || 0;
//       } else if (entry.year_unit === previousYear) {
//         grouped[key][`prev_${k}`] += entry[k] || 0;
//       }
//     });
//   });

//   return Object.values(grouped);
// }

// // ---------- 메인 처리 영역 ----------

// const data = {{ indexing.value }};
// const sumKeys = ["rev", "tag", "cost"];
// const groupKeys = ["year_unit", "season_cd", "season_nm", "sales_type"];

// const groupedArr = groupBySum(data, groupKeys, sumKeys);

// const transformKeys = ["season_cd", "season_nm", "sales_type"];
// const result = transformSalesData(groupedArr, transformKeys, sumKeys);

// // 중간 집계: 소계 계산
// const totKeys = ["sales_type"];
// const totSumKeys = [
//   "cur_rev", "prev_rev",
//   "cur_tag", "prev_tag",
//   "cur_cost", "prev_cost"
// ];
// const totArr = groupBySum(result, totKeys, totSumKeys);

// // 소계에 season_cd / season_nm 기본값 보정
// const defaultValues = {
//   season_cd: '9',
//   season_nm: '소계'
// };

// const groupedArrKeys = groupedArr.length > 0 ? Object.keys(groupedArr[0]) : [];
// totArr.forEach(item => {
//   groupedArrKeys.forEach(key => {
//     if (!(key in item)) item[key] = defaultValues[key];
//   });
// });

// result.push(...totArr);

// // 용품 데이터 추가
// const supply = {{ periodsalesBySupply.value }};
// result.push(...supply);

// // 총계 계산
// //  const totalSums = Object.fromEntries(totSumKeys.map(k => [k, 0]));
// //  result.forEach(item => {
// //    totSumKeys.forEach(k => {
// //      totalSums[k] += Number(item[k]) || 0;
// //    });
// //  });

// // 초기값 0으로 합계 객체 생성
// const totalSums = Object.fromEntries(totSumKeys.map(k => [k, 0]));

// // 'season_nm'이 '소계'인 항목만 합산
// result.forEach(item => {
//   if (item.season_nm === '소계') {
//     totSumKeys.forEach(k => {
//       totalSums[k] += Number(item[k]) || 0;
//     });
//   }
// });

// const totalObj = {
//   sales_type: '합계',
//   season_cd: 999,
//   season_nm: '총계',
//   ...totalSums
// };
// result.push(totalObj);

// // '총계' 객체 추출
// const totalRow = result.find(item => item.season_nm === '총계');
// const totalCurRev = totalRow?.cur_rev ?? 0;
// const totalPrevRev = totalRow?.prev_rev ?? 0;

// // 각 항목에 비중 추가
// result.forEach(item => {
//   item.cur_sale_rate = totalCurRev > 0 ? item.cur_rev / totalCurRev : 0;
//   item.prev_sale_rate = totalPrevRev > 0 ? item.prev_rev / totalPrevRev : 0;
// });

// const target =  {{ formatDataAsArray(periodicTargetSales.data).filter(i=> tabs1.value === '합계' ? true : i.onoff_flag===tabs1.value) }};

// const targetKeys = ["year_unit"];
// const targetSumKeys = ["target_sales"];
// const targetArr = groupBySum(target, targetKeys, targetSumKeys);

// const planChgAmt = targetArr[0]?.target_sales ?? 0;
// result.forEach(item => {
//   item.target_sales = (item.prev_sale_rate || 0) * planChgAmt;
// });

// // 정렬: sales_type 기준 오름차순, season_cd 기준 오름차순
// return result.sort((a, b) => {
//   const typeCompare = b.sales_type.localeCompare(a.sales_type);
//   if (typeCompare !== 0) return typeCompare;
//   return Number(a.season_cd) - Number(b.season_cd);
// });


// // function groupBySum(arr, groupKeys, sumKeys) {
// //   return Object.values(
// //     arr.reduce((acc, item) => {
// //       const key = groupKeys.map(k => item[k]).join("-");

// //       if (!acc[key]) {
// //         acc[key] = Object.fromEntries(groupKeys.map(k => [k, item[k]]));
// //         sumKeys.forEach(sumKey => {
// //           acc[key][sumKey] = Number(item[sumKey]) || 0;
// //         });
// //       } else {
// //         sumKeys.forEach(sumKey => {
// //           acc[key][sumKey] += Number(item[sumKey]) || 0;
// //         });
// //       }
// //       return acc;
// //     }, {})
// //   );
// // }

// // function transformSalesData(data, groupKeys, sumKeys) {
// //   const years = [...new Set(data.map(entry => entry.year_unit))].sort((a, b) => b - a);
// //   const [currentYear, previousYear] = years;

// //   const grouped = {};

// //   data.forEach(entry => {
// //     const key = groupKeys.map(k => entry[k]).join("|");

// //     if (!grouped[key]) {
// //       const groupInfo = {};
// //       groupKeys.forEach(k => groupInfo[k] = entry[k]);
// //       sumKeys.forEach(k => {
// //         groupInfo[`cur_${k}`] = 0;
// //         groupInfo[`prev_${k}`] = 0;
// //       });
// //       grouped[key] = groupInfo;
// //     }

// //     sumKeys.forEach(k => {
// //       if (entry.year_unit === currentYear) {
// //         grouped[key][`cur_${k}`] += entry[k] || 0;
// //       } else if (entry.year_unit === previousYear) {
// //         grouped[key][`prev_${k}`] += entry[k] || 0;
// //       }
// //     });
// //   });

// //   return Object.values(grouped);
// // }




// // const data = {{ indexing.value }}
// // console.log(data)
// // const sumKeys = ["rev","tag","cost"]
// // const keys = ["year_unit",
// //               //"biz_cd",
// //               "season_cd","season_nm",
// //               "sales_type"]
// // const groupedArr = groupBySum(data, keys, sumKeys)

// // console.log(groupedArr)
// // const _keys = [//"biz_cd",
// //               "season_cd","season_nm",
// //               "sales_type"]
// // const result = transformSalesData(groupedArr,_keys,sumKeys);
// // console.log(result);


// //   // ... existing code ...
// //     const totKeys = [//"biz_cd",
// //                       "sales_type"]
// //     const totSumKeys = ["cur_rev",  "prev_rev",
// //                         "cur_tag","prev_tag",
// //                        "cur_cost","prev_cost"]
// //     const totArr = groupBySum(result, totKeys, totSumKeys)
  
// //     // groupedArr의 첫 번째 요소의 키를 가져옵니다. (groupedArr가 비어있지 않다고 가정)
// //     const groupedArrKeys = groupedArr.length > 0 ? Object.keys(groupedArr[0]) : [];
  
// // const defaultValues = {
// //   season_cd: '9',
// //   season_nm: '소계'
// // };

// // totArr.forEach(item => {
// //   groupedArrKeys.forEach(key => {
// //     if (!(key in item)) {
// //       item[key] = defaultValues[key];
// //     }
// //   });
// // });
  
// //     result.push(...totArr)

// // const supply = {{ periodsalesBySupply.value }}

// // result.push(...supply)

// // const totalSums = {};
// // // 초기화
// // totSumKeys.forEach(key => totalSums[key] = 0);

// // // 합계 계산
// // result.forEach(item => {
// //   totSumKeys.forEach(key => {
// //     totalSums[key] += Number(item[key]) || 0;
// //   });
// // });

// // // 총계 객체 생성
// // const totalObj = {
// //   sales_type: '합계',
// //   season_cd: 999, // 정렬 순서상 가장 마지막에 오도록 큰 값 설정
// //   season_nm: '총계',
// //   ...totalSums // 동적으로 합산된 값들 추가
// // };

// // result.push(totalObj);

// // return result.sort((a, b) => {
// //   // 1차: sales_type 기준 (문자열 오름차순)
// //   const typeCompare = b.sales_type.localeCompare(a.sales_type);
// //   if (typeCompare !== 0) return typeCompare;

// //   // 2차: season_cd 기준 (숫자 내림차순)
// //   return Number(a.season_cd) - Number(b.season_cd);
// // });