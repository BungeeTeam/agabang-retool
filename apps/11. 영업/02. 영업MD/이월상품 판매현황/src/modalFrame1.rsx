<ModalFrame
  id="modalFrame1"
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
      id="text54"
      value="###### 매장별 {{yearSelect2.selectedItem.year_nm }} {{ varSelectedRow.value.season_nm }} | {{ varSelectedRow.value.item_grade }}등급 {{ varSelectedRow.value.category_name }} ({{ tabs1.selectedLabel }})"
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
        pluginId="modalFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text55"
      disableMarkdown={true}
      margin="0px 8px"
      value="* 판매 기간: {{ yearSelect2.selectedItem.last_season_end_dt }} ~ {{ moment(endDate.value).format('YYYY-MM-DD') }} | 출고 기간: {{ yearSelect2.selectedItem.last_season_end_dt }} ~ {{ getOutEndDate.data[0].outEndDate }}
* 단위: 수량-개, 금액-천원"
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Table
      id="table27"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopDetailData.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      rowBackgroundColor="{{ currentSourceRow.shop_nm === '총계' ? '01488f60' :
  'ffffff' }}"
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
        size={57.921875}
      />
      <Column
        id="cf3b8"
        alignment="left"
        caption="{{ currentSourceRow.shop_cd === '총계' ? '' : currentSourceRow.shop_cd  }}"
        format="multilineString"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="left"
        size={178.671875}
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
        id="674f4"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tp_nm"
        label="채널명"
        placeholder="Enter value"
        position="center"
        size={121.859375}
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
        size={122.859375}
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
        size={102.859375}
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
        size={100.484375}
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
        size={113.03125}
        tooltip="(판매금액/순출고금액)"
        valueOverride="{{ currentSourceRow.sale_amt/currentSourceRow.net_out_amt}}"
      />
      <Column
        id="c99ab"
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
        hidden="{{!checkboxTreeNew1.value.includes(11)}}"
        label="판매율(수량)"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_qty"
        size={111.03125}
        summaryAggregationMode="none"
        tooltip="(판매/순출고)"
        valueOverride="{{currentSourceRow.sale_qty/currentSourceRow.net_out_qty}}"
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
        size={128.234375}
        tooltip="(출고-반품)"
        valueOverride="{{ (item/1000).toFixed(0) }}"
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
        size={145.15625}
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
        size={99.859375}
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
        size={109.859375}
        tooltip="(순출고-판매)"
        valueOverride="{{((currentSourceRow.net_out_tag-currentSourceRow.sale_tag)/1000).toFixed(0)}}"
      />
      <Column
        id="c0cff"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(5) }}"
        key="net_out_amt"
        label="재고금액 (실판가)"
        placeholder="Enter value"
        position="center"
        referenceId="net_stock_amt"
        size={114}
        summaryAggregationMode="none"
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
        size={93.484375}
        tooltip="(순출고-판매)"
        valueOverride="{{ currentSourceRow.net_out_qty-currentSourceRow.sale_qty }}"
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
        hidden="{{!checkboxTreeNew1.value.includes(13)}}"
        label="할인율(판매)"
        placeholder="Enter value"
        position="center"
        referenceId="discount_rate"
        size={98.109375}
        tooltip="1-(판매금액/실판매금액)"
        valueOverride="{{ 1-(currentSourceRow.sale_amt/currentSourceRow.sale_tag) }}"
      />
      <Column
        id="aae65"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(14)}}"
        label="할인율(출고)"
        placeholder="Enter value"
        position="center"
        referenceId="out_discount_rate"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.net_out_amt/currentSourceRow.net_out_tag) }}"
      />
      <Column
        id="e6db2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !switch1.value }}"
        key="ttl_out_qty"
        label="기간 누적 출고량"
        placeholder="Enter value"
        position="center"
        referenceId="column16"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="18acc"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ !switch1.value }}"
        key="ttl_rtn_qty"
        label="기간 누적 반품량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="f7de1"
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
        key="ttl_out_amt"
        label="기간 누적 출고금액(실판가)"
        placeholder="Enter value"
        position="center"
        size={111}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="e105c"
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
        key="ttl_rtn_amt"
        label="기간 누적 반품금액(실판가)"
        placeholder="Enter value"
        position="center"
        size={114}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="9214f"
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
        key="ttl_out_tag"
        label="기간 누적 출고금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={116}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="31fee"
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
        key="ttl_rtn_tag"
        label="기간 누적 반품금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={111}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000 }}"
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
          method="trigger"
          params={{
            ordered: [
              {
                options: {
                  object: {
                    onSuccess: null,
                    onFailure: null,
                    additionalScope: null,
                  },
                },
              },
            ],
          }}
          pluginId="excelDownloadByShop"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</ModalFrame>
