<SplitPaneFrame
  id="splitPaneFrame1"
  _resizeHandleEnabled={true}
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden=""
  isHiddenOnMobile={true}
  padding="8px 4px"
  position="right"
  showFooterBorder={false}
  showHeaderBorder={false}
  width="40%"
>
  <Button
    id="button1"
    iconAfter="bold/interface-delete-1"
    style={{ ordered: [{ background: "rgba(1, 72, 143, 0)" }] }}
    text="닫기"
  >
    <Event
      event="click"
      method="setValue"
      params={{ ordered: [{ value: "false" }] }}
      pluginId="toggleButton1"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="click"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="setShopListFrameHidden"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </Button>
  <Text
    id="text14"
    value="###### 매장별 {{yearSelect2.selectedItem.year_nm }} {{ varSelectedRow.value.season_nm }} | {{ varSelectedRow.value.item_grade }}등급 {{ varSelectedRow.value.category_name }} ({{ tabs1.selectedLabel }})"
    verticalAlign="center"
  />
  <Text
    id="text45"
    disableMarkdown={true}
    margin="0px 8px"
    value="* 기간: {{ yearSelect2.selectedItem.season_end_dt }} ~ {{ moment(endDate.value).format('YYYY-MM-DD') }} | 단위: 수량-개, 금액-천원"
    verticalAlign="center"
  />
  <Table
    id="table26"
    cellSelection="none"
    clearChangesetOnSave={true}
    data="{{ varSelectedRow.value?.category_name === '소계'? groupByGrade.value.filter(i => 
  (tabs1.value === '합계'? 1===1 : i.onoff_flag === tabs1.value) &&
  i.item_grade === varSelectedRow.value.item_grade &&
  i.season_nm === varSelectedRow.value.season_nm).sort((a,b)=> (a.sale_tag/a.net_out_tag) - (b.sale_tag/b.net_out_tag))
  
  :varSelectedRow.value?.category_name === '총계'? groupByShop.value.filter(i => 
  (tabs1.value === '합계'? 1===1 : i.onoff_flag === tabs1.value)).sort((a,b)=> (a.sale_tag/a.net_out_tag) - (b.sale_tag/b.net_out_tag))
  
  : mergeCurOutSale.value.filter(i => 
  (tabs1.value === '합계'? 1===1 : i.onoff_flag === tabs1.value) &&
  i.item_grade === varSelectedRow.value.item_grade &&
  i.season_nm === varSelectedRow.value.season_nm&&
  i.category_name === varSelectedRow.value.category_name).sort((a,b)=> (a.sale_tag/a.net_out_tag) - (b.sale_tag/b.net_out_tag)) }}"
    defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
    emptyMessage="No rows found"
    enableSaveActions={true}
    rowBackgroundColor=""
    rowHeight="medium"
    rowSelection="none"
    showBorder={true}
    showColumnBorders={true}
    showFooter={true}
    showHeader={true}
    style={{ headerBackground: "tokens/356f4e7b" }}
  >
    <Column
      id="3d55a"
      alignment="left"
      editableOptions={{ showStepper: true }}
      format="string"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="shop_cd"
      label="매장코드"
      placeholder="Enter value"
      position="center"
      referenceId="column25"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="cf3b8"
      alignment="left"
      caption="{{ currentSourceRow.shop_cd }}"
      format="multilineString"
      groupAggregationMode="none"
      key="shop_nm"
      label="매장명"
      placeholder="Enter value"
      position="left"
      size={160}
    />
    <Column
      id="facb8"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{!checkboxTreeNew1.value.includes(1) }}"
      key="net_out_tag"
      label="순출고금액(TAG)"
      placeholder="Enter value"
      position="center"
      size={96.890625}
      tooltip="(출고-반품)"
      valueOverride="{{ (item/1000).toFixed(0) }}"
    />
    <Column
      id="8349c"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="net_out_tag"
      label="순출고금액(실판가)"
      placeholder="Enter value"
      position="center"
      referenceId="column26"
      size={81.734375}
      tooltip="(출고-반품)"
      valueOverride="{{ (item*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)/1000).toFixed(0) }}"
    />
    <Column
      id="f1004"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      hidden="{{!checkboxTreeNew1.value.includes(2) }}"
      key="net_out_amt"
      label="순출고금액 (실판가)"
      placeholder="Enter value"
      position="center"
      size={84}
      valueOverride="{{ item/1000 }}"
    />
    <Column
      id="152fc"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{!checkboxTreeNew1.value.includes(3) }}"
      key="net_out_qty"
      label="순출고수량"
      placeholder="Enter value"
      position="center"
      size={70.90625}
      tooltip="(출고-반품)"
    />
    <Column
      id="76d06"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{!checkboxTreeNew1.value.includes(4) }}"
      label="재고금액(TAG)"
      placeholder="Enter value"
      position="center"
      referenceId="재고금액TAG"
      size={71.515625}
      tooltip="(순출고-판매)"
      valueOverride="{{((currentSourceRow.net_out_tag-currentSourceRow.sale_tag)/1000).toFixed(0)}}"
    />
    <Column
      id="bb59c"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: false, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      label="재고금액(실판가)"
      placeholder="Enter value"
      position="center"
      size={72.359375}
      tooltip="(순출고-판매)*(1-할인율)"
      valueOverride="{{ ((currentSourceRow.net_out_tag*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)-currentSourceRow.sale_amt)/1000).toFixed(0) }}"
    />
    <Column
      id="75298"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: false,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      hidden="{{!checkboxTreeNew1.value.includes(5) }}"
      key="net_out_amt"
      label="재고금액 (실판가)"
      placeholder="Enter value"
      position="center"
      size={71}
      valueOverride="{{ (item-currentSourceRow.sale_amt)/1000 }}"
    />
    <Column
      id="0da50"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{!checkboxTreeNew1.value.includes(6) }}"
      label="재고수량"
      placeholder="Enter value"
      position="center"
      referenceId="재고수량"
      size={59.515625}
      tooltip="(순출고-판매)"
      valueOverride="{{ currentSourceRow.net_out_qty-currentSourceRow.sale_qty }}"
    />
    <Column
      id="204ee"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{!checkboxTreeNew1.value.includes(7)}}"
      key="sale_tag"
      label="판매금액(TAG)"
      placeholder="Enter value"
      position="center"
      size={67.515625}
      valueOverride="{{ (item/1000).toFixed(0) }}"
    />
    <Column
      id="60fbd"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{!checkboxTreeNew1.value.includes(8)}}"
      key="sale_amt"
      label="실판매금액"
      placeholder="Enter value"
      position="center"
      size={73.90625}
      valueOverride="{{ (item/1000).toFixed(0) }}"
    />
    <Column
      id="b441e"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{!checkboxTreeNew1.value.includes(9)}}"
      key="sale_qty"
      label="판매수량"
      placeholder="Enter value"
      position="center"
      size={75.515625}
    />
    <Column
      id="982ea"
      alignment="right"
      backgroundColor="{{  'FDE68A60'}}"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="average"
      hidden="{{!checkboxTreeNew1.value.includes(10)}}"
      label="판매율(금액)"
      placeholder="Enter value"
      position="center"
      referenceId="sale_rate_amt"
      size={57.59375}
      tooltip="(판매금액/순출고금액)"
      valueOverride="{{ currentSourceRow.sale_tag/currentSourceRow.net_out_tag}}"
    />
    <Column
      id="c99ab"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="average"
      hidden="{{!checkboxTreeNew1.value.includes(11)}}"
      label="판매율(수량)"
      placeholder="Enter value"
      position="center"
      referenceId="sale_rate_qty"
      size={91.59375}
      tooltip="(판매/순출고)"
      valueOverride="{{currentSourceRow.sale_qty/currentSourceRow.net_out_qty}}"
    />
    <Column
      id="bc312"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="average"
      hidden="{{!checkboxTreeNew1.value.includes(12)}}"
      label="할인율"
      placeholder="Enter value"
      position="center"
      referenceId="discount_rate"
      size={55.578125}
      tooltip="1-(판매금액/실판매금액)"
      valueOverride="{{ 1-(currentSourceRow.sale_amt/currentSourceRow.sale_tag) }}"
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
                      "[{{ moment().format('YYYY-MM-DD') }}] {{ text14.value.slice(7,60) }}",
                  },
                ],
              },
            },
          ],
        }}
        pluginId="table26"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </ToolbarButton>
  </Table>
</SplitPaneFrame>
