// Retool에서 사용할 데이터 준비 함수 (하드코딩 제거)
function exportReorderDataToExcel() {
    // 데이터 가져오기 (selectedReorderItems에서)
    const reorderData = selectedReorderItems.value || [];

    if (!reorderData || reorderData.length === 0) {
      try {
        utils.toast.error("내보낼 데이터가 없습니다.");
      } catch (e) {
        console.log("Toast 에러:", e);
      }
      return {
        success: false,
        message: "내보낼 데이터가 없습니다.",
        combinedTableData: [],
        reviewColorTableData: [],
        reviewSizeTableData: [],
        rawColorTableData: [],
        rawSizeTableData: []
      };
    }

    // 첫 번째 아이템 구조 확인 (디버깅용)
    console.log("첫 번째 아이템 구조:", JSON.stringify(reorderData[0], null, 2));

    // 현재 날짜 (YYYY-MM-DD 형식)
    const today = new Date().toISOString().split('T')[0];

    // 날짜 차이 계산 함수 (일 단위)
    function getDaysDifference(startDateStr, endDateStr) {
      if (!startDateStr || !endDateStr) return 0;

      const start = new Date(startDateStr);
      const end = new Date(endDateStr);

      if (isNaN(start.getTime()) || isNaN(end.getTime())) return 0;

      // 차이 계산 (밀리초 -> 일) + 1 (당일 포함)
      const diffDays = Math.floor((end - start) / (1000 * 60 * 60 * 24)) + 1;
      return Math.max(0, diffDays); // 음수가 되지 않도록 보장
    }

    // 리오더 납기일 계산 함수
    function calculateReorderDeliveryDate(referenceDateStr, leadTimeDays) {
      if (!referenceDateStr || !leadTimeDays) return '';

      const referenceDate = new Date(referenceDateStr);
      if (isNaN(referenceDate.getTime())) return '';

      // 리드타임을 더해서 납기일 계산
      referenceDate.setDate(referenceDate.getDate() + parseInt(leadTimeDays));

      return referenceDate.toISOString().split('T')[0];
    }

    // 일 판매량 기반 예상 판매량 계산 함수
    function calculateExpectedSales(dailySales, days) {
      if (!dailySales || !days || days <= 0) return 0;
      return Math.round(dailySales * days);
    }

    // 퍼센티지 형식 변환 함수 (소수를 퍼센트로 변환)
    function formatPercentage(value) {
      if (value === null || value === undefined) return '0%';
      return Math.round(value * 100) + '%';
    }

    // 금액을 천 단위로 표시하는 함수
    function formatCurrency(amount) {
      if (amount === null || amount === undefined || isNaN(amount)) return '0';
      return Math.round(amount).toLocaleString('ko-KR');
    }

    // MD 메모 처리 함수
    function formatMdMemo(memo) {
      if (!memo || memo === "(메모 없음)") return '';
      return memo;
    }

    // 성장률 포맷 함수 (값이 이미 퍼센트 형태가 아닌 경우만 % 추가)
    function formatGrowthRate(value) {
      if (value === null || value === undefined || value === '') return '';
      // 이미 %가 포함되어 있으면 그대로 반환
      if (String(value).includes('%')) return String(value);
      // 숫자만 있으면 % 추가
      return value + '%';
    }

    // CSV 값 이스케이프 함수 (이 함수는 더 이상 CSV 생성을 하지 않으므로 불필요하지만, 원본 코드와의 일관성을 위해 유지)
    function escapeCSVValue(value) {
      if (value === null || value === undefined) return '';

      if (typeof value === 'number') return value.toString();

      let strValue = String(value);

      if (strValue.includes(',') || strValue.includes('"') || strValue.includes('\n') || strValue.includes('\r') || strValue.includes('\t')) {
        strValue = strValue.replace(/"/g, '""');
        return '"' + strValue + '"';
      }

      return strValue;
    }

    // 모든 테이블 데이터를 저장할 변수들
    let rawColorTableData = [];
    let rawSizeTableData = [];
    let reviewSizeTableData = [];
    let reviewColorTableData = [];
    let combinedTableData = [];

    try {
      // --- 1. 리오더 검토의 건 테이블 ---
      console.log("리오더 검토 테이블 생성 시작");
      reorderData.forEach(item => {
        // reference_info, production_info, sales_performance, reorder_info가 있는 경우
        if (item.reference_info || item.production_info || item.sales_performance || item.reorder_info) {
          const referenceInfo = item.reference_info || {};
          const productionInfo = item.production_info || {};
          const salesPerformance = item.sales_performance || {};
          const reorderInfo = item.reorder_info || {};

          let totalQty = 0;
          if (item.size_reorder_info && Array.isArray(item.size_reorder_info)) {
            totalQty = item.size_reorder_info.reduce((sum, size) => sum + (size.reorder_qty || 0), 0);
          }

          const tagPrice = productionInfo["TAG가"] || productionInfo["리오더 TAG가"] || 0;
          const amount = tagPrice * totalQty;

          reviewColorTableData.push({
            "품번": referenceInfo.sty_cd || '',
            "컬러명": referenceInfo.col_nm || '',
            "품명": referenceInfo.sty_nm || '',
            "생산처": productionInfo["생산업체"] || '',
            "판가(TAG가)": tagPrice,
            "수량(pcs)": totalQty,
            "금액": formatCurrency(amount),
            "성장률(%)": formatGrowthRate(reorderInfo["성장률(%)"]),
            "리드타임(일)": reorderInfo["리드타임(일)"] || '',
            "납기일": reorderInfo["리오더 납기일"] || reorderInfo["리오더 입고 예상일"] || '',
            "기준일": salesPerformance["기준일"] || today,
            "누적 판매량": salesPerformance["누적 판매량"] || 0,
            "최근 7일 판매량": salesPerformance["최근 7일 판매량"] || 0,
            "생산팀 메모": productionInfo["생산팀 메모"] || '',
            "MD 메모": formatMdMemo(reorderInfo["MD 메모"])
          });
        } else {
          // 직접 필드가 있는 경우 (샘플 데이터 구조)
          let totalQty = item.final_reorder_qty || 0;
          if (item._childrenArray && Array.isArray(item._childrenArray)) {
            const childTotal = item._childrenArray.reduce((sum, size) => sum + (size.size_reorder_qty || 0), 0);
            if (childTotal > 0) totalQty = childTotal;
          }

          const tagPrice = item.tag_price || 0;
          const amount = tagPrice * totalQty;

          // 리오더 납기일 계산
          const reorderDeliveryDate = item.reorder_delivery_date ||
            calculateReorderDeliveryDate(item.reference_date || today, item.lead_time_days);

          reviewColorTableData.push({
            "품번": item.sty_cd || '',
            "컬러명": item.col_nm || '',
            "품명": item.sty_nm || '',
            "생산처": item.cust_nm || '',
            "판가(TAG가)": tagPrice,
            "수량(pcs)": totalQty,
            "금액": formatCurrency(amount),
            "성장률(%)": formatGrowthRate(item.growth_rate),
            "리드타임(일)": item.lead_time_days || '',
            "납기일": reorderDeliveryDate,
            "기준일": item.reference_date || today,
            "누적 판매량": item.tot_sale_qty || 0,
            "최근 7일 판매량": Math.round(item.weekly_7d_sale_qty || 0),
            "생산팀 메모": item.production_memo || '',
            "MD 메모": formatMdMemo(item.md_memo)
          });
        }
      });
      console.log("리오더 검토 테이블 생성 완료:", reviewColorTableData.length, "개");

      // --- 2. 상신용 아소트 테이블 ---
      console.log("상신용 아소트 테이블 생성 시작");

      // 모든 사이즈 수집
      const allSizes = [...new Set(
        reorderData.flatMap(item => {
          if (item.size_reorder_info && Array.isArray(item.size_reorder_info)) {
            return item.size_reorder_info.map(size => size.size_nm);
          } else if (item._childrenArray && Array.isArray(item._childrenArray)) {
            return item._childrenArray.map(size => size.size_nm);
          }
          return [];
        })
      )];

      // 요청하신 사이즈 순서 정의 (우선순위 부여)
      const customSizeOrder = [
        "NB", "3M", "6M", "12M", "18M",
        "2Y", "3Y", "4Y",
        "115", "125", "130", "140",
        "7-8", "9-10", "11-12", "13-14",
        "42", "44", "46", "48", "50", "52"
      ];

      allSizes.sort((a, b) => {
        const indexA = customSizeOrder.indexOf(a);
        const indexB = customSizeOrder.indexOf(b);

        // customSizeOrder에 없는 사이즈는 마지막으로 보내거나,
        // 아니면 문자열 오름차순으로 정렬 (여기서는 뒤로 보내는 방식)
        if (indexA === -1 && indexB === -1) {
            return a.localeCompare(b); // 둘 다 없으면 문자열 비교
        } else if (indexA === -1) {
            return 1; // A가 없으면 B가 우선
        } else if (indexB === -1) {
            return -1; // B가 없으면 A가 우선
        }
        return indexA - indexB; // 둘 다 있으면 정의된 순서대로 정렬
      });


      reorderData.forEach(item => {
        const rowData = {};
        let totalQty = 0;

        // reference_info가 있는 경우
        if (item.reference_info) {
          rowData["품번"] = item.reference_info.sty_cd || '';
          rowData["품명"] = item.reference_info.sty_nm || '';
          rowData["컬러명"] = item.reference_info.col_nm || '';

          // 사이즈별 수량
          if (item.size_reorder_info && Array.isArray(item.size_reorder_info)) {
            item.size_reorder_info.forEach(size => {
              const sizeName = size.size_nm || '';
              const reorderQty = size.reorder_qty || 0;
              rowData[sizeName] = reorderQty;
              totalQty += reorderQty;
            });
          }

          rowData["TTL"] = totalQty;
          rowData["납기일"] = item.reorder_info?.["리오더 납기일"] || item.reorder_info?.["리오더 입고 예상일"] || '';

          // 비고란에 메모 처리
          const productionMemo = item.production_info?.["생산팀 메모"] || '';
          const mdMemo = formatMdMemo(item.reorder_info?.["MD 메모"]);
          rowData["비고"] = `${productionMemo} ${mdMemo}`.trim();
        } else {
          // 직접 필드가 있는 경우
          rowData["품번"] = item.sty_cd || '';
          rowData["품명"] = item.sty_nm || '';
          rowData["컬러명"] = item.col_nm || '';

          if (item._childrenArray && Array.isArray(item._childrenArray)) {
            item._childrenArray.forEach(size => {
              const sizeName = size.size_nm || '';
              const reorderQty = size.size_reorder_qty || 0;
              rowData[sizeName] = reorderQty;
              totalQty += reorderQty;
            });
          }

          rowData["TTL"] = totalQty || item.final_reorder_qty || 0;

          // 리오더 납기일 계산
          const reorderDeliveryDate = item.reorder_delivery_date ||
            calculateReorderDeliveryDate(item.reference_date || today, item.lead_time_days);
          rowData["납기일"] = reorderDeliveryDate;

          const productionMemo = item.production_memo || '';
          const mdMemo = formatMdMemo(item.md_memo);
          rowData["비고"] = `${productionMemo} ${mdMemo}`.trim();
        }

        // --- 여기서 reviewSizeTableData 에 배열의 map 함수 적용 ---
        // Create the final ordered row object
        const orderedRow = {
          "품번": rowData["품번"],
          "품명": rowData["품명"],
          "컬러명": rowData["컬러명"]
        };

        // Add size-specific columns based on the sorted allSizes
        allSizes.forEach(size => {
          orderedRow[size] = rowData[size] || 0; // Ensure all sizes are present, default to 0
        });

        // Add TTL, 납기일, and 비고 columns
        orderedRow["TTL"] = rowData["TTL"];
        orderedRow["납기일"] = rowData["납기일"];
        orderedRow["비고"] = rowData["비고"];

        reviewSizeTableData.push(orderedRow);
      });
      console.log("상신용 아소트 테이블 생성 완료:", reviewSizeTableData.length, "개");

      // --- 3. 컬러 단위 상세 정보 (메인 테이블) ---
      console.log("메인 테이블 데이터 생성 시작");
      reorderData.forEach((item) => {
        if (item.reference_info || item.production_info) {
          const referenceInfo = item.reference_info || {};
          const productionInfo = item.production_info || {};
          const salesPerformance = item.sales_performance || {};
          const reorderInfo = item.reorder_info || {};

          const sizeInfoArray = item.size_reorder_info || [];
          let totalReorderQty = sizeInfoArray.reduce((sum, size) => sum + (size.reorder_qty || 0), 0);

          // 날짜 정보 추출
          const referenceDate = salesPerformance["기준일"] || today;
          const salesEndDate = reorderInfo["판매 마감일"] || '';
          const leadTimeDays = parseInt(reorderInfo["리드타임(일)"] || 0);

          // 리오더 납기일 계산
          const reorderDeliveryDate = reorderInfo["리오더 납기일"] ||
                                         reorderInfo["리오더 입고 예상일"] ||
                                         calculateReorderDeliveryDate(referenceDate, leadTimeDays);

          // 리오더 납기일~판매 마감일 계산
          const deliveryToSalesEndDays = getDaysDifference(reorderDeliveryDate, salesEndDate);

          // 기준일~판매마감일 계산
          const referenceTosalesEndDays = getDaysDifference(referenceDate, salesEndDate);

          // 일 판매량
          const dailySales = parseFloat(salesPerformance["일 판매량"] || 0);

          // 기준일~마감일 예상 판매량 계산
          const expectedSales = calculateExpectedSales(dailySales, referenceTosalesEndDays);

          rawColorTableData.push({
            "품명": referenceInfo.sty_nm || '',
            "컬러명": referenceInfo.col_nm || '',
            "품번": referenceInfo.sty_cd || '',
            "컬러코드": referenceInfo.col_cd || '',
            "생산업체": productionInfo["생산업체"] || '',
            "TAG가": productionInfo["TAG가"] || 0,
            "원가": productionInfo["원가"] || 0,
            "배수": productionInfo["배수"] || 0,
            "출고일": productionInfo["출고일"] || '',
            "입고 수량": productionInfo["입고 수량"] || 0,
            "출고 수량": productionInfo["출고 수량"] || 0,
            "출고율": formatPercentage(productionInfo["출고율"]),
            "기준일": referenceDate,
            "누적 판매량": salesPerformance["누적 판매량"] || 0,
            "누적 판매율": formatPercentage(salesPerformance["누적 판매율(입고 기준)"]),
            "출고~기준일 판매일수": salesPerformance["출고~기준일 판매일수"] || 0,
            "일 판매량": dailySales,
            "최근 7일 판매량": salesPerformance["최근 7일 판매량"] || 0,
            "현재총재고": reorderInfo["현재 총재고"] || 0,
            "매장재고": productionInfo["매장재고"] || item.sh_stck_qty || 0,
            "창고재고": productionInfo["창고재고"] || item.wh_stck_qty || 0,
            "업체재고": productionInfo["업체재고"] || 0,
            "리드타임(일)": leadTimeDays,
            "리오더 납기일": reorderDeliveryDate,
            "판매 마감일": salesEndDate,
            "기준일~판매마감일": referenceTosalesEndDays,
            "기준일~마감일 예상 판매량": expectedSales || reorderInfo["예상 판매량"] || 0,
            "부족 수량": reorderInfo["부족 수량"] || 0,
            "리오더 수량": totalReorderQty,
            "리오더 TAG가": productionInfo["리오더 TAG가"] || productionInfo["TAG가"] || 0,
            "리오더 원가": productionInfo["리오더 원가"] || productionInfo["원가"] || 0,
            "리오더 배수": productionInfo["리오더 배수"] || productionInfo["배수"] || 0,
            "성장률(%)": formatGrowthRate(reorderInfo["성장률(%)"]),
            "리오더 납기일~판매 마감일": deliveryToSalesEndDays,
            "생산팀 메모": productionInfo["생산팀 메모"] || '',
            "MD 메모": formatMdMemo(reorderInfo["MD 메모"])
          });
        } else {
          // 직접 필드가 있는 경우
          let totalReorderQty = item.final_reorder_qty || 0;
          if (item._childrenArray && Array.isArray(item._childrenArray)) {
            const childTotal = item._childrenArray.reduce((sum, size) => sum + (size.size_reorder_qty || 0), 0);
            if (childTotal > 0) totalReorderQty = childTotal;
          }

          // 날짜 정보
          const referenceDate = item.reference_date || today;
          const salesEndDate = item.sales_end_date || '';
          const leadTimeDays = parseInt(item.lead_time_days || 0);

          // 리오더 납기일 계산
          const reorderDeliveryDate = item.reorder_delivery_date ||
            calculateReorderDeliveryDate(referenceDate, leadTimeDays);

          // 리오더 납기일~판매 마감일 계산
          const deliveryToSalesEndDays = getDaysDifference(reorderDeliveryDate, salesEndDate);

          // 기준일~판매마감일 계산 (expected_sales_period 우선 사용)
          const referenceTosalesEndDays = item.expected_sales_period || getDaysDifference(referenceDate, salesEndDate);

          // 일 판매량 (우선순위: avg_daily_sales_d180 > avg_daily_sales)
          const dailySales = item.avg_daily_sales_d180 || item.avg_daily_sales || 0;

          // 기준일~마감일 예상 판매량 계산 (expected_sales_full_period 우선 사용)
          const expectedSales = item.expected_sales_full_period || calculateExpectedSales(dailySales, referenceTosalesEndDays);

          rawColorTableData.push({
            "품명": item.sty_nm || '',
            "컬러명": item.col_nm || '',
            "품번": item.sty_cd || '',
            "컬러코드": item.col_cd || '',
            "생산업체": item.cust_nm || '',
            "TAG가": item.tag_price || 0,
            "원가": item.cost_price || 0,
            "배수": Math.round((item.price_multiple || 0) * 10) / 10,
            "출고일": item.first_outbound_date || '',
            "입고 수량": item.tot_in_qty || 0,
            "출고 수량": item.tot_out_qty || 0,
            "출고율": formatPercentage(item.out_rate),
            "기준일": referenceDate,
            "누적 판매량": item.tot_sale_qty || 0,
            "누적 판매율": formatPercentage(item.sale_rate),
            "출고~기준일 판매일수": item.sales_period_until_reference_date || 0,
            "일 판매량": Math.round(dailySales * 10) / 10,
            "최근 7일 판매량": Math.round(item.weekly_7d_sale_qty || 0),
            "현재총재고": item.current_stock_qty || 0,
            "매장재고": item.sh_stck_qty || 0,
            "창고재고": item.wh_stck_qty || 0,
            "업체재고": 0,
            "리드타임(일)": leadTimeDays,
            "리오더 납기일": reorderDeliveryDate,
            "판매 마감일": salesEndDate,
            "기준일~판매마감일": referenceTosalesEndDays,
            "기준일~마감일 예상 판매량": Math.round(expectedSales),
            "부족 수량": Math.round(item.shortage_qty || 0),
            "리오더 수량": totalReorderQty,
            "리오더 TAG가": item.tag_price || 0,
            "리오더 원가": item.cost_price || 0,
            "리오더 배수": Math.round((item.price_multiple || 0) * 10) / 10,
            "성장률(%)": formatGrowthRate(item.growth_rate),
            "리오더 납기일~판매 마감일": deliveryToSalesEndDays,
            "생산팀 메모": item.production_memo || '',
            "MD 메모": formatMdMemo(item.md_memo)
          });
        }
      });
      console.log("메인 테이블 데이터 생성 완료:", rawColorTableData.length, "개");

      // --- 4. 사이즈 단위 상세 정보 ---
      console.log("사이즈 테이블 데이터 생성 시작");
      reorderData.forEach(item => {
        if (item.size_reorder_info && Array.isArray(item.size_reorder_info)) {
          const referenceInfo = item.reference_info || {};

          item.size_reorder_info.forEach(sizeInfo => {
            rawSizeTableData.push({
              "품명": referenceInfo.sty_nm || '',
              "컬러명": referenceInfo.col_nm || '',
              "품번": referenceInfo.sty_cd || '',
              "컬러 코드": referenceInfo.col_cd || '',
              "사이즈명": sizeInfo.size_nm || '',
              "입고량": sizeInfo.size_in_count || 0,
              "입고율": formatPercentage(sizeInfo.size_in_ratio),
              "출고량": sizeInfo.size_out_count || 0,
              "출고율": formatPercentage(sizeInfo.size_out_ratio),
              "판매량": sizeInfo.size_sales_count || 0,
              "판매비": formatPercentage(sizeInfo.size_sales_ratio),
              "출고율-판매비": formatPercentage(sizeInfo.size_out_ratio_diff),
              "판매율": formatPercentage(sizeInfo.size_sales_rate),
              "판매 마감일까지 일수": sizeInfo.days_until_sales_end || 0,
              "예상 판매량": sizeInfo.expected_sales || 0,
              "현재 총재고": sizeInfo.total_stock || 0,
              "부족 수량": sizeInfo.shortage_qty || 0,
              "리오더 수량": sizeInfo.reorder_qty || 0
            });
          });
        } else if (item._childrenArray && Array.isArray(item._childrenArray)) {
          item._childrenArray.forEach(sizeItem => {
            rawSizeTableData.push({
              "품명": item.sty_nm || '',
              "컬러명": item.col_nm || '',
              "품번": item.sty_cd || '',
              "컬러 코드": item.col_cd || '',
              "사이즈명": sizeItem.size_nm || '',
              "입고량": sizeItem.tot_in_qty || 0,
              "입고율": formatPercentage(sizeItem.size_distribution_ratio || 0),
              "출고량": sizeItem.tot_out_qty || 0,
              "출고율": formatPercentage(sizeItem.out_rate || 0),
              "판매량": sizeItem.tot_sale_qty || 0,
              "판매비": formatPercentage(sizeItem.sale_rate || 0),
              "출고율-판매비": formatPercentage((sizeItem.out_rate || 0) - (sizeItem.sale_rate || 0)),
              "판매율": formatPercentage(sizeItem.sale_rate || 0),
              "판매 마감일까지 일수": item.expected_sales_period || 0,
              "예상 판매량": Math.round(sizeItem.expected_sales_full_period || 0),
              "현재 총재고": sizeItem.current_stock_qty || 0,
              "부족 수량": Math.round(sizeItem.shortage_qty || 0),
              "리오더 수량": sizeItem.size_reorder_qty || 0
            });
          });
        }
      });
      console.log("사이즈 테이블 데이터 생성 완료:", rawSizeTableData.length, "개");

      // --- 5. 통합 테이블 데이터 생성 (이 부분은 다운로드 기능이 없어지면서 더 이상 사용되지 않지만, 기존 반환 값에 맞춰 유지) ---
      console.log("통합 테이블 데이터 생성 시작");

      // 섹션 1: 리오더 검토의 건
      combinedTableData.push({
        _sectionTitle: "=== [공유용] 리오더 진행할 아이템 ===",
        _isHeader: true,
        _rowType: "section_header"
      });
      reviewColorTableData.forEach(row => {
        combinedTableData.push({
          ...row,
          _section: "review",
          _rowType: "data"
        });
      });

      // 빈 줄 추가
      combinedTableData.push({ _rowType: "spacer" });

      // 섹션 2: 상신용 아소트
      combinedTableData.push({
        _sectionTitle: "=== [공유용] 아이템별 아소트 ===",
        _isHeader: true,
        _rowType: "section_header"
      });
      // For combinedTableData, ensure the same column order as reviewSizeTableData
      reviewSizeTableData.forEach(row => {
        combinedTableData.push({
          ...row,
          _section: "approval",
          _rowType: "data"
        });
      });

      // 빈 줄 추가
      combinedTableData.push({ _rowType: "spacer" });

      // 섹션 3: 컬러 단위 상세 정보
      combinedTableData.push({
        _sectionTitle: "=== 컬러 단위 상세 정보 ===",
        _isHeader: true,
        _rowType: "section_header"
      });
      rawColorTableData.forEach(row => {
        combinedTableData.push({
          ...row,
          _section: "main",
          _rowType: "data"
        });
      });

      // 빈 줄 추가
      combinedTableData.push({ _rowType: "spacer" });

      // 섹션 4: 사이즈 단위 상세 정보
      combinedTableData.push({
        _sectionTitle: "=== 사이즈 단위 상세 정보 ===",
        _isHeader: true,
        _rowType: "section_header"
      });
      rawSizeTableData.forEach(row => {
        combinedTableData.push({
          ...row,
          _section: "size",
          _rowType: "data"
        });
      });

      console.log("통합 테이블 데이터 생성 완료:", combinedTableData.length, "개");

      // 성공 반환
      return {
        success: true,
        message: "데이터가 성공적으로 처리되었습니다.",
        combinedTableData: combinedTableData,
        reviewColorTableData: reviewColorTableData,
        reviewSizeTableData: reviewSizeTableData,
        rawColorTableData: rawColorTableData,
        rawSizeTableData: rawSizeTableData
      };

    } catch (error) {
      console.error("데이터 처리 중 예외 발생:", error);

      // 에러가 발생해도 생성된 데이터는 반환
      return {
        success: false,
        error: String(error),
        combinedTableData: combinedTableData || [],
        reviewColorTableData: reviewColorTableData || [],
        reviewSizeTableData: reviewSizeTableData || [],
        rawColorTableData: rawColorTableData || [],
        rawSizeTableData: rawSizeTableData || []
      };
    }
  }
  // 함수 실행
  return exportReorderDataToExcel();