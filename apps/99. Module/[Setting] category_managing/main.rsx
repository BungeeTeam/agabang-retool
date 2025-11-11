<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css="" />
  <GlobalWidgetProp id="brand_code" description="브랜드코드" value="79" />
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
    <ModuleContainerWidget
      id="moduleContainer"
      backgroundColor="white"
      brand_code="79"
      isGlobalWidgetContainer={true}
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
      <Text
        id="modalTitle1"
        value="##### 📦 제품 정보 대량 변경하기"
        verticalAlign="center"
      />
      <Include src="./src/steppedContainer1.rsx" />
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
          pluginId="modalFrame_bulk_edit"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </Button>
      <Table
        id="item_table"
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ query_get_info.data }}"
        defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        groupedColumnConfig={{ expandByDefault: false }}
        rowBackgroundColor=""
        rowHeight="medium"
        rowSelection="none"
        searchTerm="{{search_text.value}}"
        showBorder={true}
        showFooter={true}
        showHeader={true}
        toolbarPosition="bottom"
      >
        <Include src="./src/item_tableExpandedRow.rsx" />
        <Column
          id="8c448"
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
          size={49.546875}
          summaryAggregationMode="none"
        />
        <Column
          id="d9290"
          alignment="center"
          editable="false"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="false"
          key="item_code"
          label="대분류 코드"
          placeholder="Enter value"
          position="center"
          size={71.28125}
          summaryAggregationMode="none"
        />
        <Column
          id="aa006"
          alignment="center"
          editable="false"
          format="string"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="large_cat"
          label="대분류"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="1e350"
          alignment="center"
          format="string"
          groupAggregationMode="none"
          key="middle_cat"
          label="중분류"
          placeholder="Enter value"
          position="center"
          size={110}
          summaryAggregationMode="none"
        />
        <Column
          id="f72a3"
          alignment="left"
          cellTooltipMode="overflow"
          format="tags"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="small_list"
          label="소분류 노출 순서"
          placeholder="Select options"
          position="center"
          size={959}
          summaryAggregationMode="none"
        />
        <Column
          id="7a35a"
          alignment="left"
          cellTooltipMode="overflow"
          format="tags"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="origin_cat_nm"
          label="기존 카테고리"
          placeholder="Select options"
          position="center"
          size={102.4375}
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
          size={108.515625}
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
    </ModuleContainerWidget>
  </Frame>
</App>
