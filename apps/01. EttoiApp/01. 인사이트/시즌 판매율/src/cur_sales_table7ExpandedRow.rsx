<ExpandedRow id="cur_sales_table7ExpandedRow">
  <Table
    id="table4"
    autoColumnWidth={true}
    cellSelection="none"
    clearChangesetOnSave={true}
    data="{{ (() => {
  const data = salesBySmallCat.value.filter(i => i.year_cd === currentSourceRow.year_cd)
  
  const result = currentSourceRow.it === '총계' ? data.filter(i=>i.total === '총계') :
  currentSourceRow.it === '소계' ? data.filter(i =>i.cat_group === currentSourceRow.cat_group): 
 data.filter(i => i.large_cat === currentSourceRow.large_cat)


  return result
})()
}} "
    defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
    emptyMessage="No rows found"
    enableSaveActions={true}
    heightType="auto"
    margin="8px 6px 3px 6px"
    rowHeight="xsmall"
    showBorder={true}
    showHeader={true}
    style={{
      headerFontSize: "10px",
      headerFontWeight: "600",
      headerFontFamily: "pretendard variable",
    }}
    toolbarPosition="bottom"
  >
    <Column
      id="07f28"
      alignment="left"
      format="string"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="none"
      key="large_cat"
      label="대분류"
      placeholder="Enter value"
      position="center"
      size={47.109375}
      summaryAggregationMode="none"
    />
    <Column
      id="1a8ab"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      key="small_cat"
      label="복종명"
      placeholder="Enter value"
      position="center"
      size={78.21875}
      summaryAggregationMode="none"
    />
    <Column
      id="b4336"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="st_count"
      label="총 컬러수"
      placeholder="Enter value"
      position="center"
      size={60.34375}
      summaryAggregationMode="none"
    />
    <Column
      id="13440"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="tot_in_qty"
      label="총입고수량"
      placeholder="Enter value"
      position="center"
      size={67.859375}
      summaryAggregationMode="none"
    />
    <Column
      id="446de"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="tot_sale_qty"
      label="총판매수량"
      placeholder="Enter value"
      position="center"
      size={67.859375}
      summaryAggregationMode="none"
    />
    <Column
      id="d5c70"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
        padDecimal: true,
      }}
      groupAggregationMode="average"
      label="판매율(수량)"
      placeholder="Enter value"
      position="center"
      referenceId="tot_sale_rate_qty"
      size={76.8125}
      summaryAggregationMode="none"
      valueOverride="{{ currentSourceRow.tot_sale_qty/currentSourceRow.tot_in_qty }}"
    />
    <Column
      id="5dee7"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      label="재고수량"
      placeholder="Enter value"
      position="center"
      referenceId="inven_qty"
      size={57.484375}
      summaryAggregationMode="none"
      valueOverride="{{ currentSourceRow.tot_in_qty-currentSourceRow.tot_sale_qty }}"
    />
    <Column
      id="08662"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      label="재고금액(TAG)"
      placeholder="Enter value"
      position="center"
      referenceId="inven_tag"
      size={89.640625}
      summaryAggregationMode="none"
      valueOverride="{{ (currentSourceRow.tot_in_tag-currentSourceRow.tot_sale_tag)/1000000 }}"
    />
    <Column
      id="74c26"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="tot_in_tag"
      label="누적입고금액(TAG)"
      placeholder="Enter value"
      position="center"
      size={110.375}
      summaryAggregationMode="none"
      valueOverride="{{ item/1000000 }}"
    />
    <Column
      id="a8a81"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="tot_sale_tag"
      label="누적판매금액(TAG)"
      placeholder="Enter value"
      position="center"
      size={110.375}
      summaryAggregationMode="none"
      valueOverride="{{ item/1000000 }}"
    />
    <Column
      id="b1fdd"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="tot_sale_amt"
      label="누적실판매금액"
      placeholder="Enter value"
      position="center"
      size={88.59375}
      summaryAggregationMode="none"
      valueOverride="{{ item/1000000 }}"
    />
    <Column
      id="aff56"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
        padDecimal: true,
      }}
      groupAggregationMode="average"
      label="누적판매율(TAG)"
      placeholder="Enter value"
      position="center"
      referenceId="tot_sale_rate_tag"
      size={100}
      summaryAggregationMode="none"
      textColor="{{ currentRow.tot_sale_rate_tag >= item ? '#fc5b5b' : '#000000' }}"
      valueOverride="{{ currentSourceRow.tot_sale_tag/currentSourceRow.tot_in_tag }}"
    />
    <Column
      id="751b4"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
        padDecimal: true,
      }}
      groupAggregationMode="average"
      label="누적실판매율"
      placeholder="Enter value"
      position="center"
      referenceId="tot_sale_rate_amt"
      size={78.21875}
      summaryAggregationMode="none"
      textColor="{{ currentRow.tot_sale_rate_amt >= item ? '#fc5b5b' : '#000000' }}"
      valueOverride="{{ currentSourceRow.tot_sale_amt/currentSourceRow.tot_in_tag }}"
    />
    <Column
      id="e1c95"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
        padDecimal: true,
      }}
      groupAggregationMode="average"
      label="할인율"
      placeholder="Enter value"
      position="center"
      referenceId="discount_rate"
      size={49.0625}
      summaryAggregationMode="none"
      valueOverride="{{(currentSourceRow.tot_sale_tag-currentSourceRow.tot_sale_amt)/currentSourceRow.tot_sale_tag }}"
    />
    <Column
      id="1b2e4"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
        padDecimal: true,
      }}
      groupAggregationMode="average"
      label="전주 판매 진도율"
      placeholder="Enter value"
      position="center"
      referenceId="p_week_sale_rate"
      size={94.296875}
      summaryAggregationMode="none"
      valueOverride="{{ currentSourceRow.p_week_sale_tag/currentSourceRow.tot_in_tag }}"
    />
    <Column
      id="a4c54"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
        padDecimal: true,
      }}
      groupAggregationMode="average"
      label="금주 판매 진도율"
      placeholder="Enter value"
      position="center"
      referenceId="week_sale_rate"
      size={94.296875}
      summaryAggregationMode="none"
      valueOverride="{{ currentSourceRow.week_sale_tag/currentSourceRow.tot_in_tag }}"
    />
    <Column
      id="cfef9"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
        padDecimal: true,
      }}
      groupAggregationMode="average"
      label="진도율차"
      placeholder="Enter value"
      position="center"
      referenceId="diff_sale_rate"
      size={57.484375}
      summaryAggregationMode="none"
      valueOverride="{{ currentSourceRow.week_sale_tag/currentSourceRow.tot_in_tag-currentSourceRow.p_week_sale_tag/currentSourceRow.tot_in_tag }}"
    />
    <Event
      event="clickRow"
      method="setValue"
      params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
      pluginId="var_clicked_middle_cat"
      type="state"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="clickRow"
      method="show"
      params={{ ordered: [] }}
      pluginId="modal_item_list"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
  </Table>
</ExpandedRow>
