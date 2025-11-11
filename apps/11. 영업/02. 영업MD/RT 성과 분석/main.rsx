<App>
  <Include src="./functions.rsx" />
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
    <Container
      id="container4"
      _align="center"
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
    >
      <View id="f808d" viewKey="View 1">
        <Text id="text12" value="#### RT 성과 분석" verticalAlign="center" />
        <Select
          id="bizSelect"
          emptyMessage="No options"
          itemMode="static"
          label="사업부"
          labelPosition="top"
          overlayMaxHeight={375}
          placeholder="Select an option"
          showSelectionIndicator={true}
          value={'"01"'}
        >
          <Option id="f1812" label="아가방사업부" value={'"01"'} />
          <Option id="7a0d7" label="에뜨와사업부" value={'"07"'} />
          <Option
            id="67357"
            disabled={false}
            hidden={false}
            label="디즈니사업부"
            value={'"79"'}
          />
        </Select>
      </View>
    </Container>
    <Text
      id="text1"
      value="**RT 이후 30일 이내 판매율(왼쪽) 및 상품갯수(오른쪽)**"
      verticalAlign="center"
    />
    <Text
      id="text2"
      value="**RT 이후 30일 이내 판매 매출**"
      verticalAlign="center"
    />
    <Chart
      id="mixedChart1"
      barGap={0.4}
      barMode="group"
      chartType="mixed"
      legendPosition="none"
      selectedPoints="[]"
      showSecondYAxis={true}
      stackedBarTotalsDataLabelPosition="none"
      title={null}
      xAxisLineWidth={1}
      xAxisRangeMax=""
      xAxisRangeMin=""
      xAxisShowTickLabels={true}
      xAxisTickFormatMode="gui"
      yAxis2LineWidth={1}
      yAxis2RangeMax=""
      yAxis2RangeMin=""
      yAxis2ShowTickLabels={true}
      yAxis2TickFormat=".0f"
      yAxis2TickFormatMode="gui"
      yAxis2Title="RT 상품갯수"
      yAxis2ZeroLine={true}
      yAxisGrid={true}
      yAxisLineWidth={1}
      yAxisRangeMax="1.2"
      yAxisRangeMin="0"
      yAxisRangeMode="manual"
      yAxisShowTickLabels={true}
      yAxisTickFormatMode="gui"
      yAxisTitle="RT 이후 30일이내 판매율"
    >
      <Series
        id="1"
        aggregationType="sum"
        colorArray={{ array: ["{{ theme.danger }}"] }}
        colorArrayDropDown={{ array: ["{{ theme.danger }}"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ rtResultQuery.data }}"
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
        groupBy={{ array: [] }}
        groupByDropdownType="source"
        groupByStyles={{}}
        hoverTemplate="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
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
        markerColor="{{ theme.danger }}"
        markerSize={4}
        markerSymbol="circle"
        name="RT Sales Ratio"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="scatter"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ rtResultQuery.data.rt_start_dt }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ rtResultQuery.data.sales_ratio }}"
        yDataMode="manual"
        zData={null}
        zDataMode="manual"
      />
      <Series
        id="2"
        aggregationType="none"
        colorArray={{ array: ["#rgba(126, 132, 250, 0.3)"] }}
        colorArrayDropDown={{ array: ["#rgba(126, 132, 250, 0.3)"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ rtResultQuery.data }}"
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
        groupBy={{ array: [] }}
        groupByDropdownType="source"
        groupByStyles={{}}
        hoverTemplate="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
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
        markerColor="rgba(126, 132, 250, 0.8)"
        markerSize={6}
        markerSymbol="circle"
        name="The Number of sty"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ rtResultQuery.data.rt_start_dt }}"
        xDataMode="source"
        yAxis="y2"
        yData="{{ rtResultQuery.data.rt_sty_cnt }}"
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
      <Series
        id="3"
        aggregationType="none"
        colorArray={{ array: ["#rgba(126, 132, 250, 0.3)"] }}
        colorArrayDropDown={{ array: ["#rgba(126, 132, 250, 0.3)"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ rtResultQuery.data }}"
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
        groupBy={{ array: [] }}
        groupByDropdownType="source"
        groupByStyles={{}}
        hoverTemplate="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
        hoverTemplateMode="source"
        increasingBorderColor="{{ theme.success }}"
        increasingColor="{{ theme.success }}"
        lineColor="rgba(220, 38, 38, 0.9)"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor={null}
        markerBorderWidth={0}
        markerColor="rgba(126, 132, 250, 0.8)"
        markerSize={6}
        markerSymbol="circle"
        name="Moving Average of Sales Ratio"
        showMarkers={false}
        textTemplateMode="source"
        type="line"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ rtResultQuery.data.rt_start_dt }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ rtResultQuery.data.ma_sales_ratio }}"
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
    </Chart>
    <Chart
      id="barChart1"
      barGap={0.4}
      legendPosition="none"
      margin="0"
      selectedPoints="[]"
      stackedBarTotalsDataLabelPosition="none"
      title={null}
      xAxisRangeMax=""
      xAxisRangeMin=""
      xAxisShowTickLabels={true}
      xAxisTickFormatMode="gui"
      xAxisZeroLine={true}
      yAxis2LineWidth={1}
      yAxis2RangeMax=""
      yAxis2RangeMin=""
      yAxis2ShowTickLabels={true}
      yAxis2TickFormatMode="gui"
      yAxisRangeMax=""
      yAxisRangeMin=""
      yAxisShowTickLabels={true}
      yAxisTickFormat=",.0f"
      yAxisTickFormatMode="gui"
      yAxisZeroLine={true}
    >
      <Series
        id="0"
        aggregationType="sum"
        colorArray={{ array: ["{{ theme.primary }}"] }}
        colorArrayDropDown={{ array: ["{{ theme.primary }}"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ rtResultQuery.data }}"
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
        groupBy={{ array: [] }}
        groupByDropdownType="source"
        groupByStyles={{}}
        hoverTemplate="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
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
        name="Primary"
        showMarkers={false}
        textTemplate="%{y}"
        textTemplateMode="source"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ rtResultQuery.data.rt_start_dt }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ rtResultQuery.data.rt_rev }}"
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
    </Chart>
    <Text id="text5" value="**RT 이동수량**" verticalAlign="center" />
    <Text
      id="text3"
      value="**RT 유형별 이후 30일 이내 판매율 이동평균추이(MA7)**"
      verticalAlign="center"
    />
    <Chart
      id="barChart2"
      barGap={0.4}
      legendPosition="none"
      margin="0"
      selectedPoints="[]"
      stackedBarTotalsDataLabelPosition="none"
      title={null}
      xAxisRangeMax=""
      xAxisRangeMin=""
      xAxisShowTickLabels={true}
      xAxisTickFormatMode="gui"
      xAxisZeroLine={true}
      yAxis2LineWidth={1}
      yAxis2RangeMax=""
      yAxis2RangeMin=""
      yAxis2ShowTickLabels={true}
      yAxis2TickFormatMode="gui"
      yAxisRangeMax=""
      yAxisRangeMin="0"
      yAxisShowTickLabels={true}
      yAxisTickFormat=",.0f"
      yAxisTickFormatMode="gui"
      yAxisZeroLine={true}
    >
      <Series
        id="0"
        aggregationType="sum"
        colorArray={{ array: ["{{ theme.primary }}"] }}
        colorArrayDropDown={{ array: ["{{ theme.primary }}"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ rtResultQuery.data }}"
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
        groupBy={{ array: [] }}
        groupByDropdownType="source"
        groupByStyles={{}}
        hoverTemplate="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
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
        markerColor="{{ theme.info }}"
        markerSize={6}
        markerSymbol="circle"
        name="Primary"
        showMarkers={false}
        textTemplate="%{y}"
        textTemplateMode="source"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ rtResultQuery.data.rt_start_dt }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ rtResultQuery.data.rt_ord_qty }}"
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
    </Chart>
    <Chart
      id="lineChart1"
      barMode="group"
      barOrientation=""
      chartType="line"
      selectedPoints="[]"
      stackedBarTotalsDataLabelPosition="none"
      title={null}
      xAxisLineWidth={1}
      xAxisRangeMax=""
      xAxisRangeMin=""
      xAxisShowLine={true}
      xAxisShowTickLabels={true}
      xAxisTickFormatMode="gui"
      xAxisTitleStandoff={20}
      yAxis2LineWidth={1}
      yAxis2RangeMax=""
      yAxis2RangeMin=""
      yAxis2ShowTickLabels={true}
      yAxis2TickFormatMode="gui"
      yAxis2TitleStandoff={20}
      yAxisGrid={true}
      yAxisLineWidth={1}
      yAxisRangeMax="1.5"
      yAxisRangeMin="0
"
      yAxisRangeMode="manual"
      yAxisShowLine={true}
      yAxisShowTickLabels={true}
      yAxisTickFormat=".2f"
      yAxisTickFormatMode="gui"
      yAxisTitle="RT 이후 30일이내 판매율"
      yAxisTitleStandoff={20}
    >
      <Series
        id="0"
        aggregationType="none"
        colorArray={{ array: [] }}
        colorArrayDropDown={{ array: [] }}
        colorInputMode="gradientColorArray"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ rtResultByTypeQuery.data }}"
        datasourceMode="manual"
        decreasingBorderColor="#000000"
        decreasingColor="#000000"
        filteredGroups={null}
        filteredGroupsMode="source"
        gradientColorArray={{ array: [] }}
        groupBy="['reg_tp']"
        groupByDropdownType="manual"
        groupByStyles={{
          E: {
            ordered: [
              { lineColor: "rgba(233, 88, 255, 1)" },
              { markerSymbol: "square" },
              { markerBorderColor: "rgba(219, 0, 253, 1)" },
              { markerColor: "rgba(221, 0, 255, 1)" },
            ],
          },
          A: {
            ordered: [
              { lineColor: "rgba(255, 204, 0, 1)" },
              { markerBorderColor: "rgba(255, 204, 0, 1)" },
              { markerColor: "rgba(255, 204, 0, 1)" },
            ],
          },
          R: {
            ordered: [
              { lineColor: "rgba(5, 253, 137, 1)" },
              { markerBorderColor: "rgba(0, 255, 136, 1)" },
              { markerColor: "rgba(0, 255, 136, 1)" },
            ],
          },
        }}
        hidden={false}
        hiddenMode="manual"
        hoverTemplate={null}
        hoverTemplateArray={{ array: [] }}
        hoverTemplateMode="source"
        increasingBorderColor="#000000"
        increasingColor="#000000"
        lineColor="#000000"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor="#ffffff"
        markerBorderWidth={1}
        markerColor="#000000"
        markerSize={6}
        markerSymbol="circle"
        name="RT 유형별 판매율"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="scatter"
        waterfallBase={0}
        waterfallMeasures={{ array: [] }}
        waterfallMeasuresMode="source"
        xData="{{ rtResultByTypeQuery.data.rt_start_dt }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ rtResultByTypeQuery.data.sales_ratio }}"
        yDataMode="source"
        zData="[1, 2, 3, 4, 5]"
        zDataMode="manual"
      />
      <Event
        event="select"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="rtResultByTypeQuery"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Chart>
    <Text
      id="text4"
      value="**RT의 플렉스 여부에 따른 판매율 이동평균추이(MA7)**"
      verticalAlign="center"
    />
    <Chart
      id="lineChart2"
      barMode="group"
      barOrientation=""
      chartType="line"
      selectedPoints="[]"
      stackedBarTotalsDataLabelPosition="none"
      title={null}
      xAxisLineWidth={1}
      xAxisRangeMax=""
      xAxisRangeMin=""
      xAxisShowLine={true}
      xAxisShowTickLabels={true}
      xAxisTickFormatMode="gui"
      xAxisTitleStandoff={20}
      yAxis2LineWidth={1}
      yAxis2RangeMax=""
      yAxis2RangeMin=""
      yAxis2ShowTickLabels={true}
      yAxis2TickFormatMode="gui"
      yAxis2TitleStandoff={20}
      yAxisGrid={true}
      yAxisLineWidth={1}
      yAxisRangeMax="1.5"
      yAxisRangeMin="0
"
      yAxisRangeMode="manual"
      yAxisShowLine={true}
      yAxisShowTickLabels={true}
      yAxisTickFormat=".2f"
      yAxisTickFormatMode="gui"
      yAxisTitle="RT 이후 30일이내 판매율"
      yAxisTitleStandoff={20}
    >
      <Series
        id="0"
        aggregationType="none"
        colorArray={{ array: [] }}
        colorArrayDropDown={{ array: [] }}
        colorInputMode="gradientColorArray"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ rtResultByFlexQuery.data }}"
        datasourceMode="manual"
        decreasingBorderColor="#000000"
        decreasingColor="#000000"
        filteredGroups={null}
        filteredGroupsMode="source"
        gradientColorArray={{ array: [] }}
        groupBy="['is_flex']"
        groupByDropdownType="manual"
        groupByStyles={{
          E: { ordered: [{ lineColor: "rgba(233, 88, 255, 1)" }] },
          A: { ordered: [{ lineColor: "rgba(255, 204, 0, 1)" }] },
          R: { ordered: [{ lineColor: "rgba(5, 253, 137, 1)" }] },
        }}
        hidden={false}
        hiddenMode="manual"
        hoverTemplate={null}
        hoverTemplateArray={{ array: [] }}
        hoverTemplateMode="source"
        increasingBorderColor="#000000"
        increasingColor="#000000"
        lineColor="#000000"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor="#ffffff"
        markerBorderWidth={1}
        markerColor="#000000"
        markerSize={6}
        markerSymbol="circle"
        name="RT 유형별 판매율"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="line"
        waterfallBase={0}
        waterfallMeasures={{ array: [] }}
        waterfallMeasuresMode="source"
        xData="{{ rtResultByFlexQuery.data.rt_start_dt }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ rtResultByFlexQuery.data.ma_sales_ratio }}"
        yDataMode="source"
        zData="[1, 2, 3, 4, 5]"
        zDataMode="manual"
      />
      <Event
        event="select"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="rtResultByTypeQuery"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Chart>
    <Include src="./src/container1.rsx" />
    <Include src="./src/container2.rsx" />
    <Include src="./src/container3.rsx" />
  </Frame>
</App>
