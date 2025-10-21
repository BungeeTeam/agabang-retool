<ExpandedRow id="table4ExpandedRow">
  <Table
    id="table8"
    autoColumnWidth={true}
    cellSelection="none"
    clearChangesetOnSave={true}
    data="{{ currentSourceRow.cat_id === 666 
  ? [...(var_middle_cat.value.var_04[6] || []),...(var_middle_cat.value.var_04[7]||[]),...(var_middle_cat.value.var_04[10]||[])] 
  : currentSourceRow.cat_id === 777 ? [...(var_middle_cat.value.var_04[1] || []),
  ...(var_middle_cat.value.var_04[2] || []),
  ...(var_middle_cat.value.var_04[3] || []),
  ...(var_middle_cat.value.var_04[6] || []),
  ...(var_middle_cat.value.var_04[7] || [])]
  : currentSourceRow.cat_id === 888 ? [...(var_middle_cat.value.var_04[4]||[]),...(var_middle_cat.value.var_04[5]||[])]
  : currentSourceRow.cat_id === 999 ? [...(var_middle_cat.value.var_04[1] || []),
  ...(var_middle_cat.value.var_04[2] || []),
  ...(var_middle_cat.value.var_04[3] || []),
  ...(var_middle_cat.value.var_04[4] || []),
  ...(var_middle_cat.value.var_04[5] || []),
  ...(var_middle_cat.value.var_04[6] || []),
  ...(var_middle_cat.value.var_04[7] || []),
  ...(var_middle_cat.value.var_04[8] || [])]
  : var_middle_cat.value.var_04[currentSourceRow.cat_id] }}"
    defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
    emptyMessage="No rows found"
    enableSaveActions={true}
    heightType="auto"
    margin="8px 6px 3px 6px"
    primaryKeyColumnId="7fac2"
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
      id="7c326"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="{{ currentSourceRow.cat_id >= 668 ? false : true }}"
      key="cat_nm"
      label="대분류"
      placeholder="Enter value"
      position="center"
      size={47.109375}
      summaryAggregationMode="none"
    />
    <Column
      id="c2158"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      key="middle_cat"
      label="중분류"
      placeholder="Enter value"
      position="center"
      size={47.109375}
      summaryAggregationMode="none"
    />
    <Column
      id="7fac2"
      alignment="right"
      editable="false"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="cat_id"
      label="Cat ID"
      placeholder="Enter value"
      position="center"
      size={51.34375}
      summaryAggregationMode="none"
    />
    <Column
      id="bd701"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="tot_ord_qty"
      label="발주수량"
      placeholder="Enter value"
      position="center"
      size={60}
      summaryAggregationMode="none"
    />
    <Column
      id="af722"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      hidden="true"
      key="tot_ord_tag"
      label="발주금액(TAG)"
      placeholder="Enter value"
      position="center"
      size={97}
      summaryAggregationMode="none"
      valueOverride="{{ item/1000000 }}"
    />
    <Column
      id="0992f"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="average"
      hidden="true"
      key="in_rate_tag"
      label="입고율"
      placeholder="Enter value"
      position="center"
      size={62}
      summaryAggregationMode="none"
    />
    <Column
      id="8a28d"
      alignment="center"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="ord_st"
      label="총 컬러수"
      placeholder="Enter value"
      position="center"
      size={60.46875}
      summaryAggregationMode="none"
    />
    <Column
      id="d3e06"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="in_st"
      label="입고 컬러수"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="a8240"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="not_in_st"
      label="미입고컬러수"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="204c0"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="average"
      hidden="true"
      key="in_st_rate"
      label="기획대비컬러 입고율"
      placeholder="Enter value"
      position="center"
      size={124}
      summaryAggregationMode="none"
    />
    <Column
      id="fc6b5"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="out_st"
      label="출고 컬러수"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="c5f5d"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="not_out_st"
      label="미출고 컬러수"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="beb50"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="average"
      hidden="true"
      key="out_st_rate"
      label="기획대비컬러 출고율"
      placeholder="Enter value"
      position="center"
      size={113}
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
      id="0ed3d"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="average"
      key="sale_rate_qty"
      label="판매율(수량)"
      placeholder="Enter value"
      position="center"
      size={77.296875}
      summaryAggregationMode="none"
    />
    <Column
      id="7feec"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="inven_qty"
      label="재고수량"
      placeholder="Enter value"
      position="center"
      size={57.484375}
      summaryAggregationMode="none"
    />
    <Column
      id="17e39"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="inven_tag"
      label="재고금액"
      placeholder="Enter value"
      position="center"
      size={57.484375}
      summaryAggregationMode="none"
      valueOverride="{{ item/1000000 }}"
    />
    <Column
      id="f2c72"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      hidden="true"
      key="tot_in_cost_amt"
      label="누적입고구입가(+)"
      placeholder="Enter value"
      position="center"
      size={109}
      summaryAggregationMode="none"
      valueOverride="{{ item/1000000 }}"
    />
    <Column
      id="e14d2"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "2",
      }}
      groupAggregationMode="sum"
      hidden="true"
      key="mark_up"
      label="배수"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
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
      size={111.859375}
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
      size={111.859375}
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
      size={88.609375}
      summaryAggregationMode="none"
      valueOverride="{{ item/1000000 }}"
    />
    <Column
      id="d38ce"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="average"
      key="sale_rate_tag"
      label="누적판매율(TAG)"
      placeholder="Enter value"
      position="center"
      size={101.484375}
      summaryAggregationMode="none"
      textColor="{{ currentRow.sale_rate_tag >= item ? '#fc5b5b' : '#000000' }}"
    />
    <Column
      id="edb3e"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="average"
      key="sale_rate_amt"
      label="누적실판매율"
      placeholder="Enter value"
      position="center"
      size={78.234375}
      summaryAggregationMode="none"
      textColor="{{ currentRow.sale_rate_amt >= item ? '#fc5b5b' : '#000000' }}"
    />
    <Column
      id="f36cf"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="average"
      key="discount_rate"
      label="할인율"
      placeholder="Enter value"
      position="center"
      size={52.34375}
      summaryAggregationMode="none"
    />
    <Column
      id="ac4f0"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="ttl_index"
      label="Ttl index"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="31be1"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="monthly_sale_qty"
      label="Monthly sale qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="9d40c"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="monthly_sale_tag"
      label="Monthly sale tag"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="0439b"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="monthly_sale_amt"
      label="Monthly sale amt"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="0998b"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="last_week_sale_qty"
      label="Last week sale qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="7172f"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="last_week_sale_tag"
      label="Last week sale tag"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="d8611"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="last_week_sale_amt"
      label="Last week sale amt"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="11eec"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="average"
      hidden="false"
      key="last_week_progress_rate"
      label="전주판매진도율"
      placeholder="Enter value"
      position="center"
      size={88.609375}
      summaryAggregationMode="none"
    />
    <Column
      id="532da"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="this_week_sale_qty"
      label="This week sale qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="4ef4b"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="this_week_sale_tag"
      label="This week sale tag"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="63d50"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="this_week_sale_amt"
      label="This week sale amt"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="91a27"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="average"
      hidden="false"
      key="this_week_progress_rate"
      label="금주판매진도율"
      placeholder="Enter value"
      position="center"
      size={88.609375}
      summaryAggregationMode="none"
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
        pluginId="table8"
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
        pluginId="table8"
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
            src: "\nswitch(currentSourceRow.cat_id){\n  case 999: // 총계\n  case 888: // 기획소계\n  case 777: // 정상소계\n  case 666: // 시즌용품\n  case 8:\n  case 7:\n  case 6:\n  case 5: // 기획내의\n  case 4: // 기획외의\n  case 3: // 정상토들러 \n  case 2: // 시즌의류\n  case 1: { // 기초복 \n    var_clicked_middle_cat.setValue(\n      {\n        cat_id: currentSourceRow.cat_id,\n        middle_cat:  currentSourceRow.middle_cat ,\n        start_dt:'2000-01-01',\n        end_dt: date_select.value,\n        year_cd: 'S0',\n        year_sesn_nm:  moment().year(),\n      cat_nm: currentSourceRow.cat_nm\n      }\n    )\n    await get_item_status.trigger()\n    modal_item_list.show()\n  } break; // 기획언더\n}",
          },
        ],
      }}
      pluginId=""
      type="script"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="clickRow"
      method="showNotification"
      params={{
        ordered: [
          {
            options: {
              ordered: [
                { notificationType: "info" },
                { title: "데이터를 불러오고 있습니다" },
                { duration: "4.5" },
              ],
            },
          },
        ],
      }}
      pluginId=""
      type="util"
      waitMs="0"
      waitType="debounce"
    />
  </Table>
</ExpandedRow>
