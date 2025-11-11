<GlobalFunctions>
  <SqlQuery
    id="season_list"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/season_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    transformer="function transform(data){
  const result = {};

  const transform_data = formatDataAsArray(data)
  transform_data.forEach(item => {
    
    if (!result[item.season_type]) {
      result[item.season_type] = [];
    }
    
    result[item.season_type].push(item);
    
  });

  //  console.log(`transform result: ${JSON.stringify(result)}`)

  return result
}

// Query results are available as the `data` variable
return transform(data)"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="season_item_list"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <SqlQuery
    id="get_item_detail"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_item_detail.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQuery
    id="get_item_size_detail"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    notificationDuration={4.5}
    query={include("./lib/get_item_size_detail.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <JavascriptQuery
    id="get_image_list"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_image_list.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQuery
    id="get_daily_sales_by_style"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/get_daily_sales_by_style.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <JavascriptQuery
    id="download_images_zip"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    notificationDuration={4.5}
    query={include("./lib/download_images_zip.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <RESTQuery
    id="get_image"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    query="{{url}}"
    resourceName="REST-WithoutResource"
    resourceTypeOverride=""
    runWhenModelUpdates={false}
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQuery
    id="query_avg_sale_rate"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/query_avg_sale_rate.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <State
    id="var_category_list"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
    value={
      '{\n  "season":[ \n    { "cat_nm": "전체", "id": 89 }, \n    { "cat_nm": "시즌의류", "id": 57 },\n    { "cat_nm": "시즌언더", "id": 56 },  \n    { "cat_nm": "파자마", "id": 59 }, \n    { "cat_nm": "시즌용품", "id": 62 },\n    { "cat_nm": "복종X", "id": 91 }\n  ],\n"season_less":[ \n    { "cat_nm": "전체", "id": 89 }, \n    { "cat_nm": "시즌의류", "id": 57 },\n    { "cat_nm": "시즌언더", "id": 56 },  \n    { "cat_nm": "파자마", "id": 59 }, \n    { "cat_nm": "시즌용품", "id": 62 },\n    { "cat_nm": "복종X", "id": 91 }\n  ],\n"yongpum": [\n    { "cat_nm": "전체", "id": 55 },\n    { "cat_nm": "발육", "id": 61 },\n    { "cat_nm": "수유", "id": 62 },\n    { "cat_nm": "완구|기타", "id": 63 },\n    { "cat_nm": "섬유1", "id": 64 },\n    { "cat_nm": "섬유2", "id": 65 },\n    { "cat_nm": "위생", "id": 66 }, \n    { "cat_nm": "화장품", "id": 68 }\n  ]\n}'
    }
  />
  <State
    id="var_color_hex_list"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
    value={
      '[\n    {\n        "col_nm": "MULTI",\n        "col_hex": "#808080"  // 부드러운 다채로운 느낌\n    },\n    {\n        "col_nm": "CREAM",\n        "col_hex": "#FFF7D1"  // 연한 크림색\n    },\n    {\n        "col_nm": "IVORY",\n        "col_hex": "#FFFAF0"  // 부드러운 아이보리\n    },\n    {\n        "col_nm": "O/WHITE",\n        "col_hex": "#F8F8F8"  // 밝은 오프 화이트\n    },\n    {\n        "col_nm": "WHITE",\n        "col_hex": "#FFFFFF"  // 기본 화이트\n    },\n    {\n        "col_nm": "SILVER",\n        "col_hex": "#ECECEC"  // 부드러운 실버\n    },\n    {\n        "col_nm": "GOLD",\n        "col_hex": "#FFEBCD"  // 연한 금색 (아이보리 톤)\n    },\n    {\n        "col_nm": "FLOWER",\n        "col_hex": "#FADADD"  // 연한 꽃 색상\n    },\n    {\n        "col_nm": "MISTY WHITE",\n        "col_hex": "#F5F5F5"  // 흐릿한 화이트\n    },\n    {\n        "col_nm": "OATMEAL",\n        "col_hex": "#E6DACD"  // 부드러운 오트밀\n    },\n    {\n        "col_nm": "CHARCOAL",\n        "col_hex": "#B3B3B3"  // 연한 차콜 그레이\n    },\n    {\n        "col_nm": "BLACK",\n        "col_hex": "#D3D3D3"  // 부드럽고 연한 블랙(그레이톤)\n    },\n    {\n        "col_nm": "D/GREY",\n        "col_hex": "#DADADA"  // 연한 다크 그레이\n    },\n    {\n        "col_nm": "NAVY",\n        "col_hex": "#C7D2FE"  // 연한 네이비 (라벤더 블루)\n    },\n    {\n        "col_nm": "GREY",\n        "col_hex": "#E0E0E0"  // 밝은 회색\n    },\n    {\n        "col_nm": "L/GREY",\n        "col_hex": "#F0F0F0"  // 매우 밝은 회색\n    },\n    {\n        "col_nm": "MELAN GREY",\n        "col_hex": "#D6D6D6"  // 연한 멜란지 그레이\n    },\n    {\n        "col_nm": "NAVY JEAN",\n        "col_hex": "#BFCFE5"  // 부드러운 네이비 진\n    },\n    {\n        "col_nm": "Z/BLACK",\n        "col_hex": "#B0B0B0"  // 연한 제로 블랙 (그레이 계열)\n    },\n    {\n        "col_nm": "B/NAVY",\n        "col_hex": "#A9BED9"  // 부드러운 블루 네이비\n    },\n    {\n        "col_nm": "BLACK MELAN",\n        "col_hex": "#C4C4C4"  // 연한 블랙 멜란지\n    },\n    {\n        "col_nm": "BEIGE",\n        "col_hex": "#F5E8DC"  // 밝은 베이지\n    },\n    {\n        "col_nm": "CAMEL",\n        "col_hex": "#E3C4A8"  // 부드러운 카멜\n    },\n    {\n        "col_nm": "CREAM BEIGE",\n        "col_hex": "#F7ECD4"  // 연한 크림 베이지\n    },\n    {\n        "col_nm": "D/BEIGE",\n        "col_hex": "#E5D3BC"  // 연한 다크 베이지\n    },\n    {\n        "col_nm": "L/BEIGE",\n        "col_hex": "#FAF3E3"  // 매우 밝은 베이지\n    },\n    {\n        "col_nm": "SKIN NUDE",\n        "col_hex": "#FCE6D1"  // 연한 누드 스킨톤\n    },\n    {\n        "col_nm": "M/BEIGE",\n        "col_hex": "#EDD2B1"  // 중간 톤의 베이지\n    },\n    {\n        "col_nm": "MUSTARD",\n        "col_hex": "#F8E4B0"  // 부드러운 머스터드\n    },\n    {\n        "col_nm": "BROWN",\n        "col_hex": "#D2B48C"  // 밝은 브라운\n    },\n    {\n        "col_nm": "COCOA",\n        "col_hex": "#D1A681"  // 연한 코코아\n    },\n    {\n        "col_nm": "D/BROWN",\n        "col_hex": "#C4A484"  // 연한 다크 브라운\n    },\n    {\n        "col_nm": "D/COCOA",\n        "col_hex": "#B8956B"  // 부드러운 다크 코코아\n    },\n    {\n        "col_nm": "BRONZE",\n        "col_hex": "#E5B89F"  // 부드러운 청동색\n    },\n    {\n        "col_nm": "LIGHT BRONZE",\n        "col_hex": "#F2CEB6"  // 연한 브론즈\n    },\n    {\n        "col_nm": "BRICK",\n        "col_hex": "#F5B19C"  // 부드러운 벽돌색\n    },\n    {\n        "col_nm": "OLIVE",\n        "col_hex": "#D9E1C5"  // 연한 올리브\n    },\n    {\n        "col_nm": "PEACH",\n        "col_hex": "#FCD6BB"  // 부드러운 복숭아색\n    },\n    {\n        "col_nm": "AQUA",\n        "col_hex": "#D3F8F2"  // 연한 아쿠아\n    },\n    {\n        "col_nm": "BLUE",\n        "col_hex": "#BFDBFE"  // 부드러운 블루\n    },\n    {\n        "col_nm": "C/BLUE",\n        "col_hex": "#C1E7FF"  // 밝은 코발트 블루\n    },\n    {\n        "col_nm": "D/BLUE",\n        "col_hex": "#A7C6F2"  // 연한 다크 블루\n    },\n    {\n        "col_nm": "I/BLUE",\n        "col_hex": "#B0E0E6"  // 부드러운 아이스 블루\n    },\n    {\n        "col_nm": "L/BLUE",\n        "col_hex": "#E0F7FA"  // 매우 밝은 블루\n    },\n    {\n        "col_nm": "M/BLUE",\n        "col_hex": "#BFDFFF"  // 중간 톤의 블루\n    },\n    {\n        "col_nm": "S/BLUE",\n        "col_hex": "#CCE8FF"  // 밝은 스카이 블루\n    },\n    {\n        "col_nm": "T/BLUE",\n        "col_hex": "#D0EFFF"  // 연한 청록색 블루\n    },\n    {\n        "col_nm": "B/BLUE",\n        "col_hex": "#A7F3D0"  // 부드러운 블루 그린\n    },\n    {\n        "col_nm": "CHERRY PINK",\n        "col_hex": "#FAD4E7"  // 연한 체리 핑크\n    },\n    {\n        "col_nm": "C/PINK",\n        "col_hex": "#F8E6FA"  // 밝은 코랄 핑크\n    },\n    {\n        "col_nm": "D/PINK",\n        "col_hex": "#FFD1DC"  // 부드러운 다크 핑크\n    },\n    {\n        "col_nm": "I/PINK",\n        "col_hex": "#FFE4E1"  // 아이보리 핑크\n    },\n    {\n        "col_nm": "L/PINK",\n        "col_hex": "#FFEBEE"  // 매우 밝은 핑크\n    },\n    {\n        "col_nm": "L/CORAL",\n        "col_hex": "#FFD5D0"  // 연한 코랄\n    },\n    {\n        "col_nm": "MAGENTA",\n        "col_hex": "#FFCCF9"  // 부드러운 마젠타\n    },\n    {\n        "col_nm": "PINK",\n        "col_hex": "#FECACA"  // 연한 핑크\n    },\n    {\n        "col_nm": "ROSE PINK",\n        "col_hex": "#FFD7E7"  // 연한 로즈 핑크\n    },\n    {\n        "col_nm": "B/PINK",\n        "col_hex": "#FFC1E3"  // 부드러운 블러시 핑크\n    },\n    {\n        "col_nm": "L/PURPLE",\n        "col_hex": "#EEDAFD"  // 연한 라벤더 퍼플\n    },\n    {\n        "col_nm": "L/VIOLET",\n        "col_hex": "#E6E6FA"  // 밝은 바이올렛\n    },\n    {\n        "col_nm": "PURPLE",\n        "col_hex": "#E0BBE4"  // 연한 퍼플\n    },\n    {\n        "col_nm": "VIOLET",\n        "col_hex": "#DCCFFF"  // 연한 바이올렛\n    },\n    {\n        "col_nm": "A/GREEN",\n        "col_hex": "#D1F2C9"  // 부드러운 아쿠아 그린\n    },\n    {\n        "col_nm": "D/KHAKI",\n        "col_hex": "#D6E0B8"  // 연한 다크 카키\n    },\n    {\n        "col_nm": "D/GREEN",\n        "col_hex": "#C8E6C9"  // 부드러운 다크 그린\n    },\n    {\n        "col_nm": "GREEN",\n        "col_hex": "#D4EDDA"  // 연한 그린\n    },\n    {\n        "col_nm": "KHAKI",\n        "col_hex": "#E4D4A2"  // 부드러운 카키\n    },\n    {\n        "col_nm": "L/KHAKI",\n        "col_hex": "#F5F5DC"  // 매우 밝은 카키\n    },\n    {\n        "col_nm": "L/GREEN",\n        "col_hex": "#DFFFE7"  // 연한 그린\n    },\n    {\n        "col_nm": "MINT",\n        "col_hex": "#D1FAD9"  // 밝은 민트\n    },\n    {\n        "col_nm": "O/GREEN",\n        "col_hex": "#D9EAD3"  // 연한 올리브 그린\n    },\n    {\n        "col_nm": "L/MINT",\n        "col_hex": "#E0FFF4"  // 매우 밝은 민트\n    },\n    {\n        "col_nm": "D/ORANGE",\n        "col_hex": "#FFDAC1"  // 부드러운 다크 오렌지\n    },\n    {\n        "col_nm": "LEMON YELLOW",\n        "col_hex": "#FFF9C4"  // 연한 레몬 옐로우\n    },\n    {\n        "col_nm": "L/ORANGE",\n        "col_hex": "#FFEDD5"  // 밝은 오렌지\n    },\n    {\n        "col_nm": "L/YELLOW",\n        "col_hex": "#FFFCDB"  // 매우 밝은 옐로우\n    },\n    {\n        "col_nm": "M/YELLOW",\n        "col_hex": "#FFF4E6"  // 연한 머스타드 옐로우\n    },\n    {\n        "col_nm": "ORANGE",\n        "col_hex": "#FFD9B2"  // 부드러운 오렌지\n    },\n    {\n        "col_nm": "YELLOW",\n        "col_hex": "#FFFBCC"  // 밝은 옐로우\n    },\n    {\n        "col_nm": "B/YELLOW",\n        "col_hex": "#FFF5B8"  // 연한 베이비 옐로우\n    },\n    {\n        "col_nm": "D/YELLOW",\n        "col_hex": "#FFF2C2"  // 부드러운 다크 옐로우\n    },\n    {\n        "col_nm": "F/YELLOW",\n        "col_hex": "#FFFDE7"  // 매우 연한 옐로우\n    },\n    {\n        "col_nm": "D/RED",\n        "col_hex": "#FFCECE"  // 부드러운 다크 레드\n    },\n    {\n        "col_nm": "L/RED",\n        "col_hex": "#FFD5D5"  // 밝은 레드\n    },\n    {\n        "col_nm": "RED",\n        "col_hex": "#FFCCCC"  // 연한 레드\n    },\n    {\n        "col_nm": "WINE",\n        "col_hex": "#F5C7C7"  // 연한 와인 레드\n    },\n    {\n        "col_nm": "P/RED",\n        "col_hex": "#FFB2B2"  // 부드러운 핑크 레드\n    },\n    {\n        "col_nm": "BURGUNDY",\n        "col_hex": "#EFB9B9"  // 밝은 버건디\n    },\n    {\n        "col_nm": "POWDERPINK",\n        "col_hex": "#FFE4E1"  // 파우더 핑크\n    },\n    {\n        "col_nm": "LIME",\n        "col_hex": "#E6F2C6"  // 부드러운 라임색\n    },\n    {\n        "col_nm": "CHARCOAL_",\n        "col_hex": "#DADADA"  // 연한 차콜 그레이\n    }\n]'
    }
  />
  <SqlQuery
    id="get_item_list_new"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_item_list_new.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    runWhenPageLoads={true}
    showSuccessToaster={false}
    transformer={
      "function getTable(inputData) {\n  // Step 1: Create a map of sizes with their corresponding data\n  const sizeDataMap = {};\n  const isPeriodMode = {{ segmentedControl_date_mode.value }} === 'period';\n  \n  inputData.forEach(item => {\n    const sizeCd = parseInt(item.size_cd, 10);\n    const sizeNm = item.size_nm;\n    // period 모드일 때는 cum_in_qty 사용, 아니면 tot_in_qty 사용\n    const inQty = isPeriodMode && item.cum_in_qty !== undefined \n      ? (item.cum_in_qty !== null ? parseInt(item.cum_in_qty, 10) : null)\n      : (item.tot_in_qty !== null ? parseInt(item.tot_in_qty, 10) : null);\n    const saleQty = item.tot_sale_qty !== null ? parseInt(item.tot_sale_qty, 10) : null;\n    const planQty = item.plan_qty !== null ? parseInt(item.plan_qty, 10) : null;\n    const weekSaleQty = item.week_sale_qty !== null ? parseInt(item.week_sale_qty, 10) : null;\n\n    sizeDataMap[sizeCd] = {\n      size_nm: sizeNm,\n      inQty,\n      saleQty,\n      planQty,\n      weekSaleQty,\n    };\n  });\n\n  // Step 2: Sort sizes by size_cd\n  const sortedSizes = Object.keys(sizeDataMap)\n    .map(sizeCd => ({\n      size_cd: parseInt(sizeCd, 10),\n      ...sizeDataMap[sizeCd],\n    }))\n    .sort((a, b) => a.size_cd - b.size_cd);\n\n  // Step 3: Filter sizes where 입고수량 is not null\n  const sizesWithInQty = sortedSizes.filter(size => size.inQty !== null);\n\n  // Step 4: Build columns dynamically\n  const result = [];\n\n  // First row: size names (use null if 입고수량 is null)\n  const firstRow = { SIZE: 'SIZE' };\n  sizesWithInQty.forEach((size, index) => {\n    firstRow[`col_${index + 1}`] = size.size_nm;\n  });\n\n  // Add TTL column immediately after sizes\n  const ttlColumnIndex = sizesWithInQty.length + 1;\n  firstRow[`col_${ttlColumnIndex}`] = 'TTL';\n\n  result.push(firstRow);\n\n  // Initialize totals\n  let totalInQty = 0;\n  let totalSaleQty = 0;\n  let totalPlanQty = 0;\n  let totalWeekSaleQty = 0;\n\n  let _mode = {{ segmentedControl_date_mode.value }}\n  // Metrics to include\n  const metrics = [\n    { label: '기획수량', key: 'planQty' },\n    { label: '입고수량', key: 'inQty' },\n    { label: '판매수량(누적)', key: 'saleQty' },\n    { label: `판매수량(${_mode === \"cumulative\" ? \"주\" : \"기간\"})`, key: 'weekSaleQty' },\n    { label: '입고비중(%)', key: 'inQtyPercent' },\n    { label: '판매비중(%)', key: 'saleQtyPercent' },\n    { label: '판매율(%)', key: 'saleRatePercent' },\n  ];\n\n  // Calculate totals\n  sizesWithInQty.forEach(size => {\n    if (size.inQty !== null) {\n      totalInQty += size.inQty;\n    }\n    if (size.saleQty !== null) {\n      totalSaleQty += size.saleQty;\n    }\n    if (size.planQty !== null) {\n      totalPlanQty += size.planQty;\n    }\n    if (size.weekSaleQty !== null) {\n      totalWeekSaleQty += size.weekSaleQty;\n    }\n  });\n\n  // Helper function to format percentages\n  function formatPercentage(value) {\n    if (value === null || isNaN(value)) return null;\n    return value % 1 === 0 ? parseInt(value) : value.toFixed(1);\n  }\n\n  // Generate data rows for each metric\n  metrics.forEach(metric => {\n    const row = { SIZE: metric.label };\n    sizesWithInQty.forEach((size, index) => {\n      let value = null;\n\n      if (metric.key === 'inQty') {\n        value = size.inQty !== null ? size.inQty : null;\n      } else if (metric.key === 'planQty') {\n        value = size.planQty !== null ? size.planQty : null;\n      } else if (metric.key === 'weekSaleQty') {\n        value = size.weekSaleQty !== null ? size.weekSaleQty : null;\n      } else if (metric.key === 'saleQty') {\n        value = size.saleQty !== null ? size.saleQty : null;\n      } else if (metric.key === 'inQtyPercent') {\n        // 입고비중: period 모드에서도 동일하게 전체 입고량 대비 비중\n        value =\n          totalInQty && size.inQty !== null\n            ? (size.inQty / totalInQty) * 100\n            : null;\n        value = formatPercentage(value);\n        if(value){\n          value = `${value}%`\n        }\n      } else if (metric.key === 'saleQtyPercent') {\n        // 판매비중: period 모드일 때는 기간 판매량(weekSaleQty) 기준으로 계산\n        if (isPeriodMode) {\n          value =\n            totalWeekSaleQty && size.weekSaleQty !== null\n              ? (size.weekSaleQty / totalWeekSaleQty) * 100\n              : null;\n        } else {\n          value =\n            totalSaleQty && size.saleQty !== null\n              ? (size.saleQty / totalSaleQty) * 100\n              : null;\n        }\n        value = formatPercentage(value);\n        if(value){\n          value = `${value}%`\n        }\n      } else if (metric.key === 'saleRatePercent') {\n        // 판매율: period 모드일 때는 기간 판매량/누적입고량\n        if (isPeriodMode) {\n          value =\n            size.inQty && size.weekSaleQty !== null\n              ? (size.weekSaleQty / size.inQty) * 100\n              : null;\n        } else {\n          value =\n            size.inQty && size.saleQty !== null\n              ? (size.saleQty / size.inQty) * 100\n              : null;\n        }\n        value = formatPercentage(value);\n        if(value){\n          value = `${value}%`\n        }\n      }\n\n      row[`col_${index + 1}`] = value;\n    });\n\n    // Add TTL values\n    if (metric.key === 'inQty') {\n      row[`col_${ttlColumnIndex}`] = totalInQty || null;\n    } else if (metric.key === 'planQty') {\n      row[`col_${ttlColumnIndex}`] = totalPlanQty || null;\n    } else if (metric.key === 'weekSaleQty') {\n      row[`col_${ttlColumnIndex}`] = totalWeekSaleQty || null;\n    } else if (metric.key === 'saleQty') {\n      row[`col_${ttlColumnIndex}`] = totalSaleQty || null;\n    } else if (metric.key === 'saleRatePercent') {\n      // 전체 판매율: period 모드일 때는 기간 판매량/누적입고량\n      let totalSaleRate;\n      if (isPeriodMode) {\n        totalSaleRate = totalInQty ? (totalWeekSaleQty / totalInQty) * 100 : null;\n      } else {\n        totalSaleRate = totalInQty ? (totalSaleQty / totalInQty) * 100 : null;\n      }\n      let rate_val = formatPercentage(totalSaleRate);\n      row[`col_${ttlColumnIndex}`] = rate_val ? `${rate_val}%` : '';\n    } else {\n      row[`col_${ttlColumnIndex}`] = null;\n    }\n\n    result.push(row);\n  });\n\n  return result;\n}\n\n\nfunction transform(data){\n  const result = {};\n  const mergedItems = []; // 모든 데이터를 모아놓을 배열\n\n  const transform_data = formatDataAsArray(data)\n  transform_data.forEach(item => {\n    \n    if (!result[item.item_nm]) {\n      result[item.item_nm] = [];\n    }\n\n    item.table_data = getTable(JSON.parse(item.size_data))\n    console.log(item.table_data)\n  \n    result[item.item_nm].push(item);\n  });\n\n  // 4의 배수가 되도록 빈 값을 추가하거나 0개일 때 제거\n  Object.keys(result).forEach(itemNm => {\n    const items = result[itemNm];\n    const remainder = items.length % 4;\n\n    if (items.length === 0) {\n      delete result[itemNm]; // 0개면 삭제\n    } else if (remainder !== 0) {\n      const itemsToAdd = 4 - remainder;\n      for (let i = 0; i < itemsToAdd; i++) {\n        const emptyItem = { sty_cd: '' }; // 빈 객체\n        items.push(emptyItem);\n      }\n    }\n  });\n\n  // 카테고리 순서를 가져옴\n  const categoryOrder = {{get_category_list.data[sel_category.value ?? 63]}}; // 외부에서 제공된 정렬 순서\n\n  // item_nm을 categoryOrder에 맞게 정렬\n  Object.keys(result)\n    .sort((a, b) => {\n      const indexA = categoryOrder?.indexOf(a);\n      const indexB = categoryOrder?.indexOf(b);\n\n      // 없는 항목은 뒤로 정렬\n      return (indexA === -1 ? Infinity : indexA) - (indexB === -1 ? Infinity : indexB);\n    })\n    .forEach(itemNm => {\n      mergedItems.push(...result[itemNm]);\n    });\n\n  return mergedItems;\n\n}\n\n// Query results are available as the `data` variable\nreturn transform(data)"
    }
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <State
    id="var_sel_sty_info"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
  />
  <SqlQueryUnified
    id="get_category_list"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    notificationDuration={4.5}
    query={include("./lib/get_category_list.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    transformer="function transform(data){
  const result = {};

  const transform_data = formatDataAsArray(data)
  transform_data.forEach(item => {
    
    result[item.id] = item.item_nm_list
    
  });

  return result
}

return transform(data)"
    updateSetValueDynamically={true}
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <State
    id="var_current_category"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
    value="89"
  />
  <SqlQueryUnified
    id="get_category_list_new"
    notificationDuration={4.5}
    query={include("./lib/get_category_list_new.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    updateSetValueDynamically={true}
    warningCodes={[]}
  />
  <State
    id="var_config"
    value="{
 br_cd: '79'
}"
  />
  <SqlQueryUnified
    id="code_season"
    isMultiplayerEdited={false}
    query={include("./lib/code_season.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    warningCodes={[]}
  />
  <SqlQuery
    id="code_brand"
    query={include("./lib/code_brand.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <State id="var_brand_code" value="79" />
  <SqlQuery
    id="get_latest_seasons"
    enableTransformer={true}
    importedQueryInputs={{
      ordered: [
        { variable0: "{{ var_brand_code.value }}" },
        { variable1: "2" },
      ],
    }}
    isImported={true}
    notificationDuration={4.5}
    playgroundQueryName="get_latest_seasons"
    playgroundQueryUuid="c13b268b-11f4-4fa8-ac73-f0b48d384738"
    query={include("./lib/get_latest_seasons.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    retoolVersion="3.148.10"
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data).map(i=>i.year_season_cd)"
    warningCodes={[]}
  />
</GlobalFunctions>
