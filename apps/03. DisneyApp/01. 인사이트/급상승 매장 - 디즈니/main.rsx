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
  <Include src="./header.rsx" />
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
      value="지난 일주일 판매량에 비해 일 판매량이 급상승한 매장을 찾습니다. (브랜드코드 79, {{base_day.value}} 기준)"
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
      hidden=""
      rowHeight="small"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="4bfcf"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        label="급상승 랭킹"
        placeholder="Enter value"
        position="left"
        referenceId="랭킹"
        size={70.703125}
        summaryAggregationMode="none"
        valueOverride="{{i+1}}"
      />
      <Column
        id="ad40a"
        alignment="left"
        format="markdown"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="left"
        size={165.9375}
        summaryAggregationMode="none"
        valueOverride="**{{item}}**"
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
        size={70.703125}
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
        size={48.453125}
        summaryAggregationMode="none"
        textColor="{{ theme.danger }}"
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
        size={100.5}
        summaryAggregationMode="none"
        valueOverride={
          '<img src={{item}} style="width: {{650 * 0.13}}px; height:{{300 * 0.13}}px; \nmin-width: {{650 * 0.13}}px; border-radius:4px;"></img>'
        }
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
        size={122.8125}
        summaryAggregationMode="none"
      />
      <Column
        id="8b520"
        alignment="left"
        cellTooltipMode="overflow"
        format="markdown"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="sales_info"
        label="판매상품 시즌"
        placeholder="Select options"
        position="center"
        size={142}
        summaryAggregationMode="none"
        valueOverride="{{ JSON.parse(item).map(i => `${i.year_sesn_nm_kor}(${i.sale_qty})`).join('\n') }}"
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
        size={97.734375}
        summaryAggregationMode="none"
      />
      <Column
        id="7965a"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total_week_sales_qty"
        label="일주일 총 판매량"
        placeholder="Enter value"
        position="center"
        size={77.078125}
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
        size={140.703125}
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
        size={890.09375}
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
        size={227.40625}
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
        size={227.40625}
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
        size={242.140625}
        summaryAggregationMode="none"
      />
      <Column
        id="c5fbb"
        alignment="left"
        format="html"
        groupAggregationMode="none"
        hidden="true"
        label="Column 16"
        placeholder="Enter value"
        position="center"
        referenceId="column16"
        size={199}
        summaryAggregationMode="none"
        valueOverride={
          '<div style="display: flex; align-items: center;">\n    <!-- Pie Chart -->\n    <div class="piechart" style="width: 30px; height: 30px; border-radius: 50%; background-image: conic-gradient(pink 70deg, lightblue 0 235deg, orange 0);"></div>\n\n    <!-- Legend -->\n    <div style="margin-left: 20px; display: flex; flex-direction: column; justify-content: center;">\n        <table style="border-collapse: collapse; border: none; margin: 0; padding: 0;">\n            <tr style="line-height: 1;">\n                <td style="border: none; padding: 0;"><div style="width: 10px; height: 10px; background-color: pink; border-radius: 50%;"></div></td>\n                <td style="padding-left: 5px; border: none;">[Category 1] 70%</td>\n            </tr>\n            <tr style="line-height: 1;">\n                <td style="border: none; padding: 0;"><div style="width: 10px; height: 10px; background-color: lightblue; border-radius: 50%;"></div></td>\n                <td style="padding-left: 5px; border: none;">[Category 2] 20%</td>\n            </tr>\n            <tr style="line-height: 1;">\n                <td style="border: none; padding: 0;"><div style="width: 10px; height: 10px; background-color: orange; border-radius: 50%;"></div></td>\n                <td style="padding-left: 5px; border: none;">[Category 3] 8%</td>\n            </tr>\n            <tr style="line-height: 1;">\n                <td style="border: none; padding: 0;"><div style="width: 10px; height: 10px; background-color: lightgreen; border-radius: 50%;"></div></td>\n                <td style="padding-left: 5px; border: none;">[Category 4] 3%</td>\n            </tr>\n        </table>\n    </div>\n</div>'
        }
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
    </Table>
  </Frame>
</App>
