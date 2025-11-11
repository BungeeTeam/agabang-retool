<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <CustomAppTheme
    id="$appTheme"
    _migrated={true}
    automatic={[
      "#fde68a",
      "#eecff3",
      "#a7f3d0",
      "#bfdbfe",
      "#c7d2fe",
      "#fecaca",
      "#fcd6bb",
    ]}
    borderRadius="4px"
    canvas="#f6f6f6"
    danger="#dc2626"
    defaultFont={{
      size: "12px",
      source:
        "https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css",
      name: '"Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif',
    }}
    h1Font={{ size: "36px" }}
    h2Font={{ size: "28px" }}
    h3Font={{ size: "24px" }}
    h4Font={{ size: "18px" }}
    h5Font={{ size: "16px" }}
    h6Font={{ size: "14px" }}
    highlight="#fde68a"
    info="#3170f9"
    primary="#dd5e2c"
    secondary=""
    success="#059669"
    surfacePrimary="#ffffff"
    surfacePrimaryBorder=""
    surfaceSecondary="#ffffff"
    surfaceSecondaryBorder=""
    tertiary=""
    textDark="#0d0d0d"
    textLight="#ffffff"
    warning="#cd6f00"
  />
  <Include src="./header.rsx" />
  <Include src="./src/drawerFrame_item_detail_new.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Include src="./src/container8.rsx" />
    <Spacer id="spacer8" />
    <Container
      id="container_best"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="0"
      showBody={true}
      showHeader={true}
      style={{ ordered: [{ headerBackground: "#444a67" }] }}
    >
      <Header>
        <Text
          id="containerTitle14"
          margin="8px 4px 0px 4px"
          value="#### 👍 BEST"
          verticalAlign="center"
        />
        <Text
          id="text20"
          margin="9px 8px 0px 0px"
          style={{
            ordered: [
              { fontSize: "12px" },
              { fontWeight: "500" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          value="💡 기간 판매수량이 **많은** 순서대로 노출됩니다."
          verticalAlign="center"
        />
        <Select
          id="select_best_list_count"
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
          id="table_best_new"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ var_best_worst_new.value.best }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          heightType="auto"
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
            alignment="center"
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
            size={36.765625}
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
            size={87.765625}
            sortMode="disabled"
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
            size={150.9375}
            summaryAggregationMode="none"
          />
          <Column
            id="806c9"
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
            position="left"
            size={137.40625}
            summaryAggregationMode="none"
          />
          <Column
            id="ca0d4"
            alignment="center"
            format="string"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            hidden="true"
            key="shop_nm"
            label="상점명"
            placeholder="Enter value"
            position="center"
            size={143.9375}
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
            size={149.28125}
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
            size={85.828125}
            summaryAggregationMode="none"
          />
          <Column
            id="1fdb0"
            alignment="center"
            format="date"
            formatOptions={{ dateFormat: "yy/MM/dd" }}
            groupAggregationMode="none"
            key="fin_date"
            label="매장입고일"
            placeholder="Enter value"
            position="center"
            size={106.1875}
            summaryAggregationMode="none"
          />
          <Column
            id="99c5d"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="int_sale_qty"
            label="기간 매장별판매량"
            placeholder="Enter value"
            position="center"
            size={102.421875}
            summaryAggregationMode="none"
          />
          <Column
            id="8d3a2"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_in_qty"
            label="누계입고량"
            placeholder="Enter value"
            position="center"
            referenceId="column33"
            size={113}
            summaryAggregationMode="none"
            tooltip="초도입고+RT입고"
            valueOverride="{{ item + currentSourceRow.tot_rt_in_qty }}"
          />
          <Column
            id="1af66"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="false"
            key="tot_sales_qty"
            label="누계 판매량"
            placeholder="Enter value"
            position="center"
            size={89.28125}
            summaryAggregationMode="none"
          />
          <Column
            id="3daf6"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_stock_qty"
            label="재고수량"
            placeholder="Enter value"
            position="center"
            size={106.515625}
            summaryAggregationMode="none"
          />
          <Column
            id="e8989"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="string"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            label="누계판매율"
            placeholder="Enter value"
            position="center"
            referenceId="누계판매율"
            size={73.90625}
            summaryAggregationMode="none"
            valueOverride="{{ ((currentSourceRow.tot_sales_qty/(currentSourceRow.tot_in_qty+currentSourceRow.tot_rt_in_qty)).toFixed(3)*100).toFixed(1) }}%"
          />
          <Column
            id="c04a5"
            alignment="center"
            backgroundColor={'{{ theme._tokensById["356f4e7b"] }}'}
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_in_qty"
            label="초도 입고량"
            placeholder="Enter value"
            position="center"
            size={71.28125}
            summaryAggregationMode="none"
          />
          <Column
            id="02f10"
            alignment="center"
            backgroundColor={'{{ theme._tokensById["356f4e7b"] }}'}
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_rt_in_qty"
            label="RT 입고량"
            placeholder="Enter value"
            position="center"
            referenceId="ㄲ"
            size={65.890625}
            summaryAggregationMode="none"
          />
          <Column
            id="9c24b"
            alignment="center"
            backgroundColor={'{{ theme._tokensById["356f4e7b"] }}'}
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_cust_rqty"
            label="고객반품수량"
            placeholder="Enter value"
            position="center"
            size={78.28125}
            summaryAggregationMode="none"
          />
          <Column
            id="b0bbb"
            alignment="center"
            backgroundColor={'{{ theme._tokensById["356f4e7b"] }}'}
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_wh_rtn_qty"
            label="물류반품수량"
            placeholder="Enter value"
            position="center"
            size={78.28125}
            summaryAggregationMode="none"
          />
          <Column
            id="3dfae"
            alignment="center"
            backgroundColor={'{{ theme._tokensById["356f4e7b"] }}'}
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_rt_rtn_qty"
            label="RT 출고량"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="da154"
            alignment="center"
            backgroundColor={'{{ theme._tokensById["356f4e7b"] }}'}
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_adjt_qty"
            label="조정수량"
            placeholder="Enter value"
            position="center"
            size={80.8125}
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
            size={90.34375}
            summaryAggregationMode="none"
            valueOverride="{{ Math.trunc((currentSourceRow.tot_in_qty*currentSourceRow.tag_price)/1000).toLocaleString() }}천원"
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
            size={121.484375}
            summaryAggregationMode="none"
            valueOverride="{{ (Math.trunc(item/1000)).toLocaleString() }}천원"
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
            size={71.28125}
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
            size={71.28125}
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
            size={62.34375}
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
            size={131.265625}
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
            size={81.046875}
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
            size={52.25}
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
            size={83.4375}
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
            size={82.703125}
            summaryAggregationMode="none"
          />
          <Column
            id="53ed5"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="A.shop_cd"
            label="A shop cd"
            placeholder="Enter value"
            position="center"
            size={72.84375}
            summaryAggregationMode="none"
          />
          <Event
            event="clickRow"
            method="setValue"
            params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
            pluginId="var_sty_data"
            type="state"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="clickRow"
            method="show"
            params={{ ordered: [] }}
            pluginId="drawerFrame_item_detail_new"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Table>
      </View>
    </Container>
    <Include src="./src/container_worst.rsx" />
  </Frame>
</App>
