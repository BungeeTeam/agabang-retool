
// function groupBySum(arr, groupKeys, sumKeys) {
//   return Object.values(
//     arr.reduce((acc, item) => {
//       const key = groupKeys.map(k => item[k]).join("-");

//       if (!acc[key]) {
//         acc[key] = Object.fromEntries(groupKeys.map(k => [k, item[k]]));
//         sumKeys.forEach(sumKey => {
//           acc[key][sumKey] = Number(item[sumKey]) || 0;
//         });
//       } else {
//         sumKeys.forEach(sumKey => {
//           acc[key][sumKey] += Number(item[sumKey]) || 0;
//         });
//       }
//       return acc;
//     }, {})
//   );
// }

// function transformSalesData(data, groupKeys, sumKeys) {
//   const years = [...new Set(data.map(entry => entry.year_unit))].sort((a, b) => b - a);
//   const [currentYear, previousYear] = years;

//   const grouped = {};

//   data.forEach(entry => {
//     const key = groupKeys.map(k => entry[k]).join("|");

//     if (!grouped[key]) {
//       const groupInfo = {};
//       groupKeys.forEach(k => groupInfo[k] = entry[k]);
//       sumKeys.forEach(k => {
//         groupInfo[`cur_${k}`] = 0;
//         groupInfo[`prev_${k}`] = 0;
//       });
//       grouped[key] = groupInfo;
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




// const data = {{ indexing.value }}
// console.log(data)
// const sumKeys = ["rev","tag","cost"]
// const keys = ["year_unit",
//               //"biz_cd",
//               "month_unit",
//               "season_cd","season_nm",
//               "category_name", "category_order"]
// const groupedArr = groupBySum(data, keys, sumKeys)

// console.log(groupedArr)
// const _keys = [//"biz_cd",
//               "season_cd","season_nm",
//               "month_unit",
//               "category_name", "category_order"]
// const result = transformSalesData(groupedArr,_keys,sumKeys);
// console.log(result);


//   // ... existing code ...
//     const totKeys = [//"biz_cd",
//                       "month_unit","season_cd","season_nm"]
//     const totSumKeys = ["cur_rev",  "prev_rev",
//                         "cur_tag","prev_tag",
//                        "cur_cost","prev_cost"]
//     const totArr = groupBySum(result, totKeys, totSumKeys)
  
//     // groupedArr의 첫 번째 요소의 키를 가져옵니다. (groupedArr가 비어있지 않다고 가정)
//     const groupedArrKeys = groupedArr.length > 0 ? Object.keys(groupedArr[0]) : [];
  
// const defaultValues = {
//   category_order: '9',
//   category_name: '소계'
// };

// totArr.forEach(item => {
//   groupedArrKeys.forEach(key => {
//     if (!(key in item)) {
//       item[key] = defaultValues[key];
//     }
//   });
// });
  
//     result.push(...totArr)


// //  const supply = {{ monthlySupply.value }}

// //  result.push(...supply)


// const totObjKeys = ["month_unit"];
// const totObj = groupBySum(result, totObjKeys, totSumKeys);

// const totDefaultValues = {
//   category_order: '999',
//   category_name: '총계'
// };

// totObj.forEach(item => {
//   ["category_order", "category_name"].forEach(key => {
//     if (!(key in item)) {
//       item[key] = totDefaultValues[key];
//     }
//   });
// });

// result.push(...totObj);

// return result.sort((a, b) => {
//   // 1차: sales_type 기준 (문자열 오름차순)
//   const typeCompare = Number(a.season_cd)- Number(b.season_cd);
//   if (typeCompare !== 0) return typeCompare;

//   // 2차: season_cd 기준 (숫자 내림차순)
//   return Number(a.category_order) - Number(b.category_order);
// });