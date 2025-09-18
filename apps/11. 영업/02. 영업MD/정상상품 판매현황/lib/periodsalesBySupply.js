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

// const arrData = {{ formatDataAsArray(periodicSalesBySupplyStyleQuery.data).filter(i=> tabs1.value === '합계' ? true : i.onoff_flag===tabs1.value) }}

// const updatedArrData = arrData.map(obj => {
//   let supply = "";
//   let order = "";

//   if (['01', '07', '79'].includes(obj.br_cd)) {
//     supply = '브랜드용품';
//     order = '0';
//   } else if (obj.br_cd === '71') {
//     supply = '퓨토용품';
//     order = '3';
//   } else if (obj.sub_br_nm === '스토케') {
//     supply = '스토케';
//     order = '2';
//   } else if (['57', '58', '59','72'].includes(obj.br_cd)) {
//     supply = '온라인';
//     order = '4';
//   }else {
//     supply = '공용용품';
//     order = '1';
//   }

//   return { ...obj, supply, order };
// });


// console.log(updatedArrData)

// const sumKeys = ["rev","tag","cost"]
// const groupKeys = ["year_unit","first_lv_class", "supply","order"]
// const groupedArr = groupBySum(updatedArrData, ["year_unit", ...groupKeys], sumKeys)

// console.log(groupedArr)





// const _keys = [//"biz_cd",
//               "first_lv_class", "supply", "order"]
// const result = transformSalesData(groupedArr,_keys,sumKeys);
// console.log(result);


//   // ... existing code ...
//     const totKeys = [//"biz_cd",
//                       "first_lv_class"]
//     const totSumKeys = ["cur_rev",  "prev_rev",
//                         "cur_tag","prev_tag",
//                        "cur_cost","prev_cost"]
//     const totArr = groupBySum(result, totKeys, totSumKeys)
  
//     // groupedArr의 첫 번째 요소의 키를 가져옵니다. (groupedArr가 비어있지 않다고 가정)
//     const groupedArrKeys = groupedArr.length > 0 ? Object.keys(groupedArr[0]) : [];
  
// const defaultValues = {
//   supply: '소계',
//   order: '9'
// };

// totArr.forEach(item => {
//   groupedArrKeys.forEach(key => {
//     if (!(key in item)) {
//       item[key] = defaultValues[key];
//     }
//   });
// });
  
//     result.push(...totArr)

// const updated = result.map(item => {
//   const newItem = { ...item };

//   // 키 이름 변경
//   newItem.sales_type = newItem.first_lv_class;
//   delete newItem.first_lv_class;

//   newItem.season_nm = newItem.supply;
//   delete newItem.supply;

//   newItem.season_cd = newItem.order;
//   delete newItem.order;

//   return newItem;
// });



// return updated.sort((a, b) => { a.season_cd - b.season_cd
// });