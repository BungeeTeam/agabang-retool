function calculateYoYRate(current, previous) {
  const currentValue = Number(current) || 0;
  const previousValue = Number(previous) || 0;

  // 작년 실적이 0이면 증감율 계산 불가 (0으로 나누기 방지)
  if (previousValue === 0) {
    // 단, 금년 실적도 0이면 변화가 없으므로 0%
    // 금년 실적이 0보다 크면 무한대 성장이므로 null
    return currentValue === 0 ? 0 : null;
  }

  // 증감율 계산: (금년 / 작년) - 1
  return (currentValue / previousValue) - 1;
}


// 0. 계산에 필요한 상수와 키 목록 정의
const THIS_YEAR_CD = {{ season_select.selectedItem.year_cd }};
const LAST_YEAR_CD = {{ season_select.selectedItem.prev_year_cd }};

// 증감율을 계산할 모든 숫자 키 목록

const numericKeys = [
    "ord_qty", "ord_tag_amt", "st_count", "in_st_count","out_st_count", 
    "tot_in_qty", "tot_in_cost", "tot_in_tag", "tot_sale_qty",
    "tot_sale_tag", "tot_sale_amt", "month_sale_qty", "month_sale_tag",
    "month_sale_amt", "p_week_sale_qty", "p_week_sale_tag", "p_week_sale_amt",
    "week_sale_qty", "week_sale_tag", "week_sale_amt",
    // 비중(ratio) 값들의 전년대비 변화는 '퍼센트 포인트(%p)' 차이를 의미하게 됨
    "in_ratio", "sale_ratio" 
];


// 1. 데이터를 large_cat 기준으로 재구성 (연도별 비교를 쉽게 하기 위함)
const data = {{ salesByLargeCat.value }}
const dataByCategory = data.reduce((acc, item) => {
  const category = item.large_cat;
  if (!acc[category]) {
    acc[category] = {};
  }
  if (item.year_cd === THIS_YEAR_CD) {
    acc[category].thisYear = item;
  } else if (item.year_cd === LAST_YEAR_CD) {
    acc[category].lastYear = item;
  }
  return acc;
}, {});


// 2. 재구성된 데이터를 기반으로 증감율 계산
const yoyRateData = Object.values(dataByCategory).map(categoryData => {
  
  const thisYear = categoryData.thisYear || {};
  const lastYear = categoryData.lastYear || {};

  // 최종 결과를 담을 객체 생성. non-numeric 키들은 올해 데이터 기준으로 설정
  const resultRow = {
    large_cat: thisYear.large_cat || lastYear.large_cat,
    cat_group: thisYear.cat_group || lastYear.cat_group,
    apparel_group: thisYear.apparel_group || lastYear.apparel_group,
    it: thisYear.it || lastYear.it,
  };

  // 모든 숫자 키에 대해 증감율을 계산
  numericKeys.forEach(key => {
    // 위에서 만든 헬퍼 함수를 사용하여 안전하게 계산
    const yoyRate = calculateYoYRate(thisYear[key], lastYear[key]);
    
    // 결과 객체에 새로운 키(예: tot_sale_qty_yoy)로 증감율 저장
    resultRow[key] = yoyRate;
  });

  return resultRow;
});

// 최종적으로 증감율만 계산된 데이터를 반환
return yoyRateData;