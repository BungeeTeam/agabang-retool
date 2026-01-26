// saveSizeEdits.js - 부족수량 계산 최종 수정 버전

// --- Main Logic for Save Button ---
console.log("--- [Size Save] 사이즈 데이터 업데이트 시작 ---");

const initialSizeItems = selectedReorderItems.value || [];
if (initialSizeItems.length === 0) {
  console.error("[Size Save] selectedReorderItems.value에 데이터가 없습니다.");
  return;
}

// 1. 변경사항 가져오기
const changesArray = table_size_details.changesetArray || [];
if (changesArray.length === 0) {
  console.log("[Size Save] 변경된 사항이 없습니다.");
  return;
}
console.log(`[Size Save] ${changesArray.length}개 변경사항 감지`);
console.log("[Size Save] 변경사항 내용:", JSON.stringify(changesArray));

// 2. [수정] 변경사항을 size_id를 키(key)로 하는 맵(Map)으로 변환
// 이렇게 하면 행 인덱스에 의존하지 않고 고유 ID로 바로 찾을 수 있습니다.
const changesMap = new Map();
changesArray.forEach(change => {
  // changesetArray의 각 항목에서 size_id 또는 고유 키를 생성합니다.
  const sizeKey = change.size_id || 
                  (change.sty_cd && change.col_cd && change.size_cd ? 
                   `${change.sty_cd}_${change.col_cd}_${change.size_cd}` : null);
  
  if (sizeKey) {
    // 맵에 { sizeKey: 변경내용 } 형태로 저장합니다.
    changesMap.set(sizeKey, change);
    console.log(`[Size Save] 변경사항 맵에 추가: ${sizeKey}`);
  }
});

if (changesMap.size === 0) {
    console.log("[Size Save] 처리할 유효한 변경사항이 없습니다.");
    return;
}

// 3. [수정] 데이터 업데이트: size_id를 기준으로 직접 조회하여 업데이트
let updatedItems = 0;
const updatedSizeItems = initialSizeItems.map((colorItem) => {
  if (!Array.isArray(colorItem.size_reorder_info) || colorItem.size_reorder_info.length === 0) {
    return colorItem;
  }
  
  const updatedColorItem = { ...colorItem };
  
  updatedColorItem.size_reorder_info = colorItem.size_reorder_info.map((sizeItem) => {
    // 원본 데이터의 각 사이즈에 대한 고유 ID 생성
    const sizeId = sizeItem.size_id || 
                   `${colorItem.sty_cd}_${colorItem.col_cd}_${sizeItem.size_cd}`;
    
    // 이 sizeId가 변경사항 맵에 있는지 직접 확인합니다.
    if (changesMap.has(sizeId)) {
      const change = changesMap.get(sizeId); // 해당 사이즈의 변경내용을 직접 가져옵니다.
      updatedItems++;
      
      const updatedSizeItem = { ...sizeItem };
      
      let growthRateChanged = false;
      let newGrowthRate = sizeItem.growth_rate || 100;
      
      // `change` 객체에서 직접 필드에 접근합니다.
      if (change.growth_rate !== undefined) {
        newGrowthRate = parseInt(change.growth_rate, 10) || 100;
        growthRateChanged = newGrowthRate !== sizeItem.growth_rate;
        updatedSizeItem.growth_rate = newGrowthRate;
        console.log(`[Size Save] ${sizeId} - growth_rate 업데이트: ${sizeItem.growth_rate} → ${updatedSizeItem.growth_rate}`);
      }
      
      if (change.reorder_qty !== undefined) {
        updatedSizeItem.reorder_qty = parseInt(change.reorder_qty, 10) || 0;
        console.log(`[Size Save] ${sizeId} - reorder_qty 업데이트: ${sizeItem.reorder_qty} → ${updatedSizeItem.reorder_qty}`);
      }
      
      if (growthRateChanged) {
        const originalExpectedSales = parseInt(sizeItem.expected_sales, 10) || 0;
        const originalGrowthRate = sizeItem.growth_rate || 100;
        const newExpectedSales = Math.round(originalExpectedSales * (newGrowthRate / originalGrowthRate));
        
        updatedSizeItem.expected_sales = newExpectedSales;
        updatedSizeItem.expected_sales_full_period = newExpectedSales;
        
        const currentStock = parseInt(sizeItem.total_stock, 10) || 0;
        const newShortageQty = Math.max(0, newExpectedSales - currentStock);
        updatedSizeItem.shortage_qty = newShortageQty;
        
        console.log(`[Size Save] ${sizeId} - expected_sales 재계산: ${sizeItem.expected_sales} → ${newExpectedSales}`);
        console.log(`[Size Save] ${sizeId} - shortage_qty 재계산: ${sizeItem.shortage_qty} → ${newShortageQty}`);
      }
      
      return updatedSizeItem;
    }
    
    return sizeItem; // 변경사항 없으면 원본 반환
  });
  
  return updatedColorItem;
});


// 4. 데이터 업데이트 (이후 로직은 기존과 동일)
if (updatedItems > 0) {
  console.log(`[Size Save] ${updatedItems}개 사이즈 항목 업데이트 완료`);
  selectedReorderItems.setValue(updatedSizeItems);
  console.log("[Size Save] selectedReorderItems 업데이트 완료");
} else {
  console.log("[Size Save] 업데이트된 항목이 없습니다.");
}

// 5. 변경사항 초기화
if (typeof table_size_details.clearChangeset === 'function') {
  table_size_details.clearChangeset();
  console.log("[Size Save] 변경사항 초기화 완료");
}

console.log("--- [Size Save] 사이즈 데이터 업데이트 완료 ---");

return {
  success: true,
  updatedItems: updatedItems,
  totalItems: initialSizeItems.reduce((count, item) => 
    count + (Array.isArray(item.size_reorder_info) ? item.size_reorder_info.length : 0), 0)
};
//  // saveSizeEdits.js - 부족수량 계산 수정 버전

//  // --- Main Logic for Save Button ---
//  console.log("--- [Size Save] 사이즈 데이터 업데이트 시작 ---");

//  // 초기 데이터 확인
//  const initialSizeItems = selectedReorderItems.value || [];
//  const initialDataLength = initialSizeItems.length;
//  console.log(`[Size Save] 초기 사이즈 데이터 길이: ${initialDataLength}`);

//  if (initialDataLength === 0) {
//    console.error("[Size Save] selectedReorderItems.value에 데이터가 없습니다.");
//    return;
//  }

//  // 1. 변경사항 가져오기
//  const changesArray = table_size_details.changesetArray || [];
//  const tableData = table_size_details.data || [];

//  if (changesArray.length === 0) {
//    console.log("[Size Save] 변경된 사항이 없습니다.");
//    return;
//  }

//  console.log(`[Size Save] ${changesArray.length}개 변경사항 감지`);
//  console.log("[Size Save] 변경사항 내용:", JSON.stringify(changesArray));

//  // 선택된 행 식별
//  let selectedRow = null;
//  if (table_size_details.selectedRow) {
//    selectedRow = table_size_details.selectedRow;
//    console.log(`[Size Save] 선택된 행: ${JSON.stringify(selectedRow)}`);
//  }

//  // 2. 변경사항 수집
//  const actualChanges = changesArray.map((change, idx) => ({
//    rowIndex: idx,
//    size_id: change.size_id || null,
//    size_key: change.size_key || null,
//    fields: { ...change }
//  }));

//  console.log(`[Size Save] 처리할 실제 변경사항: ${actualChanges.length}개`);
//  console.log("[Size Save] 실제 변경사항:", JSON.stringify(actualChanges));

//  // 3. 데이터 구조 탐색 및 사이즈별 맵 생성
//  let updatedItems = 0;

//  // 테이블 데이터에서 행 인덱스와 size_id 또는 키 매핑 생성
//  const tableRowToSizeMap = new Map();
//  tableData.forEach((row, index) => {
//    const sizeKey = row.size_id || 
//                    (row.sty_cd && row.col_cd && row.size_cd ? 
//                     `${row.sty_cd}_${row.col_cd}_${row.size_cd}` : null);
  
//    if (sizeKey) {
//      tableRowToSizeMap.set(index, sizeKey);
//      console.log(`[Size Save] 테이블 행 ${index}와 size_id ${sizeKey} 매핑`);
//    }
//  });

//  // 변경된 행의 size_id 찾기
//  const changeRowIndices = actualChanges.map(c => c.rowIndex);
//  const targetSizeIds = new Set(
//    changeRowIndices
//      .map(idx => tableRowToSizeMap.get(idx))
//      .filter(id => id) // undefined/null 제거
//  );

//  console.log(`[Size Save] 변경 대상 size_id: ${Array.from(targetSizeIds).join(', ')}`);

//  // 실제 데이터 업데이트
//  const updatedSizeItems = initialSizeItems.map((colorItem) => {
//    // size_reorder_info 배열이 없으면 항목 그대로 반환
//    if (!Array.isArray(colorItem.size_reorder_info) || colorItem.size_reorder_info.length === 0) {
//      return colorItem;
//    }
  
//    // colorItem의 복사본 생성
//    const updatedColorItem = { ...colorItem };
  
//    // 공통 값 추출 (예상 판매량 계산에 필요한 값들)
//    const daysUntilSalesEnd = colorItem.expected_sales_period || 92; // 기본값 92
//    const shopCount = colorItem.active_shop_count || 383; // 기본값 383
//    const shopDailySales = 0.03; // 샘플 데이터 기준 기본값
  
//    // size_reorder_info 배열 복사 및 업데이트
//    updatedColorItem.size_reorder_info = colorItem.size_reorder_info.map((sizeItem, sizeIdx) => {
//      // 식별자 생성
//      const sizeId = sizeItem.size_id || 
//                     `${colorItem.sty_cd}_${colorItem.col_cd}_${sizeItem.size_cd}`;
    
//      // 이 행이 변경 대상인지 확인
//      const isTargetSize = targetSizeIds.has(sizeId);
    
//      // 변경 대상이 아니면 원본 반환
//      if (!isTargetSize) {
//        return sizeItem;
//      }
    
//      // 이 사이즈 항목에 대한 변경사항 찾기
//      const change = actualChanges.find(c => {
//        const rowSizeId = tableRowToSizeMap.get(c.rowIndex);
//        return rowSizeId === sizeId;
//      });
    
//      // 변경사항이 있으면 적용
//      if (change && change.fields) {
//        updatedItems++;
      
//        // 필드 업데이트를 위한 새 객체 생성
//        const updatedSizeItem = { ...sizeItem };
      
//        // growth_rate 업데이트
//        let growthRateChanged = false;
//        let newGrowthRate = sizeItem.growth_rate || 100;
      
//        if (change.fields.growth_rate !== undefined) {
//          newGrowthRate = parseInt(change.fields.growth_rate) || 100;
//          growthRateChanged = newGrowthRate !== sizeItem.growth_rate;
//          updatedSizeItem.growth_rate = newGrowthRate;
//          console.log(`[Size Save] ${sizeId} - growth_rate 업데이트: ${sizeItem.growth_rate} → ${updatedSizeItem.growth_rate}`);
//        }
      
//        // reorder_qty 업데이트
//        if (change.fields.reorder_qty !== undefined) {
//          updatedSizeItem.reorder_qty = parseInt(change.fields.reorder_qty) || 0;
//          console.log(`[Size Save] ${sizeId} - reorder_qty 업데이트: ${sizeItem.reorder_qty} → ${updatedSizeItem.reorder_qty}`);
//        }
      
//        // growth_rate가 변경되었으면 expected_sales 재계산
//        if (growthRateChanged) {
//          // 사이즈 비율 계산 (기본값 1)
//          const sizeRatio = sizeItem.size_distribution_ratio || 1;
        
//          // 성장율을 백분율로 변환 (100 -> 1.0)
//          const growthRateFactor = newGrowthRate / 100;
        
//          // 예상 판매량 계산
//          // 원래 예상 판매량에서 성장율만 조정 (정확한 비율 유지)
//          const originalExpectedSales = parseInt(sizeItem.expected_sales) || 0;
//          const originalGrowthRate = sizeItem.growth_rate || 100;
//          const newExpectedSales = Math.round(originalExpectedSales * (newGrowthRate / originalGrowthRate));
        
//          // 예상 판매량 업데이트
//          updatedSizeItem.expected_sales = newExpectedSales;
//          updatedSizeItem.expected_sales_full_period = newExpectedSales;
        
//          // 현재 재고량 가져오기 (테이블에서)
//          let currentStock = parseInt(sizeItem.total_stock) || 0;
        
//          // 테이블 행 데이터에서도 확인
//          const tableRow = tableData.find(row => row.size_id === sizeId);
//          if (tableRow && tableRow.total_stock !== undefined) {
//            currentStock = parseInt(tableRow.total_stock) || 0;
//          }
        
//          console.log(`[Size Save] ${sizeId} - 현재 재고량: ${currentStock}`);
        
//          // 부족 수량 계산 (예상 판매량 - 현재 재고량)
//          // 음수가 되지 않도록 Math.max() 사용
//          const newShortageQty = Math.max(0, newExpectedSales - currentStock);
//          updatedSizeItem.shortage_qty = newShortageQty;
        
//          console.log(`[Size Save] ${sizeId} - expected_sales 재계산: ${sizeItem.expected_sales} → ${newExpectedSales}`);
//          console.log(`[Size Save] ${sizeId} - shortage_qty 재계산: ${sizeItem.shortage_qty} → ${newShortageQty}`);
//        }
      
//        // 업데이트된 아이템 반환
//        return updatedSizeItem;
//      }
    
//      // 변경사항이 없으면 원본 반환
//      return sizeItem;
//    });
  
//    return updatedColorItem;
//  });

//  // 4. 데이터 업데이트
//  if (updatedItems > 0) {
//    console.log(`[Size Save] ${updatedItems}개 사이즈 항목 업데이트 완료`);
  
//    // 중요: selectedReorderItems 업데이트 - 이 부분이 핵심
//    selectedReorderItems.setValue(updatedSizeItems);
//    console.log("[Size Save] selectedReorderItems 업데이트 완료");
//  } else {
//    console.log("[Size Save] 업데이트된 항목이 없습니다.");
//  }

//  // 5. 변경사항 초기화
//  if (typeof table_size_details.clearChangeset === 'function') {
//    table_size_details.clearChangeset();
//    console.log("[Size Save] 변경사항 초기화 완료");
//  }

//  console.log("--- [Size Save] 사이즈 데이터 업데이트 완료 ---");

//  // 결과 반환
//  return {
//    success: true,
//    updatedItems: updatedItems,
//    totalItems: initialSizeItems.reduce((count, item) => 
//      count + (Array.isArray(item.size_reorder_info) ? item.size_reorder_info.length : 0), 0)
//  };