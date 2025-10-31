function transformSalesData(data) {
  // reduce를 사용하여 배열을 순회하며 데이터를 누적 변환합니다.
  const groupedResult = data.reduce((acc, item) => {
    // biz_cd, time_unit, second_lv_class 값이 없는 항목은 건너뜁니다.
    if (!item.biz_cd || !item.time_unit || !item.second_lv_class) {
      return acc;
    }

    // 1. 그룹화를 위한 고유 키를 생성합니다. (예: "A1-2023")
    const groupKey = `${item.biz_cd}-${item.time_unit}`;

    // 2. 이 그룹 키가 처음 발견되면, 최종 결과 객체의 기본 틀을 생성합니다.
    if (!acc[groupKey]) {
      acc[groupKey] = {
        biz_cd: item.biz_cd,
        biz_nm: item.biz_nm,
        sale_yr: parseInt(item.time_unit, 10),
      };
    }

    // 3. 'second_lv_class'의 값을 새로운 컬럼명(동적 키)으로 사용합니다.
    const categoryName = item.second_lv_class;
    const revenue = Number(item.rev) || 0;

    // 4. 해당 카테리에 매출액(rev)을 더합니다. (기존 값이 없으면 0에서 시작)
    acc[groupKey][categoryName] = (acc[groupKey][categoryName] || 0) + revenue;

    return acc;
  }, {}); // 초기값은 빈 객체 {}

  // 5. 그룹화가 완료된 객체의 값들만 추출하여 최종 배열 형태로 반환합니다.
  return Object.values(groupedResult);
}

function calculateYoYGrowth(data) {
  // 1. 데이터에서 가장 최신 연도를 찾아 올해와 작년 연도를 정의합니다.
  const latestYear = Math.max(...data.map(item => item.sale_yr));
  const prevYear = latestYear - 1;

  // 2. biz_cd를 키로, 연도별 데이터를 값으로 갖는 맵을 생성하여 데이터 접근을 용이하게 합니다.
  //   (예: { A1: { 2025: {...}, 2024: {...} }, B1: { ... } })
  const dataByBizCd = {};
  data.forEach(item => {
    // 올해와 작년 데이터만 필요하므로 필터링합니다.
    if (item.sale_yr === latestYear || item.sale_yr === prevYear) {
      const bizCd = item.biz_cd;
      if (!dataByBizCd[bizCd]) {
        dataByBizCd[bizCd] = {};
      }
      dataByBizCd[bizCd][item.sale_yr] = item;
    }
  });

  const finalResult = [];

  // 3. 사업부(biz_cd)별로 순회하며 신장율을 계산합니다.
  for (const bizCd in dataByBizCd) {
    const bizData = dataByBizCd[bizCd];
    const currentYearData = bizData[latestYear];
    const prevYearData = bizData[prevYear];

    // 4. 올해와 작년 데이터가 모두 존재해야 신장율 계산이 가능합니다.
    if (currentYearData && prevYearData) {
      // 신장율 정보를 추가할 객체를 올해 데이터 기준으로 복사합니다.
      const resultItem = { ...currentYearData };

      // 5. 매출 카테고리(하드류, 외의류 등)를 순회하며 신장율을 계산합니다.
      Object.keys(prevYearData).forEach(categoryName => {
        // biz_cd, biz_nm, sale_yr 같은 기본 정보는 건너뜁니다.
        if (categoryName !== 'biz_cd' && categoryName !== 'biz_nm' && categoryName !== 'sale_yr') {
          const currentValue = currentYearData[categoryName] || 0;
          const prevValue = prevYearData[categoryName] || 0;

          let growthRate = 0;
          // 작년 매출이 0이 아닐 때만 신장율을 계산합니다. (0으로 나누기 방지)
          if (prevValue !== 0) {
            growthRate = ((currentValue - prevValue) / prevValue)*100;
          }
          
          // `${카테고리명} 신장율` 형태의 키로 값을 추가합니다. (소수점 3자리)
          resultItem[`${categoryName}신장율`] = parseFloat(growthRate.toFixed(1));
        }
      });
      finalResult.push(resultItem);
    } else if (currentYearData) {
      // 작년 데이터가 없어 비교가 불가능하면, 올해 데이터만 결과에 포함합니다.
      finalResult.push(currentYearData);
    }
  }

  return finalResult;
}

const data = {{ inputDataByStyle.value }};

let arrData = formatDataAsArray(data).filter(
  (item) => item.onoff_flag === "오프라인"
);



const transformedData = transformSalesData(arrData);


const final = calculateYoYGrowth(transformedData)

return final;
