<Container
  id="tabbedContainer1"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="2px 12px"
  padding="0"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Tabs
      id="tabs1"
      itemMode="static"
      targetContainerId="tabbedContainer1"
      value="{{ self.values[0] }}"
    >
      <Option id="6656b" label="오프라인" value="오프라인" />
      <Option id="02c6c" label="온라인" value="온라인" />
      <Option id="64864" label="온오프라인 합계" value="합계" />
    </Tabs>
  </Header>
  <View id="e0e87" label="온오프라인 합계" viewKey="합계">
    <Text
      id="text2"
      margin="0px 8px"
      value="###### [요약]"
      verticalAlign="center"
    />
    <Text
      id="text16"
      disableMarkdown={true}
      margin="0px 8px"
      value="* 판매 기간: {{ yearSelect2.selectedItem.last_season_end_dt }} ~ {{ moment(endDate.value).format('YYYY-MM-DD') }} | 출고 기간: {{ yearSelect2.selectedItem.last_season_end_dt }} ~ {{ getOutEndDate.data[0].outEndDate }}
* 단위: 수량-개, 금액-백만원
* 온라인 출고는 온라인 창고 이동 기준입니다."
      verticalAlign="center"
    />
    <Table
      id="table20"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ summaryData.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowBackgroundColor="{{ currentSourceRow.category_name === '소계' ? '01488f33' :
  currentSourceRow.category_name === '총계' ? '01488f60' :
  'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
    >
      <Column
        id="82f4e"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="sale_unit"
        placeholder="Enter value"
        position="left"
        size={130.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="204ee"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(7)}}"
        key="sale_tag"
        label="판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={110.875}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000) }}"
      />
      <Column
        id="60fbd"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(8)}}"
        key="sale_amt"
        label="실판매금액"
        placeholder="Enter value"
        position="center"
        size={81.65625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000)}}"
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
        size={73.40625}
        summaryAggregationMode="none"
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
        size={86.140625}
        summaryAggregationMode="none"
        tooltip="(판매금액/순출고금액)"
        valueOverride="{{ i === 2 ? (self.data[0].sale_amt/self.data[0].net_out_amt)-(self.data[1].sale_amt/self.data[1].net_out_amt):
  currentSourceRow.sale_amt/currentSourceRow.net_out_amt}}"
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
        size={89.90625}
        summaryAggregationMode="none"
        tooltip="(판매/순출고)"
        valueOverride="{{ i === 2 ? (self.data[0].sale_qty/self.data[0].net_out_qty)-(self.data[1].sale_qty/self.data[1].net_out_qty):
  currentSourceRow.sale_qty/currentSourceRow.net_out_qty}}"
      />
      <Column
        id="facb8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(1) }}"
        key="net_out_tag"
        label="순출고금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={120.890625}
        summaryAggregationMode="none"
        tooltip="(출고-반품)"
        valueOverride="{{ (item/1000000)}}"
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
        size={120.734375}
        summaryAggregationMode="none"
        tooltip="(출고-반품)*(1-할인율)"
        valueOverride="{{ (item*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)/1000000).toFixed(0) }}"
      />
      <Column
        id="88547"
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
        size={121}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
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
        size={98.90625}
        summaryAggregationMode="none"
        tooltip="(출고-반품)"
      />
      <Column
        id="76d06"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(4) }}"
        label="재고금액(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="재고금액TAG"
        size={117.3125}
        summaryAggregationMode="none"
        tooltip="(순출고-판매)"
        valueOverride="{{ ((currentSourceRow.net_out_tag-currentSourceRow.sale_tag)/1000000) }}"
      />
      <Column
        id="bb59c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: false, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="재고금액 (실판가)"
        placeholder="Enter value"
        position="center"
        referenceId="stock_amt_old"
        size={74.359375}
        summaryAggregationMode="none"
        tooltip="(순출고-판매)*(1-할인율)"
        valueOverride="{{ ((currentSourceRow.net_out_tag*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)-currentSourceRow.sale_amt)/1000000).toFixed(0) }}"
      />
      <Column
        id="1a784"
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
        referenceId="column25"
        size={107}
        summaryAggregationMode="none"
        valueOverride="{{ (item - currentSourceRow.sale_amt)/1000000 }}"
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
        size={99.515625}
        summaryAggregationMode="none"
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
        referenceId="sale_discount_rate"
        size={92.140625}
        summaryAggregationMode="none"
        tooltip="1-(판매금액/실판매금액)"
        valueOverride="{{ i === 2 ?(1-(self.data[0].sale_amt/self.data[0].sale_tag))-(1-(self.data[1].sale_amt/self.data[1].sale_tag)):
  1-currentSourceRow.sale_amt/currentSourceRow.sale_tag}}"
      />
      <Column
        id="78ebf"
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
        size={91}
        summaryAggregationMode="none"
        valueOverride="{{ i === 2 ?(1-(self.data[0].net_out_amt/self.data[0].net_out_tag))-(1-(self.data[1].net_out_amt/self.data[1].net_out_tag)):
  1-currentSourceRow.net_out_amt/currentSourceRow.net_out_tag}}"
      />
      <Column
        id="f0853"
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
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="962c8"
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
        id="fd9ef"
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
        size={112}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="a0aaa"
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
        size={113}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="5fd0c"
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
        size={110}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="a488f"
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
        size={109}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
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
                        "{{ text15.value.slice(6) }}({{ tabs1.value }})",
                    },
                  ],
                },
              },
            ],
          }}
          pluginId="table20"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text
      id="text3"
      margin="0px 8px"
      value="###### [등급별 판매현황]"
      verticalAlign="center"
    />
    <Text
      id="text17"
      disableMarkdown={true}
      margin="0px 8px"
      value="* 판매 기간: {{ yearSelect2.selectedItem.last_season_end_dt }} ~ {{ moment(endDate.value).format('YYYY-MM-DD') }} | 출고 기간: {{ yearSelect2.selectedItem.last_season_end_dt }} ~ {{ getOutEndDate.data[0].outEndDate }}
* 단위: 수량-개, 금액-백만원
* 온라인 출고는 온라인 창고 이동 기준입니다."
      verticalAlign="center"
    />
    <Table
      id="table2"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ groupByCategory.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowBackgroundColor="{{ currentSourceRow.category_name === '소계' ? '01488f33' :
  currentSourceRow.category_name === '총계' ? '01488f60' :
  'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
    >
      <Column
        id="e7cb1"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="item_grade"
        label="등급"
        placeholder="Enter value"
        position="left"
        size={52.125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.category_order === '0'? item+'('+currentSourceRow.year_season_cd.slice(0,1)+')' : '' }}"
      />
      <Column
        id="dbdc5"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="category_name"
        label="대분류"
        placeholder="Enter value"
        position="left"
        size={83.515625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="204ee"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(7)}}"
        key="sale_tag"
        label="판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={108.515625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000) }}"
      />
      <Column
        id="60fbd"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(8)}}"
        key="sale_amt"
        label="실판매금액"
        placeholder="Enter value"
        position="center"
        size={78.90625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000)}}"
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
        size={73.515625}
        summaryAggregationMode="none"
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
        label="판매율 (금액)"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_amt"
        size={86.140625}
        summaryAggregationMode="none"
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
        label="판매율 (수량)"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_qty"
        size={90.90625}
        summaryAggregationMode="none"
        tooltip="(판매/순출고)"
        valueOverride="{{currentSourceRow.sale_qty/currentSourceRow.net_out_qty}}"
      />
      <Column
        id="facb8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(1) }}"
        key="net_out_tag"
        label="순출고금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={122.515625}
        summaryAggregationMode="none"
        tooltip="(출고-반품)"
        valueOverride="{{ (item/1000000) }}"
      />
      <Column
        id="1b3cb"
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
        size={121}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
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
        size={95.546875}
        summaryAggregationMode="none"
        tooltip="(출고-반품)"
      />
      <Column
        id="76d06"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(4) }}"
        label="재고금액(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="재고금액TAG"
        size={114.515625}
        summaryAggregationMode="none"
        tooltip="(순출고-판매)"
        valueOverride="{{((currentSourceRow.net_out_tag-currentSourceRow.sale_tag)/1000000)}}"
      />
      <Column
        id="014c6"
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
        valueOverride="{{ (item - currentSourceRow.sale_amt)/1000000 }}"
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
        size={97.515625}
        summaryAggregationMode="none"
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
        referenceId="sale_discount_rate"
        size={95.140625}
        summaryAggregationMode="none"
        tooltip="1-(판매금액/실판매금액)"
        valueOverride="{{ 1-(currentSourceRow.sale_amt/currentSourceRow.sale_tag) }}"
      />
      <Column
        id="492ca"
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
        size={92}
        summaryAggregationMode="none"
        valueOverride="{{ 1-(currentSourceRow.net_out_amt/currentSourceRow.net_out_tag) }}"
      />
      <Column
        id="36afa"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "",
        }}
        groupAggregationMode="sum"
        hidden="{{ !switch1.value }}"
        key="ttl_out_qty"
        label="기간 누적 출고량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="2394d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "{{ !switch1.value }}",
        }}
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
        id="5cd31"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "{{ !switch1.value }}",
        }}
        groupAggregationMode="sum"
        hidden="{{ !switch1.value }}"
        key="ttl_out_amt"
        label="기간 누적 출고금액(실판가)"
        placeholder="Enter value"
        position="center"
        size={119}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="0d587"
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
        size={112}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="ea457"
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
        size={111}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="7dc06"
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
        valueOverride="{{ item/1000000 }}"
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
                        "{{ text15.value.slice(6,20) }}등급별 판매현황({{ tabs1.value }})",
                    },
                    { includeHiddenColumns: false },
                  ],
                },
              },
            ],
          }}
          pluginId="table2"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{currentSourceRow}}" }] }}
        pluginId="varSelectedRow"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "true" }] }}
        pluginId="toggleButton1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="modalFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </View>
  <View id="7323f" viewKey="오프라인">
    <Text
      id="text46"
      margin="0px 8px"
      value="###### [요약]"
      verticalAlign="center"
    />
    <Text
      id="text47"
      disableMarkdown={true}
      margin="0px 8px"
      value="* 기간: {{ yearSelect2.selectedItem.season_end_dt }} ~ {{ moment(endDate.value).format('YYYY-MM-DD') }} | 단위: 수량-개, 금액-백만원"
      verticalAlign="center"
    />
    <Table
      id="table22"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ summaryData.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowBackgroundColor="{{ currentSourceRow.category_name === '소계' ? '01488f33' :
  currentSourceRow.category_name === '총계' ? '01488f60' :
  'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
      toolbarPosition="bottom"
    >
      <Column
        id="82f4e"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="sale_unit"
        placeholder="Enter value"
        position="left"
        size={57.515625}
        summaryAggregationMode="none"
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
        size={99.890625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="8349c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(2) }}"
        key="net_out_tag"
        label="순출고금액(실판가)"
        placeholder="Enter value"
        position="center"
        referenceId="column26"
        size={107.734375}
        summaryAggregationMode="none"
        valueOverride="{{ (item*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)/1000000).toFixed(0) }}"
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
        size={67.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="76d06"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(4) }}"
        label="재고금액(TGA)"
        placeholder="Enter value"
        position="center"
        referenceId="재고금액TAG"
        size={90.3125}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.net_out_tag-currentSourceRow.sale_tag)/1000000).toFixed(0) }}"
      />
      <Column
        id="bb59c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: false, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(5) }}"
        label="재고금액(실판가)"
        placeholder="Enter value"
        position="center"
        size={97.359375}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.net_out_tag*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)-currentSourceRow.sale_amt)/1000000).toFixed(0) }}"
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
        size={59.046875}
        summaryAggregationMode="none"
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
        size={89.515625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
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
        size={67.90625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
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
        size={63.40625}
        summaryAggregationMode="none"
      />
      <Column
        id="982ea"
        alignment="right"
        backgroundColor="{{  'FDE68A60'}}"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(10)}}"
        label="판매율"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_amt"
        size={58.125}
        summaryAggregationMode="none"
        tooltip="판매금액/순출고금액"
        valueOverride="{{ i === 2 ? (((self.data[0].sale_tag/self.data[0].net_out_tag)-(self.data[1].sale_tag/self.data[1].net_out_tag))*100).toFixed(2) :
  (100*currentSourceRow.sale_tag/currentSourceRow.net_out_tag).toFixed(2)}}%"
      />
      <Column
        id="c99ab"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(11)}}"
        label="수량판매율"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_qty"
        size={67.90625}
        summaryAggregationMode="none"
        tooltip="출고수량 기준"
        valueOverride="{{ i === 2 ? (((self.data[0].sale_qty/self.data[0].net_out_qty)-(self.data[1].sale_qty/self.data[1].net_out_qty))*100).toFixed(2) :
  (100*currentSourceRow.sale_qty/currentSourceRow.net_out_qty).toFixed(2)}}%"
      />
      <Column
        id="bc312"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
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
        size={58.25}
        summaryAggregationMode="none"
        tooltip="1-(판매금액/실판매금액)"
        valueOverride="{{ i === 2 ? (((self.data[0].sale_amt/self.data[0].sale_tag)-(self.data[1].sale_amt/self.data[1].sale_tag))*100).toFixed(2) :
  (100-(currentSourceRow.sale_amt/currentSourceRow.sale_tag)*100).toFixed(2) }}%"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          pluginId="table22"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="refresh"
          pluginId="table22"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text
      id="text48"
      margin="0px 8px"
      value="###### [등급별 판매현황]"
      verticalAlign="center"
    />
    <Text
      id="text49"
      disableMarkdown={true}
      margin="0px 8px"
      value="* 기간: {{ yearSelect2.selectedItem.season_end_dt }} ~ {{ moment(endDate.value).format('YYYY-MM-DD') }} | 단위: 수량-개, 금액-백만원"
      verticalAlign="center"
    />
    <Table
      id="table23"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ groupByCategory.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowBackgroundColor="{{ currentSourceRow.category_name === '소계' ? '01488f33' :
  currentSourceRow.category_name === '총계' ? '01488f60' :
  'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
    >
      <Column
        id="e7cb1"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="item_grade"
        label="등급"
        placeholder="Enter value"
        position="left"
        size={48.125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.category_order === '1'? item+'('+currentSourceRow.year_season_cd+')' : '' }}"
      />
      <Column
        id="dbdc5"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="category_name"
        label="대분류"
        placeholder="Enter value"
        position="left"
        size={57.515625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
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
        size={99.890625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="8349c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(2) }}"
        key="net_out_tag"
        label="순출고금액(실판가)"
        placeholder="Enter value"
        position="center"
        referenceId="column26"
        size={107.734375}
        summaryAggregationMode="none"
        valueOverride="{{ (item*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)/1000000).toFixed(0) }}"
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
        size={67.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="76d06"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(4) }}"
        label="재고금액(TGA)"
        placeholder="Enter value"
        position="center"
        referenceId="재고금액TAG"
        size={90.3125}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.net_out_tag-currentSourceRow.sale_tag)/1000000).toFixed(0) }}"
      />
      <Column
        id="bb59c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: false, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(5) }}"
        label="재고금액(실판가)"
        placeholder="Enter value"
        position="center"
        size={97.359375}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.net_out_tag*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)-currentSourceRow.sale_amt)/1000000).toFixed(0) }}"
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
        size={57.515625}
        summaryAggregationMode="none"
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
        size={89.515625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
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
        size={67.90625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
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
        size={62.34375}
        summaryAggregationMode="none"
      />
      <Column
        id="982ea"
        alignment="right"
        backgroundColor="{{  'FDE68A60'}}"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(10)}}"
        label="판매율"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_amt"
        size={58.515625}
        summaryAggregationMode="none"
        tooltip="판매금액/순출고금액"
        valueOverride="{{ (100*currentSourceRow.sale_tag/currentSourceRow.net_out_tag).toFixed(2)}}%"
      />
      <Column
        id="c99ab"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(11)}}"
        label="수량판매율"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_qty"
        size={67.90625}
        summaryAggregationMode="none"
        tooltip="출고수량 기준"
        valueOverride="{{ (100*currentSourceRow.sale_qty/currentSourceRow.net_out_qty).toFixed(2)}}%"
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
        size={47.140625}
        summaryAggregationMode="none"
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
                        "{{ text15.value.slice(6,20) }}등급별 판매현황({{ tabs1.value }})",
                    },
                  ],
                },
              },
            ],
          }}
          pluginId="table23"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="splitPaneFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{currentSourceRow}}" }] }}
        pluginId="varSelectedRow"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "true" }] }}
        pluginId="toggleButton1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </View>
  <View id="f8cd1" viewKey="온라인">
    <Text
      id="text50"
      margin="0px 8px"
      value="###### [요약]"
      verticalAlign="center"
    />
    <Text
      id="text51"
      disableMarkdown={true}
      margin="0px 8px"
      value="* 기간: {{ yearSelect2.selectedItem.season_end_dt }} ~ {{ moment(endDate.value).format('YYYY-MM-DD') }} | 단위: 수량-개, 금액-백만원"
      verticalAlign="center"
    />
    <Table
      id="table24"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ summaryData.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowBackgroundColor="{{ currentSourceRow.category_name === '소계' ? '01488f33' :
  currentSourceRow.category_name === '총계' ? '01488f60' :
  'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
      toolbarPosition="bottom"
    >
      <Column
        id="82f4e"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="sale_unit"
        placeholder="Enter value"
        position="left"
        size={57.515625}
        summaryAggregationMode="none"
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
        size={99.890625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="8349c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(2) }}"
        key="net_out_tag"
        label="순출고금액(실판가)"
        placeholder="Enter value"
        position="center"
        referenceId="column26"
        size={107.734375}
        summaryAggregationMode="none"
        valueOverride="{{ (item*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)/1000000).toFixed(0) }}"
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
        size={67.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="76d06"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(4) }}"
        label="재고금액(TGA)"
        placeholder="Enter value"
        position="center"
        referenceId="재고금액TAG"
        size={90.3125}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.net_out_tag-currentSourceRow.sale_tag)/1000000).toFixed(0) }}"
      />
      <Column
        id="bb59c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: false, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(5) }}"
        label="재고금액(실판가)"
        placeholder="Enter value"
        position="center"
        size={97.359375}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.net_out_tag*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)-currentSourceRow.sale_amt)/1000000).toFixed(0) }}"
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
        size={57.625}
        summaryAggregationMode="none"
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
        size={89.515625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
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
        size={67.90625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
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
        size={60.75}
        summaryAggregationMode="none"
      />
      <Column
        id="982ea"
        alignment="right"
        backgroundColor="{{  'FDE68A60'}}"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(10)}}"
        label="판매율"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_amt"
        size={63.921875}
        summaryAggregationMode="none"
        tooltip="판매금액/순출고금액"
        valueOverride="{{ i === 2 ? (((self.data[0].sale_tag/self.data[0].net_out_tag)-(self.data[1].sale_tag/self.data[1].net_out_tag))*100).toFixed(2) :
  (100*currentSourceRow.sale_tag/currentSourceRow.net_out_tag).toFixed(2)}}%"
      />
      <Column
        id="c99ab"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(11)}}"
        label="수량판매율"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_qty"
        size={67.90625}
        summaryAggregationMode="none"
        tooltip="출고수량 기준"
        valueOverride="{{ i === 2 ? (((self.data[0].sale_qty/self.data[0].net_out_qty)-(self.data[1].sale_qty/self.data[1].net_out_qty))*100).toFixed(2) :
  (100*currentSourceRow.sale_qty/currentSourceRow.net_out_qty).toFixed(2)}}%"
      />
      <Column
        id="bc312"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
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
        size={56.28125}
        summaryAggregationMode="none"
        tooltip="1-(판매금액/실판매금액)"
        valueOverride="{{ i === 2 ? (((self.data[0].sale_amt/self.data[0].sale_tag)-(self.data[1].sale_amt/self.data[1].sale_tag))*100).toFixed(2) :
  (100-(currentSourceRow.sale_amt/currentSourceRow.sale_tag)*100).toFixed(2) }}%"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          pluginId="table24"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="refresh"
          pluginId="table24"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text
      id="text52"
      margin="0px 8px"
      value="###### [등급별 판매현황]"
      verticalAlign="center"
    />
    <Text
      id="text53"
      disableMarkdown={true}
      margin="0px 8px"
      value="* 기간: {{ yearSelect2.selectedItem.season_end_dt }} ~ {{ moment(endDate.value).format('YYYY-MM-DD') }} | 단위: 수량-개, 금액-백만원"
      verticalAlign="center"
    />
    <Table
      id="table25"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ groupByCategory.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowBackgroundColor="{{ currentSourceRow.category_name === '소계' ? '01488f33' :
  currentSourceRow.category_name === '총계' ? '01488f60' :
  'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
    >
      <Column
        id="e7cb1"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="item_grade"
        label="등급"
        placeholder="Enter value"
        position="left"
        size={48.125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.category_order === '1'? item+'('+currentSourceRow.year_season_cd+')' : '' }}"
      />
      <Column
        id="dbdc5"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="category_name"
        label="대분류"
        placeholder="Enter value"
        position="left"
        size={57.515625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
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
        size={99.890625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
      />
      <Column
        id="8349c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(2) }}"
        key="net_out_tag"
        label="순출고금액(실판가)"
        placeholder="Enter value"
        position="center"
        referenceId="column26"
        size={107.734375}
        summaryAggregationMode="none"
        valueOverride="{{ (item*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)/1000000).toFixed(0) }}"
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
        size={67.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="76d06"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(4) }}"
        label="재고금액(TGA)"
        placeholder="Enter value"
        position="center"
        referenceId="재고금액TAG"
        size={90.3125}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.net_out_tag-currentSourceRow.sale_tag)/1000000).toFixed(0) }}"
      />
      <Column
        id="bb59c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: false, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(5) }}"
        label="재고금액(실판가)"
        placeholder="Enter value"
        position="center"
        size={97.359375}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.net_out_tag*(currentSourceRow.sale_amt/currentSourceRow.sale_tag)-currentSourceRow.sale_amt)/1000000).toFixed(0) }}"
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
        size={57.515625}
        summaryAggregationMode="none"
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
        size={89.515625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
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
        size={67.90625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000).toFixed(0) }}"
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
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="982ea"
        alignment="right"
        backgroundColor="{{  'FDE68A60'}}"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(10)}}"
        label="판매율"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_amt"
        size={64.421875}
        summaryAggregationMode="none"
        tooltip="판매금액/순출고금액"
        valueOverride="{{ (100*currentSourceRow.sale_tag/currentSourceRow.net_out_tag).toFixed(2)}}%"
      />
      <Column
        id="c99ab"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(11)}}"
        label="수량판매율"
        placeholder="Enter value"
        position="center"
        referenceId="sale_rate_qty"
        size={67.90625}
        summaryAggregationMode="none"
        tooltip="출고수량 기준"
        valueOverride="{{ (100*currentSourceRow.sale_qty/currentSourceRow.net_out_qty).toFixed(2)}}%"
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
        size={47.140625}
        summaryAggregationMode="none"
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
                        "{{ text15.value.slice(6,20) }}등급별 판매현황({{ tabs1.value }})",
                    },
                  ],
                },
              },
            ],
          }}
          pluginId="table25"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="splitPaneFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{currentSourceRow}}" }] }}
        pluginId="varSelectedRow"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "true" }] }}
        pluginId="toggleButton1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </View>
</Container>
