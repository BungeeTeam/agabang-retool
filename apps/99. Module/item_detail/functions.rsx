<GlobalFunctions>
  <Folder id="resource_query">
    <SqlQuery
      id="get_item_size_detail"
      query={include("./lib/get_item_size_detail.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      warningCodes={[]}
    />
    <SqlQuery
      id="get_item_detail"
      isMultiplayerEdited={false}
      query={include("./lib/get_item_detail.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_image_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQuery>
    <SqlQuery
      id="get_shop_sales"
      isMultiplayerEdited={false}
      query={include("./lib/get_shop_sales.sql", "string")}
      queryFailureConditions={'[{"condition":"","message":""}]'}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      runWhenModelUpdates={false}
      runWhenPageLoadsDelay="1000"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_shop_in_graph_data"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
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
        pluginId="filter_out_handover_shops"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQuery>
    <SqlQuery
      id="get_daily_sales_by_style"
      isMultiplayerEdited={false}
      query={include("./lib/get_daily_sales_by_style.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_image_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQuery>
    <SqlQuery
      id="get_online_sales"
      enableTransformer={true}
      isMultiplayerEdited={false}
      query={include("./lib/get_online_sales.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      transformer="// const expectedSaleGb = ['오프라인(매장)', '온라인 - 자사몰', '온라인 - 외부몰'];
// const resultMap = {};

// // 먼저 응답 데이터를 매핑합니다.
// data.forEach(item => {
//   resultMap[item.sale_gb] = item;
// });

// // 결과 배열을 만듭니다. 누락된 sale_gb도 포함되게.
// const result = expectedSaleGb.map(sale_gb => {
//   if (resultMap[sale_gb]) {
//     return resultMap[sale_gb];
//   } else {
//     // sale_trend가 없을 경우 0값을 넣은 기본 구조 생성
//     return {
//       sale_gb: sale_gb,
//       sale_trend: JSON.stringify([{ day: 'N/A', val: 0, sale_gb }])
//     };
//   }
// });

// return result;

return formatDataAsArray(data)"
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="get_shop_handover"
      isMultiplayerEdited={false}
      query={include("./lib/get_shop_handover.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      showFailureToaster={false}
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="filter_out_handover_shops"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <JavascriptQuery
      id="filter_out_handover_shops"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/filter_out_handover_shops.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
  </Folder>
  <Folder id="variable">
    <State
      id="var_category_list"
      value={
        '{\n  "season":[ \n    { "cat_nm": "전체", "id": 89 }, \n    { "cat_nm": "시즌의류", "id": 57 },\n    { "cat_nm": "시즌언더", "id": 56 },  \n    { "cat_nm": "파자마", "id": 59 }, \n    { "cat_nm": "시즌용품", "id": 62 },\n    { "cat_nm": "복종X", "id": 91 }\n  ]\n}'
      }
    />
    <State
      id="var_color_hex_list"
      value={
        '[\n     {\n        "col_nm": "MAIN",\n        "col_hex": "#01488F"  // 자사 메인 컬러\n    },\n    {\n        "col_nm": "SUB",\n        "col_hex": "#00A0E6"  // 자사 서브컬러\n    },\n    {\n        "col_nm": "MULTI",\n        "col_hex": "#808080"  // 부드러운 다채로운 느낌\n    },\n    {\n        "col_nm": "CREAM",\n        "col_hex": "#FFF7D1"  // 연한 크림색\n    },\n    {\n        "col_nm": "IVORY",\n        "col_hex": "#FFFAF0"  // 부드러운 아이보리\n    },\n    {\n        "col_nm": "O/WHITE",\n        "col_hex": "#F8F8F8"  // 밝은 오프 화이트\n    },\n    {\n        "col_nm": "WHITE",\n        "col_hex": "#FFFFFF"  // 기본 화이트\n    },\n    {\n        "col_nm": "SILVER",\n        "col_hex": "#ECECEC"  // 부드러운 실버\n    },\n    {\n        "col_nm": "GOLD",\n        "col_hex": "#FFEBCD"  // 연한 금색 (아이보리 톤)\n    },\n    {\n        "col_nm": "FLOWER",\n        "col_hex": "#FADADD"  // 연한 꽃 색상\n    },\n    {\n        "col_nm": "MISTY WHITE",\n        "col_hex": "#F5F5F5"  // 흐릿한 화이트\n    },\n    {\n        "col_nm": "OATMEAL",\n        "col_hex": "#E6DACD"  // 부드러운 오트밀\n    },\n    {\n        "col_nm": "CHARCOAL",\n        "col_hex": "#B3B3B3"  // 연한 차콜 그레이\n    },\n    {\n        "col_nm": "BLACK",\n        "col_hex": "#D3D3D3"  // 부드럽고 연한 블랙(그레이톤)\n    },\n    {\n        "col_nm": "D/GREY",\n        "col_hex": "#DADADA"  // 연한 다크 그레이\n    },\n    {\n        "col_nm": "NAVY",\n        "col_hex": "#C7D2FE"  // 연한 네이비 (라벤더 블루)\n    },\n    {\n        "col_nm": "GREY",\n        "col_hex": "#E0E0E0"  // 밝은 회색\n    },\n    {\n        "col_nm": "L/GREY",\n        "col_hex": "#F0F0F0"  // 매우 밝은 회색\n    },\n    {\n        "col_nm": "MELAN GREY",\n        "col_hex": "#D6D6D6"  // 연한 멜란지 그레이\n    },\n    {\n        "col_nm": "NAVY JEAN",\n        "col_hex": "#BFCFE5"  // 부드러운 네이비 진\n    },\n    {\n        "col_nm": "Z/BLACK",\n        "col_hex": "#B0B0B0"  // 연한 제로 블랙 (그레이 계열)\n    },\n    {\n        "col_nm": "B/NAVY",\n        "col_hex": "#A9BED9"  // 부드러운 블루 네이비\n    },\n    {\n        "col_nm": "BLACK MELAN",\n        "col_hex": "#C4C4C4"  // 연한 블랙 멜란지\n    },\n    {\n        "col_nm": "BEIGE",\n        "col_hex": "#F5E8DC"  // 밝은 베이지\n    },\n    {\n        "col_nm": "CAMEL",\n        "col_hex": "#E3C4A8"  // 부드러운 카멜\n    },\n    {\n        "col_nm": "CREAM BEIGE",\n        "col_hex": "#F7ECD4"  // 연한 크림 베이지\n    },\n    {\n        "col_nm": "D/BEIGE",\n        "col_hex": "#E5D3BC"  // 연한 다크 베이지\n    },\n    {\n        "col_nm": "L/BEIGE",\n        "col_hex": "#FAF3E3"  // 매우 밝은 베이지\n    },\n    {\n        "col_nm": "SKIN NUDE",\n        "col_hex": "#FCE6D1"  // 연한 누드 스킨톤\n    },\n    {\n        "col_nm": "M/BEIGE",\n        "col_hex": "#EDD2B1"  // 중간 톤의 베이지\n    },\n    {\n        "col_nm": "MUSTARD",\n        "col_hex": "#F8E4B0"  // 부드러운 머스터드\n    },\n    {\n        "col_nm": "BROWN",\n        "col_hex": "#D2B48C"  // 밝은 브라운\n    },\n    {\n        "col_nm": "COCOA",\n        "col_hex": "#D1A681"  // 연한 코코아\n    },\n    {\n        "col_nm": "D/BROWN",\n        "col_hex": "#C4A484"  // 연한 다크 브라운\n    },\n    {\n        "col_nm": "D/COCOA",\n        "col_hex": "#B8956B"  // 부드러운 다크 코코아\n    },\n    {\n        "col_nm": "BRONZE",\n        "col_hex": "#E5B89F"  // 부드러운 청동색\n    },\n    {\n        "col_nm": "LIGHT BRONZE",\n        "col_hex": "#F2CEB6"  // 연한 브론즈\n    },\n    {\n        "col_nm": "BRICK",\n        "col_hex": "#F5B19C"  // 부드러운 벽돌색\n    },\n    {\n        "col_nm": "OLIVE",\n        "col_hex": "#D9E1C5"  // 연한 올리브\n    },\n    {\n        "col_nm": "PEACH",\n        "col_hex": "#FCD6BB"  // 부드러운 복숭아색\n    },\n    {\n        "col_nm": "AQUA",\n        "col_hex": "#D3F8F2"  // 연한 아쿠아\n    },\n    {\n        "col_nm": "BLUE",\n        "col_hex": "#BFDBFE"  // 부드러운 블루\n    },\n    {\n        "col_nm": "C/BLUE",\n        "col_hex": "#C1E7FF"  // 밝은 코발트 블루\n    },\n    {\n        "col_nm": "D/BLUE",\n        "col_hex": "#A7C6F2"  // 연한 다크 블루\n    },\n    {\n        "col_nm": "I/BLUE",\n        "col_hex": "#B0E0E6"  // 부드러운 아이스 블루\n    },\n    {\n        "col_nm": "L/BLUE",\n        "col_hex": "#E0F7FA"  // 매우 밝은 블루\n    },\n    {\n        "col_nm": "M/BLUE",\n        "col_hex": "#BFDFFF"  // 중간 톤의 블루\n    },\n    {\n        "col_nm": "S/BLUE",\n        "col_hex": "#CCE8FF"  // 밝은 스카이 블루\n    },\n    {\n        "col_nm": "T/BLUE",\n        "col_hex": "#D0EFFF"  // 연한 청록색 블루\n    },\n    {\n        "col_nm": "B/BLUE",\n        "col_hex": "#A7F3D0"  // 부드러운 블루 그린\n    },\n    {\n        "col_nm": "CHERRY PINK",\n        "col_hex": "#FAD4E7"  // 연한 체리 핑크\n    },\n    {\n        "col_nm": "C/PINK",\n        "col_hex": "#F8E6FA"  // 밝은 코랄 핑크\n    },\n    {\n        "col_nm": "D/PINK",\n        "col_hex": "#FFD1DC"  // 부드러운 다크 핑크\n    },\n    {\n        "col_nm": "I/PINK",\n        "col_hex": "#FFE4E1"  // 아이보리 핑크\n    },\n    {\n        "col_nm": "L/PINK",\n        "col_hex": "#FFEBEE"  // 매우 밝은 핑크\n    },\n    {\n        "col_nm": "L/CORAL",\n        "col_hex": "#FFD5D0"  // 연한 코랄\n    },\n    {\n        "col_nm": "MAGENTA",\n        "col_hex": "#FFCCF9"  // 부드러운 마젠타\n    },\n    {\n        "col_nm": "PINK",\n        "col_hex": "#FECACA"  // 연한 핑크\n    },\n    {\n        "col_nm": "ROSE PINK",\n        "col_hex": "#FFD7E7"  // 연한 로즈 핑크\n    },\n    {\n        "col_nm": "B/PINK",\n        "col_hex": "#FFC1E3"  // 부드러운 블러시 핑크\n    },\n    {\n        "col_nm": "L/PURPLE",\n        "col_hex": "#EEDAFD"  // 연한 라벤더 퍼플\n    },\n    {\n        "col_nm": "L/VIOLET",\n        "col_hex": "#E6E6FA"  // 밝은 바이올렛\n    },\n    {\n        "col_nm": "PURPLE",\n        "col_hex": "#E0BBE4"  // 연한 퍼플\n    },\n    {\n        "col_nm": "VIOLET",\n        "col_hex": "#DCCFFF"  // 연한 바이올렛\n    },\n    {\n        "col_nm": "A/GREEN",\n        "col_hex": "#D1F2C9"  // 부드러운 아쿠아 그린\n    },\n    {\n        "col_nm": "D/KHAKI",\n        "col_hex": "#D6E0B8"  // 연한 다크 카키\n    },\n    {\n        "col_nm": "D/GREEN",\n        "col_hex": "#C8E6C9"  // 부드러운 다크 그린\n    },\n    {\n        "col_nm": "GREEN",\n        "col_hex": "#D4EDDA"  // 연한 그린\n    },\n    {\n        "col_nm": "KHAKI",\n        "col_hex": "#E4D4A2"  // 부드러운 카키\n    },\n    {\n        "col_nm": "L/KHAKI",\n        "col_hex": "#F5F5DC"  // 매우 밝은 카키\n    },\n    {\n        "col_nm": "L/GREEN",\n        "col_hex": "#DFFFE7"  // 연한 그린\n    },\n    {\n        "col_nm": "MINT",\n        "col_hex": "#D1FAD9"  // 밝은 민트\n    },\n    {\n        "col_nm": "O/GREEN",\n        "col_hex": "#D9EAD3"  // 연한 올리브 그린\n    },\n    {\n        "col_nm": "L/MINT",\n        "col_hex": "#E0FFF4"  // 매우 밝은 민트\n    },\n    {\n        "col_nm": "D/ORANGE",\n        "col_hex": "#FFDAC1"  // 부드러운 다크 오렌지\n    },\n    {\n        "col_nm": "LEMON YELLOW",\n        "col_hex": "#FFF9C4"  // 연한 레몬 옐로우\n    },\n    {\n        "col_nm": "L/ORANGE",\n        "col_hex": "#FFEDD5"  // 밝은 오렌지\n    },\n    {\n        "col_nm": "L/YELLOW",\n        "col_hex": "#FFFCDB"  // 매우 밝은 옐로우\n    },\n    {\n        "col_nm": "M/YELLOW",\n        "col_hex": "#FFF4E6"  // 연한 머스타드 옐로우\n    },\n    {\n        "col_nm": "ORANGE",\n        "col_hex": "#FFD9B2"  // 부드러운 오렌지\n    },\n    {\n        "col_nm": "YELLOW",\n        "col_hex": "#FFFBCC"  // 밝은 옐로우\n    },\n    {\n        "col_nm": "B/YELLOW",\n        "col_hex": "#FFF5B8"  // 연한 베이비 옐로우\n    },\n    {\n        "col_nm": "D/YELLOW",\n        "col_hex": "#FFF2C2"  // 부드러운 다크 옐로우\n    },\n    {\n        "col_nm": "F/YELLOW",\n        "col_hex": "#FFFDE7"  // 매우 연한 옐로우\n    },\n    {\n        "col_nm": "D/RED",\n        "col_hex": "#FFCECE"  // 부드러운 다크 레드\n    },\n    {\n        "col_nm": "L/RED",\n        "col_hex": "#FFD5D5"  // 밝은 레드\n    },\n    {\n        "col_nm": "RED",\n        "col_hex": "#FFCCCC"  // 연한 레드\n    },\n    {\n        "col_nm": "WINE",\n        "col_hex": "#F5C7C7"  // 연한 와인 레드\n    },\n    {\n        "col_nm": "P/RED",\n        "col_hex": "#FFB2B2"  // 부드러운 핑크 레드\n    },\n    {\n        "col_nm": "BURGUNDY",\n        "col_hex": "#EFB9B9"  // 밝은 버건디\n    },\n    {\n        "col_nm": "POWDERPINK",\n        "col_hex": "#FFE4E1"  // 파우더 핑크\n    },\n    {\n        "col_nm": "LIME",\n        "col_hex": "#E6F2C6"  // 부드러운 라임색\n    },\n    {\n        "col_nm": "CHARCOAL_",\n        "col_hex": "#DADADA"  // 연한 차콜 그레이\n    }\n]'
      }
    />
    <State id="var_item_info" />
    <State
      id="var_color_dict"
      value={
        '{\n    "MULTI": "#808080",\n    "CREAM": "#FFF7D1",\n    "IVORY": "#FFFAF0",\n    "O/WHITE": "#F8F8F8",\n    "WHITE": "#FFFFFF",\n    "SILVER": "#ECECEC",\n    "GOLD": "#FFEBCD",\n    "FLOWER": "#FADADD",\n    "MISTY WHITE": "#F5F5F5",\n    "OATMEAL": "#E6DACD",\n    "CHARCOAL": "#B3B3B3",\n    "BLACK": "#D3D3D3",\n    "D/GREY": "#DADADA",\n    "NAVY": "#C7D2FE",\n    "GREY": "#E0E0E0",\n    "L/GREY": "#F0F0F0",\n    "MELAN GREY": "#D6D6D6",\n    "NAVY JEAN": "#BFCFE5",\n    "Z/BLACK": "#B0B0B0",\n    "B/NAVY": "#A9BED9",\n    "BLACK MELAN": "#C4C4C4",\n    "BEIGE": "#F5E8DC",\n    "CAMEL": "#E3C4A8",\n    "CREAM BEIGE": "#F7ECD4",\n    "D/BEIGE": "#E5D3BC",\n    "L/BEIGE": "#FAF3E3",\n    "SKIN NUDE": "#FCE6D1",\n    "M/BEIGE": "#EDD2B1",\n    "MUSTARD": "#F8E4B0",\n    "BROWN": "#D2B48C",\n    "COCOA": "#D1A681",\n    "D/BROWN": "#C4A484",\n    "D/COCOA": "#B8956B",\n    "BRONZE": "#E5B89F",\n    "LIGHT BRONZE": "#F2CEB6",\n    "BRICK": "#F5B19C",\n    "OLIVE": "#D9E1C5",\n    "PEACH": "#FCD6BB",\n    "AQUA": "#D3F8F2",\n    "BLUE": "#BFDBFE",\n    "C/BLUE": "#C1E7FF",\n    "D/BLUE": "#A7C6F2",\n    "I/BLUE": "#B0E0E6",\n    "L/BLUE": "#E0F7FA",\n    "M/BLUE": "#BFDFFF",\n    "S/BLUE": "#CCE8FF",\n    "T/BLUE": "#D0EFFF",\n    "B/BLUE": "#A7F3D0",\n    "CHERRY PINK": "#FAD4E7",\n    "C/PINK": "#F8E6FA",\n    "D/PINK": "#FFD1DC",\n    "I/PINK": "#FFE4E1",\n    "L/PINK": "#FFEBEE",\n    "L/CORAL": "#FFD5D0",\n    "MAGENTA": "#FFCCF9",\n    "PINK": "#FECACA",\n    "ROSE PINK": "#FFD7E7",\n    "B/PINK": "#FFC1E3",\n    "L/PURPLE": "#EEDAFD",\n    "L/VIOLET": "#E6E6FA",\n    "PURPLE": "#E0BBE4",\n    "VIOLET": "#DCCFFF",\n    "A/GREEN": "#D1F2C9",\n    "D/KHAKI": "#D6E0B8",\n    "D/GREEN": "#C8E6C9",\n    "GREEN": "#D4EDDA",\n    "KHAKI": "#E4D4A2",\n    "L/KHAKI": "#F5F5DC",\n    "L/GREEN": "#DFFFE7",\n    "MINT": "#D1FAD9",\n    "O/GREEN": "#D9EAD3",\n    "L/MINT": "#E0FFF4",\n    "D/ORANGE": "#FFDAC1",\n    "LEMON YELLOW": "#FFF9C4",\n    "L/ORANGE": "#FFEDD5",\n    "L/YELLOW": "#FFFCDB",\n    "M/YELLOW": "#FFF4E6",\n    "ORANGE": "#FFD9B2",\n    "YELLOW": "#FFFBCC",\n    "B/YELLOW": "#FFF5B8",\n    "D/YELLOW": "#FFF2C2",\n    "F/YELLOW": "#FFFDE7",\n    "D/RED": "#FFCECE",\n    "L/RED": "#FFD5D5",\n    "RED": "#FFCCCC",\n    "WINE": "#F5C7C7",\n    "P/RED": "#FFB2B2",\n    "BURGUNDY": "#EFB9B9",\n    "POWDERPINK": "#FFE4E1",\n    "LIME": "#E6F2C6",\n    "CHARCOAL_": "#DADADA"\n}'
      }
    />
    <Function
      id="var_item_list"
      funcBody={include("./lib/var_item_list.js", "string")}
    />
    <State id="sel_s3_key" />
  </Folder>
  <Folder id="query">
    <JavascriptQuery
      id="get_image_list"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/get_image_list.js", "string")}
      resourceName="JavascriptQuery"
      runWhenPageLoadsDelay="15000"
      showSuccessToaster={false}
    />
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
    <JavascriptQuery
      id="get_brand_and_season"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/get_brand_and_season.js", "string")}
      resourceName="JavascriptQuery"
      runWhenPageLoads={true}
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="query21"
      notificationDuration={4.5}
      query={include("./lib/query21.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
  </Folder>
  <Folder id="image_update">
    <SqlQueryUnified
      id="get_folder_list"
      query={include("./lib/get_folder_list.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      warningCodes={[]}
    />
    <JavascriptQuery
      id="s3_single_upload"
      notificationDuration={4.5}
      query={include("./lib/s3_single_upload.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <SqlQueryUnified
      id="update_item_image_each"
      query={include("./lib/update_item_image_each.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="get_image_list_from_item_image_review"
      notificationDuration={4.5}
      query={include(
        "./lib/get_image_list_from_item_image_review.sql",
        "string"
      )}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="update_item_image"
      isMultiplayerEdited={false}
      query={include("./lib/update_item_image.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      warningCodes={[]}
    />
    <S3Query
      id="delete_image"
      actionType="delete"
      bucketName="agabang-image"
      fileKey="{{sel_s3_key.value}}"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      resourceDisplayName="s3-agabang"
      resourceName="90497f58-753e-4796-a084-fefd4ba65928"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
    />
    <S3Query
      id="s3_upload"
      actionType="upload"
      bucketName="agabang-image"
      isMultiplayerEdited={false}
      resourceDisplayName="s3-agabang"
      resourceName="90497f58-753e-4796-a084-fefd4ba65928"
      runWhenModelUpdates={false}
      successMessage="사진 업로드 완료! 약 30분 후 업데이트됩니다."
      uploadData="{{upload_file_dropzone.value[i].base64Data }}"
      uploadFileName="item_upload/{{ sel_sty.value.sty_cd.substring(0, 2) }}/{{ sel_sty.value.sty_cd.charAt(2) }}/{{ sel_sty.value.sty_cd.charAt(3) }}/{{ sel_sty.value.sty_cd + sel_sty.value.col_cd }}.{{ upload_file_dropzone.value[0].type.split('/')[1] }}"
      uploadFileType="{{upload_file_dropzone.value[i].type}}"
      useRawUploadFileType={true}
    />
    <RESTQuery
      id="trigger_airflow_manual_dag"
      bodyType="json"
      query="z__manual_update_review_image_v2/dagRuns"
      resourceDisplayName="AirflowDAGRun - Manual run"
      resourceName="8ef755f8-13c4-4d85-a5ea-5bab23c18e13"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      type="POST"
    />
  </Folder>
</GlobalFunctions>
