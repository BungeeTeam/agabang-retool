<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <CustomAppTheme
    id="$appTheme"
    _migrated={true}
    automatic={[
      "#fde68a",
      "#eecff3",
      "#a7f3d0",
      "#bfdbfe",
      "#c7d2fe",
      "#fecaca",
      "#fcd6bb",
    ]}
    borderRadius="4px"
    canvas="#f6f6f6"
    danger="#dc2626"
    defaultFont={{
      size: "12px",
      source:
        "https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css",
      name: '"Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif',
    }}
    h1Font={{ size: "36px" }}
    h2Font={{ size: "28px" }}
    h3Font={{ size: "24px" }}
    h4Font={{ size: "18px" }}
    h5Font={{ size: "16px" }}
    h6Font={{ size: "14px" }}
    highlight="#fde68a"
    info="#3170f9"
    primary="#dd5e2c"
    secondary=""
    success="#059669"
    surfacePrimary="#ffffff"
    surfacePrimaryBorder=""
    surfaceSecondary="#ffffff"
    surfaceSecondaryBorder=""
    tertiary=""
    textDark="#0d0d0d"
    textLight="#ffffff"
    warning="#cd6f00"
  />
  <DocumentTitle id="$customDocumentTitle" value="급상승 아이템 | ET" />
  <Include src="./header.rsx" />
  <Include src="./src/drawerFrame_item_detail_new.rsx" />
  <Include src="./src/modalFrame1.rsx" />
  <Include src="./sidebar.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Text
      id="text4"
      style={{ ordered: [{ color: "rgba(13, 13, 13, 0.58)" }] }}
      value="{{base_day.value}} 기준, 지난 일주일 판매량에 비해 일 판매량이 급상승한 상품을 찾습니다"
      verticalAlign="center"
    />
    <Spacer id="spacer1" />
    <Table
      id="table_main"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ var_rise_top.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicRowHeights={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      rowHeight="small"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="d4f7f"
        alignment="center"
        format="html"
        formatOptions={{
          showUnderline: "hover",
          underlineStyle: "solid",
          widthType: "fit",
        }}
        groupAggregationMode="none"
        key="image_link"
        label="이미지"
        placeholder="Enter value"
        position="left"
        size={110.96875}
        summaryAggregationMode="none"
        valueOverride={
          '<img src={{item}} style="width: 50px; border-radius:4px;">'
        }
      />
      <Column
        id="c42d4"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sty_cd"
        label="스타일코드"
        placeholder="Enter value"
        position="left"
        size={82.1875}
        summaryAggregationMode="none"
      />
      <Column
        id="fe4d6"
        alignment="center"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="cat_nm"
        label="복종"
        placeholder="Select option"
        position="left"
        size={94}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="6549f"
        alignment="left"
        caption="{{currentSourceRow.sty_cd}}"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="상품명"
        placeholder="Enter value"
        position="left"
        size={151.359375}
        summaryAggregationMode="none"
      />
      <Column
        id="5c9b5"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="score"
        label="급상승 점수"
        placeholder="Enter value"
        position="center"
        size={95.640625}
        summaryAggregationMode="none"
        textColor="{{ theme.warning }}"
      />
      <Column
        id="0fa32"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="diff_per"
        label="상승률"
        placeholder="Enter value"
        position="center"
        size={83.40625}
        summaryAggregationMode="none"
        textColor="rgb(255, 102, 102)"
      />
      <Column
        id="89a7f"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="yesterday_sales_qty"
        label="판매량(일간)"
        placeholder="Enter value"
        position="center"
        size={103.75}
        summaryAggregationMode="none"
      />
      <Column
        id="391b1"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="avg_week_sales_qty"
        label="판매량(7일 평균)"
        placeholder="Enter value"
        position="center"
        size={114.625}
        summaryAggregationMode="none"
      />
      <Column
        id="e1f03"
        alignment="center"
        format="html"
        formatOptions={{ widthType: "fit" }}
        groupAggregationMode="none"
        key="src"
        label="그래프(최근 7일)"
        placeholder="Enter value"
        position="center"
        size={138.46875}
        summaryAggregationMode="none"
        valueOverride={
          '<img src={{item}} style="width: {{650 * 0.13}}px; height:{{300 * 0.13}}px; \nmin-width: {{650 * 0.13}}px; border-radius:4px;"></img>'
        }
      />
      <Column
        id="78465"
        alignment="left"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="progress"
        formatOptions={{
          min: 0,
          max: "1",
          positiveTrend: "",
          negativeTrend: "",
        }}
        groupAggregationMode="average"
        key="sale_per"
        label="소진율"
        placeholder="Enter value"
        position="center"
        size={61}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      />
      <Column
        id="6d8d9"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sale_per"
        placeholder="Enter value"
        position="center"
        size={64}
        summaryAggregationMode="none"
      />
      <Column
        id="82841"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_sale_qty"
        label="누적 판매량"
        placeholder="Enter value"
        position="center"
        size={72}
        summaryAggregationMode="none"
      />
      <Column
        id="da656"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="누적 입고량"
        placeholder="Enter value"
        position="center"
        size={93}
        summaryAggregationMode="none"
      />
      <Column
        id="37b57"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tag_prce"
        label="TAG 가격(원)"
        placeholder="Enter value"
        position="center"
        size={88.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="6d3d1"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        size={15.96875}
        summaryAggregationMode="none"
      />
      <Column
        id="21b11"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="stddev_week_sales_qty"
        label="Stddev week sales qty"
        placeholder="Enter value"
        position="center"
        size={140.5625}
        summaryAggregationMode="none"
      />
      <Column
        id="637a6"
        alignment="left"
        format="multilineString"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="daily_sales_qty_array"
        label="일간 판매현황"
        placeholder="Enter value"
        position="center"
        size={1139.78125}
        summaryAggregationMode="none"
        valueOverride="{{item}}"
      />
      <Column
        id="ef46d"
        alignment="left"
        cellTooltipMode="overflow"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="sales"
        label="Sales"
        placeholder="Enter value"
        position="center"
        size={341.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="e4f6b"
        alignment="left"
        cellTooltipMode="overflow"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="xs"
        label="Xs"
        placeholder="Enter value"
        position="center"
        size={445}
        summaryAggregationMode="none"
      />
      <Column
        id="a734e"
        alignment="left"
        cellTooltipMode="overflow"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="ys"
        label="Ys"
        placeholder="Enter value"
        position="center"
        size={459.71875}
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
          pluginId="table_main"
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
          pluginId="table_main"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="var_sty_data"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</App>
