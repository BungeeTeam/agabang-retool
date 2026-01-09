<Screen
  id="dashboard"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title="dashboard"
  urlSlug=""
>
  <SqlQueryUnified
    id="get_tickets"
    isMultiplayerEdited={false}
    query={include("../lib/get_tickets.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    resourceTypeOverride=""
    warningCodes={[]}
  />
  <SqlQueryUnified
    id="get_ticket_number"
    isMultiplayerEdited={false}
    query={include("../lib/get_ticket_number.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    resourceTypeOverride=""
    warningCodes={[]}
  />
  <Function
    id="transformer3"
    funcBody={include("../lib/transformer3.js", "string")}
  />
  <SqlQueryUnified
    id="get_ticket_number2"
    isMultiplayerEdited={false}
    query={include("../lib/get_ticket_number2.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    resourceTypeOverride=""
    warningCodes={[]}
  />
  <Frame
    id="$main4"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Text
      id="text33"
      style={{
        ordered: [
          { fontSize: "h4Font" },
          { fontWeight: "h4Font" },
          { fontFamily: "h4Font" },
        ],
      }}
      value="티켓 처리 대시보드"
      verticalAlign="center"
    />
    <DateRange
      id="dateRange1"
      dateFormat="yyyy-MM-dd"
      endPlaceholder="End date"
      iconBefore="bold/interface-calendar-remove"
      label="조회기간"
      startPlaceholder="Start date"
      textBetween="~"
      value={{
        ordered: [
          { start: "'2025-06-01'" },
          { end: "{{ moment().format('YYYY-MM-DD') }}" },
        ],
      }}
    />
    <Spacer id="spacer27" />
    <Include src="./collapsibleContainer1.rsx" />
    <Text
      id="text32"
      style={{
        ordered: [
          { fontSize: "h6Font" },
          { fontWeight: "h6Font" },
          { fontFamily: "h6Font" },
        ],
      }}
      value="[유형별 티켓 비율]"
      verticalAlign="center"
    />
    <Text
      id="text31"
      style={{
        ordered: [
          { fontSize: "h6Font" },
          { fontWeight: "h6Font" },
          { fontFamily: "h6Font" },
        ],
      }}
      value="[기간별 티켓 건수]"
      verticalAlign="center"
    />
    <Container
      id="container9"
      enableFullBleed={true}
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      heightType="fixed"
      overflowType="hidden"
      padding="12px"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Tabs id="tabs3" itemMode="static" value="{{ self.values[0] }}">
          <Option id="5a4f0" label="반영 범위" value="in_scope" />
          <Option id="95ff6" label="진행상태" value="status" />
          <Option
            id="74ce7"
            label="고객 문의유형"
            tooltip="고객이 선택한 문의 유형"
            value="category"
          />
          <Option
            id="7de7e"
            disabled={false}
            hidden={false}
            iconPosition="left"
            label="클리브 분류유형"
            tooltip="클리브가 분류한 문의유형"
            value="admin_category"
          />
        </Tabs>
      </Header>
      <View id="150fd" viewKey="View 1">
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
            "#11B5AE",
            "#4046CA",
            "#F68512",
            "#DE3C82",
            "#7E84FA",
            "#72E06A",
          ]}
          colorInputMode="colorArrayDropDown"
          datasource="{{ getReportsQuery.data }}"
          datasourceMode="source"
          gradientColorArray={[
            ["0.0", "{{ theme.canvas }}"],
            ["1.0", "{{ theme.primary }}"],
          ]}
          hoverTemplate="%{label}<br>%{value}<br>%{percent}<extra></extra>"
          hoverTemplateMode="source"
          labelData="{{ formatDataAsObject(getReportsQuery.data)[tabs3.value]}}"
          legendPosition="none"
          lineColor="{{ theme.surfacePrimary }}"
          lineWidth={2}
          pieDataHole={0.4}
          selectedPoints="[]"
          textTemplate="%{label}<br>%{value}건(%{percent})"
          textTemplatePosition="outside"
          title={null}
          valueData=""
        >
          <Event
            event="select"
            method="setFilter"
            params={{
              ordered: [
                {
                  filter: {
                    ordered: [
                      { id: "ticket_list" },
                      { columnId: "{{ tabs3.value }}" },
                      { operator: "=" },
                      { value: "{{ self.selectedPoints[0]?.label }}" },
                    ],
                  },
                },
              ],
            }}
            pluginId="table4"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Chart>
      </View>
    </Container>
    <Container
      id="tabbedContainer1"
      currentViewKey="{{ self.viewKeys[0] }}"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      heightType="fixed"
      overflowType="hidden"
      padding="12px"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Tabs
          id="tabs2"
          itemMode="static"
          targetContainerId="tabbedContainer1"
          value="{{ self.values[0] }}"
        >
          <Option id="616b8" label="일간" value="dt" />
          <Option id="06157" label="주간" value="year_week_num" />
          <Option id="ba271" label="월간" value="year_month" />
        </Tabs>
      </Header>
      <View id="28778" label="일간" viewKey="dt">
        <Chart
          id="bubbleChart1"
          barGap={null}
          barGroupGap="0.4"
          barMode="group"
          chartType="scatter"
          legendPosition="none"
          selectedPoints="[]"
          stackedBarTotalsDataLabelPosition="none"
          title={null}
          xAxisLineWidth="1"
          xAxisRangeMax=""
          xAxisRangeMin=""
          xAxisRangeMode="manual"
          xAxisShowLine={true}
          xAxisShowTickLabels={true}
          xAxisSort="ascending"
          xAxisTitle="접수 {{ tabs2.value === 'dt' ? '일자' :
 tabs2.value === 'year_week_num' ?
 '주차' : '월' }}"
          xAxisTitleStandoff="4"
          yAxis2LineWidth={1}
          yAxis2RangeMax=""
          yAxis2RangeMin=""
          yAxis2ShowTickLabels={true}
          yAxis2TickFormatMode="gui"
          yAxis2TitleStandoff={20}
          yAxisGrid={true}
          yAxisLineWidth={1}
          yAxisRangeMax="{{ tabs2.value === 'dt' ? 11 :
 tabs2.value === 'year_week_num' ?
 21 : 31 }}"
          yAxisRangeMin="0"
          yAxisRangeMode="manual"
          yAxisShowLine={true}
          yAxisShowTickLabels={true}
          yAxisTickFormat=".0f"
          yAxisTickFormatMode="gui"
          yAxisTitle="접수 건수 (건)"
          yAxisTitleStandoff="3"
        >
          <Series
            id="0"
            aggregationType="sum"
            colorArray={{ array: [] }}
            colorArrayDropDown={{ array: [] }}
            colorInputMode="gradientColorArray"
            connectorLineColor="#000000"
            dataLabelPosition="outside"
            datasource="{{ get_ticket_number.data }}"
            datasourceMode="source"
            decreasingBorderColor="#000000"
            decreasingColor="#000000"
            filteredGroups={null}
            filteredGroupsMode="source"
            gradientColorArray={{ array: [] }}
            groupBy={{ array: [] }}
            groupByDropdownType="manual"
            groupByStyles={{}}
            hidden={false}
            hiddenMode="manual"
            hoverTemplate="<b>%{x}</b><br>%{y}<extra></extra>"
            hoverTemplateArray={{ array: [] }}
            hoverTemplateMode="manual"
            increasingBorderColor="#000000"
            increasingColor="#000000"
            lineColor="#000000"
            lineDash="solid"
            lineShape="linear"
            lineUnderFillMode="none"
            lineWidth={2}
            markerBorderColor="#ffffff"
            markerBorderWidth="1"
            markerColor="rgba(136, 212, 173, 1)"
            markerSize={6}
            markerSymbol="circle"
            name="New Series (1)"
            showMarkers={false}
            textTemplate="%{y:.0f}"
            textTemplateMode="manual"
            type="bar"
            waterfallBase={0}
            waterfallMeasures={{ array: [] }}
            waterfallMeasuresMode="source"
            xData="{{ get_ticket_number.data[tabs2.value] }}"
            xDataMode="manual"
            yAxis="y"
            yData="{{ get_ticket_number.data.ticket_cnt }}"
            yDataMode="source"
            zData="[1, 2, 3, 4, 5]"
            zDataMode="manual"
          />
          <Event
            event="select"
            method="setFilter"
            params={{
              ordered: [
                {
                  filter: {
                    ordered: [
                      { id: "ticket_list" },
                      { columnId: "{{ tabs2.value }}" },
                      { operator: "=" },
                      { value: "{{ self.selectedPoints[0]?.x }}" },
                    ],
                  },
                },
              ],
            }}
            pluginId="table4"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="clear"
            method="clearFilter"
            params={{ ordered: [{ id: "ticket_list" }] }}
            pluginId="table4"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Chart>
      </View>
      <View id="d2676" label="주간" viewKey="year_week_num" />
      <View id="45997" label="월간" viewKey="year_month" />
    </Container>
    <Container
      id="stack19"
      _align="center"
      _flexWrap={true}
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
      style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
    >
      <View id="a4244" viewKey="View 1">
        <Text
          id="text34"
          style={{
            ordered: [
              { fontSize: "h6Font" },
              { fontWeight: "h6Font" },
              { fontFamily: "h6Font" },
            ],
          }}
          value="[티켓 목록]"
          verticalAlign="center"
        />
        <Button
          id="closeButton1"
          ariaLabel="reset list"
          heightType="auto"
          horizontalAlign="left"
          iconBefore="bold/interface-arrows-synchronize"
          margin="0"
          style={{ ordered: [{ border: "transparent" }] }}
          styleVariant="outline"
          text="목록 초기화"
        >
          <Event
            event="click"
            method="setFilter"
            params={{
              ordered: [
                {
                  filter: {
                    ordered: [
                      { id: "ticket_list" },
                      { columnId: "id" },
                      { operator: ">" },
                      { value: "0" },
                    ],
                  },
                },
              ],
            }}
            pluginId="table4"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
    <Table
      id="table4"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_tickets.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      hidden=""
      rowHeight="medium"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      showSummaryRow={true}
      toolbarPosition="bottom"
    >
      <Column
        id="5965d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="false"
        key="id"
        label="ID"
        placeholder="Enter value"
        position="left"
        size={40.96875}
        summaryAggregationMode="none"
      />
      <Column
        id="52973"
        alignment="left"
        caption="{{ currentSourceRow.re }}"
        format="multilineString"
        groupAggregationMode="none"
        key="report_title"
        label="제목"
        placeholder="Enter value"
        position="left"
        size={265.453125}
        sortMode="disabled"
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      />
      <Column
        id="1c976"
        alignment="left"
        cellTooltipMode="overflow"
        format="html"
        groupAggregationMode="none"
        key="report_description"
        label="요청 상세"
        placeholder="Enter value"
        position="left"
        size={371}
        summaryAggregationMode="none"
      />
      <Column
        id="8e8c8"
        alignment="center"
        editable="false"
        editableOptions={{ allowCustomValue: false }}
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="in_scope"
        label="반영 범위"
        optionList={{
          manualData: [
            {
              ordered: [
                { value: "범위 내" },
                { label: "범위 내" },
                { caption: "명확히 유지보수 범위 내에 들어옴" },
                { color: "#f8fab4" },
              ],
            },
            {
              ordered: [
                { value: "제한적 수용" },
                { label: "제한적 수용" },
                { caption: "리소스 투입 대비 임팩트를 고려하여 수용" },
                { color: "#fee2ad" },
              ],
            },
            {
              ordered: [
                { value: "범위 외" },
                { label: "범위 외" },
                { caption: "명확히 유지보수 범위 내에 들어오지 않음" },
                { color: "#f08787" },
              ],
            },
          ],
        }}
        placeholder="Select option"
        position="center"
        size={86.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="a10c8"
        alignment="center"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="category"
        label="고객 문의유형"
        optionList={{
          manualData: [
            { ordered: [{ value: "오류 신고" }] },
            { ordered: [{ value: "기능 개선 요청" }] },
            { ordered: [{ value: "작동 오류" }] },
            { ordered: [{ value: "데이터 오류" }] },
            { ordered: [{ value: "기능 개선" }] },
            { ordered: [{ value: "오타/오기" }] },
            { ordered: [{ value: "사용 방법 문의" }] },
          ],
        }}
        placeholder="Enter value"
        position="center"
        size={100.25}
        summaryAggregationMode="none"
      />
      <Column
        id="fd4f2"
        alignment="left"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="admin_category"
        label="클리브 분류유형"
        placeholder="Enter value"
        position="center"
        referenceId="column13"
        size={91.609375}
        summaryAggregationMode="none"
      />
      <Column
        id="5b4af"
        alignment="center"
        editable={false}
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="status"
        label="진행 상태"
        optionList={{
          manualData: [
            { ordered: [{ value: "접수 대기" }] },
            { ordered: [{ value: "담당자 지정" }, { label: "담당자 지정" }] },
            { ordered: [{ value: "처리 진행 중" }] },
            { ordered: [{ value: "보류" }] },
            { ordered: [{ value: "해결 완료" }] },
            { ordered: [{ value: "처리 완료" }] },
            { ordered: [{ value: "반영 예정" }] },
          ],
          mode: "manual",
        }}
        placeholder="Select option"
        position="center"
        size={89.875}
        summaryAggregationMode="none"
      />
      <Column
        id="41394"
        alignment="left"
        caption="{{ currentSourceRow.submitter_email }}"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="submitter_name"
        label="작성자"
        placeholder="Enter value"
        position="center"
        size={170.375}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      >
        <Event
          event="clickCell"
          method="run"
          params={{
            ordered: [
              {
                src: "utils.copyToClipboard(currentSourceRow.submitter_email);\n\nutils.showNotification(\n  { title: '복사 성공',\n    notificationType: 'success',\n    description: '이메일 주소가 복사되었습니다.'\n  }\n)",
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="84b41"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="lag_days"
        label="처리 소요일"
        placeholder="Enter value"
        position="center"
        size={123}
        summaryAggregationMode="average"
      />
      <Column
        id="9e7e6"
        alignment="left"
        format="string"
        formatOptions={{ timeFormat: "" }}
        groupAggregationMode="none"
        key="real_lag"
        label="처리 소요 시간"
        placeholder="Enter value"
        position="center"
        size={249}
        summaryAggregationMode="none"
      />
      <Column
        id="6d966"
        alignment="center"
        format="date"
        formatOptions={{ dateFormat: "yyyy-MM-dd" }}
        groupAggregationMode="none"
        key="submitted_dt"
        label="접수일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="a90ba"
        alignment="center"
        format="date"
        formatOptions={{ dateFormat: "yyyy-MM-dd" }}
        groupAggregationMode="none"
        key="end_dt"
        label="처리완료일"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="d8cd2"
        alignment="left"
        format="datetime"
        formatOptions={{
          dateFormat: "yyyy-MM-dd",
          timeFormat: "'HH:mm'",
          manageTimeZone: true,
          valueTimeZone: "00:00",
          displayTimeZone: "local",
        }}
        groupAggregationMode="none"
        key="last_updated_at"
        label="마지막 업데이트 일시"
        placeholder="Enter value"
        position="center"
        size={119.203125}
        summaryAggregationMode="none"
      />
      <Column
        id="e87bf"
        alignment="left"
        editable={false}
        format="datetime"
        formatOptions={{
          dateFormat: "yyyy-MM-dd",
          timeFormat: "'HH:mm'",
          manageTimeZone: true,
          valueTimeZone: "00:00",
          displayTimeZone: "local",
        }}
        groupAggregationMode="none"
        key="resolved_at"
        label="처리완료 일시"
        placeholder="Enter value"
        position="center"
        size={118.78125}
        summaryAggregationMode="none"
      />
      <Column
        id="3c66e"
        alignment="left"
        format="datetime"
        formatOptions={{
          dateFormat: "'yyyy-MM-dd'",
          manageTimeZone: true,
          valueTimeZone: "00:00",
          displayTimeZone: "local",
          timeFormat: "'HH:mm'",
        }}
        groupAggregationMode="none"
        key="submitted_at"
        label="작성일시"
        placeholder="Enter value"
        position="center"
        size={119.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="4f1a8"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        hidden="true"
        key="dt"
        label="Dt"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="3c0ae"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="year_week_num"
        label="Year week num"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="9d7bc"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="year_month"
        label="Year month"
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
          pluginId="table4"
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
          pluginId="table4"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="save"
        method="trigger"
        params={{
          ordered: [
            {
              options: {
                object: {
                  onSuccess: null,
                  onFailure: null,
                  additionalScope: null,
                },
              },
            },
          ],
        }}
        pluginId=""
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="run"
        params={{
          ordered: [
            {
              src: "varSelectedRow.setValue(currentSourceRow)\n//  modalFrameAdmin.show();\nmodalFrameReportsDetailUser.show();\ngetFileAttachments.trigger();\ngetReplies.trigger();",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Chart
      id="pieChart2"
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
        "#11B5AE",
        "#4046CA",
        "#F68512",
        "#DE3C82",
        "#7E84FA",
        "#72E06A",
      ]}
      colorInputMode="colorArrayDropDown"
      datasource="{{ get_ticket_number2.data }}"
      datasourceMode="source"
      gradientColorArray={[
        ["0.0", "{{ theme.canvas }}"],
        ["1.0", "{{ theme.primary }}"],
      ]}
      hoverTemplate="%{label}<br>%{value}<br>%{percent}<extra></extra>"
      hoverTemplateMode="source"
      labelData="{{ get_ticket_number2.data.lag_days }}"
      legendPosition="none"
      lineColor="{{ theme.surfacePrimary }}"
      lineWidth={2}
      pieDataHole={0.4}
      selectedPoints="[]"
      textTemplate="%{label}<br>%{percent}<br>%{value}"
      textTemplateMode="source"
      title={null}
      valueData="{{ get_ticket_number2.data.ticket_cnt}}"
      valueDataMode="source"
    />
  </Frame>
</Screen>
