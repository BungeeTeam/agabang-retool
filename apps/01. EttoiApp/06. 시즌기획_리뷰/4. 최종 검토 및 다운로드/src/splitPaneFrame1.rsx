<SplitPaneFrame
  id="splitPaneFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden="true"
  isHiddenOnMobile={true}
  padding="8px 12px"
  position="right"
  showFooterBorder={false}
  showHeaderBorder={false}
  width="50%"
>
  <TextInput id="search_text" iconBefore="bold/interface-search" label="" />
  <Select
    id="select_category"
    data="{{var_category_list.value['season']}}"
    emptyMessage="No options"
    fallbackTextByIndex=""
    label=""
    labels="{{ item.cat_nm }}"
    labelWidth="25"
    overlayMaxHeight={375}
    placeholder="Select an option"
    showSelectionIndicator={true}
    textBefore="복종"
    value="1"
    values="{{ item.id }}"
  />
  <Button
    id="button4"
    iconBefore="bold/shopping-furniture-closet"
    style={{ ordered: [{ background: "canvas" }] }}
    text="닫기"
  >
    <Event
      event="click"
      method="hide"
      params={{ ordered: [] }}
      pluginId="splitPaneFrame1"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
  </Button>
  <Table
    id="table_items_related"
    cellSelection="none"
    clearChangesetOnSave={true}
    data="{{ get_related_item_list.data }}"
    defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
    emptyMessage="No rows found"
    enableSaveActions={true}
    rowHeight="large"
    searchTerm="{{ search_text.value }}"
    showFooter={true}
    showHeader={true}
    toolbarPosition="bottom"
  >
    <Column
      id="53602"
      alignment="center"
      format="image"
      formatOptions={{ widthType: "fit" }}
      groupAggregationMode="none"
      placeholder="Enter value"
      position="center"
      referenceId="img"
      size={69}
      summaryAggregationMode="none"
      valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg"
    />
    <Column
      id="0efe5"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="sty_cd"
      label="Sty cd"
      placeholder="Enter value"
      position="center"
      size={85.859375}
      summaryAggregationMode="none"
    />
    <Column
      id="7c3f0"
      alignment="left"
      caption="{{ currentSourceRow.sty_cd }}"
      format="string"
      groupAggregationMode="none"
      key="sty_nm"
      label="품명"
      placeholder="Enter value"
      position="center"
      size={141.28125}
      summaryAggregationMode="none"
      valueOverride="({{ currentSourceRow.year_sesn_nm_eng }}) {{ item }}"
    />
    <Column
      id="55e07"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="col_cd"
      label="Col cd"
      placeholder="Enter value"
      position="center"
      size={52.265625}
      summaryAggregationMode="none"
    />
    <Column
      id="f3770"
      alignment="center"
      format="tag"
      formatOptions={{
        automaticColors: false,
        color:
          "{{ JSON.parse(retoolContext.configVars.var_color_dict)[item] }}",
      }}
      groupAggregationMode="none"
      key="col_nm"
      label="컬러"
      placeholder="Select option"
      position="center"
      size={88.265625}
      summaryAggregationMode="none"
    />
    <Column
      id="8bbf5"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      key="fabric"
      label="소재"
      placeholder="Enter value"
      position="center"
      size={106.421875}
      summaryAggregationMode="none"
    />
    <Column
      id="923e5"
      alignment="center"
      format="button"
      formatOptions={{ variant: "solid" }}
      groupAggregationMode="none"
      label="추가"
      placeholder="Enter value"
      position="right"
      referenceId="추가"
      size={49.765625}
      summaryAggregationMode="none"
      valueOverride="+"
    >
      <Event
        event="clickCell"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="add_item"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Column>
    <Column
      id="a5921"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="item_md_category_id"
      label="Item md category ID"
      placeholder="Enter value"
      position="center"
      size={131.265625}
      summaryAggregationMode="none"
    />
    <Column
      id="44c01"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="average"
      key="sale_per"
      label="판매율(수량)"
      placeholder="Enter value"
      position="center"
      size={80.140625}
      summaryAggregationMode="none"
    />
    <Column
      id="72a47"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="tot_in_qty"
      label="입고량"
      placeholder="Enter value"
      position="center"
      size={50.40625}
      summaryAggregationMode="none"
    />
    <Column
      id="68c33"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="tot_sale_qty"
      label="판매량"
      placeholder="Enter value"
      position="center"
      size={50.40625}
      summaryAggregationMode="none"
    />
    <Column
      id="62bbc"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="average"
      key="sale_amt_per"
      label="판매율(금액)"
      placeholder="Enter value"
      position="center"
      size={78}
      summaryAggregationMode="none"
    />
    <Column
      id="52d2a"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="year_sesn_nm_eng"
      label="Year sesn nm eng"
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
        pluginId="table_items_related"
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
        pluginId="table_items_related"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </ToolbarButton>
  </Table>
</SplitPaneFrame>
