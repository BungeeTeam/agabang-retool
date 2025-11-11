<Container
  id="tabbedContainer1"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
  showBorder={false}
  showHeader={true}
>
  <Header>
    <Tabs
      id="shop_modal_tab"
      itemMode="static"
      navigateContainer={true}
      targetContainerId="tabbedContainer1"
      value="{{ self.values[0] }}"
    >
      <Option id="7a451" value="Tab 1" />
      <Option id="79105" value="Tab 2" />
      <Option id="1a5d5" value="Tab 3" />
    </Tabs>
  </Header>
  <View
    id="f1d15"
    icon="bold/shopping-store-1"
    iconPosition="left"
    label="매장 판매량"
    viewKey="sales"
  >
    <Chart
      id="plotlyJsonChart2"
      chartType="plotlyJson"
      plotlyDataJson="{{ get_shop_sales_graph_data.data }}"
      plotlyLayoutJson={
        '{\n  "margin": {\n    "l": 50,\n    "r": 50,\n    "t": 50,\n    "b": 50\n  },\n  "paper_bgcolor": "rgb(0,0,0,0)",\n  "plot_bgcolor": "rgb(0,0,0,0)",\n  "autosize": false,\n  "xaxis": {\n    "title": "날짜",\n    "tickformat": "%m-%d",\n    "showgrid": true,\n    "gridcolor": "rgba(200, 200, 200, 0.3)",\n    "gridwidth": 0.5,\n    "zeroline": true,\n    "zerolinecolor": "rgba(200, 200, 200, 0.5)",\n    "zerolinewidth": 0.5,\n    "showline": true,\n    "ticks": "outside",\n    "tickcolor": "black"\n  },\n  "yaxis": {\n    "title": "판매량",\n    "showgrid": true,\n    "gridcolor": "rgba(200, 200, 200, 0.3)",\n    "gridwidth": 0.5,\n    "zeroline": true,\n    "zerolinecolor": "rgba(200, 200, 200, 0.5)",\n    "zerolinewidth": 0.5,\n    "showline": true,\n    "ticks": "outside",\n    "tickcolor": "black"\n  },\n  "legend": {\n    "bgcolor": "white",\n    "itemclick": "toggleothers"\n  }\n}'
      }
      selectedPoints="[]"
    />
  </View>
  <View
    id="f729f"
    icon="bold/shopping-store-1"
    iconPosition="left"
    label="매장 판매율(%)"
    viewKey="sales_per"
  >
    <Chart
      id="plotlyJsonChart1"
      chartType="plotlyJson"
      plotlyDataJson="{{ get_shop_sales_per_graph_data.data }}"
      plotlyLayoutJson={
        '{\n  "margin": {\n    "l": 50,\n    "r": 50,\n    "t": 50,\n    "b": 50\n  },\n  "paper_bgcolor": "rgb(0,0,0,0)",\n  "plot_bgcolor": "rgb(0,0,0,0)",\n  "autosize": false,\n  "xaxis": {\n    "title": "날짜",\n    "tickformat": "%m-%d",\n    "showgrid": true,\n    "gridcolor": "rgba(200, 200, 200, 0.3)",\n    "gridwidth": 0.5,\n    "zeroline": true,\n    "zerolinecolor": "rgba(200, 200, 200, 0.5)",\n    "zerolinewidth": 0.5,\n    "showline": true,\n    "ticks": "outside",\n    "tickcolor": "black"\n  },\n  "yaxis": {\n    "title": "판매율(%)",\n    "showgrid": true,\n    "gridcolor": "rgba(200, 200, 200, 0.3)",\n    "gridwidth": 0.5,\n    "zeroline": true,\n    "zerolinecolor": "rgba(200, 200, 200, 0.5)",\n    "zerolinewidth": 0.5,\n    "showline": true,\n    "ticks": "outside",\n    "tickcolor": "black"\n  },\n  "legend": {\n    "bgcolor": "white",\n    "itemclick": "toggleothers"\n  }\n}'
      }
      selectedPoints="[]"
    />
  </View>
  <View
    id="de22d"
    disabled={false}
    hidden={false}
    icon="bold/shopping-store-1"
    iconPosition="left"
    label="매장 입고량"
    viewKey="in"
  >
    <Chart
      id="plotlyJsonChart3"
      chartType="plotlyJson"
      plotlyDataJson="{{ get_shop_in_graph_data.data }}"
      plotlyLayoutJson={
        '{\n  "margin": {\n    "l": 50,\n    "r": 50,\n    "t": 50,\n    "b": 50\n  },\n  "paper_bgcolor": "rgb(0,0,0,0)",\n  "plot_bgcolor": "rgb(0,0,0,0)",\n  "autosize": false,\n  "xaxis": {\n    "title": "날짜",\n    "tickformat": "%m-%d",\n    "showgrid": true,\n    "gridcolor": "rgba(200, 200, 200, 0.3)",\n    "gridwidth": 0.5,\n    "zeroline": true,\n    "zerolinecolor": "rgba(200, 200, 200, 0.5)",\n    "zerolinewidth": 0.5,\n    "showline": true,\n    "ticks": "outside",\n    "tickcolor": "black"\n  },\n  "yaxis": {\n    "title": "입고량",\n    "showgrid": true,\n    "gridcolor": "rgba(200, 200, 200, 0.3)",\n    "gridwidth": 0.5,\n    "zeroline": true,\n    "zerolinecolor": "rgba(200, 200, 200, 0.5)",\n    "zerolinewidth": 0.5,\n    "showline": true,\n    "ticks": "outside",\n    "tickcolor": "black"\n  },\n  "legend": {\n    "bgcolor": "white",\n    "itemclick": "toggleothers"\n  }\n}'
      }
      selectedPoints="[]"
    />
  </View>
  <View
    id="2f85f"
    disabled={false}
    hidden={false}
    icon="bold/computer-connection-network"
    iconPosition="left"
    label="온라인판매"
    viewKey="online"
  >
    <Chart
      id="lineChart1"
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
      xAxisTitle="날짜"
      yAxis2LineWidth={1}
      yAxis2RangeMax=""
      yAxis2RangeMin=""
      yAxis2ShowTickLabels={true}
      yAxis2TickFormatMode="gui"
      yAxisGrid={true}
      yAxisLineWidth={1}
      yAxisRangeMax=""
      yAxisRangeMin=""
      yAxisShowTickLabels={true}
      yAxisTickFormatMode="gui"
      yAxisTitle="판매수량"
    >
      <Series
        id="0"
        aggregationType="none"
        colorArray={{ array: [] }}
        colorArrayDropDown={{ array: [] }}
        colorInputMode="gradientColorArray"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ JSON.parse(get_online_sales.data[0].sale_trend) }}"
        datasourceMode="manual"
        decreasingBorderColor="#000000"
        decreasingColor="#000000"
        filteredGroups={null}
        filteredGroupsMode="source"
        gradientColorArray={{ array: [] }}
        groupBy={{ array: [] }}
        groupByDropdownType="manual"
        groupByStyles={{}}
        hoverTemplateArray={{ array: [] }}
        hoverTemplateMode="manual"
        increasingBorderColor="#000000"
        increasingColor="#000000"
        lineColor="{{ theme.info }}"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor="#ffffff"
        markerBorderWidth={1}
        markerColor="#000000"
        markerSize={6}
        markerSymbol="circle"
        name="{{ get_online_sales.data[0].sale_gb }}"
        showMarkers={false}
        textTemplateMode="manual"
        type="line"
        waterfallBase={0}
        waterfallMeasures={{ array: [] }}
        waterfallMeasuresMode="source"
        xData="{{ formatDataAsObject(JSON.parse(get_online_sales.data[0].sale_trend)).day }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ formatDataAsObject(JSON.parse(get_online_sales.data[0].sale_trend)).val }}"
        yDataMode="source"
        zData="[1, 2, 3, 4, 5]"
        zDataMode="manual"
      />
      <Series
        id="1"
        aggregationType="none"
        colorArray={{ array: [] }}
        colorArrayDropDown={{ array: [] }}
        colorInputMode="gradientColorArray"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ JSON.parse(get_online_sales.data[1].sale_trend) }}"
        datasourceMode="manual"
        decreasingBorderColor="#000000"
        decreasingColor="#000000"
        filteredGroups={null}
        filteredGroupsMode="source"
        gradientColorArray={{ array: [] }}
        groupBy={{ array: [] }}
        groupByDropdownType="manual"
        groupByStyles={{}}
        hoverTemplateArray={{ array: [] }}
        hoverTemplateMode="manual"
        increasingBorderColor="#000000"
        increasingColor="#000000"
        lineColor="{{ theme.warning }}"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor="#ffffff"
        markerBorderWidth={1}
        markerColor="#000000"
        markerSize={6}
        markerSymbol="circle"
        name="{{ get_online_sales.data[1].sale_gb }}"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="line"
        waterfallBase={0}
        waterfallMeasures={{ array: [] }}
        waterfallMeasuresMode="source"
        xData="{{ formatDataAsObject(JSON.parse(get_online_sales.data[1].sale_trend)).day }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ formatDataAsObject(JSON.parse(get_online_sales.data[1].sale_trend)).val }}"
        yDataMode="source"
        zData="[1, 2, 3, 4, 5]"
        zDataMode="manual"
      />
    </Chart>
    <Chart
      id="pieChart1"
      chartType="pie"
      colorArray={[
        "#11B5AE",
        "#4046CA",
        "#F68512",
        "#DE3C82",
        "#7E84FA",
        "#72E06A",
      ]}
      colorArrayDropDown={[
        "rgba(16, 32, 181, 1)",
        "rgba(201, 111, 64, 1)",
        "#F68512",
        "#DE3C82",
        "#7E84FA",
        "#72E06A",
      ]}
      colorInputMode="colorArrayDropDown"
      datasource=""
      gradientColorArray={[
        ["0.0", "{{ theme.canvas }}"],
        ["1.0", "{{ theme.primary }}"],
      ]}
      hoverTemplate="%{label}<br>%{value}<br>%{percent}<extra></extra>"
      hoverTemplateMode="source"
      labelData="{{ get_online_sales.data.map(item => item.sale_gb)}}"
      legendPosition="top"
      lineColor="{{ theme.surfacePrimary }}"
      lineWidth={2}
      margin="0"
      pieDataHole={0.4}
      selectedPoints="[]"
      textTemplate="%{percent}"
      textTemplateMode="source"
      title="판매 비중"
      valueData="{{ get_online_sales.data.map(item => JSON.parse(item.sale_trend).at(-1).val)}}"
    />
  </View>
</Container>
