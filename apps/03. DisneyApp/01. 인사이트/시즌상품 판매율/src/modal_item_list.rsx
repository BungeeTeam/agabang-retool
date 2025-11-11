<ModalFrame
  id="modal_item_list"
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
      id="modalTitle1"
      heightType="fixed"
      margin="0"
      style={{
        ordered: [
          { fontSize: "16px" },
          { fontWeight: "600" },
          { fontFamily: "Pretendard variable" },
        ],
      }}
      value="[상세 아이템 리스트]"
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
        pluginId="modal_item_list"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text17"
      margin="0"
      style={{
        ordered: [
          { fontSize: "20px" },
          { fontWeight: "500" },
          { fontFamily: "pretendard variable" },
        ],
      }}
      value="{{ var_clicked_middle_cat.value.year_nm }}년 {{ var_clicked_middle_cat.value.season_nm }} / {{ var_clicked_middle_cat.value.large_cat }} / {{ var_clicked_middle_cat.value.middle_cat }}"
      verticalAlign="center"
    />
    <Text
      id="text18"
      disableMarkdown={true}
      horizontalAlign="right"
      style={{
        ordered: [
          { fontSize: "12px" },
          { fontWeight: "500" },
          { fontFamily: "Pretendard variable" },
        ],
      }}
      value="* 조회기간: ~ {{ var_clicked_middle_cat.value.end_dt }}"
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Table
      id="item_list_table"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ formatDataAsArray(salesByColor.data).filter(i=>i.year_cd === var_clicked_middle_cat.value.year_cd  && i.large_cat === var_clicked_middle_cat.value.large_cat && i.middle_cat === var_clicked_middle_cat.value.middle_cat) }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      rowHeight="large"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="8b419"
        alignment="center"
        format="image"
        formatOptions={{ widthType: "fit" }}
        groupAggregationMode="none"
        label="제품사진"
        placeholder="Enter value"
        position="left"
        referenceId="제품사진"
        size={78}
        sortMode="disabled"
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.sty_cd?.length>0 ? `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${currentSourceRow.sty_cd}${currentSourceRow.col_cd}.jpg` : null }}"
      />
      <Column
        id="ff740"
        alignment="center"
        caption="{{ currentSourceRow.sty_cd }}"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="품명"
        placeholder="Enter value"
        position="left"
        size={145}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      />
      <Column
        id="730fc"
        alignment="center"
        format="tag"
        formatOptions={{
          automaticColors: false,
          color:
            "{{ JSON.parse(retoolContext.configVars.var_color_dict)[item] }}",
        }}
        groupAggregationMode="none"
        key="col_nm"
        label="컬러명"
        placeholder="Select option"
        position="left"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="a619a"
        alignment="center"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="small_cat"
        label="소분류"
        placeholder="Enter value"
        position="left"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="ff703"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="입고량"
        placeholder="Enter value"
        position="center"
        size={91}
        summaryAggregationMode="none"
      />
      <Column
        id="352f8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        label="재고량"
        placeholder="Enter value"
        position="center"
        referenceId="inven_qty"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_in_qty-currentSourceRow.tot_sale_qty }}"
      />
      <Column
        id="a3344"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["356f4e7b"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_sale_qty"
        label="판매량"
        placeholder="Enter value"
        position="center"
        size={80}
        summaryAggregationMode="none"
      />
      <Column
        id="aa44b"
        alignment="center"
        backgroundColor={'{{ theme._tokensById["356f4e7b"] }}'}
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        label="판매율 (수량)"
        placeholder="Enter value"
        position="center"
        referenceId="판매율수량"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_sale_qty/currentSourceRow.tot_in_qty }}"
      />
      <Column
        id="a95e9"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="tag"
        formatOptions={{ automaticColors: false }}
        groupAggregationMode="average"
        key="gini"
        label="매장편중"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride={
          '{{ self.data[i]["gini"]  === null ? null : Math.max(0, Math.round(((self.data[i]["gini"] - 0.3) / (0.7 - 0.3))*100)) }}'
        }
      />
      <Column
        id="88c1e"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="tag"
        formatOptions={{ automaticColors: false }}
        groupAggregationMode="average"
        key="online_sales_ratio"
        label="온라인비율(%)"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (self.data[i]["online_sales_ratio"]*100).toFixed(0) }}%'
        }
      />
      <Column
        id="dadf2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tag_price"
        label="TAG가"
        placeholder="Enter value"
        position="center"
        size={60}
        summaryAggregationMode="none"
      />
      <Column
        id="2d064"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="tot_in_tag"
        label="입고금액(천원)"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="d9835"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="tot_sale_tag"
        label="판매금액(천원)"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="e21b2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        label="판매율(금액)"
        placeholder="Enter value"
        position="center"
        referenceId="판매율금액"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_sale_tag/currentSourceRow.tot_in_tag }}"
      />
      <Column
        id="92d74"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        label="회수율"
        placeholder="Enter value"
        position="center"
        referenceId="회수율"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_sale_amt/currentSourceRow.tot_in_cost }}"
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
          pluginId="item_list_table"
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
          pluginId="item_list_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="var_item_info"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="drawerFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Body>
</ModalFrame>
