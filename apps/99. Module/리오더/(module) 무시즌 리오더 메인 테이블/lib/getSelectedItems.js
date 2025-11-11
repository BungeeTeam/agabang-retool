// getSelectedItems.js
function getSelectedItems() {
  // 날짜 포맷팅 함수 - 코드 상단으로 이동
  const formatDate = (dateStr) => {
    if (!dateStr) return '';
    
    const date = new Date(dateStr);
    if (isNaN(date.getTime())) return dateStr; // 유효하지 않은 날짜는 원본 문자열 반환
    
    return date.toISOString().split('T')[0]; // YYYY-MM-DD 형식
  };

  // 원본 데이터 가져오기
  const colorListData = tempTableData.value || [];
  
  // 데이터 로깅
  console.log("[getSelectedItems] getColorList 데이터 길이:", colorListData.length);
  
  // 사용자가 선택한 컬러(헤더) 리스트 가져오기
  const selectedKeys = (table_main_list.selectedRows || []).map(row => ({
    sty_cd: row.sty_cd,
    col_cd: row.col_cd
  }));
  
  // 선택된 헤더만 추출
  const selectedColorHeaderRows = colorListData.filter(
    item => item._type === 'header' &&
      selectedKeys.some(sel => sel.sty_cd === item.sty_cd && sel.col_cd === item.col_cd)
  );
  
  // 데이터 로깅
  console.log("[getSelectedItems] 선택된 컬러 수:", selectedColorHeaderRows.length);
  
  // 기준일 설정 (오늘 날짜 또는 입력값)
  const referenceDate = inputReferenceDate.value ? formatDate(inputReferenceDate.value) : formatDate(new Date());
  
  // 판매 마감 기준일 설정
  const salesEndDate = inputSalesEndDate.value ? formatDate(inputSalesEndDate.value) : '';
  
  // 리드타임 기본값 설정 (기본 50일)
  const defaultLeadTime = 50;
  
  // 성장률 기본값 설정 (100%)
  const defaultGrowthRate = 1.0;
  
  // 매장 수 기본값 설정 (120개)
  const defaultShopCount = 120;
  
  // 안전한 숫자 변환 함수
  const safeNumber = (val) => {
    if (val === null || val === undefined || val === '') return 0;
    const num = Number(val);
    return isNaN(num) ? 0 : num;
  };
  
  // 정수로 변환하는 함수 (수량 관련 필드용)
  const safeInteger = (val) => {
    return Math.round(safeNumber(val));
  };
  
  // 날짜 차이 계산 함수 (일 단위)
  const getDaysDifference = (startDateStr, endDateStr) => {
    if (!startDateStr || !endDateStr) return 0;
    
    const start = new Date(startDateStr);
    const end = new Date(endDateStr);
    
    if (isNaN(start.getTime()) || isNaN(end.getTime())) return 0;
    
    // 차이 계산 (밀리초 -> 일) + 1 (당일 포함)
    return Math.floor((end - start) / (1000 * 60 * 60 * 24)) + 1;
  };

  // 매장 수 가져오기 (get_item_list 데이터에서 첫 아이템의 active_shop_count 사용 또는 기본값 120 사용)
  const getShopCount = () => {
    try {
      // get_item_list.data가 배열이므로 첫 번째 요소의 active_shop_count 가져오기
      if (get_item_list.data && get_item_list.data.length > 0) {
        return safeNumber(get_item_list.data[0].active_shop_count) || defaultShopCount;
      }
      return defaultShopCount;
    } catch (error) {
      console.error("[getSelectedItems] 매장 수 조회 오류:", error);
      return defaultShopCount;
    }
  };
  
  // 각 헤더 행에 대해 분석 보고서 생성
  const analysisReport = selectedColorHeaderRows.map(item => {
    //
    const hasSheetData = item.has_sheet_data;
    // 매장 수 가져오기
    const shopCount = getShopCount();
    
    // 점일 판매량 (최근 7일 판매량 기준)
    const shopDailySales = shopCount > 0 ? 
                           safeNumber(item.weekly_7d_sale_qty) / (shopCount * 7) : 0;
    
    // 리드타임 추출 또는 기본값 사용
    const leadTimeDays = safeNumber(item.lead_time_days) || defaultLeadTime;
    
    // 리오더 입고 예상일: 기준일+리드타임
    const reorderInboundDate = (() => {
      const date = new Date(referenceDate);
      date.setDate(date.getDate() + leadTimeDays);
      return formatDate(date);
    })();
    
    // 판매마감까지 남은 일수
    const daysUntilSalesEnd = salesEndDate ? getDaysDifference(referenceDate, salesEndDate) : 90;
    
    // 판매마감일~리오더 입고예상일
    const salesEndToReorderInboundDays = salesEndDate ? getDaysDifference(reorderInboundDate, salesEndDate) : 0;
    
    // 예상판매량: 기준일~판매마감일동안 예상판매량 = 판매마감까지 남은 일수*매장수*점일 판매
    const expectedSales = daysUntilSalesEnd * shopCount * shopDailySales * defaultGrowthRate;
    
    // 총재고
    const totalStock = safeNumber(item.current_stock_qty);
    
    // 부족수량: 예상판매량-총재고
    const shortageSales = Math.max(0, expectedSales - totalStock);
    
    // 목표 판매율 (기본값 1.0 = 100%)
    const targetSaleRate = safeNumber(item.target_sale_rate) || 1.0;
    
    // 리오더 필요 수량: 부족수량/목표판매율
    const reorderRequiredQty = shortageSales > 0 ? shortageSales / targetSaleRate : 0;
    const reorderFinalQty = Math.ceil(reorderRequiredQty / 10) * 10; // 10단위 올림
    
    // 사이즈별 정보 추출 (사이즈별 리오더 필요량 계산)
    const colorGroupId = item.groupId;
    const sizeItems = colorListData.filter(row => row.groupId === colorGroupId && row._type === 'size');
    
    // 사이즈별 판매 비율 계산
    const totalSizeOutQty = sizeItems.reduce((sum, size) => sum + safeNumber(size.tot_out_qty), 0);
    const totalSizeInQty = sizeItems.reduce((sum, size) => sum + safeNumber(size.tot_in_qty), 0);
    const totalSizeSalesQty = sizeItems.reduce((sum, size) => sum + safeNumber(size.tot_sale_qty), 0);

    // 사이즈별 리오더 수량 계산
    const sizeReorderInfo = sizeItems.map(sizeItem => {
      const sizeOutQty = safeNumber(sizeItem.tot_out_qty);
      const sizeInQty = safeNumber(sizeItem.tot_in_qty);
      const sizeSalesQty = safeNumber(sizeItem.tot_sale_qty);

      const sizeOutRatio = totalSizeOutQty > 0 ? sizeOutQty / totalSizeOutQty : 0;
      const sizeInRatio = totalSizeInQty > 0 ? sizeInQty / totalSizeInQty : 0;
      const sizeSalesRatio = totalSizeSalesQty > 0 ? sizeSalesQty / totalSizeSalesQty : 0;
      const sizeSalesRate = totalSizeSalesQty > 0 ? sizeSalesQty / sizeInQty : 0;
      
      // 사이즈별 리오더 수량 (전체 리오더 수량 * 사이즈 비율)
      const sizeReorderQty = Math.ceil(reorderFinalQty * sizeSalesRatio / 10) * 10; // 10단위 올림
      
      // 사이즈별 총재고
      const sizeStock = safeNumber(sizeItem.current_stock_qty);
      
      // 사이즈별 예상판매량 - 사이즈별 판매 비율 기반으로 계산
      // 사이즈별 매장당 일 판매량 계산
      const sizeDailySales = safeNumber(sizeItem.weekly_7d_sale_qty) / (shopCount * 7);
      // 사이즈별 예상판매량 = 남은 일수 * 매장 수 * 사이즈별 매장당 일 판매량 * 성장률
      const sizeExpectedSales = daysUntilSalesEnd * shopCount * sizeDailySales * defaultGrowthRate;
      // 사이즈별 부족수량
      const sizeShortageQty = Math.max(0, sizeExpectedSales - sizeStock);
      
      // 사이즈 ID 생성
      const sizeId = `${colorGroupId}_${sizeItem.size_cd}`;
      
      // 영문 필드명 사용 (수량은 정수로 변환)
      return {
        size_cd: sizeItem.size_cd || '',
        size_nm: sizeItem.size_nm || '',
        reorder_qty: safeInteger(sizeReorderQty),
        growth_rate: safeInteger(defaultGrowthRate),
        days_until_sales_end: safeInteger(daysUntilSalesEnd),
        expected_sales: safeInteger(sizeExpectedSales),
        total_stock: safeInteger(sizeStock),
        shortage_qty: safeInteger(sizeShortageQty),
        size_id: sizeId,
        // 사이즈별 비율 정보 추가
        size_in_count: safeInteger(sizeInQty),
        size_in_ratio: Number(sizeInRatio.toFixed(4)),
        size_out_count: safeInteger(sizeOutQty),
        size_out_ratio: Number(sizeOutRatio.toFixed(4)),
        size_sales_count: safeInteger(sizeSalesQty),
        size_sales_ratio: Number(sizeSalesRatio.toFixed(4)),
        size_out_ratio_diff: Number((sizeOutRatio - sizeSalesRatio).toFixed(4)),
        size_sales_rate: Number(sizeSalesRate.toFixed(4))
      };
    }).sort((a, b) => {
      // size_cd 기준으로 오름차순 정렬
      if (a.size_cd < b.size_cd) return -1;
      if (a.size_cd > b.size_cd) return 1;
      return 0;
    });
    
    // 간소화된 리포트 형태로 반환 (그룹화 + 필드별 라벨 적용)
    return {
      // 공통 참조 정보 - 영문 필드명 사용
      reference_info: {
          groupId: item.groupId,
        sty_cd: item.sty_cd || '',
        sty_nm: item.sty_nm || '',
        item_nm: item.item_nm || '',
        col_cd: item.col_cd || '',
        col_nm: item.col_nm || '',
        has_sheet_data: hasSheetData || false
      },
      
      // 1. 생산 관련 정보
      production_info: {
          groupId: item.groupId,
        "생산업체": item.cust_nm || '',
        "TAG가": safeInteger(item.tag_price),
        "출고일": formatDate(item.first_outbound_date) || '',
        "창고재고": safeInteger(item.wh_stck_qty) || 0,
        "매장재고": safeInteger(item.sh_stck_qty) || 0,
        "원가": safeInteger(item.cost_price),
        "배수": Number((safeNumber(item.cost_price) > 0 ? 
                        safeNumber(item.tag_price) / safeNumber(item.cost_price) / 1.1 : 0).toFixed(2)),
        "리오더 TAG가": safeInteger(item.tag_price),
        "리오더 원가": safeInteger(item.cost_price),
        "리오더 배수": Number((safeNumber(item.cost_price) > 0 ? 
                        safeNumber(item.tag_price) / safeNumber(item.cost_price) / 1.1 : 0).toFixed(2)),
        "생산팀 메모": item.note || '',
        "입고 수량": safeInteger(item.tot_in_qty),
        "출고 수량": safeInteger(item.tot_out_qty),
        "출고율": Number((safeNumber(item.tot_in_qty) > 0 ? 
                  safeNumber(item.tot_out_qty) / safeNumber(item.tot_in_qty) : 0).toFixed(2))
      },
      
      // 2. 판매실적 (출고~기준일, 주간 통합)
      sales_performance: {
          groupId: item.groupId,
        // 출고~기준일 판매실적
        "기준일": formatDate(referenceDate),
        "누적 판매량": safeInteger(item.tot_sale_qty),
        "누적 판매율(입고 기준)": Number((safeNumber(item.tot_in_qty) > 0 ? 
                      safeNumber(item.tot_sale_qty) / safeNumber(item.tot_in_qty) : 0).toFixed(2)),
        "출고~기준일 판매일수": safeInteger(item.sales_period_until_reference_date),
        "일 판매량": safeInteger(safeNumber(item.sales_period_until_reference_date) > 0 ? 
                        safeNumber(item.tot_sale_qty) / safeNumber(item.sales_period_until_reference_date) : 0),
        
        // 주간판매실적
        "매장수": safeInteger(shopCount),
        "최근 7일 판매량": safeInteger(item.weekly_7d_sale_qty),
        "최근 7일 판매율(출고 기준)": Number((safeNumber(item.tot_out_qty) > 0 ? 
                          safeNumber(item.weekly_7d_sale_qty) / safeNumber(item.tot_out_qty) : 0).toFixed(4)),
        "매장당 일 판매량": Number(shopDailySales.toFixed(2))
      },
      
      // 3. 리오더 수량
      reorder_info: {
          groupId: item.groupId,
        "리드타임(일)": safeInteger(leadTimeDays),
        "리오더 납기일": formatDate(reorderInboundDate),
        "판매 마감일": formatDate(salesEndDate),
        "리오더 납기일~판매 마감일": safeInteger(salesEndToReorderInboundDays),
        "성장률(%)": safeInteger(defaultGrowthRate * 100),
        "기준일~판매 마감일": safeInteger(daysUntilSalesEnd),
        "기준일~마감일 예상 판매량": safeInteger(expectedSales),
        "현재 총재고": safeInteger(totalStock),
        "부족 수량": safeInteger(shortageSales),
        "MD 메모": '(메모 없음)',
        // "리오더 필요 수량": reorderRequiredQty,
        // "최종 리오더 수량": reorderFinalQty
      },
      
      // 4. 사이즈별 리오더 정보
      size_reorder_info: sizeReorderInfo
    };
  });
  
  // selectedReorderItems에 분석 보고서 형식으로 정보 추가
  const selectedItemsWithAnalysis = selectedColorHeaderRows.map((header, index) => {
    // 해당 헤더의 하위 사이즈 정보 조회
    const children = colorListData.filter(
      item => item._type === 'size' &&
        item.sty_cd === header.sty_cd &&
        item.col_cd === header.col_cd
    );
    
    // 분석 보고서에서 해당 아이템 찾기
    const analysis = analysisReport.find(item => 
      item.reference_info.sty_cd === header.sty_cd && 
      item.reference_info.col_cd === header.col_cd
    ) || analysisReport[index];
    
    // 원본 헤더 정보와 함께 분석 정보 추가
    return {
      //  ...header,
      //  _childrenArray: children,
      reference_info: analysis.reference_info,
      production_info: analysis.production_info,
      sales_performance: analysis.sales_performance,
      reorder_info: analysis.reorder_info,
      size_reorder_info: analysis.size_reorder_info
    };
  });
  
  // ★ Retool 상태 갱신
  if (selectedReorderItems && typeof selectedReorderItems.setValue === 'function') {
    selectedReorderItems.setValue(selectedItemsWithAnalysis);
    console.log("[getSelectedItems] selectedReorderItems 업데이트 완료:", selectedItemsWithAnalysis.length);
  }
  
  return analysisReport;
}

return getSelectedItems(); 