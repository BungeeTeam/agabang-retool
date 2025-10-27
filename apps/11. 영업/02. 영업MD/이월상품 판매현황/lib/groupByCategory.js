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
  const onlineSourceData = data.filter(i => i.onoff_flag === '온라인');
  const onlineGroupedFromSource = groupBySum(onlineSourceData, keys, sumKeys);

  const onlineTargetMap = new Map();
  groupBySum(online_data, keys, sumKeys).forEach(item => {
    const key = `${item.br_cd}-${item.year_cd}-${item.season_cd}-${item.category_name}`;
    onlineTargetMap.set(key, item);
  });

  onlineGroupedFromSource.forEach(item => {
    const key = `${item.br_cd}-${item.year_cd}-${item.season_cd}-${item.category_name}`;
    const targetData = onlineTargetMap.get(key);
    if (targetData) {
      // online_data의 출고량 값으로 덮어쓰기
      netOutKeys.forEach(netKey => {
        item[netKey] = targetData[netKey] || 0;
      });
    } else {
      // 매칭되는 온라인 출고량이 없으면 0으로 처리
      netOutKeys.forEach(netKey => {
        item[netKey] = 0;
      });
    }
  });
  baseArr = onlineGroupedFromSource;

} else if ({{tabs1.value}} === '합계') {
  // '합계' 탭: (전체 판매량) + (오프라인 출고량 + 온라인 출고량)
  
  // 1. 전체 데이터 합산 (올바른 전체 판매량 + (오프라인+소스온라인) 출고량)
  const allGrouped = groupBySum(data, keys, sumKeys);

  // 2. 소스 데이터 중 '온라인' 출고량만 따로 계산 (나중에 빼줄 값)
  const onlineSourceData = data.filter(i => i.onoff_flag === '온라인');
  const onlineSourceMap = new Map();
  groupBySum(onlineSourceData, keys, sumKeys).forEach(item => {
    const key = `${item.br_cd}-${item.year_cd}-${item.season_cd}-${item.category_name}`;
    onlineSourceMap.set(key, item);
  });
  
  // 3. 최종적으로 반영할 '타겟' 온라인 출고량 데이터 (나중에 더해줄 값)
  const onlineTargetMap = new Map();
  groupBySum(online_data, keys, sumKeys).forEach(item => {
    const key = `${item.br_cd}-${item.year_cd}-${item.season_cd}-${item.category_name}`;
    onlineTargetMap.set(key, item);
  });

  // 4. 최종 계산: (전체합) - (소스온라인출고) + (타겟온라인출고)
  allGrouped.forEach(item => {
    const key = `${item.br_cd}-${item.year_cd}-${item.season_cd}-${item.category_name}`;
    const sourceOnline = onlineSourceMap.get(key);
    const targetOnline = onlineTargetMap.get(key);

    netOutKeys.forEach(netKey => {
        const initialValue = item[netKey] || 0;
        const sourceValue = sourceOnline ? (sourceOnline[netKey] || 0) : 0;
        const targetValue = targetOnline ? (targetOnline[netKey] || 0) : 0;
        item[netKey] = initialValue - sourceValue + targetValue;
    });
  });
  baseArr = allGrouped;
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
  ...totalSums
};
finalArr.push(totalObj);

return finalArr.sort((a, b) => {
  const yearA = a.year_nm || '';
  const yearB = b.year_nm || '';
  const yearComparison = yearB.localeCompare(yearA, "ko");
  if (yearComparison !== 0) return yearComparison;

  const orderA = a.category_order != null ? Number(a.category_order) : Infinity;
  const orderB = b.category_order != null ? Number(b.category_order) : Infinity;
  return orderA - orderB;
});