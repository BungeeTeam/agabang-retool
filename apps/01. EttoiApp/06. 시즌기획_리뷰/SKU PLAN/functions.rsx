<GlobalFunctions>
  <SqlQuery
    id="season_list"
    enableTransformer={true}
    isImported={true}
    notificationDuration={4.5}
    playgroundQueryName="season_list"
    playgroundQueryUuid="508692e9-ef18-4711-b256-271a313ce72c"
    query={include("./lib/season_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    retoolVersion="3.123.0"
    showSuccessToaster={false}
    transformer="function transform(data){
  const result = {};

  const transform_data = formatDataAsArray(data)
  transform_data.forEach(item => {
    
    if (!result[item.season_type]) {
      result[item.season_type] = [];
    }
    
    result[item.season_type].push(item);
    
  });

  return result
}

// Query results are available as the `data` variable
return transform(data)"
    warningCodes={[]}
  />
  <State id="var_season_list" />
  <JavascriptQuery
    id="set_season_list"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/set_season_list.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
  <SqlQueryUnified
    id="category_list"
    notificationDuration={4.5}
    query={include("./lib/category_list.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    updateSetValueDynamically={true}
    warningCodes={[]}
  />
  <SqlQuery
    id="get_season_data"
    isMultiplayerEdited={false}
    query={include("./lib/get_season_data.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenPageLoadsDelay="150"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="make_table_data"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <JavascriptQuery
    id="make_table_data"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/make_table_data.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <State id="var_select_category" />
  <RESTQuery
    id="get_analysis"
    body={
      '{\n    "model": "o3",\n    "messages": [\n      {\n        "role": "system",\n        "content": "너는 다음 시즌 기획을 통해 매출을 올려야하는 유아복 패션브랜드의 MD(Merchandiser)야. 데이터 뿐 아니라 날씨, 경제, 상품 트렌드 등 다양한 외부적 요소를 고려해 전문가다운 인사이트가 있는 조언을 해줘. 항상 답변 마지막에는 추가로 더 파보면 좋을만한 점들을 몇 가지 제안해 줘. 그리고 모든 답변은 전문가다우면서도 명료한 의견을 전달해야하므로 격식있게 작성해줘"\n      },\n      {\n        "role": "user",\n        "content": "{{ textArea_prompt.value }} \n\n  아래 데이터는 {{ var_select_category.value }} 내 소분류들의 과거 데이터야. \n  {{ JSON.stringify(rename_columns_for_ai_input.data[var_select_category.value]) }}\n  \n  아래 데이터는 동일 카테고리 내 개별 상품의 데이터야.\n  {{ JSON.stringify(formatDataAsArray(get_season_item_data.data)) }}\n\n  아래 데이터는 지난 3년간 최고, 최저, 평균 기온 데이터야.\n  {{ JSON.stringify(formatDataAsArray(get_weather.data)) }}\n"    \n      }\n    ]\n}\n'
    }
    bodyType="raw"
    confirmationMessage="분석하겠습니까? 약 5분정도 소요됩니다."
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query="?"
    queryTimeout="300000"
    requireConfirmation={true}
    resourceDisplayName="OpenAI ChatCompletions"
    resourceName="c620a231-8e2b-46f8-99fe-2a13293336c1"
    resourceTypeOverride=""
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    type="POST"
  >
    <Event
      event="success"
      method="setValue"
      params={{ ordered: [{ value: "{{ get_analysis.data }}" }] }}
      pluginId="text_ai_result"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="insert_ai_result"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </RESTQuery>
  <SqlQuery
    id="get_season_item_data"
    isMultiplayerEdited={false}
    query={include("./lib/get_season_item_data.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="make_table_data"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <State id="var_category_total" />
  <SqlQueryUnified
    id="get_ai_result"
    notificationDuration={4.5}
    query={include("./lib/get_ai_result.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    updateSetValueDynamically={true}
    warningCodes={[]}
  />
  <SqlQueryUnified
    id="insert_ai_result"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/insert_ai_result.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    updateSetValueDynamically={true}
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_ai_result"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <State
    id="var_default_prompt"
    value="### 목표
주어진 데이터를 기반으로 다음 시즌의 카테고리별 SKU(복종수)와 각 분류의 물량을 추천받고 싶어.
추천은 아래의 항목들을 고려해서 판단해야 하며, 추천 결과에 어떤 영향을 미치는지 알려줘야 해.
* 고려항목 : 판매 트랜드, 최근 유아복 유행, 최근 경기상황, 최근의 날씨 변화, 상품의 소재 및 가격, 마진

### 결과물 
카테고리 별로 추천량을 명확하게 제시하고, 그 근거도 함께 제시해줘.
카테고리 별로 세부 상품도 살펴보고 판매가 잘 된 상품과 부진한 상품을 함께 나열해줘. ( 판매율 기준으로 찾고, 최종 판매율 기록 ) 
카테고리 별로 소재별로 어떤 소재가 인기가 좋았고 어떤 소재가 좋지 않았는지 알려줘.
카테고리 별로 적절한 가격대도 함께 정해줘. ( 잘 팔린 상품을 참고해서 가격대 설정 ) 

### 주의사항 
제공되는 판매 데이터는 판매시작후 100일간의 데이터야. 
입고 대비 판매 수량 및 판매금액을 보고 판매율을 계산해서 성과를 판단해야 해.
이미 있는 데이터를 나열하지 말고 데이터를 분석해서 인사이트 위주로 정리해줘.

### 제공 데이터"
  />
  <SqlQueryUnified
    id="get_weather"
    isMultiplayerEdited={false}
    query={include("./lib/get_weather.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    warningCodes={[]}
  />
  <JavascriptQuery
    id="rename_columns_for_ai_input"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/rename_columns_for_ai_input.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    runWhenPageLoadsDelay="2000"
    showSuccessToaster={false}
  />
  <SqlQuery
    id="season_list_new"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/season_list_new.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenPageLoadsDelay="100"
    showFailureToaster={false}
    transformer="//  return formatDataAsArray(data)
function transform(data){
 const result = {};

 const transform_data = formatDataAsArray(data)
  console.log(transform_data)
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
  />
</GlobalFunctions>
