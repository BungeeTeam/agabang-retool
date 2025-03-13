<ModalFrame
  id="shopDetailModalFrame"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
  size="fullScreen"
>
  <Header>
    <Text
      id="head"
      value="### {{ selectedRow.value.shop_nm }}"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton1"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ ordered: [{ border: "transparent" }] }}
      styleVariant="outline"
    >
      <Event
        event="click"
        method="setHidden"
        params={{ ordered: [{ hidden: true }] }}
        pluginId="shopDetailModalFrame"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method=""
        params={{ ordered: [] }}
        pluginId=""
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text8"
      value="{{ selectedRow.value.shop_cd }}"
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Container
      id="container1"
      _direction="vertical"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      heightType="fixed"
      margin="0px 1px"
      padding="0"
      showBody={true}
      showHeader={true}
      style={{ ordered: [{ headerBackground: "primary" }] }}
    >
      <Header>
        <Text
          id="containerTitle1"
          horizontalAlign="center"
          value="**개점일**"
          verticalAlign="center"
        />
      </Header>
      <View id="5ef41" viewKey="View 1">
        <Text
          id="text9"
          heightType="fill"
          value={'{{ shopInfoQuery.data?.open_dt?.at(0) || ""}}'}
          verticalAlign="center"
        />
      </View>
    </Container>
    <Container
      id="container2"
      _direction="vertical"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      heightType="fixed"
      margin="0px 1px"
      padding="0"
      showBody={true}
      showHeader={true}
      style={{ ordered: [{ headerBackground: "primary" }] }}
    >
      <Header>
        <Text
          id="containerTitle2"
          horizontalAlign="center"
          value="**사업부**"
          verticalAlign="center"
        />
      </Header>
      <View id="5ef41" viewKey="View 1">
        <Text
          id="text10"
          heightType="fill"
          value={
            '{{ shopInfoQuery.data?.biz_nm?.join(0).replace("]", "").replace("[", "") || ""}}'
          }
          verticalAlign="center"
        />
      </View>
    </Container>
    <Container
      id="container3"
      _direction="vertical"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      heightType="fixed"
      margin="0px 1px"
      padding="0"
      showBody={true}
      showHeader={true}
      style={{ ordered: [{ headerBackground: "primary" }] }}
    >
      <Header>
        <Text
          id="containerTitle3"
          horizontalAlign="center"
          value="**운영브랜드**"
          verticalAlign="center"
        />
      </Header>
      <View id="5ef41" viewKey="View 1">
        <Text
          id="text11"
          heightType="fill"
          value={
            '{{ shopInfoQuery.data?.br_nm?.join("").replace("]", "").replace("[", "") || ""}}'
          }
          verticalAlign="center"
        />
      </View>
    </Container>
    <Container
      id="container4"
      _direction="vertical"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      heightType="fixed"
      margin="0px 1px"
      padding="0"
      showBody={true}
      showHeader={true}
      style={{ ordered: [{ headerBackground: "primary" }] }}
    >
      <Header>
        <Text
          id="containerTitle4"
          horizontalAlign="center"
          value="**거래형태**"
          verticalAlign="center"
        />
      </Header>
      <View id="5ef41" viewKey="View 1">
        <Text
          id="text12"
          heightType="fill"
          value={'{{ shopInfoQuery.data?.gb_nm?.at(0) || ""}}'}
          verticalAlign="center"
        />
      </View>
    </Container>
    <Container
      id="container7"
      _direction="vertical"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      heightType="fixed"
      margin="0px 1px"
      padding="0"
      showBody={true}
      showHeader={true}
      style={{ ordered: [{ headerBackground: "primary" }] }}
    >
      <Header>
        <Text
          id="containerTitle7"
          horizontalAlign="center"
          value="**지역**"
          verticalAlign="center"
        />
      </Header>
      <View id="5ef41" viewKey="View 1">
        <Text
          id="text15"
          heightType="fill"
          value={'{{ shopInfoQuery.data?.area_nm?.at(0) || ""}}'}
          verticalAlign="center"
        />
      </View>
    </Container>
    <Container
      id="container5"
      _direction="vertical"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      heightType="fixed"
      margin="0px 1px"
      padding="0"
      showBody={true}
      showHeader={true}
      style={{ ordered: [{ headerBackground: "primary" }] }}
    >
      <Header>
        <Text
          id="containerTitle5"
          horizontalAlign="center"
          value="**담당조직**"
          verticalAlign="center"
        />
      </Header>
      <View id="5ef41" viewKey="View 1">
        <Text
          id="text13"
          heightType="fill"
          value={'{{ shopInfoQuery.data?.team_nm?.at(0) || ""}}'}
          verticalAlign="center"
        />
      </View>
    </Container>
    <Container
      id="container6"
      _direction="vertical"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      heightType="fixed"
      margin="0px 1px"
      padding="0"
      showBody={true}
      showHeader={true}
      style={{ ordered: [{ headerBackground: "primary" }] }}
    >
      <Header>
        <Text
          id="containerTitle6"
          horizontalAlign="center"
          value="**담당자**"
          verticalAlign="center"
        />
      </Header>
      <View id="5ef41" viewKey="View 1">
        <Text
          id="text14"
          heightType="fill"
          value={'{{ shopInfoQuery.data?.user_nm?.at(0) || ""}}'}
          verticalAlign="center"
        />
      </View>
    </Container>
    <Text id="text21" value="###### 월별 매출 추이" verticalAlign="center" />
    <Text id="text17" value="###### 분기별 매출 추이" verticalAlign="center" />
    <Chart
      id="plotlyJsonChart1"
      chartType="plotlyJson"
      plotlyDataJson={
        '[\n  {\n    "x": {{ shopSalesMonthlyQuery.data.year_month }},\n    "y": {{ shopSalesMonthlyQuery.data.판매금액 }},\n    "type": "bar",\n    "marker": {\n      "color": "01488F",\n      "opacity": 1\n    }\n  },\n  {\n    x: {{ shopTargetSalesMonthlyQuery.data.year_month }},\n    y: {{ shopTargetSalesMonthlyQuery.data.목표매출 }},\n    type: "scatter",\n    mode: "lines",\n    line: {\n      color: "red",\n      width: 2\n    }\n  }\n]'
      }
      plotlyLayoutJson={
        '{\n  "margin": {\n    "l": 30,\n    "r": 0,\n    "t": 0,\n    "b": 30\n  },\n  showlegend: false,\n  "autosize": false,\n  "axis": {\n    type: "date"\n  }\n}'
      }
      selectedPoints="[]"
    />
    <Table
      id="table1"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopSalesQuaterlyQuery.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      margin="4px 4px"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="18617"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sales_year"
        label="연도"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="23738"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="q1"
        label="Q 1"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="63127"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="q2"
        label="Q 2"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="d01c8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="q3"
        label="Q 3"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="c66d8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="q4"
        label="Q 4"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="050aa"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total"
        label="합계"
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
          pluginId="table1"
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
          pluginId="table1"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text
      id="text18"
      value="###### 브랜드별 카테고리 매출"
      verticalAlign="center"
    />
    <Container
      id="brandTabbedContainer"
      currentViewKey="{{ self.viewKeys[0] }}"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      heightType="fixed"
      margin="4px 4px 4px 0px"
      padding="0"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Tabs
          id="tabs1"
          itemMode="static"
          navigateContainer={true}
          style={{ ordered: [] }}
          targetContainerId="brandTabbedContainer"
          value="{{ self.values[0] }}"
        >
          <Option id="f64e5" value="Tab 1" />
          <Option id="c6038" value="Tab 2" />
          <Option id="529b5" value="Tab 3" />
        </Tabs>
        <Table
          id="table4"
          autoColumnWidth={true}
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ shopSalesByBrandQuery.data }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          margin="0"
          rowSelection="none"
          showBorder={true}
          showColumnBorders={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Column
            id="7e3bb"
            alignment="left"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="string"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="연도"
            label="연도"
            placeholder="Enter value"
            position="left"
            size={36.75}
            summaryAggregationMode="none"
          />
          <Column
            id="213f6"
            alignment="center"
            format="tag"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            key="정상구분"
            label="정상구분"
            placeholder="Select option"
            position="left"
            size={57.515625}
            summaryAggregationMode="none"
            valueOverride="{{ _.startCase(item) }}"
          />
          <Column
            id="bee46"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="일반용품"
            label="일반용품"
            placeholder="Enter value"
            position="center"
            size={57.515625}
            summaryAggregationMode="none"
          />
          <Column
            id="fe505"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="유아복"
            label="유아복"
            placeholder="Enter value"
            position="center"
            size={47.125}
            summaryAggregationMode="none"
          />
          <Column
            id="1ec87"
            alignment="center"
            backgroundColor="rgba(1, 72, 143, 0)"
            cellTooltip="{{ item }}"
            cellTooltipMode="custom"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="ratio"
            label="비중"
            placeholder="Enter value"
            position="right"
            referenceId="비중"
            size={36.75}
            summaryAggregationMode="none"
            textColor="rgb(1, 72, 143)"
          />
          <Column
            id="659fa"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="total"
            label="총합"
            placeholder="Enter value"
            position="right"
            size={36.75}
            summaryAggregationMode="none"
            textColor="#01488f"
          />
          <Column
            id="0d148"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="기초복(아동)"
            label="기초복 아동"
            placeholder="Enter value"
            position="center"
            size={71.265625}
            summaryAggregationMode="none"
          />
          <Column
            id="27a3a"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="시즌용품"
            label="시즌용품"
            placeholder="Enter value"
            position="center"
            size={57.515625}
            summaryAggregationMode="none"
          />
          <Column
            id="8b5f1"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="기획"
            label="기획"
            placeholder="Enter value"
            position="center"
            size={36.75}
            summaryAggregationMode="none"
          />
          <Column
            id="8e27b"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="터들러"
            label="터들러"
            placeholder="Enter value"
            position="center"
            size={47.125}
            summaryAggregationMode="none"
          />
          <Column
            id="0886e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="일반용품위탁"
            label="일반용품위탁"
            placeholder="Enter value"
            position="center"
            size={78.28125}
            summaryAggregationMode="none"
          />
          <Column
            id="e6970"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="실내복(주니어)"
            label="실내복 주니어"
            placeholder="Enter value"
            position="center"
            size={81.65625}
            summaryAggregationMode="none"
          />
          <Column
            id="551b2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="판촉/부자재"
            label="판촉 부자재"
            placeholder="Enter value"
            position="center"
            size={71.265625}
            summaryAggregationMode="none"
          />
        </Table>
      </Header>
      <View id="1c9b4" label="전체" viewKey={'"-1"'} />
      <View id="90951" label="아가방" viewKey={'"01"'} />
      <View id="d2422" label="에뜨와" viewKey={'"07"'}>
        <Table
          id="table3"
          autoColumnWidth={true}
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ shopSalesByBrandQuery.data }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          margin="0"
          primaryKeyColumnId="7e3bb"
          rowSelection="none"
          showBorder={true}
          showColumnBorders={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Column
            id="7e3bb"
            alignment="left"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="string"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="연도"
            label="연도"
            placeholder="Enter value"
            position="left"
            size={36.765625}
            summaryAggregationMode="none"
          />
          <Column
            id="213f6"
            alignment="center"
            format="tag"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            key="정상구분"
            label="정상구분"
            placeholder="Select option"
            position="left"
            size={57.515625}
            summaryAggregationMode="none"
            valueOverride="{{ _.startCase(item) }}"
          />
          <Column
            id="9a324"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="조끼"
            label="조끼"
            placeholder="Enter value"
            position="center"
            size={36.765625}
            summaryAggregationMode="none"
          />
          <Column
            id="2c376"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="팬티"
            label="팬티"
            placeholder="Enter value"
            position="center"
            size={36.765625}
            summaryAggregationMode="none"
          />
          <Column
            id="c76d4"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="BOTTOM"
            label="Bottom"
            placeholder="Enter value"
            position="center"
            size={57.21875}
            summaryAggregationMode="none"
          />
          <Column
            id="4d449"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="TOP"
            label="Top"
            placeholder="Enter value"
            position="center"
            size={37.21875}
            summaryAggregationMode="none"
          />
          <Column
            id="e7e2b"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="신발"
            label="신발"
            placeholder="Enter value"
            position="center"
            size={36.765625}
            summaryAggregationMode="none"
          />
          <Column
            id="32ad4"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="양말"
            label="양말"
            placeholder="Enter value"
            position="center"
            size={36.765625}
            summaryAggregationMode="none"
          />
          <Column
            id="3ac06"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="미분류"
            label="미분류"
            placeholder="Enter value"
            position="center"
            size={47.140625}
            summaryAggregationMode="none"
          />
          <Column
            id="13847"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="SET"
            label="Set"
            placeholder="Enter value"
            position="center"
            size={35}
            summaryAggregationMode="none"
          />
          <Column
            id="5860d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="OUTER"
            label="Outer"
            placeholder="Enter value"
            position="center"
            size={47.859375}
            summaryAggregationMode="none"
          />
          <Column
            id="b2676"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="런닝"
            label="런닝"
            placeholder="Enter value"
            position="center"
            size={36.765625}
            summaryAggregationMode="none"
          />
          <Column
            id="5d9e6"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="기타"
            label="기타"
            placeholder="Enter value"
            position="center"
            size={36.765625}
            summaryAggregationMode="none"
          />
          <Column
            id="9a40d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="배내류"
            label="배내류"
            placeholder="Enter value"
            position="center"
            size={47.140625}
            summaryAggregationMode="none"
          />
          <Column
            id="1aeeb"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="우주복"
            label="우주복"
            placeholder="Enter value"
            position="center"
            size={47.140625}
            summaryAggregationMode="none"
          />
          <Column
            id="b5395"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="선물세트"
            label="선물세트"
            placeholder="Enter value"
            position="center"
            size={57.515625}
            summaryAggregationMode="none"
          />
          <Column
            id="65a9a"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="모자"
            label="모자"
            placeholder="Enter value"
            position="center"
            size={36.765625}
            summaryAggregationMode="none"
          />
          <Column
            id="98251"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="내의"
            label="내의"
            placeholder="Enter value"
            position="center"
            size={36.765625}
            summaryAggregationMode="none"
          />
          <Column
            id="a1ebd"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="바디수트"
            label="바디수트"
            placeholder="Enter value"
            position="center"
            size={57.515625}
            summaryAggregationMode="none"
          />
          <Column
            id="4510a"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="수영복"
            label="수영복"
            placeholder="Enter value"
            position="center"
            size={47.140625}
            summaryAggregationMode="none"
          />
          <Column
            id="b0cb2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="섬유"
            label="섬유"
            placeholder="Enter value"
            position="center"
            size={36.765625}
            summaryAggregationMode="none"
          />
          <Column
            id="9b55d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="우비"
            label="우비"
            placeholder="Enter value"
            position="center"
            size={36.765625}
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
              pluginId="table3"
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
              pluginId="table3"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
        </Table>
      </View>
      <View
        id="e50cd"
        disabled={false}
        hidden={false}
        iconPosition="left"
        label="디즈니"
        viewKey={'"79"'}
      />
    </Container>
    <Text
      id="text20"
      value="###### 상품 재고 및 판매 현황"
      verticalAlign="center"
    />
    <Table
      id="table6"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopInventoryQuery.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="3d667"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="d6c92"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="season_nm"
        label="계절"
        placeholder="Enter value"
        position="center"
        size={47.140625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="3d667"
        alignment="left"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="sum"
        key="year_nm"
        label="연도"
        placeholder="Select option"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="dea64"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="season_nm"
        label="시즌"
        placeholder="Select option"
        position="center"
        referenceId="column9"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="c9da4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="in_qty"
        label="입고량"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="b9dcd"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sales_qty"
        label="판매량"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="d147f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="inventory"
        label="재고량"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
      />
      <Column
        id="7eeff"
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
        label="매장판매율"
        placeholder="Enter value"
        position="center"
        size={67.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="de350"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="전체판매율"
        placeholder="Enter value"
        position="center"
        referenceId="전체"
        size={67.890625}
        summaryAggregationMode="none"
        valueOverride="{{ totalInventoryQuery.data[i].ratio }}"
      />
      <Column
        id="9956b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="차이"
        placeholder="Enter value"
        position="center"
        referenceId="차이"
        size={36.75}
        summaryAggregationMode="none"
        textColor={'{{ item >= 0? "green": "red" }}'}
        valueOverride="{{ shopInventoryQuery.data.ratio[i] - totalInventoryQuery.data[i].ratio }}"
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
  </Body>
</ModalFrame>
