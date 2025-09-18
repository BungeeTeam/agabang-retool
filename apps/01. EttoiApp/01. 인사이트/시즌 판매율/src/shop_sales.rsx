<ModalFrame
  id="shop_sales"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
  size="fullScreen"
>
  <Header>
    <Text
      id="modalTitle2"
      value="### {{var_item_info.value.sty_nm}} {{var_item_info.value.col_nm}} ({{ var_item_info.value.sty_cd }}{{ var_item_info.value.col_cd }})"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton2"
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
    />
    <Table
      id="shop_sales_table"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_shop_sales.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="78254"
      rowHeight="small"
      rowSelection="multiple"
      searchTerm="{{ shop_search_text.value }}"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="78254"
        alignment="center"
        editable={false}
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장"
        placeholder="Enter value"
        position="left"
        size={167.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="bce07"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total_sale_per"
        label="판매율"
        placeholder="Enter value"
        position="center"
        size={87.765625}
        summaryAggregationMode="none"
        valueOverride="{{ item.toFixed() }}%"
      />
      <Column
        id="ebab0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total_in_qty"
        label="입고량"
        placeholder="Enter value"
        position="center"
        size={74.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="ba9a4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total_sale_qty"
        label="판매량"
        placeholder="Enter value"
        position="center"
        size={61.359375}
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
