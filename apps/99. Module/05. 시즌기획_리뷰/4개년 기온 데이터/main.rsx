<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css="" />
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
      id="container_title"
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle4"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="0e22d" viewKey="View 1">
        <Text
          id="title"
          margin="10px 8px 4px 8px"
          style={{
            ordered: [
              { fontSize: "18px" },
              { fontWeight: "600" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          value="🌡️  4개년 기온 데이터"
          verticalAlign="center"
        />
        <Container
          id="container5"
          _gap="0px"
          _justify="end"
          _type="stack"
          footerPadding="4px 12px"
          headerPadding="4px 12px"
          margin="0"
          padding="0"
          showBody={true}
          showBorder={false}
        >
          <Header>
            <Text
              id="containerTitle5"
              value="#### Container title"
              verticalAlign="center"
            />
          </Header>
          <View id="0e22d" viewKey="View 1">
            <Select
              id="select_region"
              data="{{ get_region.data }}"
              emptyMessage="No options"
              iconBefore="bold/travel-map-earth-1"
              label=""
              labelPosition="top"
              labels="{{ item.region_name }}"
              overlayMaxHeight={375}
              placeholder="Select an option"
              showSelectionIndicator={true}
              textBefore="지역"
              value={'"108"'}
              values="{{ item.region_code }}"
            />
            <DateRange
              id="dateRange_day"
              dateFormat="yyyy-MM-dd"
              endPlaceholder="종료일"
              iconBefore="bold/interface-calendar-remove"
              label=""
              labelPosition="top"
              maxDate="{{ moment() }}"
              minDate="{{ moment(self.value.end).subtract(1, 'years') }}"
              startPlaceholder="시작일"
              textBefore="날짜"
              textBetween="-"
              value={{
                ordered: [
                  {
                    start:
                      '{{ select_period.value == "day"\n    ? moment().subtract(1, \'months\').format("YYYY-MM-DD")  // 일간 선택 시: 최근 1달\n    : select_period.value == "week"\n        ? moment().subtract(16, \'weeks\').format("YYYY-MM-DD") // ★ 주간 선택 시: 최근 16주 ★\n        : moment().subtract(1, \'year\').format("YYYY-MM-DD")   // 그 외 기본값 (예: 최근 1년)\n}}',
                  },
                  { end: '{{ moment().format("YYYY-MM-DD") }}' },
                ],
              }}
            />
            <Select
              id="select_period"
              emptyMessage="No options"
              iconBefore="bold/interface-calendar-date-week-seven"
              itemMode="static"
              label=""
              labelPosition="top"
              overlayMaxHeight={375}
              placeholder="Select an option"
              showSelectionIndicator={true}
              textBefore="단위"
              value="day"
            >
              <Option id="7c9df" label="일간" value="day" />
              <Option
                id="ae03f"
                disabled={false}
                hidden={false}
                label="주간"
                value="week"
              />
            </Select>
          </View>
        </Container>
      </View>
    </Container>
    <Container
      id="container_temp_max"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="container_temp_max_title"
          value="###### ⬆️ 최고온도"
          verticalAlign="center"
        />
      </Header>
      <View id="50155" viewKey="View 1">
        <Chart
          id="plotly_temp_max"
          chartType="plotlyJson"
          plotlyDataJson="{{ weather_table_data.data.plotlyTracesMax}}"
          plotlyLayoutJson={
            '{\n  "title": "",\n  "xaxis": {\n    "title": "",\n    "showgrid": false\n  },\n  "yaxis": {\n    "title": "",\n    "showgrid": true // Y축 그리드 표시\n  },\n  "hovermode": "x unified",\n  "margin": { // 여백 조정 (값을 줄여 여백 감소)\n    "l": 30,  // 왼쪽 여백\n    "r": 30,  // 오른쪽 여백\n    "t": 30,  // 상단 여백 (제목 공간 포함)\n    "b": 30   // 하단 여백\n  },\n  "colorway": [\n    "#feecaa", // 2022년\n    "#eecff3", // 2023년\n    "#bfdbfe", // 2024년\n    "#dc2626"  // 2025년\n  ],\n  "legend": { // 범례 설정\n    "orientation": "h",\n    "yanchor": "bottom",\n    "y": 1,\n    "xanchor": "center",\n    "x": 0.5\n  }\n}'
          }
          selectedPoints="[]"
        />
        <Table
          id="table_temp_max"
          autoColumnWidth={true}
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ weather_table_data.data.tableDataMax }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          showHeader={true}
          showSummaryRow={true}
          style={{ summaryRowText: "#dc2626" }}
          toolbarPosition="bottom"
        >
          <Column
            id="84c3b"
            alignment="center"
            editable={false}
            format="string"
            groupAggregationMode="none"
            key="날짜"
            label="날짜"
            placeholder="Enter value"
            position="center"
            size={89.234375}
            summaryAggregationMode="none"
          />
          <Column
            id="2b99a"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2022년"
            label="2022 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
          <Column
            id="d3969"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2023년"
            label="2023 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
          <Column
            id="85e62"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2024년"
            label="2024 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
          <Column
            id="4778c"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2025년"
            label="2025 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
        </Table>
      </View>
    </Container>
    <Container
      id="container_temp_min"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="container_temp_min_title"
          value="###### ⬇️ 최저온도"
          verticalAlign="center"
        />
      </Header>
      <View id="50155" viewKey="View 1">
        <Chart
          id="plotly_temp_min"
          chartType="plotlyJson"
          plotlyDataJson="{{ weather_table_data.data.plotlyTracesMin}}"
          plotlyLayoutJson={
            '{\n  "title": "",\n  "xaxis": {\n    "title": "",\n    "showgrid": false\n  },\n  "yaxis": {\n    "title": "",\n    "showgrid": true // Y축 그리드 표시\n  },\n  "hovermode": "x unified",\n  "margin": { // 여백 조정 (값을 줄여 여백 감소)\n    "l": 30,  // 왼쪽 여백\n    "r": 30,  // 오른쪽 여백\n    "t": 30,  // 상단 여백 (제목 공간 포함)\n    "b": 30   // 하단 여백\n  },\n  "colorway": [\n    "#feecaa", // 2022년\n    "#eecff3", // 2023년\n    "#bfdbfe", // 2024년\n    "#3170f9"  // 2025년\n  ],\n  "legend": { // 범례 설정\n    "orientation": "h",\n    "yanchor": "bottom",\n    "y": 1,\n    "xanchor": "center",\n    "x": 0.5\n  }\n}'
          }
          selectedPoints="[]"
        />
        <Table
          id="table_temp_min"
          autoColumnWidth={true}
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ weather_table_data.data.tableDataMin }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          showHeader={true}
          showSummaryRow={true}
          style={{ summaryRowText: "rgba(46, 37, 219, 1)" }}
          toolbarPosition="bottom"
        >
          <Column
            id="84c3b"
            alignment="center"
            editable={false}
            format="string"
            groupAggregationMode="none"
            key="날짜"
            label="날짜"
            placeholder="Enter value"
            position="center"
            size={89.234375}
            summaryAggregationMode="none"
          />
          <Column
            id="2b99a"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2022년"
            label="2022 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
          <Column
            id="d3969"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2023년"
            label="2023 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
          <Column
            id="85e62"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2024년"
            label="2024 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
          <Column
            id="edc39"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2025년"
            label="2025 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
        </Table>
      </View>
    </Container>
    <Container
      id="container_temp_avg"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="container_temp_avg_title"
          value="###### 😑 평균온도"
          verticalAlign="center"
        />
      </Header>
      <View id="50155" viewKey="View 1">
        <Chart
          id="plotly_temp_avg"
          chartType="plotlyJson"
          plotlyDataJson="{{ weather_table_data.data.plotlyTracesAvg}}"
          plotlyLayoutJson={
            '{\n  "title": "",\n  "xaxis": {\n    "title": "",\n    "showgrid": false\n  },\n  "yaxis": {\n    "title": "",\n    "showgrid": true // Y축 그리드 표시\n  },\n  "hovermode": "x unified",\n  "margin": { // 여백 조정 (값을 줄여 여백 감소)\n    "l": 30,  // 왼쪽 여백\n    "r": 30,  // 오른쪽 여백\n    "t": 30,  // 상단 여백 (제목 공간 포함)\n    "b": 30   // 하단 여백\n  },\n  "colorway": [\n    "#feecaa", // 2022년\n    "#eecff3", // 2023년\n    "#bfdbfe", // 2024년\n    "#069669"  // 2025년\n  ],\n  "legend": { // 범례 설정\n    "orientation": "h",\n    "yanchor": "bottom",\n    "y": 1,\n    "xanchor": "center",\n    "x": 0.5\n  }\n}'
          }
          selectedPoints="[]"
        />
        <Table
          id="table_temp_avg"
          autoColumnWidth={true}
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ weather_table_data.data.tableDataAvg }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          showHeader={true}
          showSummaryRow={true}
          style={{ summaryRowText: "rgba(28, 129, 3, 1)" }}
          toolbarPosition="bottom"
        >
          <Column
            id="84c3b"
            alignment="center"
            editable={false}
            format="string"
            groupAggregationMode="none"
            key="날짜"
            label="날짜"
            placeholder="Enter value"
            position="center"
            size={89.234375}
            summaryAggregationMode="none"
          />
          <Column
            id="2b99a"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2022년"
            label="2022 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
          <Column
            id="d3969"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2023년"
            label="2023 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
          <Column
            id="85e62"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2024년"
            label="2024 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
          <Column
            id="d9b43"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="sum"
            key="2025년"
            label="2025 년"
            placeholder="Enter value"
            position="center"
            size={60.84375}
            summaryAggregationMode="average"
          />
        </Table>
      </View>
    </Container>
  </Frame>
</App>
