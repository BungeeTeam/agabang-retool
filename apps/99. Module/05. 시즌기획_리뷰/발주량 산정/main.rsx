<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <GlobalWidgetProp
    id="brand_code"
    description="브랜드코드 입력, 스트링으로"
    value="'07'"
  />
  <Include src="./src/drawerFrame_item_detail_new.rsx" />
  <Include src="./src/shop_sales.rsx" />
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
      brand_code="'07'"
      isGlobalWidgetContainer={true}
      margin="0"
    >
      <Module
        id="itemDetail1"
        brand_code="{{ var_brand_code.value }}"
        name="item_detail"
        pageUuid="17be4764-ecd2-11ef-8654-fbc4f3e414ec"
        sel_sty="{{ var_sty_data.value }}"
      />
      <Container
        id="container4"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="0"
        showBody={true}
      >
        <Header>
          <Text
            id="containerTitle18"
            value="#### Container title"
            verticalAlign="center"
          />
        </Header>
        <View id="9329a" viewKey="View 1">
          <NumberInput
            id="sale_per"
            currency="USD"
            format="percent"
            inputValue={0}
            label=""
            labelPosition="top"
            max={1}
            min={0}
            placeholder="Enter value"
            showSeparators={true}
            showStepper={true}
            textBefore="판매율"
            value="0.4"
          >
            <Event
              event="submit"
              method="trigger"
              params={{ ordered: [] }}
              pluginId="get_item_list"
              type="datasource"
              waitMs="0"
              waitType="debounce"
            />
          </NumberInput>
          <Include src="./src/container3.rsx" />
          <Button
            id="button3"
            iconBefore="bold/interface-search"
            text="상품찾기"
          >
            <Event
              event="click"
              method="run"
              params={{ ordered: [{ src: "container11.setHidden(false)" }] }}
              pluginId=""
              type="script"
              waitMs="0"
              waitType="debounce"
            />
          </Button>
        </View>
      </Container>
      <Text
        id="modalTitle1"
        value="### {{var_item_info.value.sty_nm}} {{var_item_info.value.col_nm}} ({{ var_item_info.value.sty_cd }}{{ var_item_info.value.col_cd }})"
        verticalAlign="center"
      />
      <Include src="./src/tabbedContainer1.rsx" />
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
      <TextInput
        id="shop_search_text"
        iconBefore="bold/interface-search"
        label=""
        labelPosition="top"
        placeholder="매장이름"
      />
      <Container
        id="stack1"
        _flexWrap={true}
        _gap="0px"
        _type="stack"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        margin="0"
        padding="0"
        showBody={true}
        showBorder={false}
        style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
      >
        <View id="05158" viewKey="View 1">
          <Include src="./src/container5.rsx" />
          <Include src="./src/container11.rsx" />
        </View>
      </Container>
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
          size={135.21875}
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
          size={65.359375}
          summaryAggregationMode="none"
        />
        <Column
          id="2a9ef"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          label="재고량"
          placeholder="Enter value"
          position="center"
          referenceId="remain"
          size={68}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.total_in_qty - currentSourceRow.total_sale_qty }}"
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
      <Text
        id="drawerTitle1"
        value="### Container title"
        verticalAlign="center"
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
          pluginId="drawerFrame_item_detail_new"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </Button>
    </ModuleContainerWidget>
  </Frame>
</App>
