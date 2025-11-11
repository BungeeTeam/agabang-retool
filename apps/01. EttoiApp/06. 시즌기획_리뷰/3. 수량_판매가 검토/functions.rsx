<GlobalFunctions>
  <State
    id="_var_item_assort_table"
    value={
      '[\n  {\n    "col_1": "3M",\n    "col_2": "6M",\n    "col_3": "12M",\n    "col_4": "2Y",\n    "col_5": "3Y",\n    "col_6": "4Y",\n  },\n  {\n    "col_1": "120",\n    "col_2": "",\n    "col_3": "",\n    "col_4": "",\n    "col_5": "",\n    "col_6": "",\n  }\n]'
    }
  />
  <SqlQuery
    id="season_list"
    notificationDuration={4.5}
    query={include("./lib/season_list.sql", "string")}
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
      pluginId="set_season_list"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <SqlQuery
    id="get_item_list"
    isMultiplayerEdited={false}
    query={include("./lib/get_item_list.sql", "string")}
    queryFailureConditions={'[{"condition":"","message":""}]'}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenPageLoadsDelay="1000"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_competitor_item_list"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="set_price_list"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <State id="var_price_list" />
  <JavascriptQuery
    id="set_price_list"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/set_price_list.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
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
    id="get_competitor_item_list"
    isMultiplayerEdited={false}
    query={include("./lib/get_competitor_item_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="set_price_list"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <State
    id="var_size_list"
    value={
      '[\n  { "size_type": "의류A", "size_list": ["60", "65", "70", "75", "80", "85", "90", "95", "100", "110"] },\n  { "size_type": "의류B", "size_list": ["75", "80", "85", "90", "95", "100", "110", "120", "130", "140"] },\n  { "size_type": "신발A", "size_list": ["100", "110", "115", "120", "125", "130", "135", "140", "145", "150"] },\n  { "size_type": "양말", "size_list": ["7-8", "9-10", "11-12", "13-14", "15-16", "17-18", "19-20", "21-22"] },\n  { "size_type": "모자", "size_list": ["40", "42", "44", "46", "48", "50", "52", "54", "56"] },\n  { "size_type": "의류J", "size_list": ["NB", "3M", "6M", "9M", "12M", "18M", "24M", "2T", "3T", "4T"] },\n  { "size_type": "의류L", "size_list": ["3M", "6M", "12M", "18M", "2Y", "3Y", "4Y", "5Y"] },\n  { "size_type": "신발B", "size_list": ["130", "135", "140", "145", "150", "155", "160", "170", "180", "190"] }\n]'
    }
  />
  <State id="var_selected_item" />
  <SqlQueryUnified
    id="update_price_memo"
    notificationDuration={4.5}
    query={include("./lib/update_price_memo.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showUpdateSetValueDynamicallyToggle={false}
    successMessage="저장되었습니다"
    updateSetValueDynamically={true}
    warningCodes={[]}
  />
  <State id="var_price_memo" />
  <SqlQuery
    id="get_size_info"
    enableTransformer={true}
    query={include("./lib/get_size_info.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer={
      'const size_tp_name_dict = {\n  "00": "대표사이즈",\n  "10": "의류A",\n  "11": "의류B",\n  "13": "의류J",\n  "14": "의류L",\n  "22": "의류E",\n  "23": "의류F",\n  "25": "의류H",\n  "27": "의류J",\n  "28": "의류K",\n  "29": "의류L",\n  "30": "신발A",\n  "40": "신발B",\n  "50": "양말",\n  "60": "모자",\n  "70": "젖꼭지등",\n  "80": "기저귀카바",\n  "81": "이불세트",\n  "82": "겉싸보",\n  "83": "처네",\n  "84": "싸보류",\n  "85": "방수요",\n  "86": "기타침구류",\n  "88": "면기저귀",\n  "89": "위생섬유기타",\n  "90": "업는띠",\n  "99": "FREE"\n};\n\nconst custom_size_dict = {\n  "양말" : ["0-6", "7-8", "9-10", "11-12", "13-14", "15-16", "17-18", "19-20", "21-22"]\n}\n\n\nconst transform_data = formatDataAsArray(data);\n\n// 데이터 그룹화\nconst groupedData = transform_data.reduce((acc, item) => {\n  const { size_tp, size_cd, size_nm } = item;\n\n  let size_tp_nm = size_tp_name_dict[size_tp];\n\n  // size_tp가 이미 존재하는지 확인\n  let group = acc.find(g => g.size_tp === size_tp);\n\n  if (!group) {\n    // 새로운 그룹 추가\n    group = { size_tp, size_tp_nm, size_cd_list: [], size_nm_list: [] };\n    acc.push(group);\n  }\n\n  // size_cd 추가\n  group.size_cd_list.push(size_cd);\n  group.size_nm_list.push(size_nm);\n\n  return acc;\n}, []);\n\n// 강제 사이즈 변환\ngroupedData.forEach(group => {\n  if (custom_size_dict[group.size_tp_nm]) {\n    group.size_nm_list = custom_size_dict[group.size_tp_nm]; \n  }\n});\n\n// 결과 반환\nreturn groupedData;'
    }
    warningCodes={[]}
  />
  <State
    id="var_selected_size_info"
    value={
      '{{ get_size_info.data.find(item => item.size_tp == select_size_type.value) || {"size_tp": select_size_type.value, "size_tp_nm": "", "size_cd_list": [], size_nm_list : [] } }}'
    }
  />
  <SqlQuery
    id="get_category_list_new"
    enableTransformer={true}
    notificationDuration={4.5}
    query={include("./lib/get_category_list_new.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
</GlobalFunctions>
