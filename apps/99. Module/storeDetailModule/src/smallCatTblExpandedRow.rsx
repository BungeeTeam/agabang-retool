<ExpandedRow id="smallCatTblExpandedRow">
  <Table
    id="table25"
    autoColumnWidth={true}
    cellSelection="none"
    clearChangesetOnSave={true}
    data={
      '{{ mergeShopInventoryByStyleQuery.value\n  .filter(item => {\n    if(largeCatSelect.value && largeCatSelect.value !== "전체") {\n      return item.it_nm === largeCatSelect.value\n    }\n    return true\n  })\n  .filter(item => {\n    if(midCatSelect.value && midCatSelect.value !== "전체") {\n      return item.it_gb_nm === midCatSelect.value\n    }\n    return true\n  })\n  .filter(item => item.year_nm === selectedInventoryRow.value.year_nm && item.season_nm === selectedInventoryRow.value.season_nm && item.it_nm === currentRow.it_nm && item.it_gb_nm === currentRow.it_gb_nm &&\n    item.item_nm === currentRow.item_nm)\n  .sort((a, b) => a.sty_nm.localeCompare(b.sty_nm, "ko"))\n}}'
    }
    defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
    dynamicColumnProperties={{ formatByIndex: "auto" }}
    emptyMessage="No rows found"
    enableSaveActions={true}
    groupedColumnConfig={{ size: 152.875, expandByDefault: false }}
    heightType="auto"
    margin="0"
    primaryKeyColumnId="4a234"
    rowHeight="medium"
    rowSelection="none"
    showBorder={true}
    showHeader={true}
    style={{ headerBackground: "tokens/356f4e7b" }}
    toolbarPosition="bottom"
  >
    <Column
      id="4a234"
      alignment="left"
      cellTooltip="{{ item }}"
      cellTooltipMode="custom"
      editable="false"
      format="string"
      groupAggregationMode="none"
      key="sty_nm"
      label="스타일명"
      placeholder="Enter value"
      position="center"
      referenceId="sty_nm"
      size={109.34375}
      summaryAggregationMode="none"
    />
    <Column
      id="d2e0b"
      alignment="right"
      caption="({{ currentSourceRow.period_in_qty }})"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="in_qty"
      label="매장입고량"
      placeholder="Enter value"
      position="center"
      size={67.859375}
      summaryAggregationMode="none"
    />
    <Column
      id="88154"
      alignment="right"
      caption="({{ currentSourceRow.period_rt_in_qty }})"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="rt_in_qty"
      label="RT물량"
      placeholder="Enter value"
      position="center"
      size={51.59375}
      summaryAggregationMode="none"
    />
    <Column
      id="2083f"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="cust_rqty"
      label="고객반품"
      placeholder="Enter value"
      position="center"
      size={57.515625}
      summaryAggregationMode="none"
    />
    <Column
      id="33932"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="stock_qty"
      label="재고수량"
      placeholder="Enter value"
      position="center"
      size={57.484375}
      summaryAggregationMode="none"
    />
    <Column
      id="276cf"
      alignment="right"
      caption="({{ currentSourceRow.period_nst_sale_qty }})"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="net_sales_qty"
      label="판매량"
      placeholder="Enter value"
      position="center"
      size={47.109375}
      summaryAggregationMode="none"
      tooltip="판매-반품"
    />
    <Column
      id="1c2f0"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="rtn_qty"
      label="기타반품"
      placeholder="Enter value"
      position="center"
      size={58.171875}
      summaryAggregationMode="none"
    />
    <Column
      id="345a6"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="adjt_qty"
      label="조정물량"
      placeholder="Enter value"
      position="center"
      size={57.515625}
      summaryAggregationMode="none"
    />
    <Column
      id="8f132"
      alignment="right"
      backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
      caption="({{ (currentSourceRow.period_sale_qty / (currentSourceRow.period_in_qty + currentSourceRow.period_rt_in_qty)*100 || 0).toFixed(1)}}%)"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="average"
      label="매장판매율"
      placeholder="Enter value"
      position="center"
      referenceId="column19"
      size={67.859375}
      summaryAggregationMode="none"
      valueOverride="{{ currentSourceRow.net_sales_qty / (currentSourceRow.stock_qty + currentSourceRow.net_sales_qty) }}"
    />
    <Column
      id="bf41a"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="average"
      label="전체판매량"
      placeholder="Enter value"
      position="center"
      referenceId="column18"
      size={67.859375}
      summaryAggregationMode="none"
      tooltip="전 매장의 평균판매량을 의미합니다"
      valueOverride="{{ currentSourceRow.tot_sales_qty / (currentSourceRow.tot_stock_qty + currentSourceRow.tot_sales_qty) }}"
    />
    <Column
      id="b01b0"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="average"
      label="판매율차이"
      placeholder="Enter value"
      position="center"
      referenceId="column23"
      size={67.859375}
      summaryAggregationMode="none"
      textColor={'{{ item > 0? "green": "red" }}'}
      valueOverride="{{ currentSourceRow.net_sales_qty / (currentSourceRow.stock_qty + currentSourceRow.net_sales_qty) - currentSourceRow.tot_sales_qty / (currentSourceRow.tot_stock_qty + currentSourceRow.tot_sales_qty) }}"
    />
    <Column
      id="ea71f"
      alignment="right"
      editable={false}
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="year_nm"
      label="시즌연도"
      placeholder="Enter value"
      position="center"
      referenceId="year_nm"
      size={100}
      summaryAggregationMode="none"
    />
  </Table>
</ExpandedRow>
