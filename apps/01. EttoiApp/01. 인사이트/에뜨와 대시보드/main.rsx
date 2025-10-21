<App>
  <Include src="./functions.rsx" />
  <DocumentTitle id="$customDocumentTitle" value="에뜨와 대시보드" />
  <Include src="./header.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <DateRange
      id="dateRange_day"
      dateFormat="yyyy-MM-dd"
      endPlaceholder="종료일"
      iconBefore="bold/interface-calendar-remove"
      label=""
      labelPosition="top"
      startPlaceholder="시작일"
      textBefore="날짜"
      textBetween="-"
      value={{
        ordered: [
          { start: "{{ moment().subtract(1, 'months').format(\"Y-M-D\") }}" },
          { end: '{{ moment().format("Y-M-D") }}' },
        ],
      }}
    />
    <Select
      id="select_season"
      captionByIndex="{{ item.year_sesn_cd }}"
      data="{{ get_season_list.data }}"
      emptyMessage="No options"
      fallbackTextByIndex=""
      iconBefore="bold/nature-ecology-clover"
      iconByIndex=""
      label=""
      labelPosition="top"
      labels="{{ item.year_sesn_nm_kor }}"
      overlayMaxHeight={375}
      placeholder="전체"
      showClear={true}
      showSelectionIndicator={true}
      textBefore="시즌"
      value="''"
      values="{{ item.year_sesn_cd }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_top_sty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Select
      id="select_style"
      captionByIndex="{{ item.sty_cd }}"
      data="{{ get_sty_list.data }}"
      emptyMessage="No options"
      fallbackTextByIndex=""
      iconBefore="bold/catergories-shirt"
      iconByIndex=""
      label=""
      labelPosition="top"
      labels="{{ item.sty_nm }}"
      overlayMaxHeight={375}
      placeholder="전체"
      showClear={true}
      showSelectionIndicator={true}
      textBefore="스타일"
      value="''"
      values="{{ item.sty_cd }}"
    />
    <Select
      id="select_shop"
      data="{{ get_shop_list.data }}"
      emptyMessage="No options"
      fallbackTextByIndex=""
      iconBefore="bold/health-medical-house-alternate"
      iconByIndex=""
      label=""
      labelPosition="top"
      overlayMaxHeight={375}
      placeholder="전체"
      showClear={true}
      showSelectionIndicator={true}
      textBefore="매장"
      value=""
      values="{{ item.shop_nm }}"
    />
    <Container
      id="container1"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="0"
      showBody={true}
      showHeader={true}
      showHeaderBorder={false}
    >
      <Header>
        <Text
          id="containerTitle1"
          value="###### 🎁 상품 판매량 Top"
          verticalAlign="center"
        />
      </Header>
      <View id="39c45" viewKey="View 1">
        <Table
          id="table1"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ get_top_sty.data }}"
          defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          primaryKeyColumnId="3df4d"
          rowHeight="medium"
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Column
            id="3df4d"
            alignment="center"
            editable={false}
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="rank"
            label="랭킹"
            placeholder="Enter value"
            position="center"
            size={46}
            summaryAggregationMode="none"
          />
          <Column
            id="0242e"
            alignment="left"
            format="image"
            formatOptions={{ widthType: "fit" }}
            groupAggregationMode="none"
            key="sty_cd"
            label="사진"
            placeholder="Enter value"
            position="center"
            referenceId="사진"
            size={40}
            summaryAggregationMode="none"
            valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{ item }}.jpg"
          />
          <Column
            id="fff34"
            alignment="left"
            caption="{{ currentSourceRow.sty_cd }}"
            format="string"
            groupAggregationMode="none"
            key="sty_nm"
            label="스타일"
            placeholder="Enter value"
            position="center"
            size={150}
            summaryAggregationMode="none"
          />
          <Column
            id="dc0b0"
            alignment="left"
            format="string"
            groupAggregationMode="none"
            hidden="true"
            key="sty_cd"
            label="Sty cd"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="dfd7d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sales_qty"
            label="판매수량"
            placeholder="Enter value"
            position="center"
            size={62}
            summaryAggregationMode="none"
          />
          <Column
            id="9e87e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sales_price"
            label="판매액"
            placeholder="Enter value"
            position="center"
            size={89}
            summaryAggregationMode="none"
          />
          <Column
            id="6db11"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_in_qty"
            label="누적입고"
            placeholder="Enter value"
            position="center"
            size={65}
            summaryAggregationMode="none"
          />
          <Column
            id="00572"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_sale_qty"
            label="누적출고"
            placeholder="Enter value"
            position="center"
            size={66}
            summaryAggregationMode="none"
          />
          <Column
            id="56c22"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_per"
            label="소진율"
            placeholder="Enter value"
            position="center"
            size={65}
            summaryAggregationMode="none"
          />
          <Event
            event="selectRow"
            method="setValue"
            params={{ ordered: [{ value: "{{ currentRow.sty_cd }}" }] }}
            pluginId="select_style"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="doubleClickRow"
            method="clearValue"
            params={{ ordered: [] }}
            pluginId="select_style"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Table>
      </View>
    </Container>
    <Switch id="switch_exclude_stroller" label="유모차 제외" value="true" />
    <Container
      id="container4"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="0"
      showBody={true}
      showHeader={true}
      showHeaderBorder={false}
    >
      <Header>
        <Text
          id="containerTitle3"
          value="###### 📊 일별 판매량"
          verticalAlign="center"
        />
      </Header>
      <View id="39c45" viewKey="View 1">
        <Chart
          id="stackedBarChart_sales_qty"
          barGap={0.4}
          legendPosition="bottom"
          selectedPoints="[]"
          stackedBarTotalsDataLabelPosition="none"
          title={null}
          xAxisRangeMax=""
          xAxisRangeMin=""
          xAxisShowTickLabels={true}
          yAxis2LineWidth={1}
          yAxis2RangeMax=""
          yAxis2RangeMin=""
          yAxis2ShowTickLabels={true}
          yAxis2TickFormatMode="gui"
          yAxisRangeMax=""
          yAxisRangeMin=""
          yAxisShowTickLabels={true}
          yAxisTickFormatMode="gui"
        >
          <Series
            id="0"
            aggregationType="none"
            colorArray={{ array: ["{{ theme.primary }}"] }}
            colorArrayDropDown={{ array: ["{{ theme.primary }}"] }}
            colorInputMode="colorArrayDropDown"
            connectorLineColor="#000000"
            dataLabelPosition="none"
            datasource="{{ get_day_sales_trend.data }}"
            datasourceMode="source"
            decreasingBorderColor="{{ theme.danger }}"
            decreasingColor="{{ theme.danger }}"
            filteredGroups={null}
            filteredGroupsMode="source"
            gradientColorArray={{
              array: [
                { array: ["0.0", "{{ theme.success }}"] },
                { array: ["1.0", "{{ theme.primary }}"] },
              ],
            }}
            groupBy={{ array: ["sale_gb"] }}
            groupByDropdownType="source"
            groupByStyles={{}}
            hoverTemplate="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
            hoverTemplateArray="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
            hoverTemplateMode="source"
            increasingBorderColor="{{ theme.success }}"
            increasingColor="{{ theme.success }}"
            lineColor="{{ theme.primary }}"
            lineDash="solid"
            lineShape="linear"
            lineUnderFillMode="none"
            lineWidth={2}
            markerBorderColor={null}
            markerBorderWidth={0}
            markerColor="{{ theme.primary }}"
            markerSize={6}
            markerSymbol="circle"
            name="sales"
            showMarkers={false}
            textTemplate={null}
            textTemplateMode="manual"
            type="bar"
            waterfallBase={0}
            waterfallMeasures={null}
            waterfallMeasuresMode="source"
            xData="{{ get_day_sales_trend.data.sale_dt }}"
            xDataMode="manual"
            yAxis="y"
            yData="{{ get_day_sales_trend.data.sales_qty }}"
            yDataMode="manual"
            zData={null}
            zDataMode="manual"
          />
        </Chart>
      </View>
    </Container>
    <Container
      id="container3"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="0"
      showBody={true}
      showHeader={true}
      showHeaderBorder={false}
    >
      <Header>
        <Text
          id="containerTitle2"
          value="###### 🏆 매장 판매량 Top"
          verticalAlign="center"
        />
      </Header>
      <View id="39c45" viewKey="View 1">
        <Table
          id="table2"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ get_top_shop.data }}"
          defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          primaryKeyColumnId="3df4d"
          rowHeight="medium"
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Column
            id="3df4d"
            alignment="center"
            editable={false}
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="rank"
            label="랭킹"
            placeholder="Enter value"
            position="center"
            size={36.765625}
            summaryAggregationMode="none"
          />
          <Column
            id="616b0"
            alignment="left"
            format="string"
            groupAggregationMode="none"
            key="shop_nm"
            label="매장"
            placeholder="Enter value"
            position="center"
            size={188}
            summaryAggregationMode="none"
          />
          <Column
            id="dfd7d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sales_qty"
            label="판매수량"
            placeholder="Enter value"
            position="center"
            size={57.53125}
            summaryAggregationMode="none"
          />
          <Column
            id="9e87e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sales_price"
            label="판매액"
            placeholder="Enter value"
            position="center"
            size={92.578125}
            summaryAggregationMode="none"
          />
          <Event
            event="selectRow"
            method="setValue"
            params={{ ordered: [{ value: "{{ currentRow.shop_nm }}" }] }}
            pluginId="select_shop"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="doubleClickRow"
            method="clearValue"
            params={{ ordered: [] }}
            pluginId="select_shop"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Table>
      </View>
    </Container>
    <Container
      id="container5"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="0"
      showBody={true}
      showHeader={true}
      showHeaderBorder={false}
    >
      <Header>
        <Text
          id="containerTitle4"
          value="###### 💰 일별 판매금액"
          verticalAlign="center"
        />
      </Header>
      <View id="39c45" viewKey="View 1">
        <Chart
          id="stackedBarChart_sales_qty2"
          barGap={0.4}
          legendPosition="bottom"
          selectedPoints="[]"
          stackedBarTotalsDataLabelPosition="none"
          title={null}
          xAxisRangeMax=""
          xAxisRangeMin=""
          xAxisShowTickLabels={true}
          yAxis2LineWidth={1}
          yAxis2RangeMax=""
          yAxis2RangeMin=""
          yAxis2ShowTickLabels={true}
          yAxis2TickFormatMode="gui"
          yAxisRangeMax=""
          yAxisRangeMin=""
          yAxisShowTickLabels={true}
          yAxisTickFormatMode="gui"
        >
          <Series
            id="0"
            aggregationType="none"
            colorArray={{ array: ["{{ theme.primary }}"] }}
            colorArrayDropDown={{ array: ["{{ theme.primary }}"] }}
            colorInputMode="colorArrayDropDown"
            connectorLineColor="#000000"
            dataLabelPosition="none"
            datasource="{{ get_day_sales_trend.data }}"
            datasourceMode="source"
            decreasingBorderColor="{{ theme.danger }}"
            decreasingColor="{{ theme.danger }}"
            filteredGroups={null}
            filteredGroupsMode="source"
            gradientColorArray={{
              array: [
                { array: ["0.0", "{{ theme.success }}"] },
                { array: ["1.0", "{{ theme.primary }}"] },
              ],
            }}
            groupBy={{ array: ["sale_gb"] }}
            groupByDropdownType="source"
            groupByStyles={{}}
            hoverTemplate="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
            hoverTemplateArray="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
            hoverTemplateMode="source"
            increasingBorderColor="{{ theme.success }}"
            increasingColor="{{ theme.success }}"
            lineColor="{{ theme.primary }}"
            lineDash="solid"
            lineShape="linear"
            lineUnderFillMode="none"
            lineWidth={2}
            markerBorderColor={null}
            markerBorderWidth={0}
            markerColor="{{ theme.primary }}"
            markerSize={6}
            markerSymbol="circle"
            name="sales"
            showMarkers={false}
            textTemplate={null}
            textTemplateMode="manual"
            type="bar"
            waterfallBase={0}
            waterfallMeasures={null}
            waterfallMeasuresMode="source"
            xData="{{ get_day_sales_trend.data.sale_dt }}"
            xDataMode="manual"
            yAxis="y"
            yData="{{ get_day_sales_trend.data.sales_price }}"
            yDataMode="manual"
            zData={null}
            zDataMode="manual"
          />
        </Chart>
      </View>
    </Container>
  </Frame>
</App>
