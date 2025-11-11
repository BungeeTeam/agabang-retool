// getNotificationItems.js
// 새로운 데이터 구조에 맞게 수정 - 다양한 경우에 대비한 방어적 코드
const allItems = Array.isArray(getColorList) ? getColorList 
                : Array.isArray(getColorList?.data) ? getColorList.data
                : Array.isArray(getColorList?.()) ? getColorList()
                : [];

// 헤더 행만 필터링하고, 창고 리오더 추천 상태가 긴급/주의인 것만 선택 후 소팅
const notificationItems = allItems
    .filter(item =>
        item._type === 'header' && // 헤더 행만 선택
        (item.wh_reorder_recommending_status?.includes('긴급') ||
         item.wh_reorder_recommending_status?.includes('주의'))
    )
    .sort((a, b) => {
        // 인라인 상태 정규화 함수
        const norm = s => s && s.includes('긴급') ? 0 : (s && s.includes('주의') ? 1 : 2);
        
        // 1. 창고 재고 상태(wh_reorder_recommending_status): 긴급 > 주의 > 양호
        const aWh = norm(a.wh_reorder_recommending_status);
        const bWh = norm(b.wh_reorder_recommending_status);
        if (aWh !== bWh) return aWh - bWh;
        
        // 2. 전체 재고 상태(reorder_recommending_status): 긴급 > 주의 > 양호
        const aTot = norm(a.reorder_recommending_status);
        const bTot = norm(b.reorder_recommending_status);
        if (aTot !== bTot) return aTot - bTot;
        
        // 3. 리드타임동안 부족 수량(lead_time_shortage_qty): 많은 것 > 적은 것
        if ((b.lead_time_shortage_qty || 0) !== (a.lead_time_shortage_qty || 0)) 
            return (b.lead_time_shortage_qty || 0) - (a.lead_time_shortage_qty || 0);
        
        // 4. 부족수량(shortage_qty): 많은 것 > 적은 것
        if ((b.shortage_qty || 0) !== (a.shortage_qty || 0)) 
            return (b.shortage_qty || 0) - (a.shortage_qty || 0);
        
        // 5. 긴급 사이즈 수량(total_wh_urgent_size_count): 많은 것 > 적은 것
        if ((b.total_wh_urgent_size_count || 0) !== (a.total_wh_urgent_size_count || 0)) 
            return (b.total_wh_urgent_size_count || 0) - (a.total_wh_urgent_size_count || 0);
        
        // 6. 재고량(current_stock_qty): 적은 것 > 많은 것
        const aStock = typeof a.current_stock_qty === 'number' ? a.current_stock_qty : Number(a.current_stock_qty) || 0;
        const bStock = typeof b.current_stock_qty === 'number' ? b.current_stock_qty : Number(b.current_stock_qty) || 0;
        if (aStock !== bStock) return aStock - bStock;
        
        // 7. 판매량(avg_monthly_sales): 많은 것 > 적은 것
        const aMonthly = Number(a.avg_monthly_sales_d180) || Number(a.avg_monthly_sales_d30) || 0;
        const bMonthly = Number(b.avg_monthly_sales_d180) || Number(b.avg_monthly_sales_d30) || 0;
        if (bMonthly !== aMonthly) return bMonthly - aMonthly;
        
        // 8. 상품 코드(sty_cd, col_cd): 알파벳 기준 역순
        if (a.sty_cd !== b.sty_cd) return String(b.sty_cd).localeCompare(String(a.sty_cd));
        if (a.col_cd !== b.col_cd) return String(b.col_cd).localeCompare(String(a.col_cd));
        
        return 0;
    });

const calculateStockInfo = (item) => {
    // emergency_stock 필드가 없으므로 0으로 처리하거나 다른 방식으로 계산
    // 안전하게 현재 재고량을 그대로 사용 가능 재고로 처리
    const emergencyStockCount = 0; // 또는 item.active_shop_count || 0 사용 가능
    const usableStock = Math.max(0, item.current_stock_qty - emergencyStockCount);
    const dailySales = item.effective_monthly_sales / 30;
    const daysOfUsableStock = dailySales > 0 ? Math.round(usableStock / dailySales) : 0;
    
    return {
        currentStock: item.current_stock_qty,
        requiredStock: Math.round(item.expected_sales_full_period || 0), // expected_sales → expected_sales_full_period
        reorderQty: item.final_reorder_qty,
        usableStock,
        daysOfUsableStock,
        monthlySales: Math.round(item.effective_monthly_sales)
    };
};

const teamsCardData = {
    TODAY_DATE: new Date().toISOString().split('T')[0],
    TOTAL_ITEMS: notificationItems.length,
    URGENT_COUNT: notificationItems.filter(item => 
        item.wh_reorder_recommending_status?.includes('긴급')).length,
    WARNING_COUNT: notificationItems.filter(item => 
        item.wh_reorder_recommending_status?.includes('주의')).length,
    //  ESTIMATED_LOSS_AMOUNT: "0",
    RETOOL_DASHBOARD_URL: notificationItems.length > 0 ? 
        (notificationItems[0].sty_cd.substring(0,2) === "07" 
            ? "https://agabang.cleave.work/app/reorder_season_ettoi"
            : notificationItems[0].sty_cd.substring(0,2) === "79"
            ? "https://agabang.cleave.work/app/reorder_season_disney"
            : "https://agabang.cleave.work/app/reorder_season_agabang")
        : "https://agabang.cleave.work/app/reorder_season_agabang", // 기본값
};

// 최대 3개 항목 처리 (이미 소팅된 상태에서 상위 3개 선택)
notificationItems.slice(0, 3).forEach((item, index) => {
    const num = index + 1;
    const stockInfo = calculateStockInfo(item);
    const styleCode = `${item.sty_cd}${item.col_cd}`.trim();
    
    teamsCardData[`ITEM${num}_IMAGE_URL`] = 
        `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${styleCode}.jpg`;
    teamsCardData[`ITEM${num}_STATUS`] = item.reorder_recommending_status;
    teamsCardData[`ITEM${num}_STY_NM`] = `${item.sty_nm} (${item.col_nm})`;
    teamsCardData[`ITEM${num}_CURRENT_STOCK`] = stockInfo.currentStock;
    teamsCardData[`ITEM${num}_REQUIRED_STOCK`] = stockInfo.requiredStock;
    teamsCardData[`ITEM${num}_REORDER_QTY`] = stockInfo.reorderQty;
    teamsCardData[`ITEM${num}_USABLE_STOCK`] = stockInfo.usableStock;
    teamsCardData[`ITEM${num}_DAYS`] = stockInfo.daysOfUsableStock;
    teamsCardData[`ITEM${num}_MONTHLY_SALES`] = stockInfo.monthlySales;
    teamsCardData[`ITEM${num}_STY_CD`] = styleCode;
});

// 빈 슬롯 채우기 (3개 슬롯 모두 처리)
for (let i = notificationItems.length + 1; i <= 3; i++) {
    teamsCardData[`ITEM${i}_IMAGE_URL`] = "";
    teamsCardData[`ITEM${i}_STATUS`] = "";
    teamsCardData[`ITEM${i}_STY_NM`] = "";
    teamsCardData[`ITEM${i}_CURRENT_STOCK`] = "";
    teamsCardData[`ITEM${i}_REQUIRED_STOCK`] = "";
    teamsCardData[`ITEM${i}_REORDER_QTY`] = "";
    teamsCardData[`ITEM${i}_USABLE_STOCK`] = "";
    teamsCardData[`ITEM${i}_DAYS`] = "";
    teamsCardData[`ITEM${i}_MONTHLY_SALES`] = "";
    teamsCardData[`ITEM${i}_STY_CD`] = "";
}

return teamsCardData;