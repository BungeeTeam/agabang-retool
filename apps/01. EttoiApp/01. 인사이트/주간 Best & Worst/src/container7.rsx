<Container
  id="container7"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  hidden="{{var_best_worst.value[item].best.length + var_best_worst.value[item].worst.length == 0}}"
  overflowType="hidden"
  padding="12px"
  showBody={true}
  showHeader={true}
  style={{ ordered: [{ headerBackground: "rgb(68, 74, 103)" }] }}
>
  <Header>
    <Text id="containerTitle7" value="#### {{ item }}" verticalAlign="center" />
  </Header>
  <View id="40734" viewKey="View 1">
    <Text id="text14" value="###### 👑 Best" verticalAlign="center" />
    <Text id="text15" value="###### 😞 Worst" verticalAlign="center" />
    <Table
      id="table_worst"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ var_best_worst.value[item].worst }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicRowHeights={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="27ce6"
        alignment="left"
        backgroundColor="{{ theme.canvas }}"
        format="image"
        formatOptions={{ widthType: "fit" }}
        groupAggregationMode="none"
        label="사진"
        placeholder="Enter value"
        position="left"
        referenceId="product_image"
        size={100}
        summaryAggregationMode="none"
        valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg"
      />
      <Column
        id="335a4"
        alignment="left"
        backgroundColor="{{ theme.canvas }}"
        caption="{{currentSourceRow.sty_cd}}"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="품명"
        placeholder="Enter value"
        position="left"
        size={110.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="a8863"
        alignment="left"
        format="tag"
        formatOptions={{
          automaticColors: false,
          color:
            "{{var_color_hex_list.value.find(i => i.col_nm == item).col_hex}}",
        }}
        groupAggregationMode="none"
        key="col_nm"
        label="컬러"
        placeholder="Select option"
        position="center"
        size={95.96875}
        summaryAggregationMode="none"
      />
      <Column
        id="349c0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="int_sale_qty"
        label="주간판매량"
        placeholder="Enter value"
        position="center"
        referenceId="주간판매량"
        size={67.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="5647a"
        alignment="right"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="int_sale_qty"
        label="판매진척"
        placeholder="Enter value"
        position="center"
        referenceId="판매진척"
        size={57.484375}
        summaryAggregationMode="none"
        valueOverride="{{Number(item) / Number(currentSourceRow.tot_in_qty)}}"
      />
      <Column
        id="192d9"
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
        key="tot_sale_qty"
        label="누적판매율"
        placeholder="Enter value"
        position="center"
        referenceId="cumulative_sales_rate"
        size={67.859375}
        summaryAggregationMode="none"
        valueOverride="{{Number(item) / Number(currentSourceRow.tot_in_qty)}}"
      />
      <Column
        id="d11b7"
        alignment="left"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="progress"
        formatOptions={{
          min: 0,
          max: 100,
          positiveTrend: 100,
          negativeTrend: 10,
        }}
        groupAggregationMode="average"
        key="tot_sale_qty"
        label="(%)"
        placeholder="Enter value"
        position="center"
        size={55.09375}
        summaryAggregationMode="none"
        valueOverride="{{Number(item) / Number(currentSourceRow.tot_in_qty) * 100}}"
      />
      <Column
        id="35053"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="입고량"
        placeholder="Enter value"
        position="center"
        referenceId="입고량"
        size={56.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="f924a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_sale_qty"
        label="누적판매량"
        placeholder="Enter value"
        position="center"
        referenceId="cumulative_sales_qty"
        size={67.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="251cf"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tag_prce"
        label="최초가"
        placeholder="Enter value"
        position="center"
        referenceId="price_original"
        size={66.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="462cd"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="f_sale_prce"
        label="현재판매가"
        placeholder="Enter value"
        position="center"
        referenceId="price_current"
        size={77.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="3d18b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
          padDecimal: true,
        }}
        groupAggregationMode="sum"
        key="multi_rate"
        label="배수"
        placeholder="Enter value"
        position="center"
        referenceId="price_multiple"
        size={45.734375}
        summaryAggregationMode="none"
      />
      <Column
        id="dd3b4"
        alignment="left"
        format="date"
        formatOptions={{ dateFormat: "yyyy/MM/dd" }}
        groupAggregationMode="none"
        key="fin_date"
        label="입고일"
        placeholder="Enter value"
        position="center"
        referenceId="date_first_receive"
        size={82.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="9c55a"
        alignment="left"
        format="date"
        formatOptions={{ dateFormat: "yyyy/MM/dd" }}
        groupAggregationMode="none"
        key="fout_date"
        label="출고일"
        placeholder="Enter value"
        position="center"
        referenceId="date_first_release"
        size={82.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="2b0ab"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="col_cd"
        label="Col cd"
        placeholder="Enter value"
        position="center"
        size={51.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="b507b"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sty_cd"
        label="Sty cd"
        placeholder="Enter value"
        position="center"
        size={82.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="069aa"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="multi_rate"
        label="Multi rate"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="var_sty_data"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="drawerFrame_item_detail_new"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Table
      id="table_best"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ var_best_worst.value[item].best }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicRowHeights={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="27ce6"
        alignment="left"
        backgroundColor="{{ theme.canvas }}"
        format="image"
        formatOptions={{ widthType: "fit" }}
        groupAggregationMode="none"
        label="사진"
        placeholder="Enter value"
        position="left"
        referenceId="product_image"
        size={100}
        summaryAggregationMode="none"
        valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg"
      />
      <Column
        id="335a4"
        alignment="left"
        backgroundColor="{{ theme.canvas }}"
        caption="{{currentSourceRow.sty_cd}}"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="품명"
        placeholder="Enter value"
        position="left"
        size={110.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="a8863"
        alignment="left"
        format="tag"
        formatOptions={{
          automaticColors: false,
          color:
            "{{var_color_hex_list.value.find(i => i.col_nm == item).col_hex}}",
        }}
        groupAggregationMode="none"
        key="col_nm"
        label="컬러"
        placeholder="Select option"
        position="center"
        size={106.96875}
        summaryAggregationMode="none"
      />
      <Column
        id="349c0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="int_sale_qty"
        label="주간판매량"
        placeholder="Enter value"
        position="center"
        referenceId="주간판매량"
        size={67.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="5647a"
        alignment="right"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="int_sale_qty"
        label="판매진척"
        placeholder="Enter value"
        position="center"
        referenceId="판매진척"
        size={57.484375}
        summaryAggregationMode="none"
        valueOverride="{{Number(item) / Number(currentSourceRow.tot_in_qty)}}"
      />
      <Column
        id="192d9"
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
        key="tot_sale_qty"
        label="누적판매율"
        placeholder="Enter value"
        position="center"
        referenceId="cumulative_sales_rate"
        size={67.859375}
        summaryAggregationMode="none"
        valueOverride="{{Number(item) / Number(currentSourceRow.tot_in_qty)}}"
      />
      <Column
        id="d11b7"
        alignment="left"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="progress"
        formatOptions={{
          min: 0,
          max: 100,
          positiveTrend: 100,
          negativeTrend: 10,
        }}
        groupAggregationMode="average"
        key="tot_sale_qty"
        label="(%)"
        placeholder="Enter value"
        position="center"
        size={55.09375}
        summaryAggregationMode="none"
        valueOverride="{{Number(item) / Number(currentSourceRow.tot_in_qty) * 100}}"
      />
      <Column
        id="35053"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="입고량"
        placeholder="Enter value"
        position="center"
        referenceId="입고량"
        size={56.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="f924a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_sale_qty"
        label="누적판매량"
        placeholder="Enter value"
        position="center"
        referenceId="cumulative_sales_qty"
        size={67.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="251cf"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tag_prce"
        label="최초가"
        placeholder="Enter value"
        position="center"
        referenceId="price_original"
        size={66.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="462cd"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="f_sale_prce"
        label="현재판매가"
        placeholder="Enter value"
        position="center"
        referenceId="price_current"
        size={77.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="3d18b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
          padDecimal: true,
        }}
        groupAggregationMode="sum"
        key="multi_rate"
        label="배수"
        placeholder="Enter value"
        position="center"
        referenceId="price_multiple"
        size={45.734375}
        summaryAggregationMode="none"
      />
      <Column
        id="dd3b4"
        alignment="left"
        format="date"
        formatOptions={{ dateFormat: "yyyy/MM/dd" }}
        groupAggregationMode="none"
        key="fin_date"
        label="입고일"
        placeholder="Enter value"
        position="center"
        referenceId="date_first_receive"
        size={82.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="9c55a"
        alignment="left"
        format="date"
        formatOptions={{ dateFormat: "yyyy/MM/dd" }}
        groupAggregationMode="none"
        key="fout_date"
        label="출고일"
        placeholder="Enter value"
        position="center"
        referenceId="date_first_release"
        size={82.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="2b0ab"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="col_cd"
        label="Col cd"
        placeholder="Enter value"
        position="center"
        size={51.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="b507b"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sty_cd"
        label="Sty cd"
        placeholder="Enter value"
        position="center"
        size={82.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="069aa"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="multi_rate"
        label="Multi rate"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow}}" }] }}
        pluginId="var_sty_data"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="drawerFrame_item_detail_new"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </View>
</Container>
