// getColorList - 컬러 단위 헤더 행 추출 함수 (개선버전)
function getColorList() {
  // 원본 데이터 가져오기
  const rawData = filterOutDiscontinuedItemsAndReorderHistoryItems.data || {};
  
  // 데이터 구조 확인 및 로깅
  console.log("[getColorList] filterOutDiscontinuedItems 구조:", typeof rawData, Array.isArray(rawData) ? "배열" : "배열 아님");
  
  // 데이터가 객체이고 data 속성이 있는지 확인
  const allItems = Array.isArray(rawData) 
                  ? rawData 
                  : (rawData.data && Array.isArray(rawData.data) 
                    ? rawData.data 
                    : []);
  
  console.log("[getColorList] 처리 후 allItems 길이:", allItems.length);
  
  const discontinuedItems = get_discontinued_products.data || [];
  const seriesData = get_series_names.data || [];

  // 안전한 숫자 변환 함수
  const safeNumber = (val) => {
    if (val === null || val === undefined || val === '') return 0;
    const num = Number(val);
    return isNaN(num) ? 0 : num;
  };

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
    console.error("[getColorList] 데이터가 없거나 배열이 아닙니다.");
    return [];
  }

      // 단종 상품 표시 여부 확인
      const showDiscontinued = table_main_list.value?.show_discontinued === true || false;

      // 날짜 포맷팅 함수 (KST 기준으로 YYYY-MM-DD 형식 반환)
      const formatDate = (dateInput) => {
          if (!dateInput) return '';
  
          let date;
          // 문자열이 들어올 경우 Date 객체로 변환
          if (typeof dateInput === 'string') {
              date = new Date(dateInput);
          } else if (dateInput instanceof Date) {
              date = dateInput; // 이미 Date 객체인 경우 그대로 사용
          } else {
              return String(dateInput); // 예상치 못한 타입은 그냥 문자열로 반환
          }
  
          if (isNaN(date.getTime())) {
              return typeof dateInput === 'string' ? dateInput : ''; // 유효하지 않은 날짜는 원본 또는 빈 문자열 반환
          }
  
          // 로컬 시간 기준으로 YYYY-MM-DD 형식 반환
          const year = date.getFullYear();
          const month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 +1
          const day = date.getDate().toString().padStart(2, '0');
  
          return `${year}-${month}-${day}`;
      };
  
      // 1. 기준일자 설정 (오늘 날짜) - 형식 통일
      const referenceDate = inputReferenceDate.value ? formatDate(inputReferenceDate.value) : formatDate(new Date());
  
      // 2. 판매 마감 기준일 설정 - 형식 통일
      // inputSalesEndDate.value가 8월 31일 Date 객체여도, formatDate를 거치면서 '2025-08-31' 문자열로 변환됩니다.
      const salesEndDate = inputSalesEndDate.value ? formatDate(inputSalesEndDate.value) : '';
  
      // 날짜 차이 계산 함수 (일 단위)
      const getDaysDifference = (startDateStr, endDateStr) => {
          if (!startDateStr || !endDateStr) return 0;
  
          // 문자열을 Date 객체로 변환 (이때는 문자열이 YYYY-MM-DD이므로 로컬 시간으로 해석됨)
          const start = new Date(startDateStr);
          const end = new Date(endDateStr);
  
          if (isNaN(start.getTime()) || isNaN(end.getTime())) return 0;
  
          // 자정 기준의 날짜 차이를 정확하게 계산하기 위해 밀리초 차이를 이용
          // Math.floor((end - start) / (1000 * 60 * 60 * 24)) 이 부분은 이미 날짜의 자정 기준 차이를 반영하므로 안전합니다.
          // + 1은 시작일과 종료일을 모두 포함하는 일수를 계산하기 위함입니다.
          return Math.floor((end - start) / (1000 * 60 * 60 * 24)) + 1;
      };
  // 상태 계산 함수
  const calculateStatus = (bufferDays) => {
    if (bufferDays < 0) return '긴급 🔴';
    if (bufferDays <= 30) return '주의 🟡';
    return '양호 🟢';
  };
  
  // 리오더 분석 함수
  const analyzedItems = allItems.map((item, idx) => {
    // 재고 및 판매 데이터 숫자 변환
    const currentStock = safeNumber(item.current_stock_qty || (safeNumber(item.tot_in_qty) - safeNumber(item.tot_sale_qty)));
    
    // 다양한 기간의 일 평균 판매량 변환
    const avgDailySales = safeNumber(item.avg_daily_sales); // 전체 기간 기준
    const avgDailySalesD7 = safeNumber(item.avg_daily_sales_d7); // 최근 7일 기준
    const avgDailySalesD30 = safeNumber(item.avg_daily_sales_d30); // 최근 30일 기준
    const avgDailySalesD180 = safeNumber(item.avg_daily_sales_d180); // 최근 180일 기준
    const avgDailySalesD365 = safeNumber(item.avg_daily_sales_d365); // 최근 365일 기준
    
    // 네 가지 기준의 평균 판매량 변환
    const avgMonthlySales = safeNumber(item.avg_monthly_sales); // 전체 기간 기준
    const avgMonthlySalesD30 = safeNumber(item.avg_monthly_sales_d30); // 최근 30일 기준
    const avgMonthlySalesD180 = safeNumber(item.avg_monthly_sales_d180); // 최근 180일 기준
    const avgMonthlySalesD365 = safeNumber(item.avg_monthly_sales_d365); // 최근 365일 기준
    
    // 판매 날짜 정보
    const itemFirstSalesDate = item.first_sale_date_all || item.first_sales_dt || '';
    const itemFirstOutboundDate = item.first_outbound_date || '';
    const itemLastSalesDate = item.last_sale_date_all || '';
    
    // 컬러+스타일 조합이 단종되었는지 확인
    const combination = `${item.sty_cd}_${item.col_cd}`;
    const isDiscontinued = discontinuedCombinations.has(combination);
    
    // 매장재고와 창고재고 추가
    const shStockQty = safeNumber(item.sh_stck_qty);
    const whStockQty = safeNumber(item.wh_stck_qty);
    
    // 출고량 정보 추가
    const totOutQty = safeNumber(item.tot_out_qty);
    
    // 리드타임 및 계수 추출
    const leadTimeDays = safeNumber(item.lead_time_days || 50);
    const targetSaleRate = safeNumber(item.target_sale_rate || 1);

    // 출고일부터 기준일까지 과거 판매기간 계산
    const formattedFirstOutboundDate = formatDate(itemFirstOutboundDate);
    const salesPeriodUntilReferenceDate = getDaysDifference(formattedFirstOutboundDate, referenceDate);
    
    // 판매마감일부터 기준일까지 예상 판매기간 계산 - 기본값 90일 (샘플 데이터 기준)
    const expectedSalesPeriod = salesEndDate ? getDaysDifference(referenceDate, salesEndDate) : 90;
    
    // 월별 판매량 데이터 추출 및 안전하게 변환
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
    
    // 주간 판매량 데이터 추출 및 안전하게 변환
    const week1SaleQty = safeNumber(item.week_1_sale_qty);
    const week2SaleQty = safeNumber(item.week_2_sale_qty);
    const week3SaleQty = safeNumber(item.week_3_sale_qty);
    const week4SaleQty = safeNumber(item.week_4_sale_qty);
    const week5SaleQty = safeNumber(item.week_5_sale_qty);
    const week6SaleQty = safeNumber(item.week_6_sale_qty);
    const week7SaleQty = safeNumber(item.week_7_sale_qty);
    const week8SaleQty = safeNumber(item.week_8_sale_qty);
    const week9SaleQty = safeNumber(item.week_9_sale_qty);
    const week10SaleQty = safeNumber(item.week_10_sale_qty);
    const week11SaleQty = safeNumber(item.week_11_sale_qty);
    const week12SaleQty = safeNumber(item.week_12_sale_qty);
    
    // 최근 7일 판매량 계산
    const weekly7dSaleQty = item.total_7d_sale_qty || // 직접 계산된 7일 판매량
      item.sales_qty_7d || // 필드 이름이 다를 경우 대비
      // 데이터가 없는 경우 월 판매량에서 추정
      (avgDailySales > 0 ? (avgDailySales * 7) : 0);
    
    // 소진 예상일 계산
    // 소진 예상일 계산 (일 단위)
    const daysUntilOutOfStockD30 = avgDailySalesD30 > 0 ? currentStock / avgDailySalesD30 : 999;
    const daysUntilOutOfStockD180 = avgDailySalesD180 > 0 ? currentStock / avgDailySalesD180 : 999;
    const daysUntilOutOfStockD365 = avgDailySalesD365 > 0 ? currentStock / avgDailySalesD365 : 999;
    
    // 창고재고 소진 예상일 계산
    const whDaysUntilOutOfStockD30 = avgDailySalesD30 > 0 ? whStockQty / avgDailySalesD30 : 999;
    const whDaysUntilOutOfStockD180 = avgDailySalesD180 > 0 ? whStockQty / avgDailySalesD180 : 999;
    const whDaysUntilOutOfStockD365 = avgDailySalesD365 > 0 ? whStockQty / avgDailySalesD365 : 999;
    
    // 버퍼 일수 계산
    const bufferDaysD30 = daysUntilOutOfStockD30 - leadTimeDays;
    const bufferDaysD180 = daysUntilOutOfStockD180 - leadTimeDays;
    const bufferDaysD365 = daysUntilOutOfStockD365 - leadTimeDays;
    
    // 창고재고 기준 버퍼 일수 계산
    const whBufferDaysD30 = whDaysUntilOutOfStockD30 - leadTimeDays;
    const whBufferDaysD180 = whDaysUntilOutOfStockD180 - leadTimeDays;
    const whBufferDaysD365 = whDaysUntilOutOfStockD365 - leadTimeDays;
    
    // 상태 판정
    const statusD30Size = calculateStatus(bufferDaysD30);
    const statusD180Size = calculateStatus(bufferDaysD180);
    const statusD365Size = calculateStatus(bufferDaysD365);
    
    // 창고 상태 판정
    const whStatusD30Size = calculateStatus(whBufferDaysD30);
    const whStatusD180Size = calculateStatus(whBufferDaysD180);
    const whStatusD365Size = calculateStatus(whBufferDaysD365);
    
    // 유효 판매량 선택 (일 단위)
    const effectiveDailySales = avgDailySalesD180 > 0 
      ? avgDailySalesD180 
      : (avgDailySalesD365 > 0 
        ? avgDailySalesD365 
        : (avgDailySalesD30 > 0
          ? avgDailySalesD30
          : avgDailySales));

    // 리드타임 동안의 예상 판매량
    const expectedSalesDuringLeadTime = effectiveDailySales * leadTimeDays;
    
    // 전체 판매 기간 동안의 예상 판매량
    const expectedSalesFullPeriod = effectiveDailySales * expectedSalesPeriod;
    
    // 예상 재고 계산
    const estimatedStock = Math.max(0, currentStock - expectedSalesDuringLeadTime);
    
    // 리드타임 동안 부족수량 계산
    const leadTimeShortageQty = Math.max(0, expectedSalesDuringLeadTime - currentStock);
    
    // 리드타임 기준 리오더 추천 수량
    const leadTimeRecommendedReorderQty = leadTimeShortageQty > 0 ? leadTimeShortageQty / targetSaleRate : 0;
    
    // 리드타임 기준 리오더 최종 수량
    const leadTimeFinalReorderQty = Math.ceil(leadTimeRecommendedReorderQty / 10) * 10;
    
    // 부족 수량 계산
    const shortageQty = Math.max(0, expectedSalesFullPeriod - currentStock);
    
    // 추천 수량 계산
    const recommendedReorderQty = shortageQty > 0 ? shortageQty / targetSaleRate : 0;
    
    // 최종 리오더 수량 계산
    const finalReorderQty = Math.ceil(recommendedReorderQty / 10) * 10;
    
    // 통합 추천 상태 결정 (OR 조건)
    const hasUrgent = [statusD30Size, statusD180Size, statusD365Size].some(s => s.includes('긴급'));
    const hasWarning = [statusD30Size, statusD180Size, statusD365Size].some(s => s.includes('주의'));
    const reorderRecommendingStatusSize = hasUrgent ? '긴급 🔴' : hasWarning ? '주의 🟡' : '양호 🟢';
    
    // 창고재고 기준 통합 추천 상태 결정
    const hasWhUrgent = [whStatusD30Size, whStatusD180Size, whStatusD365Size].some(s => s.includes('긴급'));
    const hasWhWarning = [whStatusD30Size, whStatusD180Size, whStatusD365Size].some(s => s.includes('주의'));
    const whReorderRecommendingStatusSize = hasWhUrgent ? '긴급 🔴' : hasWhWarning ? '주의 🟡' : '양호 🟢';

    // 이미지 URL 생성 로직 수정
    const itemImage = item.col_cd ? 
    `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${item.sty_cd}${item.col_cd}.jpg` : 
    `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${item.sty_cd}.jpg`;

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
      tot_out_qty: totOutQty,
      current_stock_qty: currentStock,
      sh_stck_qty: shStockQty,
      wh_stck_qty: whStockQty,
      avg_monthly_sales: avgMonthlySales,
      avg_monthly_sales_d30: avgMonthlySalesD30,
      avg_monthly_sales_d180: avgMonthlySalesD180,
      avg_monthly_sales_d365: avgMonthlySalesD365,
      avg_daily_sales: avgDailySales,
      avg_daily_sales_d7: avgDailySalesD7,
      avg_daily_sales_d30: avgDailySalesD30,
      avg_daily_sales_d180: avgDailySalesD180,
      avg_daily_sales_d365: avgDailySalesD365,
      weekly_7d_sale_qty: weekly7dSaleQty,
      sales_period_until_reference_date: salesPeriodUntilReferenceDate,
      expected_sales_period: expectedSalesPeriod, // 새로 추가: 예상 판매기간
      large_cat: item.large_cat || '',
      middle_cat: item.middle_cat || '',
      small_cat: item.small_cat || '',
      it_nm: item.it_nm || '',
      it_gb_nm: item.it_gb_nm || '',
      item_nm: item.item_nm || '',
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
      // 주간 판매량 추가
      week_1_sale_qty: week1SaleQty,
      week_2_sale_qty: week2SaleQty,
      week_3_sale_qty: week3SaleQty,
      week_4_sale_qty: week4SaleQty,
      week_5_sale_qty: week5SaleQty,
      week_6_sale_qty: week6SaleQty,
      week_7_sale_qty: week7SaleQty,
      week_8_sale_qty: week8SaleQty,
      week_9_sale_qty: week9SaleQty,
      week_10_sale_qty: week10SaleQty,
      week_11_sale_qty: week11SaleQty,
      week_12_sale_qty: week12SaleQty,
      // 추가 필드
      cust_cd: item.cust_cd || '',
      cust_nm: item.cust_nm || '',
      br_nm: item.br_nm || '',
      fabric: item.fabric || '',
      is_discontinued: isDiscontinued,
      series_name: item.series_name,
      colorKey: `${item.sty_cd}_${item.col_cd}`,
      item_image: itemImage,
      
      // 소진 예상일 관련 필드
      days_until_out_of_stock_d30: daysUntilOutOfStockD30,
      days_until_out_of_stock_d180: daysUntilOutOfStockD180,
      days_until_out_of_stock_d365: daysUntilOutOfStockD365,
      wh_days_until_out_of_stock_d30: whDaysUntilOutOfStockD30,
      wh_days_until_out_of_stock_d180: whDaysUntilOutOfStockD180,
      wh_days_until_out_of_stock_d365: whDaysUntilOutOfStockD365,
      
      // 버퍼 일수 관련 필드
      buffer_days_d30: bufferDaysD30,
      buffer_days_d180: bufferDaysD180,
      buffer_days_d365: bufferDaysD365,
      wh_buffer_days_d30: whBufferDaysD30,
      wh_buffer_days_d180: whBufferDaysD180,
      wh_buffer_days_d365: whBufferDaysD365,
      
      // 상태 판정 필드
      status_d30_size: statusD30Size,
      status_d180_size: statusD180Size,
      status_d365_size: statusD365Size,
      wh_status_d30_size: whStatusD30Size,
      wh_status_d180_size: whStatusD180Size,
      wh_status_d365_size: whStatusD365Size,
      reorder_recommending_status_size: reorderRecommendingStatusSize,
      wh_reorder_recommending_status_size: whReorderRecommendingStatusSize,
      
      // 리오더 관련 필드
      lead_time_days: leadTimeDays,
      target_sale_rate: targetSaleRate,
      // moq: moq,
      // expected_sales_period_months: expectedSalesPeriodMonths,
      effective_monthly_sales: avgMonthlySales,
      expected_sales_during_lead_time: expectedSalesDuringLeadTime,
      expected_sales_full_period: expectedSalesFullPeriod,
      estimated_stock: estimatedStock,
      shortage_qty: shortageQty,
      recommended_reorder_qty: recommendedReorderQty,
      final_reorder_qty: finalReorderQty,
      
      // 새로 추가된 리드타임 기준 필드
      lead_time_shortage_qty: leadTimeShortageQty,
      lead_time_recommended_reorder_qty: leadTimeRecommendedReorderQty,
      lead_time_final_reorder_qty: leadTimeFinalReorderQty
    };
  });
  console.log('analyzedItems 생성 완료, 첫번째 객체:', analyzedItems[0]);
  
  // 컬러별 그룹화
  const colorGroups = {};
  analyzedItems.forEach(item => {
    const colorKey = item.colorKey;
    if (!colorGroups[colorKey]) {
      colorGroups[colorKey] = [];
    }
    colorGroups[colorKey].push(item);
  });

  // 최종 결과 배열 (헤더+사이즈)
  const resultRows = [];

  // 각 컬러 그룹에 대해 헤더 행과 사이즈 행 추가
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
    
    // 재고 및 판매량 합계 계산
    const totalStock = items.reduce((sum, item) => sum + item.current_stock_qty, 0);
    const totalInQty = items.reduce((sum, item) => sum + item.tot_in_qty, 0);
    const totalSaleQty = items.reduce((sum, item) => sum + item.tot_sale_qty, 0);
    
    // 매장재고와 창고재고 합계 계산
    const totalShStockQty = items.reduce((sum, item) => sum + item.sh_stck_qty, 0);
    const totalWhStockQty = items.reduce((sum, item) => sum + item.wh_stck_qty, 0);
    
    // 출고량 합계 계산
    const totalOutQty = items.reduce((sum, item) => sum + item.tot_out_qty, 0);
    
    // 다양한 기간 기준 일 평균 판매량 합계 계산
    const totalAvgDailySales = items.reduce((sum, item) => sum + (item.avg_daily_sales || 0), 0);
    const totalAvgDailySalesD7 = items.reduce((sum, item) => sum + (item.avg_daily_sales_d7 || 0), 0);
    const totalAvgDailySalesD30 = items.reduce((sum, item) => sum + (item.avg_daily_sales_d30 || 0), 0);
    const totalAvgDailySalesD180 = items.reduce((sum, item) => sum + (item.avg_daily_sales_d180 || 0), 0);
    const totalAvgDailySalesD365 = items.reduce((sum, item) => sum + (item.avg_daily_sales_d365 || 0), 0);
    
    // 네 가지 기준의 평균 월 판매량 합계
    const totalMonthlySales = items.reduce((sum, item) => sum + item.avg_monthly_sales, 0);
    const totalMonthlySalesD30 = items.reduce((sum, item) => sum + item.avg_monthly_sales_d30, 0);
    const totalMonthlySalesD180 = items.reduce((sum, item) => sum + item.avg_monthly_sales_d180, 0);
    const totalMonthlySalesD365 = items.reduce((sum, item) => sum + item.avg_monthly_sales_d365, 0);

    // 월별 판매량 합계 계산
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

    // 주간 판매량 합계 계산
    const totalWeek1SaleQty = items.reduce((sum, item) => sum + (item.week_1_sale_qty || 0), 0);
    const totalWeek2SaleQty = items.reduce((sum, item) => sum + (item.week_2_sale_qty || 0), 0);
    const totalWeek3SaleQty = items.reduce((sum, item) => sum + (item.week_3_sale_qty || 0), 0);
    const totalWeek4SaleQty = items.reduce((sum, item) => sum + (item.week_4_sale_qty || 0), 0);
    const totalWeek5SaleQty = items.reduce((sum, item) => sum + (item.week_5_sale_qty || 0), 0);
    const totalWeek6SaleQty = items.reduce((sum, item) => sum + (item.week_6_sale_qty || 0), 0);
    const totalWeek7SaleQty = items.reduce((sum, item) => sum + (item.week_7_sale_qty || 0), 0);
    const totalWeek8SaleQty = items.reduce((sum, item) => sum + (item.week_8_sale_qty || 0), 0);
    const totalWeek9SaleQty = items.reduce((sum, item) => sum + (item.week_9_sale_qty || 0), 0);
    const totalWeek10SaleQty = items.reduce((sum, item) => sum + (item.week_10_sale_qty || 0), 0);
    const totalWeek11SaleQty = items.reduce((sum, item) => sum + (item.week_11_sale_qty || 0), 0);
    const totalWeek12SaleQty = items.reduce((sum, item) => sum + (item.week_12_sale_qty || 0), 0);

    // 최근 7일 판매량 합계
    const totalWeekly7dSaleQty = items.reduce((sum, item) => sum + item.weekly_7d_sale_qty, 0);
    
    // 평균 판매기간 계산
    const avgSalesPeriod = items.reduce((sum, item) => sum + (item.sales_period_until_reference_date || 0), 0) / items.length;
    
    // 예상 판매기간 평균 계산 (90일이 기본값)
    const expectedSalesPeriod = items.reduce((sum, item) => sum + item.expected_sales_period, 0) / items.length || 90;

    // 리오더 계산에 필요한 설정값
    const leadTimeDays = firstItem.lead_time_days || 50;
    const targetSaleRate = firstItem.target_sale_rate || 1;
    // const moq = firstItem.moq || 1000;
    // const expectedSalesPeriodMonths = firstItem.expected_sales_period_months || 6;
    
    // 소진 예상일 계산 (일 단위)
    const daysUntilOutOfStockD30 = totalMonthlySalesD30 > 0 ? totalStock / (totalMonthlySalesD30 / 30) : 999;
    const daysUntilOutOfStockD180 = totalMonthlySalesD180 > 0 ? totalStock / (totalMonthlySalesD180 / 30) : 999;
    const daysUntilOutOfStockD365 = totalMonthlySalesD365 > 0 ? totalStock / (totalMonthlySalesD365 / 30) : 999;

    // 버퍼 일수 계산
    const bufferDaysD30 = daysUntilOutOfStockD30 - leadTimeDays;
    const bufferDaysD180 = daysUntilOutOfStockD180 - leadTimeDays;
    const bufferDaysD365 = daysUntilOutOfStockD365 - leadTimeDays;

    // 상태 결정
    const statusD30 = calculateStatus(bufferDaysD30);
    const statusD180 = calculateStatus(bufferDaysD180);
    const statusD365 = calculateStatus(bufferDaysD365);
    
    // 통합 추천 상태 결정
    const hasUrgent = [statusD30, statusD180, statusD365].some(s => s.includes('긴급'));
    const hasWarning = [statusD30, statusD180, statusD365].some(s => s.includes('주의'));
    const reorderRecommendingStatus = hasUrgent ? '긴급 🔴' : hasWarning ? '주의 🟡' : '양호 🟢';
    
    // 창고재고 소진 예상일 계산
    const whDaysUntilOutOfStockD30 = totalAvgDailySalesD30 > 0 ? totalWhStockQty / (totalAvgDailySalesD30) : 999;
    const whDaysUntilOutOfStockD180 = totalAvgDailySalesD180 > 0 ? totalWhStockQty / (totalAvgDailySalesD180) : 999;
    const whDaysUntilOutOfStockD365 = totalAvgDailySalesD365 > 0 ? totalWhStockQty / (totalAvgDailySalesD365) : 999;

    // 창고재고 기준 버퍼 일수 계산
    const whBufferDaysD30 = whDaysUntilOutOfStockD30 - leadTimeDays;
    const whBufferDaysD180 = whDaysUntilOutOfStockD180 - leadTimeDays;
    const whBufferDaysD365 = whDaysUntilOutOfStockD365 - leadTimeDays;

    // 창고재고 기준 상태 결정
    const whStatusD30 = calculateStatus(whBufferDaysD30);
    const whStatusD180 = calculateStatus(whBufferDaysD180);
    const whStatusD365 = calculateStatus(whBufferDaysD365);
    
    // 창고재고 기준 통합 추천 상태 결정
    const hasWhUrgent = [whStatusD30, whStatusD180, whStatusD365].some(s => s.includes('긴급'));
    const hasWhWarning = [whStatusD30, whStatusD180, whStatusD365].some(s => s.includes('주의'));
    const whReorderRecommendingStatus = hasWhUrgent ? '긴급 🔴' : hasWhWarning ? '주의 🟡' : '양호 🟢';
    
    // 유효 판매량 선택
    const effectiveMonthlySales = totalMonthlySalesD180 > 0 
      ? totalMonthlySalesD180 
      : (totalMonthlySalesD365 > 0 
        ? totalMonthlySalesD365 
        : (totalMonthlySalesD30 > 0
          ? totalMonthlySalesD30
          : 0));
    
    // 일 평균 판매량 계산
    const effectiveDailySales = totalAvgDailySalesD180 > 0 
      ? totalAvgDailySalesD180
      : (totalAvgDailySalesD365 > 0
        ? totalAvgDailySalesD365
        : (totalAvgDailySalesD30 > 0
          ? totalAvgDailySalesD30
          : totalAvgDailySales));
    
    // 리드타임 동안의 예상 판매량
    const expectedSalesDuringLeadTime = effectiveDailySales * leadTimeDays;
    
    // 전체 판매 기간 동안의 예상 판매량
    const expectedSalesFullPeriod = effectiveDailySales * expectedSalesPeriod;
    
    // 부족 수량 계산
    const shortageQty = Math.max(0, expectedSalesFullPeriod - totalStock);
    
    // 추천 수량 계산
    const recommendedReorderQty = shortageQty > 0 ? shortageQty / targetSaleRate : 0;
    
    // 최종 리오더 수량 계산
    const finalReorderQty = Math.ceil(recommendedReorderQty / 10) * 10;
    
    // 예상 재고 계산
    const estimatedStock = Math.max(0, totalStock - expectedSalesDuringLeadTime);
    
    // 리드타임 동안 부족수량 계산
    const leadTimeShortageQty = Math.max(0, expectedSalesDuringLeadTime - totalStock);
    
    // 리드타임 기준 리오더 추천 수량
    const leadTimeRecommendedReorderQty = leadTimeShortageQty > 0 ? leadTimeShortageQty / targetSaleRate : 0;
    
    // 리드타임 기준 리오더 최종 수량
    const leadTimeFinalReorderQty = Math.ceil(leadTimeRecommendedReorderQty / 10) * 10;
    
    // 판매율 계산
    const saleRate = totalInQty > 0 ? (totalSaleQty / totalInQty) : 0;
    
    // 출고율 및 매장 판매 효율 계산
    const outRate = totalInQty > 0 ? (totalOutQty / totalInQty) : 0;
    const saleOutRate = totalOutQty > 0 ? (totalSaleQty / totalOutQty) : 0;
    
    // 사이즈별 상태 분석
    const sizeStatusData = items.map(item => ({
      size_cd: item.size_cd,
      size_nm: item.size_nm,
      // 상태 정보
      status_d30_size: item.status_d30_size || '양호 🟢',
      status_d180_size: item.status_d180_size || '양호 🟢',
      status_d365_size: item.status_d365_size || '양호 🟢',
      reorder_recommending_status_size: item.reorder_recommending_status_size || '양호 🟢',
      // 창고재고 기준 상태
      wh_status_d30_size: item.wh_status_d30_size || '양호 🟢',
      wh_status_d180_size: item.wh_status_d180_size || '양호 🟢',
      wh_status_d365_size: item.wh_status_d365_size || '양호 🟢',
      wh_reorder_recommending_status_size: item.wh_reorder_recommending_status_size || '양호 🟢',
      // 재고 및 판매 정보
      current_stock_qty: item.current_stock_qty,
      wh_stck_qty: item.wh_stck_qty,
      tot_out_qty: item.tot_out_qty,
      avg_monthly_sales: Math.max(
        item.avg_monthly_sales_d180 || 0,
        item.avg_monthly_sales_d365 || 0,
        item.avg_monthly_sales_d30 || 0
      )
    }));
    
    // 사이즈별 상태 요약 - 위험도순 정렬
    const sortedSizeStatus = [...sizeStatusData].sort((a, b) => {
      const aPriority = getStatusPriority(a.wh_reorder_recommending_status_size, a.reorder_recommending_status_size);
      const bPriority = getStatusPriority(b.wh_reorder_recommending_status_size, b.reorder_recommending_status_size);
      
      if (aPriority !== bPriority) return aPriority - bPriority;
      if (a.current_stock_qty !== b.current_stock_qty) return a.current_stock_qty - b.current_stock_qty;
      if (a.avg_monthly_sales !== b.avg_monthly_sales) return b.avg_monthly_sales - a.avg_monthly_sales;
      
      return 0;
    });
    
    // 사이즈별 상태 요약 생성
    const sizeStatusSummary = sortedSizeStatus.map(size => ({
      size_nm: size.size_nm,
      stock: size.current_stock_qty,
      wh_stock: size.wh_stck_qty,
      status: size.reorder_recommending_status_size,
      wh_status: size.wh_reorder_recommending_status_size,
      out_qty: size.tot_out_qty
    }));

    // 사이즈별 상태 카운트
    const totalUrgentSizeCount = sizeStatusData.filter(s => s.reorder_recommending_status_size.includes('긴급')).length;
    const totalWarningSizeCount = sizeStatusData.filter(s => s.reorder_recommending_status_size.includes('주의')).length;
    const totalWhUrgentSizeCount = sizeStatusData.filter(s => s.wh_reorder_recommending_status_size.includes('긴급')).length;
    const totalWhWarningSizeCount = sizeStatusData.filter(s => s.wh_reorder_recommending_status_size.includes('주의')).length;
    
    // 정렬을 위한 추가 지표 계산
    const urgentCount = [statusD30, statusD180, statusD365].filter(s => s.includes('긴급')).length;
    const warningCount = [statusD30, statusD180, statusD365].filter(s => s.includes('주의')).length;
    const whUrgentCount = [whStatusD30, whStatusD180, whStatusD365].filter(s => s.includes('긴급')).length;
    const whWarningCount = [whStatusD30, whStatusD180, whStatusD365].filter(s => s.includes('주의')).length;
    
    // 컬러 그룹 내 날짜 찾기
    let groupLastSalesDate = '';
    let groupFirstSalesDate = '';
    let groupFirstInventoryDate = '';
    let groupLastInventoryDate = '';
    let groupFirstOutboundDate = '';

    items.forEach(item => {
      // 날짜 정보 수집
      if (item.last_sales_dt && (!groupLastSalesDate || item.last_sales_dt > groupLastSalesDate)) {
        groupLastSalesDate = item.last_sales_dt;
      }
      
      if (item.first_sales_dt && (!groupFirstSalesDate || item.first_sales_dt < groupFirstSalesDate)) {
        groupFirstSalesDate = item.first_sales_dt;
      }
      
      if (item.first_inventory_date && (!groupFirstInventoryDate || item.first_inventory_date < groupFirstInventoryDate)) {
        groupFirstInventoryDate = item.first_inventory_date;
      }
      
      if (item.last_inventory_date && (!groupLastInventoryDate || item.last_inventory_date > groupLastInventoryDate)) {
        groupLastInventoryDate = item.last_inventory_date;
      }

      if (item.first_outbound_date && (!groupFirstOutboundDate || item.first_outbound_date < groupFirstOutboundDate)) {
        groupFirstOutboundDate = item.first_outbound_date;
      }
    });
    
    // 컬러 그룹의 판매기간 계산
    const formattedGroupFirstOutboundDate = formatDate(groupFirstOutboundDate);
    const groupSalesPeriodUntilReferenceDate = getDaysDifference(formattedGroupFirstOutboundDate, referenceDate);
    
    // 이미지 URL 확인
    const itemImage = firstItem.col_cd ? 
    `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${firstItem.sty_cd}${firstItem.col_cd}.jpg` : 
    `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${firstItem.sty_cd}.jpg`;

    // 헤더 행 생성
    const headerRow = {
      // 이미지 정보
      item_image: itemImage,
      
      // 기본 정보
      sty_nm: firstItem.sty_nm,
      col_nm: firstItem.col_nm,
      size_nm: '-',
      tag_price: firstItem.tag_price,
      cost_price: firstItem.cost_price,
      price_multiple: firstItem.cost_price > 0 ? (firstItem.tag_price / firstItem.cost_price / 1.1) : 0,
      
      // 날짜 정보
      first_sales_dt: groupFirstSalesDate,
      last_sales_dt: groupLastSalesDate,
      first_inventory_date: groupFirstInventoryDate,
      last_inventory_date: groupLastInventoryDate,
      first_outbound_date: groupFirstOutboundDate,
      sales_end_date: salesEndDate,
      reference_date: referenceDate,
      sales_period_until_reference_date: groupSalesPeriodUntilReferenceDate,
      expected_sales_period: Math.round(expectedSalesPeriod), // 예상 판매기간 추가
      
      // 수량 정보
      tot_in_qty: totalInQty,
      tot_sale_qty: totalSaleQty,
      tot_out_qty: totalOutQty,
      current_stock_qty: totalStock,
      sh_stck_qty: totalShStockQty,
      wh_stck_qty: totalWhStockQty,
      sale_rate: saleRate,
      out_rate: outRate,
      sale_out_rate: saleOutRate,
      estimated_stock: estimatedStock,

      // 일 평균 판매량 정보
      avg_daily_sales: totalAvgDailySales,
      avg_daily_sales_d7: totalAvgDailySalesD7,
      avg_daily_sales_d30: totalAvgDailySalesD30,
      avg_daily_sales_d180: totalAvgDailySalesD180,
      avg_daily_sales_d365: totalAvgDailySalesD365,

      // 판매량 정보
      avg_monthly_sales_d30: totalMonthlySalesD30,
      avg_monthly_sales_d180: totalMonthlySalesD180,
      avg_monthly_sales_d365: totalMonthlySalesD365,
      weekly_7d_sale_qty: totalWeekly7dSaleQty,

      // 월별 판매량
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

      // 주간 판매량
      week_1_sale_qty: totalWeek1SaleQty,
      week_2_sale_qty: totalWeek2SaleQty,
      week_3_sale_qty: totalWeek3SaleQty,
      week_4_sale_qty: totalWeek4SaleQty,
      week_5_sale_qty: totalWeek5SaleQty,
      week_6_sale_qty: totalWeek6SaleQty,
      week_7_sale_qty: totalWeek7SaleQty,
      week_8_sale_qty: totalWeek8SaleQty,
      week_9_sale_qty: totalWeek9SaleQty,
      week_10_sale_qty: totalWeek10SaleQty,
      week_11_sale_qty: totalWeek11SaleQty,
      week_12_sale_qty: totalWeek12SaleQty,

      // 최근 평균 판매량
      recent_6month_avg_sale_qty: [
        totalMonth1SaleQty, totalMonth2SaleQty, totalMonth3SaleQty,
        totalMonth4SaleQty, totalMonth5SaleQty, totalMonth6SaleQty
      ].reduce((sum, qty) => sum + qty, 0) / 6,
      
      recent_12month_avg_sale_qty: [
        totalMonth1SaleQty, totalMonth2SaleQty, totalMonth3SaleQty,
        totalMonth4SaleQty, totalMonth5SaleQty, totalMonth6SaleQty,
        totalMonth7SaleQty, totalMonth8SaleQty, totalMonth9SaleQty,
        totalMonth10SaleQty, totalMonth11SaleQty, totalMonth12SaleQty
      ].reduce((sum, qty) => sum + qty, 0) / 12,
      
      // 소진 예상일
      daysUntilOutOfStock_d30: daysUntilOutOfStockD30,
      daysUntilOutOfStock_d180: daysUntilOutOfStockD180,
      daysUntilOutOfStock_d365: daysUntilOutOfStockD365,
      
      // 상태 정보
      status_d30: statusD30,
      status_d180: statusD180,
      status_d365: statusD365,
      reorder_recommending_status: reorderRecommendingStatus,
      
      // 창고재고 소진 예상일
      whDaysUntilOutOfStock_d30: whDaysUntilOutOfStockD30,
      whDaysUntilOutOfStock_d180: whDaysUntilOutOfStockD180,
      whDaysUntilOutOfStock_d365: whDaysUntilOutOfStockD365,
      
      // 창고 상태 정보
      wh_status_d30: whStatusD30,
      wh_status_d180: whStatusD180,
      wh_status_d365: whStatusD365,
      wh_reorder_recommending_status: whReorderRecommendingStatus,
      
      // 리오더 정보
      effective_monthly_sales: effectiveMonthlySales,
      expected_sales_during_lead_time: expectedSalesDuringLeadTime,
      expected_sales_full_period: expectedSalesFullPeriod,
      recommended_reorder_qty: recommendedReorderQty,
      shortage_qty: shortageQty, // 부족수량 필드 추가
      final_reorder_qty: finalReorderQty,
      
      // 새로 추가된 리드타임 기준 필드
      lead_time_shortage_qty: leadTimeShortageQty,
      lead_time_recommended_reorder_qty: leadTimeRecommendedReorderQty,
      lead_time_final_reorder_qty: leadTimeFinalReorderQty,
      
      // 추가 정보
      sty_cd: firstItem.sty_cd,
      col_cd: firstItem.col_cd,
      size_cd: '',
      large_cat: firstItem.large_cat,
      middle_cat: firstItem.middle_cat,
      small_cat: firstItem.small_cat,
      it_nm: firstItem.it_nm,
      it_gb_nm: firstItem.it_gb_nm,
      item_nm: firstItem.item_nm,
      cust_cd: firstItem.cust_cd,
      cust_nm: firstItem.cust_nm, 
      br_nm: firstItem.br_nm,
      fabric: firstItem.fabric,
      
      is_discontinued: isColorDiscontinued,
      series_name: firstItem.series_name,
      
      // 계산 설정값
      lead_time_days: leadTimeDays,
      target_sale_rate: targetSaleRate,
      // moq: moq,
      // expected_sales_period_months: expectedSalesPeriodMonths,
      
      // 메타 정보
      urgentCount: urgentCount,
      warningCount: warningCount,
      whUrgentCount: whUrgentCount,
      whWarningCount: whWarningCount,
      
      // 사이즈별 상태
      size_status_summary: sizeStatusSummary,
      total_urgent_size_count: totalUrgentSizeCount,
      total_warning_size_count: totalWarningSizeCount,
      total_wh_urgent_size_count: totalWhUrgentSizeCount,
      total_wh_warning_size_count: totalWhWarningSizeCount,
      
      _type: 'header',
      groupId: colorKey,
    };
    
    // 헤더 행 추가
    resultRows.push(headerRow);

    // 사이즈 행 추가
    items.forEach(sizeItem => {
      resultRows.push({
        ...sizeItem,
        _type: 'size',
        groupId: colorKey
      });
    });
  }

  return resultRows;
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