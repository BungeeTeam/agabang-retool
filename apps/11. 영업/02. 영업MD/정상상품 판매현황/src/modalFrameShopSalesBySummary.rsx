<ModalFrame
  id="modalFrameShopSalesBySummary"
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
      id="text52"
      value="### {{ varShopSalesSummary.value.category_name }} 매장별 판매데이터({{ tabs1.selectedLabel }})"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton2"
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
        pluginId="modalFrameShopSalesBySummary"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text53"
      disableMarkdown={true}
      margin="0px 8px"
      value="* 기간: {{dateRange.value.start }} ~ {{ dateRange.value.end}} | 단위: 천원"
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Table
      id="table10"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopSalesSummary.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      groupByColumns={{}}
      hidden="{{ select1.value != 'period' }}"
      limitOffsetRowCount="350"
      margin="0"
      rowBackgroundColor="{{ 
  currentSourceRow.shop_nm === '총계' ? '01488f60' :
  'ffffff' }}"
      rowHeight="medium"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      templatePageSize="10"
    >
      <Column
        id="b8698"
        alignment="left"
        caption="{{ currentSourceRow.shop_cd }}"
        format="multilineString"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명
"
        placeholder="Enter value"
        position="left"
        size={144.3125}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="run"
          params={{
            ordered: [
              {
                src: "utils.copyToClipboard(currentSourceRow.shop_cd)\nutils.showNotification(\n  {\n    title: '매장코드가 복사되었습니다.',\n    notificationType: 'success',\n  duration: '40000'}\n)",
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="1031d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_cd"
        label="매장코드"
        placeholder="Enter value"
        position="center"
        size={100}
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
        label="{{ tableHeader.value[2] }} (기간)"
        placeholder="Enter value"
        position="center"
        referenceId="cur_rev"
        size={93.828125}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000).toFixed(0) }}"
      />
      <Column
        id="3ff11"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cur_qty"
        label="{{ tableHeader.value[20] }} (기간)"
        placeholder="Enter value"
        position="center"
        referenceId="cur_qty"
        size={113.59375}
        summaryAggregationMode="none"
      />
      <Column
        id="72a17"
        alignment="right"
        cellTooltip="{{ (item*1000).toLocaleString() }}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="cur_tot_rev"
        label="{{tableHeader.value[28]}}"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_qty"
        size={89}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="f071d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cur_tot_qty"
        label="{{tableHeader.value[29]}}"
        placeholder="Enter value"
        position="center"
        size={111}
      />
      <Column
        id="05384"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        key="cur_sale_rate_amt"
        label="{{ tableHeader.value[19] }}"
        placeholder="Enter value"
        position="center"
        referenceId="tableHeaderValue19"
        size={126.734375}
        valueOverride="{{ currentSourceRow.cur_tot_rev/currentSourceRow.cur_sup_amt }}"
      />
      <Column
        id="92112"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        key="cur_sale_rate_qty"
        label="{{tableHeader.value[18]}}"
        placeholder="Enter value"
        position="center"
        referenceId="tableHeaderValue18"
        size={121.34375}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_tot_qty/currentSourceRow.cur_out_qty }}"
      />
      <Column
        id="0dac4"
        alignment="right"
        cellTooltip="{{ (item*1000).toLocaleString() }}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="cur_sup_amt"
        label="{{ tableHeader.value[22] }}"
        placeholder="Enter value"
        position="center"
        size={115.59375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="e1806"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cur_out_qty"
        label="{{ tableHeader.value[21] }}"
        placeholder="Enter value"
        position="center"
        size={119.59375}
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
        size={112.21875}
        valueOverride="{{ 1-currentSourceRow.cur_rev/item }}"
      />
      <Column
        id="c21f5"
        alignment="right"
        cellTooltip="{{ (item*1000).toLocaleString() }}"
        cellTooltipMode="custom"
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
        label="{{ checkboxTreeNew1.values[4] }} (기간)"
        placeholder="Enter value"
        position="center"
        referenceId="{{ checkboxTreeNew1.values[4] }}"
        size={96.0625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000) }}"
      />
      <Column
        id="188ae"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="prev_qty"
        label="{{ tableHeader.value[23] }} (기간)"
        placeholder="Enter value"
        position="center"
        referenceId="tableHeaderValue23기간"
        size={107.8125}
      />
      <Column
        id="7c448"
        alignment="right"
        cellTooltip="{{ (item*1000).toLocaleString() }}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="prev_tot_rev"
        label="{{tableHeader.value[30]}}"
        placeholder="Enter value"
        position="center"
        size={93}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="a7942"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="prev_tot_qty"
        label="{{tableHeader.value[31]}}"
        placeholder="Enter value"
        position="center"
        size={105}
      />
      <Column
        id="18b39"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        key="prev_sale_rate_amt"
        label="{{ tableHeader.value[27] }}"
        placeholder="Enter value"
        position="center"
        referenceId="tableHeaderValue27"
        size={133.5625}
        valueOverride="{{ currentSourceRow.prev_tot_rev/currentSourceRow.prev_sup_amt }}"
      />
      <Column
        id="6fcfa"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        key="prev_sale_rate_qty"
        label="{{ tableHeader.value[26] }}"
        placeholder="Enter value"
        position="center"
        size={121.953125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.prev_tot_qty/currentSourceRow.prev_out_qty }}"
      />
      <Column
        id="d69ca"
        alignment="right"
        cellTooltip="{{ (item*1000).toLocaleString() }}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="prev_sup_amt"
        label="{{tableHeader.value[24]}}"
        placeholder="Enter value"
        position="center"
        referenceId="tableHeaderValue24"
        size={115.8125}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="82615"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="prev_out_qty"
        label="{{ tableHeader.value[25] }}"
        placeholder="Enter value"
        position="center"
        referenceId="tableHeaderValue25"
        size={123.8125}
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
        size={113.4375}
        valueOverride="{{ 1-(currentSourceRow.prev_rev/item) }}"
      />
      <Column
        id="03295"
        alignment="right"
        cellTooltip="{{ (item*1000).toLocaleString() }}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[6] ) }}"
        label="{{ tableHeader.value[6] }}"
        placeholder="Enter value"
        position="center"
        referenceId="매출 증감"
        size={100.515625}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.cur_rev-currentSourceRow.prev_rev)/1000).toFixed(0) }}"
      />
      <Column
        id="7a2c5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        label="입고량 증감"
        placeholder="Enter value"
        position="center"
        referenceId="in_qty_diff"
        size={99.28125}
        valueOverride="{{ currentSourceRow.cur_out_qty-currentSourceRow.prev_out_qty }}"
      />
      <Column
        id="8faa1"
        alignment="right"
        cellTooltip="{{ (item*1000).toLocaleString() }}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="입고금액 증감"
        placeholder="Enter value"
        position="center"
        referenceId="in_amt_diff"
        size={106.65625}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.cur_sup_amt - currentSourceRow.prev_sup_amt)/1000 }}"
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
        size={81.28125}
        valueOverride="{{ ratio = currentSourceRow.prev_rev === 0 
  ? 0 
  :(currentSourceRow.cur_rev / currentSourceRow.prev_rev)-1 }}"
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
                        "{{bizSelect.selectedLabels}} {{ text50.value.slice(4) }} ({{ moment(dateRange.value.start).format('YYYY-MM-DD') }}~{{ moment(dateRange.value.end).format('YYYY-MM-DD') }})",
                    },
                    { includeHiddenColumns: true },
                  ],
                },
              },
            ],
          }}
          pluginId="table10"
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
