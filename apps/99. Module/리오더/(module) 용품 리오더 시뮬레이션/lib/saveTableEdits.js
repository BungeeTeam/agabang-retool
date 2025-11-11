// --- Helper Function with Auto Reorder Qty Calculation ---
function recalculateDependentFields(row) {
  console.log("--------------------------------------------------");
  console.log(`[Helper Debug] recalculateDependentFields 시작 for groupId: ${row.groupId}`);
  console.log("[Helper Debug] 입력 Row:", JSON.stringify(row, null, 2));

  let updatedRow = { ...row };

  // --- Parse and Log Input Values ---
  console.log("[Helper Debug] Parsing inputs for calculation...");
  const tag_price = parseFloat(updatedRow.tag_price || 0);
  const modifiableCostPrice = parseFloat(updatedRow.modifiableCostPrice || 0);
  // const initial_final_reorder_qty = parseInt(updatedRow.final_reorder_qty || 0); // 이 변수는 아래 로직에서 직접 사용되지 않음
  const confirmed_lead_time = parseInt(updatedRow.confirmed_lead_time || 90);
  const expectedSalesPeriod = parseInt(updatedRow.expectedSalesPeriod || 6);
  // target_sale_rate 파싱 - 퍼센트 문자열 처리
  let target_sale_rate = updatedRow.target_sale_rate || 0.8;
  if (typeof target_sale_rate === 'string') {
    // "80%" 형태의 문자열을 0.8로 변환
    if (target_sale_rate.includes('%')) {
      target_sale_rate = parseFloat(target_sale_rate.replace('%', '')) / 100;
    } else {
      target_sale_rate = parseFloat(target_sale_rate);
    }
  } else {
    target_sale_rate = parseFloat(target_sale_rate);
  }
  // 기본값 보정 (0~1 사이가 아닌 경우)
  if (isNaN(target_sale_rate) || target_sale_rate <= 0 || target_sale_rate > 1) {
    target_sale_rate = 0.8;
  }
  // 변환된 값을 updatedRow에 저장하여 출력에도 반영
  updatedRow.target_sale_rate = target_sale_rate;
  
  // 먼저 tot_in_qty, tot_sale_qty, manufacturer_stock을 파싱
  const tot_in_qty = parseInt(updatedRow.tot_in_qty || 0);
  const tot_sale_qty = parseInt(updatedRow.tot_sale_qty || 0);
  const manufacturer_stock = parseInt(updatedRow.manufacturer_stock || 0);
  
  // 총재고 재계산: tot_in_qty - tot_sale_qty + manufacturer_stock
  const recalculated_current_stock_qty = tot_in_qty - tot_sale_qty + manufacturer_stock;
  updatedRow.current_stock_qty = recalculated_current_stock_qty;
  const current_stock_qty = recalculated_current_stock_qty;
  
  // 업체 재고가 이미 포함된 총재고이므로 중복 추가 제거
  const adjustedCurrentStock = current_stock_qty;
  
  // avgMonthlySales 값 확인 및 avgDailySales 계산
  const avgMonthlySales = parseFloat(updatedRow.avgMonthlySales || 0);
  // avgMonthlySales 직접 매핑 - 변경된 avgMonthlySales 값이 expected_sales에 반영되도록
  let avgDailySales = avgMonthlySales / 30;
  
  // 원래 avgDailySales 값과 비교해 로깅
  const originalAvgDailySales = parseFloat(updatedRow.avgDailySales || 0);
  // avgMonthlySales가 실제로 변경된 경우에만 avgDailySales를 재계산하고 로그를 남깁니다.
  // 그렇지 않으면, 테이블에서 avgDailySales가 직접 수정되었을 수 있으므로 기존 값을 유지합니다.
  if (updatedRow.avgMonthlySales !== undefined && Math.abs(avgMonthlySales - (originalAvgDailySales * 30)) > 0.0001 * 30) {
    console.log(`[Helper Debug] avgMonthlySales 변경 감지: ${avgMonthlySales}`);
    console.log(`[Helper Debug] avgDailySales 재계산: ${originalAvgDailySales} -> ${avgDailySales}`);
    updatedRow.avgDailySales = avgDailySales;
  } else {
    // avgMonthlySales가 변경되지 않았거나 undefined인 경우, 기존 avgDailySales 값을 사용합니다.
    avgDailySales = originalAvgDailySales;
  }
  
  const sale_rate = parseFloat(updatedRow.sale_rate || 0);
  const emergency_stock = parseInt(updatedRow.emergency_stock || 400);
  const confirmed_moq = parseInt(updatedRow.confirmed_moq || 500);  

  // 수정된 로그: 총재고 재계산 반영
  console.log(`  tot_in_qty: ${tot_in_qty}`);
  console.log(`  tot_sale_qty: ${tot_sale_qty}`);
  console.log(`  manufacturer_stock: ${manufacturer_stock}`);
  console.log(`  recalculated_current_stock_qty (tot_in_qty - tot_sale_qty + manufacturer_stock): ${current_stock_qty}`);
  console.log(`  adjustedCurrentStock (same as current_stock_qty): ${adjustedCurrentStock}`);

  // Log parsed values including the initial recommended_reorder_qty from the input row for clarity
  console.log(`  tag_price: ${tag_price}`);
  console.log(`  modifiableCostPrice: ${modifiableCostPrice}`);
  console.log(`  confirmed_lead_time: ${confirmed_lead_time}`);
  console.log(`  expectedSalesPeriod (From Row): ${expectedSalesPeriod}`);
  console.log(`  target_sale_rate (From Row): ${target_sale_rate}`);
  console.log(`  avgMonthlySales: ${avgMonthlySales}`);
  console.log(`  avgDailySales: ${avgDailySales}`); // 이 값은 위에서 조건부로 업데이트됨
  console.log(`  sale_rate: ${sale_rate}`);
  console.log(`  emergency_stock: ${emergency_stock}`);
  console.log(`  confirmed_moq: ${confirmed_moq}`);
  console.log(`  recommended_reorder_qty (from input row before calc): ${updatedRow.recommended_reorder_qty}`);


  // NaN Check
  if (isNaN(avgDailySales)) {
    console.warn("[Helper Debug] avgDailySales is NaN, using 0 instead");
    avgDailySales = 0;
    updatedRow.avgDailySales = 0; // Ensure avgDailySales in updatedRow is also set to 0
  }

  // --- Recalculate Dependent Fields ---
  console.log("[Helper Debug] Starting dependent calculations...");

  // 1. priceReorderMultiple
  updatedRow.priceReorderMultiple = modifiableCostPrice > 0 ? tag_price / modifiableCostPrice / 1.1 : 0;
  console.log(`  1. priceReorderMultiple = ${updatedRow.priceReorderMultiple}`);

  // Initialize calculated values
  let calculated_expected_sales = 0;
  let calculated_total_expected_sales_qty = 0;
  let calculated_expected_supply_qty = 0;
  // calculated_final_reorder_qty 와 calculated_recommended_reorder_qty 는 아래 로직에서 updatedRow에 직접 할당됩니다.

  // 2. avgDailySales 기반 계산
  if (avgDailySales > 0 && !isNaN(avgDailySales)) {
      console.log("[Helper Debug]  2. avgDailySales > 0 branch...");

      // 2a. 개선 2: 리드타임에 따른 예상 판매량 계산 (리드타임 변경 시 영향)
      calculated_expected_sales = avgDailySales * confirmed_lead_time;
      updatedRow.expected_sales = calculated_expected_sales;
      console.log(`    2a. expected_sales = ${calculated_expected_sales} (avgDailySales * confirmed_lead_time)`);

      // 2b. 전체 판매 기간 동안의 총 예상 판매량
      const total_period_days = expectedSalesPeriod * 30;
      calculated_total_expected_sales_qty = avgDailySales * total_period_days;
      updatedRow.totalExpectedSalesQty = calculated_total_expected_sales_qty;
      console.log(`    2b. totalExpectedSalesQty = ${calculated_total_expected_sales_qty}`);

      // 2c. 개선 1: 기획안에 맞게 리오더 수량 계산 공식 수정
      console.log("[Helper Debug]  2c. Calculating expectedSupplyQty using formula from planning document...");
      console.log(`    emergency_stock: ${emergency_stock}`);
      console.log(`    calculated_total_expected_sales_qty: ${calculated_total_expected_sales_qty}`);
      console.log(`    current_stock_qty: ${current_stock_qty}`);
      
      // expectedSupplyQty = (전체 기간 예상 판매량 + 안전 재고 - 업체 재고를 포함한 총 재고량)
      calculated_expected_supply_qty = Math.max(0, calculated_total_expected_sales_qty + emergency_stock - current_stock_qty);
            updatedRow.expectedSupplyQty = calculated_expected_supply_qty;
      
      // recommended_reorder_qty = expectedSupplyQty / 목표 판매율
      const totalShortage = calculated_expected_supply_qty;
      const calculated_recommended_reorder_qty = target_sale_rate > 0 ? (totalShortage / target_sale_rate) : 0;
      
      console.log(`    expectedSupplyQty: ${calculated_expected_supply_qty}`);
      console.log(`    target_sale_rate: ${target_sale_rate}`);
      console.log(`    calculated_recommended_reorder_qty: ${calculated_recommended_reorder_qty}`);
      updatedRow.expectedSupplyQty = calculated_expected_supply_qty;

      // --- 여기가 핵심 수정 부분 ---

    // 2d. 리오더 수량 계산 (recommended_reorder_qty 및 final_reorder_qty)
    console.log(`[Helper Debug]  2d. Calculating/Determining Reorder Qtys...`);
    // 우선, 예상 공급량을 기반으로 자동 계산된 권장 리오더 수량을 구합니다 (MOQ 적용 전).
    const auto_calc_recommended_qty = Math.ceil(calculated_recommended_reorder_qty / 10) * 10;
    console.log(`      -> Auto-calculated base recommended_reorder_qty (pre-MOQ, rounded): ${auto_calc_recommended_qty}`);

    // recommended_reorder_qty 처리
    let chosen_recommended_qty;
    const provided_recommended_qty_str = updatedRow.recommended_reorder_qty;

    // 사용자가 입력한 값이 유효한 숫자인지 확인합니다.
    if (provided_recommended_qty_str !== undefined &&
        provided_recommended_qty_str !== null &&
        String(provided_recommended_qty_str).trim() !== '' && // 빈 문자열이 아닌 경우
        !isNaN(parseFloat(String(provided_recommended_qty_str)))) {
        chosen_recommended_qty = parseInt(String(provided_recommended_qty_str));
        // 사용자가 제공한 (또는 기존의 유효한) 값을 recommended_reorder_qty로 사용합니다.
        updatedRow.recommended_reorder_qty = chosen_recommended_qty;
        console.log(`      -> Using provided/existing value for recommended_reorder_qty: ${chosen_recommended_qty}`);
    } else {
        // 사용자가 값을 입력하지 않았거나 유효하지 않은 경우, 자동 계산된 값을 사용합니다.
        chosen_recommended_qty = auto_calc_recommended_qty;
        updatedRow.recommended_reorder_qty = chosen_recommended_qty;
        console.log(`      -> Using auto-calculated value for recommended_reorder_qty: ${chosen_recommended_qty}`);
    }

    // final_reorder_qty 처리 - 사용자가 제공한 값을 우선적으로 사용
    const provided_final_reorder_qty_str = updatedRow.final_reorder_qty;

    // 사용자가 입력한 final_reorder_qty 값이 유효한 숫자인지 확인
    if (provided_final_reorder_qty_str !== undefined &&
        provided_final_reorder_qty_str !== null &&
        String(provided_final_reorder_qty_str).trim() !== '' &&
        !isNaN(parseFloat(String(provided_final_reorder_qty_str)))) {
        // 사용자 입력값 사용
        const user_final_reorder_qty = parseInt(String(provided_final_reorder_qty_str));
        updatedRow.final_reorder_qty = user_final_reorder_qty;
        console.log(`      -> Using user-provided value for final_reorder_qty: ${user_final_reorder_qty}`);
    } else {
        // 사용자 입력이 없는 경우 자동 계산 (기존 로직)
        updatedRow.final_reorder_qty = Math.max(chosen_recommended_qty, confirmed_moq);
        console.log(`      -> Using auto-calculated value for final_reorder_qty: ${updatedRow.final_reorder_qty}`);
    }
      // 2e. 예상 기말 재고 계산 (수정된 공식 적용)
      const final_reorder_qty_to_use = updatedRow.final_reorder_qty; // updatedRow에서 직접 가져옴
      console.log(`[Helper Debug]  2e. Calculating estimatedEndingStock using final_reorder_qty: ${final_reorder_qty_to_use}`);
      
      // 수정된 공식: (업체 재고를 포함한 총 재고량 + final_reorder_qty) - 전체 기간 예상 판매량
      updatedRow.estimatedEndingStock = (current_stock_qty + final_reorder_qty_to_use) - calculated_total_expected_sales_qty;
      console.log(`        -> current_stock_qty (업체재고 포함): ${current_stock_qty}`);
      console.log(`        -> final_reorder_qty: ${final_reorder_qty_to_use}`);
      console.log(`        -> calculated_total_expected_sales_qty: ${calculated_total_expected_sales_qty}`);
      console.log(`        -> Result estimatedEndingStock: ${updatedRow.estimatedEndingStock}`);

      // 2f. 예상 최종 판매율 계산 (새로 계산된 final_reorder_qty 사용)
      console.log(`[Helper Debug]  2f. Calculating estimatedFinalSaleRate using final_reorder_qty: ${final_reorder_qty_to_use}`);
      const historicalAndFutureSupply = tot_in_qty + final_reorder_qty_to_use;
      const historicalAndFutureSales = Math.min(historicalAndFutureSupply, tot_sale_qty + calculated_total_expected_sales_qty);
      updatedRow.estimatedFinalSaleRate = historicalAndFutureSupply > 0 ? historicalAndFutureSales / historicalAndFutureSupply : 0;
      console.log(`        -> Result estimatedFinalSaleRate: ${updatedRow.estimatedFinalSaleRate}`);

  } else {
      console.log("[Helper Debug]  2. avgDailySales <= 0 or NaN branch...");
      // 판매량 0일 때 모든 관련 값 0 또는 기본값으로 설정
      updatedRow.expected_sales = 0;
      updatedRow.totalExpectedSalesQty = 0;
      updatedRow.expectedSupplyQty = 0;
      
      // 사용자가 recommended_reorder_qty를 입력했더라도, 판매량이 0이면 0으로 처리하는 현재 로직을 유지합니다.
      // 만약 이 경우에도 사용자 입력값을 존중하고 싶다면 추가 수정이 필요합니다.
      updatedRow.recommended_reorder_qty = 0;
      updatedRow.final_reorder_qty = 0; 
      
      // 기말 재고 = 업체 재고를 포함한 총 재고량 (리오더 0)
      updatedRow.estimatedEndingStock = current_stock_qty;
      
      // 판매율 = 초기 판매율 (또는 0). 현재 로직은 기존 sale_rate를 사용.
      updatedRow.estimatedFinalSaleRate = sale_rate; 
      console.log(`  판매량이 0이므로 기본값 설정: recommended_reorder_qty=${updatedRow.recommended_reorder_qty}, final_reorder_qty=${updatedRow.final_reorder_qty}`);
  }

  console.log("[Helper Debug] 반환 Row (재계산 완료):", JSON.stringify(updatedRow, null, 2));
  console.log("--------------------------------------------------");
  return updatedRow;
}

// --- Main Logic for Save Button ---
console.log("--- [Save Debug] Save script started (Direct Array Mode) ---");

// 초기 State 확인
const initialDataArray = editableReviewedList.value || [];
const initialDataLength = initialDataArray.length;
console.log(`[Save Debug] Initial data array length from state: ${initialDataLength}`);

if (initialDataLength === 0) {
  console.error("[Save Error] Initial data in 'editableReviewedList' is EMPTY.");
  // 오류 알림 (생략)...
  return;
}

// 1. 변경사항 가져오기
const changesArray = table_reorder_targets2.changesetArray;
if (!changesArray || changesArray.length === 0) {
  // 변경 없음 알림 (생략)...
  return;
}
console.log(`[Save Debug] Found ${changesArray.length} changes in changesetArray.`);
console.log("[Save Debug] ChangesetArray Content:", JSON.stringify(changesArray, null, 2));

// 2. 현재 데이터 Map 생성
const currentDataMap = new Map();
initialDataArray.forEach(row => {
  if (row.groupId !== undefined && row.groupId !== null) {
    currentDataMap.set(row.groupId, { ...row });
  } else {
    console.warn("[Save Warn] Initial data: groupId가 없는 행 발견:", row);
  }
});
const initialMapSize = currentDataMap.size;
console.log(`[Save Debug] Initial data Map size: ${initialMapSize}`);

// 3. 변경사항 병합 및 재계산 루프
console.log("[Save Debug] Starting changes processing loop...");
let processingErrorOccurred = false;

// 변경된 부분: 변경사항에 groupId가 없는 경우 처리
if (changesArray.length === 1 && !changesArray[0].groupId && initialDataArray.length === 1) {
  // 단일 행만 있는 경우 (첫 번째 행에 변경사항 적용)
  console.log("[Save Debug] 단일 행 데이터 감지: 첫 번째 행에 변경사항 적용");
  
  const firstRow = initialDataArray[0];
  const firstRowGroupId = firstRow.groupId;
  
  if (firstRowGroupId) {
      // 변경사항에 groupId 추가
      const enrichedChange = { ...changesArray[0], groupId: firstRowGroupId };
      console.log("[Save Debug] 풍부화된 변경사항:", JSON.stringify(enrichedChange, null, 2));
      
      // 기존 변경사항 배열 대체
      changesArray.length = 0;
      changesArray.push(enrichedChange);
  } else {
      console.warn("[Save Warn] 첫 번째 행에 groupId가 없습니다. 변경사항을 적용할 수 없습니다.");
  }
}

changesArray.forEach((change, index) => {
  const pk = change.groupId;
  
  // groupId 체크 - 변경됨: 더 명확한 로깅
  if (!pk) {
    console.error(`[Save Error] 변경사항 #${index}에 groupId가 없습니다:`, JSON.stringify(change, null, 2));
    processingErrorOccurred = true;
    return;
  }

  const originalRow = currentDataMap.get(pk);

  if (originalRow) {
      console.log(`[Save Debug] 병합: groupId=${pk}`);
      let mergedRow = { ...originalRow, ...change }; // 여기서 change에 recommended_reorder_qty가 있으면 mergedRow에 반영됨
      console.log(`[Save Debug] 병합 결과:`, JSON.stringify(mergedRow, null, 2));
      
      // avgMonthlySales 변경 감지 및 로깅
      const originalAvgMonthlySales = parseFloat(originalRow.avgMonthlySales || 0);
      const newAvgMonthlySales = parseFloat(change.avgMonthlySales !== undefined ? change.avgMonthlySales : originalAvgMonthlySales);
      
      if (Math.abs(originalAvgMonthlySales - newAvgMonthlySales) > 0.0001 && change.avgMonthlySales !== undefined) {
        console.log(`[Save Debug] 평균 월 판매량 변경 감지: ${originalAvgMonthlySales} -> ${newAvgMonthlySales}`);
        
        // expected_sales 직접 업데이트 (avgMonthlySales 변경에 바로 반응하도록)
        const confirmed_lead_time = parseInt(mergedRow.confirmed_lead_time || 90);
        const newDailySales = newAvgMonthlySales / 30;
        const newExpectedSales = newDailySales * confirmed_lead_time;
        
        // 병합된 행에 추가 정보 반영
        mergedRow.avgDailySales = newDailySales; // 여기서 avgDailySales를 업데이트하면 recalculateDependentFields에서 이 값을 사용하게 됨
        mergedRow.expected_sales = newExpectedSales;
        
        console.log(`[Save Debug] expected_sales 업데이트됨: ${newExpectedSales}`);
      }

      // target_sale_rate 변경 감지 및 로깅 (새로 추가)
      const originalTargetSaleRate = parseFloat(originalRow.target_sale_rate || 0.8);
      let newTargetSaleRate = change.target_sale_rate !== undefined ? change.target_sale_rate : originalTargetSaleRate;
      
      // 퍼센트 문자열 처리
      if (typeof newTargetSaleRate === 'string' && newTargetSaleRate.includes('%')) {
        newTargetSaleRate = parseFloat(newTargetSaleRate.replace('%', '')) / 100;
      } else {
        newTargetSaleRate = parseFloat(newTargetSaleRate);
      }
      
      if (Math.abs(originalTargetSaleRate - newTargetSaleRate) > 0.0001 && change.target_sale_rate !== undefined) {
        console.log(`[Save Debug] 목표 판매율 변경 감지: ${originalTargetSaleRate} -> ${newTargetSaleRate}`);
        
        // target_sale_rate 변경 시 recommended_reorder_qty와 final_reorder_qty 재계산을 위해 기존 값 제거
        delete mergedRow.recommended_reorder_qty;
        delete mergedRow.final_reorder_qty;
        
        console.log(`[Save Debug] recommended_reorder_qty와 final_reorder_qty 재계산을 위해 기존 값 제거`);
      }

      // confirmed_moq 변경 감지 및 로깅 (새로 추가)
      const originalConfirmedMoq = parseInt(originalRow.confirmed_moq || 500);
      const newConfirmedMoq = parseInt(change.confirmed_moq !== undefined ? change.confirmed_moq : originalConfirmedMoq);
      
      if (originalConfirmedMoq !== newConfirmedMoq && change.confirmed_moq !== undefined) {
        console.log(`[Save Debug] MOQ 변경 감지: ${originalConfirmedMoq} -> ${newConfirmedMoq}`);
        
        // confirmed_moq 변경 시 final_reorder_qty 재계산을 위해 기존 값 제거
        delete mergedRow.final_reorder_qty;
        
        console.log(`[Save Debug] final_reorder_qty 재계산을 위해 기존 값 제거`);
      }

      // expectedSalesPeriod 변경 감지 및 로깅 (새로 추가)
      const originalExpectedSalesPeriod = parseInt(originalRow.expectedSalesPeriod || 6);
      const newExpectedSalesPeriod = parseInt(change.expectedSalesPeriod !== undefined ? change.expectedSalesPeriod : originalExpectedSalesPeriod);
      
      if (originalExpectedSalesPeriod !== newExpectedSalesPeriod && change.expectedSalesPeriod !== undefined) {
        console.log(`[Save Debug] 예상 판매기간 변경 감지: ${originalExpectedSalesPeriod}개월 -> ${newExpectedSalesPeriod}개월`);
        
        // expectedSalesPeriod 변경 시 totalExpectedSalesQty -> recommended_reorder_qty, final_reorder_qty 재계산을 위해 기존 값 제거
        delete mergedRow.recommended_reorder_qty;
        delete mergedRow.final_reorder_qty;
        
        console.log(`[Save Debug] recommended_reorder_qty와 final_reorder_qty 재계산을 위해 기존 값 제거`);
      }

      let recalculatedRow = null;
      try {
          // 수정된 recalculateDependentFields 함수 호출
          // mergedRow에는 사용자가 수정한 recommended_reorder_qty (만약 수정했다면)가 포함되어 전달됨
          recalculatedRow = recalculateDependentFields(mergedRow);
      } catch (error) {
          console.error(`[Save Error] 재계산 오류(${pk}):`, error);
          processingErrorOccurred = true;
          return; // 다음 변경사항으로 넘어가지 않고 현재 루프 중단
      }

      if (recalculatedRow && typeof recalculatedRow === 'object') {
          currentDataMap.set(pk, recalculatedRow);
          console.log(`[Save Debug] 행 업데이트 성공: groupId=${pk}`);
      } else {
          console.error(`[Save Error] 재계산 결과 유효하지 않음(${pk}):`, recalculatedRow);
          processingErrorOccurred = true;
          currentDataMap.set(pk, originalRow); // 오류 발생 시 원본 행으로 복원 (또는 mergedRow로 유지할지 결정 필요)
      }
  } else {
      console.warn(`[Save Warn] groupId=${pk}에 대한 원본 행을 찾을 수 없음`);
  }
});
console.log("[Save Debug] Finished changes processing loop.");

if (processingErrorOccurred) {
  console.error("[Save Error] 처리 중 오류가 발생했습니다.");
  // 필요하다면 사용자에게 알림
  // return; // 전체 저장 프로세스를 중단할지 여부 결정
}

// 4. Map을 다시 배열로 변환
const finalMapSize = currentDataMap.size;
// 데이터 손실 체크 (생략 가능)
if (initialMapSize > finalMapSize) {
    console.warn(`[Save Warn] 데이터 손실 가능성: 초기 Map 크기 ${initialMapSize}, 최종 Map 크기 ${finalMapSize}`);
}
const finalUpdatedArray = Array.from(currentDataMap.values());
const finalArrayLength = finalUpdatedArray.length;
console.log(`[Save Debug] Final updated array length: ${finalArrayLength}`);

// 5. Temporary State 업데이트
if (finalArrayLength === 0 && initialDataLength > 0 && !processingErrorOccurred) {
    // 모든 데이터가 사라졌지만 처리 오류는 없는 경우 (예: 모든 행이 어떤 조건에 의해 필터링된 경우 - 현재 로직에서는 드묾)
    console.warn("[Save Warn] 최종 데이터 배열이 비어있습니다. 초기 데이터는 존재했습니다.");
    // editableReviewedList.setValue([]); // 비우거나, 사용자에게 알림
    // utils.showNotification({ title: "Warning", description: "All items were removed or became invalid after changes.", notificationType: "warning" });
} else if (!processingErrorOccurred || finalArrayLength > 0) { // 처리 오류가 없었거나, 오류가 있었더라도 일부 데이터가 남은 경우
    editableReviewedList.setValue(finalUpdatedArray);
    console.log("[Save Debug] editableReviewedList state updated.");
    // State 업데이트 후 확인 로그 (선택 사항)
    // console.log("[Save Debug] State after update:", JSON.stringify(editableReviewedList.value, null, 2));
} else {
    console.error("[Save Error] 최종 데이터 배열이 비어있고 처리 중 오류가 발생하여 State를 업데이트하지 않습니다.");
    // utils.showNotification({ title: "Error", description: "Failed to save changes due to processing errors. Data not updated.", notificationType: "error" });
}


// 6. 테이블 변경사항 표시 초기화
console.log("[Save Debug] Clearing changeset from table_reorder_targets2.");
table_reorder_targets2.clearChangeset();

// 7. 요약 정보 재계산 및 업데이트
if (!(finalArrayLength === 0 && initialDataLength > 0 && processingErrorOccurred)) { // 심각한 오류로 데이터가 모두 사라진 경우가 아니라면 요약 업데이트
  // (요약 계산 로직은 이전과 동일, finalUpdatedArray 사용)
  
  // 총 리오더 수량 계산
  const totalReorderQty = finalUpdatedArray.reduce(
    (sum, item) => sum + (parseInt(item.final_reorder_qty) || 0), 0 // parseInt 추가하여 안전성 확보
  );
  
  // 총 비용 계산
  const totalCost = finalUpdatedArray.reduce(
    (sum, item) => sum + ((parseInt(item.final_reorder_qty) || 0) * (parseFloat(item.modifiableCostPrice) || 0)), 0 // 타입 변환 추가
  );
  
  // 평균 판매율 계산
  const totalEstimatedFinalSaleRate = finalUpdatedArray.reduce((sum, item) => sum + (parseFloat(item.estimatedFinalSaleRate) || 0), 0);
  const avgEstimatedFinalSaleRate = finalUpdatedArray.length > 0 ? totalEstimatedFinalSaleRate / finalUpdatedArray.length : 0;
  
  const summaryText = `총 ${finalUpdatedArray.length}개 항목 선택됨 | 총 리오더 수량: ${totalReorderQty.toLocaleString()} | 예상 비용: ${totalCost.toLocaleString()}원 | 예상 평균 판매율: ${(avgEstimatedFinalSaleRate * 100).toFixed(1)}%`;
  
  // 요약 정보 상태 업데이트 (Retool의 Text 컴포넌트나 State에 할당)
  // 예: textSummary.setValue(summaryText); 또는 stateSummary.setValue({count: finalUpdatedArray.length, totalQty: totalReorderQty, totalCost: totalCost, avgSaleRate: avgEstimatedFinalSaleRate });
  console.log(`[Save Debug] Summary: ${summaryText}`);
  
} else {
  console.warn("[Save Warn] 요약 정보를 업데이트하지 않습니다 (오류 또는 데이터 없음).");
  // textSummary.setValue("요약 정보를 계산할 수 없습니다.");
}

// 8. 저장 완료 알림
if (!processingErrorOccurred) {
    // utils.showNotification({ title: "Success", description: "Changes saved and calculations updated successfully!", notificationType: "success" });
    console.log("[Save Debug] 저장 및 재계산 완료 알림 (가상).");
} else {
    // utils.showNotification({ title: "Partial Error", description: "Some changes were saved, but errors occurred during processing. Please review the data.", notificationType: "warning" });
    console.log("[Save Debug] 일부 오류와 함께 저장 및 재계산 완료 알림 (가상).");
}

console.log("--- [Save Debug] Save script finished (Direct Array Mode) ---");