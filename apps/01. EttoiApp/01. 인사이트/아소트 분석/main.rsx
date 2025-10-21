<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <DocumentTitle id="$customDocumentTitle" value="아소트 분석 | ET" />
  <Include src="./header.rsx" />
  <Include src="./src/drawerFrame1.rsx" />
  <Include src="./sidebar.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Container
      id="tabbedContainer1"
      currentViewKey="{{ self.viewKeys[0] }}"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
      style={{ ordered: [{ background: "canvas" }] }}
    >
      <View id="1f75c" viewKey="요약 보기">
        <Table
          id="table_main"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ query_get_threshold.data }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          dynamicRowHeights={true}
          emptyMessage="No rows found"
          enableSaveActions={true}
          rowHeight="small"
          searchTerm="{{input_search_keyword.value}}"
          showBorder={true}
          showFooter={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Column
            id="da4d1"
            alignment="center"
            format="image"
            formatOptions={{ widthType: "fit" }}
            groupAggregationMode="none"
            key="sty_cd"
            label="이미지"
            placeholder="Enter value"
            position="left"
            referenceId="image_link"
            size={83}
            summaryAggregationMode="none"
            valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg"
          />
          <Column
            id="058a7"
            alignment="left"
            format="string"
            groupAggregationMode="none"
            hidden="true"
            key="sty_cd"
            label="style_code"
            placeholder="Enter value"
            position="center"
            referenceId="style_code"
            size={85.71875}
            summaryAggregationMode="none"
          />
          <Column
            id="45427"
            alignment="center"
            caption="{{currentSourceRow.sty_cd}}"
            format="string"
            groupAggregationMode="none"
            key="sty_nm"
            label="스타일명"
            placeholder="Enter value"
            position="left"
            referenceId="style_name"
            size={149.1875}
            summaryAggregationMode="none"
          />
          <Column
            id="2cf35"
            alignment="center"
            format="tag"
            formatOptions={{ automaticColors: false }}
            groupAggregationMode="none"
            key="col_nm"
            label="컬러명"
            placeholder="Select option"
            position="left"
            referenceId="color"
            size={106.625}
            summaryAggregationMode="none"
            valueOverride="{{item}}"
          />
          <Column
            id="99ce6"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="color_sale_rate"
            label="컬러별 판매율"
            placeholder="Enter value"
            position="center"
            referenceId="total_sales_rate"
            size={110.46875}
            summaryAggregationMode="none"
          />
          <Column
            id="59df9"
            alignment="center"
            format="date"
            formatOptions={{ dateFormat: "yyyy-MM-dd" }}
            groupAggregationMode="none"
            key="sale_dt"
            label="도달일자"
            placeholder="Enter value"
            position="center"
            referenceId="target_date"
            size={87.78125}
            summaryAggregationMode="none"
          />
          <Column
            id="8001d"
            alignment="right"
            backgroundColor="{{ theme.canvas }}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="color_cum_in_qty"
            label="입고량"
            placeholder="Enter value"
            position="center"
            size={69.140625}
            summaryAggregationMode="none"
          />
          <Column
            id="3a474"
            alignment="right"
            backgroundColor="{{ theme.canvas }}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="color_cum_sale_qty"
            label="판매량"
            placeholder="Enter value"
            position="center"
            size={69.140625}
            summaryAggregationMode="none"
          />
          <Column
            id="09cae"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="html"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="in_rate_3m"
            label="3M/FREE"
            placeholder="Enter value"
            position="center"
            size={128.453125}
            summaryAggregationMode="none"
            textColor="{{color_grad(item)}}"
            valueOverride="{{numbers_html(currentSourceRow.in_rate_3m, currentSourceRow.size_sale_rate_color_3m, currentSourceRow.size_sale_rate_3m)}}"
          />
          <Column
            id="c2eb0"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="html"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="in_rate_6m"
            label="6M/42/7-8"
            placeholder="Enter value"
            position="center"
            size={128.453125}
            summaryAggregationMode="none"
            textColor="{{color_grad(item)}}"
            valueOverride="{{numbers_html(currentSourceRow.in_rate_6m, currentSourceRow.size_sale_rate_color_6m, currentSourceRow.size_sale_rate_6m)}}"
          />
          <Column
            id="91e70"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="html"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="in_rate_12m"
            label="12M/44/9-10"
            placeholder="Enter value"
            position="center"
            size={128.453125}
            summaryAggregationMode="none"
            textColor="{{color_grad(item)}}"
            valueOverride="{{numbers_html(currentSourceRow.in_rate_12m, currentSourceRow.size_sale_rate_color_12m, currentSourceRow.size_sale_rate_12m)}}"
          />
          <Column
            id="cf81f"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="html"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="in_rate_18m"
            label="18M/46/11-12"
            placeholder="Enter value"
            position="center"
            size={128.453125}
            summaryAggregationMode="none"
            textColor="{{color_grad(item)}}"
            valueOverride="{{numbers_html(currentSourceRow.in_rate_18m, currentSourceRow.size_sale_rate_color_18m, currentSourceRow.size_sale_rate_18m)}}"
          />
          <Column
            id="5e284"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="html"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="in_rate_2y"
            label="2Y/48/13~14"
            placeholder="Enter value"
            position="center"
            size={128.453125}
            summaryAggregationMode="none"
            textColor="{{color_grad(item)}}"
            valueOverride="{{numbers_html(currentSourceRow.in_rate_2y, currentSourceRow.size_sale_rate_color_2y, currentSourceRow.size_sale_rate_2y)}}"
          />
          <Column
            id="4889a"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="html"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="in_rate_3y"
            label="3Y/50/15~16"
            placeholder="Enter value"
            position="center"
            size={128.453125}
            summaryAggregationMode="none"
            textColor="{{color_grad(item)}}"
            valueOverride="{{numbers_html(currentSourceRow.in_rate_3y, currentSourceRow.size_sale_rate_color_3y, currentSourceRow.size_sale_rate_3y)}}"
          />
          <Column
            id="c8d53"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="html"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="in_rate_4y"
            label="4Y/52"
            placeholder="Enter value"
            position="center"
            size={128.453125}
            summaryAggregationMode="none"
            textColor="{{color_grad(item)}}"
            valueOverride="{{numbers_html(currentSourceRow.in_rate_4y, currentSourceRow.size_sale_rate_color_4y, currentSourceRow.size_sale_rate_4y)}}"
          />
          <Column
            id="df8df"
            alignment="left"
            format="string"
            groupAggregationMode="none"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Event
            event="clickRow"
            method="show"
            params={{ ordered: [] }}
            pluginId="drawerFrame1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Table>
      </View>
      <View id="53307" viewKey="모든 데이터 보기">
        <Table
          id="table_main2"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ query_get_threshold.data }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          rowHeight="small"
          searchTerm="{{input_search_keyword.value}}"
          showBorder={true}
          showFooter={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Column
            id="eaabd"
            alignment="left"
            format="string"
            groupAggregationMode="none"
            key="sty_cd"
            label="품번"
            placeholder="Enter value"
            position="left"
            size={85.71875}
          />
          <Column
            id="de72c"
            alignment="left"
            format="string"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            key="col_nm"
            label="칼라"
            placeholder="Enter value"
            position="left"
            size={64.8125}
          />
          <Column
            id="ef299"
            alignment="left"
            format="string"
            groupAggregationMode="none"
            key="sty_nm"
            label="제품명"
            placeholder="Enter value"
            position="left"
            size={130.1875}
          />
          <Column
            id="05b29"
            alignment="right"
            backgroundColor="{{ theme.canvas }}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="color_plan_qty"
            label="기획량"
            placeholder="Enter value"
            position="center"
            size={70.796875}
          />
          <Column
            id="7c438"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="plan_qty_3m"
            label="3M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="2e8da"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="plan_qty_6m"
            label="6M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="46479"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="plan_qty_12m"
            label="12M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="10233"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="plan_qty_18m"
            label="18M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="e31f9"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="plan_qty_2y"
            label="2Y"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="0df46"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="plan_qty_3y"
            label="3Y"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="f2ff8"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="plan_qty_4y"
            label="4Y"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="eab8c"
            alignment="right"
            backgroundColor="{{ theme.canvas }}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="color_cum_in_qty"
            label="입고량"
            placeholder="Enter value"
            position="center"
            size={75.796875}
          />
          <Column
            id="00751"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="in_qty_3m"
            label="3M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="fd722"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="in_qty_6m"
            label="6M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="4da3f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="in_qty_12m"
            label="12M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="0c8f6"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="in_qty_18m"
            label="18M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="f7713"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="in_qty_2y"
            label="2Y"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="c851f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="in_qty_3y"
            label="3Y"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="1a95d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="in_qty_4y"
            label="4Y"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="ead8d"
            alignment="right"
            backgroundColor="{{ theme.canvas }}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="tot_in_rate"
            label="입고비중"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="71e98"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="in_rate_3m"
            label="3M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="eeaf0"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="in_rate_6m"
            label="6M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="f61b4"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="in_rate_12m"
            label="12M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="50234"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="in_rate_18m"
            label="18M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="5c8fb"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="in_rate_2y"
            label="2Y"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="96d47"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="in_rate_3y"
            label="3Y"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="bf52f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="in_rate_4y"
            label="4Y"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="2b3c4"
            alignment="right"
            backgroundColor="{{ theme.canvas }}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="color_cum_sale_qty"
            label="판매량"
            placeholder="Enter value"
            position="center"
            size={71.796875}
          />
          <Column
            id="3d14f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sale_qty_3m"
            label="3M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="203b8"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sale_qty_6m"
            label="6M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="f459b"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sale_qty_12m"
            label="12M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="11a76"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sale_qty_18m"
            label="18M"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="e7fa2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sale_qty_2y"
            label="2Y"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="dff0c"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sale_qty_3y"
            label="3Y"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="07660"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sale_qty_4y"
            label="4Y"
            placeholder="Enter value"
            position="center"
            size={49.796875}
          />
          <Column
            id="adc24"
            alignment="right"
            backgroundColor="{{ theme.canvas }}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            key="tot_size_sale_rate"
            label="판매비중"
            placeholder="Enter value"
            position="center"
            size={76.015625}
            summaryAggregationMode="none"
          />
          <Column
            id="fefb8"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_color_3m"
            label="3M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="4f5e1"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_color_6m"
            label="6M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="c0980"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_color_12m"
            label="12M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="bb1b8"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_color_18m"
            label="18M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="d98e8"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_color_2y"
            label="2Y"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="19f2f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_color_3y"
            label="3Y"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="12e9b"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_color_4y"
            label="4Y"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="ca932"
            alignment="right"
            backgroundColor="{{ theme.canvas }}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="color_sale_rate"
            label="소진율"
            placeholder="Enter value"
            position="center"
            referenceId="소진율"
            size={76.015625}
          />
          <Column
            id="c661c"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_3m"
            label="3M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="95a1a"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_6m"
            label="6M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="65490"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_12m"
            label="12M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="84f5d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_18m"
            label="18M"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="82514"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_2y"
            label="2Y"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="0b9fd"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_3y"
            label="3Y"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="5b6dd"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            key="size_sale_rate_4y"
            label="4Y"
            placeholder="Enter value"
            position="center"
            size={76.015625}
          />
          <Column
            id="014d3"
            alignment="left"
            format="string"
            groupAggregationMode="none"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
        </Table>
      </View>
    </Container>
    <Table
      id="table2"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ var_check_parity_final.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="true"
      rowHeight="small"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      showInEditor={true}
      toolbarPosition="bottom"
    >
      <Column
        id="6d630"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sty_cd"
        label="스타일"
        placeholder="Enter value"
        position="center"
        size={85.71875}
        summaryAggregationMode="none"
      />
      <Column
        id="d0532"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="스타일명"
        placeholder="Enter value"
        position="left"
        size={147.65625}
        summaryAggregationMode="none"
      />
      <Column
        id="ed1c2"
        alignment="left"
        format="date"
        formatOptions={{ dateFormat: "yyyy-MM-dd" }}
        groupAggregationMode="none"
        key="sale_dt"
        label="기준일"
        placeholder="Enter value"
        position="center"
        size={87.78125}
        summaryAggregationMode="none"
      />
      <Column
        id="a5f95"
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
        size={53.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="f655e"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="col_nm"
        label="컬러"
        placeholder="Select option"
        position="center"
        size={83.828125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="0ead8"
        alignment="left"
        format="tags"
        formatOptions={{ automaticColors: false }}
        groupAggregationMode="none"
        key="size_list"
        label="사이즈 목록"
        placeholder="Select options"
        position="left"
        size={206.71875}
        summaryAggregationMode="none"
        valueOverride="{{item.replace('[', '').replace(']', '').split(', ').map(item => item.trim())}}"
      />
      <Column
        id="88ba8"
        alignment="left"
        format="boolean"
        formatOptions={{
          falseIcon: "bold/interface-alert-warning-triangle",
          trueIcon: "bold/interface-alert-warning-triangle",
          trueColor: "{{ theme.canvas }}",
          falseColor: "rgba(255, 0, 0, 0.6)",
        }}
        groupAggregationMode="none"
        key="check_sum_plan_qty"
        label="기획량 체크"
        placeholder="Enter value"
        position="center"
        size={71.09375}
        summaryAggregationMode="none"
        valueOverride="{{!item}}"
      />
      <Column
        id="5a084"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="color_plan_qty"
        label="CL"
        placeholder="Enter value"
        position="center"
        size={49.796875}
        summaryAggregationMode="none"
      />
      <Column
        id="7a2ab"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="each_sum_plan_qty"
        label="SIZE"
        placeholder="Enter value"
        position="center"
        size={49.796875}
        summaryAggregationMode="none"
      />
      <Column
        id="27561"
        alignment="left"
        format="boolean"
        formatOptions={{
          trueIcon: "bold/interface-alert-warning-triangle",
          trueColor: "{{ theme.canvas }}",
          falseIcon: "bold/interface-alert-warning-triangle",
          falseColor: "rgba(255, 0, 0, 0.6)",
        }}
        groupAggregationMode="none"
        key="check_in_qty"
        label="입고량 체크"
        placeholder="Enter value"
        position="center"
        size={71.09375}
        summaryAggregationMode="none"
        valueOverride="{{!item}}"
      />
      <Column
        id="0d334"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="color_cum_in_qty"
        label="CL"
        placeholder="Enter value"
        position="center"
        size={49.796875}
        summaryAggregationMode="none"
      />
      <Column
        id="9e00b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="each_sum_in_qty"
        label="SIZE"
        placeholder="Enter value"
        position="center"
        size={49.796875}
        summaryAggregationMode="none"
      />
      <Column
        id="35922"
        alignment="left"
        format="boolean"
        formatOptions={{
          trueIcon: "bold/interface-alert-warning-triangle",
          trueColor: "{{ theme.canvas }}",
          falseIcon: "bold/interface-alert-warning-triangle",
          falseColor: "rgba(255, 0, 0, 0.6)",
        }}
        groupAggregationMode="none"
        key="check_sale_qty"
        label="판매량 체크"
        placeholder="Enter value"
        position="center"
        size={71.09375}
        summaryAggregationMode="none"
        valueOverride="{{!item}}"
      />
      <Column
        id="041c1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="color_cum_sale_qty"
        label="CL"
        placeholder="Enter value"
        position="center"
        size={38.671875}
        summaryAggregationMode="none"
      />
      <Column
        id="51ea3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="each_sum_sale_qty"
        label="SIZE"
        placeholder="Enter value"
        position="center"
        size={42.96875}
        summaryAggregationMode="none"
      />
      <Column
        id="b3687"
        alignment="left"
        format="boolean"
        formatOptions={{
          trueIcon: "bold/interface-alert-warning-triangle",
          trueColor: "{{ theme.canvas }}",
          falseIcon: "bold/interface-alert-warning-triangle",
          falseColor: "rgba(255, 0, 0, 0.6)",
        }}
        groupAggregationMode="none"
        key="check_in_rate"
        label="입고비중 체크"
        placeholder="Enter value"
        position="center"
        size={81.46875}
        summaryAggregationMode="none"
        valueOverride="{{!item}}"
      />
      <Column
        id="1a929"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="tot_in_rate"
        label="CL"
        placeholder="Enter value"
        position="center"
        size={49.78125}
        summaryAggregationMode="none"
      />
      <Column
        id="17ae9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="each_sum_in_rate"
        label="SIZE"
        placeholder="Enter value"
        position="center"
        size={49.78125}
        summaryAggregationMode="none"
      />
      <Column
        id="c3a68"
        alignment="left"
        format="boolean"
        formatOptions={{
          falseIcon: "bold/interface-alert-warning-triangle",
          trueIcon: "bold/interface-alert-warning-triangle",
          trueColor: "rgba(255, 0, 0, 0.6)",
          falseColor: "{{ theme.canvas }}",
        }}
        groupAggregationMode="none"
        key="check_sale_rate_color"
        label="판매비중 체크"
        placeholder="Enter value"
        position="center"
        size={81.46875}
        summaryAggregationMode="none"
        valueOverride="{{item}}"
      />
      <Column
        id="75fb9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="each_sum_size_sale_rate_color"
        label="SIZE"
        placeholder="Enter value"
        position="center"
        size={76.015625}
        summaryAggregationMode="none"
      />
      <Column
        id="a0709"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="plan_qty_3m"
        label="Plan qty 3 m"
        placeholder="Enter value"
        position="center"
        size={89.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="4d104"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="plan_qty_6m"
        label="Plan qty 6 m"
        placeholder="Enter value"
        position="center"
        size={89.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="a3e6a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="plan_qty_12m"
        label="Plan qty 12 m"
        placeholder="Enter value"
        position="center"
        size={97.1875}
        summaryAggregationMode="none"
      />
      <Column
        id="c407f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="plan_qty_18m"
        label="Plan qty 18 m"
        placeholder="Enter value"
        position="center"
        size={97.1875}
        summaryAggregationMode="none"
      />
      <Column
        id="3009c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="plan_qty_2y"
        label="Plan qty 2 y"
        placeholder="Enter value"
        position="center"
        size={85.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="5d7f2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="plan_qty_3y"
        label="Plan qty 3 y"
        placeholder="Enter value"
        position="center"
        size={85.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="6ed58"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="plan_qty_4y"
        label="Plan qty 4 y"
        placeholder="Enter value"
        position="center"
        size={85.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="c2375"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="in_qty_3m"
        label="In qty 3 m"
        placeholder="Enter value"
        position="center"
        size={74.6875}
        summaryAggregationMode="none"
      />
      <Column
        id="fab5d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="in_qty_6m"
        label="In qty 6 m"
        placeholder="Enter value"
        position="center"
        size={74.6875}
        summaryAggregationMode="none"
      />
      <Column
        id="5eaaa"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="in_qty_12m"
        label="In qty 12 m"
        placeholder="Enter value"
        position="center"
        size={82.578125}
        summaryAggregationMode="none"
      />
      <Column
        id="688c7"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="in_qty_18m"
        label="In qty 18 m"
        placeholder="Enter value"
        position="center"
        size={82.578125}
        summaryAggregationMode="none"
      />
      <Column
        id="6996b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="in_qty_2y"
        label="In qty 2 y"
        placeholder="Enter value"
        position="center"
        size={70.6875}
        summaryAggregationMode="none"
      />
      <Column
        id="4b29b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="in_qty_3y"
        label="In qty 3 y"
        placeholder="Enter value"
        position="center"
        size={70.6875}
        summaryAggregationMode="none"
      />
      <Column
        id="4dd69"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="in_qty_4y"
        label="In qty 4 y"
        placeholder="Enter value"
        position="center"
        size={70.6875}
        summaryAggregationMode="none"
      />
      <Column
        id="4728c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="in_rate_3m"
        label="In rate 3 m"
        placeholder="Enter value"
        position="center"
        size={79}
        summaryAggregationMode="none"
      />
      <Column
        id="737ac"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="in_rate_6m"
        label="In rate 6 m"
        placeholder="Enter value"
        position="center"
        size={79}
        summaryAggregationMode="none"
      />
      <Column
        id="eaaf1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="in_rate_12m"
        label="In rate 12 m"
        placeholder="Enter value"
        position="center"
        size={86.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="f75a0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="in_rate_18m"
        label="In rate 18 m"
        placeholder="Enter value"
        position="center"
        size={86.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="fa835"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="in_rate_2y"
        label="In rate 2 y"
        placeholder="Enter value"
        position="center"
        size={75.015625}
        summaryAggregationMode="none"
      />
      <Column
        id="adc19"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="in_rate_3y"
        label="In rate 3 y"
        placeholder="Enter value"
        position="center"
        size={75.015625}
        summaryAggregationMode="none"
      />
      <Column
        id="7dca2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="in_rate_4y"
        label="In rate 4 y"
        placeholder="Enter value"
        position="center"
        size={75.015625}
        summaryAggregationMode="none"
      />
      <Column
        id="d2979"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sale_qty_3m"
        label="Sale qty 3 m"
        placeholder="Enter value"
        position="center"
        size={88.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="41fed"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_6m"
        label="Sale qty 6 m"
        placeholder="Enter value"
        position="center"
        size={88.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="d7939"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_12m"
        label="Sale qty 12 m"
        placeholder="Enter value"
        position="center"
        size={96.875}
        summaryAggregationMode="none"
      />
      <Column
        id="84e5f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_18m"
        label="Sale qty 18 m"
        placeholder="Enter value"
        position="center"
        size={96.875}
        summaryAggregationMode="none"
      />
      <Column
        id="052d1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_2y"
        label="Sale qty 2 y"
        placeholder="Enter value"
        position="center"
        size={85}
        summaryAggregationMode="none"
      />
      <Column
        id="7996e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_3y"
        label="Sale qty 3 y"
        placeholder="Enter value"
        position="center"
        size={85}
        summaryAggregationMode="none"
      />
      <Column
        id="9944e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sale_qty_4y"
        label="Sale qty 4 y"
        placeholder="Enter value"
        position="center"
        size={85}
        summaryAggregationMode="none"
      />
      <Column
        id="98de7"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="tot_size_sale_rate"
        label="Tot size sale rate"
        placeholder="Enter value"
        position="center"
        size={115.5}
        summaryAggregationMode="none"
      />
      <Column
        id="433b9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="size_sale_rate_3m"
        label="Size sale rate 3 m"
        placeholder="Enter value"
        position="center"
        size={120.09375}
        summaryAggregationMode="none"
      />
      <Column
        id="02b4c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="size_sale_rate_6m"
        label="Size sale rate 6 m"
        placeholder="Enter value"
        position="center"
        size={120.09375}
        summaryAggregationMode="none"
      />
      <Column
        id="7d1d9"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="size_sale_rate_12m"
        label="Size sale rate 12 m"
        placeholder="Enter value"
        position="center"
        size={127.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="5e73a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="size_sale_rate_18m"
        label="Size sale rate 18 m"
        placeholder="Enter value"
        position="center"
        size={127.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="59765"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="size_sale_rate_2y"
        label="Size sale rate 2 y"
        placeholder="Enter value"
        position="center"
        size={116.09375}
        summaryAggregationMode="none"
      />
      <Column
        id="173b6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="size_sale_rate_3y"
        label="Size sale rate 3 y"
        placeholder="Enter value"
        position="center"
        size={116.09375}
        summaryAggregationMode="none"
      />
      <Column
        id="00e14"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="size_sale_rate_4y"
        label="Size sale rate 4 y"
        placeholder="Enter value"
        position="center"
        size={116.09375}
        summaryAggregationMode="none"
      />
      <Column
        id="96d32"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="size_sale_rate_color_3m"
        label="Size sale rate color 3 m"
        placeholder="Enter value"
        position="center"
        size={153.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="22c6d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="size_sale_rate_color_6m"
        label="Size sale rate color 6 m"
        placeholder="Enter value"
        position="center"
        size={153.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="d660a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="size_sale_rate_color_12m"
        label="Size sale rate color 12 m"
        placeholder="Enter value"
        position="center"
        size={161.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="23840"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="size_sale_rate_color_18m"
        label="Size sale rate color 18 m"
        placeholder="Enter value"
        position="center"
        size={161.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="aa574"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="size_sale_rate_color_2y"
        label="Size sale rate color 2 y"
        placeholder="Enter value"
        position="center"
        size={149.234375}
        summaryAggregationMode="none"
      />
      <Column
        id="15b8b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="size_sale_rate_color_3y"
        label="Size sale rate color 3 y"
        placeholder="Enter value"
        position="center"
        size={149.234375}
        summaryAggregationMode="none"
      />
      <Column
        id="b8fab"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="size_sale_rate_color_4y"
        label="Size sale rate color 4 y"
        placeholder="Enter value"
        position="center"
        size={149.234375}
        summaryAggregationMode="none"
      />
      <Column
        id="8988a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="each_sum_size_sale_rate"
        label="Each sum size sale rate"
        placeholder="Enter value"
        position="center"
        size={153.484375}
        summaryAggregationMode="none"
      />
      <Column
        id="68135"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="color_sale_rate"
        label="Color sale rate"
        placeholder="Enter value"
        position="center"
        size={100}
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
          pluginId="table2"
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
          pluginId="table2"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Frame>
</App>
