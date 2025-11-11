<GlobalFunctions>
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
    showLatestVersionUpdatedWarning={true}
    showSuccessToaster={false}
    transformer="const Data = formatDataAsArray(data)

const seasonArr = Data.map(item => item.year_season_cd);

return seasonArr"
    warningCodes={[]}
  />
  <SqlQuery
    id="season_list"
    isImported={true}
    isMultiplayerEdited={false}
    playgroundQueryName="season_list_without_0code"
    playgroundQueryUuid="2107b35d-c8c3-443b-953b-751d38a2dd84"
    query={include("./lib/season_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    retoolVersion="3.148.10"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQuery
    id="query_get_data"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/query_get_data.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showFailureToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQuery
    id="recent_no_season_list"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    query={include("./lib/recent_no_season_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <Function
    id="var_best_worst"
    funcBody={include("./lib/var_best_worst.js", "string")}
  />
  <Function
    id="var_current_season_code"
    funcBody={include("./lib/var_current_season_code.js", "string")}
  />
  <Function
    id="var_target_season_code"
    funcBody={include("./lib/var_target_season_code.js", "string")}
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
  <State
    id="var_category_list"
    value={
      '[\n  { cat_nm: "시즌의류(베이비)", id: 21 },\n  { cat_nm: "시즌의류(토들러)", id: 22 },\n  { cat_nm: "기획의류", id: 24 },\n  { cat_nm: "시즌언더", id: 20 },\n  { cat_nm: "기획언더", id: 25 },\n  { cat_nm: "시즌용품", id: 27 },\n]'
    }
  />
  <Function
    id="var_best_worst_new"
    funcBody={include("./lib/var_best_worst_new.js", "string")}
  />
  <State id="var_item_info" />
  <State id="var_brand_code" value="01" />
</GlobalFunctions>
