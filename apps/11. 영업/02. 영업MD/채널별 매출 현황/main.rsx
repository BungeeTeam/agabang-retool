<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <UrlFragments
    id="$urlFragments"
    value={{
      ordered: [
        { biz: "{{ bizSelect.value }}" },
        { br: "{{ brandSelect.value }}" },
        { season: "{{ itCodeSelect.value }}" },
        { even: "{{ JSON.stringify(switchGroup1.value) }}" },
        { startDate: "{{ dateRange.value.end }}" },
        { endDate: "{{ dateRange.value.end }}" },
      ],
    }}
  />
  <Include src="./header.rsx" />
  <Include src="./sidebar.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="0"
    sticky={null}
    type="main"
  >
    <Container
      id="stack3"
      _align="center"
      _flexWrap={true}
      _gap="8px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
      style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
    >
      <View id="e152e" viewKey="View 1">
        <Text
          id="text50"
          hidden=""
          value="##### {{ bizSelect.selectedLabel }} {{ brandSelect.selectedLabel }} {{ seasonSelect.selectedLabel }} 복종 {{ itCodeSelect.selectedLabel }}"
          verticalAlign="center"
        />
        <DropdownButton
          id="dropdownButton1"
          _colorByIndex={["", ""]}
          _fallbackTextByIndex={["", ""]}
          _imageByIndex={["", ""]}
          _values={["", ""]}
          icon="bold/interface-download-button-2"
          itemMode="static"
          margin="8px 8px"
          overlayMaxHeight={375}
          styleVariant="outline"
          text="엑셀 다운로드"
        >
          <Option id="918f7" label="채널별" tooltip="채널별 매출 다운로드">
            <Event
              event="click"
              method="run"
              params={{
                ordered: [
                  {
                    src: "const channelFileName = `${brandSelect.selectedLabel } ${ seasonSelect.selectedLabel } ${ itCodeSelect.selectedLabel } sales by channel(${ dateRange.value.end })`\n\n\n\ntable1.exportData({\n  fileName: channelFileName,\n  fileType: 'xlsx',\n  includeHiddenColumns: false\n})\n",
                  },
                ],
              }}
              pluginId=""
              type="script"
              waitMs="0"
              waitType="debounce"
            />
          </Option>
          <Option id="5e0b5" label="매장별" tooltip="매장별 매출 다운로드">
            <Event
              event="click"
              method="run"
              params={{
                ordered: [
                  {
                    src: "const shopFileName = `${brandSelect.selectedLabel } ${ seasonSelect.selectedLabel } ${ itCodeSelect.selectedLabel } sales by shop(${ dateRange.value.end })`\nawait table3.exportData({\n  fileName: shopFileName,\n  fileType: 'xlsx',\n  includeHiddenColumns: false\n})",
                  },
                ],
              }}
              pluginId=""
              type="script"
              waitMs="0"
              waitType="debounce"
            />
          </Option>
        </DropdownButton>
      </View>
    </Container>
    <DateRange
      id="dateRange"
      dateFormat="yyyy-MM-dd"
      endPlaceholder="End date"
      iconBefore="bold/interface-calendar-remove"
      label=""
      labelPosition="top"
      showClear={true}
      startPlaceholder="Start date"
      textBefore="조회기간"
      textBetween="-"
      tooltipText="기본 설정: 전년도 시즌 마감일부터 어제까지"
      value={{
        ordered: [
          { start: "{{ seasonSelect.selectedItem.season_end_dt }}" },
          { end: "{{ moment().subtract(1,'days').format('YYYY-MM-DD') }}" },
        ],
      }}
    >
      <Event
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getSalesByShop"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </DateRange>
    <Text
      id="text47"
      horizontalAlign="right"
      margin="4px 12px"
      value="단위: 수량-개 / 금액-백만원"
      verticalAlign="center"
    />
    <Text id="text4" value="###### [채널별 매출]" verticalAlign="center" />
    <Table
      id="table1"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByChannel.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      primaryKeyColumnId="18ad4"
      rowBackgroundColor="{{ currentSourceRow.tp_nm === '소계' ? '#01488F33' : '' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showFooter={true}
      showHeader={true}
      style={{
        headerBackground: "tokens/356f4e7b",
        accent: "rgba(1, 72, 143, 0.2)",
      }}
    >
      <Column
        id="53059"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="tp_nm"
        label="채널명"
        placeholder="Enter value"
        position="left"
        size={203.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="e7e85"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="shop_out_count"
        label="{{ seasonSelect.selectedItem.year_nm}} 출고 매장수"
        placeholder="Enter value"
        position="left"
        size={83.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="04b3d"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="out_tag"
        label=" {{ seasonSelect.selectedItem.year_nm}} 순출고금액"
        placeholder="Enter value"
        position="center"
        size={81.515625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="6e84f"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_amt"
        label="{{ seasonSelect.selectedItem.year_nm}} 실판매금액"
        placeholder="Enter value"
        position="center"
        size={79.90625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="1bd4d"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_amt_rate"
        label="{{ seasonSelect.selectedItem.year_nm}} 실판가판매율"
        placeholder="Enter value"
        position="center"
        size={83.96875}
        summaryAggregationMode="none"
        textColor="{{ salesByChannel.value.filter(i => i.tp_nm === '소계')[0].sale_amt_rate > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="918dc"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="out_tag_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 순출고금액"
        placeholder="Enter value"
        position="center"
        size={83.734375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="55050"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_amt_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 실판매금액"
        placeholder="Enter value"
        position="center"
        size={77.890625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="74966"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_amt_rate_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 실판가판매율"
        placeholder="Enter value"
        position="center"
        size={81.984375}
        summaryAggregationMode="none"
        textColor="{{ salesByChannel.value.filter(i => i.tp_nm === '소계')[0].sale_amt_rate_ly > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="0b392"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="out_tag_diff"
        label="순출고금액 증감량"
        placeholder="Enter value"
        position="center"
        size={79.75}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="0139e"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_amt_diff"
        label="실판매금액 증감량"
        placeholder="Enter value"
        position="center"
        size={79.671875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="7ecdf"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_out_count_ly"
        label="작년 출고 매장 수"
        placeholder="Enter value"
        position="center"
        size={71.578125}
        summaryAggregationMode="none"
      />
      <Column
        id="42bf3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_out_count_diff"
        label="출고매장수 증감"
        placeholder="Enter value"
        position="center"
        size={74}
        summaryAggregationMode="none"
      />
      <Column
        id="417a1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_sale_count"
        label="판매
매장수"
        placeholder="Enter value"
        position="left"
        size={66.90625}
      />
      <Column
        id="18ad4"
        alignment="right"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="tp_cd"
        label="Tp cd"
        placeholder="Enter value"
        position="center"
        size={47.859375}
      />
      <Column
        id="f1921"
        alignment="right"
        backgroundColor="rgba(1, 72, 143, 0)"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "",
        }}
        groupAggregationMode="sum"
        key="out_qty"
        label="{{ seasonSelect.selectedItem.year_nm}} 순출고수량"
        placeholder="Enter value"
        position="center"
        size={93.25}
        summaryAggregationMode="none"
      />
      <Column
        id="3c6d1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty"
        label="{{ seasonSelect.selectedItem.year_nm}} 판매수량"
        placeholder="Enter value"
        position="center"
        size={69.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="6d505"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_tag"
        label="{{ seasonSelect.selectedItem.year_nm}} 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={79.515625}
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="d9cfe"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_qty_rate"
        label="{{ seasonSelect.selectedItem.year_nm}} 수량판매율"
        placeholder="Enter value"
        position="center"
        referenceId="판매율(수량)"
        size={76.59375}
        summaryAggregationMode="none"
        textColor="{{ salesByChannel.value.filter(i => i.tp_nm === '소계')[0].sale_qty_rate > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="719ed"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_tag_rate"
        label="{{ seasonSelect.selectedItem.year_nm}} TAG판매율"
        placeholder="Enter value"
        position="center"
        size={79.140625}
        summaryAggregationMode="none"
        textColor="{{ salesByChannel.value.filter(i => i.tp_nm === '소계')[0].sale_tag_rate > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="a305c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="out_qty_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 순출고수량"
        placeholder="Enter value"
        position="center"
        size={88.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="2b063"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 판매수량"
        placeholder="Enter value"
        position="center"
        size={74.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="07118"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_tag_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={75.125}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="f97e6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_sale_count_ly"
        label="Shop sale count ly"
        placeholder="Enter value"
        position="center"
        size={119.953125}
        summaryAggregationMode="none"
      />
      <Column
        id="2ce05"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_qty_rate_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 수량판매율"
        placeholder="Enter value"
        position="center"
        size={80.78125}
        summaryAggregationMode="none"
        textColor="{{ salesByChannel.value.filter(i => i.tp_nm === '소계')[0].sale_qty_rate_ly > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="9efa0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_tag_rate_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} TAG판매율"
        placeholder="Enter value"
        position="center"
        size={78.875}
        summaryAggregationMode="none"
        textColor="{{ salesByChannel.value.filter(i => i.tp_nm === '소계')[0].sale_tag_rate_ly > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="07112"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="out_qty_growth"
        label="순출고수량 증감율"
        placeholder="Enter value"
        position="center"
        size={82.4375}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      />
      <Column
        id="a0dd8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="out_tag_growth"
        label="순출고금액 증감율"
        placeholder="Enter value"
        position="center"
        size={77.640625}
        summaryAggregationMode="none"
      />
      <Column
        id="27659"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_qty_growth"
        label="판매수량 증감율"
        placeholder="Enter value"
        position="center"
        size={81.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="e81b0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_tag_growth"
        label="판매금액(TAG) 증감율"
        placeholder="Enter value"
        position="center"
        size={96.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="d4af4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_amt_growth"
        label="실판매금액 증감율"
        placeholder="Enter value"
        position="center"
        size={83.421875}
        summaryAggregationMode="none"
      />
      <Column
        id="8cdf6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="out_qty_diff"
        label="순출고수량 증감량"
        placeholder="Enter value"
        position="center"
        size={74.53125}
      />
      <Column
        id="2b8d0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_diff"
        label="판매수량 증감량"
        placeholder="Enter value"
        position="center"
        size={76.3125}
      />
      <Column
        id="8072c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_tag_diff"
        label="판매금액(TAG) 증감량"
        placeholder="Enter value"
        position="center"
        size={89.078125}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="50b2e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_sale_count_diff"
        label="Shop sale count diff"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="65a40"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="shop_out_count_growth"
        label="Shop out count growth"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="ae9b1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="shop_sale_count_growth"
        label="Shop sale count growth"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="필터"
        type="filter"
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
                    {
                      fileName:
                        "{{brandSelect.selectedLabel }} {{ seasonSelect.selectedLabel }} {{ itCodeSelect.selectedLabel }} 채널별 판매 데이터(마감일: {{ dateRange.value.end }})",
                    },
                    { includeHiddenColumns: false },
                  ],
                },
              },
            ],
          }}
          pluginId="table1"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="varSelectedChannel"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Container
      id="stack1"
      _align="center"
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
      <View id="64367" viewKey="View 1">
        <Button
          id="closeButton1"
          ariaLabel="Close"
          heightType="auto"
          horizontalAlign="right"
          iconBefore="bold/interface-arrows-synchronize"
          margin="0"
          style={{ ordered: [{ border: "transparent" }] }}
          styleVariant="outline"
          text="모든매장 보기"
        >
          <Event
            event="click"
            method="run"
            params={{ ordered: [{ src: "varSelectedChannel.setValue(null)" }] }}
            pluginId=""
            type="script"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <Text
          id="text48"
          value="###### [매장 리스트] ({{ salesByShop.value.filter(i => i.out_qty > 0).length - 1 === -1 ? 0 : salesByShop.value.filter(i => i.out_qty > 0).length - 1 }})"
          verticalAlign="center"
        />
      </View>
    </Container>
    <Table
      id="table3"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByShop.value.filter(i => i.out_qty > 0) }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden=""
      primaryKeyColumnId="60ee3"
      rowBackgroundColor="{{ currentSourceRow.tp_nm === '소계' ? '#01488F33' : '' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showFooter={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
    >
      <Column
        id="53059"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="tp_nm"
        label="채널명"
        placeholder="Enter value"
        position="left"
        size={118.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="60ee3"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="left"
        size={167}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="copyToClipboard"
          params={{ ordered: [{ value: "{{ currentSourceRow.shop_cd }}" }] }}
          pluginId=""
          type="util"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="417a1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_sale_count"
        label="판매
매장수"
        placeholder="Enter value"
        position="left"
        size={71.28125}
      />
      <Column
        id="04b3d"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="out_tag"
        label=" {{ seasonSelect.selectedItem.year_nm}} 순출고금액"
        placeholder="Enter value"
        position="center"
        size={82.59375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="6e84f"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_amt"
        label="{{ seasonSelect.selectedItem.year_nm}} 실판매금액"
        placeholder="Enter value"
        position="center"
        size={85.59375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="1bd4d"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_amt_rate"
        label="{{ seasonSelect.selectedItem.year_nm}} 실판가판매율"
        placeholder="Enter value"
        position="center"
        size={81.96875}
        summaryAggregationMode="none"
        textColor="{{ salesByShop.value.filter(i => i.shop_nm === '소계')[0].sale_amt_rate > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="918dc"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="out_tag_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 순출고금액"
        placeholder="Enter value"
        position="center"
        size={80.8125}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="55050"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_amt_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 실판매금액"
        placeholder="Enter value"
        position="center"
        size={82.8125}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="74966"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_amt_rate_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 실판가판매율"
        placeholder="Enter value"
        position="center"
        size={86.1875}
        summaryAggregationMode="none"
        textColor="{{ salesByShop.value.filter(i => i.shop_nm === '소계')[0].sale_amt_rate_ly > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="0b392"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="out_tag_diff"
        label="순출고금액 증감량"
        placeholder="Enter value"
        position="center"
        size={82.421875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="0139e"
        alignment="right"
        backgroundColor={'{{ theme._tokensById["d8f872e2"] }}'}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_amt_diff"
        label="실판매금액 증감량"
        placeholder="Enter value"
        position="center"
        size={74.421875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="f1921"
        alignment="right"
        backgroundColor="rgba(1, 72, 143, 0)"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "",
        }}
        groupAggregationMode="sum"
        key="out_qty"
        label="{{ seasonSelect.selectedItem.year_nm}} 순출고수량"
        placeholder="Enter value"
        position="center"
        size={89.59375}
        summaryAggregationMode="none"
      />
      <Column
        id="3c6d1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty"
        label="{{ seasonSelect.selectedItem.year_nm}} 판매수량"
        placeholder="Enter value"
        position="center"
        size={75.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="6d505"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_tag"
        label="{{ seasonSelect.selectedItem.year_nm}} 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={77.203125}
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="d9cfe"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_qty_rate"
        label="{{ seasonSelect.selectedItem.year_nm}} 수량판매율"
        placeholder="Enter value"
        position="center"
        referenceId="판매율(수량)"
        size={88.59375}
        summaryAggregationMode="none"
        textColor="{{ salesByShop.value.filter(i => i.shop_nm === '소계')[0].sale_qty_rate > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="719ed"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_tag_rate"
        label="{{ seasonSelect.selectedItem.year_nm}} TAG판매율"
        placeholder="Enter value"
        position="center"
        size={97.140625}
        summaryAggregationMode="none"
        textColor="{{ salesByShop.value.filter(i => i.shop_nm === '소계')[0].sale_tag_rate > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="a305c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="out_qty_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 순출고수량"
        placeholder="Enter value"
        position="center"
        size={96.8125}
        summaryAggregationMode="none"
      />
      <Column
        id="2b063"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 판매수량"
        placeholder="Enter value"
        position="center"
        size={74.4375}
        summaryAggregationMode="none"
      />
      <Column
        id="07118"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_tag_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={87.421875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="7ecdf"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_out_count_ly"
        label="Shop out count ly"
        placeholder="Enter value"
        position="center"
        size={115.578125}
        summaryAggregationMode="none"
      />
      <Column
        id="f97e6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_sale_count_ly"
        label="Shop sale count ly"
        placeholder="Enter value"
        position="center"
        size={119.953125}
        summaryAggregationMode="none"
      />
      <Column
        id="2ce05"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_qty_rate_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} 수량판매율"
        placeholder="Enter value"
        position="center"
        size={85.8125}
        summaryAggregationMode="none"
        textColor="{{ salesByShop.value.filter(i => i.shop_nm === '소계')[0].sale_qty_rate_ly > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="9efa0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_tag_rate_ly"
        label="{{ Number(seasonSelect.selectedItem.year_nm)-1}} TAG판매율"
        placeholder="Enter value"
        position="center"
        size={85.359375}
        summaryAggregationMode="none"
        textColor="{{ salesByShop.value.filter(i => i.tp_nm === '소계')[0].sale_tag_rate_ly > item ? '#DC2626' : 'ffffff' }}"
      />
      <Column
        id="07112"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="out_qty_growth"
        label="순출고수량 증감율"
        placeholder="Enter value"
        position="center"
        size={88.421875}
        summaryAggregationMode="none"
      />
      <Column
        id="a0dd8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="out_tag_growth"
        label="순출고금액 증감율"
        placeholder="Enter value"
        position="center"
        size={102.421875}
        summaryAggregationMode="none"
      />
      <Column
        id="27659"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_qty_growth"
        label="판매수량 증감율"
        placeholder="Enter value"
        position="center"
        size={92.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="e81b0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_tag_growth"
        label="판매금액(TAG) 증감율"
        placeholder="Enter value"
        position="center"
        size={105.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="d4af4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_amt_growth"
        label="실판매금액 증감율"
        placeholder="Enter value"
        position="center"
        size={92.421875}
        summaryAggregationMode="none"
      />
      <Column
        id="8cdf6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="out_qty_diff"
        label="순출고수량 증감량"
        placeholder="Enter value"
        position="center"
        size={85.421875}
      />
      <Column
        id="2b8d0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_diff"
        label="판매수량 증감량"
        placeholder="Enter value"
        position="center"
        size={92.03125}
      />
      <Column
        id="8072c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="sale_tag_diff"
        label="판매금액(TAG) 증감량"
        placeholder="Enter value"
        position="center"
        size={95.03125}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="50b2e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_sale_count_diff"
        label="Shop sale count diff"
        placeholder="Enter value"
        position="center"
        size={129.390625}
        summaryAggregationMode="none"
      />
      <Column
        id="65a40"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="shop_out_count_growth"
        label="Shop out count growth"
        placeholder="Enter value"
        position="center"
        size={145.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="ae9b1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="shop_sale_count_growth"
        label="Shop sale count growth"
        placeholder="Enter value"
        position="center"
        size={150.28125}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="필터"
        type="filter"
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
                    {
                      fileName:
                        "{{brandSelect.selectedLabel }} {{ seasonSelect.selectedLabel }} {{ itCodeSelect.selectedLabel }} 매장별 판매 데이터(마감일: {{ dateRange.value.end }})",
                    },
                    { includeHiddenColumns: false },
                  ],
                },
              },
            ],
          }}
          pluginId="table3"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Frame>
</App>
