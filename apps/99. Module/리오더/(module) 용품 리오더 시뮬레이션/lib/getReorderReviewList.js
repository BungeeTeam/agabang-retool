// Query Name: getReorderReviewList

// 1. 데이터 가져오기
const selectedItems = reorderSimulationTargets.value;
const manufacturingData = get_manufactoring_team_input_data.data || [];
const moqLeadtimeData = get_reorder_moq_leadtime_info.data || []; // MOQ 및 리드타임 데이터 가져오기

// --- Optional: Data Validation ---
if (!Array.isArray(selectedItems)) {
  console.error("selectedReorderItems.value가 배열이 아닙니다:", selectedItems);
  return {
    reviewedList: [],
    count: 0,
    totalReorderQty: 0,
    totalCost: 0,
    avgEstimatedFinalSaleRate: 0,
    summaryText: "오류: selectedItems 데이터 형식이 잘못되었습니다."
  };
}

// 2. 제조팀 데이터 룩업 맵 생성 (개선된 버전)
const manufacturingMap = new Map();
manufacturingData.forEach(mfgItem => {
  // 문자열 정규화 및 유효성 검사 강화
  const styleCode = String(mfgItem.sty_cd || '').trim();
  const colorCode = String(mfgItem.col_cd || '').trim();
  
  if (styleCode && colorCode) { // 빈 문자열 체크도 포함
    const key = `${styleCode}|${colorCode}`;
    manufacturingMap.set(key, mfgItem);
    console.log(`제조팀 데이터 추가: ${key}`); // 디버깅용 로그
  }
});

console.log(`제조팀 데이터 총 ${manufacturingMap.size}개 항목 로드됨`);

// 2.1 MOQ 및 리드타임 데이터 맵 생성 (item 소분류 코드 기준)
const moqLeadtimeMap = new Map();
moqLeadtimeData.forEach(info => {
  if (info && info.item) {
    // 소분류(item) 코드를 키로 사용
    moqLeadtimeMap.set(String(info.item), {
      moq: parseInt(info.moq || 500),
      lead_time: parseInt(info.lead_time || 90),
      item_nm: info.item_nm || '' // 디버깅용 아이템명 추가
    });
  }
});

// 3. Input 컴포넌트 값 가져오기 (유효성 검사 포함)
let inputSalesRate = parseFloat(inputExpectedSalesRate.value);
if (isNaN(inputSalesRate) || inputSalesRate < 0.1 || inputSalesRate > 1.0) {
  console.warn(`유효하지 않은 예상 판매율(${inputSalesRate}), 기본값 0.8을 사용합니다.`);
  inputSalesRate = 0.8;
}

let inputSalesPeriod = parseInt(inputExpectedSalesPeriod.value);
if (isNaN(inputSalesPeriod) || inputSalesPeriod < 1 || inputSalesPeriod > 24) {
  console.warn(`유효하지 않은 예상 판매기간(${inputSalesPeriod}), 기본값 6개월을 사용합니다.`);
  inputSalesPeriod = 6;
}

// 4. selectedItems 순회하며 데이터 병합 및 계산
const reviewedList = selectedItems.map(item => {
  // 키 생성 시 문자열 정규화
  const itemStyleCode = String(item.sty_cd || '').trim();
  const itemColorCode = String(item.col_cd || '').trim();
  const key = `${itemStyleCode}|${itemColorCode}`;
  
  const matchingMfgData = manufacturingMap.get(key);
  const hasSheetData = !!matchingMfgData;

  // 디버깅용 로그
  if (hasSheetData) {
    console.log(`✓ 시트 데이터 발견: ${key}`);
  } else {
    console.log(`✗ 시트 데이터 없음: ${key}`);
  }

  // 소분류(item) 코드로 MOQ 및 리드타임 정보 가져오기
  const itemCode = String(item.item || ''); // 문자열로 변환하여 일관성 유지
  const moqLeadtimeInfo = itemCode ? moqLeadtimeMap.get(itemCode) : null;
  
  // --- 최종 객체에 포함될 변수 선언 및 초기화 ---
  // 리드타임 값 결정 (우선순위: 제조팀 데이터 > MOQ/리드타임 테이블 > 아이템 데이터 > 기본값)
  let confirmed_lead_time = 90; // 기본값
  let confirmed_moq = 500; // 기본값
  let moq_lead_time_source = "default"; // 데이터 출처 추적용
  
  // MOQ 및 리드타임 정보 설정 우선순위에 따라 적용
  if (hasSheetData && matchingMfgData.lead_time) {
    // 1순위: 제조팀 데이터
    confirmed_lead_time = parseInt(matchingMfgData.lead_time || 90);
    confirmed_moq = parseInt(matchingMfgData.moq || 500);
    moq_lead_time_source = "manufacturing";
    console.log(`${key}: 제조팀 데이터 사용 - Lead Time: ${confirmed_lead_time}, MOQ: ${confirmed_moq}`);
  } else if (moqLeadtimeInfo) {
    // 2순위: MOQ/리드타임 테이블 데이터 (소분류 기준)
    confirmed_lead_time = moqLeadtimeInfo.lead_time;
    confirmed_moq = moqLeadtimeInfo.moq;
    moq_lead_time_source = "moq_leadtime_table";
    console.log(`${key}: 소분류(${itemCode}:${moqLeadtimeInfo.item_nm}) 기반 MOQ/리드타임 테이블 사용 - Lead Time: ${confirmed_lead_time}, MOQ: ${confirmed_moq}`);
  } else if (item.lead_time_days || item.moq) {
    // 3순위: 아이템 자체에 포함된 값 (manageReorderSelection에서 이미 수집됨)
    confirmed_lead_time = parseInt(item.lead_time_days || 90);
    confirmed_moq = parseInt(item.moq || 500);
    moq_lead_time_source = "item_data";
    console.log(`${key}: 아이템 자체 데이터 사용 - Lead Time: ${confirmed_lead_time}, MOQ: ${confirmed_moq}`);
  } else {
    // 4순위: 기본값
    console.log(`${key}: 소분류(${itemCode}) 정보 없음, 기본값 사용 - Lead Time: ${confirmed_lead_time}, MOQ: ${confirmed_moq}`);
  }
  
  let modifiable_cost_price = parseFloat(item.cost_price || 0);
  let manufacturer_stock = parseFloat(item.manufacturer_stock || 0);
  let note_from_sheet = '';

  // --- 원본 item에서 값 가져오기 ---
  const original_cost_price = parseFloat(item.cost_price || 0);
  const tag_price = parseFloat(item.tag_price || 0);
  const current_stock_qty = parseInt(item.current_stock_qty || 0);
  const original_moq = parseInt(item.moq || confirmed_moq);
  
  // 유효 판매량 결정: effective_monthly_sales > avgMonthlySales 순으로 확인
  let avg_monthly_sales = 0;
  if (typeof item.effective_monthly_sales === 'number' && item.effective_monthly_sales > 0) {
    avg_monthly_sales = item.effective_monthly_sales;
  } else if (typeof item.avgMonthlySales === 'number' && item.avgMonthlySales > 0) {
    avg_monthly_sales = item.avgMonthlySales;
  } else {
    // 대체 판매량 소스들 (180일, 365일, 30일 순)
    if (typeof item.avg_monthly_sales_d180 === 'number' && item.avg_monthly_sales_d180 > 0) {
      avg_monthly_sales = item.avg_monthly_sales_d180;
    } else if (typeof item.avg_monthly_sales_d365 === 'number' && item.avg_monthly_sales_d365 > 0) {
      avg_monthly_sales = item.avg_monthly_sales_d365;
    } else if (typeof item.avg_monthly_sales_d30 === 'number' && item.avg_monthly_sales_d30 > 0) {
      avg_monthly_sales = item.avg_monthly_sales_d30;
    }
  }
  
  const emergency_stock = parseInt(item.emergency_stock || 400);
  const tot_in_qty = parseInt(item.tot_in_qty || 0);
  const tot_sale_qty = parseInt(item.tot_sale_qty || 0);

  // --- 기본 계산 ---
  const price_multiple = original_cost_price > 0 ? tag_price / original_cost_price / 1.1 : 0;
  const avg_daily_sales = avg_monthly_sales / 30;
  const total_period_days = inputSalesPeriod * 30;

  // --- 시트 데이터 처리 ---
  if (hasSheetData) {
    modifiable_cost_price = parseFloat(matchingMfgData.reorder_cost || original_cost_price);
    manufacturer_stock = parseInt(matchingMfgData.manufacturer_stock || 0);
    note_from_sheet = matchingMfgData.note || '';
    console.log(`시트 데이터 적용: ${key} - 원가: ${modifiable_cost_price}, 재고: ${manufacturer_stock}`);
  }

  // --- 리오더 관련 계산 ---
  let expected_sales = 0; // 리드타임 동안 예상 판매량
  let total_expected_sales_qty = 0; // 전체 기간 예상 판매량
  let expected_supply_qty = 0; // 필요 공급량 (MOQ 적용 전)
  let recommended_reorder_qty = 0; // 필요 공급량 (소수점 포함, MOQ/Rounding 적용 전 Raw 값)
  let final_reorder_qty = 0; // 최종 리오더 수량 (MOQ, Rounding 적용)
  let estimated_ending_stock = current_stock_qty; // 기본값: 현재고 (계산 불가시)
  let estimated_final_sale_rate = parseFloat(item.sale_rate || 0); // 기본값: 과거 판매율

  // 판매량이 있는 경우에만 계산
  if (avg_daily_sales > 0) {
    expected_sales = avg_daily_sales * confirmed_lead_time; // 확정된 리드타임 사용
    total_expected_sales_qty = avg_daily_sales * total_period_days;

    const totalRequiredStock = emergency_stock + total_expected_sales_qty;
    const totalShortage = Math.max(0, totalRequiredStock - current_stock_qty);

    expected_supply_qty = inputSalesRate > 0 ? (totalShortage / inputSalesRate) : 0;

    const roundedUpReorderQty = Math.ceil(expected_supply_qty / 10) * 10;
    recommended_reorder_qty = roundedUpReorderQty; // Raw 값 저장
    final_reorder_qty = Math.max(roundedUpReorderQty, confirmed_moq); // 확정된 MOQ 사용

    // 만약 리오더가 필요 없다면 (shortage가 없다면) 0으로 설정
    if (totalShortage <= 0) {
      final_reorder_qty = 0;
    }

    const expectedTotalSupply = current_stock_qty + final_reorder_qty; // 실제 리오더 반영
    estimated_ending_stock = expectedTotalSupply - total_expected_sales_qty;

    const historicalAndFutureSupply = tot_in_qty + final_reorder_qty;
    const historicalAndFutureSales = Math.min(historicalAndFutureSupply, tot_sale_qty + total_expected_sales_qty);
    estimated_final_sale_rate = historicalAndFutureSupply > 0 ? historicalAndFutureSales / historicalAndFutureSupply : 0;

  } else {
    final_reorder_qty = 0;
    console.warn(`${key}: 판매량 데이터 부족 또는 0으로 리오더 계산 불가.`);
  }

  const price_reorder_multiple = modifiable_cost_price > 0 ? tag_price / modifiable_cost_price / 1.1 : 0;

  // --- 최종 반환 객체 생성 ---
  const finalItem = {
    reorder_recommending_status: item.reorder_recommending_status,
    wh_reorder_recommending_status: item.wh_reorder_recommending_status,
    image_url: item.이미지 || item.image_url,
    sty_nm: item.sty_nm,
    col_nm: item.col_nm,
    size_nm: item.size_nm,
    series_name: item.series_name,
    cust_nm: item.cust_nm,
    fabric: item.fabric,
    tag_price: tag_price,
    cost_price: original_cost_price, 
    priceMultiple: price_multiple,
    modifiableCostPrice: modifiable_cost_price,
    priceReorderMultiple: price_reorder_multiple,
    current_stock_qty: current_stock_qty,
    sh_stck_qty: parseInt(item.sh_stck_qty || 0),
    wh_stck_qty: parseInt(item.wh_stck_qty || 0),
    manufacturer_stock: manufacturer_stock,
    sale_rate: parseFloat(item.sale_rate || 0),
    sty_cd: item.sty_cd,
    col_cd: item.col_cd,
    size_cd: item.size_cd,
    cust_cd: item.cust_cd,
    _type: item._type,
    recommended_reorder_qty: recommended_reorder_qty,
    final_reorder_qty: final_reorder_qty,
    groupId: item.groupId,
    lead_time_days: confirmed_lead_time,
    confirmed_lead_time: confirmed_lead_time,
    target_sale_rate: inputSalesRate,
    moq: original_moq,
    confirmed_moq: confirmed_moq,
    emergency_stock: emergency_stock,
    expected_sales: expected_sales,
    effective_monthly_sales: avg_monthly_sales,
    avgDailySales: avg_daily_sales,
    avgMonthlySales: avg_monthly_sales,
    expectedSalesPeriod: inputSalesPeriod,
    expectedSupplyQty: expected_supply_qty,
    totalExpectedSalesQty: total_expected_sales_qty,
    estimatedEndingStock: estimated_ending_stock,
    estimatedFinalSaleRate: estimated_final_sale_rate,
    note: note_from_sheet,
    has_sheet_data: hasSheetData, // ✓ 이 부분이 스프레드시트 데이터 존재 여부를 나타냅니다
    moq_lead_time_source: moq_lead_time_source,

    // 재계산에 필요한 필드
    tot_in_qty: tot_in_qty,
    tot_sale_qty: tot_sale_qty,
    
    // 소분류 코드 저장 (MOQ/리드타임 테이블 연동용)
    item: itemCode,
    item_nm: item.item_nm,
    
    // 디버깅 정보에 시트 데이터 정보 추가
    debug_info: {
      avg_monthly_sales: avg_monthly_sales,
      avg_daily_sales: avg_daily_sales,
      expected_sales: expected_sales,
      total_expected_sales_qty: total_expected_sales_qty,
      emergency_stock: emergency_stock,
      totalRequiredStock: emergency_stock + total_expected_sales_qty,
      totalShortage: Math.max(0, (emergency_stock + total_expected_sales_qty) - current_stock_qty),
      expected_supply_qty: expected_supply_qty,
      confirmed_moq: confirmed_moq,
      moq_lead_time_source: moq_lead_time_source,
      sheet_data_key: key, // 시트 데이터 검색에 사용된 키
      has_sheet_data: hasSheetData // 디버깅용 중복 저장
    }
  };

  return finalItem;
}); // .map() 끝

// 5. 시트 데이터 통계 출력
const sheetDataCount = reviewedList.filter(item => item.has_sheet_data).length;
console.log(`총 ${reviewedList.length}개 항목 중 ${sheetDataCount}개 항목에 시트 데이터가 있습니다.`);

// 6. 총계 계산
const totalReorderQty = reviewedList.reduce(
  (sum, item) => sum + (item.final_reorder_qty || 0), 0
);

const totalCost = reviewedList.reduce(
  (sum, item) => sum + ((item.final_reorder_qty || 0) * (item.modifiableCostPrice || 0)), 0
);

const avgEstimatedFinalSaleRate = reviewedList.length > 0 ?
  reviewedList.reduce((sum, item) => sum + (item.estimatedFinalSaleRate || 0), 0) / reviewedList.length : 0;

const summaryText = `총 ${reviewedList.length}개 항목 선택됨 (시트 데이터: ${sheetDataCount}개) | 총 리오더 수량: ${totalReorderQty.toLocaleString()} | 예상 비용: ${totalCost.toLocaleString()}원 | 예상 평균 판매율: ${(avgEstimatedFinalSaleRate * 100).toFixed(1)}%`;

// 7. 통계 정보 추가 (소스별 아이템 수 카운트)
const sourceStats = {
  manufacturing: reviewedList.filter(item => item.moq_lead_time_source === "manufacturing").length,
  moq_leadtime_table: reviewedList.filter(item => item.moq_lead_time_source === "moq_leadtime_table").length,
  item_data: reviewedList.filter(item => item.moq_lead_time_source === "item_data").length,
  default: reviewedList.filter(item => item.moq_lead_time_source === "default").length,
  has_sheet_data: sheetDataCount // 시트 데이터 통계 추가
};

// 8. 최종 결과 반환
return {
  reviewedList: reviewedList,
  count: reviewedList.length,
  totalReorderQty: totalReorderQty,
  totalCost: totalCost,
  avgEstimatedFinalSaleRate: avgEstimatedFinalSaleRate,
  summaryText: summaryText,
  sourceStats: sourceStats // 데이터 소스 통계
};