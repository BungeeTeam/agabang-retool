<Container
  id="container_worst"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  hidden="{{ select_main_type.value === 'shop' }}"
  padding="0"
  showBody={true}
  showHeader={true}
  style={{ ordered: [{ headerBackground: "#444a67" }] }}
>
  <Header>
    <Text
      id="containerTitle15"
      margin="8px 4px 0px 4px"
      value="#### 🤔 WORST"
      verticalAlign="center"
    />
    <Text
      id="text21"
      margin="9px 8px 0px 0px"
      style={{
        ordered: [
          { fontSize: "12px" },
          { fontWeight: "500" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      value="💡 기간 판매수량이 **적은** 순서대로 노출됩니다."
      verticalAlign="center"
    />
    <Select
      id="select_exclude_day"
      emptyMessage="No options"
      itemMode="static"
      label=""
      labelPosition="top"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      style={{
        ordered: [
          { fontSize: "11px" },
          { fontWeight: "400" },
          { fontFamily: "Pretendard Variable" },
          { optionFontSize: "11px" },
          { optionFontWeight: "400" },
          { optionFontFamily: "Pretendard Variable" },
        ],
      }}
      textBefore="판매일수"
      value="20"
    >
      <Option id="33ce0" label="10일 이하 제외" value="10" />
      <Option id="28165" label="20일 이하 제외" value="20" />
      <Option id="4e04c" label="30일 이하 제외" value="30" />
    </Select>
    <Select
      id="select_exclude_rate"
      emptyMessage="No options"
      itemMode="static"
      label=""
      labelPosition="top"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      style={{
        ordered: [
          { fontSize: "11px" },
          { fontWeight: "400" },
          { fontFamily: "Pretendard Variable" },
          { optionFontSize: "11px" },
          { optionFontWeight: "400" },
          { optionFontFamily: "Pretendard Variable" },
        ],
      }}
      textBefore="판매율"
      value="0.35"
    >
      <Option
        id="26a87"
        disabled={false}
        hidden={false}
        label="20% 이상 제외"
        value="0.2"
      />
      <Option
        id="0fb57"
        disabled={false}
        hidden={false}
        label="25% 이상 제외"
        value="0.25"
      />
      <Option id="33ce0" label="30% 이상 제외" value="0.3" />
      <Option
        id="ead47"
        disabled={false}
        hidden={false}
        label="35% 이상 제외"
        value="0.35"
      />
      <Option id="4e04c" label="40% 이상 제외" value="0.4" />
    </Select>
    <Select
      id="select_worst_list_count"
      emptyMessage="No options"
      itemMode="static"
      label=""
      labelPosition="top"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      style={{
        ordered: [
          { fontSize: "11px" },
          { fontWeight: "400" },
          { fontFamily: "Pretendard Variable" },
          { optionFontSize: "11px" },
          { optionFontWeight: "400" },
          { optionFontFamily: "Pretendard Variable" },
        ],
      }}
      textBefore="아이템수"
      value="15"
    >
      <Option id="a16ea" label="5개" value="5" />
      <Option id="a3b5c" label="10개" value="10" />
      <Option id="85ddd" label="15개" value="15" />
    </Select>
  </Header>
  <View id="6a4e6" viewKey="View 1">
    <Table
      id="table_best_new2"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ var_best_worst_new.value.worst }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{
        formatByIndex: "auto",
        labelByIndex: "",
        hiddenByIndex: "",
      }}
      dynamicColumnsEnabled={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden="{{ select_main_type.value === 'ch' }}"
      margin="0"
      overflowActionsOverlayMaxHeight="200"
      rowHeight="large"
      rowSelection="none"
      showHeader={true}
      style={{ background: "surfacePrimary" }}
      toolbarPosition="bottom"
    >
      <Column
        id="8549d"
        alignment="right"
        backgroundColor="{{ theme.canvas }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="false"
        key="sale_rank"
        label="순위"
        placeholder="Enter value"
        position="left"
        size={36.734375}
        summaryAggregationMode="none"
      />
      <Column
        id="a5d56"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ select_main_type.value !== 'shop' }}"
        key="shop_cd"
        label="상점코드"
        placeholder="Enter value"
        position="center"
        size={75}
        summaryAggregationMode="none"
      />
      <Column
        id="ca0d4"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="{{ select_main_type.value !== 'shop' }}"
        key="shop_nm"
        label="상점명"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="5fc0c"
        alignment="center"
        format="image"
        formatOptions={{ widthType: "fit" }}
        groupAggregationMode="none"
        label="사진"
        placeholder="Enter value"
        position="left"
        referenceId="column20"
        size={82}
        summaryAggregationMode="none"
        valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg"
      />
      <Column
        id="288e6"
        alignment="center"
        caption="{{ currentSourceRow.sty_cd }}"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="품명"
        placeholder="Enter value"
        position="left"
        size={169}
        summaryAggregationMode="none"
      />
      <Column
        id="d6e3a"
        alignment="center"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="{{ select_main_type.value === 'channel' }}"
        key="channel_gb"
        label="채널구분"
        placeholder="Enter value"
        position="center"
        size={117}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="0cf38"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sty_cd"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={82.25}
        summaryAggregationMode="none"
      />
      <Column
        id="806c9"
        alignment="center"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        format="tag"
        formatOptions={{
          automaticColors: false,
          color:
            "{{ JSON.parse(retoolContext.configVars.var_color_dict)[item] }}",
        }}
        groupAggregationMode="average"
        key="col_nm"
        label="컬러"
        placeholder="Select option"
        position="left"
        size={137.6875}
        summaryAggregationMode="none"
      />
      <Column
        id="1fdb0"
        alignment="center"
        format="date"
        formatOptions={{ dateFormat: "yy/MM/dd" }}
        groupAggregationMode="none"
        key="fout_date"
        label="출고일자"
        placeholder="Enter value"
        position="center"
        size={114.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="c04a5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="누계입고량"
        placeholder="Enter value"
        position="center"
        size={95.53125}
        summaryAggregationMode="none"
      />
      <Column
        id="07403"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="입고 금액(천원)"
        placeholder="Enter value"
        position="center"
        referenceId="total_tot_in_qty"
        size={89.421875}
        summaryAggregationMode="none"
        valueOverride="{{ Math.trunc((currentSourceRow.tot_in_qty*currentSourceRow.tag_price)/1000).toLocaleString() }}천원"
      />
      <Column
        id="1af66"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="false"
        key="tot_sale_qty"
        label="누계 판매량"
        placeholder="Enter value"
        position="center"
        size={128.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="2c687"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="tot_sale_amt"
        label="누적 실판매금액(천원)"
        placeholder="Enter value"
        position="center"
        size={120.53125}
        summaryAggregationMode="none"
        valueOverride="{{ (Math.trunc(item/1000)).toLocaleString() }}천원"
      />
      <Column
        id="e8989"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        label="누계판매율"
        placeholder="Enter value"
        position="center"
        referenceId="누계판매율"
        size={117.609375}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.tot_sale_qty/currentSourceRow.tot_in_qty).toFixed(3)*100).toFixed(1) }}%"
      />
      <Column
        id="99c5d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="int_sale_qty"
        label="기간 매장별판매량"
        placeholder="Enter value"
        position="center"
        size={147.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="dc9ec"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="기간 일판량"
        placeholder="Enter value"
        position="center"
        referenceId="주간일판량"
        size={70.859375}
        summaryAggregationMode="none"
        valueOverride="{{  (parseInt(currentSourceRow.int_sale_qty) / ((moment(dateRange.value.end)).diff(moment(dateRange.value.start), 'days') ?? 1)).toFixed(2) }}%"
      />
      <Column
        id="c28f9"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="기간 일판율"
        placeholder="Enter value"
        position="center"
        referenceId="주간일판율"
        size={70.859375}
        summaryAggregationMode="none"
        valueOverride="{{ (parseFloat((currentSourceRow.int_sale_qty/currentSourceRow.tot_in_qty).toFixed(4))*100).toFixed(2) }}%"
      />
      <Column
        id="68a05"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="sort"
        label="TYPE"
        placeholder="Select option"
        position="center"
        size={60.859375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="28e9e"
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
        size={124.796875}
        summaryAggregationMode="none"
      />
      <Column
        id="89017"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="cat_raw_nm"
        label="Cat raw nm"
        placeholder="Select option"
        position="center"
        size={77.46875}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="b6cec"
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
        size={50.1875}
        summaryAggregationMode="none"
      />
      <Column
        id="ef730"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="cat_nm"
        label="중분류"
        placeholder="Select option"
        position="center"
        size={81.078125}
        summaryAggregationMode="none"
      />
      <Column
        id="c7173"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="int_sale_rate"
        label="Int sale rate"
        placeholder="Enter value"
        position="center"
        size={78.59375}
        summaryAggregationMode="none"
      />
      <Column
        id="fa5b7"
        alignment="left"
        format="date"
        formatOptions={{ dateFormat: "yyyy/MM/dd" }}
        groupAggregationMode="none"
        hidden="true"
        key="fin_date"
        label="입고일"
        placeholder="Enter value"
        position="center"
        size={82.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="47af6"
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
          pluginId="table_best_new2"
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
          pluginId="table_best_new2"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
</Container>
