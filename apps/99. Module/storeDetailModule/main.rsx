<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <GlobalWidgetProp
    id="endDate"
    defaultValue={'{{ moment().subtract(1, "days").format("YYYY-MM-DD") }}'}
    value="'2025-07-02'"
  />
  <GlobalWidgetProp
    id="inputData"
    value={
      '{\n  "time_unit": [\n    2023,\n    2023,\n    2025,\n    2024,\n    2025,\n    2025,\n    2024,\n    2025,\n    2025,\n    2025,\n    2024,\n    2025,\n    2025,\n    2024,\n    2024,\n    2025,\n    2025,\n    2024,\n    2025,\n    2023,\n    2023,\n    2023\n  ],\n  "ym": [\n    "2023-08",\n    "2023-08",\n    "2025-08",\n    "2024-08",\n    "2025-08",\n    "2025-08",\n    "2024-08",\n    "2025-08",\n    "2025-08",\n    "2025-08",\n    "2024-08",\n    "2025-08",\n    "2025-08",\n    "2024-08",\n    "2024-08",\n    "2025-08",\n    "2025-08",\n    "2024-08",\n    "2025-08",\n    "2023-08",\n    "2023-08",\n    "2023-08"\n  ],\n  "yr": [\n    2023,\n    2023,\n    2025,\n    2024,\n    2025,\n    2025,\n    2024,\n    2025,\n    2025,\n    2025,\n    2024,\n    2025,\n    2025,\n    2024,\n    2024,\n    2025,\n    2025,\n    2024,\n    2025,\n    2023,\n    2023,\n    2023\n  ],\n  "month": [\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8\n  ],\n  "shop_cd": [\n    "124062",\n    "124062",\n    "126668",\n    "126053",\n    "126668",\n    "126053",\n    "126737",\n    "124062",\n    "126737",\n    "126668",\n    "126053",\n    "124062",\n    "126053",\n    "124062",\n    "124062",\n    "126053",\n    "124062",\n    "126053",\n    "126053",\n    "126053",\n    "126737",\n    "126053"\n  ],\n  "shop_nm": [\n    "원주무실아가방갤러리",\n    "원주무실아가방갤러리",\n    "원주롯데마트 아가방",\n    "원주중앙아가방갤러리",\n    "원주롯데마트 아가방",\n    "원주중앙아가방갤러리",\n    "신)원주베이비하우스",\n    "원주무실아가방갤러리",\n    "신)원주베이비하우스",\n    "원주롯데마트 아가방",\n    "원주중앙아가방갤러리",\n    "원주무실아가방갤러리",\n    "원주중앙아가방갤러리",\n    "원주무실아가방갤러리",\n    "원주무실아가방갤러리",\n    "원주중앙아가방갤러리",\n    "원주무실아가방갤러리",\n    "원주중앙아가방갤러리",\n    "원주중앙아가방갤러리",\n    "원주중앙아가방갤러리",\n    "신)원주베이비하우스",\n    "원주중앙아가방갤러리"\n  ],\n  "biz_cd": [\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1"\n  ],\n  "biz_nm": [\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부"\n  ],\n  "br_cd": [\n    "71",\n    "01",\n    "76",\n    "01",\n    "01",\n    "74",\n    "01",\n    "01",\n    "01",\n    "71",\n    "74",\n    "76",\n    "01",\n    "01",\n    "76",\n    "71",\n    "01",\n    "71",\n    "76",\n    "71",\n    "01",\n    "01"\n  ],\n  "br_nm": [\n    "퓨토시크릿리뉴얼",\n    "아가방",\n    "해외브랜드2",\n    "아가방",\n    "아가방",\n    "엘츠",\n    "아가방",\n    "",\n    "아가방",\n    "퓨토시크릿리뉴얼",\n    "엘츠",\n    "해외브랜드2",\n    "아가방",\n    "아가방",\n    "해외브랜드2",\n    "퓨토시크릿리뉴얼",\n    "아가방",\n    "퓨토시크릿리뉴얼",\n    "해외브랜드2",\n    "퓨토시크릿리뉴얼",\n    "아가방",\n    "아가방"\n  ],\n  "tp_cd": [\n    "31",\n    "31",\n    "34",\n    "31",\n    "34",\n    "31",\n    "31",\n    "31",\n    "31",\n    "34",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31"\n  ],\n  "tp_nm": [\n    "가두점",\n    "가두점",\n    "롯데마트",\n    "가두점",\n    "롯데마트",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "롯데마트",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점"\n  ],\n  "team_cd": [\n    "05",\n    "05",\n    "02",\n    "05",\n    "02",\n    "05",\n    "05",\n    "05",\n    "05",\n    "02",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05"\n  ],\n  "team_nm": [\n    "05팀",\n    "05팀",\n    "02팀",\n    "05팀",\n    "02팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "02팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀"\n  ],\n  "user_cd": [\n    "14",\n    "14",\n    "01",\n    "14",\n    "01",\n    "14",\n    "14",\n    "14",\n    "14",\n    "01",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14"\n  ],\n  "user_nm": [\n    "이승국",\n    "이승국",\n    "남기훈",\n    "이승국",\n    "남기훈",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "남기훈",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국"\n  ],\n  "area_cd": [\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31"\n  ],\n  "area_nm": [\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원"\n  ],\n  "onoff_flag": [\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인"\n  ],\n  "is_flex": [\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false\n  ],\n  "rev": [\n    0.056,\n    2.91287,\n    0.027,\n    3.92576,\n    2.4784,\n    0.129,\n    1.17942,\n    0,\n    1.0211,\n    0.069,\n    0.079,\n    0.0187,\n    4.8926,\n    1.41414,\n    0.0978,\n    0.091,\n    1.0106,\n    0.1072,\n    0.0258,\n    0.2088,\n    0.58968,\n    3.59653\n  ],\n  "target_sales": [\n    0,\n    0,\n    0,\n    0,\n    3.17,\n    0,\n    0,\n    0.67,\n    1.09,\n    0,\n    0,\n    0,\n    2.18,\n    0,\n    0,\n    0,\n    0.33,\n    0,\n    0,\n    0,\n    0,\n    0\n  ]\n}'
    }
  />
  <GlobalWidgetOutput
    id="selectedData"
    description="클릭 데이터"
    value="{{ selectedRow.value }}"
  />
  <GlobalWidgetProp
    id="startDate"
    defaultValue={'{{ moment().startOf("year").format("YYYY-MM-DD") }}'}
    value="'2025-01-01'"
  />
  <Include src="./src/inventoryDrawerFrame.rsx" />
  <Include src="./src/shopDetailModalFrame.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <ModuleContainerWidget
      id="moduleContainer"
      backgroundColor="white"
      endDate="'2025-07-02'"
      inputData={
        '{\n  "time_unit": [\n    2023,\n    2023,\n    2025,\n    2024,\n    2025,\n    2025,\n    2024,\n    2025,\n    2025,\n    2025,\n    2024,\n    2025,\n    2025,\n    2024,\n    2024,\n    2025,\n    2025,\n    2024,\n    2025,\n    2023,\n    2023,\n    2023\n  ],\n  "ym": [\n    "2023-08",\n    "2023-08",\n    "2025-08",\n    "2024-08",\n    "2025-08",\n    "2025-08",\n    "2024-08",\n    "2025-08",\n    "2025-08",\n    "2025-08",\n    "2024-08",\n    "2025-08",\n    "2025-08",\n    "2024-08",\n    "2024-08",\n    "2025-08",\n    "2025-08",\n    "2024-08",\n    "2025-08",\n    "2023-08",\n    "2023-08",\n    "2023-08"\n  ],\n  "yr": [\n    2023,\n    2023,\n    2025,\n    2024,\n    2025,\n    2025,\n    2024,\n    2025,\n    2025,\n    2025,\n    2024,\n    2025,\n    2025,\n    2024,\n    2024,\n    2025,\n    2025,\n    2024,\n    2025,\n    2023,\n    2023,\n    2023\n  ],\n  "month": [\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8,\n    8\n  ],\n  "shop_cd": [\n    "124062",\n    "124062",\n    "126668",\n    "126053",\n    "126668",\n    "126053",\n    "126737",\n    "124062",\n    "126737",\n    "126668",\n    "126053",\n    "124062",\n    "126053",\n    "124062",\n    "124062",\n    "126053",\n    "124062",\n    "126053",\n    "126053",\n    "126053",\n    "126737",\n    "126053"\n  ],\n  "shop_nm": [\n    "원주무실아가방갤러리",\n    "원주무실아가방갤러리",\n    "원주롯데마트 아가방",\n    "원주중앙아가방갤러리",\n    "원주롯데마트 아가방",\n    "원주중앙아가방갤러리",\n    "신)원주베이비하우스",\n    "원주무실아가방갤러리",\n    "신)원주베이비하우스",\n    "원주롯데마트 아가방",\n    "원주중앙아가방갤러리",\n    "원주무실아가방갤러리",\n    "원주중앙아가방갤러리",\n    "원주무실아가방갤러리",\n    "원주무실아가방갤러리",\n    "원주중앙아가방갤러리",\n    "원주무실아가방갤러리",\n    "원주중앙아가방갤러리",\n    "원주중앙아가방갤러리",\n    "원주중앙아가방갤러리",\n    "신)원주베이비하우스",\n    "원주중앙아가방갤러리"\n  ],\n  "biz_cd": [\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1",\n    "A1"\n  ],\n  "biz_nm": [\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부",\n    "아가방사업부"\n  ],\n  "br_cd": [\n    "71",\n    "01",\n    "76",\n    "01",\n    "01",\n    "74",\n    "01",\n    "01",\n    "01",\n    "71",\n    "74",\n    "76",\n    "01",\n    "01",\n    "76",\n    "71",\n    "01",\n    "71",\n    "76",\n    "71",\n    "01",\n    "01"\n  ],\n  "br_nm": [\n    "퓨토시크릿리뉴얼",\n    "아가방",\n    "해외브랜드2",\n    "아가방",\n    "아가방",\n    "엘츠",\n    "아가방",\n    "",\n    "아가방",\n    "퓨토시크릿리뉴얼",\n    "엘츠",\n    "해외브랜드2",\n    "아가방",\n    "아가방",\n    "해외브랜드2",\n    "퓨토시크릿리뉴얼",\n    "아가방",\n    "퓨토시크릿리뉴얼",\n    "해외브랜드2",\n    "퓨토시크릿리뉴얼",\n    "아가방",\n    "아가방"\n  ],\n  "tp_cd": [\n    "31",\n    "31",\n    "34",\n    "31",\n    "34",\n    "31",\n    "31",\n    "31",\n    "31",\n    "34",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31"\n  ],\n  "tp_nm": [\n    "가두점",\n    "가두점",\n    "롯데마트",\n    "가두점",\n    "롯데마트",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "롯데마트",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점",\n    "가두점"\n  ],\n  "team_cd": [\n    "05",\n    "05",\n    "02",\n    "05",\n    "02",\n    "05",\n    "05",\n    "05",\n    "05",\n    "02",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05",\n    "05"\n  ],\n  "team_nm": [\n    "05팀",\n    "05팀",\n    "02팀",\n    "05팀",\n    "02팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "02팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀",\n    "05팀"\n  ],\n  "user_cd": [\n    "14",\n    "14",\n    "01",\n    "14",\n    "01",\n    "14",\n    "14",\n    "14",\n    "14",\n    "01",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14",\n    "14"\n  ],\n  "user_nm": [\n    "이승국",\n    "이승국",\n    "남기훈",\n    "이승국",\n    "남기훈",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "남기훈",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국",\n    "이승국"\n  ],\n  "area_cd": [\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31",\n    "31"\n  ],\n  "area_nm": [\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원",\n    "강원"\n  ],\n  "onoff_flag": [\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인",\n    "오프라인"\n  ],\n  "is_flex": [\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false,\n    false\n  ],\n  "rev": [\n    0.056,\n    2.91287,\n    0.027,\n    3.92576,\n    2.4784,\n    0.129,\n    1.17942,\n    0,\n    1.0211,\n    0.069,\n    0.079,\n    0.0187,\n    4.8926,\n    1.41414,\n    0.0978,\n    0.091,\n    1.0106,\n    0.1072,\n    0.0258,\n    0.2088,\n    0.58968,\n    3.59653\n  ],\n  "target_sales": [\n    0,\n    0,\n    0,\n    0,\n    3.17,\n    0,\n    0,\n    0.67,\n    1.09,\n    0,\n    0,\n    0,\n    2.18,\n    0,\n    0,\n    0,\n    0.33,\n    0,\n    0,\n    0,\n    0,\n    0\n  ]\n}'
      }
      inventoryData=""
      isGlobalWidgetContainer={true}
      margin="0"
      startDate="'2025-01-01'"
    >
      <Text
        id="modalTitle6"
        value="##### 매장별 매출 현황({{ salesByShop.value.length }})"
        verticalAlign="center"
      />
      <Text
        id="text47"
        horizontalAlign="right"
        margin="4px 12px"
        value="단위: 백만원"
        verticalAlign="center"
      />
      <Table
        id="shopTbl"
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ salesByShop.value }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        groupByColumns={{}}
        heightType="auto"
        hidden=""
        margin="0"
        primaryKeyColumnId="b9bca"
        rowBackgroundColor=""
        rowHeight="small"
        rowSelection="none"
        showBorder={true}
        showColumnBorders={true}
        showFooter={true}
        showHeader={true}
        showSummaryRow={true}
        style={{ headerBackground: "#f5f5f5" }}
      >
        <Column
          id="4dd68"
          alignment="left"
          editable="false"
          format="string"
          groupAggregationMode="none"
          label="매장명"
          placeholder="Enter value"
          position="center"
          referenceId="shop_nm"
          size={239}
          sortMode="disabled"
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["shop_nm"] }}'}
        >
          <Event
            event="clickCell"
            method="run"
            params={{
              ordered: [
                {
                  src: "utils.copyToClipboard(currentSourceRow.shop_cd)\nutils.showNotification(\n  {\n    title: '매장코드 복사 완료',\n    description: '클립보드에 매장코드가 복사되었습니다.',\n    notificationType: \"success\"\n  }\n)",
                },
              ],
            }}
            pluginId=""
            type="script"
            waitMs="0"
            waitType="debounce"
          />
        </Column>
        <Column
          id="33700"
          alignment="right"
          backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          label="{{ thisYear.value.toString().slice(2) }}실적"
          placeholder="Enter value"
          position="center"
          referenceId="this_yr_sales"
          size={100}
          summaryAggregationMode="sum"
          valueOverride="{{ self.data[i][thisYear.value] }}"
        />
        <Column
          id="f25ac"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          label="{{ thisYear.value.toString().slice(2) }}목표"
          placeholder="Enter value"
          position="center"
          referenceId="this_yr_target"
          size={100}
          summaryAggregationMode="sum"
          valueOverride={'{{ self.data[i]["target_sales"] }}'}
        />
        <Column
          id="b97a4"
          alignment="right"
          backgroundColor={'{{ item < 1 ? "rgba(237, 41, 57, 0.1)" : null }}'}
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="average"
          label="목표달성율"
          placeholder="Enter value"
          position="center"
          referenceId="목표달성율"
          size={107.90625}
          valueOverride={
            '{{ self.data[i]["target_sales"] === 0 ? null : self.data[i][thisYear.value] / self.data[i]["target_sales"] }}'
          }
        />
        <Column
          id="b646b"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          label="목표차액"
          placeholder="Enter value"
          position="center"
          referenceId="목표차액"
          size={104.515625}
          summaryAggregationMode="sum"
          textColor={'{{ item > 0 ? "green" : "red" }}'}
          valueOverride={
            '{{ (self.data[i][thisYear.value] ?? 0) - (self.data[i]["target_sales"] ?? 0) }}'
          }
        />
        <Column
          id="8a9cb"
          alignment="right"
          backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="2024"
          label="{{ (thisYear.value-1).toString().slice(2) }}실적"
          placeholder="Enter value"
          position="center"
          size={130.3125}
          summaryAggregationMode="sum"
          valueOverride="{{ self.data[i][thisYear.value - 1] }}"
        />
        <Column
          id="36681"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="average"
          label="{{ (thisYear.value-1).toString().slice(2) }}대비"
          placeholder="Enter value"
          position="center"
          referenceId="thisYearValue1ToStringSlice2대비"
          size={90.3125}
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride="{{ self.data[i][thisYear.value] / self.data[i][thisYear.value - 1] - 1 }}"
        />
        <Column
          id="e0872"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          label="{{ (thisYear.value-1).toString().slice(2) }}대비신장액"
          placeholder="Enter value"
          position="center"
          referenceId="thisYearValue1ToStringSlice2대비신장액"
          size={113.453125}
          summaryAggregationMode="sum"
          valueOverride="{{ (self.data[i][thisYear.value] ?? 0) - (self.data[i][thisYear.value - 1] ?? 0)
}}"
        />
        <Column
          id="ba994"
          alignment="right"
          backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="2023"
          label="{{ (thisYear.value-2).toString().slice(2) }}실적"
          placeholder="Enter value"
          position="center"
          referenceId="thisYearValue2ToStringSlice2실적"
          size={127.3125}
          summaryAggregationMode="sum"
          valueOverride="{{ self.data[i][thisYear.value - 2] }}"
        />
        <Column
          id="2783a"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="average"
          label="23대비"
          placeholder="Enter value"
          position="center"
          referenceId="23대비"
          size={109.3125}
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride="{{ self.data[i][thisYear.value] / self.data[i][thisYear.value - 2] - 1 }}"
        />
        <Column
          id="cc18b"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          label="{{ (thisYear.value-2).toString().slice(2) }}대비신장액"
          placeholder="Enter value"
          position="center"
          referenceId="thisYearValue2ToStringSlice2대비신장액"
          size={129.453125}
          summaryAggregationMode="sum"
          valueOverride="{{ (self.data[i][thisYear.value] ?? 0) - (self.data[i][thisYear.value - 2] ?? 0)}}"
        />
        <Column
          id="b9bca"
          alignment="left"
          editable={false}
          format="string"
          groupAggregationMode="none"
          hidden="true"
          label="shop_cd"
          placeholder="Enter value"
          position="center"
          referenceId="shop_cd"
          size={100}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["shop_cd"] }}'}
        />
        <ToolbarButton
          id="1a"
          icon="bold/interface-text-formatting-filter-2"
          label="필터"
          type="filter"
        />
        <ToolbarButton
          id="3c"
          icon="bold/interface-download-button-2"
          label="엑셀 다운로드"
          type="custom"
        >
          <Event
            event="clickToolbar"
            method="run"
            params={{
              ordered: [
                {
                  src: '//  utils.changeLocale("ko")\n//  utils.exportData(salesByShop.value.map(obj => {\n//    const newObj = {}\n//    newObj["매장명"] = obj["shop_nm"]\n//    newObj["매장코드"] = obj["shop_cd"]  \n//    for (let year = thisYear.value; year >= thisYear.value -2; year--) {\n//      newObj[`${year}년도`] = obj[year]\n\n//      if (year === thisYear.value) {\n//        newObj["목표매출"] = obj?.target_sales\n//        newObj["목표차액"] = obj[year] - newObj["목표매출"]\n//        newObj["목표달성률"] = obj[year] / newObj["목표매출"]\n//      } else {\n//        newObj[`${year}대비`] = (obj[thisYear.value] - obj[year]) / obj[year]\n//        newObj[`${year}신장액`] =  obj[thisYear.value] - obj[year]   \n//      }\n//    }\n//    return newObj\n//  }), "매장목록", "xlsx")',
                },
              ],
            }}
            pluginId=""
            type="script"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="clickToolbar"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="excelDownloadByShop"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </ToolbarButton>
        <Event
          event="clickRow"
          method="setValue"
          params={{ ordered: [{ value: "{{ currentRow }}" }] }}
          pluginId="selectedRow"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickRow"
          method="show"
          params={{ ordered: [] }}
          pluginId="shopDetailModalFrame"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickCell"
          method="run"
          params={{ ordered: [{ src: "console.log(currentRow)" }] }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Table>
      <Text
        id="text65"
        horizontalAlign="right"
        value="단위: 천원"
        verticalAlign="center"
      />
    </ModuleContainerWidget>
  </Frame>
</App>
