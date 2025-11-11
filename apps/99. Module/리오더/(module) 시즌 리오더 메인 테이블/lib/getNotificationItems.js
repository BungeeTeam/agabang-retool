// getNotificationItems.js
// 시즌 리오더 알림: 소수점 값 정수 변환, 특수 문자 처리
const allItems = Array.isArray(getColorList) ? getColorList 
                : Array.isArray(getColorList?.data) ? getColorList.data
                : Array.isArray(getColorList?.()) ? getColorList()
                : [];

// 헤더 행만 필터링하고, 창고 리오더 상태가 긴급/주의인 항목만 선택 후 정렬
const notificationItems = allItems
    .filter(item =>
        item._type === 'header' && // 헤더 행만 선택
        (item.wh_reorder_recommending_status?.includes('긴급') ||
         item.wh_reorder_recommending_status?.includes('주의'))
    )
    .sort((a, b) => {
        // 상태 정규화 함수: 긴급(0) > 주의(1) > 양호(2)
        const norm = s => s && s.includes('긴급') ? 0 : (s && s.includes('주의') ? 1 : 2);

        // 1. 창고 재고 상태: 긴급 > 주의 > 양호
        const aWh = norm(a.wh_reorder_recommending_status);
        const bWh = norm(b.wh_reorder_recommending_status);
        if (aWh !== bWh) return aWh - bWh;

        // 2. 전체 재고 상태: 긴급 > 주의 > 양호
        const aTot = norm(a.reorder_recommending_status);
        const bTot = norm(b.reorder_recommending_status);
        if (aTot !== bTot) return aTot - bTot;

        // 3. 리드타임 동안 부족 수량: 큰 값 우선
        if ((b.lead_time_shortage_qty || 0) !== (a.lead_time_shortage_qty || 0)) 
            return (b.lead_time_shortage_qty || 0) - (a.lead_time_shortage_qty || 0);

        // 4. 부족 수량: 큰 값 우선
        if ((b.shortage_qty || 0) !== (a.shortage_qty || 0)) 
            return (b.shortage_qty || 0) - (a.shortage_qty || 0);

        // 5. 긴급 사이즈 수량: 큰 값 우선
        if ((b.total_wh_urgent_size_count || 0) !== (a.total_wh_urgent_size_count || 0)) 
            return (b.total_wh_urgent_size_count || 0) - (a.total_wh_urgent_size_count || 0);

        // 6. 현재 재고: 작은 값 우선
        const aStock = typeof a.current_stock_qty === 'number' ? a.current_stock_qty : Number(a.current_stock_qty) || 0;
        const bStock = typeof b.current_stock_qty === 'number' ? b.current_stock_qty : Number(b.current_stock_qty) || 0;
        if (aStock !== bStock) return aStock - bStock;

        // 7. 판매량 (180일 우선, 30일 대체): 큰 값 우선
        const aMonthly = Number(a.avg_monthly_sales_d180) || Number(a.avg_monthly_sales_d30) || 0;
        const bMonthly = Number(b.avg_monthly_sales_d180) || Number(b.avg_monthly_sales_d30) || 0;
        if (bMonthly !== aMonthly) return bMonthly - aMonthly;

        // 8. 상품 코드(sty_cd, col_cd): 알파벳 역순
        if (a.sty_cd !== b.sty_cd) return String(b.sty_cd).localeCompare(String(a.sty_cd));
        if (a.col_cd !== b.col_cd) return String(b.col_cd).localeCompare(String(a.col_cd));

        return 0;
    });

const calculateStockInfo = (item) => {
    // 판매율을 백분율로 변환
    const saleRate = typeof item.sale_rate === 'number' ? Math.round(item.sale_rate * 100) : 0;
    // 목표 판매율을 백분율로 변환
    const targetSaleRate = typeof item.target_sale_rate === 'number' ? Math.round(item.target_sale_rate * 100) : 0;
    // 월 판매량, 소수점 반올림
    const monthlySales = Math.round(Number(item.avg_monthly_sales_d180) || Number(item.avg_monthly_sales_d30) || 0);
    
    return {
        currentStock: item.current_stock_qty || 0,
        weekly7dSales: Math.round(item.weekly_7d_sale_qty || 0), // 소수점 제거
        saleRate: `${saleRate}%`,
        shortageQty: Math.round(item.shortage_qty || 0), // 소수점 제거
        reorderQty: item.final_reorder_qty || 0,
        targetSaleRate: `${targetSaleRate}%`,
        monthlySales: monthlySales
    };
};

const teamsCardData = {
    TODAY_DATE: new Date().toISOString().split('T')[0],
    TOTAL_ITEMS: notificationItems.length,
    URGENT_COUNT: notificationItems.filter(item => 
        item.wh_reorder_recommending_status?.includes('긴급')).length,
    WARNING_COUNT: notificationItems.filter(item => 
        item.wh_reorder_recommending_status?.includes('주의')).length,
    ESTIMATED_LOSS_AMOUNT: notificationItems.reduce((sum, item) => 
        sum + (Number(item.estimated_loss_amount) || 0), 0).toString(), // 특수 문자 제거, 숫자 문자열로 변환
    RETOOL_DASHBOARD_URL: notificationItems.length > 0 ? 
        (notificationItems[0].sty_cd.substring(0,2) === "07" 
            ? "https://agabang.cleave.work/app/reorder_season_ettoi"
            : notificationItems[0].sty_cd.substring(0,2) === "79"
            ? "https://agabang.cleave.work/app/reorder_season_disney"
            : "https://agabang.cleave.work/app/reorder_season_agabang")
        : "https://agabang.cleave.work/app/reorder_season_agabang"
};

// 최대 3개 항목 처리
notificationItems.slice(0, 3).forEach((item, index) => {
    const num = index + 1;
    const stockInfo = calculateStockInfo(item);
    const styleCode = `${item.sty_cd}${item.col_cd}`.trim();
    
    teamsCardData[`ITEM${num}_IMAGE_URL`] = 
        `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${styleCode}.jpg`;
    teamsCardData[`ITEM${num}_STATUS`] = item.wh_reorder_recommending_status;
    teamsCardData[`ITEM${num}_STY_NM`] = `${item.sty_nm} (${item.col_nm})`;
    teamsCardData[`ITEM${num}_CURRENT_STOCK`] = stockInfo.currentStock;
    teamsCardData[`ITEM${num}_WEEKLY_SALES`] = stockInfo.weekly7dSales;
    teamsCardData[`ITEM${num}_SALE_RATE`] = stockInfo.saleRate;
    teamsCardData[`ITEM${num}_SHORTAGE_QTY`] = stockInfo.shortageQty;
    teamsCardData[`ITEM${num}_TARGET_SALE_RATE`] = stockInfo.targetSaleRate;
    teamsCardData[`ITEM${num}_REORDER_QTY`] = stockInfo.reorderQty;
    teamsCardData[`ITEM${num}_MONTHLY_SALES`] = stockInfo.monthlySales;
    teamsCardData[`ITEM${num}_STY_CD`] = styleCode;
});

// 빈 슬롯 채우기 (3개 슬롯)
for (let i = notificationItems.length + 1; i <= 3; i++) {
    teamsCardData[`ITEM${i}_IMAGE_URL`] = "";
    teamsCardData[`ITEM${i}_STATUS`] = "";
    teamsCardData[`ITEM${i}_STY_NM`] = "";
    teamsCardData[`ITEM${i}_CURRENT_STOCK`] = "";
    teamsCardData[`ITEM${i}_WEEKLY_SALES`] = "";
    teamsCardData[`ITEM${i}_SALE_RATE`] = "";
    teamsCardData[`ITEM${i}_SHORTAGE_QTY`] = "";
    teamsCardData[`ITEM${i}_TARGET_SALE_RATE`] = "";
    teamsCardData[`ITEM${i}_REORDER_QTY`] = "";
    teamsCardData[`ITEM${i}_MONTHLY_SALES`] = "";
    teamsCardData[`ITEM${i}_STY_CD`] = "";
}

return teamsCardData;