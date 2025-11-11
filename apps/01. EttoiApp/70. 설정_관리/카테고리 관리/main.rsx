<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css="" />
  <DocumentTitle id="$customDocumentTitle" value="카테고리 관리 | ET" />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrame_bulk_edit.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Container
      id="container1"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
    >
      <View id="9139e" viewKey="View 1">
        <Text
          id="containerTitle1"
          value="##### 카테고리 관리"
          verticalAlign="center"
        />
        <Text
          id="text1"
          value="현재 관리되는 카테고리 리스트 입니다."
          verticalAlign="center"
        />
        <Spacer id="spacer1" />
      </View>
    </Container>
    <Table
      id="item_table"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ query_get_info.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="f9131"
      rowHeight="medium"
      rowSelection="none"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Include src="./src/item_tableExpandedRow.rsx" />
      <Column
        id="f9131"
        alignment="center"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="id"
        label="ID"
        placeholder="Enter value"
        position="center"
        size={31.125}
        summaryAggregationMode="none"
      />
      <Column
        id="570fc"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="cat_nm"
        label="카테고리명"
        placeholder="Enter value"
        position="center"
        size={72}
        summaryAggregationMode="none"
      />
      <Column
        id="d9290"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="item_code"
        label="복종"
        placeholder="Enter value"
        position="center"
        size={67.765625}
        summaryAggregationMode="none"
      />
      <Column
        id="7a35a"
        alignment="left"
        cellTooltipMode="overflow"
        format="tags"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="origin_cat_nm"
        label="기존 카테고리"
        placeholder="Select options"
        position="center"
        size={264.96875}
        summaryAggregationMode="none"
      />
      <Column
        id="8a9e6"
        alignment="left"
        cellTooltipMode="overflow"
        format="tags"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="item_nm_list"
        label="아이템 노출 순서"
        placeholder="Select options"
        position="center"
        size={109}
        summaryAggregationMode="none"
      />
      <Column
        id="bc405"
        alignment="center"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="use_yn"
        label="사용여부"
        placeholder="Select option"
        position="right"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
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
          pluginId="item_table"
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
          pluginId="item_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="save"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="update_changes"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</App>
