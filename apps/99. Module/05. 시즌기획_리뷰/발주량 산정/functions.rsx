<GlobalFunctions>
  <State
    id="var_category_list"
    value={
      '{\n\'07\' : { \n    "season":[ \n      { "cat_nm": "전체", "id": 19 }, \n      { "cat_nm": "기초복", "id": 1 }, \n      { "cat_nm": "기획내의", "id": 5 }, \n      { "cat_nm": "기획외의", "id": 4 }, \n      { "cat_nm": "유아복", "id": 2 },\n      { "cat_nm": "토들러", "id": 3 },\n      { "cat_nm": "기초ACC", "id": 6 }, \n      { "cat_nm": "정상ACC", "id": 7 }, \n      { "cat_nm": "일반용품", "id": 8 }, \n      { "cat_nm": "복종X", "id": 18 }\n    ],\n    "NO" : [\n      { "cat_nm": "전체", "id": 19 },\n      { "cat_nm": "기초복", "id": 1 }, \n      { "cat_nm": "기획내의", "id": 5 }, \n      { "cat_nm": "기획외의", "id": 4 }, \n      { "cat_nm": "유아복", "id": 2 }, \n      { "cat_nm": "기초ACC", "id": 6 }, \n      { "cat_nm": "정상ACC", "id": 7 }, \n      { "cat_nm": "일반용품", "id": 8 }, \n      { "cat_nm": "복종X", "id": 18 }\n    ],\n    "BIRTH": [\n      { "cat_nm": "전체", "id": 19 },\n      { "cat_nm": "침구류", "id": 11 },\n      { "cat_nm": "방수류", "id": 13 },\n      { "cat_nm": "목욕위생류", "id": 14 },\n      { "cat_nm": "완구류", "id": 15 },\n      { "cat_nm": "발육류", "id": 16 },\n      { "cat_nm": "기타", "id": 17 }, \n      { "cat_nm": "복종X", "id": 18 }\n    ]\n  },\n  \'01\' : {\n    "season": [\n      { cat_nm: "전체", id: 55 },\n      { cat_nm: "시즌의류(베이비)", id: 21 },\n      { cat_nm: "시즌의류(토들러)", id: 22 },\n      { cat_nm: "기획의류", id: 24 },\n      { cat_nm: "시즌언더", id: 20 },\n      { cat_nm: "기획언더", id: 25 },\n      { cat_nm: "시즌용품", id: 27 },\n      { cat_nm: "복종X", id: 91 }\n    ],\n    "season_less" : [\n      { cat_nm: "전체", id: 55 },\n      { cat_nm: "시즌의류(베이비)", id: 21 },\n      { cat_nm: "시즌의류(토들러)", id: 22 },\n      { cat_nm: "기획의류", id: 24 },\n      { cat_nm: "시즌언더", id: 20 },\n      { cat_nm: "기획언더", id: 25 },\n      { cat_nm: "시즌용품", id: 27 },\n      { cat_nm: "복종X", id: 91 }\n    ],\n    "yongpum": [\n      { "cat_nm": "전체", "id": 55 },\n      { "cat_nm": "발육", "id": 61 },\n      { "cat_nm": "수유", "id": 62 },\n      { "cat_nm": "완구|기타", "id": 63 },\n      { "cat_nm": "섬유1", "id": 64 },\n      { "cat_nm": "섬유2", "id": 65 },\n      { "cat_nm": "위생", "id": 66 }, \n      { "cat_nm": "화장품", "id": 68 }\n    ]\n  },\n  \'79\': {\n    "season":[ \n      { "cat_nm": "전체", "id": 89 }, \n      { "cat_nm": "시즌의류", "id": 57 },\n      { "cat_nm": "시즌언더", "id": 56 },  \n      { "cat_nm": "파자마", "id": 59 }, \n      { "cat_nm": "시즌용품", "id": 62 },\n      { "cat_nm": "복종X", "id": 91 }\n    ],\n  "season_less":[ \n      { "cat_nm": "전체", "id": 89 }, \n      { "cat_nm": "시즌의류", "id": 57 },\n      { "cat_nm": "시즌언더", "id": 56 },  \n      { "cat_nm": "파자마", "id": 59 }, \n      { "cat_nm": "시즌용품", "id": 62 },\n      { "cat_nm": "복종X", "id": 91 }\n    ],\n  "mart":[ \n      { "cat_nm": "전체", "id": 89 }, \n      { "cat_nm": "시즌의류", "id": 57 },\n      { "cat_nm": "시즌언더", "id": 56 },  \n      { "cat_nm": "파자마", "id": 59 }, \n      { "cat_nm": "시즌용품", "id": 62 },\n      { "cat_nm": "복종X", "id": 91 }\n    ],\n  "yongpum": [\n      { "cat_nm": "전체", "id": 89 },\n      { "cat_nm": "발육", "id": 81 },\n      { "cat_nm": "수유", "id": 82 },\n      { "cat_nm": "완구|기타", "id": 83 },\n      { "cat_nm": "섬유1", "id": 84 },\n      { "cat_nm": "섬유2", "id": 85 },\n      { "cat_nm": "위생", "id": 86 }, \n      { "cat_nm": "화장품", "id": 88 }\n    ]\n  }\n}'
    }
  />
  <SqlQuery
    id="get_main_item_list"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_main_item_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <State id="var_main_item_info" />
  <SqlQuery
    id="get_related_item_list"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_related_item_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="get_item_list"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_item_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showFailureToaster={false}
    showSuccessToaster={false}
    transformer="function getTable(inputData) {
  // Step 1: Create a map of sizes with their corresponding data
  const sizeDataMap = {};
  inputData.forEach(item => {
    const sizeCd = parseInt(item.size_cd, 10);
    const sizeNm = item.size_nm;
    const inQty = item.tot_in_qty !== null ? parseInt(item.tot_in_qty, 10) : null;
    const saleQty = item.tot_sale_qty !== null ? parseInt(item.tot_sale_qty, 10) : null;
    const inShopCnt = item.in_shop_cnt !== null ? parseInt(item.in_shop_cnt, 10) : null;
    const saleShopCnt = item.sale_shop_cnt !== null ? parseInt(item.sale_shop_cnt, 10) : null;

    sizeDataMap[sizeCd] = {
      size_nm: sizeNm,
      inQty,
      saleQty,
      inShopCnt,
      saleShopCnt
    };
  });

  // Step 2: Sort sizes by size_cd
  const sortedSizes = Object.keys(sizeDataMap)
    .map(sizeCd => ({
      size_cd: parseInt(sizeCd, 10),
      ...sizeDataMap[sizeCd],
    }))
    .sort((a, b) => a.size_cd - b.size_cd);

  // Step 3: Filter sizes where 입고수량 is not null
  const sizesWithInQty = sortedSizes.filter(size => size.inQty !== null);

  // Step 4: Build columns dynamically
  const result = [];

  // First row: size names (use null if 입고수량 is null)
  const firstRow = { SIZE: 'SIZE' };
  sizesWithInQty.forEach((size, index) => {
    firstRow[`col_${index + 1}`] = size.size_nm;
  });

  // Add TTL column immediately after sizes
  const ttlColumnIndex = sizesWithInQty.length + 1;
  firstRow[`col_${ttlColumnIndex}`] = 'TTL';

  result.push(firstRow);

  // Initialize totals
  let totalInQty = 0;
  let totalSaleQty = 0;

  // Metrics to include
  const metrics = [
    { label: '입고수량', key: 'inQty' },
    { label: '판매수량', key: 'saleQty' },
    { label: '입고비중(%)', key: 'inQtyPercent' },
    { label: '판매비중(%)', key: 'saleQtyPercent' },
    { label: '판매율(%)', key: 'saleRatePercent' },
    { label: '입고매장', key: 'inShopCnt' },
    { label: '판매매장', key: 'saleShopCnt' },
  ];

  // Calculate totals
  sizesWithInQty.forEach(size => {
    if (size.inQty !== null) {
      totalInQty += size.inQty;
    }
    if (size.saleQty !== null) {
      totalSaleQty += size.saleQty;
    }
  });

  // Helper function to format percentages
  function formatPercentage(value) {
    if (value === null || isNaN(value)) return null;
    return value % 1 === 0 ? parseInt(value) : value.toFixed(1);
  }

  // Generate data rows for each metric
  metrics.forEach(metric => {
    const row = { SIZE: metric.label };
    sizesWithInQty.forEach((size, index) => {
      let value = null;

      if (metric.key === 'inQty') {
        value = size.inQty !== null ? size.inQty : null;
      } else if (metric.key === 'saleQty') {
        value = size.saleQty !== null ? size.saleQty : null;
      } else if (metric.key === 'inQtyPercent') {
        value =
          totalInQty && size.inQty !== null
            ? (size.inQty / totalInQty) * 100
            : null;
        value = formatPercentage(value);
      } else if (metric.key === 'saleQtyPercent') {
        value =
          totalSaleQty && size.saleQty !== null
            ? (size.saleQty / totalSaleQty) * 100
            : null;
        value = formatPercentage(value);
      } else if (metric.key === 'saleRatePercent') {
        value =
          size.inQty && size.saleQty !== null
            ? (size.saleQty / size.inQty) * 100
            : null;
        value = formatPercentage(value);
      } else if (metric.key === 'inShopCnt') {
        value = size.inShopCnt;
      } else if (metric.key === 'saleShopCnt') {
        value = size.saleShopCnt;
      }

      row[`col_${index + 1}`] = value;
    });

    // Add TTL values
    if (metric.key === 'inQty') {
      row[`col_${ttlColumnIndex}`] = totalInQty || null;
    } else if (metric.key === 'saleQty') {
      row[`col_${ttlColumnIndex}`] = totalSaleQty || null;
    } else if (metric.key === 'saleRatePercent') {
      const totalSaleRate =
        totalInQty ? (totalSaleQty / totalInQty) * 100 : null;
      row[`col_${ttlColumnIndex}`] = formatPercentage(totalSaleRate);
    } else {
      row[`col_${ttlColumnIndex}`] = null;
    }

    result.push(row);
  });

  return result;
}


function transform(data){
  const result = {};
  const mergedItems = []; // 모든 데이터를 모아놓을 배열

  const transform_data = formatDataAsArray(data)
  transform_data.forEach(item => {
    
    if (!result[item.item_nm]) {
      result[item.item_nm] = [];
    }

    item.table_data = getTable(JSON.parse(item.size_data))
    console.log(item.table_data)
  
    result[item.item_nm].push(item);
  });


  Object.keys(result)
    .forEach(itemNm => {
      mergedItems.push(...result[itemNm]);
    });

  return mergedItems;

}

// Query results are available as the `data` variable
return transform(data)"
    warningCodes={[]}
  />
  <State id="var_selected_related_items" value="[]" />
  <JavascriptQuery
    id="add_item"
    notificationDuration={4.5}
    query={include("./lib/add_item.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="delete_item"
    notificationDuration={4.5}
    query={include("./lib/delete_item.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <State id="var_delete_item" value="" />
  <State id="var_item_info" />
  <SqlQuery
    id="get_shop_sales"
    notificationDuration={4.5}
    query={include("./lib/get_shop_sales.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_shop_sales_graph_data"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_shop_sales_per_graph_data"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_shop_in_graph_data"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <JavascriptQuery
    id="get_shop_sales_graph_data"
    notificationDuration={4.5}
    query={include("./lib/get_shop_sales_graph_data.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="get_shop_sales_per_graph_data"
    notificationDuration={4.5}
    query={include("./lib/get_shop_sales_per_graph_data.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="get_shop_in_graph_data"
    notificationDuration={4.5}
    query={include("./lib/get_shop_in_graph_data.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <SqlQuery
    id="get_online_sales"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_online_sales.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <State
    id="var_assort"
    value={
      '{\n  "size_1": {\n    "qty": {{ size_1_qty.value }},\n    "per": {{ size_1_per.value }}\n  },\n  "size_2": {\n    "qty": {{ size_2_qty.value }},\n    "per": {{ size_2_per.value }}\n  },\n  "size_3": {\n    "qty": {{ size_3_qty.value }},\n    "per": {{ size_3_per.value }}\n  },\n  "size_4": {\n    "qty": {{ size_4_qty.value }},\n    "per": {{ size_4_per.value }}\n  },\n  "size_5": {\n    "qty": {{ size_5_qty.value }},\n    "per": {{ size_5_per.value }}\n  },\n  "size_6": {\n    "qty": {{ size_6_qty.value }},\n    "per": {{ size_6_per.value }}\n  },\n  "size_7": {\n    "qty": {{ size_7_qty.value }},\n    "per": {{ size_7_per.value }}\n  },\n  "size_8": {\n    "qty": {{ size_8_qty.value }},\n    "per": {{ size_8_per.value }}\n  },\n  "size_9": {\n    "qty": {{ size_9_qty.value }},\n    "per": {{ size_9_per.value }}\n  },\n  "size_10": {\n    "qty": {{ size_10_qty.value }},\n    "per": {{ size_10_per.value }}\n  }\n}'
    }
  />
  <State
    id="var_assort_final"
    value={
      '{\n  "size_1": {\n    "qty": {{ size_1_qty2.value }},\n    "per": {{ size_1_per2.value }}\n  },\n  "size_2": {\n    "qty": {{ size_2_qty2.value }},\n    "per": {{ size_2_per2.value }}\n  },\n  "size_3": {\n    "qty": {{ size_3_qty2.value }},\n    "per": {{ size_3_per2.value }}\n  },\n  "size_4": {\n    "qty": {{ size_4_qty2.value }},\n    "per": {{ size_4_per2.value }}\n  },\n  "size_5": {\n    "qty": {{ size_5_qty2.value }},\n    "per": {{ size_5_per2.value }}\n  },\n  "size_6": {\n    "qty": {{ size_6_qty2.value }},\n    "per": {{ size_6_per2.value }}\n  },\n  "size_7": {\n    "qty": {{ size_7_qty2.value }},\n    "per": {{ size_7_per2.value }}\n  },\n  "size_8": {\n    "qty": {{ size_8_qty2.value }},\n    "per": {{ size_8_per2.value }}\n  },\n  "size_9": {\n    "qty": {{ size_9_qty2.value }},\n    "per": {{ size_9_per2.value }}\n  },\n  "size_10": {\n    "qty": {{ size_10_qty2.value }},\n    "per": {{ size_10_per2.value }}\n  }\n}'
    }
  />
  <SqlQueryUnified
    id="save_assort"
    isMultiplayerEdited={false}
    query={include("./lib/save_assort.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    successMessage="현재 정보가 저장되었습니다."
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_assort"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <SqlQueryUnified
    id="get_assort"
    enableTransformer={true}
    query={include("./lib/get_assort.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    transformer="const assort_data = formatDataAsArray(data)

let result = {}
assort_data.forEach(item => {
    if (item.related_items === 0 || (typeof item.related_items === 'object' && !Array.isArray(item.related_items))) {
    item.related_items = [];
  }
  result[item.sty_col_cd] = item
});

return result"
    warningCodes={[]}
  />
  <SqlQueryUnified
    id="save_assort_final"
    isMultiplayerEdited={false}
    query={include("./lib/save_assort_final.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    successMessage="최종 정보가 저장되었습니다"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_assort"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <SqlQuery
    id="get_size_shop"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_size_shop.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="const transform_data = formatDataAsArray(data);

const result = [];
transform_data.forEach(item => {
    
    if (!result[item.size_nm]) {
      result[item.size_nm] = [];
    }

    result[item.size_nm].push(item);
  });

return transform_data;"
    warningCodes={[]}
  />
  <JavascriptQuery
    id="set_md_qty"
    notificationDuration={4.5}
    query={include("./lib/set_md_qty.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="set_md_per"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/set_md_per.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <State
    id="var_size_list"
    value={
      '[\n  { "size_type": "의류A", "size_list": ["60", "65", "70", "75", "80", "85", "90", "95", "100", "110"] },\n  { "size_type": "의류B", "size_list": ["75", "80", "85", "90", "95", "100", "110", "120", "130", "140"] },\n  { "size_type": "신발A", "size_list": ["100", "110", "115", "120", "125", "130", "135", "140", "145", "150"] },\n  { "size_type": "양말", "size_list": ["0-6", "7-8", "9-10", "11-12", "13-14", "15-16", "17-18", "19-20", "21-22"] },\n  { "size_type": "모자", "size_list": ["40", "42", "44", "46", "48", "50", "52", "54", "56"] },\n  { "size_type": "의류J", "size_list": ["NB", "3M", "6M", "9M", "12M", "18M", "24M", "2T", "3T", "4T"] },\n  { "size_type": "의류L", "size_list": ["3M", "6M", "12M", "18M", "2Y", "3Y", "4Y", "5Y"] },\n  { "size_type": "신발B", "size_list": ["130", "135", "140", "145", "150", "155", "160", "170", "180", "190"] }\n]'
    }
  />
  <State
    id="var_size_tp"
    value={
      '{\n  "99" : "의류L",\n  "00" : "의류L",\n  "01" : "의류L",\n  "10" : "의류L",\n  "11" : "의류L",\n  "13" : "의류L",\n  "14" : "의류L",\n  "22" : "의류L",\n  "23" : "의류L",\n  "25" : "의류L",\n  "27" : "의류L",\n  "28" : "의류L",\n  "29" : "의류L",\n  "30" : "의류L",\n  "40" : "의류L",\n  "50" : "의류L",\n  "60" : "의류L",\n  "70" : "의류L",\n  "80" : "의류L",\n  "81" : "의류L",\n  "82" : "의류L",\n  "83" : "의류L",\n  "84" : "의류L",\n  "85" : "의류L",\n  "86" : "의류L",\n  "88" : "의류L",\n  "89" : "의류L",\n  "90" : "의류L",\n  "99" : "의류L"\n}'
    }
  />
  <SqlQuery
    id="get_size_info"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/get_size_info.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    transformer={
      'const size_tp_name_dict = {\n  "00": "대표사이즈",\n  "10": "의류A",\n  "11": "의류B",\n  "13": "의류J",\n  "14": "의류L",\n  "22": "의류E",\n  "23": "의류F",\n  "25": "의류H",\n  "27": "의류J",\n  "28": "의류K",\n  "29": "의류L",\n  "30": "신발A",\n  "40": "신발B",\n  "50": "양말",\n  "60": "모자",\n  "70": "젖꼭지등",\n  "80": "기저귀카바",\n  "81": "이불세트",\n  "82": "겉싸보",\n  "83": "처네",\n  "84": "싸보류",\n  "85": "방수요",\n  "86": "기타침구류",\n  "88": "면기저귀",\n  "89": "위생섬유기타",\n  "90": "업는띠",\n  "99": "FREE"\n};\n\nconst custom_size_dict = {\n  "양말" : ["0-6", "7-8", "9-10", "11-12", "13-14", "15-16", "17-18", "19-20", "21-22"]\n}\n\n\nconst transform_data = formatDataAsArray(data);\n\n// 데이터 그룹화\nconst groupedData = transform_data.reduce((acc, item) => {\n  const { size_tp, size_cd, size_nm } = item;\n\n  let size_tp_nm = size_tp_name_dict[size_tp];\n\n  // size_tp가 이미 존재하는지 확인\n  let group = acc.find(g => g.size_tp === size_tp);\n\n  if (!group) {\n    // 새로운 그룹 추가\n    group = { size_tp, size_tp_nm, size_cd_list: [], size_nm_list: [] };\n    acc.push(group);\n  }\n\n  // size_cd 추가\n  group.size_cd_list.push(size_cd);\n  group.size_nm_list.push(size_nm);\n\n  return acc;\n}, []);\n\n// 강제 사이즈 변환\ngroupedData.forEach(group => {\n  if (custom_size_dict[group.size_tp_nm]) {\n    group.size_nm_list = custom_size_dict[group.size_tp_nm]; \n  }\n});\n\n// 결과 반환\nreturn groupedData;'
    }
    warningCodes={[]}
  />
  <State
    id="var_selected_size_info"
    value={
      '{{ get_size_info.data.find(item => item.size_tp == main_items_table.selectedSourceRow.size_tp) || {"size_tp": main_items_table.selectedSourceRow.size_tp, "size_tp_nm": "", "size_cd_list": [], size_nm_list : [] } }}'
    }
  />
  <State id="var_sty_data" />
  <State id="var_brand_code" value="{{ brand_code.value }}" />
  <SqlQuery
    id="get_season_list_dimstyle"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_season_list_dimstyle.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer=""
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_categories_by_brand"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <SqlQuery
    id="get_categories_by_brand"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/get_categories_by_brand.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="transform_categories"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <JavascriptQuery
    id="transform_categories"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/transform_categories.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <SqlQuery
    id="get_lot_by_color"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/get_lot_by_color.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="const assort_data = formatDataAsArray(data)

let result = {}
assort_data.forEach(item => {
    if (item.related_items === 0 || (typeof item.related_items === 'object' && !Array.isArray(item.related_items))) {
    item.related_items = [];
  }
  result[item.sty_col_cd] = item
});

return result"
    warningCodes={[]}
  />
  <SqlQuery
    id="get_categories_by_brand_for_reference"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/get_categories_by_brand_for_reference.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="transform_categories_for_reference"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <JavascriptQuery
    id="transform_categories_for_reference"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/transform_categories_for_reference.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
</GlobalFunctions>
