<ModalFrame
  id="shop_sales"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showFooter={true}
  showHeader={true}
  showOverlay={true}
  size="fullScreen"
>
  <Header>
    <Text
      id="modalTitle1"
      value="### {{sel_sty.value.sty_nm}} {{sel_sty.value.col_nm}} ({{ sel_sty.value.sty_cd }}{{ sel_sty.value.col_cd }})"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton1"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ ordered: [{ border: "transparent" }] }}
      styleVariant="outline"
    >
      <Event
        event="click"
        method="setHidden"
        params={{ ordered: [{ hidden: true }] }}
        pluginId="shop_sales"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Include src="./tabbedContainer1.rsx" />
    <TextInput
      id="shop_search_text"
      iconBefore="bold/interface-search"
      label=""
      labelPosition="top"
      placeholder="매장이름 입력 후 엔터를 눌러주세요."
    >
      <Event
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_shop_sales"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="filter_out_handover_shops"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </TextInput>
    <Text
      id="text4"
      value="ℹ️ 본 페이지의 판매율은 매장 총 입고량(물류 반품량 차감 전) 대비 판매량으로 계산됩니다."
      verticalAlign="center"
    />
    <Table
      id="shop_sales_table"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_shop_sales.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="ae266"
      rowHeight="small"
      rowSelection="multiple"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      showSummaryRow={true}
      toolbarPosition="bottom"
    >
      <Column
        id="78254"
        alignment="left"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="multilineString"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="A.shop_nm"
        label="매장"
        placeholder="Enter value"
        position="left"
        size={150.5}
        summaryAggregationMode="none"
      />
      <Column
        id="ae266"
        alignment="right"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="A.shop_cd"
        label="매장코드"
        placeholder="Enter value"
        position="center"
        size={60.6875}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="copyToClipboard"
          params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
          pluginId=""
          type="util"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="bce07"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total_sale_per"
        label="판매율"
        placeholder="Enter value"
        position="center"
        size={76.109375}
        summaryAggregationMode="none"
        valueOverride="{{ item.toFixed() }}%"
      />
      <Column
        id="ba9a4"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total_sale_qty"
        label="판매량"
        placeholder="Enter value"
        position="center"
        size={78.109375}
        summaryAggregationMode="sum"
      />
      <Column
        id="4e8bb"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cum_in_qty"
        label="총 입고량"
        placeholder="Enter value"
        position="center"
        size={103}
        summaryAggregationMode="sum"
      />
      <Column
        id="a82ef"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total_in_qty"
        label="순 입고량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="sum"
      />
      <Column
        id="74e83"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cum_rtn_qty"
        label="물류 반품량"
        placeholder="Enter value"
        position="center"
        size={102}
        summaryAggregationMode="sum"
      />
      <Column
        id="d8a8b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="br_cd"
        label="Br cd"
        placeholder="Enter value"
        position="center"
        size={44.078125}
        summaryAggregationMode="none"
      />
      <Column
        id="94b78"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="A.sty_cd"
        label="A sty cd"
        placeholder="Enter value"
        position="center"
        size={76.609375}
        summaryAggregationMode="none"
      />
      <Column
        id="dd4cd"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="A.col_cd"
        label="A col cd"
        placeholder="Enter value"
        position="center"
        size={58.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="aee96"
        alignment="left"
        cellTooltipMode="overflow"
        format="tags"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="in_trend"
        label="In trend"
        placeholder="Select options"
        position="center"
        size={57.09375}
        summaryAggregationMode="none"
      />
      <Column
        id="e59dc"
        alignment="left"
        cellTooltipMode="overflow"
        format="tags"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="sale_trend"
        label="Sale trend"
        placeholder="Select options"
        position="center"
        size={70.4375}
        summaryAggregationMode="none"
      />
      <Column
        id="e3057"
        alignment="left"
        cellTooltipMode="overflow"
        format="tags"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="sale_per_trend"
        label="Sale per trend"
        placeholder="Select options"
        position="center"
        size={91.234375}
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
                    {
                      fileName:
                        "매장데이터_{{ sel_sty.value.sty_nm }}_{{ sel_sty.value.col_nm }}_{{ sel_sty.value.sty_cd }}{{ sel_sty.value.col_cd }}",
                    },
                    { includeHiddenColumns: false },
                  ],
                },
              },
            ],
          }}
          pluginId="shop_sales_table"
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
          pluginId="shop_sales_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_shop_sales_graph_data"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_shop_sales_per_graph_data"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_shop_in_graph_data"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="deselectRow"
        method="run"
        params={{
          ordered: [
            {
              src: "get_shop_in_graph_data.trigger();\nget_shop_sales_per_graph_data.trigger();\nget_shop_sales_graph_data.trigger();",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Body>
</ModalFrame>
