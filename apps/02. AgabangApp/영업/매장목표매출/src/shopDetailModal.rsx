<ModalFrame
  id="shopDetailModal"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="4px 12px"
  showHeader={true}
  showOverlay={true}
  size="fullScreen"
>
  <Header>
    <Text
      id="modalTitle1"
      value="#### {{ selectedShopName.value }}"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton1"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-2"
      style={{ ordered: [{ border: "transparent" }] }}
      styleVariant="outline"
    >
      <Event
        event="click"
        method="setHidden"
        params={{ ordered: [{ hidden: true }] }}
        pluginId="shopDetailModal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="modalTitle2"
      value="{{ selectedShopCode.value }}"
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Text id="text12" value="##### ► 매장정보" verticalAlign="center" />
    <Table
      id="shopInfoTable"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopInfoQuery.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      margin="0"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="600e1"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="매장명"
        label="매장명"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="2d8ec"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="매장코드"
        label="매장코드"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="3f348"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="브랜드코드"
        label="브랜드코드"
        placeholder="Enter value"
        position="center"
        size={67.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="5b277"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="브랜드명"
        label="운영브랜드"
        placeholder="Enter value"
        position="center"
        size={67.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="22398"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="매장거래형태
"
        placeholder="Enter value"
        position="center"
        referenceId="column5"
        size={78.28125}
        summaryAggregationMode="none"
        valueOverride={'{{ shopInfoDetailQuery.data[0]["매장구분명"] }}'}
      />
      <Column
        id="df266"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="매장유형"
        placeholder="Enter value"
        position="center"
        referenceId="매장유형"
        size={57.515625}
        summaryAggregationMode="none"
        valueOverride={'{{ shopInfoDetailQuery.data[0]["매장유형"]}}'}
      />
      <Column
        id="9186f"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="인테리어사양"
        placeholder="Enter value"
        position="center"
        referenceId="인테리어사양"
        size={78.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="a2595"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="인테리어진행시기
"
        placeholder="Enter value"
        position="center"
        referenceId="인테리"
        size={99.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="e784d"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="평수"
        placeholder="Enter value"
        position="center"
        referenceId="평수"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="454f0"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="24년월평균매출"
        placeholder="Enter value"
        position="center"
        referenceId="24년월평균매출"
        size={93.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="b8901"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="23년월평균매출"
        placeholder="Enter value"
        position="center"
        referenceId="23년월평균매출"
        size={93.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="66f95"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="신장율"
        placeholder="Enter value"
        position="center"
        referenceId="신장율"
        size={47.140625}
        summaryAggregationMode="none"
      />
      <Column
        id="b343f"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="등급"
        placeholder="Enter value"
        position="center"
        referenceId="등급"
        size={36.75}
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
          pluginId="shopInfoTable"
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
          pluginId="shopInfoTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text id="text13" value="##### ► 연도별매출" verticalAlign="center" />
    <Container
      id="container7"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle7"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="f313e" viewKey="View 1">
        <Table
          id="table5"
          autoColumnWidth={true}
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ shopYearlyRevenueQuery.data }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          margin="0"
          showBorder={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Column
            id="f0dd5"
            alignment="left"
            editableOptions={{ showStepper: true }}
            format="string"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="sales_year"
            label="실적연도"
            placeholder="Enter value"
            position="center"
            size={57.515625}
            summaryAggregationMode="none"
          />
          <Column
            id="6414a"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="q1"
            label="Q 1"
            placeholder="Enter value"
            position="center"
            size={36.28125}
            summaryAggregationMode="none"
          />
          <Column
            id="a93d9"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="q2"
            label="Q 2"
            placeholder="Enter value"
            position="center"
            size={36.28125}
            summaryAggregationMode="none"
          />
          <Column
            id="95aeb"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="q3"
            label="Q 3"
            placeholder="Enter value"
            position="center"
            size={36.28125}
            summaryAggregationMode="none"
          />
          <Column
            id="ed880"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="q4"
            label="Q 4"
            placeholder="Enter value"
            position="center"
            size={36.28125}
            summaryAggregationMode="none"
          />
          <Column
            id="abb32"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="total"
            label="합계"
            placeholder="Enter value"
            position="center"
            size={36.75}
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
              pluginId="table5"
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
              pluginId="table5"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
        </Table>
      </View>
    </Container>
    <Chart
      id="shopMonthlySalesBarChart"
      barGap="0.1"
      barMode="group"
      legendPosition="none"
      selectedPoints="[]"
      stackedBarTotalsDataLabelPosition="none"
      style={{ componentBackgroundColor: "rgb(255, 255, 255)" }}
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
      yAxisTickFormatMode="gui"
    >
      <Series
        id="0"
        aggregationType="sum"
        colorArray={{ array: ["{{ theme.primary }}"] }}
        colorArrayDropDown={{ array: ["{{ theme.primary }}"] }}
        colorInputMode="colorArrayDropDown"
        connectorLineColor="#000000"
        dataLabelPosition="none"
        datasource="{{ shopSalesMonthlyQuery.data }}"
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
        markerColor="{{ theme.success }}"
        markerSize={6}
        markerSymbol="circle"
        name="월별 매장 매출"
        showMarkers={false}
        textTemplate="%{y}"
        textTemplateMode="source"
        type="bar"
        waterfallBase={0}
        waterfallMeasures={null}
        waterfallMeasuresMode="source"
        xData="{{ shopSalesMonthlyQuery.data.year_month }}"
        xDataMode="source"
        yAxis="y"
        yData="{{ shopSalesMonthlyQuery.data.판매금액 }}"
        yDataMode="source"
        zData={null}
        zDataMode="manual"
      />
    </Chart>
    <Text id="text14" value="##### ► 카테고리별매출" verticalAlign="center" />
    <Container
      id="container8"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      heightType="fixed"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle8"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="f313e" viewKey="View 1">
        <Table
          id="table6"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ shopSalesByCategoryQuery.data }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          margin="0"
          primaryKeyColumnId="e352c"
          showBorder={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Column
            id="e352c"
            alignment="left"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="string"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="연도"
            label="연도"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="04561"
            alignment="left"
            format="tag"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            key="정상구분"
            label="정상구분"
            placeholder="Select option"
            position="center"
            size={100}
            summaryAggregationMode="none"
            valueOverride="{{ _.startCase(item) }}"
          />
          <Column
            id="25fed"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="미분류"
            label="미분류"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="5ff92"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="SET"
            label="Set"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="041a2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="TOP"
            label="Top"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="1c811"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="토들러"
            label="토들러"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="eea9a"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="기획내의"
            label="기획내의"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="9f450"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="신발"
            label="신발"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="f3f1d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="BOTTOM"
            label="Bottom"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="4018d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="기획외의"
            label="기획외의"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="b537e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="OUTER"
            label="Outer"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="95c19"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="선물세트"
            label="선물세트"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="5b26b"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="내의"
            label="내의"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="4514e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="우주복"
            label="우주복"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="1bdf4"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="유아복"
            label="유아복"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="2b6c4"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="기초복"
            label="기초복"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="567b7"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="조끼"
            label="조끼"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="d3ded"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="배내류"
            label="배내류"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="8efcf"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="바디수트"
            label="바디수트"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="da171"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="기타"
            label="기타"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="620a0"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="기초ACC"
            label="기초acc"
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
              pluginId="table6"
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
              pluginId="table6"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
        </Table>
      </View>
    </Container>
    <Text id="text17" value="##### ► " verticalAlign="center" />
  </Body>
  <Event
    event="show"
    method="trigger"
    params={{ ordered: [] }}
    pluginId="shopSalesQuery"
    type="datasource"
    waitMs="0"
    waitType="debounce"
  />
</ModalFrame>
