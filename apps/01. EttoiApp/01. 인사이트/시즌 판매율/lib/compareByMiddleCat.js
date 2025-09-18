// --- 메인 로직 시작 ---

// 0. 기본 설정
const THIS_YEAR_CD = {{ season_select.selectedItem.year_cd }};
const LAST_YEAR_CD = {{ season_select.selectedItem.prev_year_cd }};
const data = {{ salesBySmallCat.value}}; // 혹은 salesByLargeCat.value 등 원본 데이터

// ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ [STEP 1] 데이터 사전 계산 (Enrichment) ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼

const enrichedData = data.map(item => {
  // 숫자 변환 및 기본값(0) 처리로 안정성 확보
  const st_count = Number(item.st_count) || 0;
  const ord_tag_amt = Number(item.ord_tag_amt) || 0;
  const in_st_count = Number(item.in_st_count) || 0;
  const out_st_count = Number(item.out_st_count) || 0;
  const tot_in_qty = Number(item.tot_in_qty) || 0;
  const tot_sale_qty = Number(item.tot_sale_qty) || 0;
  const tot_in_cost = Number(item.tot_in_cost) || 0;
  const tot_in_tag = Number(item.tot_in_tag) || 0;
  const tot_sale_tag = Number(item.tot_sale_tag) || 0;
  const tot_sale_amt = Number(item.tot_sale_amt) || 0;
  const p_week_sale_tag = Number(item.p_week_sale_tag) || 0;
  const week_sale_tag = Number(item.week_sale_tag) || 0;
  
  // --- 새로운 KPI 계산 ---
  // 0으로 나누는 오류(division by zero)를 항상 방지합니다.
  const in_rate = (ord_tag_amt === 0) ? 0 : tot_in_tag / ord_tag_amt;
  const not_in_st_count = st_count - in_st_count;
  const in_st_rate = (st_count === 0) ? 0 : in_st_count / st_count;
  const not_out_st_count = in_st_count - out_st_count;
  const out_st_rate = (in_st_count === 0) ? 0 : out_st_count / in_st_count;
  const tot_sale_rate_qty = (tot_in_qty === 0) ? 0 : tot_sale_qty / tot_in_qty;
  const markup = (tot_in_cost === 0) ? 0 : tot_in_tag / tot_in_cost;
  const tot_sale_rate_tag = (tot_in_tag === 0) ? 0 : tot_sale_tag / tot_in_tag;
  const tot_sale_rate_amt = (tot_in_tag === 0) ? 0 : tot_sale_amt / tot_in_tag;
  const discount_rate = (tot_sale_tag === 0) ? 0 : 1 - (tot_sale_amt / tot_sale_tag);
  const inven_qty = tot_in_qty - tot_sale_qty;
  const inven_tag = tot_in_tag - tot_sale_tag;
  // '진도율'은 '해당 기간 판매금액(TAG) / 누적 입고금액(TAG)'으로 가정하여 계산합니다.
  const p_week_sale_rate = (tot_in_tag === 0) ? 0 : p_week_sale_tag / tot_in_tag;
  const week_sale_rate = (tot_in_tag === 0) ? 0 : week_sale_tag / tot_in_tag;
  const diff_sale_rate = week_sale_rate - p_week_sale_rate;

  // 기존 객체에 새로 계산한 KPI들을 추가하여 반환
  return {
    ...item,
    in_rate,not_in_st_count, in_st_rate, not_out_st_count, out_st_rate,
    tot_sale_rate_qty, markup, tot_sale_rate_tag, tot_sale_rate_amt,
    discount_rate, inven_qty, inven_tag, p_week_sale_rate, week_sale_rate,
    diff_sale_rate
  };
});


// ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ [STEP 2] 연도별 차이 계산 (기존 로직 확장) ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼

// 차이를 계산할 전체 키 목록 (새로 추가한 KPI 키 모두 포함)
const numericKeys = [
  "ord_qty", "ord_tag_amt", "st_count", "in_st_count", "out_st_count", 
  "tot_in_qty", "tot_in_cost", "tot_in_tag", "tot_sale_qty", "tot_sale_tag", 
  "tot_sale_amt", "month_sale_qty", "month_sale_tag", "month_sale_amt", 
  "p_week_sale_qty", "p_week_sale_tag", "p_week_sale_amt", "week_sale_qty", 
  "week_sale_tag", "week_sale_amt", "in_ratio", "sale_ratio",
  // 새로 추가된 KPI 키들
  "in_rate","not_in_st_count", "in_st_rate", "not_out_st_count", "out_st_rate", 
  "tot_sale_rate_qty", "markup", "tot_sale_rate_tag", "tot_sale_rate_amt",
  "discount_rate", "inven_qty", "inven_tag", "p_week_sale_rate", 
  "week_sale_rate", "diff_sale_rate"
];

// 1. 데이터를 (large_cat + middle_cat) 기준으로 재구성
const dataByCategory = enrichedData.reduce((acc, item) => {
  // ▼▼▼▼▼ [수정] 그룹핑 키를 복합 키로 변경 ▼▼▼▼▼
  const compositeKey = `${item.large_cat}-${item.small_cat}`;
  
  if (!acc[compositeKey]) {
    acc[compositeKey] = {};
  }
  
  if (item.year_cd === THIS_YEAR_CD) {
    acc[compositeKey].thisYear = item;
  } else if (item.year_cd === LAST_YEAR_CD) {
    acc[compositeKey].lastYear = item;
  }
  // ▲▲▲▲▲ [수정] 그룹핑 키를 복합 키로 변경 ▲▲▲▲▲
  
  return acc;
}, {});


// 2. 재구성된 데이터를 기반으로 차이(difference) 계산
const differenceData = Object.values(dataByCategory).map(categoryData => {
  
  const thisYear = categoryData.thisYear || {};
  const lastYear = categoryData.lastYear || {};

  // ▼▼▼▼▼ [수정] 최종 결과에 middle_cat 추가 ▼▼▼▼▼
  const resultRow = {
    year_nm: thisYear.year_nm || lastYear.year_nm,
    year_cd: thisYear.year_cd || lastYear.year_cd,
    total: thisYear.total || lastYear.total,
    cat_group: thisYear.cat_group || lastYear.cat_group,
    apparel_group: thisYear.apparel_group || lastYear.apparel_group,
    large_cat: thisYear.large_cat || lastYear.large_cat,
    small_cat: thisYear.small_cat || lastYear.small_cat, // middle_cat 추가
    it: thisYear.it || lastYear.it,
  };
  // ▲▲▲▲▲ [수정] 최종 결과에 middle_cat 추가 ▲▲▲▲▲

  numericKeys.forEach(key => {
    const thisYearValue = Number(thisYear[key]) || 0;
    const lastYearValue = Number(lastYear[key]) || 0;
    resultRow[key] = thisYearValue - lastYearValue;
  });

  return resultRow;
});

// 최종적으로 차이값만 계산된 데이터를 반환
return differenceData;