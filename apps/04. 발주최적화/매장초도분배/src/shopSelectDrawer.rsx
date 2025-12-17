<DrawerFrame
  id="shopSelectDrawer"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 2px"
  showFooter={true}
  showHeader={true}
  showOverlay={true}
  width="60%"
>
  <Header>
    <Text
      id="drawerTitle2"
      value="### 분배 대상 매장 선정"
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
        params={{ ordered: [] }}
        pluginId="shopSelectDrawer"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Text
      id="text8"
      value="##### 매장당 초도 분배 최소 수량 "
      verticalAlign="center"
    />
    <Text
      id="text12"
      value="기획 수량이 모든 매장에 최소 수량만큼 돌아가지 못할 경우, 자동으로 최소 수량이 조절됩니다."
      verticalAlign="center"
    />
    <NumberInput
      id="minNumberInput"
      currency="USD"
      inputValue={0}
      label=""
      labelPosition="top"
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="2"
    />
    <Spacer id="spacer1" />
    <Text
      id="text13"
      value="##### 오프라인 매장 분배 비율"
      verticalAlign="center"
    />
    <Text
      id="text14"
      value="초도 기획 물량 중 오프라인 매장에 분배할 비율을 지정해 주세요."
      verticalAlign="center"
    />
    <NumberInput
      id="distRatio"
      currency="USD"
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="0.8"
    />
    <Spacer id="spacer6" />
    <Text
      id="text18"
      value="##### 특정 매장 고정 수량 설정"
      verticalAlign="center"
    />
    <Text
      id="text19"
      value="특정 매장과 수량을 설정해두면 전 상품에 대해 다른 매장보다 우선적으로 지정 수량만큼 분배가 됩니다."
      verticalAlign="center"
    />
    <Button id="button5" margin="2px 8px" text="매장 및 수량 지정하기">
      <Event
        event="click"
        method="show"
        params={{ ordered: [] }}
        pluginId="shopSelectionModal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Table
      id="table4"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopListCombined.value.filter(obj => obj.default_qty > 0) }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      primaryKeyColumnId="b9777"
      rowHeight="xsmall"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="b9777"
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
        id="71abe"
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
        id="a832f"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="default_qty"
        label="고정수량"
        placeholder="Enter value"
        position="center"
        size={57.484375}
        summaryAggregationMode="none"
      />
      <Column
        id="3834d"
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
          pluginId="table4"
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
          pluginId="table4"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Spacer id="spacer7" />
    <Text
      id="text11"
      value="##### 초도 분배를 위한 매장 선정(총 {{ shopTbl.data.filter(item => item.is_checked === true).length }}개)"
      verticalAlign="center"
    />
    <Text
      id="text9"
      value="작년 시즌에 매출이 있던 매장은 인수인계 사항을 고려해 분배 대상으로 포함 되어있습니다. 이번 시즌에 폐점으로 예상되거나, 인수인계 또는 새로 개장할 매장이나, 개업 대기(오픈대기) 중인 매장은 별도로 추가해 주셔야 합니다."
      verticalAlign="center"
    />
    <Button id="button4" margin="2px 8px" text="매장 선택 초기화">
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            { src: "await resetShopStatus.trigger()\nshopTbl.refresh()" },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="throttle"
      />
    </Button>
    <Button id="button3" margin="2px 8px" text="지난달 매출있는 매장 추가">
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            { src: "await updateShopWithRevenue.trigger()\nshopTbl.refresh()" },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="1"
        waitType="throttle"
      />
    </Button>
    <Button id="button11" margin="2px 8px" text="ERP 매장그룹으로 선택하기">
      <Event
        event="click"
        method="run"
        params={{ ordered: [{ src: "groupSelectModal.show()" }] }}
        pluginId=""
        type="script"
        waitMs="1"
        waitType="throttle"
      />
    </Button>
    <Table
      id="shopTbl"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopListCombined.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      defaultSort={[]}
      emptyMessage="No rows found"
      heightType="auto"
      includeRowInChangesetArray={true}
      primaryKeyColumnId="ec72f"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="b1fb0"
        alignment="left"
        editable="true"
        editableOptions={{ alwaysShowCheckboxes: true }}
        format="boolean"
        formatOptions={{ variant: "solid" }}
        groupAggregationMode="none"
        key="is_checked"
        label="분배대상여부"
        placeholder="Enter value"
        position="left"
        referenceId="is_checked"
        size={78.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="1c03a"
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
        size={78.84375}
        summaryAggregationMode="none"
      />
      <Column
        id="51396"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="center"
        size={148.625}
        summaryAggregationMode="none"
      />
      <Column
        id="a3f4b"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="biz_nm"
        label="사업부명"
        placeholder="Enter value"
        position="center"
        size={78.21875}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="678cc"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="유통채널명"
        placeholder="Enter value"
        position="center"
        size={67.859375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="064e7"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="team_nm"
        label="팀명"
        placeholder="Enter value"
        position="center"
        size={52.796875}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="0d430"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="user_nm"
        label="담당자명"
        placeholder="Enter value"
        position="center"
        size={57.484375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="78dd6"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="area_nm"
        label="지역명"
        placeholder="Enter value"
        position="center"
        size={47.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="ec72f"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="idx"
        label="Idx"
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
          pluginId="shopTbl"
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
          pluginId="shopTbl"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="run"
        params={{
          ordered: [
            { src: "await updateRetoolDB.trigger()\nawait shopTbl.refresh()" },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Body>
</DrawerFrame>
