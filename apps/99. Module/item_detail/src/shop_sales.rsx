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
      placeholder="매장이름"
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
    <Table
      id="shop_sales_table"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ filter_out_handover_shops.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
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
        size={189.765625}
        summaryAggregationMode="none"
      />
      <Column
        id="ae266"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="A.shop_cd"
        label="매장코드"
        placeholder="Enter value"
        position="center"
        size={77}
        summaryAggregationMode="none"
      />
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
        size={131.140625}
        summaryAggregationMode="none"
        valueOverride="{{ item.toFixed() }}%"
      />
      <Column
        id="ebab0"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total_in_qty"
        label="입고량"
        placeholder="Enter value"
        position="center"
        size={95.140625}
        summaryAggregationMode="sum"
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
        size={47.140625}
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
        size={100}
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
        size={100}
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
        size={100}
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
        size={100}
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
        size={100}
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
        event="selectRow"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_shop_in_graph_data"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Body>
</ModalFrame>
