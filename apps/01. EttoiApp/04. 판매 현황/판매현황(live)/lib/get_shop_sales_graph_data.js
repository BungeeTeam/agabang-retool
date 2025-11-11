// 데이터 전처리
let data = formatDataAsArray(get_shop_sales.data);

const selected_shop_names = shop_sales_table.selectedRowKeys

// 매장별로 일별 판매율
const shop_data = data.reduce((acc, item) => {
  // sale_per_trend 문자열에서 "inf"를 "null"로 대체
  let safeTrendString = item.sale_trend.replace(/inf/g, "null");

  // 변환된 문자열을 JSON 객체로 파싱
  let parsedTrend = JSON.parse(safeTrendString);

  if ( ( selected_shop_names.length > 0 ) && ( selected_shop_names.includes(item.shop_nm) ) ) {
    acc[item.shop_nm] = parsedTrend; 
  }
  else if ( selected_shop_names.length == 0 ){
    acc[item.shop_nm] = parsedTrend; 
  }
  
  return acc;
}, {});

// Plotly 데이터 생성
const plotlyData = Object.keys(shop_data)
  .sort()
  .map(shop => {
    return {
        x: shop_data[shop].map(item => item.day), 
        y: shop_data[shop].map(item => item.val), 
        type: "scatter",
        mode: "lines+markers",
        name: shop, // 각 shop 이름
        marker: {
            symbol: "circle",
            size: 1,
            line: { width: 0.5 }
        },
        line: {
          width: 1
        }
    };
});

console.log(JSON.stringify(plotlyData, null, 4));

return plotlyData;