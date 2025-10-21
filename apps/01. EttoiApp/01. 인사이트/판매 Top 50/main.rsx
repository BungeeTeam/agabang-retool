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
  <DocumentTitle id="$customDocumentTitle" value="판매 Top50 | ET" />
  <Include src="./header.rsx" />
  <Include src="./src/drawerFrame_item_detail_new.rsx" />
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
    <Table
      id="table_main"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ var_best_50_result.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicRowHeights={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="05ed8"
      rowHeight="small"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      style={{}}
      toolbarPosition="bottom"
    >
      <Column
        id="05ed8"
        alignment="right"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="idx"
        label="Idx"
        placeholder="Enter value"
        position="center"
        size={32.8125}
        summaryAggregationMode="none"
      />
      <Column
        id="bb4a5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_rank"
        placeholder="Enter value"
        position="left"
        size={43.734375}
        summaryAggregationMode="none"
      />
      <Column
        id="66f93"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="rank_diff"
        placeholder="Enter value"
        position="left"
        size={84.234375}
        statusIndicatorOptions={{
          manualData: [
            {
              ordered: [
                { showWhen: "{{ item > 0 }}" },
                { label: "{{ Math.abs(item) }}" },
                { color: "rgba(219, 37, 37, 0.1)" },
                { icon: "bold/interface-arrows-up-alternate" },
              ],
            },
            {
              ordered: [
                { showWhen: "{{ item < 0 }}" },
                { label: "{{ Math.abs(item) }}" },
                { color: "rgba(50, 113, 250, 0.1)" },
                { icon: "bold/interface-arrows-down-alternate" },
              ],
            },
            {
              ordered: [
                { showWhen: "{{ item == 0 }}" },
                { label: "-" },
                { color: "rgba(0, 0, 0, 0.1)" },
                { icon: "" },
              ],
            },
          ],
        }}
        summaryAggregationMode="none"
        textColor="rgba(0, 0, 0, 0.01)"
      />
      <Column
        id="ce425"
        alignment="left"
        backgroundColor="{{ theme.canvas }}"
        format="image"
        formatOptions={{
          showUnderline: "hover",
          underlineStyle: "solid",
          widthType: "fit",
        }}
        groupAggregationMode="none"
        key="sty_cd"
        label="제품사진"
        placeholder="Enter value"
        position="left"
        size={70}
        summaryAggregationMode="none"
        valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{item}}.jpg"
      >
        <Event
          event="clickCell"
          method="openUrl"
          params={{ ordered: [{ url: "{{ item }}" }] }}
          pluginId=""
          type="util"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="6ac2e"
        alignment="left"
        backgroundColor="{{ theme.canvas }}"
        caption="{{currentSourceRow.sty_cd}}"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="품명"
        placeholder="Enter value"
        position="left"
        size={124.03125}
        summaryAggregationMode="none"
        valueOverride="{{item}}"
      />
      <Column
        id="5a3f0"
        alignment="center"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="col_nm"
        label="색상"
        optionList={{
          mode: "mapped",
          mappedData: "{{ get_color_hex_list.data }}",
          valueByIndex: "{{ item.col_nm }}",
          colorByIndex: "{{ item.hex_code }}",
        }}
        placeholder="Select option"
        position="left"
        size={98.765625}
        summaryAggregationMode="none"
      />
      <Column
        id="7929e"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="tag"
        formatOptions={{ automaticColors: false }}
        groupAggregationMode="sum"
        key="year_cd"
        label="연도"
        optionList={{
          mode: "mapped",
          mappedData: "{{ def_year_code.value }}",
          valueByIndex: "{{item.code}}",
          labelByIndex: "{{item.year}}",
        }}
        placeholder="Select option"
        position="center"
        size={94.140625}
        summaryAggregationMode="none"
      />
      <Column
        id="f039d"
        alignment="center"
        editableOptions={{ showStepper: true, allowCustomValue: false }}
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="sum"
        key="sesn_cd"
        label="시즌"
        optionList={{
          mode: "manual",
          manualData: [
            {
              ordered: [
                { value: '"1"' },
                { label: "SP" },
                { color: "rgb(255, 221, 238)" },
              ],
            },
            {
              ordered: [
                { value: '"3"' },
                { label: "SM" },
                { color: "rgb(221, 238, 255)" },
              ],
            },
            {
              ordered: [
                { value: '"5"' },
                { label: "FA" },
                { color: "rgb(255, 238, 221)" },
              ],
            },
            {
              ordered: [
                { value: '"7"' },
                { label: "WT" },
                { color: "rgb(238, 238, 255)" },
              ],
            },
            {
              ordered: [
                { value: '"0"' },
                { label: "무시즌" },
                { color: "{{ theme.canvas }}" },
              ],
            },
          ],
        }}
        placeholder="Select option"
        position="center"
        size={70.78125}
        summaryAggregationMode="none"
      />
      <Column
        id="896c7"
        alignment="center"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="cat_nm"
        label="카테고리"
        placeholder="Select option"
        position="center"
        size={82.109375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="fd5b2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tag_prce"
        label="최초가"
        placeholder="Enter value"
        position="center"
        size={69.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="f360d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cum_in_qty"
        label="누적 입고량"
        placeholder="Enter value"
        position="center"
        size={95.703125}
        summaryAggregationMode="none"
      />
      <Column
        id="a4282"
        alignment="right"
        backgroundColor="{{ theme.canvas }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_cur"
        label="판매량"
        placeholder="Enter value"
        position="center"
        size={84.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="1902b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_prev"
        label="이전 판매량"
        placeholder="Enter value"
        position="center"
        size={91.703125}
        summaryAggregationMode="none"
      />
      <Column
        id="382c8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="inc_rate"
        label="상승률"
        placeholder="Enter value"
        position="center"
        size={88.875}
        summaryAggregationMode="none"
      />
      <Column
        id="4c3c9"
        alignment="right"
        backgroundColor="{{ theme.canvas }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cum_sale_qty"
        label="누적 판매량"
        placeholder="Enter value"
        position="center"
        size={89.703125}
        summaryAggregationMode="none"
      />
      <Column
        id="ddfe3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="tot_sale_rate"
        label="누적 판매율"
        placeholder="Enter value"
        position="center"
        size={83.703125}
        summaryAggregationMode="none"
      />
      <Column
        id="bda0d"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="d8522"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sty_cd"
        label="sty_cd"
        placeholder="Enter value"
        position="left"
        size={82.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="3f89f"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="year_cd"
        label="Year cd"
        placeholder="Select option"
        position="center"
        size={57.578125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="c07db"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="col_cd"
        label="Col cd"
        placeholder="Enter value"
        position="center"
        size={51.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="0cd35"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="sale_rank_prev"
        label="Sale rank prev"
        placeholder="Enter value"
        position="center"
        size={94.78125}
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
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="drawerFrame_item_detail_new"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</App>
