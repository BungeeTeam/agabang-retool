// getColorList - 컬러 단위 헤더 행만 추출하는 함수 (정렬 기준 및 리오더 수량 계산 개선 + Manufacturer Stock 추가)
function getColorList() {
    // 안전한 숫자 변환 함수 - 최상단으로 이동
    const safeNumber = (val) => {
      if (val === null || val === undefined || val === '') return 0;
      const num = Number(val);
      return isNaN(num) ? 0 : num;
    };
  
    // 원본 데이터 가져오기
    const rawData = filterOutDiscontinuedItemsAndReorderHistoryItems.data || {};
    
    // 데이터가 객체이고 data 속성이 있는지 확인
    const allItems = Array.isArray(rawData) 
                    ? rawData 
                    : (rawData.data && Array.isArray(rawData.data) 
                      ? rawData.data 
                      : []);
      
    const discontinuedItems = get_discontinued_products.data || [];
    const seriesData = get_series_names.data || [];
    
    // reorder_moq_leadtime_info 테이블 데이터 가져오기
    const moqLeadtimeInfo = get_reorder_moq_leadtime_info.data || [];
    
    // manufacturer stock 데이터 가져오기 (새로 추가)
    const manufacturerStockData = get_manufacturer_stock.data || [];
    
    // 아이템별 MOQ와 리드타임 매핑 생성
    const itemMoqMap = {};
    const itemLeadTimeMap = {};
    
    moqLeadtimeInfo.forEach(info => {
      if (info && info.item) {
        itemMoqMap[info.item] = info.moq || 500;
        itemLeadTimeMap[info.item] = info.lead_time || 90;
      }
    });
  
    // manufacturer stock 매핑 생성 (스타일코드 기준)
    const manufacturerStockMap = {};
    manufacturerStockData.forEach(stock => {
      if (stock && stock.sty_cd) {
        // 스타일코드별로 총 재고량 합계 계산
        if (!manufacturerStockMap[stock.sty_cd]) {
          manufacturerStockMap[stock.sty_cd] = {
            total_stock: 0,
            details: []
          };
        }
        
        const stockQty = safeNumber(stock.stck_qty);
        manufacturerStockMap[stock.sty_cd].total_stock += stockQty;
        manufacturerStockMap[stock.sty_cd].details.push({
          col_cd: stock.col_cd,
          size_cd: stock.size_cd,
          stock_qty: stockQty,
          upload_dt: stock.upload_dt,
          comp_cd: stock.comp_cd,
          rmrk: stock.rmrk
        });
      }
    });
  
    // 단종정보 맵 생성 (스타일+컬러 조합)
    const discontinuedCombinations = new Set();
    discontinuedItems.forEach(item => {
      if (item && item.sty_cd && item.col_cd) {
        discontinuedCombinations.add(`${item.sty_cd}_${item.col_cd}`);
        
        // 사이즈별 단종 정보도 저장 (있는 경우)
        if (item.size_cd) {
          discontinuedCombinations.add(`${item.sty_cd}_${item.col_cd}_${item.size_cd}`);
        }
      }
    });
  
    // 시리즈명 맵 생성
    const seriesMap = {};
    seriesData.forEach(item => {
      if (item && item.sty_cd && item.series_name) {
        seriesMap[item.sty_cd] = item.series_name;
      }
    });
  
    // 데이터가 없거나 배열이 아닌 경우 빈 배열 반환
    if (!Array.isArray(allItems) || allItems.length === 0) {
      console.error("데이터가 없거나 배열이 아닙니다.");
      return [];
    }
  
    // 단종 상품 표시 여부 확인 (table6의 show_discontinued 체크박스 또는 전역 상태 변수 사용)
    const showDiscontinued = table_main_list.value?.show_discontinued === true || false;
    
    // 리오더 분석 함수 - 모든 아이템을 분석한 다음 나중에 단종 필터링
    const analyzedItems = allItems.map(item => {
      // 재고 및 판매 데이터 숫자 변환
      const currentStock = safeNumber(item.current_stock_qty || (safeNumber(item.tot_in_qty) - safeNumber(item.tot_sale_qty)));
      
      // 판매 날짜 정보
      const itemFirstOutboundDate = item.first_outbound_date || '';

      // --- 평균 판매량 계산 로직 고도화 ---
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      const yesterday = new Date(today);
      yesterday.setDate(today.getDate() - 1);

      let actualSalesStartDate = null;
      if (itemFirstOutboundDate) {
        actualSalesStartDate = new Date(itemFirstOutboundDate);
        actualSalesStartDate.setDate(actualSalesStartDate.getDate() + 1); // 출고일 + 1일을 실제 판매 시작일로 간주
        actualSalesStartDate.setHours(0, 0, 0, 0);
      }

      const calculateAverages = (periodDays, totalSales) => {
        let salesDays = periodDays;
        
        if (actualSalesStartDate) {
          const periodStartDate = new Date(today);
          periodStartDate.setDate(today.getDate() - periodDays);
          
          if (actualSalesStartDate >= periodStartDate) {
            const diffTime = Math.abs(yesterday - actualSalesStartDate);
            salesDays = Math.floor(diffTime / (1000 * 60 * 60 * 24)) + 1;
          }
        }
        
        salesDays = Math.max(1, salesDays);
        const salesMonths = salesDays / 30.0;

        const avgDailySales = totalSales / salesDays;
        const avgMonthlySales = totalSales / salesMonths;
        
        return { avgDailySales, avgMonthlySales };
      };

      const totalSales30d = safeNumber(item.sales_qty_30d);
      const totalSales180d = safeNumber(item.sales_qty_180d);
      const totalSales365d = safeNumber(item.sales_qty_365d);

      const avg30d = calculateAverages(30, totalSales30d);
      const avg180d = calculateAverages(180, totalSales180d);
      const avg365d = calculateAverages(365, totalSales365d);
      // --- 평균 판매량 계산 로직 끝 ---
      
      const itemFirstSalesDate = item.first_sale_date_all || item.first_sales_dt || '';
      const itemLastSalesDate = item.last_sale_date_all || '';
      
      // 리오더 횟수 정보 추가
      const totalReorderCount = safeNumber(item.total_reorder_count);
  
      // 컬러+스타일 조합이 단종되었는지 확인
      const combination = `${item.sty_cd}_${item.col_cd}`;
      const isDiscontinued = discontinuedCombinations.has(combination);
      
      // 매장재고와 창고재고 추가
      const shStockQty = safeNumber(item.sh_stck_qty);
      const whStockQty = safeNumber(item.wh_stck_qty);
      
      // 창고재고 소진 예상일 (새로 추가)
      const whDaysUntilOutOfStockD30 = safeNumber(item.wh_days_until_out_of_stock_d30);
      const whDaysUntilOutOfStockD180 = safeNumber(item.wh_days_until_out_of_stock_d180);
      const whDaysUntilOutOfStockD365 = safeNumber(item.wh_days_until_out_of_stock_d365);
      
      // 12개월 판매량 데이터 추출 및 안전하게 변환
      const month1SaleQty = safeNumber(item.month_1_sale_qty);
      const month2SaleQty = safeNumber(item.month_2_sale_qty);
      const month3SaleQty = safeNumber(item.month_3_sale_qty);
      const month4SaleQty = safeNumber(item.month_4_sale_qty);
      const month5SaleQty = safeNumber(item.month_5_sale_qty);
      const month6SaleQty = safeNumber(item.month_6_sale_qty);
      const month7SaleQty = safeNumber(item.month_7_sale_qty);
      const month8SaleQty = safeNumber(item.month_8_sale_qty);
      const month9SaleQty = safeNumber(item.month_9_sale_qty);
      const month10SaleQty = safeNumber(item.month_10_sale_qty);
      const month11SaleQty = safeNumber(item.month_11_sale_qty);
      const month12SaleQty = safeNumber(item.month_12_sale_qty);
      const month13SaleQty = safeNumber(item.month_13_sale_qty);
      const month14SaleQty = safeNumber(item.month_14_sale_qty);
      const month15SaleQty = safeNumber(item.month_15_sale_qty);
      const month16SaleQty = safeNumber(item.month_16_sale_qty);
      const month17SaleQty = safeNumber(item.month_17_sale_qty);
      const month18SaleQty = safeNumber(item.month_18_sale_qty);
      const month19SaleQty = safeNumber(item.month_19_sale_qty);
      const month20SaleQty = safeNumber(item.month_20_sale_qty);
      const month21SaleQty = safeNumber(item.month_21_sale_qty);
      const month22SaleQty = safeNumber(item.month_22_sale_qty);
      const month23SaleQty = safeNumber(item.month_23_sale_qty);
      const month24SaleQty = safeNumber(item.month_24_sale_qty);
      
      // 필요한 필드만 반환
      return {
        sty_cd: item.sty_cd,
        col_cd: item.col_cd,
        size_cd: item.size_cd,
        size_nm: item.size_nm || '',
        sty_nm: item.sty_nm || '',
        col_nm: item.col_nm || '',
        tag_price: item.tag_price || 0,
        cost_price: item.cost_price || 0,
        first_sales_dt: itemFirstSalesDate,
        first_outbound_date: itemFirstOutboundDate,
        last_sales_dt: itemLastSalesDate,
        first_inventory_date: item.first_inventory_date || '',
        last_inventory_date: item.last_inventory_date || '',
        tot_in_qty: safeNumber(item.tot_in_qty),
        tot_sale_qty: safeNumber(item.tot_sale_qty),
        current_stock_qty: currentStock,
        sh_stck_qty: shStockQty,
        wh_stck_qty: whStockQty,
        
        // 고도화된 평균 판매량 적용
        avg_daily_sales_d30: avg30d.avgDailySales,
        avg_monthly_sales_d30: avg30d.avgMonthlySales,
        avg_daily_sales_d180: avg180d.avgDailySales,
        avg_monthly_sales_d180: avg180d.avgMonthlySales,
        avg_daily_sales_d365: avg365d.avgDailySales,
        avg_monthly_sales_d365: avg365d.avgMonthlySales,

        total_reorder_count: totalReorderCount, // 리오더 횟수 추가
        // 창고재고 소진 예상일 추가
        wh_days_until_out_of_stock_d30: whDaysUntilOutOfStockD30,
        wh_days_until_out_of_stock_d180: whDaysUntilOutOfStockD180,
        wh_days_until_out_of_stock_d365: whDaysUntilOutOfStockD365,
        large_cat: item.large_cat || '',
        middle_cat: item.middle_cat || '',
        small_cat: item.small_cat || '',
        it_gb_nm: item.it_gb_nm || '',
        item_nm: item.item_nm || '',
        item: item.item || '', // 추가: item 코드 저장
        // 월별 판매량 추가
        month_1_sale_qty: month1SaleQty,
        month_2_sale_qty: month2SaleQty,
        month_3_sale_qty: month3SaleQty,
        month_4_sale_qty: month4SaleQty,
        month_5_sale_qty: month5SaleQty,
        month_6_sale_qty: month6SaleQty,
        month_7_sale_qty: month7SaleQty,
        month_8_sale_qty: month8SaleQty,
        month_9_sale_qty: month9SaleQty,
        month_10_sale_qty: month10SaleQty,
        month_11_sale_qty: month11SaleQty,
        month_12_sale_qty: month12SaleQty,
        month_13_sale_qty: month13SaleQty,
        month_14_sale_qty: month14SaleQty,
        month_15_sale_qty: month15SaleQty,
        month_16_sale_qty: month16SaleQty,
        month_17_sale_qty: month17SaleQty,
        month_18_sale_qty: month18SaleQty,
        month_19_sale_qty: month19SaleQty,
        month_20_sale_qty: month20SaleQty,
        month_21_sale_qty: month21SaleQty,
        month_22_sale_qty: month22SaleQty,
        month_23_sale_qty: month23SaleQty,
        month_24_sale_qty: month24SaleQty,
        // 추가 필드
        cust_cd: item.cust_cd || '',
        cust_nm: item.cust_nm || '',
        br_nm: item.br_nm || '',
        fabric: item.fabric || '',
        is_discontinued: isDiscontinued,
        series_name: item.series_name,
        colorKey: `${item.sty_cd}_${item.col_cd}`
      };
    });
    
    // 컬러별 그룹화
    const colorGroups = {};
    analyzedItems.forEach(item => {
      const colorKey = item.colorKey;
      if (!colorGroups[colorKey]) {
        colorGroups[colorKey] = [];
      }
      colorGroups[colorKey].push(item);
    });
  
    // 헤더 행 배열 준비
    const headers = [];
  
    // 리오더 계산에 필요한 기본 설정값 (기본값)
    const defaultLeadTimeDays = 90;
    const defaultTargetSaleRate = 0.8;
    const defaultMoq = 500;
    
    // 5. 예상 판매 기간 (월) - 기본값 6개월 (신규 추가)
    const expectedSalesPeriodMonths = 6;
  
    // 각 컬러 그룹에 대해 헤더 행 추가
    for (const colorKey in colorGroups) {
      const items = colorGroups[colorKey];
      if (items.length === 0) continue;
      
      // 첫 번째 아이템
      const firstItem = items[0];
      
      // 컬러의 단종 여부 확인
      const isColorDiscontinued = discontinuedCombinations.has(colorKey);
      
      // 단종된 상품이고 보기 옵션이 false면 건너뛰기
      if (isColorDiscontinued && !showDiscontinued) {
        continue;
      }
      
      // item 코드에 따른 MOQ 및 리드타임 가져오기
      const itemCode = firstItem.item;
      const moq = itemMoqMap[itemCode] || defaultMoq;
      const leadTimeDays = itemLeadTimeMap[itemCode] || defaultLeadTimeDays;
      const targetSaleRate = defaultTargetSaleRate; // 목표 판매율은 기본값 사용
      
      // manufacturer stock 정보 가져오기 (새로 추가)
      const manufacturerStockInfo = manufacturerStockMap[firstItem.sty_cd] || { total_stock: 0, details: [] };
      const manufacturerTotalStock = manufacturerStockInfo.total_stock;
      
      // 해당 컬러의 manufacturer stock 계산 (컬러별 필터링)
      const manufacturerColorStock = manufacturerStockInfo.details
        .filter(detail => detail.col_cd === firstItem.col_cd)
        .reduce((sum, detail) => sum + detail.stock_qty, 0);
      
      // 4. 매장 수 가져오기
      const shopCount = safeNumber(allItems.length > 0 ? allItems[0].active_shop_count : 0);
      
      // 재고 및 판매량 합계 계산 (manufacturer stock 포함)
      const totalStock = items.reduce((sum, item) => sum + item.current_stock_qty, 0) + manufacturerColorStock;
      const totalInQty = items.reduce((sum, item) => sum + item.tot_in_qty, 0);
      const totalSaleQty = items.reduce((sum, item) => sum + item.tot_sale_qty, 0);
      
      // 매장재고와 창고재고 합계 계산 추가
      const totalShStockQty = items.reduce((sum, item) => sum + item.sh_stck_qty, 0);
      const totalWhStockQty = items.reduce((sum, item) => sum + item.wh_stck_qty, 0);
      
      // 네 가지 기준의 평균 월 판매량 합계 -> 일/월 평균 판매량 합계로 변경
      const totalDailySalesD30 = items.reduce((sum, item) => sum + item.avg_daily_sales_d30, 0);
      const totalMonthlySalesD30 = items.reduce((sum, item) => sum + item.avg_monthly_sales_d30, 0);
      const totalDailySalesD180 = items.reduce((sum, item) => sum + item.avg_daily_sales_d180, 0);
      const totalMonthlySalesD180 = items.reduce((sum, item) => sum + item.avg_monthly_sales_d180, 0);
      const totalDailySalesD365 = items.reduce((sum, item) => sum + item.avg_daily_sales_d365, 0);
      const totalMonthlySalesD365 = items.reduce((sum, item) => sum + item.avg_monthly_sales_d365, 0);
  
      //컬러 그룹의 최대 리오더 횟수 계산
      const maxReorderCount = Math.max(...items.map(item => item.total_reorder_count || 0));
  
      // 소진 예상일을 월에서 일 단위로 변경 -> 일평균 판매량 사용으로 변경
      const daysUntilOutOfStockD30 = totalDailySalesD30 > 0 ? totalStock / totalDailySalesD30 : 999;
      const daysUntilOutOfStockD180 = totalDailySalesD180 > 0 ? totalStock / totalDailySalesD180 : 999;
      const daysUntilOutOfStockD365 = totalDailySalesD365 > 0 ? totalStock / totalDailySalesD365 : 999;
  
      // 버퍼 일수 계산 (일 단위) - 아이템별 리드타임 사용
      const bufferDaysD30 = daysUntilOutOfStockD30 - leadTimeDays;
      const bufferDaysD180 = daysUntilOutOfStockD180 - leadTimeDays;
      const bufferDaysD365 = daysUntilOutOfStockD365 - leadTimeDays;
  
      // 비상 재고량 (매장당 1개씩)
      const emergencyStock = shopCount * 1;
  
      // === 개선된 리오더 수량 계산 로직 시작 ===
      
      // 판매량 데이터 검증 및 가장 적절한 판매량 선택
      // 우선순위: 180일 > 365일 > 30일
      const effectiveMonthlySales = totalMonthlySalesD180 > 0 
        ? totalMonthlySalesD180 
        : (totalMonthlySalesD365 > 0 
          ? totalMonthlySalesD365 
          : totalMonthlySalesD30);
      
      // 일 평균 판매량으로 변환
      const effectiveDailySales = effectiveMonthlySales / 30;
      
      // 리드타임 동안의 예상 판매량 - 아이템별 리드타임 사용
      const expectedSalesDuringLeadTime = effectiveDailySales * leadTimeDays;
      
      // 전체 판매 기간 동안의 예상 판매량 (추가) - 기획안 반영
      const expectedSalesFullPeriod = effectiveMonthlySales * expectedSalesPeriodMonths;
      
      // 개선된 리오더 수량 계산 함수
      const calculateReorderQty = (stock, emergency, expectedFullPeriodSales, targetRate) => {
        // 기획안에 맞게 수정: (전체 기간 예상 판매량 + 안전 재고 - 총 재고량) ÷ 목표 판매율
        const totalRequired = expectedFullPeriodSales + emergency;
        const shortage = Math.max(0, totalRequired - stock);
        return shortage > 0 ? shortage / targetRate : 0;
      };
      
      // 리오더 수량 계산 - 개선된 로직 적용 - 아이템별 targetSaleRate 사용
      const recommendedReorderQty = calculateReorderQty(
        totalStock, 
        emergencyStock,
        expectedSalesFullPeriod, // 리드타임이 아닌 전체 판매 기간 사용
        targetSaleRate
      );
          
      // 추천 수량을 10의 자리에서 반올림
      const roundedRecommendedQty = Math.ceil(recommendedReorderQty / 10) * 10;
      
      // 반올림된 추천 수량과 MOQ 중 큰 값 선택 - 아이템별 MOQ 사용
      // recommendedReorderQty가 0인 경우, MOQ도 적용하지 않음
      const finalReorderQty = recommendedReorderQty > 0 
        ? Math.max(roundedRecommendedQty, moq)
        : 0;    
  
      // 예상 재고 (리드타임 동안 판매되고 남은 재고) - 아이템별 리드타임 반영
      const estimatedStock = Math.max(0, totalStock - expectedSalesDuringLeadTime);
      
      // 상태 결정 (일 단위 기준 변경) - 아이템별 리드타임 반영된 버퍼 일수 사용
      const statusD30 = bufferDaysD30 < 0 ? '긴급 🔴' : 
                        bufferDaysD30 <= 30 ? '주의 🟡' : '양호 🟢';
      const statusD180 = bufferDaysD180 < 0 ? '긴급 🔴' :
                        bufferDaysD180 <= 30 ? '주의 🟡' : '양호 🟢';
      const statusD365 = bufferDaysD365 < 0 ? '긴급 🔴' : 
                         bufferDaysD365 <= 30 ? '주의 🟡' : '양호 🟢';
      
      // 통합 추천 상태 결정 (OR 조건) - d30, d180, d365 고려
      const hasUrgent = [statusD30, statusD180, statusD365].some(s => s.includes('긴급'));
      const hasWarning = [statusD30, statusD180, statusD365].some(s => s.includes('주의'));
      
      const reorderRecommendingStatus = hasUrgent ? '긴급 🔴' : 
                                        hasWarning ? '주의 🟡' : 
                                        '양호 🟢';
      
      // === 창고재고 기준 소진 예상일 및 상태 계산 (신규 추가) ===
      // 창고재고 소진 예상일 계산 (일 단위) -> 일평균 판매량 사용으로 변경
      const whDaysUntilOutOfStockD30 = totalDailySalesD30 > 0 ? totalWhStockQty / totalDailySalesD30 : 999;
      const whDaysUntilOutOfStockD180 = totalDailySalesD180 > 0 ? totalWhStockQty / totalDailySalesD180 : 999;
      const whDaysUntilOutOfStockD365 = totalDailySalesD365 > 0 ? totalWhStockQty / totalDailySalesD365 : 999;
  
      // 창고재고 기준 버퍼 일수 계산 - 아이템별 리드타임 사용
      const whBufferDaysD30 = whDaysUntilOutOfStockD30 - leadTimeDays;
      const whBufferDaysD180 = whDaysUntilOutOfStockD180 - leadTimeDays;
      const whBufferDaysD365 = whDaysUntilOutOfStockD365 - leadTimeDays;
  
      // 창고재고 기준 상태 결정 - 아이템별 리드타임 반영된 버퍼 일수 사용
      const whStatusD30 = whBufferDaysD30 < 0 ? '긴급 🔴' : 
                          whBufferDaysD30 <= 30 ? '주의 🟡' : '양호 🟢';
      const whStatusD180 = whBufferDaysD180 < 0 ? '긴급 🔴' :
                           whBufferDaysD180 <= 30 ? '주의 🟡' : '양호 🟢';
      const whStatusD365 = whBufferDaysD365 < 0 ? '긴급 🔴' : 
                           whBufferDaysD365 <= 30 ? '주의 🟡' : '양호 🟢';
      
      // 창고재고 기준 통합 추천 상태 결정
      const hasWhUrgent = [whStatusD30, whStatusD180, whStatusD365].some(s => s.includes('긴급'));
      const hasWhWarning = [whStatusD30, whStatusD180, whStatusD365].some(s => s.includes('주의'));
      
      const whReorderRecommendingStatus = hasWhUrgent ? '긴급 🔴' : 
                                          hasWhWarning ? '주의 🟡' : 
                                          '양호 🟢';
      
      // 정렬을 위한 추가 지표 계산
      const urgentCount = [statusD30, statusD180, statusD365].filter(s => s.includes('긴급')).length;
      const warningCount = [statusD30, statusD180, statusD365].filter(s => s.includes('주의')).length;
      const whUrgentCount = [whStatusD30, whStatusD180, whStatusD365].filter(s => s.includes('긴급')).length;
      const whWarningCount = [whStatusD30, whStatusD180, whStatusD365].filter(s => s.includes('주의')).length;
      
      // 판매율 계산
      const saleRate = totalInQty > 0 ? (totalSaleQty / totalInQty) : 0;
      
      // 컬러 그룹 내 판매 일자 찾기
      let groupLastSalesDate = '';
      let groupFirstSalesDate = '';
      let groupFirstInventoryDate = '';
      let groupLastInventoryDate = '';
      let groupFirstOutboundDate = '';
  
      items.forEach(item => {
        // 마지막 판매일 계산
        if (item.last_sales_dt && (!groupLastSalesDate || item.last_sales_dt > groupLastSalesDate)) {
          groupLastSalesDate = item.last_sales_dt;
        }
        
        // 첫 판매일 계산
        if (item.first_sales_dt && (!groupFirstSalesDate || item.first_sales_dt < groupFirstSalesDate)) {
          groupFirstSalesDate = item.first_sales_dt;
        }
        
        // 첫 입고일 계산
        if (item.first_inventory_date && (!groupFirstInventoryDate || item.first_inventory_date < groupFirstInventoryDate)) {
          groupFirstInventoryDate = item.first_inventory_date;
        }
        
        // 마지막 입고일 계산
        if (item.last_inventory_date && (!groupLastInventoryDate || item.last_inventory_date > groupLastInventoryDate)) {
          groupLastInventoryDate = item.last_inventory_date;
        }
  
        // 첫 출고일 계산
        if (item.first_outbound_date && (!groupFirstOutboundDate || item.first_outbound_date < groupFirstOutboundDate)) {
          groupFirstOutboundDate = item.first_outbound_date;
        }
      });
      
      // 월별 판매량 합계 계산 추가
      const totalMonth1SaleQty = items.reduce((sum, item) => sum + (item.month_1_sale_qty || 0), 0);
      const totalMonth2SaleQty = items.reduce((sum, item) => sum + (item.month_2_sale_qty || 0), 0);
      const totalMonth3SaleQty = items.reduce((sum, item) => sum + (item.month_3_sale_qty || 0), 0);
      const totalMonth4SaleQty = items.reduce((sum, item) => sum + (item.month_4_sale_qty || 0), 0);
      const totalMonth5SaleQty = items.reduce((sum, item) => sum + (item.month_5_sale_qty || 0), 0);
      const totalMonth6SaleQty = items.reduce((sum, item) => sum + (item.month_6_sale_qty || 0), 0);
      const totalMonth7SaleQty = items.reduce((sum, item) => sum + (item.month_7_sale_qty || 0), 0);
      const totalMonth8SaleQty = items.reduce((sum, item) => sum + (item.month_8_sale_qty || 0), 0);
      const totalMonth9SaleQty = items.reduce((sum, item) => sum + (item.month_9_sale_qty || 0), 0);
      const totalMonth10SaleQty = items.reduce((sum, item) => sum + (item.month_10_sale_qty || 0), 0);
      const totalMonth11SaleQty = items.reduce((sum, item) => sum + (item.month_11_sale_qty || 0), 0);
      const totalMonth12SaleQty = items.reduce((sum, item) => sum + (item.month_12_sale_qty || 0), 0);
      const totalMonth13SaleQty = items.reduce((sum, item) => sum + (item.month_13_sale_qty || 0), 0);
      const totalMonth14SaleQty = items.reduce((sum, item) => sum + (item.month_14_sale_qty || 0), 0);
      const totalMonth15SaleQty = items.reduce((sum, item) => sum + (item.month_15_sale_qty || 0), 0);
      const totalMonth16SaleQty = items.reduce((sum, item) => sum + (item.month_16_sale_qty || 0), 0);
      const totalMonth17SaleQty = items.reduce((sum, item) => sum + (item.month_17_sale_qty || 0), 0);
      const totalMonth18SaleQty = items.reduce((sum, item) => sum + (item.month_18_sale_qty || 0), 0);
      const totalMonth19SaleQty = items.reduce((sum, item) => sum + (item.month_19_sale_qty || 0), 0);
      const totalMonth20SaleQty = items.reduce((sum, item) => sum + (item.month_20_sale_qty || 0), 0);
      const totalMonth21SaleQty = items.reduce((sum, item) => sum + (item.month_21_sale_qty || 0), 0);
      const totalMonth22SaleQty = items.reduce((sum, item) => sum + (item.month_22_sale_qty || 0), 0);
      const totalMonth23SaleQty = items.reduce((sum, item) => sum + (item.month_23_sale_qty || 0), 0);
      const totalMonth24SaleQty = items.reduce((sum, item) => sum + (item.month_24_sale_qty || 0), 0);

      // 헤더 행 생성
      const headerRow = {
        // 아이템 사진
        item_image: '',
        
        // 기본 정보
        sty_nm: firstItem.sty_nm,
        col_nm: firstItem.col_nm,
        size_nm: '-',
        tag_price: firstItem.tag_price,
        cost_price: firstItem.cost_price,
        price_multiple: firstItem.cost_price > 0 ? 
      (firstItem.tag_price / firstItem.cost_price / 1.1) : 0,
        
        // 날짜 정보
        first_sales_dt: groupFirstSalesDate,
        last_sales_dt: groupLastSalesDate,
        first_inventory_date: groupFirstInventoryDate,
        last_inventory_date: groupLastInventoryDate,
        first_outbound_date: groupFirstOutboundDate,
        
        // 수량 정보
        tot_in_qty: totalInQty,
        tot_sale_qty: totalSaleQty,
        current_stock_qty: totalStock,
        sh_stck_qty: totalShStockQty,  // 매장 재고 추가
        wh_stck_qty: totalWhStockQty,  // 창고 재고 추가
        
        // Manufacturer Stock 정보 추가 (새로 추가)
        manufacturer_total_stock: manufacturerTotalStock,     // 해당 스타일의 전체 제조사 재고
        manufacturer_color_stock: manufacturerColorStock,     // 해당 컬러의 제조사 재고
        manufacturer_stock_details: manufacturerStockInfo.details.filter(d => d.col_cd === firstItem.col_cd), // 상세 정보
        
        sale_rate: saleRate,
        estimated_stock: estimatedStock,
        total_reorder_count: maxReorderCount,
  
        // 판매량 정보 (일/월 단위)
        avg_daily_sales_d30: totalDailySalesD30,
        avg_monthly_sales_d30: totalMonthlySalesD30,
        avg_daily_sales_d180: totalDailySalesD180,
        avg_monthly_sales_d180: totalMonthlySalesD180,
        avg_daily_sales_d365: totalDailySalesD365,
        avg_monthly_sales_d365: totalMonthlySalesD365,
  
        // 월별 판매량 추가
        month_1_sale_qty: totalMonth1SaleQty,
        month_2_sale_qty: totalMonth2SaleQty,
        month_3_sale_qty: totalMonth3SaleQty,
        month_4_sale_qty: totalMonth4SaleQty,
        month_5_sale_qty: totalMonth5SaleQty,
        month_6_sale_qty: totalMonth6SaleQty,
        month_7_sale_qty: totalMonth7SaleQty,
        month_8_sale_qty: totalMonth8SaleQty,
        month_9_sale_qty: totalMonth9SaleQty,
        month_10_sale_qty: totalMonth10SaleQty,
        month_11_sale_qty: totalMonth11SaleQty,
        month_12_sale_qty: totalMonth12SaleQty,
        month_13_sale_qty: totalMonth13SaleQty,
        month_14_sale_qty: totalMonth14SaleQty,
        month_15_sale_qty: totalMonth15SaleQty,
        month_16_sale_qty: totalMonth16SaleQty,
        month_17_sale_qty: totalMonth17SaleQty,
        month_18_sale_qty: totalMonth18SaleQty,
        month_19_sale_qty: totalMonth19SaleQty,
        month_20_sale_qty: totalMonth20SaleQty,
        month_21_sale_qty: totalMonth21SaleQty,
        month_22_sale_qty: totalMonth22SaleQty,
        month_23_sale_qty: totalMonth23SaleQty,
        month_24_sale_qty: totalMonth24SaleQty,
  
        // 월평균 판매량 계산 시 사용할 수 있는 추가 컬럼 (옵션)
        recent_6month_avg_sale_qty: [
          totalMonth1SaleQty, totalMonth2SaleQty, totalMonth3SaleQty,
          totalMonth4SaleQty, totalMonth5SaleQty, totalMonth6SaleQty
        ].reduce((sum, qty) => sum + qty, 0) / 6,
        
        // 월평균 판매량 계산 시 사용할 수 있는 추가 컬럼 (옵션)
        recent_12month_avg_sale_qty: [
          totalMonth1SaleQty, totalMonth2SaleQty, totalMonth3SaleQty,
          totalMonth4SaleQty, totalMonth5SaleQty, totalMonth6SaleQty,
          totalMonth7SaleQty, totalMonth8SaleQty, totalMonth9SaleQty,
          totalMonth10SaleQty, totalMonth11SaleQty, totalMonth12SaleQty
        ].reduce((sum, qty) => sum + qty, 0) / 12,
        
        // 총재고 기준 소진 예상 일 수
        daysUntilOutOfStock_d30: daysUntilOutOfStockD30,
        daysUntilOutOfStock_d180: daysUntilOutOfStockD180,
        daysUntilOutOfStock_d365: daysUntilOutOfStockD365,
        
        // 리드타임에 따른 버퍼 일수
        bufferDays_d30: bufferDaysD30,
        bufferDays_d180: bufferDaysD180,
        bufferDays_d365: bufferDaysD365,
        
        // 총재고 기준 상태 정보
        status_d30: statusD30,
        status_d180: statusD180,
        status_d365: statusD365,
        reorder_recommending_status: reorderRecommendingStatus,
        
        // 창고재고 기준 소진 예상 일 수 (신규 추가)
        whDaysUntilOutOfStock_d30: whDaysUntilOutOfStockD30,
        whDaysUntilOutOfStock_d180: whDaysUntilOutOfStockD180,
        whDaysUntilOutOfStock_d365: whDaysUntilOutOfStockD365,
        
        // 창고재고 기준 버퍼 일수
        whBufferDays_d30: whBufferDaysD30,
        whBufferDays_d180: whBufferDaysD180,
        whBufferDays_d365: whBufferDaysD365,
        
        // 창고재고 기준 상태 정보 (신규 추가)
        wh_status_d30: whStatusD30,
        wh_status_d180: whStatusD180,
        wh_status_d365: whStatusD365,
        wh_reorder_recommending_status: whReorderRecommendingStatus,
        
        // 리오더 정보 - 개선된 계산 결과 적용
        effective_monthly_sales: effectiveMonthlySales,      // 선택된 유효 월 판매량
        expected_sales: expectedSalesDuringLeadTime,         // 리드타임 동안 예상 판매량
        expected_sales_full_period: expectedSalesFullPeriod, // 전체 기간 예상 판매량
        recommended_reorder_qty: recommendedReorderQty,      // 계산된 리오더 필요량 
        final_reorder_qty: finalReorderQty,                  // 최종 리오더 수량
        
        // 추가 정보
        sty_cd: firstItem.sty_cd,
        col_cd: firstItem.col_cd,
        size_cd: '',
        large_cat: firstItem.large_cat,
        middle_cat: firstItem.middle_cat,
        small_cat: firstItem.small_cat,
        it_gb_nm: firstItem.it_gb_nm,
        item_nm: firstItem.item_nm,
        item: firstItem.item,  // 아이템 코드 추가
        // 새로 추가된 필드들
        cust_cd: firstItem.cust_cd,
        cust_nm: firstItem.cust_nm, 
        br_nm: firstItem.br_nm,
        fabric: firstItem.fabric,
        
        is_discontinued: isColorDiscontinued,
        series_name: firstItem.series_name,
        
        // 리오더 계산에 사용된 값들 (디버깅/참고용)
        lead_time_days: leadTimeDays,
        target_sale_rate: targetSaleRate,
        moq: moq,
        emergency_stock: emergencyStock,
        expected_sales_period_months: expectedSalesPeriodMonths,
        
        // 메타 정보 (정렬용)
        urgentCount: urgentCount,              // 총재고 기준 긴급 상태 개수
        warningCount: warningCount,            // 총재고 기준 주의 상태 개수
        whUrgentCount: whUrgentCount,          // 창고재고 기준 긴급 상태 개수 (신규)
        whWarningCount: whWarningCount,        // 창고재고 기준 주의 상태 개수 (신규)
        
        _type: 'header',
        groupId: colorKey,
        _isExpanded: false
      };
      
      headers.push(headerRow);
    }
  
      
  // 헤더를 새로운 우선순위로 정렬 (창고재고 상태 고려)
    headers.sort((a, b) => {
      const aPriority = getStatusPriority(a.wh_reorder_recommending_status, a.reorder_recommending_status);
      const bPriority = getStatusPriority(b.wh_reorder_recommending_status, b.reorder_recommending_status);
  
      const aStock = typeof a.current_stock_qty === 'number' ? a.current_stock_qty : Number(a.current_stock_qty) || 0;
      const bStock = typeof b.current_stock_qty === 'number' ? b.current_stock_qty : Number(b.current_stock_qty) || 0;
  
      const aMonthly = Number(a.avg_monthly_sales_d180) || Number(a.avg_monthly_sales_d30) || 0;
      const bMonthly = Number(b.avg_monthly_sales_d180) || Number(b.avg_monthly_sales_d30) || 0;
  
      if (aPriority !== bPriority) return aPriority - bPriority;
      if (aMonthly !== bMonthly) return bMonthly - aMonthly;
      if (aStock !== bStock) return aStock - bStock;
      if (a.sty_cd !== b.sty_cd) return String(a.sty_cd).localeCompare(String(b.sty_cd));
      if (a.col_cd !== b.col_cd) return String(a.col_cd).localeCompare(String(b.col_cd));
      return 0;
    });
  
    return headers;
  }
  
  // 상태값 정규화 함수
  function normalizeStatus(status) {
    if (!status) return '양호 🟢';
    if (status.includes('긴급')) return '긴급 🔴';
    if (status.includes('주의')) return '주의 🟡';
    return '양호 🟢';
  }
  
  // 상태 조합 우선순위 함수
  function getStatusPriority(whStatus, totalStatus) {
    const wh = normalizeStatus(whStatus);
    const tot = normalizeStatus(totalStatus);
    if (wh === '긴급 🔴' && tot === '긴급 🔴') return 1;
    if (wh === '긴급 🔴' && tot === '주의 🟡') return 2;
    if (wh === '긴급 🔴' && tot === '양호 🟢') return 3;
    if (wh === '주의 🟡' && tot === '긴급 🔴') return 4;
    if (wh === '주의 🟡' && tot === '주의 🟡') return 5;
    if (wh === '양호 🟢' && tot === '긴급 🔴') return 6;
    if (wh === '양호 🟢' && tot === '주의 🟡') return 7;
    if (wh === '주의 🟡' && tot === '양호 🟢') return 8;
    if (wh === '양호 🟢' && tot === '양호 🟢') return 9;
    return 99;
  }
  
  // 실행
  return getColorList();