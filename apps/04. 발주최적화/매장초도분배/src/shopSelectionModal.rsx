<ModalFrame
  id="shopSelectionModal"
  enableFullBleed={true}
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
>
  <Header>
    <Text
      id="modalTitle1"
      value="### 특정 매장 선정 및 고정 수량 할당"
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
        pluginId="shopSelectionModal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Table
      id="defaultShopTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ formatDataAsArray(shopList.data).filter(obj =>  shopListQuery.data.shop_cd.includes(obj.shop_cd)).sort((a, b) => b.default_qty - a.default_qty) }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="da143"
      rowSelection="none"
      showBorder={true}
      showFooter={true}
      showHeader={true}
    >
      <Column
        id="da143"
        alignment="left"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="shop_cd"
        label="매장코드"
        placeholder="Enter value"
        position="center"
        size={57.484375}
        summaryAggregationMode="none"
      />
      <Column
        id="3df2a"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="center"
        size={140.453125}
        summaryAggregationMode="none"
      />
      <Column
        id="f19a9"
        alignment="left"
        format="boolean"
        groupAggregationMode="none"
        hidden="true"
        key="is_checked"
        label="Is checked"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="6bac1"
        alignment="left"
        editable={true}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="default_qty"
        label="지정 수량"
        placeholder="Enter value"
        position="center"
        size={60.5}
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
          pluginId="defaultShopTbl"
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
          pluginId="defaultShopTbl"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="save"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="updateDefaultQty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Body>
  <Footer>
    <Text
      id="text20"
      style={{ ordered: [{ color: "danger" }] }}
      value="🚨 **수량을 지정 후, 반드시 저장(save) 버튼을 눌러야 해당 사항이 반영됩니다**"
      verticalAlign="center"
    />
  </Footer>
</ModalFrame>
