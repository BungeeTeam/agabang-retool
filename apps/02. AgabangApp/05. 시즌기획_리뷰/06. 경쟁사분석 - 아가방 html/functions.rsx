<GlobalFunctions>
  <SqlQuery
    id="get_items"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/get_items.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    runWhenPageLoadsDelay="1000"
    showFailureToaster={false}
    transformer={
      'function transform(data) {\n  const result = {};\n  const brand_list = [];\n\n  const transform_data = formatDataAsArray(data);\n  transform_data.forEach(item => {\n    const { category_name, brand, item_code, item_name, image_url, item_link, origin_price, color, sale_per } = item;\n\n    //  console.log(item)\n\n    if (!result[category_name]) {\n      result[category_name] = {};\n    }\n\n    if (!result[category_name][brand]) {\n      result[category_name][brand] = [];\n    }\n\n    result[category_name][brand].push({\n      item_code,\n      item_name,\n      image_url,\n      item_link,\n      origin_price,\n      color,\n      sale_per,\n    });\n  });\n\n  // 가격 N위를 매기기 위해 origin_price 기준으로 순위 필드를 추가\n  Object.keys(result).forEach(category => {\n    Object.keys(result[category]).forEach(brand => {\n      const items = result[category][brand];\n\n      // 가격 기준 내림차순으로 정렬된 리스트 생성\n      const priceSortedItems = [...items].sort((a, b) => b.origin_price - a.origin_price);\n\n      // 가격 순위 추가\n      priceSortedItems?.forEach((item, index) => {\n        // 동일한 참조를 사용하여 직접 필드 추가\n        item.origin_price_ranking = `가격 ${index + 1}위`;\n      });\n\n      // 판매율 기준 정렬 + 가격 기준 정렬\n      items?.sort((a, b) => {\n        if (b.sale_per !== a.sale_per) {\n          return b.sale_per - a.sale_per; // 판매율 내림차순\n        }\n        return b.origin_price - a.origin_price; // 가격 내림차순\n      });\n      \n      // "아가방" 브랜드에 대해 item_code의 다섯 번째 글자를 기준으로 분류\n      if (brand === "아가방") {\n        //const subdividedItems = {};\n\n        items?.forEach(item => {\n          const key = item.item_code[4]; // item_code의 다섯 번째 글자 추출\n          let nm = "";\n          if (key === "1") {nm = "시즌 언더";}\n          else if (key === "2") {nm = "시즌 의류 (베이비)";}\n          else if (key === "3") {nm = "시즌 의류 (토들러)";}\n          else if (key === "4") {nm = "주니어";}\n          else if (key === "5") {nm = "기획";}\n          else if (key === "6") {nm = "출산용품 (자체 생산)";}\n          else if (key === "7") {nm = "시즌용품";}\n          else if (key === "8") {nm = "출산용품";}\n          \n          brand = "아가방_" + nm;\n          \n          if (!result[category][brand]) {\n            result[category][brand] = [];\n          }\n          if ( brand_list.includes(brand) == false ){\n            brand_list.push(brand);\n          }\n          \n          result[category][brand].push(item)\n        });\n      }\n\n      if ( brand_list.includes(brand) == false ){\n        brand_list.push(brand);\n      }\n\n      \n    });\n  });\n  \n  //  console.log(brand_list);\n  //  console.log(JSON.stringify(result));\n  \n  return result;\n}\n\n// Query results are available as the `data` variable\nreturn transform(data);'
    }
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="set_brand_list"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <State
    id="sel_item_info"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
  />
  <SqlQueryUnified
    id="get_category"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/get_category.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQueryUnified
    id="get_item_old"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    query={include("./lib/get_item_old.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <State
    id="var_item_info"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
  />
  <State
    id="var_result"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
  />
  <SqlQueryUnified
    id="get_season"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    query={include("./lib/get_season.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQueryUnified
    id="update_category_looxloo"
    confirmationMessage="최신정보로 카테고리를 업데이트 하겠습니까?"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/update_category_looxloo.sql", "string")}
    queryTimeout="30000"
    requireConfirmation={true}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    transformer="// Query results are available as the `data` variable
return data"
    updateSetValueDynamically={true}
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="update_category_happyland"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <SqlQueryUnified
    id="update_category_happyland"
    confirmationMessage="최신정보로 카테고리를 업데이트 하겠습니까?"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/update_category_happyland.sql", "string")}
    queryTimeout="30000"
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    transformer="// Query results are available as the `data` variable
return data"
    updateSetValueDynamically={true}
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="update_category_bebedepino"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <SqlQueryUnified
    id="update_category_bebedepino"
    confirmationMessage="최신정보로 카테고리를 업데이트 하겠습니까?"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/update_category_bebedepino.sql", "string")}
    queryTimeout="30000"
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    transformer="// Query results are available as the `data` variable
return data"
    updateSetValueDynamically={true}
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="update_category_moimoln"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <SqlQueryUnified
    id="update_category_moimoln"
    confirmationMessage="최신정보로 카테고리를 업데이트 하겠습니까?"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/update_category_moimoln.sql", "string")}
    queryTimeout="30000"
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    transformer="// Query results are available as the `data` variable
return data"
    updateSetValueDynamically={true}
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="update_category_lotteon"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <SqlQueryUnified
    id="update_category_lotteon"
    confirmationMessage="최신정보로 카테고리를 업데이트 하겠습니까?"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/update_category_lotteon.sql", "string")}
    queryTimeout="30000"
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    transformer="// Query results are available as the `data` variable
return data"
    updateSetValueDynamically={true}
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_items"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <State
    id="var_category_info"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
  />
  <Function
    id="category_summary"
    funcBody={include("./lib/category_summary.js", "string")}
  />
  <State
    id="var_brand_orders"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
    value={
      '["블루독베이비", "밍크뮤", "압소바", "타티네 쇼콜라", "해피랜드", "베베드피노", "베베드피노 언더웨어", "모이몰른", "모이몰른 US", "아가방"]'
    }
  />
  <JavascriptQuery
    id="set_brand_list"
    notificationDuration={4.5}
    query={include("./lib/set_brand_list.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
</GlobalFunctions>
