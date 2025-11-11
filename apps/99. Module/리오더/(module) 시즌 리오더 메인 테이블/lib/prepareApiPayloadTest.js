const itemsArray = {{ selectedReorderItems.value.map(item => ({
    product_image_url: `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${item.reference_info.sty_cd}${item.reference_info.col_cd}.jpg`,
    style_code: item.reference_info.sty_cd,
    style_name: item.reference_info.sty_nm,
    color_code: item.reference_info.col_cd,
    color_name: item.reference_info.col_nm,
    color_key: item.reference_info.groupId, 
    manufacturer_name: item.production_info["생산업체"],
    tag_price: item.production_info["TAG가"],
    cost_price: item.production_info["원가"],
    recommended_reorder_qty: item.reorder_info["부족 수량"],
    details_url: item.reference_info.sty_cd.substring(0,2) === "07" 
      ? "https://agabang.cleave.work/app/reorder_season_ettoi"
      : item.reference_info.sty_cd.substring(0,2) === "79"
      ? "https://agabang.cleave.work/app/reorder_season_disney"
      : "https://agabang.cleave.work/app/reorder_season_agabang",
    current_stock_total: item.reorder_info["현재 총재고"],
    current_stock_store: item.production_info["매장재고"],
    current_stock_warehouse: item.production_info["창고재고"],
    cumulative_sales_rate: item.sales_performance["누적 판매율(입고 기준)"],
    sales_monthly_30d: Math.round(item.sales_performance["일 판매량"] * 30 || 0),
    stock_out_days_30d: Math.floor(
      item.reorder_info["현재 총재고"] / (item.sales_performance["일 판매량"] || 1)
    ), 
    sales_monthly_180d: Math.round(item.sales_performance["일 판매량"] * 30 || 0),
    stock_out_days_180d: Math.floor(
      item.reorder_info["현재 총재고"] / (item.sales_performance["일 판매량"] || 1)
    ),
    sales_monthly_365d: Math.round(item.sales_performance["일 판매량"] * 30 || 0),
    stock_out_days_365d: Math.floor(
      item.reorder_info["현재 총재고"] / (item.sales_performance["일 판매량"] || 1)
    ),
    initial_reorder_cost_price: item.production_info["리오더 원가"] ?? null, 
    initial_moq: 1000,
    initial_lead_time: item.reorder_info["리드타임(일)"] ?? null,
    input_deadline: moment().add(3, 'days').format("YYYY-MM-DD")
  }))}};
  
  // simulation_url을 상위 레벨로 이동
  const simulationUrl = {{ var_brand_code.value }} === "07" 
    ? "https://agabang.cleave.work/app/reorder_simulation_season_ettoi"
    : {{ var_brand_code.value }} === "79"
    ? "https://agabang.cleave.work/app/reorder_simulation_season_disney"
    : "https://agabang.cleave.work/app/reorder_simulation_season_agabang";
  
  // 최종 페이로드 객체 생성
  const payload = {
    items: itemsArray,
    simulation_url: simulationUrl, // 상위 레벨에 추가
    triggeredBy: "chaewon@bungeework.onmicrosoft.com",
   "br_cd":"test",
    "isSupplies": false,
"production":["chaewon@bungeework.onmicrosoft.com"]
  };
  
  // 생성된 페이로드 객체를 반환
  return payload;