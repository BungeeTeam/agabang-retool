<Screen
  id="defaultPage"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title="Default Page"
  urlSlug=""
>
  <Folder id="bulk_reorder">
    <State id="selectedReorderItems" value="" />
    <SqlQueryUnified
      id="getReorderSimulationTargets"
      enableTransformer={true}
      isMultiplayerEdited={false}
      query={include("../lib/getReorderSimulationTargets.sql", "string")}
      queryThrottleTime=""
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="setValue"
        params={{
          ordered: [
            {
              value:
                "{{ formatDataAsObject(self.data.filter(i=> multiselect1.value?.includes(i.id))).content.flat() }}",
            },
          ],
        }}
        pluginId="selectedReorderItems"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <GoogleSheetsQuery
      id="get_manufactoring_team_input_data"
      allowedGroupIds={[4]}
      allowedGroups={["All Users"]}
      enableTransformer={true}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      resourceDisplayName="팀즈봇 연동 구글 시트"
      resourceName="bfb63675-9694-4519-851e-afbd7f4e9a81"
      sheetName={
        '{{ var_brand_code.value === \'01\' ? "agabang" : var_brand_code.value === \'07\' ? "ettoi" : var_brand_code.value === \'79\' ? "disney" : "test" }}'
      }
      showFailureToaster={false}
      showSuccessToaster={false}
      spreadsheetId="1afJgasB6-Tl_8LTLQU3DD7z6FqYxtPS89gYD2PpMKHA"
      valueFormatting="unformatted"
    >
      <Event
        event="success"
        method="trigger"
        params={{
          ordered: [
            {
              options: {
                ordered: [
                  { onSuccess: null },
                  { onFailure: null },
                  { additionalScope: null },
                ],
              },
            },
          ],
        }}
        pluginId="InsertManufactoringTeamInputData"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </GoogleSheetsQuery>
    <JavascriptQuery
      id="saveColorEdits"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/saveColorEdits.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="saveSizeEdits"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/saveSizeEdits.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    >
      <Event
        event="success"
        method="refresh"
        params={{ ordered: [] }}
        pluginId="table_size_details"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </JavascriptQuery>
    <JavascriptQuery
      id="InsertManufactoringTeamInputData"
      notificationDuration={4.5}
      query={include("../lib/InsertManufactoringTeamInputData.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <State id="temp" />
    <SqlQueryUnified
      id="insertMDDecisionsToDB"
      actionType="BULK_INSERT"
      editorMode="gui"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      records={
        "{{ selectedReorderItems.value.map(item => ({\n  // selectedReorderItems.value에서 값을 가져오는 컬럼들\n  col_nm: item.reference_info?.col_nm || null,\n  col_cd: item.reference_info?.col_cd || null,\n  sty_nm: item.reference_info?.sty_nm || null,\n  group_id: item.reference_info?.groupId || null,\n  sty_cd: item.reference_info?.sty_cd || null,\n  tag_price: item.production_info?.['TAG가'] || null,\n  cost_price: item.production_info?.['원가'] || null,\n  sh_stck_qty: item.production_info?.['매장재고'] || null,\n  total_reorder_count: item.reorder_info?.['부족 수량'] || null,\n  tot_in_qty: item.production_info?.['입고 수량'] || null,\n  tot_sale_qty: item.sales_performance?.['누적 판매량'] || null,\n  final_reorder_qty: JSON.stringify(item.size_reorder_info?.map(size => size.reorder_qty) || []), // 배열을 JSON 문자열로 변환\n  current_stock_qty: item.reorder_info?.['현재 총재고'] || null,\n  wh_stck_qty: item.production_info?.['창고재고'] || null,\n  size_cd: JSON.stringify(item.size_reorder_info?.map(size => size.size_cd) || []), // 배열을 JSON 문자열로 변환\n  size_nm: JSON.stringify(item.size_reorder_info?.map(size => size.size_nm) || []), // 배열을 JSON 문자열로 변환\n  sale_rate: item.sales_performance?.['누적 판매율(입고 기준)'] || null,\n  expected_sales: item.reorder_info?.['기준일~마감일 예상 판매량'] || null,\n  lead_time_days: item.reorder_info?.['리드타임(일)'] || null,\n  avg_daily_sales: item.sales_performance?.['일 판매량'] || null,\n  expected_sales_period: item.reorder_info?.['기준일~판매 마감일'] || null,\n  expected_sales_qty: item.reorder_info?.['기준일~마감일 예상 판매량'] || null,\n  modifiable_cost_price: item.production_info?.['리오더 원가'] || null,\n  price_multiple: item.production_info?.['배수'] || null,\n  has_sheet_data: item.reference_info?.has_sheet_data || null,\n  note: item.production_info?.['생산팀 메모'] || null,\n  price_reorder_multiple: item.production_info?.['리오더 배수'] || null,\n  lead_time: item.reorder_info?.['리드타임(일)'] || null,\n  created_by: current_user.email,\n  created_at: new Date(),\n  md_memo: item.reorder_info?.['MD 메모'] === \"(메모 없음)\" ? \"\" : (item.reorder_info?.['MD 메모'] || null),\n  type: 'seasonless',\n\n  // selectedReorderItems.value에 없어 null로 저장되는 컬럼들\n  reorder_recommending_status: null,\n  series_name: null,\n  cust_nm: null,\n  fabric: null,\n  small_cat: null,\n  avg_monthly_sales_d_180: null,\n  cust_cd: null,\n  shop_gini: null,\n  estimated_stock: null,\n  status_d_30: null,\n  middle_cat: null,\n  large_cat: null,\n  avg_monthly_sales_d_30: null,\n  avg_monthly_sales_d_365: null,\n  days_until_out_of_stock_d_30: null,\n  days_until_out_of_stock_d_180: null,\n  emergency_stock: null,\n  target_sale_rate: null,\n  status_d_180: null,\n  status_d_365: null,\n  moq: null,\n  effective_monthly_sales: null,\n  avg_monthly_sales: null,\n  expected_supply_qty: null,\n  days_until_out_of_stock_d_365: null,\n  exclude_button: null,\n  expected_sales_rate: null,\n  total_expected_sales_qty: null,\n  manufacturer_stock: null,\n  estimated_final_sale_rate: null,\n  estimated_ending_stock: null\n})) }}"
      }
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showUpdateSetValueDynamicallyToggle={false}
      successMessage="리오더 내역을 저장했어요!"
      tableName="reorder_md_decision"
      updateSetValueDynamically={true}
    />
    <JavascriptQuery
      id="exportReorderDataToExcel"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/exportReorderDataToExcel.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    >
      <Event
        event="success"
        method="exportData"
        params={{
          ordered: [
            { fileType: "xlsx" },
            { data: "{{ mainTable.data }}" },
            {
              fileName:
                "raw_seasonless_color_{{moment(new Date()).format('YYYY-MM-DD')}}",
            },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="success"
        method="exportData"
        params={{
          ordered: [
            { fileType: "xlsx" },
            { data: "{{ sizeTable.data }}" },
            {
              fileName:
                "raw_seasonless_size_{{moment(new Date()).format('YYYY-MM-DD')}}",
            },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="success"
        method="exportData"
        params={{
          ordered: [
            { fileType: "xlsx" },
            { data: "{{ reviewTable.data }}" },
            {
              fileName:
                "summary_seasonless_color_{{moment(new Date()).format('YYYY-MM-DD')}}",
            },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="success"
        method="exportData"
        params={{
          ordered: [
            { fileType: "xlsx" },
            {
              fileName:
                "summary_seasonless_size_{{moment(new Date()).format('YYYY-MM-DD')}}",
            },
            { data: "{{ approvalTable.data }}" },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </JavascriptQuery>
  </Folder>
  <SqlQueryUnified
    id="insertReorderSimulationTargets"
    actionType="INSERT"
    changeset={
      '[{"key":"timestamp","value":"{{ new Date() }}"},{"key":"content","value":"{{ selectedReorderItems.value }}"},{"key":"user_name","value":"{{ current_user.email }}"},{"key":"br_cd","value":"{{ var_brand_code.value }}"}]'
    }
    editorMode="gui"
    notificationDuration={4.5}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showUpdateSetValueDynamicallyToggle={false}
    successMessage="시뮬레이션 대상 아이템을 업데이트했습니다."
    tableName="reorder_seasonless_simulation_targets"
    updateSetValueDynamically={true}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="getReorderSimulationTargets"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <State id="var_brand_code" value="'01'" />
  <AppStyles id="$appStyles" css={include("../lib/$appStyles.css", "string")} />
  <Include src="./header.rsx" />
  <Include src="./modalFrame1.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    type="main"
  >
    <Container
      id="mainContainer"
      _direction="vertical"
      _gap="0px"
      _type="stack"
      enableFullBleed={true}
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      heightType="fixed"
      margin="0"
      overflowType="hidden"
      padding="0"
      showBody={true}
      showBorder={false}
      showFooter={true}
      style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
    >
      <Header>
        <Container
          id="stack12"
          _align="center"
          _flexWrap={true}
          _gap="0px"
          _justify="space-between"
          _type="stack"
          footerPadding="4px 12px"
          headerPadding="4px 12px"
          margin="0"
          padding="0"
          showBody={true}
          showBorder={false}
          style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
        >
          <View id="5bfc2" viewKey="View 1">
            <Button
              id="button7"
              horizontalAlign="right"
              iconBefore="bold/interface-content-save"
              style={{ ordered: [] }}
              text="현재 값 임시 저장"
            >
              <Event
                event="click"
                method="trigger"
                params={{ ordered: [] }}
                pluginId="insertReorderSimulationTargets"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
            </Button>
            <Container
              id="stack11"
              _align="center"
              _flexWrap={true}
              _gap="0px"
              _type="stack"
              footerPadding="4px 12px"
              headerPadding="4px 12px"
              margin="0"
              padding="0"
              showBody={true}
              showBorder={false}
              style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
            >
              <View id="5bfc2" viewKey="View 1">
                <Icon
                  id="icon1"
                  icon="bold/interface-alert-information-circle"
                  margin="0"
                >
                  <Event
                    event="click"
                    method="show"
                    params={{ ordered: [] }}
                    pluginId="modalFrame1"
                    type="widget"
                    waitMs="0"
                    waitType="debounce"
                  />
                </Icon>
                <Text
                  id="text37"
                  style={{
                    ordered: [
                      { fontSize: "20px" },
                      { fontWeight: "700" },
                      { fontFamily: "pretendard variable" },
                    ],
                  }}
                  value="리오더 시뮬레이션"
                  verticalAlign="center"
                />
              </View>
            </Container>
          </View>
        </Container>
      </Header>
      <View id="78ff7" viewKey="View 1">
        <Container
          id="gridContainer"
          _direction="vertical"
          _gap="0px"
          _type="stack"
          footerPadding="4px 12px"
          headerPadding="4px 12px"
          heightType="fixed"
          margin="0"
          overflowType="hidden"
          padding="12px"
          showBody={true}
          showBorder={false}
          showHeader={true}
          style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
        >
          <Header>
            <Container
              id="stack13"
              _align="center"
              _flexWrap={true}
              _gap="0px"
              _type="stack"
              footerPadding="4px 12px"
              headerPadding="4px 12px"
              margin="0"
              padding="0"
              showBody={true}
              showBorder={false}
              style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
            >
              <View id="5bfc2" viewKey="View 1">
                <Icon
                  id="icon2"
                  icon="bold/interface-alert-information-circle"
                  margin="0"
                >
                  <Event
                    event="click"
                    method="show"
                    params={{ ordered: [] }}
                    pluginId="modalFrame1"
                    type="widget"
                    waitMs="0"
                    waitType="debounce"
                  />
                </Icon>
                <Text
                  id="text42"
                  style={{
                    ordered: [
                      { fontSize: "20px" },
                      { fontWeight: "700" },
                      { fontFamily: "pretendard variable" },
                    ],
                  }}
                  value="리오더 시뮬레이션"
                  verticalAlign="center"
                />
                <Multiselect
                  id="multiselect1"
                  captionByIndex="{{ item.content[0].reference_info.sty_nm }} 외 {{ item.content.length - 1 }}개"
                  data="{{ getReorderSimulationTargets.data }}"
                  emptyMessage="No options"
                  label="시뮬레이션 저장 일시"
                  labels="{{ moment(item.timestamp).format('YYYY-MM-DD HH:MM') }}"
                  labelWidth="18"
                  overlayMaxHeight={375}
                  placeholder="리오더 일시를 선택해주세요"
                  showSelectionIndicator={true}
                  value="[{{ self.data[0].id }}]"
                  values="{{ item.id }}"
                  wrapTags={true}
                >
                  <Event
                    event="change"
                    method="run"
                    params={{
                      ordered: [
                        {
                          src: "await selectedReorderItems.setValue( formatDataAsObject(getReorderSimulationTargets.data.filter(i=> multiselect1.value.includes(i.id))).content.flat())\n//  getReorderSimulationTargets.trigger();\n",
                        },
                      ],
                    }}
                    pluginId=""
                    type="script"
                    waitMs="0"
                    waitType="debounce"
                  />
                </Multiselect>
              </View>
            </Container>
            <Button
              id="button8"
              horizontalAlign="right"
              iconBefore="bold/interface-content-save"
              style={{ ordered: [] }}
              text="현재 시뮬레이션 목록 임시 저장"
            >
              <Event
                event="click"
                method="trigger"
                params={{ ordered: [] }}
                pluginId="insertReorderSimulationTargets"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
            </Button>
          </Header>
          <View id="e5d12" viewKey="View 1">
            <ListViewBeta
              id="gridView2"
              _primaryKeys="{{i}}"
              data="{{ selectedReorderItems.value || [] }}"
              heightType="fill"
              itemWidth="200px"
              margin="0"
              numColumns="2"
              padding="0"
            >
              <Container
                id="container2"
                _align="center"
                _flexWrap={true}
                _gap="0px"
                _justify="space-between"
                _type="stack"
                footerPadding="4px 12px"
                headerPadding="4px 12px"
                overflowType="hidden"
                padding="12px"
                showBody={true}
                showBorder={false}
                showHeader={true}
                showHeaderBorder={false}
              >
                <Header>
                  <Text
                    id="containerTitle2"
                    style={{
                      ordered: [
                        { fontSize: "h6Font" },
                        { fontWeight: "h6Font" },
                        { fontFamily: "h6Font" },
                      ],
                    }}
                    value="{{item.reference_info.sty_nm}} ({{ item.reference_info.col_nm }}) - {{item.reference_info.sty_cd}}{{  item.reference_info.col_cd }}"
                    verticalAlign="center"
                  />
                  <Button
                    id="button1"
                    horizontalAlign="right"
                    iconBefore="bold/interface-remove-circle"
                    style={{ ordered: [{ background: "#d8d8d8" }] }}
                    text="시뮬레이션에서 제외"
                  >
                    <Event
                      event="click"
                      method="run"
                      params={{
                        ordered: [
                          {
                            src: '// 함수 시작 로깅\nconsole.log("===== 항목 제거 함수 시작 =====");\n\n// 제거할 항목의 ID 가져오기\nconst groupId = item.reference_info.groupId;\nconsole.log("제거할 항목 ID:", groupId);\n\n// 현재 선택된 항목 목록 가져오기\nconst currentItems = selectedReorderItems.value || [];\nconsole.log("현재 항목 개수:", currentItems.length);\n\n// 수정된 필터링 로직: reorder_info 내부의 groupId 확인\nconsole.log("필터링 시작...");\nconst updatedItems = currentItems.filter(item => {\n  // 다양한 가능한 경로로 groupId 찾기\n  const itemGroupId = \n    (item.reorder_info && item.reorder_info.groupId) || // reorder_info 내부\n    (item.reference_info && item.reference_info.groupId) || // reference_info 내부\n    item.groupId; // 루트 레벨\n  \n  const matches = itemGroupId === groupId;\n  console.log(`항목 ID: ${itemGroupId}, 일치: ${matches ? "예" : "아니오"}`);\n  return itemGroupId !== groupId;\n});\n\n// 결과 로깅\nconsole.log(`필터링 완료! 원래 ${currentItems.length}개 항목 중 ${updatedItems.length}개 항목 남음`);\nconsole.log("제거된 항목 수:", currentItems.length - updatedItems.length);\n\n// 업데이트된 목록을 변수에 설정\nconsole.log("selectedReorderItems 변수 업데이트 시작...");\nselectedReorderItems.setValue(updatedItems);\nconsole.log("selectedReorderItems 변수 업데이트 성공!");\n\n// 업데이트 후 검증\nsetTimeout(() => {\n  console.log("업데이트 후 항목 개수:", (selectedReorderItems.value || []).length);\n}, 500);\n\nconsole.log(`항목 ${groupId} 제거 작업 완료!`);\nconsole.log("===== 항목 제거 함수 종료 =====");\n\nreturn true;',
                          },
                        ],
                      }}
                      pluginId=""
                      type="script"
                      waitMs="0"
                      waitType="debounce"
                    />
                    <Event
                      event="click"
                      method="trigger"
                      params={{ ordered: [] }}
                      pluginId="insertReorderSimulationTargets"
                      type="datasource"
                      waitMs="0"
                      waitType="debounce"
                    />
                  </Button>
                </Header>
                <View id="fe38f" viewKey="View 1">
                  <Container
                    id="container3"
                    _direction="vertical"
                    _flexWrap={true}
                    _gap="0px"
                    _type="stack"
                    footerPadding="4px 12px"
                    headerPadding="4px 12px"
                    margin="0"
                    padding="0"
                    showBody={true}
                    showBorder={false}
                  >
                    <View id="fe38f" viewKey="View 1">
                      <Container
                        id="container4"
                        _flexWrap={true}
                        _gap="0px"
                        _justify="space-between"
                        _type="stack"
                        footerPadding="4px 12px"
                        headerPadding="4px 12px"
                        margin="0"
                        padding="0"
                        showBody={true}
                        showBorder={false}
                      >
                        <View id="fe38f" viewKey="View 1">
                          <KeyValue
                            id="keyValueSalesPerformance"
                            data="{{ item.sales_performance }}"
                            editIcon="bold/interface-edit-pencil"
                            enableSaveActions={true}
                            groupLayout="singleColumn"
                            labelWrap={true}
                          >
                            <Property
                              id="기준일"
                              editable="false"
                              editableOptions={{
                                minDate: "",
                                maxDate:
                                  "{{new Date(new Date().setDate(new Date().getDate() - 1))}}",
                              }}
                              format="date"
                              formatOptions={{ dateFormat: "yyyy-MM-dd" }}
                              hidden="false"
                              label="기준일"
                            />
                            <Property
                              id="출고~기준일 판매일수"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="출고~기준일 판매일수"
                            />
                            <Property
                              id="누적 판매량"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="누적 판매량"
                            />
                            <Property
                              id="누적 판매율(입고 기준)"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="percent"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="누적 판매율(입고 기준)"
                            />
                            <Property
                              id="판매일수"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="판매일수"
                            />
                            <Property
                              id="일 판매량"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="일 판매량"
                            />
                            <Property
                              id="매장수"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="매장수"
                            />
                            <Property
                              id="주간 판매량"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="주간 판매량"
                            />
                            <Property
                              id="기간 판매율(출고 기준)"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="percent"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="기간 판매율(출고 기준)"
                            />
                            <Property
                              id="매장당 일 판매량"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="매장당 일 판매량"
                            />
                            <Property
                              id="최근 7일 판매량"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="최근 7일 판매량"
                            />
                            <Property
                              id="최근 7일 판매율(출고 기준)"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="percent"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                                decimalPlaces: "",
                              }}
                              hidden="false"
                              label="최근 7일 판매율(출고 기준)"
                            />
                            <Property
                              id="groupId"
                              editable="false"
                              editableOptions={{}}
                              format="string"
                              formatOptions={{}}
                              hidden="true"
                              label="Group ID"
                            />
                            <Event
                              event="save"
                              method="trigger"
                              params={{ ordered: [] }}
                              pluginId="saveColorEdits"
                              type="datasource"
                              waitMs="0"
                              waitType="debounce"
                            />
                          </KeyValue>
                          <Container
                            id="stack10"
                            _align="center"
                            _direction="vertical"
                            _flexWrap={true}
                            _gap="0px"
                            _type="stack"
                            footerPadding="4px 12px"
                            headerPadding="4px 12px"
                            padding="0"
                            showBody={true}
                            showBorder={false}
                          >
                            <View id="01eb7" viewKey="View 1">
                              <TagsWidget2
                                id="tags1"
                                allowWrap={true}
                                colorByIndex={
                                  '{{ \n  self.value[0] === "생산팀 입력 완료" ? theme.automatic[2] : theme.automatic[0] \n}}'
                                }
                                data={
                                  '[{{ \n  item.reference_info?.has_sheet_data === true ? "생산팀 입력 완료" : "생산팀 미입력" \n}}]'
                                }
                                hidden=""
                                hiddenByIndex=""
                                labels=""
                                style={{ ordered: [] }}
                                value=""
                                values=""
                              />
                              <Image
                                id="image3"
                                horizontalAlign="center"
                                src="{{ 
 `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${item.reference_info.sty_cd}${item.reference_info.col_cd}.jpg`
}}"
                                style={{
                                  ordered: [
                                    { borderColor: "rgba(237, 237, 237, 1)" },
                                  ],
                                }}
                              />
                            </View>
                          </Container>
                          <KeyValue
                            id="keyValueReorderInfo"
                            data="{{ item.reorder_info }}"
                            editIcon="bold/interface-edit-pencil"
                            enableSaveActions={true}
                            groupLayout="singleColumn"
                            labelWrap={true}
                            style={{}}
                          >
                            <Property
                              id="리드타임(일)"
                              editable={true}
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="리드타임(일)"
                            />
                            <Property
                              id="리오더 납기일"
                              editable="false"
                              editableOptions={{}}
                              format="date"
                              formatOptions={{ dateFormat: "yyyy-MM-dd" }}
                              hidden="false"
                              label="리오더 납기일"
                            />
                            <Property
                              id="판매 마감일"
                              editable="true"
                              editableOptions={{}}
                              format="date"
                              formatOptions={{ dateFormat: "yyyy-MM-dd" }}
                              hidden="false"
                              label="판매 마감일"
                            />
                            <Property
                              id="리오더 납기일~판매 마감일"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="리오더 납기일~판매 마감일"
                            />
                            <Property
                              id="기준일~판매 마감일"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="기준일~판매 마감일"
                            />
                            <Property
                              id="성장률(%)"
                              editable="true"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="성장률(%)"
                            />
                            <Property
                              id="기준일~마감일 예상 판매량"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                                decimalPlaces: "",
                              }}
                              hidden="false"
                              label="기준일~마감일 예상 판매량"
                              valueOverride="{{ item.toFixed(0) }}"
                            />
                            <Property
                              id="현재 총재고"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="현재 총재고"
                            />
                            <Property
                              id="부족 수량"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="부족 수량"
                            />
                            <Property
                              id="groupId"
                              editable="false"
                              editableOptions={{}}
                              format="string"
                              formatOptions={{}}
                              hidden="true"
                              label="Group ID"
                            />
                            <Property
                              id="리오더 입고 예상일"
                              editable="false"
                              editableOptions={{}}
                              format="date"
                              formatOptions={{}}
                              hidden="false"
                              label="리오더 입고 예상일"
                            />
                            <Property
                              id="MD 메모"
                              editable="true"
                              editableOptions={{}}
                              format="string"
                              formatOptions={{}}
                              hidden="false"
                              label="MD 메모"
                              placeholder="추후 리오더 이력 확인 시 참고할만한 특이사항이 있으면 메모로 남겨주세요."
                            />
                            <Event
                              event="save"
                              method="trigger"
                              params={{ ordered: [] }}
                              pluginId="saveColorEdits"
                              type="datasource"
                              waitMs="0"
                              waitType="debounce"
                            />
                          </KeyValue>
                          <KeyValue
                            id="keyValueProductInfo"
                            data="{{ item.production_info }}"
                            editIcon="bold/interface-edit-pencil"
                            enableSaveActions={true}
                            groupLayout="singleColumn"
                            labelWrap={true}
                          >
                            <Property
                              id="생산업체"
                              editable="false"
                              editableOptions={{}}
                              format="string"
                              formatOptions={{}}
                              hidden="false"
                              label="생산업체"
                            />
                            <Property
                              id="TAG가"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="Tag가"
                            />
                            <Property
                              id="원가"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="원가"
                            />
                            <Property
                              id="배수"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="배수"
                            />
                            <Property
                              id="리오더 TAG가"
                              editable="true"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="리오더 Tag가"
                            />
                            <Property
                              id="리오더 원가"
                              editable="true"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="리오더 원가"
                            />
                            <Property
                              id="리오더 배수"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="리오더 배수"
                            />
                            <Property
                              id="입고 수량"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="입고 수량"
                            />
                            <Property
                              id="출고 수량"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="출고 수량"
                            />
                            <Property
                              id="매장재고"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="true"
                              label="매장재고"
                            />
                            <Property
                              id="창고재고"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="decimal"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="true"
                              label="창고재고"
                            />
                            <Property
                              id="출고일"
                              editable="false"
                              editableOptions={{}}
                              format="date"
                              formatOptions={{ dateFormat: "yyyy-MM-dd" }}
                              hidden="false"
                              label="출고일"
                            />
                            <Property
                              id="출고율"
                              editable="false"
                              editableOptions={{ showStepper: true }}
                              format="percent"
                              formatOptions={{
                                showSeparators: true,
                                notation: "standard",
                              }}
                              hidden="false"
                              label="출고율"
                            />
                            <Property
                              id="groupId"
                              editable="false"
                              editableOptions={{}}
                              format="string"
                              formatOptions={{}}
                              hidden="true"
                              label="Group ID"
                            />
                            <Property
                              id="note"
                              editable="false"
                              editableOptions={{}}
                              format="multilineString"
                              formatOptions={{}}
                              hidden="false"
                              label="생산팀 메모"
                            />
                            <Property
                              id="생산팀 메모"
                              editable="false"
                              editableOptions={{}}
                              format="string"
                              formatOptions={{}}
                              hidden="true"
                              label="생산팀 메모"
                            />
                            <Event
                              event="save"
                              method="trigger"
                              params={{ ordered: [] }}
                              pluginId="saveColorEdits"
                              type="datasource"
                              waitMs="0"
                              waitType="debounce"
                            />
                          </KeyValue>
                        </View>
                      </Container>
                      <Table
                        id="table_size_details"
                        alwaysShowRowSelectionCheckboxes={true}
                        autoColumnWidth={true}
                        cellSelection="none"
                        clearChangesetOnSave={true}
                        data="{{ item.size_reorder_info || [] }}"
                        defaultSelectedRow={{
                          mode: "index",
                          indexType: "display",
                          index: 0,
                        }}
                        defaultSort={[
                          { object: { columnId: "1af16", direction: "asc" } },
                          { object: { columnId: "88328", direction: "asc" } },
                          { object: { columnId: "943ac", direction: "asc" } },
                        ]}
                        emptyMessage="No rows found"
                        enableSaveActions={true}
                        groupedColumnConfig={{
                          expandByDefault: false,
                          size: 115.203125,
                        }}
                        heightType="auto"
                        margin="0"
                        primaryKeyColumnId="7334e"
                        rowBackgroundColor=""
                        rowHeight="small"
                        showBorder={true}
                        showFooter={true}
                        showHeader={true}
                        showSummaryRow={true}
                        style={{ accent: "rgba(1, 72, 143, 0)" }}
                        toolbarPosition="bottom"
                      >
                        <Column
                          id="1781d"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="decimal"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="sum"
                          hidden="true"
                          key="size_cd"
                          label="Size cd"
                          placeholder="Enter value"
                          position="center"
                          size={100}
                          summaryAggregationMode="none"
                        />
                        <Column
                          id="db087"
                          alignment="center"
                          editableOptions={{ showStepper: true }}
                          format="string"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="sum"
                          key="size_nm"
                          label="사이즈명"
                          placeholder="Enter value"
                          position="center"
                          size={57.484375}
                          summaryAggregationMode="none"
                        />
                        <Column
                          id="e7ef3"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="decimal"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="sum"
                          key="size_in_count"
                          label="입고량"
                          placeholder="Enter value"
                          position="center"
                          size={48.109375}
                          summaryAggregationMode="sum"
                        />
                        <Column
                          id="bb90f"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="percent"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                            decimalPlaces: "0",
                          }}
                          groupAggregationMode="average"
                          key="size_in_ratio"
                          label="입고율"
                          placeholder="Enter value"
                          position="center"
                          size={47.109375}
                          summaryAggregationMode="sum"
                        />
                        <Column
                          id="09c12"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="decimal"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="sum"
                          key="size_out_count"
                          label="출고량"
                          placeholder="Enter value"
                          position="center"
                          size={48.109375}
                          summaryAggregationMode="sum"
                        />
                        <Column
                          id="7867f"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="percent"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                            decimalPlaces: "0",
                          }}
                          groupAggregationMode="average"
                          key="size_out_ratio"
                          label="출고율"
                          placeholder="Enter value"
                          position="center"
                          size={47.109375}
                          summaryAggregationMode="sum"
                        />
                        <Column
                          id="1bfed"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="decimal"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="sum"
                          key="size_sales_count"
                          label="판매량"
                          placeholder="Enter value"
                          position="center"
                          size={47.6875}
                          summaryAggregationMode="sum"
                        />
                        <Column
                          id="5cdab"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="percent"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                            decimalPlaces: "0",
                          }}
                          groupAggregationMode="average"
                          key="size_sales_ratio"
                          label="판매비"
                          placeholder="Enter value"
                          position="center"
                          size={47.109375}
                          summaryAggregationMode="sum"
                        />
                        <Column
                          id="4cbbf"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="percent"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="average"
                          key="size_out_ratio_diff"
                          label="출고율-판매비"
                          placeholder="Enter value"
                          position="center"
                          size={83.421875}
                          summaryAggregationMode="none"
                        />
                        <Column
                          id="3b9a4"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="percent"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="average"
                          key="size_sales_rate"
                          label="판매율"
                          placeholder="Enter value"
                          position="center"
                          size={47.109375}
                          summaryAggregationMode="none"
                          valueOverride="{{ item.toFixed(2) }}"
                        />
                        <Column
                          id="69479"
                          alignment="right"
                          backgroundColor="{{ theme.highlight }}"
                          editable="true"
                          editableOptions={{ showStepper: true }}
                          format="percent"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="average"
                          hidden="true"
                          key="growth_rate"
                          label="성장률"
                          placeholder="Enter value"
                          position="center"
                          size={47.109375}
                          summaryAggregationMode="none"
                        />
                        <Column
                          id="2d1a8"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="decimal"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="sum"
                          hidden="true"
                          key="days_until_sales_end"
                          label="판매마감까지 남은 일수"
                          placeholder="Enter value"
                          position="center"
                          size={100}
                          summaryAggregationMode="none"
                        />
                        <Column
                          id="9a8d1"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="decimal"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="sum"
                          key="expected_sales"
                          label="예상 판매량"
                          placeholder="Enter value"
                          position="center"
                          size={70.859375}
                          summaryAggregationMode="sum"
                          tooltip="성장률에 따라 계산된 예상 판매량 (기준일~마감일)"
                          valueOverride="{{ item.toFixed(0) }}"
                        />
                        <Column
                          id="7638c"
                          alignment="right"
                          editableOptions={{ showStepper: true }}
                          format="decimal"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="sum"
                          key="total_stock"
                          label="현재 총재고"
                          placeholder="Enter value"
                          position="center"
                          size={70.859375}
                          summaryAggregationMode="sum"
                        />
                        <Column
                          id="6c141"
                          alignment="right"
                          cellTooltip="사이즈별 예상 판매량 - 현재 총재고
= {{ currentSourceRow.expected_sales }} - {{ currentSourceRow.total_stock }}"
                          cellTooltipMode="custom"
                          editableOptions={{ showStepper: true }}
                          format="decimal"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="sum"
                          key="shortage_qty"
                          label="부족 수량"
                          placeholder="Enter value"
                          position="center"
                          size={60.5}
                          summaryAggregationMode="sum"
                          valueOverride="{{ item.toFixed(0) }}"
                        />
                        <Column
                          id="e73e5"
                          alignment="right"
                          backgroundColor="{{ theme.highlight }}"
                          editable="true"
                          editableOptions={{ showStepper: true }}
                          format="decimal"
                          formatOptions={{
                            showSeparators: true,
                            notation: "standard",
                          }}
                          groupAggregationMode="sum"
                          key="reorder_qty"
                          label="리오더 수량"
                          placeholder="리오더할 수량을 입력해주세요"
                          position="center"
                          size={70.859375}
                          summaryAggregationMode="sum"
                        />
                        <Column
                          id="7334e"
                          alignment="left"
                          editable={false}
                          format="string"
                          groupAggregationMode="none"
                          hidden="true"
                          key="size_id"
                          label="Size ID"
                          placeholder="Enter value"
                          position="center"
                          size={100}
                          summaryAggregationMode="none"
                        />
                        <ToolbarButton
                          id="1a"
                          icon="bold/interface-text-formatting-filter-2"
                          label="Filter"
                          type="filter"
                        />
                        <ToolbarButton
                          id="3c"
                          icon="bold/interface-download-button-2"
                          label="Download"
                          type="custom"
                        >
                          <Event
                            event="clickToolbar"
                            method="exportData"
                            params={{
                              ordered: [
                                {
                                  options: {
                                    ordered: [
                                      { fileType: "xlsx" },
                                      { includeHiddenColumns: false },
                                      {
                                        fileName:
                                          "raw_seasonless_size_{{moment(new Date()).format('YYYY-MM-DD')}}",
                                      },
                                    ],
                                  },
                                },
                              ],
                            }}
                            pluginId="table_size_details"
                            type="widget"
                            waitMs="0"
                            waitType="debounce"
                          />
                        </ToolbarButton>
                        <ToolbarButton
                          id="4d"
                          icon="bold/interface-arrows-round-left"
                          label="Refresh"
                          type="custom"
                        >
                          <Event
                            event="clickToolbar"
                            method="refresh"
                            pluginId="table_size_details"
                            type="widget"
                            waitMs="0"
                            waitType="debounce"
                          />
                        </ToolbarButton>
                        <Event
                          event="save"
                          method="trigger"
                          params={{ ordered: [] }}
                          pluginId="saveSizeEdits"
                          type="datasource"
                          waitMs="0"
                          waitType="debounce"
                        />
                      </Table>
                    </View>
                  </Container>
                </View>
              </Container>
            </ListViewBeta>
          </View>
          <Footer>
            <Button id="button3" text="리오더 확정 & 엑셀 다운로드">
              <Event
                event="click"
                method="trigger"
                params={{
                  ordered: [
                    {
                      options: {
                        object: {
                          onSuccess: null,
                          onFailure: null,
                          additionalScope: null,
                        },
                      },
                    },
                  ],
                }}
                pluginId="exportReorderDataToExcel"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
              <Event
                event="click"
                method="trigger"
                params={{ ordered: [] }}
                pluginId="insertMDDecisionsToDB"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
              <Event
                enabled=""
                event="click"
                method="run"
                params={{
                  ordered: [
                    {
                      src: 'setTimeout(() => {\n  // This code will run after the delay\n  selectedReorderItems.setValue("");\n}, 500); // 500 milliseconds (0.5 seconds) delay. Adjust as needed.',
                    },
                  ],
                }}
                pluginId=""
                type="script"
                waitMs="0"
                waitType="debounce"
              />
            </Button>
          </Footer>
        </Container>
      </View>
      <Footer>
        <Button id="button10" text="리오더 내역 저장 & 엑셀 다운로드">
          <Event
            event="click"
            method="trigger"
            params={{
              ordered: [
                {
                  options: {
                    object: {
                      onSuccess: null,
                      onFailure: null,
                      additionalScope: null,
                    },
                  },
                },
              ],
            }}
            pluginId="exportReorderDataToExcel"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="click"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="insertMDDecisionsToDB"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </Footer>
    </Container>
    <Table
      id="mainTable"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ exportReorderDataToExcel.data.mainTableData }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      dynamicColumnsEnabled={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="true"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="4153e"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품번"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="489a8"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="컬러명"
        label="컬러명"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="6dd0f"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품명"
        label="품명"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="d7c4d"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="성장률(%)"
        label="성장률"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="82a65"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리드타임(일)"
        label="리드타임 일"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="af0dd"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="기준일"
        label="기준일"
        placeholder="Enter value"
        position="center"
        size={93.75}
        summaryAggregationMode="none"
      />
      <Column
        id="48de5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="누적 판매량"
        label="누적 판매량"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="4bd3a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="최근 7일 판매량"
        label="최근 7 일 판매량"
        placeholder="Enter value"
        position="center"
        size={95.25}
        summaryAggregationMode="none"
      />
      <Column
        id="fe233"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="생산팀 메모"
        label="생산팀 메모"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="23b3f"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="MD 메모"
        label="Md 메모"
        placeholder="Enter value"
        position="center"
        size={58.25}
        summaryAggregationMode="none"
      />
      <Column
        id="9d0b1"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="컬러코드"
        label="컬러코드"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="42a9b"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="생산업체"
        label="생산업체"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="b25eb"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="TAG가"
        label="Tag가"
        placeholder="Enter value"
        position="center"
        size={47.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="c2da1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="원가"
        label="원가"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="b9a67"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="배수"
        label="배수"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="9500e"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="출고일"
        label="출고일"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="ee550"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="입고 수량"
        label="입고 수량"
        placeholder="Enter value"
        position="center"
        size={60.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="1bfa9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="출고 수량"
        label="출고 수량"
        placeholder="Enter value"
        position="center"
        size={60.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="102ad"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="출고율"
        label="출고율"
        placeholder="Select option"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="ff8b3"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="누적 판매율"
        label="누적 판매율"
        placeholder="Select option"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="7378b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="출고~기준일 판매일수"
        label="출고 기준일 판매일수"
        placeholder="Enter value"
        position="center"
        size={116.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="bc948"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="일 판매량"
        label="일 판매량"
        placeholder="Enter value"
        position="center"
        size={60.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="16971"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="현재총재고"
        label="현재총재고"
        placeholder="Enter value"
        position="center"
        size={67.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="360db"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="매장재고"
        label="매장재고"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="592b9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="창고재고"
        label="창고재고"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="ba098"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="업체재고"
        label="업체재고"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="65763"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="리오더 납기일"
        label="리오더 납기일"
        placeholder="Enter value"
        position="center"
        size={81.65625}
        summaryAggregationMode="none"
      />
      <Column
        id="901e0"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="판매 마감일"
        label="판매 마감일"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="01858"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="기준일~판매마감일"
        label="기준일 판매마감일"
        placeholder="Enter value"
        position="center"
        size={102.40625}
        summaryAggregationMode="none"
      />
      <Column
        id="47a70"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="기준일~마감일 예상 판매량"
        label="기준일 마감일 예상 판매량"
        placeholder="Enter value"
        position="center"
        size={140.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="6598b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="부족 수량"
        label="부족 수량"
        placeholder="Enter value"
        position="center"
        size={60.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="0d3b8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 수량"
        label="리오더 수량"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="08130"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 TAG가"
        label="리오더 tag가"
        placeholder="Enter value"
        position="center"
        size={79.328125}
        summaryAggregationMode="none"
      />
      <Column
        id="1512e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 원가"
        label="리오더 원가"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="54d7b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 배수"
        label="리오더 배수"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="128a8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 납기일~판매 마감일"
        label="리오더 납기일 판매 마감일"
        placeholder="Enter value"
        position="center"
        size={140.296875}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          pluginId="mainTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="refresh"
          pluginId="mainTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Table
      id="reviewTable"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ exportReorderDataToExcel.data.reviewTableData }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      dynamicColumnsEnabled={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="true"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="4153e"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품번"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="489a8"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="컬러명"
        label="컬러명"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="6dd0f"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품명"
        label="품명"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="d7c4d"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="성장률(%)"
        label="성장률"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="82a65"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리드타임(일)"
        label="리드타임 일"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="af0dd"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="기준일"
        label="기준일"
        placeholder="Enter value"
        position="center"
        size={93.75}
        summaryAggregationMode="none"
      />
      <Column
        id="48de5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="누적 판매량"
        label="누적 판매량"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="4bd3a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="최근 7일 판매량"
        label="최근 7 일 판매량"
        placeholder="Enter value"
        position="center"
        size={95.25}
        summaryAggregationMode="none"
      />
      <Column
        id="fe233"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="생산팀 메모"
        label="생산팀 메모"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="23b3f"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="MD 메모"
        label="Md 메모"
        placeholder="Enter value"
        position="center"
        size={58.25}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          pluginId="reviewTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="refresh"
          pluginId="reviewTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Table
      id="sizeTable"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ exportReorderDataToExcel.data.sizeTableData }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      dynamicColumnsEnabled={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="true"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="4153e"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품번"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="489a8"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="컬러명"
        label="컬러명"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="6dd0f"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품명"
        label="품명"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="d7c4d"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="성장률(%)"
        label="성장률"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="82a65"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리드타임(일)"
        label="리드타임 일"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="af0dd"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="기준일"
        label="기준일"
        placeholder="Enter value"
        position="center"
        size={93.75}
        summaryAggregationMode="none"
      />
      <Column
        id="48de5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="누적 판매량"
        label="누적 판매량"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="4bd3a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="최근 7일 판매량"
        label="최근 7 일 판매량"
        placeholder="Enter value"
        position="center"
        size={95.25}
        summaryAggregationMode="none"
      />
      <Column
        id="fe233"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="생산팀 메모"
        label="생산팀 메모"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="23b3f"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="MD 메모"
        label="Md 메모"
        placeholder="Enter value"
        position="center"
        size={58.25}
        summaryAggregationMode="none"
      />
      <Column
        id="9d0b1"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="컬러코드"
        label="컬러코드"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="42a9b"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="생산업체"
        label="생산업체"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="b25eb"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="TAG가"
        label="Tag가"
        placeholder="Enter value"
        position="center"
        size={47.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="c2da1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="원가"
        label="원가"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="b9a67"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="배수"
        label="배수"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="9500e"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="출고일"
        label="출고일"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="ee550"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="입고 수량"
        label="입고 수량"
        placeholder="Enter value"
        position="center"
        size={60.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="1bfa9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="출고 수량"
        label="출고 수량"
        placeholder="Enter value"
        position="center"
        size={60.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="102ad"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="출고율"
        label="출고율"
        placeholder="Select option"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="ff8b3"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="누적 판매율"
        label="누적 판매율"
        placeholder="Select option"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="7378b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="출고~기준일 판매일수"
        label="출고 기준일 판매일수"
        placeholder="Enter value"
        position="center"
        size={116.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="bc948"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="일 판매량"
        label="일 판매량"
        placeholder="Enter value"
        position="center"
        size={60.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="16971"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="현재총재고"
        label="현재총재고"
        placeholder="Enter value"
        position="center"
        size={67.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="360db"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="매장재고"
        label="매장재고"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="592b9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="창고재고"
        label="창고재고"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="ba098"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="업체재고"
        label="업체재고"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="65763"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="리오더 납기일"
        label="리오더 납기일"
        placeholder="Enter value"
        position="center"
        size={81.65625}
        summaryAggregationMode="none"
      />
      <Column
        id="901e0"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="판매 마감일"
        label="판매 마감일"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="01858"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="기준일~판매마감일"
        label="기준일 판매마감일"
        placeholder="Enter value"
        position="center"
        size={102.40625}
        summaryAggregationMode="none"
      />
      <Column
        id="47a70"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="기준일~마감일 예상 판매량"
        label="기준일 마감일 예상 판매량"
        placeholder="Enter value"
        position="center"
        size={140.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="6598b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="부족 수량"
        label="부족 수량"
        placeholder="Enter value"
        position="center"
        size={60.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="0d3b8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 수량"
        label="리오더 수량"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="08130"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 TAG가"
        label="리오더 tag가"
        placeholder="Enter value"
        position="center"
        size={79.328125}
        summaryAggregationMode="none"
      />
      <Column
        id="1512e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 원가"
        label="리오더 원가"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="54d7b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 배수"
        label="리오더 배수"
        placeholder="Enter value"
        position="center"
        size={71.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="128a8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 납기일~판매 마감일"
        label="리오더 납기일 판매 마감일"
        placeholder="Enter value"
        position="center"
        size={140.296875}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          pluginId="sizeTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="refresh"
          pluginId="sizeTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Table
      id="approvalTable"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ exportReorderDataToExcel.data.approvalTableData }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      dynamicColumnsEnabled={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="true"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="4153e"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품번"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="489a8"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="컬러명"
        label="컬러명"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="6dd0f"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품명"
        label="품명"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          pluginId="approvalTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="refresh"
          pluginId="approvalTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Frame>
</Screen>
