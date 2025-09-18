<ExpandedRow id="largeCatTblExpandedRow">
  <Table
    id="table19"
    autoColumnWidth={true}
    cellSelection="none"
    clearChangesetOnSave={true}
    data="{{ shopInventoryByStyleQuery.data.filter(item => item.it_gb_nm === currentRow.it_gb_nm && item.item_nm === currentRow.item_nm)}}"
    defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
    dynamicColumnProperties={{ formatByIndex: "auto" }}
    emptyMessage="No rows found"
    enableSaveActions={true}
    groupedColumnConfig={{ size: 152.875, expandByDefault: false }}
    primaryKeyColumnId="cabaf"
    rowHeight="small"
    showBorder={true}
    showFooter={true}
    showHeader={true}
    style={{ headerBackground: "tokens/356f4e7b" }}
    toolbarPosition="bottom"
  >
    <Column
      id="244e0"
      alignment="left"
      editable="false"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="sty_cd"
      label="Sty cd"
      placeholder="Enter value"
      position="center"
      size={85.796875}
      summaryAggregationMode="none"
    />
    <Column
      id="cabaf"
      alignment="left"
      cellTooltip="{{ item }}"
      cellTooltipMode="custom"
      editable={false}
      format="string"
      groupAggregationMode="none"
      key="sty_nm"
      label="스타일명"
      placeholder="Enter value"
      position="center"
      size={57.515625}
      summaryAggregationMode="none"
    />
    <Column
      id="d2e0b"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="in_qty"
      label="매장입고량"
      placeholder="Enter value"
      position="center"
      size={67.890625}
      summaryAggregationMode="none"
    />
    <Column
      id="88154"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="rt_in_qty"
      label="매장이동물량"
      placeholder="Enter value"
      position="center"
      size={78.28125}
      summaryAggregationMode="none"
    />
    <Column
      id="2083f"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
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
      backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="stock_qty"
      label="재고수량"
      placeholder="Enter value"
      position="center"
      size={57.515625}
      summaryAggregationMode="none"
    />
    <Column
      id="276cf"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="sales_qty"
      label="판매량"
      placeholder="Enter value"
      position="center"
      size={47.125}
      summaryAggregationMode="none"
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
      size={57.515625}
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
      id="df305"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="tot_in_qty"
      label="총입고량"
      placeholder="Enter value"
      position="center"
      size={57.515625}
      summaryAggregationMode="none"
      tooltip="전 매장의 총 입고수량을 의미합니다"
    />
    <Column
      id="b3221"
      alignment="left"
      editable="false"
      editableOptions={{ showStepper: true }}
      format="string"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="year_nm"
      label="시즌연도"
      placeholder="Enter value"
      position="center"
      size={57.515625}
      summaryAggregationMode="none"
    />
    <Column
      id="ca60d"
      alignment="left"
      editable="false"
      format="string"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="none"
      key="season_nm"
      label="시즌계절"
      placeholder="Enter value"
      position="center"
      size={57.515625}
      summaryAggregationMode="none"
      valueOverride="{{ _.startCase(item) }}"
    />
    <Column
      id="fc803"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="season_seq"
      label="Season seq"
      placeholder="Enter value"
      position="center"
      size={81.8125}
      summaryAggregationMode="none"
    />
    <Column
      id="16353"
      alignment="left"
      editable="false"
      format="string"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="none"
      key="it_nm"
      label="대분류"
      placeholder="Enter value"
      position="center"
      size={47.125}
      summaryAggregationMode="none"
      valueOverride="{{ _.startCase(item) }}"
    />
    <Column
      id="80ac6"
      alignment="left"
      editable="false"
      format="string"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="none"
      key="it_gb_nm"
      label="중분류"
      placeholder="Enter value"
      position="center"
      size={47.125}
      summaryAggregationMode="none"
      valueOverride="{{ _.startCase(item) }}"
    />
    <Column
      id="41bb2"
      alignment="left"
      editable={false}
      format="string"
      groupAggregationMode="none"
      key="item_nm"
      label="소분류"
      placeholder="Enter value"
      position="center"
      size={47.125}
      summaryAggregationMode="none"
    />
    <Column
      id="abca2"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="tot_sales_qty"
      label="총판매량"
      placeholder="Enter value"
      position="center"
      size={57.515625}
      summaryAggregationMode="none"
      tooltip="전 매장의 총 판매량을 의미합니다"
    />
    <Column
      id="38141"
      alignment="right"
      backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="tot_stock_qty"
      label="총재고량"
      placeholder="Enter value"
      position="center"
      size={57.515625}
      summaryAggregationMode="none"
      tooltip="전 매장의 총재고량을 의미합니다"
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
      label="평균판매량"
      placeholder="Enter value"
      position="center"
      referenceId="column18"
      size={67.890625}
      summaryAggregationMode="none"
      tooltip="전 매장의 평균판매량을 의미합니다"
      valueOverride="{{ currentSourceRow.tot_sales_qty / currentSourceRow.tot_in_qty }}"
    />
    <Column
      id="8f132"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="average"
      label="Column 19"
      placeholder="Enter value"
      position="center"
      referenceId="column19"
      size={79.796875}
      summaryAggregationMode="none"
      valueOverride="{{ currentSourceRow.sales_qty / (currentSourceRow.stock_qty + currentSourceRow.sales_qty) }}"
    />
  </Table>
</ExpandedRow>
