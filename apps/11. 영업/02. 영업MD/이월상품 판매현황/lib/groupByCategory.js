// groupBySum 함수는 전역에서 사용 (metadata.json preloadedAppJavaScript에 정의됨)

const data = {{ mergeCurOutSale.value }};
const online_data = {{ processCurrentOnlineWarehouse.value }};
console.log(online_data)
const sumKeys = ["sale_tag", "sale_qty", "sale_amt", "net_out_qty", "net_out_tag", "net_out_amt","ttl_out_qty","ttl_rtn_qty","ttl_out_amt","ttl_rtn_amt","ttl_out_tag","ttl_rtn_tag"];
const keys = [
  "biz_cd", "biz_nm", "br_cd", "br_nm",
  "year_cd", "year_nm", "season_cd", "season_nm",
  "year_season_cd", "category_name", "category_order", "item_grade"
];
const netOutKeys = ["net_out_qty","net_out_tag","net_out_amt","ttl_out_qty","ttl_rtn_qty","ttl_out_amt","ttl_rtn_amt","ttl_out_tag","ttl_rtn_tag"];


// --- ✨ 탭 선택에 따라 데이터 가공 ---
let baseArr = [];

if ({{tabs1.value}} === '오프라인') {
  // '오프라인'은 간단. 오프라인 데이터만 필터링하여 그룹핑
  const offlineData = data.filter(i => i.onoff_flag === '오프라인');
  baseArr = groupBySum(offlineData, keys, sumKeys);

} else if ({{tabs1.value}} === '온라인') {
  // '온라인' 탭: 판매량은 data 소스, 출고량은 online_data 소스 사용
  // 출고 데이터를 기준으로 순회하여, 판매가 없어도 출고 데이터가 표시되도록 수정
  const onlineSourceData = data.filter(i => i.onoff_flag === '온라인');
  const onlineGroupedFromSource = groupBySum(onlineSourceData, keys, sumKeys);
  
  // 판매 데이터를 Map으로 변환 (빠른 조회를 위해)
  const onlineSaleMap = new Map();
  onlineGroupedFromSource.forEach(item => {
    const key = `${item.br_cd}-${item.year_cd}-${item.season_cd}-${item.category_name}`;
    onlineSaleMap.set(key, item);
  });

  // 출고 데이터를 기준으로 최종 배열 생성
  //  const onlineGroupedFromTarget = groupBySum(online_data, keys, sumKeys);
  const onlineGroupedFromTarget = online_data
  const finalOnlineArr = [];
  
  onlineGroupedFromTarget.forEach(outItem => {
    const key = `${outItem.br_cd}-${outItem.year_cd}-${outItem.season_cd}-${outItem.category_name}`;
    const saleItem = onlineSaleMap.get(key);
    
    if (saleItem) {
      // 판매 데이터가 있는 경우: 판매량은 판매 데이터에서, 출고량은 출고 데이터에서
      const mergedItem = { ...saleItem };
      netOutKeys.forEach(netKey => {
        mergedItem[netKey] = outItem[netKey] || 0;
      });
      finalOnlineArr.push(mergedItem);
    } else {
      // 판매 데이터가 없는 경우: 출고 데이터만 사용 (판매량은 0으로 초기화)
      const outOnlyItem = { ...outItem };
      // 판매 관련 필드 초기화
      outOnlyItem.sale_tag = 0;
      outOnlyItem.sale_qty = 0;
      outOnlyItem.sale_amt = 0;
      // 나머지 필드는 outItem에서 가져오거나 기본값 설정
      if (!outOnlyItem.biz_cd) outOnlyItem.biz_cd = '';
      if (!outOnlyItem.biz_nm) outOnlyItem.biz_nm = '';
      if (!outOnlyItem.year_season_cd) outOnlyItem.year_season_cd = '';
      finalOnlineArr.push(outOnlyItem);
    }
  });
  
  // 판매 데이터에는 있지만 출고 데이터에는 없는 경우도 추가
  onlineGroupedFromSource.forEach(saleItem => {
    const key = `${saleItem.br_cd}-${saleItem.year_cd}-${saleItem.season_cd}-${saleItem.category_name}`;
    const existsInOut = onlineGroupedFromTarget.some(outItem => 
      `${outItem.br_cd}-${outItem.year_cd}-${outItem.season_cd}-${outItem.category_name}` === key
    );
    if (!existsInOut) {
      // 출고 데이터가 없는 경우: 출고량은 0으로 설정
      const saleOnlyItem = { ...saleItem };
      netOutKeys.forEach(netKey => {
        saleOnlyItem[netKey] = 0;
      });
      finalOnlineArr.push(saleOnlyItem);
    }
  });
  
  baseArr = finalOnlineArr;

} else if ({{tabs1.value}} === '합계') {
  // '합계' 탭: 오프라인 결과 + 온라인 결과를 합산
  // 각각의 탭 로직을 독립적으로 실행한 후 합침
  
  // 1. 오프라인 데이터 처리 (오프라인 탭 로직과 동일)
  const offlineData = data.filter(i => i.onoff_flag === '오프라인');
  const offlineGrouped = groupBySum(offlineData, keys, sumKeys);
  
  // 2. 온라인 데이터 처리 (온라인 탭 로직과 동일)
  const onlineSourceData = data.filter(i => i.onoff_flag === '온라인');
  const onlineGroupedFromSource = groupBySum(onlineSourceData, keys, sumKeys);
  
  // 판매 데이터를 Map으로 변환
  const onlineSaleMap = new Map();
  onlineGroupedFromSource.forEach(item => {
    const key = `${item.br_cd}-${item.year_cd}-${item.season_cd}-${item.category_name}`;
    onlineSaleMap.set(key, item);
  });

  // 출고 데이터를 기준으로 최종 배열 생성
  const onlineGroupedFromTarget = groupBySum(online_data, keys, sumKeys);
  const finalOnlineArr = [];
  
  onlineGroupedFromTarget.forEach(outItem => {
    const key = `${outItem.br_cd}-${outItem.year_cd}-${outItem.season_cd}-${outItem.category_name}`;
    const saleItem = onlineSaleMap.get(key);
    
    if (saleItem) {
      // 판매 데이터가 있는 경우: 판매량은 판매 데이터에서, 출고량은 출고 데이터에서
      const mergedItem = { ...saleItem };
      netOutKeys.forEach(netKey => {
        mergedItem[netKey] = outItem[netKey] || 0;
      });
      finalOnlineArr.push(mergedItem);
    } else {
      // 판매 데이터가 없는 경우: 출고 데이터만 사용 (판매량은 0으로 초기화)
      const outOnlyItem = { ...outItem };
      outOnlyItem.sale_tag = 0;
      outOnlyItem.sale_qty = 0;
      outOnlyItem.sale_amt = 0;
      if (!outOnlyItem.biz_cd) outOnlyItem.biz_cd = '';
      if (!outOnlyItem.biz_nm) outOnlyItem.biz_nm = '';
      if (!outOnlyItem.year_season_cd) outOnlyItem.year_season_cd = '';
      finalOnlineArr.push(outOnlyItem);
    }
  });
  
  // 판매 데이터에는 있지만 출고 데이터에는 없는 경우도 추가
  onlineGroupedFromSource.forEach(saleItem => {
    const key = `${saleItem.br_cd}-${saleItem.year_cd}-${saleItem.season_cd}-${saleItem.category_name}`;
    const existsInOut = onlineGroupedFromTarget.some(outItem => 
      `${outItem.br_cd}-${outItem.year_cd}-${outItem.season_cd}-${outItem.category_name}` === key
    );
    if (!existsInOut) {
      const saleOnlyItem = { ...saleItem };
      netOutKeys.forEach(netKey => {
        saleOnlyItem[netKey] = 0;
      });
      finalOnlineArr.push(saleOnlyItem);
    }
  });
  
  // 3. 오프라인과 온라인 결과를 합산
  const combinedMap = new Map();
  
  // 오프라인 데이터를 Map에 추가
  offlineGrouped.forEach(item => {
    const key = `${item.br_cd}-${item.year_cd}-${item.season_cd}-${item.category_name}`;
    combinedMap.set(key, { ...item });
  });
  
  // 온라인 데이터를 Map에 합산
  finalOnlineArr.forEach(item => {
    const key = `${item.br_cd}-${item.year_cd}-${item.season_cd}-${item.category_name}`;
    const existing = combinedMap.get(key);
    
    if (existing) {
      // 기존 항목이 있으면 합산
      sumKeys.forEach(sumKey => {
        existing[sumKey] = (existing[sumKey] || 0) + (item[sumKey] || 0);
      });
    } else {
      // 기존 항목이 없으면 새로 추가
      combinedMap.set(key, { ...item });
    }
  });
  
  // Map을 배열로 변환
  baseArr = Array.from(combinedMap.values());
}

// --- ✨ 소계 및 총계 추가, 최종 정렬 (이하 로직은 동일) ---

let finalArr = [...baseArr];

const totKeys = [
  "biz_cd", "biz_nm", "br_cd", "br_nm",
  "year_cd", "year_nm", "season_cd", "season_nm",
  "year_season_cd", "item_grade"
];
const totArr = groupBySum(baseArr, totKeys, sumKeys);

const baseArrKeys = baseArr.length > 0 ? Object.keys(baseArr[0]) : [];
totArr.forEach(item => {
  baseArrKeys.forEach(key => {
    if (!(key in item)) { item[key] = '소계'; }
  });
});
finalArr.push(...totArr);

const totalSums = {};
sumKeys.forEach(key => totalSums[key] = 0);
baseArr.forEach(item => {
  sumKeys.forEach(key => { totalSums[key] += Number(item[key]) || 0; });
});

const totalObj = {
  year_nm: 'A',
  category_name: '총계',
  category_order: "-1",
  season_nm: '총계',
  item_grade:'총계',
  ...totalSums
};
finalArr.push(totalObj);

//primay key를 위해 idx 추가
const _finalArr = finalArr.map(item => ({
  ...item,
  idx: `${item.item_grade}-${item.category_name}`
}));

return _finalArr.sort((a, b) => {
  const yearA = a.year_nm || '';
  const yearB = b.year_nm || '';
  const yearComparison = yearB.localeCompare(yearA, "ko");
  if (yearComparison !== 0) return yearComparison;

  const orderA = a.category_order != null ? Number(a.category_order) : Infinity;
  const orderB = b.category_order != null ? Number(b.category_order) : Infinity;
  return orderA - orderB;
});