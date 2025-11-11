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
    <Chart
      id="SalesRevenueByGift"
      barGap={0.4}
      barMode="group"
      legendPosition="bottom"
      selectedPoints="[]"
      stackedBarTotalsDataLabelPosition="none"
      title="선물여부에 따른 월별매출추이(단위: 원)"
      xAxisRangeMax=""
      xAxisRangeMin=""
      xAxisShowTickLabels={true}
      xAxisTickFormatMode="gui"
      yAxis2LineWidth={1}
      yAxis2RangeMax=""
      yAxis2RangeMin=""
      yAxis2ShowTickLabels={true}
      yAxis2TickFormatMode="gui"
      yAxisGrid={true}
      yAxisRangeMax=""
      yAxisRangeMin=""
      yAxisRangeMode="manual"
      yAxisShowTickLabels={true}
      yAxisTickFormat=",.0f"
      yAxisTickFormatMode="gui"
      yAxisZeroLine={true}
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
        groupByDropdownType="manual"
        groupByStyles={{}}
        hoverTemplate="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
        hoverTemplateMode="source"
        increasingBorderColor="{{ theme.success }}"
        increasingColor="{{ theme.success }}"
        lineColor="{{ theme.success }}"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth="3"
        markerBorderColor={null}
        markerBorderWidth={0}
        markerColor="{{ theme.primary }}"
        markerSize={6}
        markerSymbol="circle"
        name="선물판매"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData={
          '{{ giftSalesQuery.data.filter(item => item.gift_yn === "Y").map(item => item.sale_dt) }}'
        }
        xDataMode="manual"
        yAxis="y"
        yData={
          '{{ giftSalesQuery.data.filter(item => item.gift_yn === "Y").map(item => item.sale_amt) }}'
        }
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
        lineColor="rgba(49, 112, 249, 0.9)"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor={null}
        markerBorderWidth={0}
        markerColor="{{ theme.danger }}"
        markerSize={6}
        markerSymbol="circle"
        name="일반판매"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData={
          '{{ giftSalesQuery.data.filter(item => item.gift_yn !== "Y").map(item => item.sale_dt) }}'
        }
        xDataMode="manual"
        yAxis="y"
        yData={
          '{{ giftSalesQuery.data.filter(item => item.gift_yn !== "Y").map(item => item.sale_amt) }}'
        }
        yDataMode="manual"
        zData={null}
        zDataMode="manual"
      />
    </Chart>
    <Chart
      id="SalesRevenueByGift2"
      barGap={0.4}
      barMode="group"
      legendPosition="bottom"
      selectedPoints="[]"
      stackedBarTotalsDataLabelPosition="none"
      title="선물여부에 따른 월별판매량 추이"
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
      yAxisShowTickLabels={true}
      yAxisTickFormat=",.0f"
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
        groupByDropdownType="manual"
        groupByStyles={{}}
        hoverTemplate="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>"
        hoverTemplateMode="source"
        increasingBorderColor="{{ theme.success }}"
        increasingColor="{{ theme.success }}"
        lineColor="{{ theme.success }}"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth="3"
        markerBorderColor={null}
        markerBorderWidth={0}
        markerColor="{{ theme.primary }}"
        markerSize={6}
        markerSymbol="circle"
        name="선물판매"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData={
          '{{ giftSalesQuery.data.filter(item => item.gift_yn === "Y").map(item => item.sale_dt) }}'
        }
        xDataMode="manual"
        yAxis="y"
        yData={
          '{{ giftSalesQuery.data.filter(item => item.gift_yn === "Y").map(item => item.sale_qty) }}'
        }
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
        lineColor="rgba(49, 112, 249, 0.9)"
        lineDash="solid"
        lineShape="linear"
        lineUnderFillMode="none"
        lineWidth={2}
        markerBorderColor={null}
        markerBorderWidth={0}
        markerColor="{{ theme.danger }}"
        markerSize={6}
        markerSymbol="circle"
        name="일반판매"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData={
          '{{ giftSalesQuery.data.filter(item => item.gift_yn !== "Y").map(item => item.sale_dt) }}'
        }
        xDataMode="manual"
        yAxis="y"
        yData={
          '{{ giftSalesQuery.data.filter(item => item.gift_yn !== "Y").map(item => item.sale_qty) }}'
        }
        yDataMode="manual"
        zData={null}
        zDataMode="manual"
      />
    </Chart>
    <Chart
      id="barChart4"
      barGap="0.5"
      barMode="relative"
      legendPosition="bottom"
      selectedPoints="[]"
      stackedBarTotalsDataLabelPosition="none"
      title="브랜드별 일반판매 월별 판매매출추이"
      xAxisRangeMax=""
      xAxisRangeMin=""
      xAxisShowTickLabels={true}
      xAxisTickFormatMode="gui"
      yAxis2LineWidth={1}
      yAxis2RangeMax=""
      yAxis2RangeMin=""
      yAxis2ShowTickLabels={true}
      yAxis2TickFormatMode="gui"
      yAxisGrid={true}
      yAxisRangeMax=""
      yAxisRangeMin=""
      yAxisShowTickLabels={true}
      yAxisZeroLine={true}
    >
      <Series
        id="0"
        aggregationType="none"
        colorArray={{ array: ["{{ theme.primary }}"] }}
        colorArrayDropDown={{ array: ["{{ theme.primary }}"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource={
          '{{ giftSalesByBrandQuery.data.filter(item => item.gift_yn !== "Y") }}'
        }
        datasourceMode="manual"
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
        groupBy={{ array: ["br_nm"] }}
        groupByDropdownType="source"
        groupByStyles={{
          N_이야이야오: { ordered: [{ markerBorderWidth: "1" }] },
          아가방: {
            ordered: [
              { markerColor: "#ff5900" },
              { markerBorderColor: "#ff5900" },
            ],
          },
          에뜨와: {
            ordered: [
              { markerColor: "#ffff00" },
              { markerBorderColor: "#ffff00" },
            ],
          },
          디즈니베이비: {
            ordered: [
              { markerColor: "#0020a1" },
              { markerBorderColor: "#0020a1" },
            ],
          },
        }}
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
        name="sales"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData={
          '{{ formatDataAsObject(giftSalesByBrandQuery.data.filter(item => item.gift_yn !== "Y")).sale_dt }}'
        }
        xDataMode="source"
        yAxis="y"
        yData={
          '{{ formatDataAsObject(giftSalesByBrandQuery.data.filter(item => item.gift_yn !== "Y")).sales_rev }}'
        }
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
    </Chart>
    <Chart
      id="barChart2"
      barGap="0.5"
      barMode="relative"
      legendPosition="bottom"
      margin="0"
      selectedPoints="[]"
      stackedBarTotalsDataLabelPosition="none"
      title="브랜드별 선물 월별 판매매출추이"
      xAxisRangeMax=""
      xAxisRangeMin=""
      xAxisShowTickLabels={true}
      xAxisTickFormatMode="gui"
      yAxis2LineWidth={1}
      yAxis2RangeMax=""
      yAxis2RangeMin=""
      yAxis2ShowTickLabels={true}
      yAxis2TickFormatMode="gui"
      yAxisGrid={true}
      yAxisRangeMax=""
      yAxisRangeMin=""
      yAxisShowTickLabels={true}
      yAxisZeroLine={true}
    >
      <Series
        id="0"
        aggregationType="none"
        colorArray={{ array: ["{{ theme.primary }}"] }}
        colorArrayDropDown={{ array: ["{{ theme.primary }}"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource={
          '{{ giftSalesByBrandQuery.data.filter(item => item.gift_yn === "Y") }}'
        }
        datasourceMode="manual"
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
        groupBy={{ array: ["br_nm"] }}
        groupByDropdownType="source"
        groupByStyles={{
          N_이야이야오: { ordered: [{ markerBorderWidth: "1" }] },
          아가방: {
            ordered: [
              { markerColor: "#ff5900" },
              { markerBorderColor: "#ff5900" },
            ],
          },
          에뜨와: {
            ordered: [
              { markerColor: "#ffff00" },
              { markerBorderColor: "#ffff00" },
            ],
          },
          디즈니베이비: {
            ordered: [
              { markerColor: "#0020a1" },
              { markerBorderColor: "#0020a1" },
            ],
          },
        }}
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
        name="sales"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData={
          '{{ formatDataAsObject(giftSalesByBrandQuery.data.filter(item => item.gift_yn === "Y")).sale_dt }}'
        }
        xDataMode="source"
        yAxis="y"
        yData={
          '{{ formatDataAsObject(giftSalesByBrandQuery.data.filter(item => item.gift_yn === "Y")).sales_rev }}'
        }
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
    </Chart>
    <Chart
      id="pieChart1"
      chartType="pie"
      colorArray={
        '["#FF5900","#4046CA","#F68512","#DE3C82","#7E84FA","#72E06A"]'
      }
      colorArrayDropDown={[
        "#ff5900",
        "#4046CA",
        "#ffff00",
        "#DE3C82",
        "#ff5900",
        "#ff5900",
        "#0020a1",
        "#fde68a",
        "#eecff3",
        "#ffff00",
        "#ffff00",
        "#c7d2fe",
        "#0020a1",
      ]}
      colorInputMode="colorArrayDropDown"
      datasource="{{ giftSalesByBrandStatistics.data }}"
      datasourceMode="source"
      gradientColorArray={[
        ["0.0", "{{ theme.canvas }}"],
        ["1.0", "{{ theme.primary }}"],
      ]}
      hoverTemplate="%{label}<br>%{value}<br>%{percent}<extra></extra>"
      hoverTemplateMode="source"
      labelData={
        '{{ giftSalesByBrandStatistics.data.filter(item => item.gift_yn === "Y").map(item => item.br_nm) }}'
      }
      legendPosition="none"
      lineColor="{{ theme.surfacePrimary }}"
      lineWidth="0"
      margin="0"
      pieDataHole="0.3"
      selectedPoints="[]"
      textTemplate="%{label}"
      textTemplateMode="source"
      textTemplatePosition="auto"
      title="브랜드별 선물 평균비중"
      valueData={
        '{{ giftSalesByBrandStatistics.data.filter(item => item.gift_yn === "Y").map(item => item.sales_rev) }}'
      }
    />
    <Chart
      id="pieChart2"
      chartType="pie"
      colorArray={
        '["#11B5AE","#4046CA","#F68512","#DE3C82","#7E84FA","#72E06A"]'
      }
      colorArrayDropDown={[
        "#ff5900",
        "#4046CA",
        "#0020a1",
        "#DE3C82",
        "#ffff00",
        "#ffff00",
        "#fcd6bb",
        "#fde68a",
        "#ffff00",
        "#a7f3d0",
        "#bfdbfe",
        "#c7d2fe",
        "#fecaca",
        "#fcd6bb",
        "#fde68a",
        "#eecff3",
        "#a7f3d0",
        "#bfdbfe",
        "#c7d2fe",
        "#ff5900",
        "#fcd6bb",
        "#fde68a",
        "#ff5900",
        "#ff5900",
        "#bfdbfe",
        "#c7d2fe",
        "#fecaca",
        "#0020a1",
        "#fde68a",
      ]}
      colorInputMode="colorArrayDropDown"
      datasource="{{ giftSalesByBrandStatistics.data }}"
      datasourceMode="source"
      gradientColorArray={[
        ["0.0", "{{ theme.canvas }}"],
        ["1.0", "{{ theme.primary }}"],
      ]}
      hoverTemplate="%{label}<br>%{value}<br>%{percent}<extra></extra>"
      hoverTemplateMode="source"
      labelData={
        '{{ giftSalesByBrandStatistics.data.filter(item => item.gift_yn !== "Y").map(item => item.br_nm) }}'
      }
      legendPosition="none"
      lineColor="{{ theme.surfacePrimary }}"
      lineWidth="0"
      margin="0"
      pieDataHole="0.3"
      selectedPoints="[]"
      textTemplate="%{label}"
      textTemplateMode="source"
      textTemplatePosition="auto"
      title="브랜드별 일반판매 평균비중"
      valueData={
        '{{ giftSalesByBrandStatistics.data.filter(item => item.gift_yn !== "Y").map(item => item.sales_rev) }}'
      }
    />
    <Chart
      id="barChart5"
      barGap={0.4}
      barMode="group"
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
      yAxisShowTickLabels={true}
      yAxisTickFormat=".0%"
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
        datasource="{{ giftSalesTrend.data }}"
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
        groupBy={{ array: ["gift_yn"] }}
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
        name="월별 선물판매비중"
        showMarkers={false}
        textTemplate={null}
        textTemplateMode="source"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ formatDataAsObject(giftSalesTrend.data).sale_dt }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ formatDataAsObject(giftSalesTrend.data).ratio }}"
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
      <Event
        event="select"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="giftSalesTrend"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Chart>
  </Frame>
</App>
