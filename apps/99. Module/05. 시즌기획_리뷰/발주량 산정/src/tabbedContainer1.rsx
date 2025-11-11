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
      id="lineChart2"
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
  <View
    id="44148"
    disabled={false}
    hidden={false}
    icon="bold/interface-arrows-horizontal-expand"
    iconPosition="left"
    label="사이즈별 매장판매"
    viewKey="size"
  >
    <ListViewBeta
      id="listView1"
      data="{{ get_size_shop.data }}"
      heightType="auto"
      itemWidth="200px"
      margin="0"
      numColumns={3}
      padding="0"
    >
      <Container
        id="container10"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="12px"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Text
            id="containerTitle24"
            value="#### {{ item.size_nm }}"
            verticalAlign="center"
          />
        </Header>
        <View id="98e50" viewKey="View 1">
          <Statistic
            id="statistic1"
            currency="USD"
            label="입고 매장 수"
            positiveTrend="{{ self.value >= 0 }}"
            secondaryCurrency="USD"
            secondaryEnableTrend={true}
            secondaryFormattingStyle="percent"
            secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
            secondaryShowSeparators={true}
            secondarySignDisplay="trendArrows"
            secondaryValue=""
            showSeparators={true}
            value="{{ item.in_shop_cnt }}"
          />
          <Statistic
            id="statistic2"
            currency="USD"
            label="판매 매장수"
            positiveTrend="{{ self.value >= 0 }}"
            secondaryCurrency="USD"
            secondaryEnableTrend={true}
            secondaryFormattingStyle="percent"
            secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
            secondaryShowSeparators={true}
            secondarySignDisplay="trendArrows"
            secondaryValue=""
            showSeparators={true}
            value="{{ item.sale_shop_cnt }}"
          />
          <Chart
            id="barChart1"
            barGap={0.4}
            barMode="group"
            legendPosition="top"
            selectedPoints="[]"
            stackedBarTotalsDataLabelPosition="none"
            title={null}
            xAxisRangeMax=""
            xAxisRangeMin=""
            xAxisShowTickLabels={true}
            xAxisTickFormatMode="gui"
            yAxis2LineWidth={1}
            yAxis2RangeMax=""
            yAxis2RangeMin=""
            yAxis2ShowTickLabels={true}
            yAxis2TickFormatMode="gui"
            yAxisRangeMax=""
            yAxisRangeMin=""
            yAxisScale="linear"
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
              name="입고"
              showMarkers={false}
              textTemplate={null}
              textTemplateMode="manual"
              type="bar"
              waterfallBase={0}
              waterfallMeasures={null}
              waterfallMeasuresMode="source"
              xData="{{ JSON.parse(item.shop_graph_data).map(item => item.shop_nm) }}"
              xDataMode="manual"
              yAxis="y"
              yData="{{ JSON.parse(item.shop_graph_data).map(item => item.in) }}"
              yDataMode="manual"
              zData={null}
              zDataMode="manual"
            />
            <Series
              id="1"
              aggregationType="none"
              colorArray={{ array: ["{{ theme.danger }}"] }}
              colorArrayDropDown={{ array: ["{{ theme.danger }}"] }}
              colorInputMode="colorArrayDropDown"
              connectorLineColor="#000000"
              dataLabelPosition="none"
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
              markerSize={6}
              markerSymbol="circle"
              name="판매"
              showMarkers={false}
              textTemplate={null}
              textTemplateMode="manual"
              type="bar"
              waterfallBase={0}
              waterfallMeasures={null}
              waterfallMeasuresMode="source"
              xData="{{ JSON.parse(item.shop_graph_data).map(item => item.shop_nm) }}"
              xDataMode="manual"
              yAxis="y"
              yData="{{ JSON.parse(item.shop_graph_data).map(item => item.sale) }}"
              yDataMode="manual"
              zData={null}
              zDataMode="manual"
            />
          </Chart>
        </View>
      </Container>
    </ListViewBeta>
  </View>
</Container>
