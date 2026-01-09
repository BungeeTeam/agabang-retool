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
      id="container_best5"
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
              { fontWeight: "400" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          value="💡 조회 기간 동안 **가장** **많이** 판매된 순서대로 정렬됩니다."
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
          value="10"
        >
          <Option id="a16ea" label="5개" value="5" />
          <Option id="a3b5c" label="10개" value="10" />
          <Option id="85ddd" label="15개" value="15" />
          <Option
            id="ab400"
            disabled={false}
            hidden={false}
            label="20개"
            value="20"
          />
          <Option
            id="ab401"
            disabled={false}
            hidden={false}
            label="25개"
            value="25"
          />
          <Option
            id="ab402"
            disabled={false}
            hidden={false}
            label="30개"
            value="30"
          />
          <Option
            id="ab403"
            disabled={false}
            hidden={false}
            label="40개"
            value="40"
          />
          <Option
            id="ab404"
            disabled={false}
            hidden={false}
            label="50개"
            value="50"
          />
          <Option
            id="ab405"
            disabled={false}
            hidden={false}
            label="60개"
            value="60"
          />
          <Option
            id="ab406"
            disabled={false}
            hidden={false}
            label="70개"
            value="70"
          />
          <Option
            id="ab407"
            disabled={false}
            hidden={false}
            label="80개"
            value="80"
          />
          <Option
            id="ab408"
            disabled={false}
            hidden={false}
            label="90개"
            value="90"
          />
          <Option
            id="ab409"
            disabled={false}
            hidden={false}
            label="100개"
            value="100"
          />
        </Select>
      </Header>
      <View id="6a4e6" viewKey="View 1">
        <Table
          id="table_best_new6"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ var_best_worst_new.value.best }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          heightType="auto"
          overflowActionsOverlayMaxHeight="200"
          rowHeight="large"
          showHeader={true}
          style={{ background: "surfacePrimary" }}
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
            size={36.734375}
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
            size={69.734375}
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
            size={132.453125}
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
            label="칼라"
            placeholder="Select option"
            position="left"
            size={112.6875}
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
            size={72.984375}
            summaryAggregationMode="none"
          />
          <Column
            id="f3682"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "KRW",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="tag_price"
            label="TAG가"
            placeholder="Enter value"
            position="center"
            size={81.90625}
            summaryAggregationMode="none"
            valueOverride="{{ item }}"
          />
          <Column
            id="0ecf9"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "KRW",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="f_sale_prce"
            label="현판매가"
            placeholder="Enter value"
            position="center"
            size={69.484375}
            summaryAggregationMode="none"
            valueOverride="{{ item.toLocaleString() }}"
          />
          <Column
            id="9482b"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="string"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="dc_rate"
            label="할인율"
            placeholder="Enter value"
            position="center"
            size={47.109375}
            summaryAggregationMode="none"
            valueOverride="{{ item.toLocaleString() }}%"
          />
          <Column
            id="c04a5"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_in_qty"
            label="입고 수량"
            placeholder="Enter value"
            position="center"
            size={77.53125}
            summaryAggregationMode="none"
          />
          <Column
            id="07403"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "KRW",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            label="입고 금액(천원)"
            placeholder="Enter value"
            position="center"
            referenceId="total_tot_in_qty"
            size={99.421875}
            summaryAggregationMode="none"
            valueOverride="{{ Math.trunc((currentSourceRow.tot_in_qty*currentSourceRow.tag_price)/1000).toLocaleString() }}"
          />
          <Column
            id="1af66"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_sale_qty"
            label="누적 판매수량"
            placeholder="Enter value"
            position="center"
            size={87.296875}
            summaryAggregationMode="none"
            tooltip="조회 마감일 기준 누적 판매량"
          />
          <Column
            id="2c687"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "KRW",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
            }}
            groupAggregationMode="sum"
            key="tot_sale_amt"
            label="누적 실판매금액(천원)"
            placeholder="Enter value"
            position="center"
            size={127.53125}
            summaryAggregationMode="none"
            tooltip="조회 마감일 기준 누적 판매금액"
            valueOverride="{{ (Math.trunc(item/1000)).toLocaleString() }}"
          />
          <Column
            id="e8989"
            alignment="center"
            backgroundColor={"{{ item > 0.7 ? 'YELLOW' : \"\"}}"}
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            label="누적 수량판매율"
            placeholder="Enter value"
            position="center"
            referenceId="누적수량판매율"
            size={91.609375}
            summaryAggregationMode="none"
            textColor="#ff0000"
            tooltip="조회 마감일 기준 누적 판매율"
            valueOverride="{{ parseFloat((currentSourceRow.tot_sale_qty/currentSourceRow.tot_in_qty).toFixed(3))}}"
          />
          <Column
            id="99c5d"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="int_sale_qty"
            label="기간 판매수량"
            placeholder="Enter value"
            position="center"
            size={87.859375}
            summaryAggregationMode="none"
          />
          <Column
            id="7248d"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="int_sale_amt"
            label="기간 판매금액(천원)"
            placeholder="Enter value"
            position="center"
            size={119.234375}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="dc9ec"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            label="기간 판매율"
            placeholder="Enter value"
            position="center"
            referenceId="주간일판량"
            size={70.859375}
            summaryAggregationMode="none"
            valueOverride="{{ parseFloat((currentSourceRow.int_sale_qty/currentSourceRow.tot_in_qty).toFixed(3))}}"
          />
          <Column
            id="c28f9"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="int_sale_qty"
            label="기간 일판량"
            placeholder="Enter value"
            position="center"
            referenceId="주간일판율"
            size={70.859375}
            summaryAggregationMode="none"
            valueOverride="{{ (item/7).toFixed(0) }}"
          />
          <ToolbarButton
            id="3c"
            icon="bold/interface-download-button-2"
            label="엑셀 다운로드"
            type="custom"
          >
            <Event
              event="clickToolbar"
              method="exportData"
              params={{
                ordered: [
                  {
                    options: {
                      ordered: [
                        { fileType: "xlsx" },
                        { includeHiddenColumns: false },
                        {
                          fileName:
                            "[{{ sel_category.selectedLabel }}/{{ multiselect1.selectedLabels }}]{{ containerTitle14.value.slice(8) }} {{ select_best_list_count.value }} ({{ dateRange.value.start }}~{{ dateRange.value.end }})",
                        },
                      ],
                    },
                  },
                ],
              }}
              pluginId="table_best_new6"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
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
    <Include src="./src/container_best3.rsx" />
  </Frame>
</App>
