let data = formatDataAsArray(get_shop_sales.data);
const selected_shop_names = shop_sales_table.selectedRows.map(i=> i['A.shop_nm']);
const selected_shop_codes = shop_sales_table.selectedRows.map(i=> i['A.shop_cd']);
console.log(selected_shop_names)

// 매장별로 일별 입고량
const shop_data = data.reduce((acc, item) => {
  const shopName = item["A.shop_nm"];
  const shopCode = item["A.shop_cd"];
  const rawTrend = item.in_trend;

  if (!rawTrend || !shopName) return acc;

  // "inf" → "null" 치환
  const safeTrendString = rawTrend.replace(/inf/g, "null");
  let parsedTrend;

  try {
    parsedTrend = JSON.parse(safeTrendString);
  } catch (e) {
    console.error(`JSON 파싱 실패 - ${shopName}:`, safeTrendString);
    return acc;
  }

  if (!Array.isArray(parsedTrend) || parsedTrend.length === 0) return acc;

  // 매장 필터링 조건
  if (
    (selected_shop_codes.length > 0 && selected_shop_codes.includes(shopCode)) ||
    selected_shop_codes.length === 0
  ) {
    acc[shopName] = parsedTrend;
  }

  return acc;
}, {});

// Plotly 그래프용 데이터 생성
const plotlyData = Object.keys(shop_data)
  .sort()
  .map(shop => ({
    x: shop_data[shop].map(point => point.day),
    y: shop_data[shop].map(point => {
      if (point.val === "null") return null;
      return typeof point.val === "string" ? parseFloat(point.val) : point.val;
    }),
    type: "scatter",
    mode: "lines+markers",
    name: shop,
    marker: {
      symbol: "circle",
      size: 2,
      line: { width: 0.5 }
    },
    line: { width: 1.5 }
  }));

// 디버깅용 로그
console.log("입고 트렌드 그래프 데이터:", JSON.stringify(plotlyData, null, 2));

return plotlyData;
