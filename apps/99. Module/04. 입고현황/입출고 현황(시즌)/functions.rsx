<GlobalFunctions>
  <SqlQuery
    id="get_item_list"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/get_item_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showFailureToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="get_sku_sum"
    query={include("./lib/get_sku_sum.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <State id="var_sel_sty_info" />
  <State
    id="var_category_list"
    value={
      '{\n  "01": [\n    { cat_nm: "전체", id: 999 },\n    { cat_nm: "시즌의류(베이비)", id: 21 },\n    { cat_nm: "시즌의류(토들러)", id: 22 },\n    { cat_nm: "기획의류", id: 24 },\n    { cat_nm: "시즌언더", id: 20 },\n    { cat_nm: "기획언더", id: 25 },\n    { cat_nm: "시즌용품", id: 27 },\n    { cat_nm: "복종X", id: 91 },\n  ],\n  "79": [\n    { cat_nm: "전체", id: 999 },\n    { "cat_nm": "시즌의류", "id": 57 },\n    { "cat_nm": "시즌언더", "id": 56 },  \n    { "cat_nm": "파자마", "id": 59 }, \n    { "cat_nm": "시즌용품", "id": 62 },\n    { "cat_nm": "복종X", "id": 91 }\n  ],\n"07": [\n    { "cat_nm": "전체", "id": 999 }, \n    { "cat_nm": "기초복", "id": 1 }, \n    { "cat_nm": "기획내의", "id": 5 }, \n    { "cat_nm": "기획외의", "id": 4 }, \n    { "cat_nm": "유아복", "id": 2 },\n    { "cat_nm": "토들러", "id": 3 },\n    { "cat_nm": "기초ACC", "id": 6 }, \n    { "cat_nm": "정상ACC", "id": 7 }, \n    { "cat_nm": "일반용품", "id": 8 }, \n    { "cat_nm": "복종X", "id": 18 }\n  ],\n"yongpum": [\n    { "cat_nm": "전체", "id": 999 },\n    { "cat_nm": "발육", "id": 61 },\n    { "cat_nm": "수유", "id": 62 },\n    { "cat_nm": "완구|기타", "id": 63 },\n    { "cat_nm": "섬유1", "id": 64 },\n    { "cat_nm": "섬유2", "id": 65 },\n    { "cat_nm": "위생", "id": 66 }, \n    { "cat_nm": "화장품", "id": 68 }\n  ]\n}'
    }
  />
  <SqlQueryUnified
    id="season_list_new"
    query={include("./lib/season_list_new.sql", "string")}
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
  <State id="var_filter" />
  <SqlQuery
    id="season_list"
    isImported={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    playgroundQueryName="season_list_without_0code"
    playgroundQueryUuid="2107b35d-c8c3-443b-953b-751d38a2dd84"
    query={include("./lib/season_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    retoolVersion="3.148.10"
    showSuccessToaster={false}
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQuery
    id="get_latest_season"
    enableTransformer={true}
    importedQueryInputs={{
      ordered: [{ variable0: "{{ brand_code.value }}" }, { variable1: "1" }],
    }}
    isImported={true}
    notificationDuration={4.5}
    playgroundQueryName="get_latest_seasons"
    playgroundQueryUuid="c13b268b-11f4-4fa8-ac73-f0b48d384738"
    query={include("./lib/get_latest_season.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    retoolVersion="3.148.10"
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data).map(i=>i.year_season_cd)[0]"
    warningCodes={[]}
  />
</GlobalFunctions>
