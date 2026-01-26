// Query Name: saveColorEdits
console.log("=== Key-Value 컴포넌트 직접 업데이트 시도 ===");
try {
  // 0. 업데이트 중인지 확인 (중복 실행 방지)
  if (!temp.hasOwnProperty('isUpdating')) {
    temp.isUpdating = false;
    temp.lastUpdateTime = 0;
    temp.updateCount = 0;
  }
  
  const now = Date.now();
  const timeSinceLastUpdate = now - temp.lastUpdateTime;
  
  if (temp.isUpdating && timeSinceLastUpdate < 1500) {
    console.warn("이미 업데이트가 진행 중이거나 너무 빠른 연속 요청입니다. 처리를 중단합니다.");
    console.log(`마지막 업데이트로부터 경과 시간: ${timeSinceLastUpdate}ms`);
    return { success: false, message: "이미 업데이트가 진행 중이거나 너무 빠른 연속 요청입니다. 잠시 후 다시 시도해주세요." };
  }
  
  if (temp.updateCount >= 5) {
    console.warn(`연속된 업데이트 ${temp.updateCount}회 감지됨 - 상태 강제 초기화`);
    temp.isUpdating = false;
    temp.updateCount = 0;
  }
  
  temp.isUpdating = true;
  temp.lastUpdateTime = now;
  temp.updateCount += 1;
  console.log(`업데이트 시작 - 상태 플래그 설정 (업데이트 횟수: ${temp.updateCount})`);
  
  // 모든 changeset 상태 확인 및 로깅
  if (keyValueProductInfo?.changeset) {
    console.log("ProductInfo changeset 상태:", Object.keys(keyValueProductInfo.changeset).length > 0 ? "변경사항 있음" : "비어있음");
  }
  
  if (keyValueSalesPerformance?.changeset) {
    console.log("SalesPerformance changeset 상태:", Object.keys(keyValueSalesPerformance.changeset).length > 0 ? "변경사항 있음" : "비어있음");
  }
  
  if (keyValueReorderInfo?.changeset) {
    console.log("ReorderInfo changeset 상태:", Object.keys(keyValueReorderInfo.changeset).length > 0 ? "변경사항 있음" : "비어있음");
  }
  
  // 이전 changeset 초기화 시도 (새 업데이트 전)
  const productChanges = keyValueProductInfo?.changeset ? {...keyValueProductInfo.changeset} : {};
  if (keyValueProductInfo && typeof keyValueProductInfo.clearChangeset === 'function') {
    keyValueProductInfo.clearChangeset();
    console.log("keyValueProductInfo changeset 초기화 완료");
  }
  
  const salesChanges = keyValueSalesPerformance?.changeset ? {...keyValueSalesPerformance.changeset} : {};
  if (keyValueSalesPerformance && typeof keyValueSalesPerformance.clearChangeset === 'function') {
    keyValueSalesPerformance.clearChangeset();
    console.log("keyValueSalesPerformance changeset 초기화 완료");
  }
  
  const reorderChanges = keyValueReorderInfo?.changeset ? {...keyValueReorderInfo.changeset} : {};
  if (keyValueReorderInfo && typeof keyValueReorderInfo.clearChangeset === 'function') {
    keyValueReorderInfo.clearChangeset();
    console.log("keyValueReorderInfo changeset 초기화 완료");
  }
  
  const changes = { ...productChanges, ...salesChanges, ...reorderChanges };
  console.log("변경사항:", JSON.stringify(changes, null, 2));
  
  if (Object.keys(changes).length === 0) {
    temp.isUpdating = false;
    return { success: true, message: "변경사항이 없습니다." };
  }
  
  const groupId = keyValueProductInfo?.data?.groupId || keyValueSalesPerformance?.data?.groupId || keyValueReorderInfo?.data?.groupId;
  console.log("그룹ID:", groupId);
  
  if (!groupId) {
    temp.isUpdating = false;
    return { success: false, message: "아이템 식별 정보가 없습니다." };
  }
  
  // 변경된 값들 처리
  let newCostPrice = null;
  let newTagPrice = null;
  let newDailySales7d = null;
  let newReferenceDate = null;
  let newLeadTimeDays = null;
  let newSalesEndDate = null;
  let newGrowthRate = null;
  let newMdMemo = null; // MD 메모 추가
  
  // 안전한 숫자 변환 함수
  const safeNumber = (val) => {
    if (val === null || val === undefined || val === '') return 0;
    const num = Number(val);
    return isNaN(num) ? 0 : num;
  };
  
  const safeInteger = (val) => {
    return Math.round(safeNumber(val));
  };
  
  const formatDate = (dateStr) => {
    if (!dateStr) return '';
    const date = new Date(dateStr);
    if (isNaN(date.getTime())) return dateStr;
    return date.toISOString().split('T')[0];
  };
  
  const getDaysDifference = (startDateStr, endDateStr) => {
    if (!startDateStr || !endDateStr) return 0;
    const start = new Date(startDateStr);
    const end = new Date(endDateStr);
    if (isNaN(start.getTime()) || isNaN(end.getTime())) return 0;
    return Math.floor((end - start) / (1000 * 60 * 60 * 24)) + 1;
  };
  
  // 변경사항 확인
  if ('리오더 원가' in changes) {
    console.log(`리오더 원가 업데이트: ${changes['리오더 원가']}`);
    newCostPrice = parseFloat(changes['리오더 원가']);
    if (isNaN(newCostPrice) || newCostPrice <= 0) {
      temp.isUpdating = false;
      return { success: false, message: "유효하지 않은 원가 값입니다." };
    }
  }
  
  if ('리오더 TAG가' in changes) {
    console.log(`리오더 TAG가 업데이트: ${changes['리오더 TAG가']}`);
    newTagPrice = parseFloat(changes['리오더 TAG가']);
    if (isNaN(newTagPrice) || newTagPrice <= 0) {
      temp.isUpdating = false;
      return { success: false, message: "유효하지 않은 판매가 값입니다." };
    }
  }
  
  if ('최근 7일 판매량' in changes) {
    console.log(`최근 7일 판매량 업데이트: ${changes['최근 7일 판매량']}`);
    newDailySales7d = parseFloat(changes['최근 7일 판매량']);
    if (isNaN(newDailySales7d) || newDailySales7d < 0) {
      temp.isUpdating = false;
      return { success: false, message: "유효하지 않은 판매량 값입니다." };
    }
  }
  
  if ('기준일' in changes) {
    console.log(`기준일 업데이트: ${changes['기준일']}`);
    newReferenceDate = changes['기준일'];
    try {
      newReferenceDate = formatDate(newReferenceDate);
    } catch (e) {
      temp.isUpdating = false;
      return { success: false, message: "유효하지 않은 기준일 형식입니다." };
    }
  }
  
  if ('리드타임(일)' in changes) {
    console.log(`리드타임 업데이트: ${changes['리드타임(일)']}`);
    newLeadTimeDays = parseInt(changes['리드타임(일)']);
    if (isNaN(newLeadTimeDays) || newLeadTimeDays <= 0) {
      temp.isUpdating = false;
      return { success: false, message: "유효하지 않은 리드타임 값입니다." };
    }
  }
  
  if ('판매 마감일' in changes) {
    console.log(`판매 마감일 업데이트: ${changes['판매 마감일']}`);
    newSalesEndDate = changes['판매 마감일'];
    try {
      newSalesEndDate = formatDate(newSalesEndDate);
    } catch (e) {
      temp.isUpdating = false;
      return { success: false, message: "유효하지 않은 판매 마감일 형식입니다." };
    }
  }
  
  if ('성장률(%)' in changes) {
    console.log(`성장률 업데이트: ${changes['성장률(%)']}`);
    const growthRatePercent = parseFloat(changes['성장률(%)']);
    if (isNaN(growthRatePercent) || growthRatePercent < 0) {
      temp.isUpdating = false;
      return { success: false, message: "유효하지 않은 성장률 값입니다." };
    }
    newGrowthRate = growthRatePercent / 100;
  }

  // MD 메모 변경사항 확인 추가
  if ('MD 메모' in changes) {
    console.log(`MD 메모 업데이트: ${changes['MD 메모']}`);
    newMdMemo = changes['MD 메모'];
  }
  
  if (newCostPrice === null && newTagPrice === null && newDailySales7d === null && 
      newReferenceDate === null && newLeadTimeDays === null && 
      newSalesEndDate === null && newGrowthRate === null && newMdMemo === null) { // newMdMemo 추가
    temp.isUpdating = false;
    return { success: false, message: "변경할 값이 없습니다." };
  }
  
  // selectedReorderItems 업데이트
  const currentItems = selectedReorderItems.value || [];
  console.log(`현재 currentItems: ${currentItems.length}개`);
  
  const backupItems = JSON.parse(JSON.stringify(currentItems));
  const itemFound = { found: false };
  
  try {
    const updatedItems = currentItems.map(item => {
      // groupId 매칭 확인
      const itemGroupId = item.reorder_info?.groupId || 
                          item.reference_info?.groupId || 
                          item.production_info?.groupId || 
                          item.sales_performance?.groupId ||
                          `${item.reference_info?.sty_cd}_${item.reference_info?.col_cd}`;
      
      if (itemGroupId === groupId) {
        itemFound.found = true;
        console.log(`아이템 매칭됨: ${groupId}`);
        
        const updatedItem = { ...item };
        
        // 현재 값들 가져오기
        const currentCostPrice = newCostPrice !== null ? newCostPrice : safeNumber(updatedItem.production_info?.["리오더 원가"]);
        const currentTagPrice = newTagPrice !== null ? newTagPrice : safeNumber(updatedItem.production_info?.["리오더 TAG가"]);
        const currentReferenceDate = newReferenceDate || updatedItem.sales_performance?.["기준일"] || formatDate(new Date());
        const currentLeadTimeDays = newLeadTimeDays !== null ? newLeadTimeDays : safeNumber(updatedItem.reorder_info?.["리드타임(일)"]);
        const currentSalesEndDate = newSalesEndDate || updatedItem.reorder_info?.["판매 마감일"] || '';
        const currentGrowthRate = newGrowthRate !== null ? newGrowthRate : (safeNumber(updatedItem.reorder_info?.["성장률(%)"]) / 100);
        const currentDailySales7d = newDailySales7d !== null ? newDailySales7d : safeNumber(updatedItem.sales_performance?.["최근 7일 판매량"]);
        const currentMdMemo = newMdMemo !== null ? newMdMemo : (updatedItem.reorder_info?.["MD 메모"] || ''); // MD 메모 현재 값 가져오기
        
        console.log(`현재 값 - 원가: ${currentCostPrice}, TAG가: ${currentTagPrice}, 성장률: ${currentGrowthRate}, 판매마감일: ${currentSalesEndDate}, MD 메모: ${currentMdMemo}`);
        
        // 배수 계산
        let newMultiple = 0;
        try {
          newMultiple = currentTagPrice > 0 && currentCostPrice > 0 ? 
            Number((currentTagPrice / currentCostPrice / 1.1).toFixed(2)) : 0;
          console.log(`계산된 배수: ${newMultiple}`);
        } catch (e) {
          console.warn(`배수 계산 오류: ${e.message}`);
          newMultiple = 0;
        }
        
        // 1. TAG가 및 원가 업데이트
        if (updatedItem.production_info) {
          if (newCostPrice !== null) {
            updatedItem.production_info["리오더 원가"] = safeInteger(newCostPrice);
            console.log(`원가 업데이트 완료: ${safeInteger(newCostPrice)}`);
          }
          
          if (newTagPrice !== null) {
            updatedItem.production_info["리오더 TAG가"] = safeInteger(newTagPrice);
            console.log(`TAG가 업데이트 완료: ${safeInteger(newTagPrice)}`);
          }
          
          updatedItem.production_info["리오더 배수"] = newMultiple;
          updatedItem.price_multiple = newMultiple;
          updatedItem.priceReorderMultiple = newMultiple;
          console.log(`배수 업데이트 완료: ${newMultiple}`);
        }
        
        // 2. 판매 실적 업데이트
        if (updatedItem.sales_performance) {
          if (newReferenceDate) {
            const oldReferenceDate = updatedItem.sales_performance["기준일"] || '';
            
            updatedItem.sales_performance["기준일"] = newReferenceDate;
            
            // 출고일 가져오기
            const firstOutboundDate = updatedItem.production_info?.["출고일"] || '';
            if (firstOutboundDate) {
              const salesPeriod = getDaysDifference(firstOutboundDate, newReferenceDate);
              updatedItem.sales_performance["출고~기준일 판매일수"] = salesPeriod;
              console.log(`기준일 변경에 따른 판매일수 업데이트: ${salesPeriod}일`);
              
              if (salesPeriod > 0) {
                const totSaleQty = safeNumber(updatedItem.sales_performance?.["누적 판매량"]);
                const dailySales = totSaleQty / salesPeriod;
                updatedItem.sales_performance["일 판매량"] = Math.round(dailySales);
                
                const shopCount = safeNumber(updatedItem.sales_performance["매장수"]);
                if (shopCount > 0) {
                  updatedItem.sales_performance["매장당 일 판매량"] = Number((dailySales / shopCount).toFixed(2));
                }
                console.log(`일 판매량 재계산: ${Math.round(dailySales)}`);
              }
            }
            
            updatedItem._reorderInfoNeedsUpdate = true;
            console.log(`기준일 업데이트 완료: ${newReferenceDate} (이전: ${oldReferenceDate})`);
          }
          
          if (newDailySales7d !== null) {
            updatedItem.sales_performance["최근 7일 판매량"] = safeInteger(newDailySales7d);
            
            const shopCount = safeNumber(updatedItem.sales_performance["매장수"]);
            
            if (shopCount > 0) {
              const dailyAvgSales = newDailySales7d / 7;
              const shopDailySales = dailyAvgSales / shopCount;
              updatedItem.sales_performance["매장당 일 판매량"] = Number(shopDailySales.toFixed(2));
              
              const totOutQty = safeNumber(updatedItem.production_info?.["출고 수량"]);
              if (totOutQty > 0) {
                const salesRateD7 = newDailySales7d / totOutQty;
                updatedItem.sales_performance["최근 7일 판매율(출고 기준)"] = Number(salesRateD7.toFixed(4));
              }
            }
            
            console.log(`최근 7일 판매량 업데이트 완료: ${safeInteger(newDailySales7d)}`);
          }
        }
        
        // 3. 리오더 정보 업데이트
        if (updatedItem.reorder_info) {
          let reorderInfoChanged = false;
          
          if (newLeadTimeDays !== null) {
            updatedItem.reorder_info["리드타임(일)"] = safeInteger(newLeadTimeDays);
            reorderInfoChanged = true;
            console.log(`리드타임 업데이트 완료: ${safeInteger(newLeadTimeDays)}`);
          }
          
          if (newSalesEndDate) {
            updatedItem.reorder_info["판매 마감일"] = newSalesEndDate;
            reorderInfoChanged = true;
            console.log(`판매 마감일 업데이트 완료: ${newSalesEndDate}`);
          }
          
          if (newGrowthRate !== null) {
            updatedItem.reorder_info["성장률(%)"] = safeInteger(newGrowthRate * 100);
            reorderInfoChanged = true;
            console.log(`성장률 업데이트 완료: ${safeInteger(newGrowthRate * 100)}%`);
          }

          // MD 메모 업데이트 로직 추가
          if (newMdMemo !== null) {
            updatedItem.reorder_info["MD 메모"] = newMdMemo;
            reorderInfoChanged = true;
            console.log(`MD 메모 업데이트 완료: ${newMdMemo}`);
          }
          
          // 리오더 정보가 변경되었거나 관련 필드가 변경된 경우
          if (reorderInfoChanged || newReferenceDate || newDailySales7d !== null || updatedItem._reorderInfoNeedsUpdate) {
            const reorderInboundDate = (() => {
              const date = new Date(currentReferenceDate);
              date.setDate(date.getDate() + currentLeadTimeDays);
              return formatDate(date);
            })();
            updatedItem.reorder_info["리오더 납기일"] = reorderInboundDate;
            console.log(`리오더 납기일 계산: ${reorderInboundDate}`);
            
            const daysUntilSalesEnd = currentSalesEndDate ? getDaysDifference(currentReferenceDate, currentSalesEndDate) : 90;
            updatedItem.reorder_info["기준일~판매 마감일"] = safeInteger(daysUntilSalesEnd);
            updatedItem.expected_sales_period = safeInteger(daysUntilSalesEnd);
            console.log(`판매마감까지 남은 일수 계산: ${daysUntilSalesEnd}일`);
            
            const salesEndToReorderInboundDays = currentSalesEndDate ? getDaysDifference(reorderInboundDate, currentSalesEndDate) : 0;
            updatedItem.reorder_info["리오더 납기일~판매 마감일"] = safeInteger(salesEndToReorderInboundDays);
            console.log(`리오더 입고 후 판매 가능일수 계산: ${salesEndToReorderInboundDays}일`);
            
            const shopCount = safeNumber(updatedItem.sales_performance?.["매장수"]);
            const dailySalesFromLast7d = currentDailySales7d / 7;
            const dailySales = dailySalesFromLast7d > 0 
              ? dailySalesFromLast7d 
              : safeNumber(updatedItem.sales_performance?.["일 판매량"]);
            const shopDailySales = shopCount > 0 ? dailySales / shopCount : 0;
            
            const expectedSales = daysUntilSalesEnd * shopCount * shopDailySales * currentGrowthRate;
            updatedItem.reorder_info["기준일~마감일 예상 판매량"] = safeInteger(expectedSales);
            updatedItem.expected_sales_full_period = safeInteger(expectedSales);
            console.log(`예상 판매량 계산: ${safeInteger(expectedSales)}`);
            
            const totalStock = safeNumber(updatedItem.production_info?.["매장재고"]) + 
                               safeNumber(updatedItem.production_info?.["창고재고"]);
            updatedItem.reorder_info["현재 총재고"] = safeInteger(totalStock);
            
            const shortageSales = Math.max(0, expectedSales - totalStock);
            updatedItem.reorder_info["부족 수량"] = safeInteger(shortageSales);
            updatedItem.shortage_qty = safeInteger(shortageSales);
            console.log(`부족 수량 계산: ${safeInteger(shortageSales)}`);
            
            const targetSaleRate = 1.0; // 기본값
            const reorderRequiredQty = shortageSales > 0 ? shortageSales / targetSaleRate : 0;
            const reorderFinalQty = Math.ceil(reorderRequiredQty / 10) * 10;
            
            const expectedSalesDuringLeadTime = shopDailySales * shopCount * currentLeadTimeDays * currentGrowthRate;
            updatedItem.expected_sales_during_lead_time = safeInteger(expectedSalesDuringLeadTime);
            updatedItem.expected_sales = safeInteger(expectedSalesDuringLeadTime);
            updatedItem.expectedSalesQty = safeInteger(expectedSalesDuringLeadTime);
            console.log(`리드타임 동안 예상 판매량 계산: ${safeInteger(expectedSalesDuringLeadTime)}`);
            
            const leadTimeShortageQty = Math.max(0, expectedSalesDuringLeadTime - totalStock);
            updatedItem.lead_time_shortage_qty = safeInteger(leadTimeShortageQty);
            
            const leadTimeRecommendedReorderQty = leadTimeShortageQty > 0 ? leadTimeShortageQty / targetSaleRate : 0;
            updatedItem.lead_time_recommended_reorder_qty = safeInteger(leadTimeRecommendedReorderQty);
            
            const leadTimeFinalReorderQty = Math.ceil(leadTimeRecommendedReorderQty / 10) * 10;
            updatedItem.lead_time_final_reorder_qty = safeInteger(leadTimeFinalReorderQty);
            
            updatedItem.recommended_reorder_qty = safeInteger(reorderRequiredQty);
            updatedItem.final_reorder_qty = safeInteger(reorderFinalQty);
            updatedItem.finalReorderQty = safeInteger(reorderFinalQty);
            updatedItem.expectedSupplyQty = safeInteger(shortageSales);
            console.log(`최종 리오더 수량 계산: ${safeInteger(reorderFinalQty)}`);
            
            // 사이즈별 리오더 정보 업데이트
            if (updatedItem.size_reorder_info && Array.isArray(updatedItem.size_reorder_info)) {
              const totalSizeOutQty = updatedItem.size_reorder_info.reduce((sum, size) => 
                sum + safeNumber(size.size_out_count), 0) || 1;
              
              updatedItem.size_reorder_info = updatedItem.size_reorder_info.map(sizeInfo => {
                const sizeOutQty = safeNumber(sizeInfo.size_out_count);
                const sizeRatio = totalSizeOutQty > 0 ? sizeOutQty / totalSizeOutQty : 0;
                
                // 사이즈별 일 판매량 계산
                const sizeDailySales = dailySales * sizeRatio;
                
                // 사이즈별 예상 판매량 계산
                const sizeExpectedSales = daysUntilSalesEnd * shopCount * (sizeDailySales / shopCount) * currentGrowthRate;
                
                // 사이즈별 부족 수량 계산
                const sizeStock = safeNumber(sizeInfo.total_stock);
                const sizeShortageQty = Math.max(0, sizeExpectedSales - sizeStock);
                
                // 사이즈별 리오더 수량 (전체 리오더 수량 * 사이즈 비율)
                const sizeReorderQty = Math.ceil(reorderFinalQty * sizeRatio / 10) * 10;
                
                return {
                  ...sizeInfo,
                  reorder_qty: safeInteger(sizeReorderQty),
                  growth_rate: safeInteger(currentGrowthRate),
                  days_until_sales_end: safeInteger(daysUntilSalesEnd),
                  expected_sales: safeInteger(sizeExpectedSales),
                  shortage_qty: safeInteger(sizeShortageQty)
                };
              });
              
              console.log(`사이즈별 리오더 정보 업데이트 완료: ${updatedItem.size_reorder_info.length}개 사이즈`);
            }
            
            updatedItem._reorderInfoNeedsUpdate = false;
          }
        }
        
        return updatedItem;
      }
      
      return item;
    });
    
    if (!itemFound.found) {
      console.warn(`매칭된 아이템이 없습니다. 찾는 groupId: ${groupId}`);
      temp.isUpdating = false;
      return { success: false, message: "수정할 아이템을 찾을 수 없습니다." };
    } else {
      console.log("업데이트된 아이템 저장 시도...");
      selectedReorderItems.setValue(updatedItems);
      console.log(`selectedReorderItems 업데이트 완료: ${updatedItems.length}개 아이템`);
    }
  } catch (updateError) {
    console.error("아이템 업데이트 오류:", updateError);
    console.error("오류 스택:", updateError.stack);
    try {
      selectedReorderItems.setValue(backupItems);
      console.log("오류로 인해 백업에서 복구됨");
    } catch (backupError) {
      console.error("백업 복구 실패:", backupError);
    }
    
    temp.isUpdating = false;
    return {
      success: false,
      message: "아이템 업데이트 중 오류 발생: " + updateError.message
    };
  }
  
  // 결과 반환
  const changesProcessed = {
    productInfo: {}
  };
  
  if (newCostPrice !== null) {
    changesProcessed.productInfo.reorderCostPrice = newCostPrice;
  }
  
  if (newTagPrice !== null) {
    changesProcessed.productInfo.reorderTagPrice = newTagPrice;
  }
  
  if (newDailySales7d !== null) {
    changesProcessed.productInfo.weekly7dSaleQty = newDailySales7d;
    changesProcessed.productInfo.dailyAvgSales = newDailySales7d / 7;
  }
  
  if (newReferenceDate) {
    changesProcessed.productInfo.referenceDate = newReferenceDate;
  }
  
  if (newLeadTimeDays !== null) {
    changesProcessed.productInfo.leadTimeDays = newLeadTimeDays;
  }
  
  if (newSalesEndDate) {
    changesProcessed.productInfo.salesEndDate = newSalesEndDate;
  }
  
  if (newGrowthRate !== null) {
    changesProcessed.productInfo.growthRate = newGrowthRate * 100;
  }

  if (newMdMemo !== null) { // MD 메모 변경사항 처리 추가
    changesProcessed.productInfo.mdMemo = newMdMemo;
  }
  
  // 모든 컴포넌트의 changeset 확실히 초기화
  try {
    if (keyValueProductInfo && typeof keyValueProductInfo.clearChangeset === 'function') {
      keyValueProductInfo.clearChangeset();
      console.log("완료 후 ProductInfo changeset 초기화 확인");
    }
    
    if (keyValueSalesPerformance && typeof keyValueSalesPerformance.clearChangeset === 'function') {
      keyValueSalesPerformance.clearChangeset();
      console.log("완료 후 SalesPerformance changeset 초기화 확인");
    }
    
    if (keyValueReorderInfo && typeof keyValueReorderInfo.clearChangeset === 'function') {
      keyValueReorderInfo.clearChangeset();
      console.log("완료 후 ReorderInfo changeset 초기화 확인");
    }
  } catch (finalClearError) {
    console.warn("최종 changeset 초기화 실패:", finalClearError);
  }
  
  const result = {
    success: true,
    message: "변경사항이 처리되었습니다.",
    processedChanges: changesProcessed
  };
  
  temp.isUpdating = false;
  console.log("업데이트 완료 - 상태 플래그 초기화");
  
  return result;
  
} catch (error) {
  console.error("오류 발생:", error);
  console.error("오류 스택:", error.stack);
  
  temp.isUpdating = false;
  temp.updateCount = 0;
  console.log("오류 발생으로 인한 상태 플래그 초기화");
  
  return {
    success: false,
    message: "처리 중 오류가 발생했습니다: " + error.message
  };
} finally {
  if (temp.isUpdating) {
    temp.isUpdating = false;
    console.log("finally 블록에서 플래그 초기화 확인");
  }
}