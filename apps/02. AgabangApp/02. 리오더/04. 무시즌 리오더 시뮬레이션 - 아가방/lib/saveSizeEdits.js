// saveSizeEdits.js - 행 인덱스 매핑 수정 버전

// --- Main Logic for Save Button ---
console.log("--- [Size Save] 사이즈 데이터 업데이트 시작 ---");

// 초기 데이터 확인
const initialSizeItems = selectedReorderItems.value || [];
const initialDataLength = initialSizeItems.length;
console.log(`[Size Save] 초기 사이즈 데이터 길이: ${initialDataLength}`);

if (initialDataLength === 0) {
  console.error("[Size Save] selectedReorderItems.value에 데이터가 없습니다.");
  return;
}

// 1. 변경사항 가져오기
const changesArray = table_size_details.changesetArray || [];
const tableData = table_size_details.data || [];

if (changesArray.length === 0) {
  console.log("[Size Save] 변경된 사항이 없습니다.");
  return;
}

console.log(`[Size Save] ${changesArray.length}개 변경사항 감지`);
console.log("[Size Save] changesetArray 구조:", JSON.stringify(changesArray));

// 선택된 행 식별
let selectedRow = null;
if (table_size_details.selectedRow) {
  selectedRow = table_size_details.selectedRow;
  console.log(`[Size Save] 선택된 행: ${JSON.stringify(selectedRow)}`);
}

// 2. 변경사항 수집 - 올바른 행 인덱스 추출
const actualChanges = changesArray.map((change, changeIdx) => {
  // Retool changesetArray의 구조에 따라 실제 테이블 행 인덱스 추출
  let actualRowIndex = changeIdx; // 기본값
  
  // 방법 1: changeset에 직접 인덱스 정보가 있는 경우
  if (change.index !== undefined) {
    actualRowIndex = change.index;
  }
  // 방법 2: changeset에 __retoolTableRowIndex가 있는 경우
  else if (change.__retoolTableRowIndex !== undefined) {
    actualRowIndex = change.__retoolTableRowIndex;
  }
  // 방법 3: 원본 데이터와 비교하여 인덱스 찾기
  else {
    // size_id로 실제 행 인덱스 찾기
    const targetSizeId = change.size_id;
    if (targetSizeId) {
      const foundIndex = tableData.findIndex(row => row.size_id === targetSizeId);
      if (foundIndex !== -1) {
        actualRowIndex = foundIndex;
      }
    }
    // size_id가 없으면 sty_cd + col_cd + size_cd 조합으로 찾기
    else if (change.sty_cd && change.col_cd && change.size_cd) {
      const foundIndex = tableData.findIndex(row => 
        row.sty_cd === change.sty_cd && 
        row.col_cd === change.col_cd && 
        row.size_cd === change.size_cd
      );
      if (foundIndex !== -1) {
        actualRowIndex = foundIndex;
      }
    }
  }
  
  console.log(`[Size Save] 변경사항 ${changeIdx}: 실제 행 인덱스 ${actualRowIndex}`);
  
  return {
    changeIndex: changeIdx,
    actualRowIndex: actualRowIndex,
    size_id: change.size_id || null,
    size_key: change.size_key || null,
    fields: { ...change }
  };
});

console.log(`[Size Save] 처리할 실제 변경사항: ${actualChanges.length}개`);
console.log("[Size Save] 실제 변경사항 매핑:", JSON.stringify(actualChanges));

// 3. 데이터 구조 탐색 및 사이즈별 맵 생성
let updatedItems = 0;

// 테이블 데이터에서 실제 행 인덱스와 size_id 매핑 생성
const tableRowToSizeMap = new Map();
tableData.forEach((row, index) => {
  const sizeKey = row.size_id || 
                  (row.sty_cd && row.col_cd && row.size_cd ? 
                   `${row.sty_cd}_${row.col_cd}_${row.size_cd}` : null);
  
  if (sizeKey) {
    tableRowToSizeMap.set(index, sizeKey);
    console.log(`[Size Save] 테이블 행 ${index}와 size_id ${sizeKey} 매핑`);
  }
});

// 변경된 행의 size_id 수집 - 올바른 행 인덱스 사용
const targetSizeIds = new Set();
actualChanges.forEach(change => {
  const sizeId = tableRowToSizeMap.get(change.actualRowIndex);
  if (sizeId) {
    targetSizeIds.add(sizeId);
    console.log(`[Size Save] 변경 대상 추가: 행 ${change.actualRowIndex} -> size_id ${sizeId}`);
  }
});

console.log(`[Size Save] 변경 대상 size_id: ${Array.from(targetSizeIds).join(', ')}`);

// 실제 데이터 업데이트
const updatedSizeItems = initialSizeItems.map((colorItem) => {
  // size_reorder_info 배열이 없으면 항목 그대로 반환
  if (!Array.isArray(colorItem.size_reorder_info) || colorItem.size_reorder_info.length === 0) {
    return colorItem;
  }
  
  // colorItem의 복사본 생성
  const updatedColorItem = { ...colorItem };
  
  // size_reorder_info 배열 복사 및 업데이트
  updatedColorItem.size_reorder_info = colorItem.size_reorder_info.map((sizeItem, sizeIdx) => {
    // 식별자 생성
    const sizeId = sizeItem.size_id || 
                   `${colorItem.sty_cd}_${colorItem.col_cd}_${sizeItem.size_cd}`;
    
    // 이 행이 변경 대상인지 확인
    const isTargetSize = targetSizeIds.has(sizeId);
    
    // 변경 대상이 아니면 원본 반환
    if (!isTargetSize) {
      return sizeItem;
    }
    
    // 이 사이즈 항목에 대한 변경사항 찾기
    const change = actualChanges.find(c => {
      const rowSizeId = tableRowToSizeMap.get(c.actualRowIndex);
      return rowSizeId === sizeId;
    });
    
    // 변경사항이 있으면 적용
    if (change && change.fields) {
      updatedItems++;
      
      // 필드 업데이트를 위한 새 객체 생성
      const updatedSizeItem = { ...sizeItem };
      
      console.log(`[Size Save] ${sizeId} 업데이트 시작 (테이블 행 ${change.actualRowIndex})`);
      
      // growth_rate 업데이트
      let growthRateChanged = false;
      let newGrowthRate = sizeItem.growth_rate || 100;
      
      if (change.fields.growth_rate !== undefined) {
        newGrowthRate = parseInt(change.fields.growth_rate) || 100;
        growthRateChanged = newGrowthRate !== sizeItem.growth_rate;
        updatedSizeItem.growth_rate = newGrowthRate;
        console.log(`[Size Save] ${sizeId} - growth_rate 업데이트: ${sizeItem.growth_rate} → ${updatedSizeItem.growth_rate}`);
      }
      
      // reorder_qty 업데이트
      if (change.fields.reorder_qty !== undefined) {
        updatedSizeItem.reorder_qty = parseInt(change.fields.reorder_qty) || 0;
        console.log(`[Size Save] ${sizeId} - reorder_qty 업데이트: ${sizeItem.reorder_qty} → ${updatedSizeItem.reorder_qty}`);
      }
      
      // growth_rate가 변경되었으면 expected_sales 재계산
      if (growthRateChanged) {
        // 원래 예상 판매량에서 성장율만 조정
        const originalExpectedSales = parseInt(sizeItem.expected_sales) || 0;
        const originalGrowthRate = sizeItem.growth_rate || 100;
        const newExpectedSales = Math.round(originalExpectedSales * (newGrowthRate / originalGrowthRate));
        
        // 예상 판매량 업데이트
        updatedSizeItem.expected_sales = newExpectedSales;
        updatedSizeItem.expected_sales_full_period = newExpectedSales;
        
        // 현재 재고량 가져오기
        let currentStock = parseInt(sizeItem.total_stock) || 0;
        
        // 테이블 행 데이터에서도 확인
        const tableRow = tableData[change.actualRowIndex];
        if (tableRow && tableRow.total_stock !== undefined) {
          currentStock = parseInt(tableRow.total_stock) || 0;
        }
        
        console.log(`[Size Save] ${sizeId} - 현재 재고량: ${currentStock}`);
        
        // 부족 수량 계산
        const newShortageQty = Math.max(0, newExpectedSales - currentStock);
        updatedSizeItem.shortage_qty = newShortageQty;
        
        console.log(`[Size Save] ${sizeId} - expected_sales 재계산: ${sizeItem.expected_sales} → ${newExpectedSales}`);
        console.log(`[Size Save] ${sizeId} - shortage_qty 재계산: ${sizeItem.shortage_qty} → ${newShortageQty}`);
      }
      
      // 업데이트된 아이템 반환
      return updatedSizeItem;
    }
    
    // 변경사항이 없으면 원본 반환
    return sizeItem;
  });
  
  return updatedColorItem;
});

// 4. 데이터 업데이트
if (updatedItems > 0) {
  console.log(`[Size Save] ${updatedItems}개 사이즈 항목 업데이트 완료`);
  
  // selectedReorderItems 업데이트
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

// 결과 반환
return {
  success: true,
  updatedItems: updatedItems,
  totalItems: initialSizeItems.reduce((count, item) => 
    count + (Array.isArray(item.size_reorder_info) ? item.size_reorder_info.length : 0), 0)
};