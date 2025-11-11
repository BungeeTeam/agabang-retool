<GlobalFunctions>
  <State id="var_size_list" value="[]" />
  <State id="var_main_item_info" />
  <SqlQueryUnified
    id="get_assort"
    enableTransformer={true}
    query={include("./lib/get_assort.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    transformer="const assort_data = formatDataAsArray(data)

let result = {}
assort_data.forEach(item => {
  result[item.sty_col_cd] = item
});

return result"
    warningCodes={[]}
  />
  <State
    id="var_selected_size_info"
    value={
      '{{\n  (() => {\n    const found = get_size_info.data.find(item => item.size_tp == select_size_type.value);\n    if (found) {\n      return {\n        size_tp: found.size_tp,\n        size_tp_nm: found.size_tp_nm,\n        size_cd_list: found.size_cd_list,\n        size_nm_list: found.size_nm_list\n      };\n    }\n    return {"size_tp": select_size_type.value, "size_tp_nm": "", "size_cd_list": [], "size_nm_list": []};\n  })()\n}}'
    }
  />
  <SqlQuery
    id="get_season_list"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_season_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="get_md_categories_by_brand"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_md_categories_by_brand.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <JavascriptQuery
    id="parse_cascader_path"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/parse_cascader_path.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
  <SqlQuery
    id="get_main_item_list"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_main_item_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenPageLoads={true}
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="get_size_info"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_size_info.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer={
      '// 브랜드별 사이즈 타입 이름 사전\nconst size_tp_name_dict_01_79 = {\n  "00": "대표사이즈",\n  "10": "의류A",\n  "11": "사이즈타입_11",  // TODO: 정식 명칭 필요\n  "20": "사이즈타입_20",  // TODO: 정식 명칭 필요\n  "22": "의류E",\n  "24": "사이즈타입_24",  // TODO: 정식 명칭 필요\n  "25": "의류H",\n  "30": "신발A",\n  "40": "신발B",\n  "50": "양말사이즈",\n  "60": "모자사이즈",\n  "70": "젖꼭지등",\n  "80": "기저귀카바",\n  "81": "이불세트",\n  "82": "겉싸보",\n  "83": "처네",\n  "84": "싸보류",\n  "85": "방수요",\n  "86": "기타침구류",\n  "88": "면기저귀",\n  "89": "위생섬유기타",\n  "90": "업는띠",\n  "99": "FREE"\n};\n\nconst size_tp_name_dict_07 = {\n  "00": "대표사이즈",\n  "10": "의류A",\n  "11": "의류B",\n  "13": "의류J",\n  "14": "의류L",\n  "22": "의류E",\n  "23": "의류F",\n  "25": "의류H",\n  "27": "의류J",\n  "28": "의류K",\n  "29": "의류L",\n  "30": "신발A",\n  "40": "신발B",\n  "50": "양말",\n  "60": "모자",\n  "70": "젖꼭지등",\n  "80": "기저귀카바",\n  "81": "이불세트",\n  "82": "겉싸보",\n  "83": "처네",\n  "84": "싸보류",\n  "85": "방수요",\n  "86": "기타침구류",\n  "88": "면기저귀",\n  "89": "위생섬유기타",\n  "90": "업는띠",\n  "99": "FREE"\n};\n\n// 브랜드별 커스텀 사이즈 사전\nconst custom_size_dict_07 = {\n  "양말": ["0-6", "7-8", "9-10", "11-12", "13-14", "15-16", "17-18", "19-20", "21-22"]\n};\n\n// 현재 브랜드 코드 가져오기\nconst current_brand = {{var_brand_code.value}};\n\n// 브랜드에 따른 사전 선택\nlet size_tp_name_dict;\nlet custom_size_dict = {};\n\nif (current_brand === \'07\') {\n  size_tp_name_dict = size_tp_name_dict_07;\n  custom_size_dict = custom_size_dict_07;\n} else if (current_brand === \'01\' || current_brand === \'79\') {\n  size_tp_name_dict = size_tp_name_dict_01_79;\n  // 01, 79는 커스텀 사이즈 변환 없음\n} else {\n  // 기타 브랜드는 기본값\n  size_tp_name_dict = {};\n}\n\n// 데이터 변환\nconst transform_data = formatDataAsArray(data);\n\n// 데이터 그룹화\nconst groupedData = transform_data.reduce((acc, item) => {\n  const { size_tp, size_cd, size_nm } = item;\n  let size_tp_nm = size_tp_name_dict[size_tp] || `사이즈타입_${size_tp}`;\n  \n  // size_tp가 이미 존재하는지 확인\n  let group = acc.find(g => g.size_tp === size_tp);\n  if (!group) {\n    // 새로운 그룹 추가\n    group = { size_tp, size_tp_nm, size_cd_list: [], size_nm_list: [] };\n    acc.push(group);\n  }\n  \n  // size_cd 추가\n  group.size_cd_list.push(size_cd);\n  group.size_nm_list.push(size_nm);\n  \n  return acc;\n}, []);\n\n// 강제 사이즈 변환\ngroupedData.forEach(group => {\n  if (custom_size_dict[group.size_tp_nm]) {\n    group.size_nm_list = custom_size_dict[group.size_tp_nm]; \n  }\n});\n\n// 결과 반환\nreturn groupedData;'
    }
    warningCodes={[]}
  />
</GlobalFunctions>
