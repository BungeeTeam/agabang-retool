function filterOutDiscontinuedItemsAndReorderHistoryItems() {
  console.log("===== filterOutDiscontinuedItemsAndReorderHistoryItems 함수 시작 =====");

  // --- 헬퍼 함수: col_cd를 01, 02 형식으로 패딩 ---
  function padColCd(colCd) {
    if (typeof colCd !== 'string') {
      colCd = String(colCd); // 숫자인 경우 문자열로 변환
    }
    const trimmedColCd = colCd.trim();
    // 한 자리 숫자인 경우에만 앞에 '0'을 붙임 (예: "1" -> "01")
    if (trimmedColCd.length === 1 && /^\d$/.test(trimmedColCd)) {
      // console.log(`  DEBUG: col_cd 패딩 '${trimmedColCd}' -> '0${trimmedColCd}'`); // 필요시 활성화하여 디버그
      return '0' + trimmedColCd;
    }
    return trimmedColCd; // 그 외의 경우 (이미 두 자리 이상이거나 숫자가 아닌 경우)는 그대로 반환
  }

  // 쿼리 결과 가져오기 및 배열로 강제 변환
  const allItems = Array.isArray(get_item_list.data) ? get_item_list.data : [];
  const discontinuedItems = Array.isArray(get_discontinued_products.data) ? get_discontinued_products.data : [];
  const reorderHistoryItems = Array.isArray(get_reorder_history.data) ? get_reorder_history.data : [];
  const seriesInfo = Array.isArray(get_series_names.data) ? get_series_names.data : [];

  console.log(`초기 데이터 로드:`);
  console.log(`  allItems.length: ${allItems.length}`);
  console.log(`  discontinuedItems.length: ${discontinuedItems.length}`);
  console.log(`  reorderHistoryItems.length: ${reorderHistoryItems.length}`);
  console.log(`  seriesInfo.length: ${seriesInfo.length}`);

  // 데이터 유효성 검사
  if (allItems.length === 0) {
    console.warn("get_item_list 결과가 비어있습니다. 빈 배열을 반환합니다.");
    console.log("===== filterOutDiscontinuedItemsAndReorderHistoryItems 함수 종료 =====");
    return [];
  }

  // 원본 데이터 샘플 확인 (각 쿼리 결과의 처음 2개 항목)
  console.log("--- 원본 데이터 샘플 (첫 2개) ---");
  console.log("allItems[0,1]:", allItems.slice(0, 2));
  console.log("discontinuedItems[0,1]:", discontinuedItems.slice(0, 2));
  console.log("reorderHistoryItems[0,1]:", reorderHistoryItems.slice(0, 2));
  console.log("seriesInfo[0,1]:", seriesInfo.slice(0, 2));


  // --- 1. 시리즈명 정보 매핑 ---
  console.log("--- 1. 시리즈명 매핑 시작 ---");
  const seriesMap = {};
  seriesInfo.forEach(item => {
    if (item && item.sty_cd) {
      seriesMap[String(item.sty_cd).trim()] = item.series_name;
    }
  });
  console.log(`seriesMap 크기: ${Object.keys(seriesMap).length}`);
  // console.log("seriesMap 샘플:", Object.entries(seriesMap).slice(0, 5)); // 필요시 활성화
  console.log("--- 1. 시리즈명 매핑 완료 ---");

  // --- 2. 단종 상품 조합 Set 생성 (첫 번째 필터 기준) ---
  console.log("--- 2. 단종 상품 조합 Set 생성 시작 (col_cd 패딩 적용) ---");
  const discontinuedCombinations = new Set();
  discontinuedItems.forEach(item => {
    if (item && item.sty_cd && item.col_cd) {
      const paddedColCd = padColCd(item.col_cd);
      const key = `${String(item.sty_cd).trim()}|${paddedColCd}`;
      discontinuedCombinations.add(key);
      // console.log(`  단종조합 추가: ${key}`); // 필요시 활성화하여 어떤 조합이 추가되는지 확인
    }
  });
  console.log(`생성된 단종 상품 필터링 조합 수 (discontinuedCombinations.size): ${discontinuedCombinations.size}`);
  console.log("--- 2. 단종 상품 조합 Set 생성 완료 ---");

  // --- 3. get_item_list에서 단종 상품 필터링 (첫 번째 필터 적용) ---
  console.log("--- 3. 단종 상품 필터링 시작 (첫 번째 필터) ---");
  let itemsAfterDiscontinuedFilter = allItems; // 원본 아이템 리스트로 시작

  if (discontinuedCombinations.size > 0) {
    const filteredCount = 0; // 필터링될 아이템 카운트 (디버깅용)
    itemsAfterDiscontinuedFilter = allItems.filter(item => {
      if (!item || !item.sty_cd || !item.col_cd) {
        // console.log(`  단종필터링: 유효하지 않은 아이템 스킵`, item); // 필요시 활성화
        return false; // 유효하지 않은 아이템은 필터링
      }
      const paddedColCd = padColCd(item.col_cd);
      const key = `${String(item.sty_cd).trim()}|${paddedColCd}`;
      const isDiscontinued = discontinuedCombinations.has(key);
      // if (isDiscontinued) {
      //   console.log(`  단종 필터링: 제외됨 (단종조합 일치) - ${key}`); // 필요시 활성화
      // }
      return !isDiscontinued; // 단종 조합에 포함되면 제외
    });
    // console.log(`  단종 필터링으로 제외된 아이템 수: ${allItems.length - itemsAfterDiscontinuedFilter.length}`); // 필요시 활성화
  } else {
    console.log("단종 상품 조합이 없어, 첫 번째 필터링(단종 상품)을 건너뜜니다.");
  }
  console.log(`단종 상품 필터링 후 아이템 수 (itemsAfterDiscontinuedFilter.length): ${itemsAfterDiscontinuedFilter.length}`);
  console.log("--- 3. 단종 상품 필터링 완료 ---");

  // --- 4. get_reorder_history 조합 Set 생성 (두 번째 필터 기준) ---
  console.log("--- 4. 리오더 히스토리 조합 Set 생성 시작 (col_cd 패딩 및 exclude_at_reorder_target_list: true 적용) ---");
  const reorderHistoryCombinations = new Set();
  let itemsWithExcludeTrueCount = 0; // `exclude_at_reorder_target_list: true`인 아이템 수 (디버깅용)

  reorderHistoryItems.forEach(item => {
    // `exclude_at_reorder_target_list`가 true인 경우에만 조합에 추가
    if (item && item.sty_cd && item.col_cd && item.exclude_at_reorder_target_list === true) {
      const paddedColCd = padColCd(item.col_cd);
      const key = `${String(item.sty_cd).trim()}|${paddedColCd}`;
      reorderHistoryCombinations.add(key);
      itemsWithExcludeTrueCount++;
      // console.log(`  리오더히스토리조합 추가 (exclude: true): ${key}`); // 필요시 활성화
    } else {
      // if (item && item.sty_cd && item.col_cd) {
      //   console.log(`  리오더히스토리조합 스킵 (exclude: false 또는 없음): ${String(item.sty_cd).trim()}|${padColCd(item.col_cd)}`); // 필요시 활성화
      // } else {
      //   console.log(`  리오더히스토리조합 스킵 (유효하지 않은 아이템):`, item); // 필요시 활성화
      // }
    }
  });
  console.log(`원본 리오더 히스토리 중 'exclude_at_reorder_target_list: true'인 항목 수: ${itemsWithExcludeTrueCount}`);
  console.log(`생성된 리오더 히스토리 필터링 조합 수 (reorderHistoryCombinations.size): ${reorderHistoryCombinations.size}`);
  console.log("--- 4. 리오더 히스토리 조합 Set 생성 완료 ---");

  // --- 5. 단종 필터링된 결과에서 리오더 히스토리 필터링 (두 번째 필터 적용) ---
  console.log("--- 5. 리오더 히스토리 필터링 시작 (두 번째 필터) ---");
  let finalFilteredItems = itemsAfterDiscontinuedFilter; // 첫 번째 필터 결과로 시작

  if (reorderHistoryCombinations.size > 0) {
    finalFilteredItems = itemsAfterDiscontinuedFilter.filter(item => {
      if (!item || !item.sty_cd || !item.col_cd) {
        // console.log(`  리오더필터링: 유효하지 않은 아이템 스킵`, item); // 필요시 활성화
        return false; // 유효하지 않은 아이템은 필터링
      }
      const paddedColCd = padColCd(item.col_cd);
      const key = `${String(item.sty_cd).trim()}|${paddedColCd}`;
      const isInReorderHistory = reorderHistoryCombinations.has(key);
      // if (isInReorderHistory) {
      //   console.log(`  리오더 필터링: 제외됨 (히스토리 조합 일치) - ${key}`); // 필요시 활성화
      // }
      return !isInReorderHistory; // 리오더 히스토리 조합에 포함되면 제외
    });
    // console.log(`  리오더 히스토리 필터링으로 제외된 아이템 수: ${itemsAfterDiscontinuedFilter.length - finalFilteredItems.length}`); // 필요시 활성화
  } else {
    console.log("리오더 히스토리 조합이 없어, 두 번째 필터링(히스토리)을 건너뜁니다.");
  }
  console.log(`최종 필터링 후 아이템 수 (finalFilteredItems.length): ${finalFilteredItems.length}`);
  console.log("--- 5. 리오더 히스토리 필터링 완료 ---");

  // --- 6. 최종 결과에 시리즈명 추가 ---
  console.log("--- 6. 최종 결과에 시리즈명 추가 시작 ---");
  const resultItems = finalFilteredItems.map(item => {
    if (!item || !item.sty_cd) {
      return item;
    }
    const styCdKey = String(item.sty_cd).trim();
    return {
      ...item,
      series_name: seriesMap[styCdKey] || null
    };
  });
  console.log("--- 6. 최종 결과에 시리즈명 추가 완료 ---");

  console.log(`--- 최종 결과 아이템 수: ${resultItems.length} ---`);

  // --- 최종 결과 요약 로그 ---
  const totalFilteredCount = allItems.length - resultItems.length;
  if (totalFilteredCount > 0) {
    console.info(`${totalFilteredCount}개의 아이템이 필터링되어 최종 ${resultItems.length}개가 남았습니다.`);
  } else if (resultItems.length === allItems.length) {
    console.info("필터링된 아이템이 없거나, 필터링할 조합이 없었습니다. (모든 allItems 유지)");
  } else if (resultItems.length < allItems.length) {
     console.info(`알 수 없는 필터링 상태: ${allItems.length} -> ${resultItems.length}. 차이: ${totalFilteredCount}`);
  }


  console.log("===== filterOutDiscontinuedItemsAndReorderHistoryItems 함수 종료 =====");
  return resultItems;
}

// 함수 실행 및 결과 반환
return filterOutDiscontinuedItemsAndReorderHistoryItems();