// InsertManufactoringTeamInputData
// 제조팀 입력 데이터를 선택된 리오더 항목에 반영하는 함수

function InsertManufactoringTeamInputData() {
  // 1. 데이터 소스 가져오기
  const selectedItems = selectedReorderItems.value || [];
  const manufacturingData = get_manufactoring_team_input_data.data || [];
  
  console.log(`InsertManufactoringTeamInputData 시작: 선택된 항목 ${selectedItems.length}개, 제조팀 데이터 ${manufacturingData.length}개`);
  
  // 데이터가 없는 경우 처리
  if (!selectedItems.length) {
    console.warn("선택된 리오더 항목이 없습니다.");
    return {
      success: false,
      message: "선택된 리오더 항목이 없습니다.",
      updatedCount: 0,
      items: []
    };
  }
  
  if (!manufacturingData.length) {
    console.warn("제조팀 입력 데이터가 없습니다.");
    return {
      success: false,
      message: "제조팀 입력 데이터가 없습니다.",
      updatedCount: 0,
      items: selectedItems
    };
  }
  
  // 2. 제조팀 데이터 매핑을 위한 룩업 테이블 생성 (빠른 검색을 위해)
  const manufacturingMap = new Map();
  manufacturingData.forEach(mfgItem => {
    if (mfgItem && mfgItem.sty_cd && mfgItem.col_cd) {
      const key = `${mfgItem.sty_cd}|${mfgItem.col_cd}`;
      manufacturingMap.set(key, mfgItem);
      console.log(`매핑에 추가됨: ${key}`, mfgItem);
    }
  });
  
  console.log(`제조팀 데이터 맵 생성: ${manufacturingMap.size}개 항목`);
  
  // 3. 각 선택된 항목에 제조팀 데이터 반영
  let updatedCount = 0;
  const updatedItems = selectedItems.map(item => {
    // 변경된 구조에서 스타일 코드와 컬러 코드 가져오기
    const sty_cd = item.reference_info?.sty_cd;
    const col_cd = item.reference_info?.col_cd;
    
    // 스타일 코드와 컬러 코드가 없는 항목은 건너뛰기
    if (!sty_cd || !col_cd) {
      console.warn(`스타일 코드 또는 컬러 코드 없음: ${JSON.stringify(item.reference_info)}`);
      return item;
    }
    
    // 제조팀 데이터 매칭 확인
    const key = `${sty_cd}|${col_cd}`;
    console.log(`검색 키: ${key}`);
    const matchingMfgData = manufacturingMap.get(key);
    
    // 매칭되는 데이터가 없으면 원본 항목 그대로 반환
    if (!matchingMfgData) {
      console.warn(`매칭되는 제조팀 데이터 없음: ${key}`);
      return item;
    }
    
    // 매칭된 항목이 있으면 제조팀 데이터 반영
    updatedCount++;
    
    // 안전한 숫자 변환 함수
    const safeNumber = (val, defaultVal) => {
      if (val === null || val === undefined || val === '') return defaultVal;
      const num = Number(val);
      return isNaN(num) ? defaultVal : num;
    };
    
    // 데이터 추출 및 변환
    const reorderCost = safeNumber(matchingMfgData.reorder_cost, item.production_info?.["리오더 원가"] || 0);
    const leadTime = safeNumber(matchingMfgData.lead_time, 90);
    const moq = safeNumber(matchingMfgData.moq, 500);
    const manufacturerStock = safeNumber(matchingMfgData.manufacturer_stock, 0);
    const note = matchingMfgData.note || '';
    const responder = matchingMfgData.responder || '';
    
    console.log(`항목 업데이트: ${sty_cd}_${col_cd} - 리오더원가: ${reorderCost}, 리드타임: ${leadTime}, MOQ: ${moq}`);
    
    // 가격 배수 재계산
    const tagPrice = safeNumber(item.production_info?.["TAG가"], 0);
    const priceReorderMultiple = tagPrice > 0 && reorderCost > 0 ? 
      tagPrice / reorderCost / 1.1 : 
      item.production_info?.["배수"] || 0;
    
    // 깊은 복사를 통해 중첩 객체 복사
    const updatedItem = JSON.parse(JSON.stringify(item));
    
    // reorder_info 업데이트
    if (updatedItem.reorder_info) {
      updatedItem.reorder_info["리드타임(일)"] = leadTime;
      // 리오더 납기일 재계산 - 기준일로부터 리드타임 이후
      if (updatedItem.sales_performance?.["기준일"]) {
        const referenceDate = new Date(updatedItem.sales_performance["기준일"]);
        if (!isNaN(referenceDate.getTime())) {
          const newDeliveryDate = new Date(referenceDate);
          newDeliveryDate.setDate(newDeliveryDate.getDate() + leadTime);
          updatedItem.reorder_info["리오더 납기일"] = newDeliveryDate.toISOString().split('T')[0];
          
          // 리오더 납기일~판매 마감일 기간 재계산
          if (updatedItem.reorder_info["판매 마감일"]) {
            const salesEndDate = new Date(updatedItem.reorder_info["판매 마감일"]);
            if (!isNaN(salesEndDate.getTime())) {
              const daysDiff = Math.floor((salesEndDate - newDeliveryDate) / (1000 * 60 * 60 * 24));
              updatedItem.reorder_info["리오더 납기일~판매 마감일"] = Math.max(0, daysDiff);
            }
          }
        }
      }
    }
    
    // production_info 업데이트 - note 추가
    if (!updatedItem.production_info) {
      updatedItem.production_info = {};
    }
    updatedItem.production_info["리오더 원가"] = reorderCost;
    updatedItem.production_info["리오더 배수"] = Number(priceReorderMultiple.toFixed(2));
    updatedItem.production_info["note"] = note; // note 필드 추가
    
    // reference_info에 생산팀 입력 여부 플래그 추가
    if (!updatedItem.reference_info) {
      updatedItem.reference_info = {};
    }
    updatedItem.reference_info.has_sheet_data = true;
    updatedItem.reference_info.responder = responder;
    updatedItem.reference_info.last_updated = new Date().toISOString();
    
    // 새로운 필드 추가를 위한 mfg_info 객체 생성 또는 업데이트
    if (!updatedItem.mfg_info) {
      updatedItem.mfg_info = {};
    }
    
    updatedItem.mfg_info = {
      ...updatedItem.mfg_info,
      manufacturer_stock: manufacturerStock,
      note: note,
      responder: responder,
      data_source: "manufacturing_team",
      last_updated: new Date().toISOString()
    };
    
    // size_reorder_info 업데이트
    if (updatedItem.size_reorder_info && updatedItem.size_reorder_info.length > 0) {
      updatedItem.size_reorder_info = updatedItem.size_reorder_info.map(size => {
        return {
          ...size,
          lead_time: leadTime,
          production_cost: reorderCost,
          note: note // 각 사이즈 항목에도 note 추가
        };
      });
    }
    
    return updatedItem;
  });
  
  // 4. 업데이트된 항목을 selectedReorderItems에 반영
  selectedReorderItems.setValue(updatedItems);
  
  console.log(`InsertManufactoringTeamInputData 완료: ${updatedCount}개 항목 업데이트됨`);
  
  // 5. 결과 반환
  return {
    success: true,
    message: `${updatedCount}개 항목에 제조팀 데이터가 반영되었습니다.`,
    updatedCount: updatedCount,
    items: updatedItems
  };
}

// 함수 실행
return InsertManufactoringTeamInputData();