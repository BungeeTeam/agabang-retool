// Query Name: saveColorEdits
console.log("=== 버전 체크: Key-Value 컴포넌트 직접 업데이트 시도 ===");

// 비동기 처리를 위한 함수로 변경
async function processSaveColorEdits() {
  const startTime = Date.now();
  const executionId = `exec_${startTime}_${Math.random().toString(36).substr(2, 9)}`;
  
  console.log(`[${executionId}] ==================== 실행 시작 ====================`);
  
  try {
    // 0. 중복 실행 방지 - Promise 기반으로 개선
    if (!temp.hasOwnProperty('isUpdating')) {
      temp.isUpdating = false;
      temp.lastUpdateTime = 0;
      temp.updateCount = 0;
      temp.currentExecution = null;
    }
    
    // 현재 실행 중인 작업이 있다면 대기
    if (temp.currentExecution) {
      console.log(`[${executionId}] 기존 실행 중인 작업 대기 중...`);
      try {
        await temp.currentExecution;
        console.log(`[${executionId}] 기존 작업 완료 대기 완료`);
      } catch (waitError) {
        console.warn(`[${executionId}] 기존 작업 대기 중 오류 (무시함):`, waitError.message);
      }
    }
    
    const now = Date.now();
    const timeSinceLastUpdate = now - temp.lastUpdateTime;
    
    // 너무 빠른 연속 호출 체크 (500ms로 단축)
    if (temp.isUpdating && timeSinceLastUpdate < 500) {
      console.warn(`[${executionId}] 너무 빠른 연속 요청 감지. 경과시간: ${timeSinceLastUpdate}ms`);
      return { 
        success: false, 
        message: "너무 빠른 연속 요청입니다. 잠시 후 다시 시도해주세요.",
        executionId: executionId
      };
    }
    
    // 과도한 연속 호출 체크
    if (temp.updateCount >= 10) {
      console.warn(`[${executionId}] 과도한 연속 호출 감지 (${temp.updateCount}회) - 상태 초기화`);
      temp.isUpdating = false;
      temp.updateCount = 0;
      temp.currentExecution = null;
    }
    
    // 실행 상태 설정
    temp.isUpdating = true;
    temp.lastUpdateTime = now;
    temp.updateCount += 1;
    
    console.log(`[${executionId}] 실행 상태 설정 완료 (업데이트 횟수: ${temp.updateCount})`);
    
    // 현재 실행을 추적하기 위한 Promise 생성
    let resolveCurrentExecution;
    temp.currentExecution = new Promise(resolve => {
      resolveCurrentExecution = resolve;
    });
    
    // 1. changeset 수집 단계
    console.log(`[${executionId}] =============== changeset 수집 시작 ===============`);
    
    const changesetCollection = await collectChangesets(executionId);
    if (!changesetCollection.success) {
      // changeset 수집 실패 시 상태 정리 후 반환
      temp.isUpdating = false;
      temp.currentExecution = null;
      resolveCurrentExecution && resolveCurrentExecution(changesetCollection);
      return changesetCollection;
    }
    
    const { changes, groupId } = changesetCollection;
    
    if (Object.keys(changes).length === 0) {
      console.log(`[${executionId}] 변경사항 없음 - 처리 종료`);
      temp.isUpdating = false;
      temp.currentExecution = null;
      const result = { 
        success: true, 
        message: "변경사항이 없습니다. 값을 수정한 후 저장 버튼을 클릭해주세요.",
        executionId: executionId
      };
      resolveCurrentExecution && resolveCurrentExecution(result);
      return result;
    }
    
    console.log(`[${executionId}] 수집된 변경사항:`, JSON.stringify(changes, null, 2));
    console.log(`[${executionId}] 대상 그룹ID: ${groupId}`);
    
    // 2. 변경사항 검증 및 파싱 단계
    console.log(`[${executionId}] =============== 변경사항 검증 시작 ===============`);
    
    const parsedChanges = await parseAndValidateChanges(changes, executionId);
    if (!parsedChanges.success) {
      return parsedChanges;
    }
    
    console.log(`[${executionId}] 검증된 변경사항:`, parsedChanges.validatedChanges);
    
    // 3. 아이템 업데이트 단계
    console.log(`[${executionId}] =============== 아이템 업데이트 시작 ===============`);
    
    const updateResult = await updateSelectedItems(groupId, parsedChanges.validatedChanges, executionId);
    if (!updateResult.success) {
      return updateResult;
    }
    
    // 4. changeset 초기화 단계
    console.log(`[${executionId}] =============== changeset 초기화 시작 ===============`);
    
    await clearAllChangesets(executionId);
    
    // 5. 완료 처리
    const endTime = Date.now();
    const duration = endTime - startTime;
    
    console.log(`[${executionId}] ==================== 실행 완료 ====================`);
    console.log(`[${executionId}] 총 실행 시간: ${duration}ms`);
    
    const result = {
      success: true,
      message: "변경사항이 성공적으로 처리되었습니다.",
      processedChanges: updateResult.processedChanges,
      executionId: executionId,
      duration: duration
    };
    
    // 현재 실행 완료 신호
    resolveCurrentExecution(result);
    
    return result;
    
  } catch (error) {
    const endTime = Date.now();
    const duration = endTime - startTime;
    
    console.error(`[${executionId}] #################### 오류 발생 ####################`);
    console.error(`[${executionId}] 오류 메시지:`, error.message);
    console.error(`[${executionId}] 오류 스택:`, error.stack);
    console.error(`[${executionId}] 실행 시간: ${duration}ms`);
    
    return {
      success: false,
      message: "처리 중 오류가 발생했습니다: " + error.message,
      executionId: executionId,
      duration: duration
    };
    
  } finally {
    // 상태 정리
    temp.isUpdating = false;
    temp.currentExecution = null;
    console.log(`[${executionId}] 상태 정리 완료`);
  }
}

// changeset 수집 함수 - GridView 환경에 맞게 수정
async function collectChangesets(executionId) {
  console.log(`[${executionId}] changeset 수집 시작...`);
  
  try {
    // GridView 환경에서는 changeset이 제대로 동작하지 않을 수 있으므로
    // 다른 방법으로 변경사항을 감지해야 합니다.
    
    // 1. 먼저 기존 changeset 방식 확인
    const productChangeset = keyValueProductInfo?.changeset || {};
    const salesChangeset = keyValueSalesPerformance?.changeset || {};
    const reorderChangeset = keyValueReorderInfo?.changeset || {};
    
    console.log(`[${executionId}] 기존 changeset 확인:`);
    console.log(`[${executionId}] - ProductInfo changeset:`, JSON.stringify(productChangeset, null, 2));
    console.log(`[${executionId}] - SalesPerformance changeset:`, JSON.stringify(salesChangeset, null, 2));
    console.log(`[${executionId}] - ReorderInfo changeset:`, JSON.stringify(reorderChangeset, null, 2));
    
    // 2. changeset이 null인지 확인
    const isProductChangesetNull = keyValueProductInfo?.changeset === null;
    const isSalesChangesetNull = keyValueSalesPerformance?.changeset === null;
    const isReorderChangesetNull = keyValueReorderInfo?.changeset === null;
    
    console.log(`[${executionId}] changeset null 여부:`);
    console.log(`[${executionId}] - ProductInfo changeset null:`, isProductChangesetNull);
    console.log(`[${executionId}] - SalesPerformance changeset null:`, isSalesChangesetNull);
    console.log(`[${executionId}] - ReorderInfo changeset null:`, isReorderChangesetNull);
    
    // 3. GridView 환경에서 changeset이 제대로 동작하지 않는다면
    // 사용자가 실제로 값을 변경했는지 다른 방법으로 확인
    
    // 현재 데이터 가져오기
    const currentData = {
      product: keyValueProductInfo?.data || {},
      sales: keyValueSalesPerformance?.data || {},
      reorder: keyValueReorderInfo?.data || {}
    };
    
    console.log(`[${executionId}] 현재 데이터:`);
    console.log(`[${executionId}] - ProductInfo:`, JSON.stringify(currentData.product, null, 2));
    console.log(`[${executionId}] - SalesPerformance:`, JSON.stringify(currentData.sales, null, 2));
    console.log(`[${executionId}] - ReorderInfo:`, JSON.stringify(currentData.reorder, null, 2));
    
    // 4. selectedReorderItems에서 원본 데이터 찾기
    const selectedItems = selectedReorderItems.value || [];
    const groupId = currentData.product.groupId || currentData.sales.groupId || currentData.reorder.groupId;
    
    if (!groupId) {
      console.error(`[${executionId}] groupId를 찾을 수 없음`);
      return { 
        success: false, 
        message: "아이템 식별 정보가 없습니다. 데이터를 다시 로드해주세요.",
        executionId: executionId
      };
    }
    
    console.log(`[${executionId}] 찾는 groupId: ${groupId}`);
    
    // 해당 groupId의 원본 데이터 찾기
    let originalItem = null;
    for (const item of selectedItems) {
      const itemGroupId = item.reorder_info?.groupId || 
                          item.reference_info?.groupId || 
                          item.production_info?.groupId || 
                          item.sales_performance?.groupId ||
                          `${item.reference_info?.sty_cd}_${item.reference_info?.col_cd}`;
      
      if (itemGroupId === groupId) {
        originalItem = item;
        break;
      }
    }
    
    if (!originalItem) {
      console.error(`[${executionId}] 원본 아이템을 찾을 수 없음`);
      return { 
        success: false, 
        message: "원본 데이터를 찾을 수 없습니다. 데이터를 다시 로드해주세요.",
        executionId: executionId
      };
    }
    
    console.log(`[${executionId}] 원본 아이템 찾음:`, originalItem.reference_info || originalItem.groupId);
    
    // 원본 아이템의 구조 확인
    console.log(`[${executionId}] 원본 아이템 구조 분석:`);
    console.log(`[${executionId}] - 원본 아이템 키:`, Object.keys(originalItem));
    console.log(`[${executionId}] - production_info 존재:`, !!originalItem.production_info);
    console.log(`[${executionId}] - sales_performance 존재:`, !!originalItem.sales_performance);
    console.log(`[${executionId}] - reorder_info 존재:`, !!originalItem.reorder_info);
    
    if (originalItem.production_info) {
      console.log(`[${executionId}] - production_info 내용:`, JSON.stringify(originalItem.production_info, null, 2));
    }
    if (originalItem.sales_performance) {
      console.log(`[${executionId}] - sales_performance 내용:`, JSON.stringify(originalItem.sales_performance, null, 2));
    }
    if (originalItem.reorder_info) {
      console.log(`[${executionId}] - reorder_info 내용:`, JSON.stringify(originalItem.reorder_info, null, 2));
    }
    
    // 5. 원본 데이터와 현재 데이터 비교하여 변경사항 감지
    const detectedChanges = {};
    
    // ProductInfo 변경사항 감지 - 다양한 구조 시도
    const originalProductInfo = originalItem.production_info || originalItem.productInfo || originalItem;
    
    console.log(`[${executionId}] 원본 ProductInfo 데이터:`, JSON.stringify(originalProductInfo, null, 2));
    
    // 리오더 원가 비교 - 다양한 키 이름 시도
    const originalReorderCost = originalProductInfo["리오더 원가"] || 
                               originalProductInfo.reorderCostPrice || 
                               originalProductInfo["리오더 원가"] ||
                               originalProductInfo.cost_price ||
                               originalProductInfo.tag_price ||
                               0;
    const currentReorderCost = currentData.product["리오더 원가"] || 0;
    console.log(`[${executionId}] 리오더 원가 비교: 원본=${originalReorderCost}, 현재=${currentReorderCost}`);
    if (Math.abs(currentReorderCost - originalReorderCost) > 0.01) {
      detectedChanges["리오더 원가"] = currentReorderCost;
      console.log(`[${executionId}] 리오더 원가 변경 감지: ${originalReorderCost} → ${currentReorderCost}`);
    }
    
    // 리오더 TAG가 비교 - 다양한 키 이름 시도
    const originalReorderTag = originalProductInfo["리오더 TAG가"] || 
                              originalProductInfo.reorderTagPrice || 
                              originalProductInfo["리오더 TAG가"] ||
                              originalProductInfo.tag_price ||
                              0;
    const currentReorderTag = currentData.product["리오더 TAG가"] || 0;
    console.log(`[${executionId}] 리오더 TAG가 비교: 원본=${originalReorderTag}, 현재=${currentReorderTag}`);
    if (Math.abs(currentReorderTag - originalReorderTag) > 0.01) {
      detectedChanges["리오더 TAG가"] = currentReorderTag;
      console.log(`[${executionId}] 리오더 TAG가 변경 감지: ${originalReorderTag} → ${currentReorderTag}`);
    }
    
    // SalesPerformance 변경사항 감지 - 다양한 구조 시도
    const originalSalesPerformance = originalItem.sales_performance || originalItem.salesPerformance || originalItem;
    
    console.log(`[${executionId}] 원본 SalesPerformance 데이터:`, JSON.stringify(originalSalesPerformance, null, 2));
    
    // 기준일 비교
    const originalReferenceDate = originalSalesPerformance["기준일"] || 
                                 originalSalesPerformance.reference_date ||
                                 originalSalesPerformance.referenceDate ||
                                 "";
    const currentReferenceDate = currentData.sales["기준일"] || "";
    console.log(`[${executionId}] 기준일 비교: 원본="${originalReferenceDate}", 현재="${currentReferenceDate}"`);
    if (originalReferenceDate !== currentReferenceDate) {
      detectedChanges["기준일"] = currentReferenceDate;
      console.log(`[${executionId}] 기준일 변경 감지: ${originalReferenceDate} → ${currentReferenceDate}`);
    }
    
    // 최근 7일 판매량 비교
    const originalWeeklySales = originalSalesPerformance["최근 7일 판매량"] || 
                               originalSalesPerformance.weekly_7d_sale_qty ||
                               originalSalesPerformance.weeklySales ||
                               0;
    const currentWeeklySales = currentData.sales["최근 7일 판매량"] || 0;
    console.log(`[${executionId}] 최근 7일 판매량 비교: 원본=${originalWeeklySales}, 현재=${currentWeeklySales}`);
    if (Math.abs(currentWeeklySales - originalWeeklySales) > 0.01) {
      detectedChanges["최근 7일 판매량"] = currentWeeklySales;
      console.log(`[${executionId}] 최근 7일 판매량 변경 감지: ${originalWeeklySales} → ${currentWeeklySales}`);
    }
    
    // ReorderInfo 변경사항 감지 - 다양한 구조 시도
    const originalReorderInfo = originalItem.reorder_info || originalItem.reorderInfo || originalItem;
    
    console.log(`[${executionId}] 원본 ReorderInfo 데이터:`, JSON.stringify(originalReorderInfo, null, 2));
    
    // 리드타임 비교
    const originalLeadTime = originalReorderInfo["리드타임(일)"] || 
                            originalReorderInfo.lead_time_days ||
                            originalReorderInfo.leadTime ||
                            0;
    const currentLeadTime = currentData.reorder["리드타임(일)"] || 0;
    console.log(`[${executionId}] 리드타임 비교: 원본=${originalLeadTime}, 현재=${currentLeadTime}`);
    if (Math.abs(currentLeadTime - originalLeadTime) > 0.01) {
      detectedChanges["리드타임(일)"] = currentLeadTime;
      console.log(`[${executionId}] 리드타임 변경 감지: ${originalLeadTime} → ${currentLeadTime}`);
    }
    
    // 판매 마감일 비교
    const originalSalesEndDate = originalReorderInfo["판매 마감일"] || 
                                originalReorderInfo.sales_end_date ||
                                originalReorderInfo.salesEndDate ||
                                "";
    const currentSalesEndDate = currentData.reorder["판매 마감일"] || "";
    console.log(`[${executionId}] 판매 마감일 비교: 원본="${originalSalesEndDate}", 현재="${currentSalesEndDate}"`);
    if (originalSalesEndDate !== currentSalesEndDate) {
      detectedChanges["판매 마감일"] = currentSalesEndDate;
      console.log(`[${executionId}] 판매 마감일 변경 감지: ${originalSalesEndDate} → ${currentSalesEndDate}`);
    }
    
    // 성장률 비교
    const originalGrowthRate = originalReorderInfo["성장률(%)"] || 
                              originalReorderInfo.growth_rate ||
                              originalReorderInfo.growthRate ||
                              0;
    const currentGrowthRate = currentData.reorder["성장률(%)"] || 0;
    console.log(`[${executionId}] 성장률 비교: 원본=${originalGrowthRate}, 현재=${currentGrowthRate}`);
    if (Math.abs(currentGrowthRate - originalGrowthRate) > 0.01) {
      detectedChanges["성장률(%)"] = currentGrowthRate;
      console.log(`[${executionId}] 성장률 변경 감지: ${originalGrowthRate} → ${currentGrowthRate}`);
    }
    
    // 목표 판매율 비교
    const originalTargetSaleRate = originalReorderInfo["목표 판매율(%)"] || 
                                  originalReorderInfo.target_sale_rate ||
                                  originalReorderInfo.targetSaleRate ||
                                  100;
    const currentTargetSaleRate = currentData.reorder["목표 판매율(%)"] || 100;
    console.log(`[${executionId}] 목표 판매율 비교: 원본=${originalTargetSaleRate}, 현재=${currentTargetSaleRate}`);
    if (Math.abs(currentTargetSaleRate - originalTargetSaleRate) > 0.01) {
      detectedChanges["목표 판매율(%)"] = currentTargetSaleRate;
      console.log(`[${executionId}] 목표 판매율 변경 감지: ${originalTargetSaleRate} → ${currentTargetSaleRate}`);
    }
    
    // MD 메모 비교
    const originalMdMemo = originalReorderInfo["MD 메모"] || 
                          originalReorderInfo.md_memo ||
                          originalReorderInfo.mdMemo ||
                          "";
    const currentMdMemo = currentData.reorder["MD 메모"] || "";
    console.log(`[${executionId}] MD 메모 비교: 원본="${originalMdMemo}", 현재="${currentMdMemo}"`);
    if (originalMdMemo !== currentMdMemo) {
      detectedChanges["MD 메모"] = currentMdMemo;
      console.log(`[${executionId}] MD 메모 변경 감지: "${originalMdMemo}" → "${currentMdMemo}"`);
    }
    
    console.log(`[${executionId}] 감지된 변경사항:`, JSON.stringify(detectedChanges, null, 2));
    console.log(`[${executionId}] 변경사항 개수: ${Object.keys(detectedChanges).length}`);
    
    // 6. 변경사항이 있다면 기존 changeset과 병합
    const allChanges = { ...productChangeset, ...salesChangeset, ...reorderChangeset, ...detectedChanges };
    
    console.log(`[${executionId}] 최종 변경사항:`, JSON.stringify(allChanges, null, 2));
    
    // 7. 변경사항이 없다면 사용자에게 안내
    if (Object.keys(allChanges).length === 0) {
      console.warn(`[${executionId}] 변경사항이 감지되지 않음`);
      
      return {
        success: false,
        message: "변경사항이 감지되지 않았습니다.\n\n해결 방법:\n1. Key-Value 컴포넌트에서 값을 수정해주세요\n2. 수정 후 Enter를 누르거나 다른 필드를 클릭하여 변경사항을 확정해주세요\n3. 저장 버튼을 다시 클릭해주세요\n\n※ GridView 환경에서는 changeset이 제대로 동작하지 않을 수 있습니다.\n※ 값을 수정했는데도 이 메시지가 나타난다면, 페이지를 새로고침하고 다시 시도해주세요.",
        executionId: executionId,
        debugInfo: {
          changesetNull: isProductChangesetNull && isSalesChangesetNull && isReorderChangesetNull,
          originalChangesetSize: Object.keys(productChangeset).length + Object.keys(salesChangeset).length + Object.keys(reorderChangeset).length,
          detectedChangesSize: Object.keys(detectedChanges).length,
          groupId: groupId,
          hasOriginalItem: !!originalItem
        }
      };
    }
    
    console.log(`[${executionId}] changeset 수집 완료 - 변경사항 ${Object.keys(allChanges).length}개`);
    
    return {
      success: true,
      changes: allChanges,
      groupId: groupId,
      detectionMethod: Object.keys(detectedChanges).length > 0 ? "데이터 비교" : "changeset"
    };
    
  } catch (error) {
    console.error(`[${executionId}] changeset 수집 중 오류:`, error);
    console.error(`[${executionId}] 오류 스택:`, error.stack);
    return {
      success: false,
      message: "변경사항 수집 중 오류 발생: " + error.message,
      executionId: executionId
    };
  }
}

// 변경사항 검증 및 파싱 함수
async function parseAndValidateChanges(changes, executionId) {
  console.log(`[${executionId}] 변경사항 검증 시작...`);
  
  try {
    const validatedChanges = {};
    
    // 안전한 숫자 변환 함수들
    const safeNumber = (val) => {
      if (val === null || val === undefined || val === '') return 0;
      const num = Number(val);
      return isNaN(num) ? 0 : num;
    };
    
    const formatDate = (dateStr) => {
      if (!dateStr) return '';
      const date = new Date(dateStr);
      if (isNaN(date.getTime())) return dateStr;
      return date.toISOString().split('T')[0];
    };
    
    // 각 변경사항 검증
    if ('리오더 원가' in changes) {
      const newCostPrice = parseFloat(changes['리오더 원가']);
      if (isNaN(newCostPrice) || newCostPrice <= 0) {
        console.error(`[${executionId}] 유효하지 않은 원가 값: ${changes['리오더 원가']}`);
        return { success: false, message: "유효하지 않은 원가 값입니다.", executionId: executionId };
      }
      validatedChanges.newCostPrice = newCostPrice;
      console.log(`[${executionId}] 원가 검증 완료: ${newCostPrice}`);
    }
    
    if ('리오더 TAG가' in changes) {
      const newTagPrice = parseFloat(changes['리오더 TAG가']);
      if (isNaN(newTagPrice) || newTagPrice <= 0) {
        console.error(`[${executionId}] 유효하지 않은 TAG가 값: ${changes['리오더 TAG가']}`);
        return { success: false, message: "유효하지 않은 판매가 값입니다.", executionId: executionId };
      }
      validatedChanges.newTagPrice = newTagPrice;
      console.log(`[${executionId}] TAG가 검증 완료: ${newTagPrice}`);
    }
    
    if ('최근 7일 판매량' in changes) {
      const newDailySales7d = parseFloat(changes['최근 7일 판매량']);
      if (isNaN(newDailySales7d) || newDailySales7d < 0) {
        console.error(`[${executionId}] 유효하지 않은 판매량 값: ${changes['최근 7일 판매량']}`);
        return { success: false, message: "유효하지 않은 판매량 값입니다.", executionId: executionId };
      }
      validatedChanges.newDailySales7d = newDailySales7d;
      console.log(`[${executionId}] 7일 판매량 검증 완료: ${newDailySales7d}`);
    }
    
    if ('기준일' in changes) {
      try {
        const newReferenceDate = formatDate(changes['기준일']);
        validatedChanges.newReferenceDate = newReferenceDate;
        console.log(`[${executionId}] 기준일 검증 완료: ${newReferenceDate}`);
      } catch (e) {
        console.error(`[${executionId}] 유효하지 않은 기준일: ${changes['기준일']}`);
        return { success: false, message: "유효하지 않은 기준일 형식입니다.", executionId: executionId };
      }
    }
    
    if ('리드타임(일)' in changes) {
      const newLeadTimeDays = parseInt(changes['리드타임(일)']);
      if (isNaN(newLeadTimeDays) || newLeadTimeDays <= 0) {
        console.error(`[${executionId}] 유효하지 않은 리드타임: ${changes['리드타임(일)']}`);
        return { success: false, message: "유효하지 않은 리드타임 값입니다.", executionId: executionId };
      }
      validatedChanges.newLeadTimeDays = newLeadTimeDays;
      console.log(`[${executionId}] 리드타임 검증 완료: ${newLeadTimeDays}`);
    }
    
    if ('판매 마감일' in changes) {
      try {
        const newSalesEndDate = formatDate(changes['판매 마감일']);
        validatedChanges.newSalesEndDate = newSalesEndDate;
        console.log(`[${executionId}] 판매 마감일 검증 완료: ${newSalesEndDate}`);
      } catch (e) {
        console.error(`[${executionId}] 유효하지 않은 판매 마감일: ${changes['판매 마감일']}`);
        return { success: false, message: "유효하지 않은 판매 마감일 형식입니다.", executionId: executionId };
      }
    }
    
    if ('성장률(%)' in changes) {
      const growthRatePercent = parseFloat(changes['성장률(%)']);
      if (isNaN(growthRatePercent) || growthRatePercent < 0) {
        console.error(`[${executionId}] 유효하지 않은 성장률: ${changes['성장률(%)']}`);
        return { success: false, message: "유효하지 않은 성장률 값입니다.", executionId: executionId };
      }
      validatedChanges.newGrowthRate = growthRatePercent / 100;
      console.log(`[${executionId}] 성장률 검증 완료: ${growthRatePercent}%`);
    }

    if ('목표 판매율(%)' in changes) {
      const targetSaleRatePercent = parseFloat(changes['목표 판매율(%)']);
      if (isNaN(targetSaleRatePercent) || targetSaleRatePercent < 0) {
        console.error(`[${executionId}] 유효하지 않은 목표 판매율: ${changes['목표 판매율(%)']}`);
        return { success: false, message: "유효하지 않은 목표 판매율 값입니다.", executionId: executionId };
      }
      validatedChanges.newTargetSaleRate = targetSaleRatePercent / 100;
      console.log(`[${executionId}] 목표 판매율 검증 완료: ${targetSaleRatePercent}%`);
    }

    if ('MD 메모' in changes) {
      validatedChanges.newMdMemo = changes['MD 메모'];
      console.log(`[${executionId}] MD 메모 검증 완료: ${changes['MD 메모']}`);
    }
    
    console.log(`[${executionId}] 변경사항 검증 완료`);
    
    return {
      success: true,
      validatedChanges: validatedChanges
    };
    
  } catch (error) {
    console.error(`[${executionId}] 변경사항 검증 중 오류:`, error);
    return {
      success: false,
      message: "변경사항 검증 중 오류 발생: " + error.message,
      executionId: executionId
    };
  }
}

// 아이템 업데이트 함수
async function updateSelectedItems(groupId, validatedChanges, executionId) {
  console.log(`[${executionId}] 아이템 업데이트 시작...`);
  
  try {
    const currentItems = selectedReorderItems.value || [];
    console.log(`[${executionId}] 현재 아이템 수: ${currentItems.length}`);
    
    const backupItems = JSON.parse(JSON.stringify(currentItems));
    console.log(`[${executionId}] 백업 생성 완료`);
    
    let itemFound = false;
    let updatedItemData = null;
    
    const updatedItems = currentItems.map(item => {
      // groupId 매칭 확인
      const itemGroupId = item.reorder_info?.groupId || 
                          item.reference_info?.groupId || 
                          item.production_info?.groupId || 
                          item.sales_performance?.groupId ||
                          `${item.reference_info?.sty_cd}_${item.reference_info?.col_cd}`;
      
      if (itemGroupId === groupId) {
        itemFound = true;
        console.log(`[${executionId}] 아이템 매칭됨: ${groupId}`);
        
        const updatedItem = { ...item };
        updatedItemData = processItemUpdate(updatedItem, validatedChanges, executionId);
        
        return updatedItemData;
      }
      
      return item;
    });
    
    if (!itemFound) {
      console.error(`[${executionId}] 매칭된 아이템 없음. 찾는 groupId: ${groupId}`);
      return { 
        success: false, 
        message: "수정할 아이템을 찾을 수 없습니다.",
        executionId: executionId
      };
    }
    
    // setValue를 비동기적으로 처리
    console.log(`[${executionId}] selectedReorderItems.setValue 실행 중...`);
    
    // setValue가 Promise를 반환하는지 확인하고 대기
    const setValueResult = selectedReorderItems.setValue(updatedItems);
    if (setValueResult && typeof setValueResult.then === 'function') {
      await setValueResult;
      console.log(`[${executionId}] setValue 비동기 완료`);
    } else {
      console.log(`[${executionId}] setValue 동기 완료`);
    }
    
    // 잠시 대기하여 상태 전파 보장
    await new Promise(resolve => setTimeout(resolve, 100));
    
    console.log(`[${executionId}] 아이템 업데이트 완료`);
    
    return {
      success: true,
      processedChanges: extractProcessedChanges(validatedChanges, updatedItemData)
    };
    
  } catch (error) {
    console.error(`[${executionId}] 아이템 업데이트 중 오류:`, error);
    return {
      success: false,
      message: "아이템 업데이트 중 오류 발생: " + error.message,
      executionId: executionId
    };
  }
}

// 아이템 업데이트 처리 함수 (기존 로직 유지)
function processItemUpdate(updatedItem, validatedChanges, executionId) {
  console.log(`[${executionId}] 아이템 업데이트 처리 시작...`);
  
  // 안전한 숫자 변환 함수들
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
  
  // 현재 값들 가져오기
  const currentCostPrice = validatedChanges.newCostPrice !== undefined ? validatedChanges.newCostPrice : safeNumber(updatedItem.production_info?.["리오더 원가"]);
  const currentTagPrice = validatedChanges.newTagPrice !== undefined ? validatedChanges.newTagPrice : safeNumber(updatedItem.production_info?.["리오더 TAG가"]);
  const currentReferenceDate = validatedChanges.newReferenceDate || updatedItem.sales_performance?.["기준일"] || formatDate(new Date());
  const currentLeadTimeDays = validatedChanges.newLeadTimeDays !== undefined ? validatedChanges.newLeadTimeDays : safeNumber(updatedItem.reorder_info?.["리드타임(일)"]);
  const currentSalesEndDate = validatedChanges.newSalesEndDate || updatedItem.reorder_info?.["판매 마감일"] || '';
  const currentGrowthRate = validatedChanges.newGrowthRate !== undefined ? validatedChanges.newGrowthRate : (safeNumber(updatedItem.reorder_info?.["성장률(%)"]) / 100);
  const currentDailySales7d = validatedChanges.newDailySales7d !== undefined ? validatedChanges.newDailySales7d : safeNumber(updatedItem.sales_performance?.["최근 7일 판매량"]);
  const currentTargetSaleRate = validatedChanges.newTargetSaleRate !== undefined ? validatedChanges.newTargetSaleRate : (safeNumber(updatedItem.reorder_info?.["목표 판매율(%)"]) / 100);
  const currentMdMemo = validatedChanges.newMdMemo !== undefined ? validatedChanges.newMdMemo : (updatedItem.reorder_info?.["MD 메모"] || '');
  
  console.log(`[${executionId}] 현재 값들 - 원가: ${currentCostPrice}, TAG가: ${currentTagPrice}, 성장률: ${currentGrowthRate}`);
  
  // 배수 계산
  let newMultiple = 0;
  try {
    newMultiple = currentTagPrice > 0 && currentCostPrice > 0 ? 
      Number((currentTagPrice / currentCostPrice / 1.1).toFixed(2)) : 0;
    console.log(`[${executionId}] 계산된 배수: ${newMultiple}`);
  } catch (e) {
    console.warn(`[${executionId}] 배수 계산 오류: ${e.message}`);
    newMultiple = 0;
  }
  
  // 1. TAG가 및 원가 업데이트
  if (updatedItem.production_info) {
    if (validatedChanges.newCostPrice !== undefined) {
      updatedItem.production_info["리오더 원가"] = safeInteger(validatedChanges.newCostPrice);
      console.log(`[${executionId}] 원가 업데이트 완료: ${safeInteger(validatedChanges.newCostPrice)}`);
    }
    
    if (validatedChanges.newTagPrice !== undefined) {
      updatedItem.production_info["리오더 TAG가"] = safeInteger(validatedChanges.newTagPrice);
      console.log(`[${executionId}] TAG가 업데이트 완료: ${safeInteger(validatedChanges.newTagPrice)}`);
    }
    
    updatedItem.production_info["리오더 배수"] = newMultiple;
    updatedItem.price_multiple = newMultiple;
    updatedItem.priceReorderMultiple = newMultiple;
    console.log(`[${executionId}] 배수 업데이트 완료: ${newMultiple}`);
  }
  
  // 2. 판매 실적 업데이트
  if (updatedItem.sales_performance) {
    if (validatedChanges.newReferenceDate) {
      const oldReferenceDate = updatedItem.sales_performance["기준일"] || '';
      
      updatedItem.sales_performance["기준일"] = validatedChanges.newReferenceDate;
      
      // 출고일 가져오기
      const firstOutboundDate = updatedItem.production_info?.["출고일"] || '';
      if (firstOutboundDate) {
        const salesPeriod = getDaysDifference(firstOutboundDate, validatedChanges.newReferenceDate);
        updatedItem.sales_performance["출고~기준일 판매일수"] = salesPeriod;
        console.log(`[${executionId}] 기준일 변경에 따른 판매일수 업데이트: ${salesPeriod}일`);
      }

      const weeklySales = safeNumber(updatedItem.sales_performance?.["최근 7일 판매량"]);
      const dailySales = weeklySales / 7;
      updatedItem.sales_performance["일 판매량"] = Number(dailySales.toFixed(1));
      
      const shopCount = safeNumber(updatedItem.sales_performance["매장수"]);
      if (shopCount > 0) {
        updatedItem.sales_performance["매장당 일 판매량"] = Number((dailySales / shopCount).toFixed(2));
      }
      console.log(`[${executionId}] 일 판매량 재계산(최근 7일 기준): ${Number(dailySales.toFixed(1))}`);
      
      updatedItem._reorderInfoNeedsUpdate = true;
      console.log(`[${executionId}] 기준일 업데이트 완료: ${validatedChanges.newReferenceDate} (이전: ${oldReferenceDate})`);
    }
    
    if (validatedChanges.newDailySales7d !== undefined) {
      updatedItem.sales_performance["최근 7일 판매량"] = safeInteger(validatedChanges.newDailySales7d);
      
      const shopCount = safeNumber(updatedItem.sales_performance["매장수"]);
      
      if (shopCount > 0) {
        const dailyAvgSales = validatedChanges.newDailySales7d / 7;
        const shopDailySales = dailyAvgSales / shopCount;
        updatedItem.sales_performance["일 판매량"] = Number(dailyAvgSales.toFixed(1));
        updatedItem.sales_performance["매장당 일 판매량"] = Number(shopDailySales.toFixed(2));
        
        const totOutQty = safeNumber(updatedItem.production_info?.["출고 수량"]);
        if (totOutQty > 0) {
          const salesRateD7 = validatedChanges.newDailySales7d / totOutQty;
          updatedItem.sales_performance["최근 7일 판매율(출고 기준)"] = Number(salesRateD7.toFixed(4));
        }
      }
      
      console.log(`[${executionId}] 최근 7일 판매량 업데이트 완료: ${safeInteger(validatedChanges.newDailySales7d)}`);
    }
  }
  
  // 3. 리오더 정보 업데이트
  if (updatedItem.reorder_info) {
    let reorderInfoChanged = false;
    
    if (validatedChanges.newLeadTimeDays !== undefined) {
      updatedItem.reorder_info["리드타임(일)"] = safeInteger(validatedChanges.newLeadTimeDays);
      reorderInfoChanged = true;
      console.log(`[${executionId}] 리드타임 업데이트 완료: ${safeInteger(validatedChanges.newLeadTimeDays)}`);
    }
    
    if (validatedChanges.newSalesEndDate) {
      updatedItem.reorder_info["판매 마감일"] = validatedChanges.newSalesEndDate;
      reorderInfoChanged = true;
      console.log(`[${executionId}] 판매 마감일 업데이트 완료: ${validatedChanges.newSalesEndDate}`);
    }
    
    if (validatedChanges.newGrowthRate !== undefined) {
      updatedItem.reorder_info["성장률(%)"] = safeInteger(validatedChanges.newGrowthRate * 100);
      reorderInfoChanged = true;
      console.log(`[${executionId}] 성장률 업데이트 완료: ${safeInteger(validatedChanges.newGrowthRate * 100)}%`);
    }

    if (validatedChanges.newTargetSaleRate !== undefined) {
      updatedItem.reorder_info["목표 판매율(%)"] = safeInteger(validatedChanges.newTargetSaleRate * 100);
      reorderInfoChanged = true;
      console.log(`[${executionId}] 목표 판매율 업데이트 완료: ${safeInteger(validatedChanges.newTargetSaleRate * 100)}%`);
    }

    if (validatedChanges.newMdMemo !== undefined) {
      updatedItem.reorder_info["MD 메모"] = validatedChanges.newMdMemo;
      reorderInfoChanged = true;
      console.log(`[${executionId}] MD 메모 업데이트 완료: ${validatedChanges.newMdMemo}`);
    }
    
    // 리오더 정보가 변경되었거나 관련 필드가 변경된 경우
    if (reorderInfoChanged || validatedChanges.newReferenceDate || validatedChanges.newDailySales7d !== undefined || updatedItem._reorderInfoNeedsUpdate) {
      console.log(`[${executionId}] 리오더 계산 업데이트 시작...`);
      
      const reorderInboundDate = (() => {
        const date = new Date(currentReferenceDate);
        date.setDate(date.getDate() + currentLeadTimeDays);
        return formatDate(date);
      })();
      updatedItem.reorder_info["리오더 납기일"] = reorderInboundDate;
      console.log(`[${executionId}] 리오더 납기일 계산: ${reorderInboundDate}`);
      
      const daysUntilSalesEnd = currentSalesEndDate ? getDaysDifference(currentReferenceDate, currentSalesEndDate) : 90;
      updatedItem.reorder_info["기준일~판매 마감일"] = safeInteger(daysUntilSalesEnd);
      updatedItem.expected_sales_period = safeInteger(daysUntilSalesEnd);
      console.log(`[${executionId}] 판매마감까지 남은 일수 계산: ${daysUntilSalesEnd}일`);
      
      const salesEndToReorderInboundDays = currentSalesEndDate ? getDaysDifference(reorderInboundDate, currentSalesEndDate) : 0;
      updatedItem.reorder_info["리오더 납기일~판매 마감일"] = safeInteger(salesEndToReorderInboundDays);
      console.log(`[${executionId}] 리오더 입고 후 판매 가능일수 계산: ${salesEndToReorderInboundDays}일`);
      
      const shopCount = safeNumber(updatedItem.sales_performance?.["매장수"]);
      const dailySales = currentDailySales7d / 7;
      const shopDailySales = shopCount > 0 ? dailySales / shopCount : 0;
      
      const shouldApplyGrowthRate = validatedChanges.newGrowthRate !== undefined;
      const growthRateFactor = shouldApplyGrowthRate ? (1 + currentGrowthRate) : 1;
      const expectedSales = daysUntilSalesEnd * shopCount * shopDailySales * growthRateFactor;
      updatedItem.reorder_info["기준일~마감일 예상 판매량"] = safeInteger(expectedSales);
      updatedItem.expected_sales_full_period = safeInteger(expectedSales);
      console.log(`[${executionId}] 예상 판매량 계산: ${safeInteger(expectedSales)}`);
      
      const totalStock = safeNumber(updatedItem.production_info?.["매장재고"]) + 
                         safeNumber(updatedItem.production_info?.["창고재고"]);
      updatedItem.reorder_info["현재 총재고"] = safeInteger(totalStock);
      
      const shortageSales = Math.max(0, expectedSales - totalStock);
      updatedItem.reorder_info["부족 수량"] = safeInteger(shortageSales);
      updatedItem.shortage_qty = safeInteger(shortageSales);
      console.log(`[${executionId}] 부족 수량 계산: ${safeInteger(shortageSales)}`);
      
      const targetSaleRate = currentTargetSaleRate || 1.0; // 기본값
      const reorderRequiredQty = shortageSales > 0 ? shortageSales / targetSaleRate : 0;
      updatedItem.reorder_info["리오더 필요 수량"] = safeInteger(reorderRequiredQty);
      const reorderFinalQty = Math.ceil(reorderRequiredQty / 10) * 10;
      
      updatedItem.recommended_reorder_qty = safeInteger(reorderRequiredQty);
      updatedItem.final_reorder_qty = safeInteger(reorderFinalQty);
      updatedItem.finalReorderQty = safeInteger(reorderFinalQty);
      updatedItem.expectedSupplyQty = safeInteger(shortageSales);
      console.log(`[${executionId}] 최종 리오더 수량 계산: ${safeInteger(reorderFinalQty)}`);
      
      const expectedSalesDuringLeadTime = shopDailySales * shopCount * currentLeadTimeDays * growthRateFactor;
      updatedItem.expected_sales_during_lead_time = safeInteger(expectedSalesDuringLeadTime);
      updatedItem.expected_sales = safeInteger(expectedSalesDuringLeadTime);
      updatedItem.expectedSalesQty = safeInteger(expectedSalesDuringLeadTime);
      console.log(`[${executionId}] 리드타임 동안 예상 판매량 계산: ${safeInteger(expectedSalesDuringLeadTime)}`);
      
      const leadTimeShortageQty = Math.max(0, expectedSalesDuringLeadTime - totalStock);
      updatedItem.lead_time_shortage_qty = safeInteger(leadTimeShortageQty);
      
      const leadTimeRecommendedReorderQty = leadTimeShortageQty > 0 ? leadTimeShortageQty / targetSaleRate : 0;
      updatedItem.lead_time_recommended_reorder_qty = safeInteger(leadTimeRecommendedReorderQty);
      
      const leadTimeFinalReorderQty = Math.ceil(leadTimeRecommendedReorderQty / 10) * 10;
      updatedItem.lead_time_final_reorder_qty = safeInteger(leadTimeFinalReorderQty);
      
      // 사이즈별 리오더 정보 업데이트
      if (updatedItem.size_reorder_info && Array.isArray(updatedItem.size_reorder_info)) {
        console.log(`[${executionId}] 사이즈별 리오더 정보 업데이트 중...`);
        
        const totalSizeOutQty = updatedItem.size_reorder_info.reduce((sum, size) => 
          sum + safeNumber(size.size_out_count), 0) || 1;
        
        updatedItem.size_reorder_info = updatedItem.size_reorder_info.map(sizeInfo => {
          const sizeOutQty = safeNumber(sizeInfo.size_out_count);
          const sizeRatio = totalSizeOutQty > 0 ? sizeOutQty / totalSizeOutQty : 0;
          
          // 사이즈별 일 판매량 계산
          const sizeDailySales = dailySales * sizeRatio;
          
          // 사이즈별 예상 판매량 계산
          const sizeExpectedSales = daysUntilSalesEnd * shopCount * (sizeDailySales / shopCount) * growthRateFactor;

          // 사이즈별 부족 수량 계산
          const sizeStock = safeNumber(sizeInfo.total_stock);
          const sizeShortageQty = Math.max(0, sizeExpectedSales - sizeStock);
          
          // 사이즈별 리오더 수량 (전체 리오더 수량 * 사이즈 비율)
          const sizeReorderQty = Math.ceil(reorderFinalQty * sizeRatio / 10) * 10;
          
          return {
            ...sizeInfo,
            reorder_qty: safeInteger(sizeReorderQty),
            growth_rate: safeInteger(currentGrowthRate * 100),
            days_until_sales_end: safeInteger(daysUntilSalesEnd),
            expected_sales: safeInteger(sizeExpectedSales),
            shortage_qty: safeInteger(sizeShortageQty)
          };
        });
        
        console.log(`[${executionId}] 사이즈별 리오더 정보 업데이트 완료: ${updatedItem.size_reorder_info.length}개 사이즈`);
      }
      
      updatedItem._reorderInfoNeedsUpdate = false;
    }
  }
  
  console.log(`[${executionId}] 아이템 업데이트 처리 완료`);
  
  return updatedItem;
}

// 변경사항 추출 함수
function extractProcessedChanges(validatedChanges, updatedItemData) {
  const changesProcessed = {
    productInfo: {}
  };
  
  if (validatedChanges.newCostPrice !== undefined) {
    changesProcessed.productInfo.reorderCostPrice = validatedChanges.newCostPrice;
  }
  
  if (validatedChanges.newTagPrice !== undefined) {
    changesProcessed.productInfo.reorderTagPrice = validatedChanges.newTagPrice;
  }
  
  if (validatedChanges.newDailySales7d !== undefined) {
    changesProcessed.productInfo.weekly7dSaleQty = validatedChanges.newDailySales7d;
    changesProcessed.productInfo.dailyAvgSales = validatedChanges.newDailySales7d / 7;
  }
  
  if (validatedChanges.newReferenceDate) {
    changesProcessed.productInfo.referenceDate = validatedChanges.newReferenceDate;
  }
  
  if (validatedChanges.newLeadTimeDays !== undefined) {
    changesProcessed.productInfo.leadTimeDays = validatedChanges.newLeadTimeDays;
  }
  
  if (validatedChanges.newSalesEndDate) {
    changesProcessed.productInfo.salesEndDate = validatedChanges.newSalesEndDate;
  }
  
  if (validatedChanges.newGrowthRate !== undefined) {
    changesProcessed.productInfo.growthRate = validatedChanges.newGrowthRate * 100;
  }

  if (validatedChanges.newMdMemo !== undefined) {
    changesProcessed.productInfo.mdMemo = validatedChanges.newMdMemo;
  }
  
  return changesProcessed;
}

// changeset 초기화 함수
async function clearAllChangesets(executionId) {
  console.log(`[${executionId}] changeset 초기화 중...`);
  
  try {
    // 모든 컴포넌트의 changeset 초기화
    const clearPromises = [];
    
    if (keyValueProductInfo && typeof keyValueProductInfo.clearChangeset === 'function') {
      clearPromises.push(
        Promise.resolve(keyValueProductInfo.clearChangeset())
          .then(() => console.log(`[${executionId}] ProductInfo changeset 초기화 완료`))
          .catch(err => console.warn(`[${executionId}] ProductInfo changeset 초기화 실패:`, err))
      );
    }
    
    if (keyValueSalesPerformance && typeof keyValueSalesPerformance.clearChangeset === 'function') {
      clearPromises.push(
        Promise.resolve(keyValueSalesPerformance.clearChangeset())
          .then(() => console.log(`[${executionId}] SalesPerformance changeset 초기화 완료`))
          .catch(err => console.warn(`[${executionId}] SalesPerformance changeset 초기화 실패:`, err))
      );
    }
    
    if (keyValueReorderInfo && typeof keyValueReorderInfo.clearChangeset === 'function') {
      clearPromises.push(
        Promise.resolve(keyValueReorderInfo.clearChangeset())
          .then(() => console.log(`[${executionId}] ReorderInfo changeset 초기화 완료`))
          .catch(err => console.warn(`[${executionId}] ReorderInfo changeset 초기화 실패:`, err))
      );
    }
    
    // 모든 초기화 작업 대기
    await Promise.all(clearPromises);
    
    // 추가 대기 시간으로 상태 전파 보장
    await new Promise(resolve => setTimeout(resolve, 50));
    
    console.log(`[${executionId}] 모든 changeset 초기화 완료`);
    
  } catch (error) {
    console.warn(`[${executionId}] changeset 초기화 중 오류:`, error);
  }
}

// 메인 함수 실행
return processSaveColorEdits();