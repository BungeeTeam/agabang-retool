function filterOutDiscontinuedItemsAndReorderHistoryItems() {
  // --- 헬퍼 함수: col_cd를 01, 02 형식으로 패딩 ---
  function padColCd(colCd) {
    if (typeof colCd !== 'string') {
      colCd = String(colCd); // 숫자인 경우 문자열로 변환
    }
    const trimmedColCd = colCd.trim();
    // 한 자리 숫자인 경우에만 앞에 '0'을 붙임 (예: "1" -> "01")
    if (trimmedColCd.length === 1 && /^\d$/.test(trimmedColCd)) {
      return '0' + trimmedColCd;
    }
    return trimmedColCd; // 그 외의 경우 (이미 두 자리 이상이거나 숫자가 아닌 경우)는 그대로 반환
  }

  // 쿼리 결과 가져오기
  const allItems = get_item_list.data || [];
  const discontinuedItems = get_discontinued_products.data || [];
  const reorderHistoryItems = get_reorder_history.data || [];
  const seriesInfo = get_series_names.data || [];

  // 데이터 유효성 검사
  if (allItems.length === 0) {
    return [];
  }

  // --- 1. 시리즈명 정보 매핑 ---
  const seriesMap = {};
  seriesInfo.forEach(item => {
    if (item && item.sty_cd) {
      seriesMap[String(item.sty_cd).trim()] = item.series_name;
    }
  });

  // --- 2. 단종 상품 조합 Set 생성 (첫 번째 필터 기준) ---
  const discontinuedCombinations = new Set();
  discontinuedItems.forEach(item => {
    if (item && item.sty_cd && item.col_cd) {
      const paddedColCd = padColCd(item.col_cd);
      const key = `${String(item.sty_cd).trim()}|${paddedColCd}`;
      discontinuedCombinations.add(key);
    }
  });

  // --- 3. get_item_list에서 단종 상품 필터링 (첫 번째 필터 적용) ---
  let itemsAfterDiscontinuedFilter = allItems;
  if (discontinuedCombinations.size > 0) {
    itemsAfterDiscontinuedFilter = allItems.filter(item => {
      if (!item || !item.sty_cd || !item.col_cd) return false;
      const paddedColCd = padColCd(item.col_cd);
      const key = `${String(item.sty_cd).trim()}|${paddedColCd}`;
      return !discontinuedCombinations.has(key);
    });
  }

  // --- 4. get_reorder_history 조합 Set 생성 (두 번째 필터 기준) ---
  const reorderHistoryCombinations = new Set();
  reorderHistoryItems.forEach(item => {
    // exclude_at_reorder_target_list가 true인 경우에만 조합에 추가
    if (item && item.sty_cd && item.col_cd && item.exclude_at_reorder_target_list === true) {
      const paddedColCd = padColCd(item.col_cd);
      const key = `${String(item.sty_cd).trim()}|${paddedColCd}`;
      reorderHistoryCombinations.add(key);
    }
  });

  // --- 5. 단종 필터링된 결과에서 리오더 히스토리 필터링 (두 번째 필터 적용) ---
  let finalFilteredItems = itemsAfterDiscontinuedFilter; // 첫 번째 필터 결과로 시작
  if (reorderHistoryCombinations.size > 0) {
    finalFilteredItems = itemsAfterDiscontinuedFilter.filter(item => {
      if (!item || !item.sty_cd || !item.col_cd) return false;
      const paddedColCd = padColCd(item.col_cd);
      const key = `${String(item.sty_cd).trim()}|${paddedColCd}`;
      return !reorderHistoryCombinations.has(key);
    });
  }

  // --- 6. 최종 결과에 시리즈명 추가 ---
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

  return resultItems;
}

// 함수 실행 및 결과 반환
return filterOutDiscontinuedItemsAndReorderHistoryItems();