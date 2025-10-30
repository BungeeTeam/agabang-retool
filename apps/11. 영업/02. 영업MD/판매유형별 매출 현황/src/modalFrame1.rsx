<ModalFrame
  id="modalFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showFooter={true}
  showHeader={true}
  showOverlay={true}
  size="medium"
>
  <Header>
    <Text id="modalTitle1" value="### Container title" verticalAlign="center" />
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
        pluginId="modalFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Table
      id="table3"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ periodic.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="{{ select1.value != 'period' }}"
      margin="0"
      rowBackgroundColor="{{ currentSourceRow.season_nm === '소계' ? '01488f33' :
  currentSourceRow.season_nm === '총계' ? '01488f60' :
  'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
    >
      <Column
        id="5c5f4"
        alignment="left"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="sales_type"
        label="정상/이월"
        placeholder="Enter value"
        position="center"
        size={61.453125}
        summaryAggregationMode="none"
      />
      <Column
        id="b0152"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="season_nm"
        label="시즌"
        placeholder="Enter value"
        position="center"
        size={67.734375}
        summaryAggregationMode="none"
      />
      <Column
        id="c5d5d"
        alignment="right"
        backgroundColor="{{  'FDE68A60'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "",
        }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes( tableHeader.value[2]) }}"
        key="cur_rev"
        label="{{ tableHeader.value[2] }}"
        placeholder="Enter value"
        position="center"
        referenceId="cur_rev"
        size={117.46875}
        summaryAggregationMode="none"
      />
      <Column
        id="0db0c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[1]) }}"
        key="target_sales"
        label="{{ tableHeader.value[1] }}"
        placeholder="Enter value"
        position="center"
        referenceId="tableHeaderValue1"
        size={105.453125}
        summaryAggregationMode="none"
      />
      <Column
        id="4fe2f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[7]) }}"
        label="{{ tableHeader.value[7]  }}"
        placeholder="Enter value"
        position="center"
        referenceId="{{ tableHeader.value[7] }}"
        size={61.046875}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_rev/currentSourceRow.target_sales }}"
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
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[4]) }}"
        key="prev_rev"
        label="{{ tableHeader.value[4] }}"
        placeholder="Enter value"
        position="center"
        referenceId="{{ tableHeader.value[4] }}"
        size={78.625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000) }}"
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
        size={122.453125}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.cur_rev-currentSourceRow.prev_rev) }}"
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
        size={50.3125}
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
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[10]) }}"
        key="cur_cost"
        label="{{tableHeader.value[10]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[10]}}"
        size={116.828125}
        summaryAggregationMode="none"
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
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[12]) }}"
        key="prev_cost"
        label="{{tableHeader.value[12]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[12]}}"
        size={125.0625}
        summaryAggregationMode="none"
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
        size={90.515625}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.cur_cost-currentSourceRow.prev_cost) }}"
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
          pluginId="table3"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="selectRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ current_user }}" }] }}
        pluginId="unitList"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Body>
</ModalFrame>
