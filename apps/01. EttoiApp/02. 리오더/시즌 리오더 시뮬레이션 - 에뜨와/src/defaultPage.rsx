<Screen
  id="defaultPage"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title="Default Page"
  urlSlug=""
>
  <SqlQuery
    id="reorderSimulation"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("../lib/reorderSimulation.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenPageLoadsDelay="1000"
    showFailureToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
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
    tableName="reorder_season_simulation_targets"
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
  <State id="selectedReorderItems" value="" />
  <JavascriptQuery
    id="saveColorEdits"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("../lib/saveColorEdits.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <SqlQueryUnified
    id="insertMDDecisionsToDB"
    actionType="BULK_INSERT"
    editorMode="gui"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    records={
      "{{ selectedReorderItems.value.map(item => ({\n  // selectedReorderItems.value에서 값을 가져오는 컬럼들\n  col_nm: item.reference_info?.col_nm || null,\n  col_cd: item.reference_info?.col_cd || null,\n  sty_nm: item.reference_info?.sty_nm || null,\n  group_id: item.reference_info?.groupId || null,\n  sty_cd: item.reference_info?.sty_cd || null,\n  tag_price: item.production_info?.['TAG가'] || null,\n  cost_price: item.production_info?.['원가'] || null,\n  sh_stck_qty: item.production_info?.['매장재고'] || null,\n  total_reorder_count: item.reorder_info?.['부족 수량'] || null,\n  tot_in_qty: item.production_info?.['입고 수량'] || null,\n  tot_sale_qty: item.sales_performance?.['누적 판매량'] || null,\n  final_reorder_qty: JSON.stringify(item.size_reorder_info?.map(size => size.reorder_qty) || []), // 배열을 JSON 문자열로 변환\n  current_stock_qty: item.reorder_info?.['현재 총재고'] || null,\n  wh_stck_qty: item.production_info?.['창고재고'] || null,\n  size_cd: JSON.stringify(item.size_reorder_info?.map(size => size.size_cd) || []), // 배열을 JSON 문자열로 변환\n  size_nm: JSON.stringify(item.size_reorder_info?.map(size => size.size_nm) || []), // 배열을 JSON 문자열로 변환\n  sale_rate: item.sales_performance?.['누적 판매율(입고 기준)'] || null,\n  expected_sales: item.reorder_info?.['기준일~마감일 예상 판매량'] || null,\n  lead_time_days: item.reorder_info?.['리드타임(일)'] || null,\n  avg_daily_sales: item.sales_performance?.['일 판매량'] || null,\n  expected_sales_period: item.reorder_info?.['기준일~판매 마감일'] || null,\n  expected_sales_qty: item.reorder_info?.['기준일~마감일 예상 판매량'] || null,\n  modifiable_cost_price: item.production_info?.['리오더 원가'] || null,\n  price_multiple: item.production_info?.['배수'] || null,\n  has_sheet_data: item.reference_info?.has_sheet_data || null,\n  note: item.production_info?.['생산팀 메모'] || null,\n  price_reorder_multiple: item.production_info?.['리오더 배수'] || null,\n  lead_time: item.reorder_info?.['리드타임(일)'] || null,\n  created_by: current_user.email,\n  created_at: new Date(),\n  md_memo: item.reorder_info?.['MD 메모'] === \"(메모 없음)\" ? \"\" : (item.reorder_info?.['MD 메모'] || null),\n  type: 'season',\n\n  // selectedReorderItems.value에 없어 null로 저장되는 컬럼들\n  reorder_recommending_status: null,\n  series_name: null,\n  cust_nm: null,\n  fabric: null,\n  small_cat: null,\n  avg_monthly_sales_d_180: null,\n  cust_cd: null,\n  shop_gini: null,\n  estimated_stock: null,\n  status_d_30: null,\n  middle_cat: null,\n  large_cat: null,\n  avg_monthly_sales_d_30: null,\n  avg_monthly_sales_d_365: null,\n  days_until_out_of_stock_d_30: null,\n  days_until_out_of_stock_d_180: null,\n  emergency_stock: null,\n  target_sale_rate: null,\n  status_d_180: null,\n  status_d_365: null,\n  moq: null,\n  effective_monthly_sales: null,\n  avg_monthly_sales: null,\n  expected_supply_qty: null,\n  days_until_out_of_stock_d_365: null,\n  exclude_button: null,\n  expected_sales_rate: null,\n  total_expected_sales_qty: null,\n  manufacturer_stock: null,\n  estimated_final_sale_rate: null,\n  estimated_ending_stock: null\n})) }}"
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
  <State id="temp" />
  <JavascriptQuery
    id="InsertManufactoringTeamInputData"
    notificationDuration={4.5}
    query={include("../lib/InsertManufactoringTeamInputData.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
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
          { data: "{{ rawColorTable.data }}" },
          {
            fileName:
              "excel-ETTOI_REORDER_COLOR_RAW_{{moment(new Date()).format('YYYY-MM-DD')}}",
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
          { data: "{{ rawSizeTable.data }}" },
          {
            fileName:
              "excel-ETTOI_REORDER_SIZE_RAW_{{moment(new Date()).format('YYYY-MM-DD')}}",
          },
        ],
      }}
      pluginId=""
      type="util"
      waitMs="0"
      waitType="debounce"
    />
  </JavascriptQuery>
  <State id="var_brand_code" value="'07'" />
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
    <Table
      id="rawColorTable"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ exportReorderDataToExcel.data.rawColorTableData }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      dynamicColumnsEnabled={true}
      emptyMessage="No rows found"
      hidden="true"
      rowHeight="xsmall"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="38c13"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품명"
        label="품명"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="e14e3"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="컬러명"
        label="컬러명"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="4447c"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품번"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="710b4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="컬러코드"
        label="컬러코드"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="291ae"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="생산업체"
        label="생산업체"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="997fc"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="TAG가"
        label="Tag가"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="e1383"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="원가"
        label="원가"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="bc631"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="배수"
        label="배수"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="55303"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="출고일"
        label="출고일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="c6264"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="입고 수량"
        label="입고 수량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="63540"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="출고 수량"
        label="출고 수량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="81883"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="출고율"
        label="출고율"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="6debf"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="기준일"
        label="기준일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="c7ad9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="누적 판매량"
        label="누적 판매량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="ad07c"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="누적 판매율"
        label="누적 판매율"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="eb049"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="출고~기준일 판매일수"
        label="출고 기준일 판매일수"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="f37fa"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="일 판매량"
        label="일 판매량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ item.toFixed(0) }}"
      />
      <Column
        id="a0ae6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="최근 7일 판매량"
        label="최근 7일 판매량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ item.toFixed(0) }}"
      />
      <Column
        id="44e1a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="현재총재고"
        label="현재총재고"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="e8107"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="매장재고"
        label="매장재고"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="ee3a8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="창고재고"
        label="창고재고"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="8fad1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="업체재고"
        label="업체재고"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="f1c5a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리드타임(일)"
        label="리드타임 일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="9e53b"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="리오더 납기일"
        label="리오더 납기일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="b483e"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="판매 마감일"
        label="판매 마감일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="c6102"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="기준일~판매마감일"
        label="기준일 판매마감일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="1d9c8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="기준일~마감일 예상 판매량"
        label="기준일 마감일 예상 판매량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="2843e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="부족 수량"
        label="부족 수량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="7e43c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 수량"
        label="리오더 수량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="6f2f2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 TAG가"
        label="리오더 tag가"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="05ba5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 원가"
        label="리오더 원가"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="82f8a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 배수"
        label="리오더 배수"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="83d79"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="성장률(%)"
        label="성장률"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="cf154"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 납기일~판매 마감일"
        label="리오더 납기일 판매 마감일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="71b6b"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="생산팀 메모"
        label="생산팀 메모"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="7dea8"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="MD 메모"
        label="Md 메모"
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
          pluginId="rawColorTable"
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
          pluginId="rawColorTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Table
      id="reviewColorTable"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ exportReorderDataToExcel.data.reviewColorTableData }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      dynamicColumnsEnabled={true}
      emptyMessage="No rows found"
      hidden="true"
      rowHeight="xsmall"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="2071b"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품번"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="51ca1"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="컬러명"
        label="컬러명"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="3eecd"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품명"
        label="품명"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="ca808"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="생산처"
        label="생산처"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="dd0cb"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="판가(TAG가)"
        label="판가 tag가"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="0c4de"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="수량(pcs)"
        label="수량 pcs"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="7b347"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="금액"
        label="금액"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="a7ccb"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="성장률(%)"
        label="성장률"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="8bded"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리드타임(일)"
        label="리드타임 일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="96925"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="납기일"
        label="납기일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="f3842"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="기준일"
        label="기준일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="b51bc"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="누적 판매량"
        label="누적 판매량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="9d31b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="최근 7일 판매량"
        label="최근 7일 판매량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ item.toFixed(0) }}"
      />
      <Column
        id="091c0"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="생산팀 메모"
        label="생산팀 메모"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="eef84"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="MD 메모"
        label="Md 메모"
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
          pluginId="reviewColorTable"
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
          pluginId="reviewColorTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Table
      id="rawSizeTable"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ exportReorderDataToExcel.data.rawSizeTableData }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      dynamicColumnsEnabled={true}
      emptyMessage="No rows found"
      hidden="true"
      rowHeight="xsmall"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="a53af"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="품명"
        label="품명"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="8a9f1"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="컬러명"
        label="컬러명"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="f9a79"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품번"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="eaee3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="컬러 코드"
        label="컬러 코드"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="64901"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="사이즈명"
        label="사이즈명"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="9b55b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="입고량"
        label="입고량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="18792"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="입고율"
        label="입고율"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="9139d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="출고량"
        label="출고량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="084b9"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="출고율"
        label="출고율"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="cb08a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="판매량"
        label="판매량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="0ad18"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="판매비"
        label="판매비"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="ae1b0"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="출고율-판매비"
        label="출고율 판매비"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="d931a"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="판매율"
        label="판매율"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="d2da2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="판매 마감일까지 일수"
        label="판매 마감일까지 일수"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="9dbed"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="예상 판매량"
        label="예상 판매량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="b5ec5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="현재 총재고"
        label="현재 총재고"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="8f92c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="부족 수량"
        label="부족 수량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="91d9e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="리오더 수량"
        label="리오더 수량"
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
          pluginId="rawSizeTable"
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
          pluginId="rawSizeTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Table
      id="reviewSizeTable"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ exportReorderDataToExcel.data.reviewSizeTableData }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      dynamicColumnsEnabled={true}
      emptyMessage="No rows found"
      hidden="true"
      rowHeight="xsmall"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="a3efe"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품번"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={79.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="22120"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="컬러명"
        label="컬러명"
        placeholder="Select option"
        position="center"
        size={74.359375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="6298b"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="품명"
        label="품명"
        placeholder="Select option"
        position="center"
        size={104.65625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="04956"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="납기일"
        label="납기일"
        placeholder="Enter value"
        position="center"
        size={90.59375}
        summaryAggregationMode="none"
      />
      <Column
        id="3c99b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="42"
        label="42"
        placeholder="Enter value"
        position="center"
        size={30.96875}
        summaryAggregationMode="none"
      />
      <Column
        id="70e5a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="44"
        label="44"
        placeholder="Enter value"
        position="center"
        size={31.40625}
        summaryAggregationMode="none"
      />
      <Column
        id="07d7f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="3M"
        label="3 m"
        placeholder="Enter value"
        position="center"
        size={38.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="e7412"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="6M"
        label="6 m"
        placeholder="Enter value"
        position="center"
        size={38.6875}
        summaryAggregationMode="none"
      />
      <Column
        id="85863"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="12M"
        label="12 m"
        placeholder="Enter value"
        position="center"
        size={42.640625}
        summaryAggregationMode="none"
      />
      <Column
        id="d4949"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="TTL"
        label="Ttl"
        placeholder="Enter value"
        position="center"
        size={46.609375}
        summaryAggregationMode="none"
      />
      <Column
        id="8195e"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="비고"
        label="비고"
        placeholder="Enter value"
        position="center"
        size={36.765625}
        summaryAggregationMode="none"
      />
      <Column
        id="3f825"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="7-8"
        label="7 8"
        placeholder="Enter value"
        position="center"
        size={46.609375}
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
          pluginId="reviewSizeTable"
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
          pluginId="reviewSizeTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
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
      showHeader={true}
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
          showFooter={true}
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
                  id="text40"
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
            <Button
              id="button8"
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
                    value="#### {{item.reference_info.sty_nm}} ({{ item.reference_info.col_nm }}) - {{item.reference_info.sty_cd}}{{  item.reference_info.col_cd }}"
                    verticalAlign="center"
                  />
                  <Button
                    id="button1"
                    horizontalAlign="right"
                    iconBefore="bold/interface-remove-circle"
                    style={{
                      ordered: [{ background: "rgba(216, 216, 216, 1)" }],
                    }}
                    text="리오더 대상에서 제외"
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
                      <Include src="./container4.rsx" />
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
                          size={47.109375}
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
                          size={47.109375}
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
                          size={47.109375}
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
            <Button
              id="button3"
              heightType="auto"
              text="리오더 내역 저장 & 엑셀 다운로드"
            >
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
  </Frame>
</Screen>
