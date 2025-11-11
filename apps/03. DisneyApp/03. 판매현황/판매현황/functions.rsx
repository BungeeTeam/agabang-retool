<GlobalFunctions>
  <Folder id="item_detail">
    <State
      id="var_item_info"
      _persistedValueGetter={null}
      _persistedValueSetter={null}
      persistedValueKey=""
      persistValue={false}
    />
  </Folder>
  <Folder id="sales_graph">
    <JavascriptQuery
      id="set_last_seasons"
      errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/set_last_seasons.js", "string")}
      resourceName="JavascriptQuery"
      runWhenPageLoads={true}
      showSuccessToaster={false}
      transformer="// Query results are available as the `data` variable
return data"
      workflowActionType={null}
      workflowBlockUuid={null}
      workflowRunId={null}
    />
    <State
      id="var_last_seasons"
      _persistedValueGetter={null}
      _persistedValueSetter={null}
      persistedValueKey=""
      persistValue={false}
    />
    <SqlQuery
      id="get_cum_sales_by_day"
      enableTransformer={true}
      errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/get_cum_sales_by_day.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      showSuccessToaster={false}
      transformer={
        '// Date 객체를 MM-DD 형식으로 변환하는 함수\nfunction formatDateToMonthDay(date) {\n    return date.toISOString().slice(5, 10);\n  }\n  \n  function monthDayToDate(monthDay, year=2000) {\n    return new Date(year, parseInt(monthDay.slice(0, 2)) - 1, parseInt(monthDay.slice(3, 5)));\n  }\n  \n  const formattedData = formatDataAsArray(data);\n  if (!formattedData || formattedData.length === 0) {\n    return {\n      sale_qty_per: [],\n      sale_amt_per: [],\n      sale_tag_amt_per: []\n    };\n  }\n  console.log("Formatted data sample:", formattedData.slice(0, 3));\n  console.log("Total formatted data length:", formattedData.length);\n  \n  // 상위 키로 사용할 지표 목록\n  const metrics = [\'sale_qty_per\', \'sale_amt_per\', \'sale_tag_amt_per\'];\n  \n  // 결과를 저장할 객체 초기화\n  const result = {\n    sale_qty_per: [],\n    sale_amt_per: [],\n    sale_tag_amt_per: []\n  };\n  \n  // 데이터를 year_season별로 그룹화\n  const groupedData = {};\n  formattedData.forEach(item => {\n    const yearSeason = item.year_season;\n  \n    if (!groupedData[yearSeason]) {\n      groupedData[yearSeason] = [];\n    }\n  \n    groupedData[yearSeason].push(item);\n  });\n  \n  // 그룹화된 데이터 디버깅\n  console.log("Grouped data keys (year_seasons):", Object.keys(groupedData));\n  Object.keys(groupedData).forEach(yearSeason => {\n    console.log(`${yearSeason}: ${groupedData[yearSeason].length} records`);\n    if (groupedData[yearSeason].length > 0) {\n      console.log(`${yearSeason} sample data:`, groupedData[yearSeason][0]);\n    }\n  });\n  \n  // 각 시즌별로 실제 날짜 기준으로 정렬\n  Object.keys(groupedData).forEach(yearSeason => {\n    groupedData[yearSeason].sort((a, b) => {\n      return new Date(a.sale_dt) - new Date(b.sale_dt);\n    });\n  });\n  \n  \n  console.log("First data item:", formattedData[0]);\n  \n  // SQL에서 계산된 global_first_month_day를 직접 사용\n  let xAxisStart = \'12-31\'; // 기본값을 늦은 날짜로 설정\n  \n  // 첫 번째 데이터에서 global_first_month_day 값을 가져옴\n  if (formattedData.length > 0 && formattedData[0].global_first_month_day) {\n    xAxisStart = formattedData[0].global_first_month_day;\n    console.log("Using global_first_month_day from SQL:", xAxisStart);\n  } else {\n    // global_first_month_day가 없는 경우 기존 로직 사용 (하지만 개선)\n    console.log("global_first_month_day not found, using fallback logic");\n    \n    Object.keys(groupedData).forEach(yearSeason => {\n      const seasonData = groupedData[yearSeason];\n      \n      let firstOutDate = null;\n      \n      // seasonData 전체를 순회하면서 가장 먼저 마주하는 유효한 날짜 찾기\n      for (let i = 0; i < seasonData.length; i++) {\n        const item = seasonData[i];\n        \n        // first_out_day 필드가 있으면 월-일만 추출하여 사용\n        if (item.first_out_day) {\n          const firstOutDayDate = new Date(item.first_out_day);\n          firstOutDate = formatDateToMonthDay(firstOutDayDate);\n          console.log(`${yearSeason}: first_out_day = ${item.first_out_day}, extracted = ${firstOutDate}`);\n          break;\n        }\n        \n        // first_out_day가 없는 경우 sale_dt 사용 (out_qty 필드는 SQL 결과에 없음)\n        if (item.sale_dt) {\n          const saleDtDate = new Date(item.sale_dt);\n          firstOutDate = formatDateToMonthDay(saleDtDate);\n          console.log(`${yearSeason}: using sale_dt = ${item.sale_dt}, extracted = ${firstOutDate}`);\n          break;\n        }\n      }\n      \n      // 유효한 날짜가 있으면 최소값 비교\n      if (firstOutDate) {\n        const oldXAxisStart = xAxisStart;\n        xAxisStart = xAxisStart < firstOutDate ? xAxisStart : firstOutDate;\n        console.log(`${yearSeason}: comparing ${oldXAxisStart} vs ${firstOutDate}, result = ${xAxisStart}`);\n      }\n    });\n  }\n  \n  console.log("Final xAxisStart:", xAxisStart);\n  \n  // xAxisStart (\'MM-DD\')를 Date 객체로 변환 (JavaScript 월은 0-based이므로 -1)\n  console.log("monthDayToDate function input:", xAxisStart);\n  const month = parseInt(xAxisStart.slice(0, 2));\n  const day = parseInt(xAxisStart.slice(3, 5));\n  console.log("Extracted month:", month, "day:", day);\n  console.log("Date constructor args:", 2000, month - 1, day);\n  \n  const xAxisStartAsDate = monthDayToDate(xAxisStart);\n  console.log("xAxisStartAsDate type:", typeof xAxisStartAsDate);\n  console.log("xAxisStartAsDate toString:", xAxisStartAsDate ? xAxisStartAsDate.toString() : \'null\');\n  console.log("xAxisStartAsDate getTime:", xAxisStartAsDate ? xAxisStartAsDate.getTime() : \'null\');\n  \n  const oneDayInMilliseconds = 24 * 60 * 60 * 1000; // 1일 = 24시간 * 60분 * 60초 * 1000밀리초\n  \n  const xCategories = Array.from({length: 365}, (_, i) => {\n    const currentDate = new Date(xAxisStartAsDate.getTime() + (i * oneDayInMilliseconds));\n    return formatDateToMonthDay(currentDate);\n  });\n  \n  \n  // 색상 배열 정의\n  const colors = [\'#1E3A8A\', \'#3170F9\', \'#F9A031\'];\n  const yearSeasons = Object.keys(groupedData);\n  \n  function getSeoulDate(date) {\n    console.log("getSeoulDate input:", date ? date.toString() : \'null\');\n    if (!date || isNaN(date.getTime())) {\n      console.log("Invalid date input to getSeoulDate");\n      return new Date();\n    }\n    const utcTime = date.getTime() + (date.getTimezoneOffset() * 60000);\n    const seoulTime = new Date(utcTime + (9 * 3600000)); // +9시간\n    console.log("getSeoulDate output:", seoulTime.toString());\n    return seoulTime;\n  }\n  \n  const originalNow = new Date(new Date().setDate(new Date().getDate() - 1));\n  console.log("Original now:", originalNow.toString());\n  const now = getSeoulDate(originalNow);\n  console.log("Seoul now toString:", now.toString());\n  console.log("Seoul now type:", typeof now);\n  \n  // yearSeason과 monthDay를 기준으로 365일 범위 내의 데이터만 필터링하는 함수\n  function fitDateWindow(yearSeason, monthDay, seasonData) {\n    console.log(`fitDateWindow called for ${yearSeason} with monthDay: ${monthDay}, data count: ${seasonData.length}`);\n    \n    // yearSeason에서 년도 추출 및 시즌별 조정\n    const yearPrefix = yearSeason.substring(0, 2);\n    const seasonType = yearSeason.substring(2); // SP, SM, FA, WR 등\n    \n    // SP(Spring) 시즌은 전년도 11월부터 시작되므로 -1년 적용\n    let fullYear = 2000 + parseInt(yearPrefix);\n    if (seasonType === \'SP\') {\n      fullYear = fullYear - 1;\n    }\n    \n    console.log(`${yearSeason}: yearPrefix=${yearPrefix}, seasonType=${seasonType}, adjustedYear=${fullYear}`);\n    \n    // 시작 날짜 생성 (예: 2024-02-26)\n    const startDate = monthDayToDate(monthDay, fullYear);\n    console.log(`${yearSeason}: startDate=${startDate.toString()}`);\n    \n    // 종료 날짜 생성 (시작일로부터 365일 후, 예: 2025-02-25)\n    const endDate = new Date(startDate);\n    endDate.setDate(startDate.getDate() + 364); // 365일 범위 (시작일 포함)\n    console.log(`${yearSeason}: endDate=${endDate.toString()}`);\n    \n    // seasonData에서 sale_dt가 범위 안에 있는 데이터만 필터링\n    let validCount = 0;\n    let dateRangeCount = 0;\n    let futureCount = 0;\n    \n    const filteredData = seasonData.filter(item => {\n      const saleDate = new Date(item.sale_dt);\n      const inDateRange = saleDate >= startDate && saleDate <= endDate;\n      const notFuture = saleDate <= now;\n      \n      if (inDateRange) dateRangeCount++;\n      if (!notFuture) futureCount++;\n      if (inDateRange && notFuture) validCount++;\n      \n      return inDateRange && notFuture;\n    });\n    \n    console.log(`${yearSeason}: original=${seasonData.length}, dateRange=${dateRangeCount}, future=${futureCount}, valid=${validCount}, filtered=${filteredData.length}`);\n    \n    if (filteredData.length > 0) {\n      console.log(`${yearSeason}: first filtered item:`, filteredData[0]);\n      console.log(`${yearSeason}: last filtered item:`, filteredData[filteredData.length-1]);\n    }\n    \n    return filteredData;\n  }\n  \n  \n  // 모든 지표에 대해 데이터 생성\n  metrics.forEach(metric => {\n    yearSeasons.forEach((yearSeason, index) => {\n      const seasonData = groupedData[yearSeason];\n  \n      // 월-일을 키로 하는 맵 생성\n      const dataMap = {};\n      const filteredData = fitDateWindow(yearSeason, xAxisStart, seasonData);\n      filteredData.forEach(d => {\n        const saleDate = new Date(d.sale_dt);\n        const monthDay = formatDateToMonthDay(saleDate);\n  \n        dataMap[monthDay] = {\n          value: d[metric],\n          originalDate: d.sale_dt\n        };\n      });\n  \n      // xCategories 순서대로 y 값 배열 생성\n      const yValues = [];\n      const customData = [];\n      let lastValue = null;\n  \n      xCategories.forEach((monthDay) => {\n        const isNextYear = monthDay < xAxisStart;\n        const fullYear = parseInt(yearSeason.substring(0, 2)) + 2000 + (isNextYear ? 1 : 0);\n        const item = dataMap[monthDay];\n        customData.push(`${fullYear}-${monthDay}`);\n        if (item) {\n          const saleDate = new Date(item.originalDate);\n          // 현재 날짜 이후의 데이터는 null로 처리\n          if (saleDate > now) {\n            yValues.push(null);\n          } else {\n            yValues.push(item.value);\n            if (item.value !== null) { // null이 아닌 경우에만 lastValue 업데이트\n                lastValue = item.value;\n            }\n          }\n        } else if (monthDayToDate(monthDay, fullYear) > now) {\n          yValues.push(null);\n        } else {\n          yValues.push(lastValue);\n        }\n      });\n  \n      const series = {\n        name: yearSeason,\n        x: xCategories,\n        y: yValues,\n        type: \'scatter\',\n        mode: \'lines\',\n        connectgaps: false, // null 값에서 선 끊기\n        hovertemplate: `\n  <b>시즌: %{fullData.name}</b><br>\n  <b>날짜: %{customdata}</b><br>\n  <b>판매율: %{y}%</b><extra></extra>\n        `,\n        customdata: customData,\n        line: {\n          color: colors[index % colors.length],\n          width: 2\n        }\n      };\n  \n      result[metric].push(series);\n    });\n  });\n  \n  // X축 범위 정보 추가\n  result.xRange = [0, Math.min(364, xCategories.length - 1)]; // 최대 365일\n  result.xCategories = xCategories;\n  return result;'
      }
      warningCodes={[]}
      workflowActionType={null}
      workflowBlockUuid={null}
      workflowRunId={null}
    />
    <SqlQuery
      id="get_cum_sales_by_week"
      enableTransformer={true}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/get_cum_sales_by_week.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      showSuccessToaster={false}
      transformer="function transform(data) {
  data = formatDataAsArray(data);
  
  // 상위 키로 사용할 지표 목록
  const metrics = ['sale_qty_per', 'sale_amt_per', 'sale_tag_amt_per'];
  
  // 결과를 저장할 객체 초기화
  const result = {
    sale_qty_per: [],
    sale_amt_per: [],
    sale_tag_amt_per: []
  };
  
  // 모든 주차를 수집하고 정렬
  const allWeeks = new Set();
  const weekToDateRange = new Map();
  
  // 먼저 모든 주차와 날짜 범위를 수집
  data.forEach(item => {
    allWeeks.add(item.weeks);
    if (!weekToDateRange.has(item.weeks)) {
      const dateRange = item.date_range;
      const dateRangeParts = dateRange.split(' - ');
      const startDate = dateRangeParts[0].substring(5);
      const endDate = dateRangeParts[1].substring(5);
      const simplifiedDateRange = `${startDate}~${endDate}`;
      weekToDateRange.set(item.weeks, simplifiedDateRange);
    }
  });
  
  // 주차를 정렬
  const sortedWeeks = Array.from(allWeeks).sort((a, b) => a - b);
  const sortedDateRanges = sortedWeeks.map(week => weekToDateRange.get(week));
  
  // 데이터를 year_season별로 그룹화합니다.
  const groupedData = {};
  
  data.forEach(item => {
    const yearSeason = item.year_season;
    const weeks = item.weeks;
    const dateRange = item.date_range;
    
    if (!groupedData[yearSeason]) {
      groupedData[yearSeason] = {
        weekData: new Map(),
        customdata: new Map()
      };
    }
    
    groupedData[yearSeason].weekData.set(weeks, {
      sale_qty_per: item.sale_qty_per,
      sale_amt_per: item.sale_amt_per,
      sale_tag_amt_per: item.sale_tag_amt_per
    });
    groupedData[yearSeason].customdata.set(weeks, dateRange);
  });
  
  // 색상 배열을 정의합니다.
  const colors = ['#1E3A8A', '#3170F9', '#F9A031'];
  const yearSeasons = Object.keys(groupedData).sort(); // 시즌 정렬
  
  metrics.forEach(metric => {
    yearSeasons.forEach((yearSeason, index) => {
      let yAxisTitle = '';
      let hoverFormat = '';
      
      // 지표별로 다른 표시 형식 설정
      switch(metric) {
        case 'sale_qty_per':
          yAxisTitle = '판매수량';
          hoverFormat = '%{y:,.0f}(개)';
          break;
        case 'sale_amt_per':
          yAxisTitle = '판매액';
          hoverFormat = '%{y:,.0f}(백만원)';
          break;
        case 'sale_tag_amt_per':
          yAxisTitle = '정가기준 판매액';
          hoverFormat = '%{y:,.0f}(백만원)';
          break;
      }
      
      // 정렬된 주차에 따라 y값과 customdata 배열 생성
      const yValues = [];
      const customdataValues = [];
      
      sortedWeeks.forEach(week => {
        const data = groupedData[yearSeason].weekData.get(week);
        const customdata = groupedData[yearSeason].customdata.get(week);
        
        if (data && customdata) {
          yValues.push(data[metric]);
          customdataValues.push(customdata);
        } else {
          // 해당 주차에 데이터가 없으면 null 추가
          yValues.push(null);
          customdataValues.push('');
        }
      });
      
      const series = {
        name: yearSeason,
        x: sortedDateRanges, // 모든 시리즈가 동일한 x축 사용
        y: yValues,
        customdata: customdataValues,
        type: 'line',
        mode: 'lines+markers', // 마커도 표시하여 실제 데이터 포인트를 명확히 표시
        connectgaps: true, // null 값이 있어도 선을 연결
        hovertemplate: `
<b>시즌: %{fullData.name}</b><br>
<b>기간: %{customdata}</b><br>
<b>${yAxisTitle}: ${hoverFormat}</b><extra></extra>
        `,
        line: {
          color: colors[index % colors.length],
          width: 2
        },
        marker: {
          color: colors[index % colors.length],
          size: 6
        }
      };
      
      result[metric].push(series);
    });
  });
  
  return result;
}
// Query results are available as the `data` variable
return transform(data);"
      warningCodes={[]}
    />
  </Folder>
  <Folder id="item_list">
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
      showSuccessToaster={false}
      transformer="function transform(data){
  const result = {};

  const transform_data = formatDataAsArray(data)
  transform_data.forEach(item => {
    
    if (!result[item.item_nm]) {
      result[item.item_nm] = [];
    }

    item.tot_inventory_qty = (item.tot_in_qty - item.tot_sale_qty);
    
    result[item.item_nm].push(item);
    
  });

  // 각 `item_nm` 그룹 내에서 `sale_qty_per` 기준으로 정렬
  for (const key in result) {
    result[key].sort((a, b) => b.sale_per_tot - a.sale_per_tot);
  }

  return result
}

// Query results are available as the `data` variable
return transform(data)


// function transform(data){
//   const result = {};

//   const transform_data = formatDataAsArray(data)
//   transform_data.forEach(item => {
    
//     if (!result[item.item_nm]) {
//       result[item.item_nm] = [];
//     }
    
//     result[item.item_nm].push(item);
    
//   });

//   // 각 `item_nm` 그룹 내에서 `sale_qty_per` 기준으로 정렬
//   for (const key in result) {
//     result[key].sort((a, b) => b.sale_per_tot - a.sale_per_tot);
//   }

//   return result
// }

// // Query results are available as the `data` variable
// return transform(data)"
      warningCodes={[]}
      workflowActionType={null}
      workflowBlockUuid={null}
      workflowRunId={null}
    />
    <Function
      id="var_item_list"
      funcBody={include("./lib/var_item_list.js", "string")}
    />
  </Folder>
  <Folder id="category_list">
    <SqlQueryUnified
      id="get_category_list"
      errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/get_category_list.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
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
        '{\n  "season":[ \n    { "cat_nm": "전체", "id": 89 }, \n    { "cat_nm": "시즌의류", "id": 57 },\n    { "cat_nm": "시즌언더", "id": 56 },  \n    { "cat_nm": "파자마", "id": 59 }, \n    { "cat_nm": "시즌용품", "id": 62 },\n    { "cat_nm": "복종X", "id": 91 }\n  ],\n"season_less":[ \n    { "cat_nm": "전체", "id": 89 }, \n    { "cat_nm": "시즌의류", "id": 57 },\n    { "cat_nm": "시즌언더", "id": 56 },  \n    { "cat_nm": "파자마", "id": 59 }, \n    { "cat_nm": "시즌용품", "id": 62 },\n    { "cat_nm": "복종X", "id": 91 }\n  ],\n"mart":[ \n    { "cat_nm": "전체", "id": 89 }, \n    { "cat_nm": "시즌의류", "id": 57 },\n    { "cat_nm": "시즌언더", "id": 56 },  \n    { "cat_nm": "파자마", "id": 59 }, \n    { "cat_nm": "시즌용품", "id": 62 },\n    { "cat_nm": "복종X", "id": 91 }\n  ],\n"yongpum": [\n    { "cat_nm": "전체", "id": 89 },\n    { "cat_nm": "발육", "id": 81 },\n    { "cat_nm": "수유", "id": 82 },\n    { "cat_nm": "완구|기타", "id": 83 },\n    { "cat_nm": "섬유1", "id": 84 },\n    { "cat_nm": "섬유2", "id": 85 },\n    { "cat_nm": "위생", "id": 86 }, \n    { "cat_nm": "화장품", "id": 88 }\n  ]\n}'
      }
    />
    <SqlQuery
      id="get_supplies_category_list"
      isMultiplayerEdited={false}
      query={include("./lib/get_supplies_category_list.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      warningCodes={[]}
    />
    <Function
      id="merged_category_list"
      funcBody={include("./lib/merged_category_list.js", "string")}
    />
  </Folder>
  <Folder id="filter_sidebar">
    <SqlQueryUnified
      id="code_season"
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
  </Folder>
  <Folder id="shop_sales_modal">
    <JavascriptQuery
      id="get_shop_sales_graph_data"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/get_shop_sales_graph_data.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="get_shop_sales_per_graph_data"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/get_shop_sales_per_graph_data.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="get_shop_in_graph_data"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/get_shop_in_graph_data.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
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
    <SqlQuery
      id="get_shop_sales"
      isMultiplayerEdited={false}
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
  </Folder>
  <State id="var_brand_code" value="79" />
</GlobalFunctions>
