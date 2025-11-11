<Container
  id="container1"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
>
  <Header>
    <Text
      id="containerTitle1"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="33419" viewKey="View 1">
    <Text
      id="text6"
      value="**아가방 RT 성과 분석(판매율)**"
      verticalAlign="center"
    />
    <Text
      id="text8"
      value="**아가방 RT 성과 분석(판매금액)**"
      verticalAlign="center"
    />
    <Chart
      id="lineChart3"
      barMode="group"
      barOrientation=""
      chartType="line"
      legendPosition="top"
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
      yAxisTitle="RT 이후 30일간 판매율"
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
        datasource="{{ agbPerformanceAnalysis.data }}"
        datasourceMode="manual"
        decreasingBorderColor="#000000"
        decreasingColor="#000000"
        filteredGroups={null}
        filteredGroupsMode="source"
        gradientColorArray={{ array: [] }}
        groupBy="['ord_id']"
        groupByDropdownType="manual"
        groupByStyles={{
          E: { ordered: [{ lineColor: "rgba(233, 88, 255, 1)" }] },
          A: { ordered: [{ lineColor: "rgba(255, 204, 0, 1)" }] },
          R: { ordered: [{ lineColor: "rgba(5, 253, 137, 1)" }] },
          Cleave: {
            ordered: [
              { markerColor: "rgba(255, 0, 0, 1)" },
              { markerBorderColor: "rgba(255, 0, 0, 1)" },
            ],
          },
          Auto: {
            ordered: [
              { markerColor: "rgba(255, 204, 0, 1)" },
              { markerBorderColor: "rgba(255, 255, 255, 1)" },
            ],
          },
          RequestByShop: {
            ordered: [
              { markerColor: "rgba(0, 255, 136, 1)" },
              { markerBorderColor: "rgba(255, 255, 255, 1)" },
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
        xData="{{ agbPerformanceAnalysis.data.rt_start_dt }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ agbPerformanceAnalysis.data.sales_ratio }}"
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
    <Chart
      id="lineChart6"
      barMode="group"
      barOrientation=""
      chartType="line"
      legendPosition="top"
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
      yAxisRangeMax=""
      yAxisRangeMin="0
"
      yAxisRangeMode="manual"
      yAxisShowLine={true}
      yAxisShowTickLabels={true}
      yAxisTickFormat=",.0f"
      yAxisTickFormatMode="gui"
      yAxisTitle="RT 이후 30일간 판매금액"
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
        datasource="{{ agbPerformanceAnalysis.data }}"
        datasourceMode="manual"
        decreasingBorderColor="#000000"
        decreasingColor="#000000"
        filteredGroups={null}
        filteredGroupsMode="source"
        gradientColorArray={{ array: [] }}
        groupBy="['ord_id']"
        groupByDropdownType="manual"
        groupByStyles={{
          E: { ordered: [{ lineColor: "rgba(233, 88, 255, 1)" }] },
          A: { ordered: [{ lineColor: "rgba(255, 204, 0, 1)" }] },
          R: { ordered: [{ lineColor: "rgba(5, 253, 137, 1)" }] },
          Cleave: {
            ordered: [
              { markerColor: "rgba(255, 0, 0, 1)" },
              { markerBorderColor: "rgba(255, 0, 0, 1)" },
            ],
          },
          Auto: {
            ordered: [
              { markerColor: "rgba(255, 204, 0, 1)" },
              { markerBorderColor: "#ffcc00" },
            ],
          },
          RequestByShop: {
            ordered: [
              { markerColor: "rgba(0, 255, 136, 1)" },
              { markerBorderColor: "#00ff88" },
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
        type="bar"
        waterfallBase={0}
        waterfallMeasures={{ array: [] }}
        waterfallMeasuresMode="source"
        xData="{{ agbPerformanceAnalysis.data.rt_start_dt }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ agbPerformanceAnalysis.data.rt_rev }}"
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
  </View>
</Container>
