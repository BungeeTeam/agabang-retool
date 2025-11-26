<Container
  id="container5"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  margin="0"
  padding="12px"
  showBody={true}
>
  <View id="e4d73" viewKey="View 1">
    <Tabs id="tabs1" itemMode="static" value="{{ self.values[0] }}">
      <Option id="d3d24" label="오프라인" value="오프라인" />
      <Option id="47702" label="온라인" value="온라인" />
      <Option id="215bc" label="온오프라인 합계" value="합계" />
    </Tabs>
    <DateRange
      id="dateRange"
      dateFormat="yyyy-MM-dd"
      disabled=""
      endPlaceholder="End date"
      firstDayOfWeek={0}
      hidden=""
      iconBefore="bold/interface-calendar-remove-alternate"
      label=""
      labelPosition="top"
      startPlaceholder="Start date"
      textBefore="조회기간"
      textBetween="-"
      value={{
        ordered: [
          {
            start:
              "{{ moment().subtract(1,'days').startOf('month').format('YYYY-MM-DD') }}",
          },
          { end: "{{ moment().subtract(1,'days').format('YYYY-MM-DD') }}" },
        ],
      }}
    />
    <Text id="text3" value="###### [요약]" verticalAlign="center" />
    <Text
      id="text48"
      disableMarkdown={true}
      horizontalAlign="right"
      margin="0px 8px"
      value="* 기간: {{dateRange.value.start }} ~ {{ dateRange.value.end}} | 단위: 백만원"
      verticalAlign="center"
    />
    <Table
      id="table5"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ summary.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="{{ select1.value != 'period' }}"
      margin="0"
      rowBackgroundColor="{{ currentSourceRow.category_name === '소계' ? '01488f33' :
  currentSourceRow.category_name === '총계' ? '01488f60' :
  'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
    >
      <Column
        id="effbc"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="category_name"
        label="대분류"
        placeholder="Enter value"
        position="center"
        size={67.921875}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="c5d5d"
        alignment="right"
        backgroundColor="{{  'FDE68A60'}}"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes( tableHeader.value[2]) }}"
        key="cur_rev"
        label="{{ tableHeader.value[2] }}"
        placeholder="Enter value"
        position="center"
        referenceId="cur_rev"
        size={78.515625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="d0997"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[16]) }}"
        key="cur_sale_rate"
        label="{{ tableHeader.value[16] }}"
        placeholder="Enter value"
        position="center"
        referenceId="tableHeaderValue16"
        size={99.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="62cc1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[3]) }}"
        key="cur_tag"
        label="{{ tableHeader.value[3] }}"
        placeholder="Enter value"
        position="center"
        size={88.890625}
        summaryAggregationMode="none"
        valueOverride="{{ 1-currentSourceRow.cur_rev/item }}"
      />
      <Column
        id="c21f5"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[4]) }}"
        key="prev_rev"
        label="{{ checkboxTreeNew1.values[4] }}"
        placeholder="Enter value"
        position="center"
        referenceId="{{ checkboxTreeNew1.values[4] }}"
        size={78.671875}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="648e3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[17]) }}"
        key="prev_sale_rate"
        label="{{ tableHeader.value[17] }}"
        placeholder="Enter value"
        position="center"
        size={99.40625}
        summaryAggregationMode="none"
      />
      <Column
        id="f9e44"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[5]) }}"
        key="prev_tag"
        label="{{ tableHeader.value[5] }}"
        placeholder="Enter value"
        position="center"
        referenceId="작년 할인율"
        size={89.03125}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.prev_rev/item) }}"
      />
      <Column
        id="03295"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString() }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[6] ) }}"
        label="{{ tableHeader.value[6] }}"
        placeholder="Enter value"
        position="center"
        referenceId="매출증감"
        size={57.484375}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.cur_rev-currentSourceRow.prev_rev)/1000000).toFixed(0) }}"
      />
      <Column
        id="cbaee"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[8]) }}"
        label="{{tableHeader.value[8]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[8]}}"
        size={70.859375}
        summaryAggregationMode="none"
        valueOverride="{{ ratio = currentSourceRow.prev_rev === 0 
  ? 0 
  : (currentSourceRow.cur_rev / currentSourceRow.prev_rev)-1}}"
      />
      <Column
        id="afb07"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[10]) }}"
        key="cur_cost"
        label="{{tableHeader.value[10]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[10]}}"
        size={79.828125}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="7562d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[11]) }}"
        label="{{tableHeader.value[11]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[11]}}"
        size={90.21875}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_cost/currentSourceRow.cur_tag }}"
      />
      <Column
        id="6262b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[12]) }}"
        key="prev_cost"
        label="{{tableHeader.value[12]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[12]}}"
        size={80.0625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="70b98"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[13]) }}"
        key="prev_cost"
        label="{{tableHeader.value[13]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[13]}}"
        size={90.4375}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.prev_cost/currentSourceRow.prev_tag }}"
      />
      <Column
        id="d68b5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[14]) }}"
        label="{{tableHeader.value[14]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[14]}}"
        size={57.515625}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.cur_cost-currentSourceRow.prev_cost)/1000000).toFixed(0) }}"
      />
      <Column
        id="0a7ee"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[15]) }}"
        label="{{tableHeader.value[15]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[15]}}"
        size={67.90625}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.cur_cost/currentSourceRow.cur_tag)-(currentSourceRow.prev_cost/currentSourceRow.prev_tag) }}"
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
                        "({{ dateRange.value.end}} 마감) 정상/이월 판매데이터",
                    },
                    { includeHiddenColumns: false },
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
              src: "varShopSalesSummary.setValue(currentSourceRow)\nshopSalesSummary.trigger()\nmodalFrameShopSalesBySummary.show()",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Text id="text4" value="###### [시즌별 판매율]" verticalAlign="center" />
    <Text
      id="text49"
      disableMarkdown={true}
      horizontalAlign="right"
      margin="0px 8px"
      value="* 기간: {{dateRange.value.start }} ~ {{ dateRange.value.end}} | 단위: 백만원"
      verticalAlign="center"
    />
    <Table
      id="table4"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ periodicSalesByCategory.value }}"
      defaultFilters={{
        0: {
          ordered: [
            { id: "74fd3" },
            { columnId: "effbc" },
            { operator: "!=" },
            { value: "총계" },
            { disabled: false },
          ],
        },
      }}
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="{{ select1.value != 'period' }}"
      margin="0"
      rowBackgroundColor="{{ currentSourceRow.category_name === '소계' ? '01488f33' :
  currentSourceRow.category_name === '총계' ? '01488f60' :
  'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{}}
    >
      <Column
        id="b0152"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="season_nm"
        label="시즌"
        placeholder="Enter value"
        position="center"
        size={47.078125}
        summaryAggregationMode="none"
      />
      <Column
        id="effbc"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="category_name"
        label="대분류"
        placeholder="Enter value"
        position="center"
        size={67.890625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="c5d5d"
        alignment="right"
        backgroundColor="{{  'FDE68A60'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes( tableHeader.value[2]) }}"
        key="cur_rev"
        label="{{ tableHeader.value[2] }}"
        placeholder="Enter value"
        position="center"
        referenceId="cur_rev"
        size={78.46875}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="d0997"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[16]) }}"
        key="cur_sale_rate"
        label="{{ tableHeader.value[16] }}"
        placeholder="Enter value"
        position="center"
        referenceId="tableHeaderValue16"
        size={99.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="62cc1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[3]) }}"
        key="cur_tag"
        label="{{ tableHeader.value[3] }}"
        placeholder="Enter value"
        position="center"
        size={88.84375}
        summaryAggregationMode="none"
        valueOverride="{{ 1-currentSourceRow.cur_rev/item }}"
      />
      <Column
        id="c21f5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[4]) }}"
        key="prev_rev"
        label="{{ checkboxTreeNew1.values[4] }}"
        placeholder="Enter value"
        position="center"
        referenceId="{{ checkboxTreeNew1.values[4] }}"
        size={78.625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="648e3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[17]) }}"
        key="prev_sale_rate"
        label="{{ tableHeader.value[17] }}"
        placeholder="Enter value"
        position="center"
        size={99.359375}
        summaryAggregationMode="none"
      />
      <Column
        id="f9e44"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[5]) }}"
        key="prev_tag"
        label="{{ tableHeader.value[5] }}"
        placeholder="Enter value"
        position="center"
        referenceId="작년 할인율"
        size={88.984375}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.prev_rev/item) }}"
      />
      <Column
        id="03295"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[6] ) }}"
        label="{{ tableHeader.value[6] }}"
        placeholder="Enter value"
        position="center"
        referenceId="매출증감"
        size={57.453125}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.cur_rev-currentSourceRow.prev_rev)/1000000).toFixed(0) }}"
      />
      <Column
        id="cbaee"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[8]) }}"
        label="{{tableHeader.value[8]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[8]}}"
        size={70.828125}
        summaryAggregationMode="none"
        valueOverride="{{ ratio = currentSourceRow.prev_rev === 0 
  ? 0 
  : (currentSourceRow.cur_rev / currentSourceRow.prev_rev)-1 }}"
      />
      <Column
        id="afb07"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[10]) }}"
        key="cur_cost"
        label="{{tableHeader.value[10]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[10]}}"
        size={79.828125}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="7562d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[11]) }}"
        label="{{tableHeader.value[11]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[11]}}"
        size={90.21875}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_cost/currentSourceRow.cur_tag }}"
      />
      <Column
        id="6262b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[12]) }}"
        key="prev_cost"
        label="{{tableHeader.value[12]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[12]}}"
        size={80.0625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="70b98"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[13]) }}"
        key="prev_cost"
        label="{{tableHeader.value[13]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[13]}}"
        size={90.4375}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.prev_cost/currentSourceRow.prev_tag }}"
      />
      <Column
        id="d68b5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[14]) }}"
        label="{{tableHeader.value[14]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[14]}}"
        size={57.515625}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.cur_cost-currentSourceRow.prev_cost)/1000000).toFixed(0) }}"
      />
      <Column
        id="0a7ee"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[15]) }}"
        label="{{tableHeader.value[15]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[15]}}"
        size={67.90625}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.cur_cost/currentSourceRow.cur_tag)-(currentSourceRow.prev_cost/currentSourceRow.prev_tag) }}"
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
                        "({{ dateRange.value.end}} 마감) 정상/이월 판매데이터",
                    },
                    { includeHiddenColumns: false },
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
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="varShopSalesCatogory"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="shopSalesCatogory"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="run"
        params={{
          ordered: [
            {
              src: "varShopSalesCatogory.setValue(currentSourceRow)\nshopSalesCatogory.trigger()\nmodalFrameShopSalesByCategory.show()",
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
