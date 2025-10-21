<DrawerFrame
  id="drawerFrame1"
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
  width="large"
>
  <Header>
    <HTML
      id="html1"
      css={include("../lib/html1.css", "string")}
      html={include("../lib/html1.html", "string")}
    />
    <Button
      id="drawerCloseButton1"
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
        pluginId="drawerFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Table
      id="table1"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ query_get_each_item_info.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[{ object: { columnId: "3c834", direction: "asc" } }]}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      groupByColumns={[{ ordered: [{ columnId: "7a13f" }] }]}
      groupedColumnConfig={{ size: 119.140625, expandByDefault: true }}
      rowHeight="small"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="fcf55"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        hidden="true"
        key="sale_dt"
        label="Sale dt"
        placeholder="Enter value"
        position="center"
        size={91.75}
        summaryAggregationMode="none"
      />
      <Column
        id="a1fc8"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sty_cd"
        label="Sty cd"
        placeholder="Enter value"
        position="center"
        size={85.71875}
        summaryAggregationMode="none"
      />
      <Column
        id="b9a21"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="sty_nm"
        label="Sty nm"
        placeholder="Select option"
        position="center"
        size={99.390625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="67368"
        alignment="right"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="col_cd"
        label="Col cd"
        placeholder="Enter value"
        position="center"
        size={53.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="7a13f"
        alignment="left"
        editable="false"
        format="tag"
        formatOptions={{ automaticColors: false }}
        groupAggregationMode="none"
        hidden="true"
        key="col_nm"
        label="컬러"
        placeholder="Select option"
        position="center"
        size={46.40625}
        summaryAggregationMode="none"
      />
      <Column
        id="3c834"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="size_cd"
        label="Size cd"
        placeholder="Enter value"
        position="center"
        size={58.65625}
        summaryAggregationMode="none"
      />
      <Column
        id="abe57"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: false }}
        groupAggregationMode="none"
        key="size_nm"
        label="사이즈"
        placeholder="Select option"
        position="center"
        size={62.140625}
        summaryAggregationMode="none"
      />
      <Column
        id="da089"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="size_cum_in_qty"
        label="입고량"
        placeholder="Enter value"
        position="center"
        size={58.140625}
        summaryAggregationMode="none"
      />
      <Column
        id="a9e00"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="size_cum_sale_qty"
        label="판매량"
        placeholder="Enter value"
        position="center"
        size={61.140625}
        summaryAggregationMode="none"
      />
      <Column
        id="41eb5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
          padDecimal: true,
        }}
        groupAggregationMode="none"
        key="size_sale_rate"
        label="소진율"
        placeholder="Enter value"
        position="center"
        size={66.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="850fc"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
          padDecimal: true,
        }}
        groupAggregationMode="none"
        key="size_sale_rate_color"
        label="판매비중"
        placeholder="Enter value"
        position="center"
        size={65.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="41c5d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
          padDecimal: true,
        }}
        groupAggregationMode="none"
        key="in_rate"
        label="입고비중"
        placeholder="Enter value"
        position="center"
        size={60.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="b1a99"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        size={16}
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
          pluginId="table1"
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
          pluginId="table1"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</DrawerFrame>
