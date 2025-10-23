<ModalFrame
  id="modalFrameShopSalesByCategory"
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
      id="text50"
      value="### {{ varShopSalesCatogory.value?.season_nm }} {{ varShopSalesCatogory.value?.category_name }} 매장별 판매데이터({{ tabs1.selectedLabel }})"
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
        pluginId="modalFrameShopSalesByCategory"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text51"
      margin="0px 8px"
      value="조회 기간: {{dateRange.value.start }} ~ {{ dateRange.value.end}} | 단위: 천원

하기 표에서 누적 매출 및 판매율은 **‘조회기간에 매출이 발생한 상품’의 출시 이후부터 조회기간 종료일까지의 누적 판매 실적**을 뜻합니다.
따라서 조회기간이 달라질 경우, 누적 데이터 집계에 포함되는 연도코드가 달라질 수 있습니다.
* 조회기간 누적매출 집계 대상 연도코드: {{ salesCumYearSeason.data.filter(i=>i.period_type ==='CURR').map(i => i.year_season_cd) }}
* 전년동기 누적매출 집계 대상 연도코드: {{ salesCumYearSeason.data.filter(i=>i.period_type ==='PREV').map(i => i.year_season_cd) }}"
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Table
      id="table9"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopSalesCatogory.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      groupByColumns={{}}
      hidden="{{ select1.value != 'period' }}"
      limitOffsetRowCount="350"
      margin="0"
      primaryKeyColumnId="b8698"
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
        editable={false}
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="center"
        size={265.3125}
      />
      <Column
        id="c5d5d"
        alignment="right"
        backgroundColor="{{  'FDE68A60'}}"
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
        key="cur_rev"
        label="조회기간 실매출"
        placeholder="Enter value"
        position="center"
        referenceId="cur_rev"
        size={98.828125}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="3ff11"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cur_qty"
        label="조회기간 판매수량"
        placeholder="Enter value"
        position="center"
        referenceId="cur_qty"
        size={110.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="0df59"
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
        label="조회기간 판매상품 누적 실매출"
        placeholder="Enter value"
        position="center"
        referenceId="조회기간판매상품누적실매출"
        size={106}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="dd6ad"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cur_tot_qty"
        label="조회기간 판매상품 누적 판매수량"
        placeholder="Enter value"
        position="center"
        size={106}
        summaryAggregationMode="none"
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
        label="조회기간 판매상품 누적 판매율(실판가)"
        placeholder="Enter value"
        position="center"
        referenceId="조회기간판매상품누적판매율실판가"
        size={114.734375}
        summaryAggregationMode="none"
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
        label="조회기간 판매상품 누적 판매율 (수량)"
        placeholder="Enter value"
        position="center"
        referenceId="조회기간판매상품누적판매율수량"
        size={113.34375}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_tot_qty / currentSourceRow.cur_out_qty }}"
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
        label="조회기간 판매상품 입고금액"
        placeholder="Enter value"
        position="center"
        size={110.21875}
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
        label="조회기간 판매상품 입고수량"
        placeholder="Enter value"
        position="center"
        size={106.21875}
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
        label="조회기간 판매상품 할인율"
        placeholder="Enter value"
        position="center"
        size={107.21875}
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
        key="prev_rev"
        label="전년동기 실매출"
        placeholder="Enter value"
        position="center"
        referenceId="전년동기 실매출"
        size={105.0625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="188ae"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="prev_qty"
        label="전년동기 판매수량"
        placeholder="Enter value"
        position="center"
        referenceId="전년동기판매수량"
        size={118}
        summaryAggregationMode="none"
      />
      <Column
        id="653aa"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="prev_tot_rev"
        label="전년동기 판매상품 누적 실매출"
        placeholder="Enter value"
        position="center"
        referenceId="column29"
        size={112}
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="92d24"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="prev_tot_qty"
        label="전년동기 판매상품 누적 판매수량"
        placeholder="Enter value"
        position="center"
        size={113}
        summaryAggregationMode="none"
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
        label="전년동기 판매상품 누적 판매율 (실판가)"
        placeholder="Enter value"
        position="center"
        referenceId="전년동기판매상품누적판매율실판가"
        size={114}
        summaryAggregationMode="none"
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
        label="전년동기 판매상품 누적 판매율 (수량)"
        placeholder="Enter value"
        position="center"
        referenceId="전년동기판매상품누적판매율수량"
        size={105}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.prev_tot_qty/currentSourceRow.prev_out_qty || 0 }}"
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
        label="전년동기 판매상품 입고금액"
        placeholder="Enter value"
        position="center"
        referenceId="전년동기판매상품입고금액"
        size={110}
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
        label="전년동기 판매상품 입고수량"
        placeholder="Enter value"
        position="center"
        referenceId="전년동기판매상품입고수량"
        size={106}
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
        label="전년동기 판매상품 할인율"
        placeholder="Enter value"
        position="center"
        referenceId="작년 할인율"
        size={104.515625}
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
        label="{{ tableHeader.value[6] }}"
        placeholder="Enter value"
        position="center"
        referenceId="매출 증감"
        size={91.515625}
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
        referenceId="out_qty_diff"
        size={86}
        valueOverride="{{ currentSourceRow.cur_out_qty-currentSourceRow.prev_out_qty }}"
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
        size={47.140625}
        valueOverride="{{ currentSourceRow.cur_rev/currentSourceRow.target_sales }}"
      />
      <Column
        id="8faa1"
        alignment="right"
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
        referenceId="out_amt_diff"
        size={100}
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
        label="{{tableHeader.value[8]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[8]}}"
        size={89.84375}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.cur_rev / currentSourceRow.prev_rev)-1 || 0 }}"
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
                    { includeHiddenColumns: false },
                  ],
                },
              },
            ],
          }}
          pluginId="table9"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</ModalFrame>
