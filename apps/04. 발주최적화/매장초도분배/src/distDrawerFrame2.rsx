<DrawerFrame
  id="distDrawerFrame2"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showFooter={true}
  showHeader={true}
  showOverlay={true}
  width="60%"
>
  <Header>
    <Text
      id="drawerTitle3"
      value="###### {{ selectedRow2.value.sty_nm }} / {{ selectedRow2.value.col_nm }} / {{ selectedRow2.value.size_nm }} 매장분배 상세"
      verticalAlign="center"
    />
    <Button
      id="drawerCloseButton3"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      loading=""
      style={{ ordered: [{ border: "transparent" }] }}
      styleVariant="outline"
    >
      <Event
        event="click"
        method="setHidden"
        params={{ ordered: [{ hidden: true }] }}
        pluginId="distDrawerFrame2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text42"
      value="{{ selectedRow2.value.sty_cd }} / {{ selectedRow2.value.col_cd }} / {{ selectedRow2.value.size_cd }}"
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Text id="text43" value="**지난 시즌 참고 정보**" verticalAlign="center" />
    <Text
      id="text44"
      value={
        '{{ JSON.stringify(distPlan2?.value.find(obj => obj.sty_cd === selectedRow2.value?.sty_cd || "")?.related_info || {}) }}'
      }
      verticalAlign="center"
    />
    <Text id="text45" value="**매장 관련 통계**" verticalAlign="center" />
    <Container
      id="container4"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
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
      <View id="be7b9" viewKey="View 1">
        <Chart
          id="plotlyJsonChart3"
          chartType="plotlyJson"
          plotlyDataJson={
            '[\n  {\n    "x": {{ Object.keys(distPlan2?.value?.find(obj => obj.sty_cd === selectedRow2.value?.sty_cd)?.distByQty || {}) }},\n    "y": {{ Object.values(distPlan2?.value?.find(obj => obj.sty_cd === selectedRow2.value?.sty_cd)?.distByQty || {}) }},\n    "mode": "markers",\n    "type": "bar"\n  }\n]'
          }
          plotlyLayoutJson={
            '{\n    "title": {\n      text: "매장 판매량 분포",\n      y: 0.95,\n      yanchor: "top",\n      font: {\n        size: 12\n      }\n    },\n    "margin": { l: 25, r: 25, t: 25, b: 25 }\n}'
          }
          selectedPoints="[]"
        />
        <Chart
          id="plotlyJsonChart4"
          chartType="plotlyJson"
          plotlyDataJson={
            '[\n  {\n    "x": {{ Object.keys(distPlan2.value.find(obj => obj.sty_cd === selectedRow2.value.sty_cd)?.distByRatio || {}) }},\n    "y": {{ Object.values(distPlan2.value.find(obj => obj.sty_cd === selectedRow2.value.sty_cd)?.distByRatio || {}) }},\n    "mode": "markers",\n    "type": "bar"\n  }\n]'
          }
          plotlyLayoutJson={
            '{\n    "title": {\n      text: "매장 판매율 분포",\n      y: 0.95,\n      yanchor: "top",\n      font: {\n        size: 12\n      }\n    },\n    "margin": { l: 25, r: 25, t: 25, b: 25 }\n}'
          }
          selectedPoints="[]"
        />
      </View>
    </Container>
    <Text id="text46" value="**초도 분배 수량**" verticalAlign="center" />
    <Text
      id="text51"
      value="초기 기획 물량: {{ distPlan2.value.find(obj => obj.sty_cd === selectedRow2.value.sty_cd && obj.col_cd === selectedRow2.value.col_cd && obj.size_cd === selectedRow2.value.size_cd).plan_qty }}"
      verticalAlign="center"
    />
    <Text
      id="text56"
      value="물류 제외 분배 물량: {{ distPlan2.value.find(obj => obj.sty_cd === selectedRow2.value.sty_cd && obj.col_cd === selectedRow2.value.col_cd && obj.size_cd === selectedRow2.value.size_cd).actualPlanQty }}"
      verticalAlign="center"
    />
    <Table
      id="table9"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ distPlan2.value.find(obj => obj.sty_cd === selectedRow2.value?.sty_cd && obj.col_cd === selectedRow2.value.col_cd && obj.size_cd === selectedRow2.value.size_cd)?.distStrategy }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      margin="0"
      showBorder={true}
      showHeader={true}
      showSummaryRow={true}
    >
      <Column
        id="c6cd3"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="shop_cd"
        label="매장코드"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="countDistinct"
      />
      <Column
        id="f17de"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="center"
        size={143}
        summaryAggregationMode="none"
      />
      <Column
        id="b280f"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="biz_nm"
        label="사업부"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="33a5f"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="유통채널명"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="7bdeb"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="team_nm"
        label="팀명"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="038fc"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="user_nm"
        label="담당자명"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="606f5"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="area_nm"
        label="지역명"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="8bbac"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="segment"
        label="매장분류"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="24a19"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="in_qty"
        label="입고물량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="sum"
      />
      <Column
        id="28b4c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sales_qty"
        label="판매물량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="sum"
      />
      <Column
        id="f6284"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="ratio"
        label="판매율"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="00029"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="plan_qty"
        label="분배수량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="sum"
        valueOverride="{{ item || null }}"
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
          pluginId="table9"
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
          pluginId="table9"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</DrawerFrame>
