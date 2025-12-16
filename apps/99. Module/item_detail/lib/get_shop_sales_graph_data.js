let data = formatDataAsArray(get_shop_sales.data);
const selected_shop_names = shop_sales_table.selectedRows.map(i=> i['A.shop_nm']);
const selected_shop_codes = shop_sales_table.selectedRows.map(i=> i['A.shop_cd']);

const shop_data = data.reduce((acc, item) => {
  const shopName = item["A.shop_nm"];
  const shopCode = item["A.shop_cd"];
  const rawTrend = item.sale_trend;

  if (!rawTrend || !shopName) return acc;

  const safeTrendString = rawTrend.replace(/inf/g, "null");
  let parsedTrend;

  try {
    parsedTrend = JSON.parse(safeTrendString);
  } catch (e) {
    console.error(`JSON 파싱 실패 - ${shopName}:`, safeTrendString);
    return acc;
  }

  if (!Array.isArray(parsedTrend) || parsedTrend.length === 0) return acc;


  if (selected_shop_codes.length > 0 && selected_shop_codes.includes(shopCode)) {
    acc[shopName] = parsedTrend;
  } else if (selected_shop_codes.length === 0) {
    acc[shopName] = parsedTrend;
  }

  return acc;
}, {});

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
      size: 1,
      line: { width: 0.5 }
    },
    line: {
      width: 1
    }
  }));

// 디버깅용 로그
console.log("Plotly 데이터:", JSON.stringify(plotlyData, null, 2));

return plotlyData;