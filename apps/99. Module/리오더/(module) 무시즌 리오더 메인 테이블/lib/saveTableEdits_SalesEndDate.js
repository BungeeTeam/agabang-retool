// Query Name: saveTableEdits_SalesEndDate
// Trigger: table_main_list의 "Save" 버튼 Click 이벤트 핸들러
// 컬러 및 사이즈 테이블 모두 업데이트

// --- Helper Functions ---
function calculateDaysDifference(startDate, endDate) {
  if (!startDate || !endDate) return 90;
  const start = new Date(startDate);
  const end = new Date(endDate);
  if (isNaN(start.getTime()) || isNaN(end.getTime())) return 90;
  return Math.floor((end - start) / (1000 * 60 * 60 * 24)) + 1;
}

function recalculateOnSalesEndDateChange(row) {
  console.log("--------------------------------------------------");
  console.log(`[Recalc] Processing row: ${row.groupId}`);
  console.log("[Recalc] Sales End Date:", row.sales_end_date);
  console.log("[Recalc] Reference Date:", row.reference_date);
  
  let updatedRow = { ...row };

  // 기본 값들 파싱
  const reference_date = updatedRow.reference_date || new Date().toISOString().split('T')[0];
  const sales_end_date = updatedRow.sales_end_date;
  const current_stock_qty = parseFloat(updatedRow.current_stock_qty || 0);
  const lead_time_days = parseInt(updatedRow.lead_time_days || 60);
  const target_sale_rate = parseFloat(updatedRow.target_sale_rate || 1.0);
  
  // 판매량 데이터 선택
  const avg_daily_sales_d180 = parseFloat(updatedRow.avg_daily_sales_d180 || 0);
  const avg_daily_sales_d365 = parseFloat(updatedRow.avg_daily_sales_d365 || 0);
  const avg_daily_sales_d30 = parseFloat(updatedRow.avg_daily_sales_d30 || 0);
  const avg_daily_sales = parseFloat(updatedRow.avg_daily_sales || 0);
  
  // 유효한 일 평균 판매량 선택
  const effective_daily_sales = avg_daily_sales_d180 > 0 ? avg_daily_sales_d180 :
                                avg_daily_sales_d365 > 0 ? avg_daily_sales_d365 :
                                avg_daily_sales_d30 > 0 ? avg_daily_sales_d30 :
                                avg_daily_sales;

  // 월 평균 판매량
  const effective_monthly_sales = effective_daily_sales * 30;

  // 1. 예상 판매기간 재계산
  const new_expected_sales_period = calculateDaysDifference(reference_date, sales_end_date);
  updatedRow.expected_sales_period = new_expected_sales_period;
  console.log(`  1. Expected Sales Period: ${new_expected_sales_period} days`);

  // 2. 전체 기간 예상 판매량 재계산
  const new_expected_sales_full_period = effective_daily_sales * new_expected_sales_period;
  updatedRow.expected_sales_full_period = new_expected_sales_full_period;
  console.log(`  2. Expected Sales Full Period: ${new_expected_sales_full_period}`);

  // 3. 리드타임 동안 예상 판매량
  const expected_sales_during_lead_time = effective_daily_sales * lead_time_days;
  updatedRow.expected_sales_during_lead_time = expected_sales_during_lead_time;
  console.log(`  3. Expected Sales During Lead Time: ${expected_sales_during_lead_time}`);

  // 4. 부족 수량 재계산
  const new_shortage_qty = Math.max(0, new_expected_sales_full_period - current_stock_qty);
  updatedRow.shortage_qty = new_shortage_qty;
  console.log(`  4. Shortage Qty: ${new_shortage_qty}`);

  // 5. 추천 리오더 수량 재계산
  const new_recommended_reorder_qty = new_shortage_qty > 0 ? new_shortage_qty / target_sale_rate : 0;
  updatedRow.recommended_reorder_qty = new_recommended_reorder_qty;
  console.log(`  5. Recommended Reorder Qty: ${new_recommended_reorder_qty}`);

  // 6. 최종 리오더 수량 재계산 (10단위 올림)
  const new_final_reorder_qty = Math.ceil(new_recommended_reorder_qty / 10) * 10;
  updatedRow.final_reorder_qty = new_final_reorder_qty;
  console.log(`  6. Final Reorder Qty: ${new_final_reorder_qty}`);

  // 7. 예상 재고 재계산
  const new_estimated_stock = Math.max(0, current_stock_qty - expected_sales_during_lead_time);
  updatedRow.estimated_stock = new_estimated_stock;
  console.log(`  7. Estimated Stock: ${new_estimated_stock}`);

  // 8. 리드타임 관련 필드들도 업데이트
  const lead_time_shortage = Math.max(0, expected_sales_during_lead_time - current_stock_qty);
  updatedRow.lead_time_shortage_qty = lead_time_shortage;
  updatedRow.lead_time_recommended_reorder_qty = lead_time_shortage > 0 ? lead_time_shortage / target_sale_rate : 0;
  updatedRow.lead_time_final_reorder_qty = Math.ceil(updatedRow.lead_time_recommended_reorder_qty / 10) * 10;

  // 9. 효과적인 월 판매량 업데이트
  updatedRow.effective_monthly_sales = effective_monthly_sales;

  console.log("[Recalc] Recalculation completed");
  console.log("--------------------------------------------------");
  
  return updatedRow;
}

// 사이즈별 재계산 함수
function recalculateSizeRow(sizeRow, headerData) {
  let updatedSizeRow = { ...sizeRow };
  
  // 헤더의 sales_end_date와 expected_sales_period 적용
  updatedSizeRow.sales_end_date = headerData.sales_end_date;
  updatedSizeRow.expected_sales_period = headerData.expected_sales_period;
  
  // 사이즈별 판매량 데이터
  const size_daily_sales = parseFloat(sizeRow.avg_daily_sales_d180 || 0) ||
                          parseFloat(sizeRow.avg_daily_sales_d365 || 0) ||
                          parseFloat(sizeRow.avg_daily_sales_d30 || 0) ||
                          parseFloat(sizeRow.avg_daily_sales || 0);
  
  const size_current_stock = parseFloat(sizeRow.current_stock_qty || 0);
  const lead_time_days = parseInt(headerData.lead_time_days || 60);
  const target_sale_rate = parseFloat(headerData.target_sale_rate || 1.0);
  
  // 사이즈별 예상 판매량 재계산
  const size_expected_sales_full_period = size_daily_sales * headerData.expected_sales_period;
  updatedSizeRow.expected_sales_full_period = size_expected_sales_full_period;
  
  // 사이즈별 부족 수량 재계산
  const size_shortage_qty = Math.max(0, size_expected_sales_full_period - size_current_stock);
  updatedSizeRow.shortage_qty = size_shortage_qty;
  
  // 사이즈별 추천 리오더 수량
  const size_recommended_reorder_qty = size_shortage_qty > 0 ? size_shortage_qty / target_sale_rate : 0;
  updatedSizeRow.recommended_reorder_qty = size_recommended_reorder_qty;
  
  // 컬러 총 리오더 수량에서 사이즈 비율 계산 (필요시)
  // 이 부분은 getSelectedItems 로직을 참고하여 구현
  
  console.log(`  [Size Recalc] ${sizeRow.size_nm}: shortage=${size_shortage_qty.toFixed(0)}, recommended=${size_recommended_reorder_qty.toFixed(0)}`);
  
  return updatedSizeRow;
}

// --- Main Save Logic ---
console.log("=== [Save] Sales End Date Save Process Started ===");

// 1. 현재 tempTableData의 데이터 가져오기
const currentData = tempTableData.value || [];
const initialDataLength = currentData.length;

if (initialDataLength === 0) {
  console.error("[Save Error] No data in tempTableData");
  utils.showNotification({
    title: "오류",
    description: "테이블에 데이터가 없습니다.",
    notificationType: "error"
  });
  return;
}

console.log(`[Save] Initial data length: ${initialDataLength}`);

// 헤더와 사이즈 행 구분
const headerRows = currentData.filter(row => row._type === 'header');
const sizeRows = currentData.filter(row => row._type === 'size');
console.log(`[Save] Header rows: ${headerRows.length}, Size rows: ${sizeRows.length}`);

// 2. 변경사항 가져오기
const changesArray = table_main_list.changesetArray;
if (!changesArray || changesArray.length === 0) {
  utils.showNotification({
    title: "알림",
    description: "변경된 내용이 없습니다.",
    notificationType: "info"
  });
  return;
}

console.log(`[Save] Found ${changesArray.length} changes`);
console.log("[Save] Changes:", JSON.stringify(changesArray, null, 2));

// 3. 현재 데이터를 Map으로 변환 (groupId를 key로 사용)
const dataMap = new Map();
currentData.forEach(row => {
  if (row.groupId) {
    // 헤더 행은 groupId로, 사이즈 행은 groupId + size_cd로 저장
    const key = row._type === 'size' && row.size_cd 
      ? `${row.groupId}_${row.size_cd}` 
      : row.groupId;
    dataMap.set(key, { ...row });
  }
});

console.log(`[Save] Data map size: ${dataMap.size}`);

// 4. 모든 변경사항 처리
let processedCount = 0;
let recalculatedCount = 0;
let errorCount = 0;
const affectedGroupIds = new Set(); // 영향받은 groupId들 저장

changesArray.forEach((change, index) => {
  try {
    // groupId 확인
    const groupId = change.groupId;
    if (!groupId) {
      console.error(`[Save Error] No groupId in change ${index + 1}`);
      errorCount++;
      return;
    }
    
    console.log(`[Save] Processing change ${index + 1}: ${groupId}`);
    
    // 헤더 행 찾기
    const headerRow = dataMap.get(groupId);
    
    if (!headerRow || headerRow._type !== 'header') {
      console.warn(`[Save Warn] Header row not found for groupId: ${groupId}`);
      errorCount++;
      return;
    }
    
    // 변경사항 병합
    let updatedHeaderRow = { ...headerRow, ...change };
    console.log(`[Save] Merged changes for ${groupId}`);
    
    // sales_end_date가 변경된 경우 재계산
    if (change.hasOwnProperty('sales_end_date')) {
      console.log(`[Save] Sales end date changed for ${groupId}: ${headerRow.sales_end_date} -> ${change.sales_end_date}`);
      updatedHeaderRow = recalculateOnSalesEndDateChange(updatedHeaderRow);
      recalculatedCount++;
      affectedGroupIds.add(groupId);
      
      // 해당 그룹의 모든 사이즈 행들도 재계산
      console.log(`[Save] Updating size rows for group ${groupId}...`);
      let sizeCount = 0;
      
      currentData.forEach(row => {
        if (row._type === 'size' && row.groupId === groupId) {
          const sizeKey = `${row.groupId}_${row.size_cd}`;
          const sizeRow = dataMap.get(sizeKey);
          if (sizeRow) {
            // 사이즈 행 재계산
            const updatedSizeRow = recalculateSizeRow(sizeRow, updatedHeaderRow);
            dataMap.set(sizeKey, updatedSizeRow);
            sizeCount++;
          }
        }
      });
      
      console.log(`[Save] Updated ${sizeCount} size rows for group ${groupId}`);
    }
    
    // 업데이트된 헤더 row를 Map에 저장
    dataMap.set(groupId, updatedHeaderRow);
    processedCount++;
    
  } catch (error) {
    console.error(`[Save Error] Failed to process change ${index + 1}:`, error);
    errorCount++;
  }
});

console.log(`[Save] Processing complete. Processed: ${processedCount}, Recalculated: ${recalculatedCount}, Errors: ${errorCount}`);

// 5. Map을 다시 배열로 변환 (원래 순서 유지)
const updatedData = currentData.map(originalRow => {
  const key = originalRow._type === 'size' && originalRow.size_cd 
    ? `${originalRow.groupId}_${originalRow.size_cd}` 
    : originalRow.groupId;
  return dataMap.get(key) || originalRow;
});

const finalDataLength = updatedData.length;
console.log(`[Save] Final data length: ${finalDataLength}`);

// 데이터 손실 체크
if (finalDataLength !== initialDataLength) {
  console.error(`[Save Error] Data length mismatch! Initial: ${initialDataLength}, Final: ${finalDataLength}`);
}

// 6. tempTableData 업데이트
console.log("[Save] Updating tempTableData...");
tempTableData.setValue(updatedData);

// 7. 테이블 변경사항 초기화
table_main_list.clearChangeset();
console.log("[Save] Table changeset cleared");

// 8. 선택된 리오더 항목 업데이트 (있는 경우)
if (typeof selectedReorderItems !== 'undefined' && 
    selectedReorderItems.value && 
    selectedReorderItems.value.length > 0 &&
    affectedGroupIds.size > 0) {
  
  console.log("[Save] Checking selected reorder items for updates...");
  
  // 영향받은 groupId를 가진 선택된 항목이 있는지 확인
  const hasAffectedItems = selectedReorderItems.value.some(item => 
    affectedGroupIds.has(item.groupId)
  );
  
  if (hasAffectedItems && typeof getSelectedItems !== 'undefined') {
    await getSelectedItems.trigger();
    console.log(`[Save] Triggered getSelectedItems update`);
  }
}

console.log("=== [Save] Sales End Date Save Process Completed ===");

// 결과 반환
return {
  success: true,
  processedCount: processedCount,
  recalculatedCount: recalculatedCount,
  errorCount: errorCount,
  updatedData: updatedData,
  affectedGroupIds: Array.from(affectedGroupIds)
};