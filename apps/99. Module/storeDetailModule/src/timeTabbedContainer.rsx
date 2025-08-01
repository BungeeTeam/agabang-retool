<Container
  id="timeTabbedContainer"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="0px 4px"
  hidden=""
  margin="0px 2px"
  padding="0"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Tabs
      id="timeUnitSelect"
      itemMode="static"
      navigateContainer={true}
      style={{ ordered: [] }}
      styleVariant="lineBottom"
      targetContainerId="timeTabbedContainer"
      value="{{ self.values[0] }}"
    >
      <Option id="5fc70" value="Tab 1" />
      <Option id="95bd0" value="Tab 2" />
      <Option id="7c71f" value="Tab 3" />
    </Tabs>
  </Header>
  <View
    id="aa659"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="일별"
    viewKey="daily"
  >
    <Chart
      id="plotlyJsonChart4"
      chartType="plotlyJson"
      margin="4px 12px"
      plotlyDataJson={
        '[\n  {\n    "x": {{ shopSalesQuery.data.sale_dt }},\n    "y": {{ shopSalesQuery.data.판매금액 }},\n    "type": "bar",\n    "marker": {\n      "color": "01488F",\n      "opacity": 1\n    },\n    "hovertemplate": "%{x|%Y-%m-%d}<br>판매금액: %{y:,.0f}원<extra></extra>"\n  },\n  {\n    x: {{ shopTargetSalesQuery.data.plan_dt }},\n    y: {{ shopTargetSalesQuery.data.목표매출 }},\n    type: "scatter",\n    mode: "markers",  \n    marker: {\n      color: "red",\n      size: 4\n    },\n    "hovertemplate": "%{x|%Y-%m-%d}<br>목표금액: %{y:,.0f}원<extra></extra>"\n  }\n]'
      }
      plotlyLayoutJson={
        '{\n  "margin": {\n    "l": 40,\n    "r": 0,\n    "t": 0,\n    "b": 30\n  },\n  showlegend: false,\n  "autosize": false,\n  "axis": {\n    type: "date"\n  },\n}'
      }
      selectedPoints="[]"
    />
  </View>
  <View id="29828" label="월별" viewKey="month">
    <Chart
      id="plotlyJsonChart1"
      chartType="plotlyJson"
      margin="4px 12px"
      plotlyDataJson={
        '[\n  {\n    "x": {{ shopSalesQuery.data.year_month }},\n    "y": {{ shopSalesQuery.data.판매금액 }},\n    "type": "bar",\n    "marker": {\n      "color": "01488F",\n      "opacity": 1\n    },\n    "hovertemplate": "%{x|%Y-%m}<br>판매금액: %{y:,.0f}원<extra></extra>"\n\n  },\n  {\n    x: {{ shopTargetSalesQuery.data.yr_month }},\n    y: {{ shopTargetSalesQuery.data.목표매출 }},\n    type: "scatter",\n    mode: "markers",  \n    marker: {\n      color: "red",\n      size: 8\n    },\n    "hovertemplate": "%{x|%Y-%m}<br>목표금액: %{y:,.0f}원<extra></extra>"\n  }\n]'
      }
      plotlyLayoutJson={
        '{\n  "margin": {\n    "l": 40,\n    "r": 0,\n    "t": 0,\n    "b": 30\n  },\n  showlegend: false,\n  "autosize": false,\n  "axis": {\n    type: "date"\n  },\n}'
      }
      selectedPoints="[]"
    />
  </View>
  <View
    id="d2629"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="분기별"
    viewKey="qaurter"
  >
    <Chart
      id="plotlyJsonChart3"
      chartType="plotlyJson"
      margin="4px 12px"
      plotlyDataJson={
        '[\n  {\n    "x": {{ shopSalesQuery.data.year_quarter }},\n    "y": {{ shopSalesQuery.data.판매금액 }},\n    "type": "bar",\n    "marker": {\n      "color": "01488F",\n      "opacity": 1\n    }\n  },\n  {\n    x: {{ shopTargetSalesQuery.data.yr_quarter }},\n    y: {{ shopTargetSalesQuery.data.목표매출 }},\n    type: "scatter",\n    mode: "markers",\n    marker: {\n      color: "red",\n      size: 8\n    }\n  }\n]'
      }
      plotlyLayoutJson={
        '{\n  "margin": {\n    "l": 40,\n    "r": 0,\n    "t": 0,\n    "b": 30\n  },\n  showlegend: false,\n  "autosize": true,\n  "axis": {\n    type: "date"\n  }\n}'
      }
      selectedPoints="[]"
    />
  </View>
  <View id="63254" label="연별" viewKey="year">
    <Chart
      id="plotlyJsonChart2"
      chartType="plotlyJson"
      margin="4px 12px"
      plotlyDataJson={
        '[\n  {\n    "x": {{ shopSalesQuery.data.yr }},\n    "y": {{ shopSalesQuery.data.판매금액 }},\n    "type": "bar",\n    "marker": {\n      "color": "01488F",\n      "opacity": 1\n    }\n  },\n  {\n    x: {{ shopTargetSalesQuery.data.yr }},\n    y: {{ shopTargetSalesQuery.data.목표매출 }},\n    type: "scatter",\n    mode: "markers",\n    marker: {\n      color: "red",\n      size: 8\n    }\n  }\n]'
      }
      plotlyLayoutJson={
        '{\n  "margin": {\n    "l": 40,\n    "r": 0,\n    "t": 0,\n    "b": 30\n  },\n  showlegend: false,\n  "autosize": false,\n  "axis": {\n    type: "date"\n  }\n}'
      }
      selectedPoints="[]"
    />
  </View>
</Container>
