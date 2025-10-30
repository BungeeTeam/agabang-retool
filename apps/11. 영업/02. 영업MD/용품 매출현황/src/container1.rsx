<Container
  id="container1"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0"
  showBody={true}
  showHeader={true}
  style={{ ordered: [] }}
>
  <Header>
    <Tabs
      id="tabs3"
      heightType="fixed"
      itemMode="static"
      value="{{ self.values[0] }}"
    >
      <Option id="d3d24" label="오프라인" value="오프라인" />
      <Option id="47702" label="온라인" value="온라인" />
      <Option id="215bc" label="온오프라인 합계" value="합계" />
    </Tabs>
    <Text
      id="text3"
      horizontalAlign="right"
      value="단위: 수량-개 / 금액 - 백만원"
      verticalAlign="center"
    />
  </Header>
  <View id="be05c" label="중분류별" viewKey="중분류별">
    <Table
      id="table1"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ groupByItGb.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      margin="0"
      rowBackgroundColor="{{ currentSourceRow.br_cd === '소계'? '01488F33' :
  currentSourceRow.br_cd === '총계'? '01488F66' :'ffffff' }}"
      rowSelection="none"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      style={{}}
    >
      <Column
        id="1ee20"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="it_gb_nm"
        label="중분류"
        placeholder="Enter value"
        position="left"
        size={83.859375}
        sortMode="disabled"
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.br_cd === '총계' ? '총계':
  currentSourceRow.br_cd === '소계' ? '' : item }}"
      />
      <Column
        id="8ba33"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="br_nm"
        label="브랜드"
        placeholder="Enter value"
        position="left"
        size={115.46875}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.br_cd === '총계' ? '':
  currentSourceRow.br_cd === '소계' ? '소계' : item }}"
      />
      <Column
        id="40b72"
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
        size={114.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="5f8b9"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={96.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="b27ce"
        alignment="right"
        backgroundColor="rgba(253, 230, 138, 0.33)"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={85.078125}
        summaryAggregationMode="none"
      />
      <Column
        id="ffb7d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        label="25년 할인율"
        placeholder="Enter value"
        position="center"
        referenceId="25년할인율"
        size={92.453125}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.cur_amt/currentSourceRow.cur_tag) }}"
      />
      <Column
        id="d0ebf"
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
        size={109.046875}
        summaryAggregationMode="none"
      />
      <Column
        id="0340b"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={84.421875}
        summaryAggregationMode="none"
      />
      <Column
        id="8277b"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
      />
      <Column
        id="dd6af"
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
        size={76.671875}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.prev_amt/currentSourceRow.prev_tag) }}"
      />
      <Column
        id="db2f9"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={57.515625}
        summaryAggregationMode="none"
        textColor={'{{ item > 0 ? "black" : "red" }}'}
        valueOverride="{{ currentSourceRow.cur_amt-currentSourceRow.prev_amt }}"
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
        size={62.046875}
        summaryAggregationMode="none"
        textColor={'{{ item > 0 ? "black" : "red" }}'}
        valueOverride="{{ (currentSourceRow.cur_amt-currentSourceRow.prev_amt)/currentSourceRow.prev_amt }}"
      />
      <Column
        id="ffcef"
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
        size={73.078125}
        summaryAggregationMode="none"
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
        size={87.453125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_cost / currentSourceRow.cur_tag }}"
      />
      <Column
        id="e8aaa"
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
        size={76.296875}
        summaryAggregationMode="none"
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
        size={88.671875}
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
        size={57.515625}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_cost-currentSourceRow.prev_cost }}"
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
        size={71.28125}
        summaryAggregationMode="none"
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
                    { includeHiddenColumns: false },
                    {
                      fileName:
                        "{{ text1.value.slice(5) }}_{{ tabs1.value }}_({{ dateRange.value.start }}~{{ dateRange.value.end }})",
                    },
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
        method="run"
        params={{
          ordered: [
            {
              src: "selectedRow_old.setValue(currentSourceRow)\nmodalFrameShopList.show()\ngetOutByShop.trigger()",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </View>
  <View
    id="53b8e"
    disabled={false}
    hidden={false}
    iconPosition="left"
    viewKey="소분류별"
  >
    <Table
      id="table5"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ groupByItem.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      margin="0"
      rowBackgroundColor="{{ currentSourceRow.br_cd === '소계'? '01488F33' :
  currentSourceRow.br_cd === '총계'? '01488F66' :'ffffff' }}"
      rowSelection="none"
      showFooter={true}
      showHeader={true}
      style={{}}
    >
      <Column
        id="1ee20"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="it_gb_nm"
        label="중분류"
        placeholder="Enter value"
        position="left"
        size={83.859375}
        sortMode="disabled"
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.br_cd === '총계' ? '총계':
  currentSourceRow.br_cd === '소계' ? '' : item }}"
      />
      <Column
        id="53be4"
        alignment="left"
        format="multilineString"
        groupAggregationMode="none"
        key="item_nm"
        label="소분류"
        placeholder="Enter value"
        position="left"
        size={156}
        sortMode="disabled"
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.br_cd === '소계' ? '': item }}"
      />
      <Column
        id="8ba33"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="br_nm"
        label="브랜드"
        placeholder="Enter value"
        position="left"
        size={110.15625}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.br_cd === '총계' ? '':
  currentSourceRow.br_cd === '소계' ? '소계' : item }}"
      />
      <Column
        id="40b72"
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
        size={106.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="5f8b9"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
      />
      <Column
        id="b27ce"
        alignment="right"
        backgroundColor="rgba(253, 230, 138, 0.33)"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={88.453125}
        summaryAggregationMode="none"
      />
      <Column
        id="ffb7d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        label="25년 할인율"
        placeholder="Enter value"
        position="center"
        referenceId="25년할인율"
        size={83.453125}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.cur_amt/currentSourceRow.cur_tag) }}"
      />
      <Column
        id="d0ebf"
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
        size={104.046875}
        summaryAggregationMode="none"
      />
      <Column
        id="0340b"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={100.65625}
        summaryAggregationMode="none"
      />
      <Column
        id="8277b"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={90.671875}
        summaryAggregationMode="none"
      />
      <Column
        id="dd6af"
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
        size={87.671875}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.prev_amt/currentSourceRow.prev_tag) }}"
      />
      <Column
        id="db2f9"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={57.515625}
        summaryAggregationMode="none"
        textColor={'{{ item > 0 ? "black" : "red" }}'}
        valueOverride="{{ currentSourceRow.cur_amt-currentSourceRow.prev_amt }}"
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
        size={62.140625}
        summaryAggregationMode="none"
        textColor={'{{ item > 0 ? "black" : "red" }}'}
        valueOverride="{{ (currentSourceRow.cur_amt-currentSourceRow.prev_amt)/currentSourceRow.prev_amt }}"
      />
      <Column
        id="ffcef"
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
        size={84.078125}
        summaryAggregationMode="none"
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
        size={85.453125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_cost / currentSourceRow.cur_tag }}"
      />
      <Column
        id="e8aaa"
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
        size={76.296875}
        summaryAggregationMode="none"
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
        size={90.671875}
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
        size={57.515625}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_cost-currentSourceRow.prev_cost }}"
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
        size={71.28125}
        summaryAggregationMode="none"
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
                    { includeHiddenColumns: false },
                    {
                      fileName:
                        "{{ text1.value.slice(5) }}_{{ tabs1.value }}_({{ dateRange.value.start }}~{{ dateRange.value.end }})",
                    },
                  ],
                },
              },
            ],
          }}
          pluginId="table5"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="run"
        params={{
          ordered: [
            {
              src: "selectedRow_old.setValue(currentSourceRow)\nmodalFrameShopList.show()\ngetOutByShop.trigger()",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </View>
  <View
    id="4024e"
    disabled={false}
    hidden={false}
    iconPosition="left"
    viewKey="서브브랜드별"
  >
    <Table
      id="table6"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ groupBySubBrand.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      margin="0"
      rowBackgroundColor="{{ currentSourceRow.sub_br_cd === '소계' ? '01488F33' :
  currentSourceRow.sub_br_cd === '총계'? '01488F66': 'ffffff' }}"
      rowSelection="none"
      showFooter={true}
      showHeader={true}
      style={{}}
    >
      <Column
        id="8ba33"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="br_nm"
        label="브랜드"
        placeholder="Enter value"
        position="left"
        size={111.46875}
        sortMode="disabled"
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.br_cd === '총계' ? '총계':
  currentSourceRow.sub_br_cd === '소계' ? '' : item }}"
      />
      <Column
        id="42569"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sub_br_nm"
        label="서브브랜드"
        placeholder="Enter value"
        position="left"
        size={115}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.br_cd === '총계' ? '':
  currentSourceRow.sub_br_cd === '소계' ? '소계' : item }}"
      />
      <Column
        id="40b72"
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
        size={99.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="5f8b9"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
      />
      <Column
        id="b27ce"
        alignment="right"
        backgroundColor="rgba(253, 230, 138, 0.33)"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={87.453125}
        summaryAggregationMode="none"
      />
      <Column
        id="ffb7d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        label="25년 할인율"
        placeholder="Enter value"
        position="center"
        referenceId="25년할인율"
        size={89.453125}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.cur_amt/currentSourceRow.cur_tag) }}"
      />
      <Column
        id="d0ebf"
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
        size={102.046875}
        summaryAggregationMode="none"
      />
      <Column
        id="0340b"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={100.65625}
        summaryAggregationMode="none"
      />
      <Column
        id="8277b"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={91.671875}
        summaryAggregationMode="none"
      />
      <Column
        id="dd6af"
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
        size={93.671875}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.prev_amt/currentSourceRow.prev_tag) }}"
      />
      <Column
        id="db2f9"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        size={57.515625}
        summaryAggregationMode="none"
        textColor={'{{ item > 0 ? "black" : "red" }}'}
        valueOverride="{{ currentSourceRow.cur_amt-currentSourceRow.prev_amt }}"
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
        size={72.078125}
        summaryAggregationMode="none"
        textColor={'{{ item > 0 ? "black" : "red" }}'}
        valueOverride="{{ (currentSourceRow.cur_amt-currentSourceRow.prev_amt)/currentSourceRow.prev_amt }}"
      />
      <Column
        id="ffcef"
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
        size={82.078125}
        summaryAggregationMode="none"
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
        size={100.453125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_cost / currentSourceRow.cur_tag }}"
      />
      <Column
        id="e8aaa"
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
        size={87.296875}
        summaryAggregationMode="none"
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
        size={96.671875}
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
        size={65.515625}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_cost-currentSourceRow.prev_cost }}"
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
        size={71.28125}
        summaryAggregationMode="none"
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
                    { includeHiddenColumns: false },
                    {
                      fileName:
                        "{{ text1.value.slice(5) }}_{{ tabs1.value }}_({{ dateRange.value.start }}~{{ dateRange.value.end }})",
                    },
                  ],
                },
              },
            ],
          }}
          pluginId="table6"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="run"
        params={{
          ordered: [
            {
              src: "selectedRow_old.setValue(currentSourceRow)\nmodalFrameShopList.show()\ngetOutByShop.trigger()",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </View>
</Container>
