<DrawerFrame
  id="brDrawerFrame"
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
    <Text
      id="drawerTitle2"
      value="### {{ selectedRow.value.br_type }} 매장목록"
      verticalAlign="center"
    />
    <Button
      id="drawerCloseButton2"
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
        pluginId="brDrawerFrame"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Table
      id="typeStatTbl3"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ periodSalesByBrShop.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      heightType="auto"
      hidden=""
      primaryKeyColumnId="2536b"
      rowBackgroundColor=""
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      showSummaryRow={true}
      style={{ headerBackground: "#f5f5f5" }}
    >
      <Column
        id="2536b"
        alignment="right"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_cd"
        label="Shop cd"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="e7dc2"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="center"
        size={151.203125}
        summaryAggregationMode="none"
      />
      <Column
        id="b17a1"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        cellTooltip="{{ item }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2025"
        label="25실적"
        placeholder="Enter value"
        position="center"
        size={91.3125}
        summaryAggregationMode="sum"
      >
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="testQuery"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="8a9cb"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2024"
        label="24실적"
        placeholder="Enter value"
        position="center"
        size={90.53125}
        summaryAggregationMode="sum"
      />
      <Column
        id="36681"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="24대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="24대비신장율"
        size={82.671875}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride={'{{ self.data[i]["2025"] / self.data[i]["2024"] - 1 }}'}
      />
      <Column
        id="e0872"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="24대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="24대비신장액"
        size={82.671875}
        summaryAggregationMode="sum"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2024"]}}'}
      />
      <Column
        id="ba994"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2023"
        label="23실적"
        placeholder="Enter value"
        position="center"
        size={78.65625}
        summaryAggregationMode="sum"
      />
      <Column
        id="2783a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="23대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="23대비신장율"
        size={82.796875}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride={'{{ self.data[i]["2025"] / self.data[i]["2023"] - 1 }}'}
      />
      <Column
        id="cc18b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="23대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="23대비N신장액"
        size={82.796875}
        summaryAggregationMode="sum"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2023"]}}'}
      />
      <Column
        id="68cbc"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        label="biz_cd"
        placeholder="Enter value"
        position="center"
        referenceId="biz_cd"
        size={52.359375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["biz_cd"] }}'}
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
          pluginId="typeStatTbl3"
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
          pluginId="typeStatTbl3"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</DrawerFrame>
