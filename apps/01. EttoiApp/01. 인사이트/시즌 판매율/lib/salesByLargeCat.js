// 기존 함수 (변경 없음)
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

// [수정] createSubtotals 함수를 더 유연하게 변경
function createSubtotals({
  sourceData,
  configs,
  categoryKey,
  groupKeysForSubtotal,
  sumKeys,
  staticFields = {}
}) {
  return configs.flatMap(config => {
    const filteredData = sourceData.filter(item => 
      config.categories.includes(item[categoryKey])
    );
    if (filteredData.length === 0) {
      return [];
    }
    const subtotals = groupBySum(
      filteredData,
      groupKeysForSubtotal,
      sumKeys
    );
    
    // config 객체에서 name과 categories를 제외한 나머지 키들을 payload로 사용
    const { name, categories, ...payload } = config;

    return subtotals.map(item => ({
      ...item,
      [categoryKey]: name, 
      ...payload, // config에 정의된 추가 키-값들을 여기에 삽입
      ...staticFields          
    }));
  });
}


// --- 메인 로직 시작 ---

// 1. 기본 설정 (변경 없음)
const sumKeys = ["ord_qty","ord_tag_amt", "st_count", "out_st_count", "in_st_count", "tot_in_qty", "tot_in_cost", "tot_in_tag", "tot_sale_qty","tot_sale_tag", "tot_sale_amt", "month_sale_qty", "month_sale_tag", "month_sale_amt", "p_week_sale_qty", "p_week_sale_tag", "p_week_sale_amt", "week_sale_qty", "week_sale_tag", "week_sale_amt"];
const groupKeys = ["large_cat", "it"];
// [수정] 초기 그룹핑 시, 유지해야 할 모든 키를 포함
const initialGroupKeys = ["year_nm", "year_cd","season_nm", "total", "cat_group", "apparel_group", ...groupKeys];
const data = {{ salesByColor.data }};
let arrData = formatDataAsArray(data);

// 2. 초기 그룹핑
const groupedArr = groupBySum(arrData, initialGroupKeys, sumKeys);


// ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ [핵심 수정] 소계 설정에 유지할 키 값들을 정의 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
const subtotalConfigs = [
  { 
    name: "정상소계",
    categories: ["기초복", "유아복", "토들러", "기초ACC","정상ACC","토들러ACC"],
    total: "총계",
    cat_group: "정상",
    apparel_group: "정상" // 정상소계는 의류/용품을 모두 포함하므로
  },
  //  { 
  //    name: "시즌용품",
  //    categories: ["기초ACC","정상ACC","토들러ACC"],
  //    total: "총계",
  //    cat_group: "정상",
  //    apparel_group: "시즌용품" // 정상소계는 의류/용품을 모두 포함하므로
  //  },
  { 
    name: "기획소계",
    categories: ["기획외의", "기획내의"],
    total: "총계",
    cat_group: "기획",
    apparel_group: "기획"
  }
];

// 4. 범용 함수를 호출하여 모든 소계 생성 (함수 호출 코드는 변경 없음)
const allSubtotals = createSubtotals({
  sourceData: groupedArr,
  configs: subtotalConfigs,
  categoryKey: "large_cat",
  groupKeysForSubtotal: ["year_nm", "year_cd"], // 소계는 연도 기준으로만 합산
  sumKeys: sumKeys,
  staticFields: { it: "소계" } // 모든 소계에 공통으로 들어갈 값
});

// ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ [수정] 총계 계산 시 유지할 키 값들을 추가 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
const grandTotals = groupBySum(
  groupedArr, 
  ["year_nm", "year_cd"], 
  sumKeys
).map(item => ({
  ...item,
  large_cat: "총계",
  it: "총계",
  // 총계에 부여할 상위 그룹 값들을 여기에 명시
  total: "총계",
  cat_group: "총계",
  apparel_group: "총계"
}));


// 6. 이후 로직 (데이터 합치기, 정렬, 비중 계산)은 모두 변경 없이 그대로 사용
const finalData = [ ...groupedArr, ...allSubtotals, ...grandTotals ];

const categorySortOrder = [
    "기초복", "유아복", "토들러", "기초ACC","정상ACC","토들러ACC", "정상소계", 
    "기획외의", "기획내의", "기획소계",
    "총계" 
];

//  const categorySortOrder = [
//      "기초복", "유아복", "토들러", "시즌용품", "정상소계", 
//      "기획외의", "기획내의", "기획소계",
//      "총계" 
//  ];
const sortedFinalData = finalData.sort((a, b) => {
    if (a.year_nm > b.year_nm) return -1;
    if (a.year_nm < b.year_nm) return 1;
    const aIndex = categorySortOrder.indexOf(a.large_cat);
    const bIndex = categorySortOrder.indexOf(b.large_cat);
    if (aIndex === -1) return 1;
    if (bIndex === -1) return -1;
    return aIndex - bIndex;
});

const yearlyTotalsMap = new Map();
grandTotals.forEach(totalRow => {
  yearlyTotalsMap.set(totalRow.year_nm, {
    totalInTag: totalRow.tot_in_tag,
    totalSaleTag: totalRow.tot_sale_tag,
  });
});

const resultWithRatios = sortedFinalData.map(row => {
  const yearTotals = yearlyTotalsMap.get(row.year_nm);
  const denominatorIn = yearTotals ? yearTotals.totalInTag : 0;
  const denominatorSale = yearTotals ? yearTotals.totalSaleTag : 0;
  const in_ratio = (denominatorIn === 0) ? 0 : row.tot_in_tag / denominatorIn;
  const sale_ratio = (denominatorSale === 0) ? 0 : row.tot_sale_tag / denominatorSale;
  return { ...row, in_ratio, sale_ratio };
});


return resultWithRatios;



//  function groupBySum(arr, groupKeys, sumKeys) {
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
//  }

//  function createSubtotals({
//   sourceData,
//   configs,
//   categoryKey,
//   groupKeysForSubtotal,
//   sumKeys,
//   staticFields = {}
//  }) {
//   return configs.flatMap(config => {
//     const filteredData = sourceData.filter(item => 
//       config.categories.includes(item[categoryKey])
//     );
//     if (filteredData.length === 0) {
//       return [];
//     }
//     const subtotals = groupBySum(
//       filteredData,
//       groupKeysForSubtotal,
//       sumKeys
//     );
    
//     return subtotals.map(item => ({
//       ...item,
//       [categoryKey]: config.name, 
//       ...staticFields             
//     }));
//   });
//  }

//  const sumKeys = ["ord_qty","ord_tag_amt",
//                  "st_count", "in_st_count",
//                  "tot_in_qty", "tot_in_cost", "tot_in_tag",
//                 "tot_sale_qty","tot_sale_tag", "tot_sale_amt",
//                  "month_sale_qty", "month_sale_tag", "month_sale_amt",
//                  "p_week_sale_qty", "p_week_sale_tag", "p_week_sale_amt",
//                  "week_sale_qty", "week_sale_tag", "week_sale_amt"
//                 ]
//  const groupKeys = ["large_cat", "it"]
//  const data = {{ salesByColor.data }}
//  let arrData = formatDataAsArray(data)

//  const groupedArr = groupBySum(arrData, ["year_nm", "year_cd","total","cat_group","apparel_group", ...groupKeys], sumKeys)



//  //소계 추가
//  const subtotalConfigs = [
//   { name: "시즌의류", categories: ["시즌의류(B)", "시즌의류(T)"] },
//   { name: "정상소계",     categories: ["시즌의류(B)", "시즌의류(T)", "시즌언더", "시즌용품"] },
//   { name: "기획소계",     categories: ["기획의류", "기획언더"] }
//  ];

//  // 4. [수정] 범용 함수를 호출하여 모든 소계 생성
//  const allSubtotals = createSubtotals({
//   sourceData: groupedArr,
//   configs: subtotalConfigs,
//   categoryKey: "large_cat",
//   groupKeysForSubtotal: ["year_nm", "year_cd"],
//   sumKeys: sumKeys,
//   staticFields: { it: "소계", total: "총계",  }
//  });

//  // [신규 추가] 총계 계산

//  const grandTotals = groupBySum(
//   groupedArr, 
//   ["year_nm", "year_cd"], 
//   sumKeys
//  ).map(item => ({
//   ...item,
//   large_cat: "총계", // 이름 부여
//   it: "총계"
//  }));


//  const finalData = [ ...groupedArr, ...allSubtotals, ...grandTotals ];

//  // 정렬 순서
//  const categorySortOrder = [
//     "시즌의류(B)", "시즌의류(T)", "시즌의류", "시즌언더",
//     "시즌용품", "정상소계", "기획언더", "기획의류", "기획소계",
//     "총계" 
//  ];

//  const sortedFinalData = finalData.sort((a, b) => {
//     // 1. 연도(내림차순)
//     if (a.year_nm > b.year_nm) return -1;
//     if (a.year_nm < b.year_nm) return 1;

//     // 2. 카테고리 (미리 정의된 순서)
//     const aIndex = categorySortOrder.indexOf(a.large_cat);
//     const bIndex = categorySortOrder.indexOf(b.large_cat);
//     // 정의되지 않은 카테고리는 기타 등등이므로 맨 뒤로 보냄
//     if (aIndex === -1) return 1;
//     if (bIndex === -1) return -1;
    
//     return aIndex - bIndex;
//  });


//  // 7. 연도별 총계 값을 쉽게 찾아 쓸 수 있도록 Map 객체로 변환
//  const yearlyTotalsMap = new Map();
//  grandTotals.forEach(totalRow => {
//   yearlyTotalsMap.set(totalRow.year_nm, {
//     totalInTag: totalRow.tot_in_tag,
//     totalSaleTag: totalRow.tot_sale_tag,
//   });
//  });

//  // 8. 정렬된 데이터에 비중(ratio) 컬럼 추가
//  const resultWithRatios = sortedFinalData.map(row => {
//   // 현재 행의 연도에 해당하는 총계 값을 찾기
//   const yearTotals = yearlyTotalsMap.get(row.year_nm);

//   // 분모가 될 총계 값 (없을 경우 0으로 처리)
//   const denominatorIn = yearTotals ? yearTotals.totalInTag : 0;
//   const denominatorSale = yearTotals ? yearTotals.totalSaleTag : 0;
  
//   // 비중 계산 (0으로 나누는 오류 방지)
//   const in_ratio = (denominatorIn === 0) ? 0 : row.tot_in_tag / denominatorIn;
//   const sale_ratio = (denominatorSale === 0) ? 0 : row.tot_sale_tag / denominatorSale;
  
//   // 기존 행 데이터에 비중 값을 추가하여 새로운 객체로 반환
//   return {
//     ...row,
//     in_ratio,
//     sale_ratio
//   };
//  });


//  return resultWithRatios;