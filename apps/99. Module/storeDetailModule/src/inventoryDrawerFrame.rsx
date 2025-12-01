<DrawerFrame
  id="inventoryDrawerFrame"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
  styleContext={{ ordered: [] }}
  width="65%"
>
  <Header>
    <Text
      id="drawerTitle"
      value="### {{ selectedInventoryRow.value.year_nm }} {{ selectedInventoryRow.value.season_nm }} 재고상세"
      verticalAlign="center"
    />
    <Button
      id="drawerCloseButton1"
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
        pluginId="inventoryDrawerFrame"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Select
      id="largeCatSelect"
      data={
        '{{\n(() => {\n  const uniqueNames = [...new Set(shopInvenByLargeCatQuery.value.map(item => item.it_nm))];\n\n  uniqueNames.unshift("전체")\n  return uniqueNames.filter(item => item !== "")\n\n})()\n}}'
      }
      emptyMessage="No options"
      label=""
      labelPosition="top"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="대분류"
      value={'"전체"'}
    />
    <Select
      id="midCatSelect"
      data={
        '{{\n(() => {\n  const uniqueNames = [...new Set(shopInvenByMiddleCatQuery.value.map(item => item.it_gb_nm))].sort((a, b) =>  a.localeCompare(b, "ko"));\n  \n  uniqueNames.unshift("전체")\n  return uniqueNames.filter(item => item !== "")\n})()\n}}'
      }
      emptyMessage="No options"
      label=""
      labelPosition="top"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="중분류"
      value={'"전체"'}
    />
  </Header>
  <Body>
    <Text
      id="text50"
      margin="0"
      value="###### 대분류별 재고"
      verticalAlign="center"
    />
    <Text
      id="text60"
      disableMarkdown={true}
      horizontalAlign="right"
      style={{
        ordered: [
          { color: "rgba(70, 70, 70, 1)" },
          { fontSize: "12px" },
          { fontWeight: "500" },
          { fontFamily: "Pretendard variable" },
        ],
      }}
      value="* 괄호 안 숫자는 조회기간 내의 수량"
      verticalAlign="center"
    />
    <Table
      id="largeCatTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data={
        '{{ shopInvenByLargeCatQuery.value\n  .filter(item => {\n    if(largeCatSelect.value && largeCatSelect.value !== "전체") {\n      return item.it_nm === largeCatSelect.value\n    }\n    return true\n  })\n  .filter(item => item.year_nm === selectedInventoryRow.value.year_nm && item.season_nm === selectedInventoryRow.value.season_nm) }}'
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
      <Include src="./largeCatTblExpandedRow.rsx" />
      <Column
        id="4a234"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="it_nm"
        label="대분류"
        placeholder="Enter value"
        position="center"
        referenceId="it_nm"
        size={76.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="d2e0b"
        alignment="right"
        caption="({{ currentSourceRow.period_in_qty.toLocaleString() }})"
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
        caption="({{ currentSourceRow.period_rt_in_qty.toLocaleString() }})"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="rt_in_qty"
        label="RT물량"
        placeholder="Enter value"
        position="center"
        size={51.375}
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
        caption="({{ currentSourceRow.period_net_sale_qty.toLocaleString() }})"
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
        label="전체판매율"
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
    <Spacer id="spacer8" />
    <Spacer id="spacer18" />
    <Text
      id="text51"
      margin="0"
      value="###### 중분류별 재고"
      verticalAlign="center"
    />
    <Text
      id="text61"
      disableMarkdown={true}
      horizontalAlign="right"
      style={{
        ordered: [
          { color: "rgba(70, 70, 70, 1)" },
          { fontSize: "12px" },
          { fontWeight: "500" },
          { fontFamily: "Pretendard variable" },
        ],
      }}
      value="* 괄호 안 숫자는 조회기간 내의 수량"
      verticalAlign="center"
    />
    <Table
      id="middleCatTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data={
        '{{ shopInvenByMiddleCatQuery.value\n  .filter(item => {\n    if(largeCatSelect.value && largeCatSelect.value !== "전체") {\n      return item.it_nm === largeCatSelect.value\n    }\n    return true\n  })\n  .filter(item => {\n    if(midCatSelect.value && midCatSelect.value !== "전체") {\n      return item.it_gb_nm === midCatSelect.value\n    }\n    return true\n  })\n  .filter(item => item.year_nm === selectedInventoryRow.value.year_nm && item.season_nm === selectedInventoryRow.value.season_nm)\n  .sort((a, b) => a.it_nm.localeCompare(b.it_nm, "ko") && a.it_gb_nm.localeCompare(b.it_gb_nm, "ko"))\n}}'
      }
      defaultFilterOperator="or"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      groupedColumnConfig={{ size: 152.875, expandByDefault: false }}
      heightType="auto"
      margin="0"
      rowHeight="medium"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
      toolbarPosition="bottom"
    >
      <Include src="./middleCatTblExpandedRow.rsx" />
      <Column
        id="4a234"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="it_nm"
        label="대분류"
        placeholder="Enter value"
        position="center"
        referenceId="it_nm"
        size={76.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="f62d1"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        format="string"
        groupAggregationMode="none"
        key="it_gb_nm"
        label="중분류"
        placeholder="Enter value"
        position="center"
        referenceId="중분류"
        size={62.75}
        summaryAggregationMode="none"
      />
      <Column
        id="d2e0b"
        alignment="right"
        caption="({{ currentSourceRow.period_in_qty.toLocaleString() }})"
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
        caption="({{ currentSourceRow.period_rt_in_qty.toLocaleString() }})"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="rt_in_qty"
        label="RT물량"
        placeholder="Enter value"
        position="center"
        size={51.375}
        summaryAggregationMode="none"
      />
      <Column
        id="2083f"
        alignment="right"
        caption="({{ currentSourceRow.period_sale_qty.toLocaleString() }})"
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
        caption="({{ currentSourceRow.period_net_sale_qty.toLocaleString() }})"
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
      >
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="shopInventoryByStyleInPeriodQuery"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
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
        id="8f132"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
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
        label="전체판매율"
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
        size={57.515625}
        summaryAggregationMode="none"
      />
    </Table>
    <Spacer id="spacer10" />
    <Spacer id="spacer17" />
    <Text
      id="text53"
      margin="0"
      value="###### 소분류별 재고"
      verticalAlign="center"
    />
    <Text
      id="text62"
      disableMarkdown={true}
      horizontalAlign="right"
      style={{
        ordered: [
          { color: "rgba(70, 70, 70, 1)" },
          { fontSize: "12px" },
          { fontWeight: "500" },
          { fontFamily: "Pretendard variable" },
        ],
      }}
      value="* 괄호 안 숫자는 조회기간 내의 수량"
      verticalAlign="center"
    />
    <Table
      id="smallCatTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data={
        '{{ shopInvenBySmallCatQuery.value\n  .filter(item => {\n    if(largeCatSelect.value && largeCatSelect.value !== "전체") {\n      return item.it_nm === largeCatSelect.value\n    }\n    return true\n  })\n  .filter(item => {\n    if(midCatSelect.value && midCatSelect.value !== "전체") {\n      return item.it_gb_nm === midCatSelect.value\n    }\n    return true\n  })\n  .filter(item => item.year_nm === selectedInventoryRow.value.year_nm && item.season_nm === selectedInventoryRow.value.season_nm\n  )\n  .sort((a, b) => a.it_nm.localeCompare(b.it_nm, "ko") && a.it_gb_nm.localeCompare(b.it_gb_nm, "ko") && a.item_nm.localeCompare(b.item_nm, "ko")) }}'
      }
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableExpandableRows={true}
      enableSaveActions={true}
      groupedColumnConfig={{ size: 152.875, expandByDefault: false }}
      heightType="auto"
      margin="0"
      rowHeight="medium"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
      toolbarPosition="bottom"
    >
      <Include src="./smallCatTblExpandedRow.rsx" />
      <Column
        id="4a234"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="it_nm"
        label="대분류"
        placeholder="Enter value"
        position="center"
        referenceId="it_nm"
        size={76.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="d61d2"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="it_gb_nm"
        label="중분류"
        placeholder="Enter value"
        position="center"
        referenceId="it_gb_nm"
        size={62.75}
        summaryAggregationMode="none"
      />
      <Column
        id="3e50c"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="item_nm"
        label="소분류"
        placeholder="Enter value"
        position="center"
        referenceId="item_nm"
        size={67.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="d2e0b"
        alignment="right"
        caption="({{ currentSourceRow.period_in_qty.toLocaleString() }})"
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
        caption="({{ currentSourceRow.period_rt_in_qty.toLocaleString() }})"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="rt_in_qty"
        label="RT물량"
        placeholder="Enter value"
        position="center"
        size={51.375}
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
        size={0}
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
        caption="({{ currentSourceRow.period_net_sale_qty.toLocaleString() }})"
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
        size={0}
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
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="8f132"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
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
        label="전체판매율"
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
        size={0}
        summaryAggregationMode="none"
      />
    </Table>
  </Body>
</DrawerFrame>
