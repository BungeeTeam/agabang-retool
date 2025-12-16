// 데이터 전처리
let data = formatDataAsArray(get_shop_sales.data);
const selected_shop_names = shop_sales_table.selectedRows.map(i=> i['A.shop_nm']);
const selected_shop_codes = shop_sales_table.selectedRows.map(i=> i['A.shop_cd']);

// 매장별로 일별 판매율
const plotlyData = [];

// 매장 데이터 처리
for (let i = 0; i < data.length; i++) {
  try {
    const item = data[i];
    
    // 매장명 가져오기 - 문자열로 확실하게 변환
    const shopName = item["A.shop_nm"];
    const shopCode = item["A.shop_cd"];
    
    // 선택된 매장 필터링
    if (selected_shop_codes.length > 0 && !selected_shop_codes.includes(shopCode)) {
      continue;
    }
    
    // sale_per_trend 또는 sale_trend 사용
    const trendData = item.sale_per_trend || item.sale_trend;
    if (!trendData) {
      continue;
    }
    
    // 데이터 파싱
    const safeTrendString = trendData.replace(/inf/g, "null");
    let parsedTrend;
    try {
      parsedTrend = JSON.parse(safeTrendString);
    } catch (e) {
      console.error(`${shopName} 데이터 파싱 오류:`, e);
      continue;
    }
    
    // 배열 확인
    if (!Array.isArray(parsedTrend) || parsedTrend.length === 0) {
      continue;
    }
    
    // x, y 배열 생성
    const days = parsedTrend.map(point => point.day);
    const values = parsedTrend.map(point => {
      if (point.val === "null") return null;
      return typeof point.val === "string" ? parseFloat(point.val) : point.val;
    });
    
    // 이름 명시적으로 설정
    const displayName = shopName.toString().trim();
    
    // 트레이스 생성
    plotlyData.push({
      x: days,
      y: values,
      type: "scatter",
      mode: "lines+markers",
      name: displayName,  // 명시적 문자열 변환
      connectgaps: true,
      marker: {
        symbol: "circle",
        size: 3,
        line: { width: 0.5 }
      },
      line: {
        width: 1.5
      }
    });
    
    console.log(`매장 추가: ${displayName}`);  // 디버깅용
    
  } catch (error) {
    console.error("데이터 처리 중 오류:", error);
    continue;
  }
}

// 처리된 데이터가 없을 경우 샘플 데이터 반환
if (plotlyData.length === 0) {
  return [{
    x: ["2024-01-01", "2024-01-02", "2024-01-03"],
    y: [10, 20, 30],
    type: "scatter",
    mode: "lines+markers",
    name: "데이터 없음"
  }];
}

// 명시적으로 이름이 설정되었는지 확인 (디버깅용)
plotlyData.forEach((trace, idx) => {
  console.log(`트레이스 ${idx} 이름:`, trace.name);
});

return plotlyData;