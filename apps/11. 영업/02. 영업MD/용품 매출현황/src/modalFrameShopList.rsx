<ModalFrame
  id="modalFrameShopList"
  enableFullBleed={true}
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
      value="#### 매장 리스트 ( {{ [selectedRow_old.value.it_gb_nm, selectedRow_old.value.item_nm, selectedRow_old.value.br_nm,selectedRow_old.value.sub_br_nm].filter(Boolean).join(' / ') }})"
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
        pluginId="modalFrameShopList"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text2"
      value="단위: 수량-개 / 금액 - 천원"
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Table
      id="table4"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ filterBySelectedRow.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      margin="0"
      rowBackgroundColor="{{ currentSourceRow.shop_nm === '소계'? '01488F33' :
  currentSourceRow.shop_nm === '총계'? '01488F66' :'ffffff' }}"
      rowHeight="medium"
      rowSelection="none"
      showFooter={true}
      showHeader={true}
      style={{}}
    >
      <Column
        id="2222b"
        alignment="left"
        caption="{{ currentSourceRow.shop_cd === '총계' ?'':currentSourceRow.shop_cd }}"
        format="multilineString"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="left"
        size={134.28125}
        sortMode="disabled"
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
        id="f0bce"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="shop_cd"
        label="매장코드"
        placeholder="Enter value"
        position="center"
        size={59.09375}
      />
      <Column
        id="2f69f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="false"
        key="cur_qty"
        label="{{moment(dateRange.value.start).format('YY') }}년 판매수량"
        placeholder="Enter value"
        position="center"
        size={91.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="0b6e5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="false"
        key="cur_tag"
        label="{{moment(dateRange.value.start).format('YY') }}년 매출 (TAG)"
        placeholder="Enter value"
        position="center"
        size={100.4375}
        summaryAggregationMode="none"
        valueOverride="{{ item*1000 }}"
      />
      <Column
        id="c3861"
        alignment="right"
        backgroundColor="rgba(253, 230, 138, 0.33)"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="cur_amt"
        label="{{moment(dateRange.value.start).format('YY') }}년 실매출"
        placeholder="Enter value"
        position="center"
        size={90.453125}
        summaryAggregationMode="none"
        valueOverride="{{ item*1000 }}"
      />
      <Column
        id="1da1b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        label="{{moment(dateRange.value.start).format('YY') }}년 할인율"
        placeholder="Enter value"
        position="center"
        referenceId="momentDateRangeValueStartFormatYy년할인율"
        size={87.453125}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.cur_amt/currentSourceRow.cur_tag) }}"
      />
      <Column
        id="cb1d3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="false"
        key="prev_qty"
        label="{{moment(dateRange.value.start).subtract(1,'year').format('YY') }}년 판매수량"
        placeholder="Enter value"
        position="center"
        size={106.046875}
        summaryAggregationMode="none"
      />
      <Column
        id="4d618"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="false"
        key="prev_tag"
        label="{{moment(dateRange.value.start).subtract(1,'year').format('YY') }}년 매출 (TAG)"
        placeholder="Enter value"
        position="center"
        size={66.140625}
        summaryAggregationMode="none"
        valueOverride="{{ item*1000 }}"
      />
      <Column
        id="af2b2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="prev_amt"
        label="{{moment(dateRange.value.start).subtract(1,'year').format('YY') }}년 실매출"
        placeholder="Enter value"
        position="center"
        size={78.296875}
        summaryAggregationMode="none"
        valueOverride="{{ item*1000 }}"
      />
      <Column
        id="11c89"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        label="{{moment(dateRange.value.start).subtract(1,'year').format('YY') }}년 할인율"
        placeholder="Enter value"
        position="center"
        referenceId="momentDateRangeValueStartSubtract1YearFormatYy년할인율"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.prev_amt/currentSourceRow.prev_tag) }}"
      />
      <Column
        id="db2f9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="매출증감"
        placeholder="Enter value"
        position="center"
        referenceId="매출증감"
        size={71.515625}
        textColor={'{{ item > 0 ? "black" : "red" }}'}
        valueOverride="{{ (currentSourceRow.cur_amt-currentSourceRow.prev_amt)*1000 }}"
      />
      <Column
        id="42588"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="신장율"
        placeholder="Enter value"
        position="center"
        referenceId="신장율"
        size={102.046875}
        textColor={'{{ item > 0 ? "black" : "red" }}'}
        valueOverride="{{ (currentSourceRow.cur_amt-currentSourceRow.prev_amt)/currentSourceRow.prev_amt }}"
      />
      <Column
        id="b3c83"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !switch1.value }}"
        key="cur_cost"
        label="{{moment(dateRange.value.start).format('YY') }}년 원가"
        placeholder="Enter value"
        position="center"
        size={85.078125}
        summaryAggregationMode="none"
        valueOverride="{{ item*1000 }}"
      />
      <Column
        id="b0658"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !switch1.value }}"
        label="{{moment(dateRange.value.start).format('YY') }}년 원가율"
        placeholder="Enter value"
        position="center"
        referenceId="momentDateRangeValueStartFormatYy년원가율"
        size={95.453125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_cost / currentSourceRow.cur_tag }}"
      />
      <Column
        id="3a7ac"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !switch1.value }}"
        key="prev_cost"
        label="{{moment(dateRange.value.start).subtract(1,'year').format('YY') }}년 원가"
        placeholder="Enter value"
        position="center"
        size={84.296875}
        summaryAggregationMode="none"
        valueOverride="{{ item*1000 }}"
      />
      <Column
        id="51567"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !switch1.value }}"
        label="{{moment(dateRange.value.start).subtract(1,'year').format('YY') }}년 원가율"
        placeholder="Enter value"
        position="center"
        referenceId="momentDateRangeValueStartSubtract1YearFormatYy년원가율"
        size={93.671875}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.prev_cost / currentSourceRow.prev_tag }}"
      />
      <Column
        id="cf4b4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !switch1.value }}"
        label="원가증감"
        placeholder="Enter value"
        position="center"
        referenceId="원가증감"
        size={64.515625}
        valueOverride="{{ (currentSourceRow.cur_cost-currentSourceRow.prev_cost)*1000 }}"
      />
      <Column
        id="40ee9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !switch1.value }}"
        label="원가율 증감"
        placeholder="Enter value"
        position="center"
        referenceId="원가율증감"
        size={81.28125}
        valueOverride="{{ currentSourceRow.cur_cost/currentSourceRow.cur_tag - currentSourceRow.prev_cost/currentSourceRow.prev_tag }}"
      />
      <Column
        id="95cfc"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        referenceId="spacer"
        size={16}
      />
      <ToolbarButton
        id="46856"
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
                    { includeHiddenColumns: false },
                    {
                      fileName:
                        "{{ modalTitle1.value.slice(5) }}_({{ dateRange.value.start }}~{{ dateRange.value.end }})",
                    },
                  ],
                },
              },
            ],
          }}
          pluginId="table4"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</ModalFrame>
