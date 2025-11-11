<Container
  id="container2"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  margin="0"
  padding="0"
  showBody={true}
  style={{ ordered: [{ borderRadius: "0px" }] }}
>
  <Header>
    <Text id="containerTitle2" value="##### 2025" verticalAlign="center" />
  </Header>
  <View id="94bf5" viewKey="View 1">
    <Table
      id="table2"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ var_week_data.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      margin="0"
      rowHeight="xsmall"
      showBorder={true}
      showHeader={true}
      style={{
        borderRadius: "0px",
        border: "#ffffff",
        rowSeparator: "#e0e0e0",
      }}
      toolbarPosition="bottom"
    >
      <Column
        id="bbef4"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="type"
        label="타입"
        placeholder="Select option"
        position="center"
        size={89}
        valueOverride="{{ item==='new' ? '신상' : '이월' }}"
      />
      <Column
        id="a7f06"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sean_01_cd"
        label="Sean 01 cd"
        placeholder="Enter value"
        position="center"
        size={100}
      />
      <Column
        id="f4a8d"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sean_01_nm"
        label="시즌상품(2025)"
        placeholder="Enter value"
        position="center"
        size={119}
      />
      <Column
        id="05219"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sean_01_tot"
        label="상품매출(2025)"
        placeholder="Enter value"
        position="center"
        size={99}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="391f5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sean_01_rate"
        label="매출 점유율(2025)"
        placeholder="Enter value"
        position="center"
        size={136}
        valueOverride="{{ item.toFixed(2) }}"
      />
      <Column
        id="fe7c0"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sean_02_cd"
        label="Sean 02 cd"
        placeholder="Enter value"
        position="center"
        size={100}
      />
      <Column
        id="ea990"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sean_02_nm"
        label="시즌상품(2024)"
        placeholder="Enter value"
        position="center"
        size={133}
      />
      <Column
        id="5a783"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sean_02_tot"
        label="상품매출(2024)"
        placeholder="Enter value"
        position="center"
        size={113}
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="be9fe"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sean_02_rate"
        label="매출 점유율(2024)"
        placeholder="Enter value"
        position="center"
        size={135}
        valueOverride="{{ item.toFixed(2) }}"
      />
      <Column
        id="727a3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sean_03_pos"
        label="상품매출(증감)"
        placeholder="Enter value"
        position="center"
        size={100}
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="4f7d2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sean_03_rate"
        label="신장율(증감)"
        placeholder="Enter value"
        position="center"
        size={100}
        valueOverride="{{ item.toFixed(2) }}"
      />
      <Column
        id="95020"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        size={100}
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
          pluginId="table2"
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
          pluginId="table2"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text id="text3" value="**소계**" verticalAlign="center" />
    <Table
      id="table3"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ var_week_result.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      margin="0"
      rowHeight="xsmall"
      showBorder={true}
      showHeader={true}
      style={{ border: "rgb(224, 224, 224)" }}
      toolbarPosition="bottom"
    >
      <Column
        id="d76da"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="type"
        label="타입"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ item==='new' ? '신상' : (item === 'old' ? '이월' : '') }}"
      />
      <Column
        id="b8bdc"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sean_01_cd"
        label="Sean 01 cd"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="a5412"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sean_01_nm"
        label="소계(2025)"
        placeholder="Enter value"
        position="center"
        size={116}
        summaryAggregationMode="none"
      />
      <Column
        id="3105d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sean_01_tot"
        label="상품매출(2025)"
        placeholder="Enter value"
        position="center"
        size={95}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed() }}"
      />
      <Column
        id="d4bdf"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sean_01_rate"
        label="매출 점유율(2025)"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="728f5"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sean_02_cd"
        label="Sean 02 cd"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="96192"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sean_02_nm"
        label="상품 시즌(2024)"
        placeholder="Enter value"
        position="center"
        size={129}
        summaryAggregationMode="none"
      />
      <Column
        id="80b2e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sean_02_tot"
        label="상품매출(2024)"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed() }}"
      />
      <Column
        id="c131c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sean_02_rate"
        label="매출 점유율(2024)"
        placeholder="Enter value"
        position="center"
        size={96}
        summaryAggregationMode="none"
      />
      <Column
        id="53ae9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sean_03_pos"
        label="상품매출(증감)"
        placeholder="Enter value"
        position="center"
        size={99}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed() }}"
      />
      <Column
        id="36dd5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sean_03_rate"
        label="신장율(증감)"
        placeholder="Enter value"
        position="center"
        size={105}
        summaryAggregationMode="none"
      />
      <Column
        id="e3076"
        alignment="left"
        format="string"
        groupAggregationMode="none"
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
          pluginId="table3"
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
          pluginId="table3"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text id="text4" value="**일반용품 세부**" verticalAlign="center" />
    <Table
      id="table4"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ var_goods_data.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      margin="0"
      rowHeight="xsmall"
      showBorder={true}
      showHeader={true}
      style={{
        borderRadius: "0px",
        border: "#ffffff",
        rowSeparator: "#e0e0e0",
      }}
      toolbarPosition="bottom"
    >
      <Column
        id="bbef4"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="type"
        label="타입"
        placeholder="Select option"
        position="center"
        size={96.765625}
        summaryAggregationMode="none"
        valueOverride="{{ (item ==='all' || item === '-') ? '' : item }}"
      />
      <Column
        id="a7f06"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sean_01_cd"
        label="Sean 01 cd"
        placeholder="Enter value"
        position="center"
        size={80.875}
      />
      <Column
        id="f4a8d"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sean_01_nm"
        label="상품시즌(2025)"
        placeholder="Enter value"
        position="center"
        size={115.546875}
      />
      <Column
        id="05219"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sean_01_tot"
        label="상품매출(2025)"
        placeholder="Enter value"
        position="center"
        size={93.1875}
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="391f5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sean_01_rate"
        label="매출 점유율(2025)"
        placeholder="Enter value"
        position="center"
        size={103.921875}
        valueOverride="{{ item.toFixed(2) }}"
      />
      <Column
        id="fe7c0"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sean_02_cd"
        label="Sean 02 cd"
        placeholder="Enter value"
        position="center"
        size={80.875}
      />
      <Column
        id="ea990"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sean_02_nm"
        label="상품 시즌(2024)"
        placeholder="Enter value"
        position="center"
        size={123.546875}
      />
      <Column
        id="5a783"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sean_02_tot"
        label="상품 매출(2024)"
        placeholder="Enter value"
        position="center"
        size={105.1875}
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="be9fe"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sean_02_rate"
        label="매출 점유율(2024)"
        placeholder="Enter value"
        position="center"
        size={101.921875}
        valueOverride="{{ item.toFixed(2) }}"
      />
      <Column
        id="727a3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sean_03_pos"
        label="상품매출(증감)"
        placeholder="Enter value"
        position="center"
        size={96.859375}
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="4f7d2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sean_03_rate"
        label="신장율(증감)"
        placeholder="Enter value"
        position="center"
        size={104.59375}
        valueOverride="{{ item.toFixed(2) }}"
      />
      <Column
        id="95020"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        size={16}
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
  </View>
</Container>
