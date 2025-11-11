// Retool용 리오더 선택 '계산' 함수
// 이 함수의 유일한 역할: 현재 테이블 선택 상태를 기반으로 누적 선택 항목 배열을 계산하여 반환합니다.
function manageReorderSelection() {
  // 1. 입력 데이터 가져오기
  //  - accumulatedItems: 이전에 선택했던 항목들의 배열 (selectedReorderItems 상태에서 가져옴)
  //  - currentlySelectedRows: 현재 UI 테이블에서 체크된 행들의 배열
  const accumulatedItems = Array.isArray(selectedReorderItems.value) ? selectedReorderItems.value : [];
  const currentlySelectedRows = table_main_list.selectedRows || [];

  // 2. 선택 해제된 항목 제거
  // 기존 누적 목록(accumulatedItems)에서 현재 선택되지 않은 항목을 걸러냅니다.
  let updatedAccumulatedItems = accumulatedItems.filter(accItem => {
    return currentlySelectedRows.some(
      row => row.sty_cd === accItem.sty_cd && row.col_cd === accItem.col_cd
    );
  });
  
  // 3. 새로 선택된 항목 추가
  // 현재 테이블에서 선택된 행들을 순회하며, 기존 누적 목록에 없는 신규 항목만 추가합니다.
  currentlySelectedRows.forEach(row => {
    // findIndex를 사용하여 이미 목록에 있는지 확인합니다.
    const existingItemIndex = updatedAccumulatedItems.findIndex(
      item => item.sty_cd === row.sty_cd && item.col_cd === row.col_cd
    );
    
    // existingItemIndex가 -1이면, 목록에 없는 새로운 항목입니다.
    if (existingItemIndex === -1) {
      // 리오더 계산에 필요한 값들을 추출 및 계산합니다.
      const monthlySales = parseFloat(row.effective_monthly_sales || 0);
      const avgDailySales = monthlySales / 30;
      const leadTimeDays = parseInt(row.lead_time_days || 90);
      const expectedSalesRate = parseFloat(row.target_sale_rate || 0.8);
      
      // 새 항목 객체를 만들어 배열에 추가합니다.
      // 원본 row의 모든 필드를 복사한 뒤, 계산된 필드들을 추가/덮어씁니다.
      updatedAccumulatedItems.push({
        ...row, // 모든 원본 필드 복사 (item, item_nm 포함)
        
        // 리오더 계산에 필요한 추가/오버라이드 필드들
        MOQ: parseInt(row.moq || 500),
        avgDailySales: avgDailySales,
        avgMonthlySales: monthlySales,
        expectedSalesPeriod: 6, // 기본값
        expectedSalesQty: avgDailySales * leadTimeDays,
        expectedSupplyQty: (avgDailySales * leadTimeDays) / expectedSalesRate,
        finalReorderQty: parseInt(row.final_reorder_qty || 0),
        modifiableCostPrice: parseFloat(row.cost_price || 0),
        priceMultiple: parseFloat(row.price_multiple || 0),
        exclude_button: '제외'
      });
    }
  });

  // 4. 최종 결과 반환
  // ✨ 중요: 계산이 완료된 '순수 배열'만 반환합니다.
  // 이 쿼리는 더 이상 상태(state)를 직접 변경하거나(setValue) 요약 정보(summary)를 반환하지 않습니다.
  return updatedAccumulatedItems;
}

// 함수 실행
return manageReorderSelection();