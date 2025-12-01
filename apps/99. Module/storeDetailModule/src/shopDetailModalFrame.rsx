<ModalFrame
  id="shopDetailModalFrame"
  footerPadding="8px 12px"
  headerPadding="0px 8px"
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
      value={'### {{ selectedRow.value?.shop_nm || "" }}'}
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
      value={'{{ selectedRow.value?.shop_cd || "" }}'}
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Text
      id="text56"
      margin="0px 4px"
      value="###### 매장 기본 정보"
      verticalAlign="center"
    />
    <Include src="./container8.rsx" />
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
          value="{{ shopInfoQuery.data.open_dt[0]}}"
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
            '{{ shopInfoQuery.data.biz_nm.join(0).replace("]", "").replace("[", "")}}'
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
          value="**취급브랜드**"
          verticalAlign="center"
        />
      </Header>
      <View id="5ef41" viewKey="View 1">
        <Text
          id="text11"
          heightType="fill"
          value={
            '{{ shopInfoQuery.data.sub_br_nm.join("").replace("]", "").replace("[", "") }}'
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
          value="{{ shopInfoQuery.data.gb_nm[0] }}"
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
          value="{{ shopInfoQuery.data.area_nm[0] }}"
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
          value="{{ shopInfoQuery.data.team_nm[0]}}"
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
          value="{{ shopInfoQuery?.data.user_nm[0]}}"
          verticalAlign="center"
        />
      </View>
    </Container>
    <Spacer id="spacer15" />
    <Text
      id="text55"
      horizontalAlign="right"
      margin="0"
      value="*조회기간: {{ startDate.value }} ~ {{ endDate.value }}"
      verticalAlign="center"
    />
    <Spacer id="spacer19" />
    <Text
      id="text64"
      margin="0px 4px"
      value="###### 월별 매장 매출 추이"
      verticalAlign="center"
    />
    <Include src="./tabbedContainer1.rsx" />
    <Spacer id="spacer20" />
    <Text
      id="text21"
      margin="0px 4px"
      value="###### 기간별 매출 추이"
      verticalAlign="center"
    />
    <Text
      id="text69"
      margin="0"
      value="###### 매장 판매 지표"
      verticalAlign="center"
    />
    <Text
      id="text48"
      margin="0px 4px"
      value="###### 브랜드별 매출 추이"
      verticalAlign="center"
    />
    <Include src="./timeTabbedContainer.rsx" />
    <Include src="./container9.rsx" />
    <Container
      id="brTabbedContainer"
      currentViewKey="{{ self.viewKeys[0] }}"
      footerPadding="4px 12px"
      headerPadding="0px 4px"
      heightType="fixed"
      margin="0px 2px"
      padding="0"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Tabs
          id="timeUnitSelect2"
          heightType="fixed"
          itemMode="static"
          navigateContainer={true}
          style={{ ordered: [] }}
          styleVariant="lineBottom"
          targetContainerId="brTabbedContainer"
          value="{{ self.values[0] }}"
        >
          <Option id="5fc70" value="Tab 1" />
          <Option id="95bd0" value="Tab 2" />
          <Option id="7c71f" value="Tab 3" />
        </Tabs>
      </Header>
      <View
        id="d2629"
        disabled={false}
        hidden={false}
        iconPosition="left"
        label="매출비중"
        viewKey="pie"
      >
        <Chart
          id="pieChart1"
          chartType="pie"
          colorArray={
            '["#FF7F00","#00C3FF","#FFD500","#6F00FF","#CDFF00","#72E06A"]'
          }
          colorArrayDropDown={[
            "#11B5AE",
            "#4046CA",
            "#F68512",
            "#DE3C82",
            "#7E84FA",
            "#72E06A",
          ]}
          datasource="{{ shopSalesTrendByBrandQuery.data }}"
          datasourceMode="source"
          gradientColorArray={[
            ["0.0", "{{ theme.canvas }}"],
            ["1.0", "{{ theme.primary }}"],
          ]}
          hoverTemplate={null}
          hoverTemplateMode="source"
          labelData="{{ shopSalesTrendByBrandQuery.data.br_cd }}"
          labelDataMode="source"
          legendPosition="none"
          lineColor="{{ theme.surfacePrimary }}"
          lineWidth={2}
          margin="8px 12px"
          pieDataHole={0.4}
          selectedPoints="[]"
          textTemplate="%{label}<br>%{percent}"
          textTemplateMode="source"
          textTemplatePosition="outside"
          title={null}
          valueData="{{ shopSalesTrendByBrandQuery.data.sales_price }}"
          valueDataMode="source"
        />
      </View>
      <View
        id="ea69a"
        disabled={false}
        hidden={false}
        iconPosition="left"
        label="연도별비중추이"
        viewKey="share"
      >
        <Table
          id="table42"
          autoColumnWidth={true}
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ shopSalesTrendByBrandQuery.data }}"
          defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          heightType="auto"
          primaryKeyColumnId="98996"
          rowSelection="none"
          showBorder={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Column
            id="98996"
            alignment="left"
            backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="string"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="br_cd"
            label="브랜드코드"
            placeholder="Enter value"
            position="center"
            size={67.90625}
            summaryAggregationMode="none"
          />
          <Column
            id="6fb91"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            key="2025"
            label="2025"
            placeholder="Enter value"
            position="center"
            size={45.3125}
            summaryAggregationMode="none"
          />
          <Column
            id="fe693"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            key="2024"
            label="2024"
            placeholder="Enter value"
            position="center"
            size={45.546875}
            summaryAggregationMode="none"
          />
          <Column
            id="fad9e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            key="2023"
            label="2023"
            placeholder="Enter value"
            position="center"
            size={45.65625}
            summaryAggregationMode="none"
          />
        </Table>
      </View>
    </Container>
    <Spacer id="spacer3" />
    <Text
      id="text18"
      value="###### 브랜드별 카테고리 매출"
      verticalAlign="center"
    />
    <Spacer id="spacer11" />
    <Text
      id="text49"
      horizontalAlign="right"
      value="단위: 천원"
      verticalAlign="center"
    />
    <Container
      id="brandTabbedContainer"
      currentViewKey="{{ self.viewKeys[0] }}"
      footerPadding="4px 12px"
      headerPadding="0px 4px"
      margin="0"
      padding="0"
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
        <Switch
          id="is_on_sale_detail"
          label="할인상세 살펴보기"
          value="false"
        />
        <Table
          id="table4"
          autoColumnWidth={true}
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ shopSalesByBrandQuery.data }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          heightType="auto"
          margin="0"
          rowBackgroundColor={
            '{{ currentRow.정상구분 === "총계"? theme.tokens.primaryOpacity20: "" }}'
          }
          rowHeight="small"
          rowSelection="none"
          showBorder={true}
          showColumnBorders={true}
          showHeader={true}
          style={{ headerBackground: "tokens/356f4e7b" }}
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
            size={44.640625}
            sortMode="disabled"
            summaryAggregationMode="none"
          />
          <Column
            id="213f6"
            alignment="left"
            format="string"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            key="정상구분"
            label="정상구분"
            placeholder="Enter value"
            position="left"
            size={57.484375}
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
            size={55.5}
            summaryAggregationMode="none"
          />
          <Column
            id="66dd1"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="기초류"
            label="기초류"
            placeholder="Enter value"
            position="center"
            size={55.140625}
            summaryAggregationMode="none"
          />
          <Column
            id="0826d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="외의류"
            label="외의류"
            placeholder="Enter value"
            position="center"
            size={60.046875}
            summaryAggregationMode="none"
          />
          <Column
            id="27a3a"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="시즌용품"
            label="시즌용품"
            placeholder="Enter value"
            position="center"
            size={57.5}
            summaryAggregationMode="none"
          />
          <Column
            id="0886e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="일반용품위탁"
            label="일반용품위탁"
            placeholder="Enter value"
            position="center"
            size={78.21875}
            summaryAggregationMode="none"
          />
          <Column
            id="cd0c3"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="섬유공산품"
            label="섬유공산품"
            placeholder="Enter value"
            position="center"
            size={67.859375}
            summaryAggregationMode="none"
          />
          <Column
            id="06579"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="하드류"
            label="하드류"
            placeholder="Enter value"
            position="center"
            size={48.03125}
            summaryAggregationMode="none"
          />
          <Column
            id="7e4aa"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="발육"
            label="발육"
            placeholder="Enter value"
            position="center"
            size={47.84375}
            summaryAggregationMode="none"
          />
          <Column
            id="e6c75"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="화장품"
            label="화장품"
            placeholder="Enter value"
            position="center"
            size={47.109375}
            summaryAggregationMode="none"
          />
          <Column
            id="23cf1"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            hidden="false"
            key="기타"
            label="기타"
            placeholder="Enter value"
            position="center"
            size={36.734375}
            summaryAggregationMode="none"
          />
          <Column
            id="659fa"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="total"
            label="총합"
            placeholder="Enter value"
            position="right"
            size={61.5625}
            summaryAggregationMode="none"
          />
          <ToolbarButton
            id="3c"
            icon="bold/interface-download-button-2"
            label="엑셀 다운로드"
            type="custom"
          >
            <Event
              event="clickToolbar"
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
              pluginId="excelDownloadshopSalesByBrand"
              type="datasource"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
        </Table>
      </Header>
      <View id="1c9b4" label="전체" viewKey={'"-1"'} />
      <View id="90951" label="아가방" viewKey={'"01"'} />
      <View id="d2422" label="에뜨와" viewKey={'"07"'} />
      <View
        id="e50cd"
        disabled={false}
        hidden={false}
        iconPosition="left"
        label="디즈니"
        viewKey={'"79"'}
      />
    </Container>
    <Spacer id="spacer1" />
    <Spacer id="spacer12" />
    <Text
      id="text20"
      value="###### 상품 재고 및 판매 현황"
      verticalAlign="center"
    />
    <Select
      id="invenBrSelect"
      data={
        '{{ \n(() => {\n  const arrData = shopInfoQuery.data.br_nm[0].slice(1, -1).split(",").map(item => item.trim()).sort((a, b) => a.localeCompare(b, "ko"))\n  arrData.unshift("전체")\n  return arrData\n})()\n}}'
      }
      emptyMessage="No options"
      label=""
      labelPosition="top"
      labels="{{ _.startCase(item) }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="브랜드"
      value={'"아가방"'}
      values="{{ item }}"
    />
    <Text
      id="text59"
      disableMarkdown={true}
      horizontalAlign="right"
      style={{
        ordered: [
          { color: "rgba(70, 70, 70, 1)" },
          { fontSize: "12px" },
          { fontWeight: "500" },
          { fontFamily: "Pretendard variable" },
        ],
      }}
      value="* 괄호 안 숫자는 조회기간 내의 수량"
      verticalAlign="center"
    />
    <Table
      id="inventoryTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopInvenByYear.value }}"
      defaultFilterOperator="or"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableExpandableRows={true}
      enableSaveActions={true}
      groupedColumnConfig={{ size: 152.875, expandByDefault: false }}
      heightType="auto"
      margin="6px 0px"
      primaryKeyColumnId="2ebd0"
      rowHeight="medium"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
    >
      <Include src="./inventoryTblExpandedRow.rsx" />
      <Column
        id="2ebd0"
        alignment="left"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="year_nm"
        label="시즌연도"
        placeholder="Enter value"
        position="center"
        referenceId="year_nm"
        size={0}
        sortMode="disabled"
        summaryAggregationMode="none"
      />
      <Column
        id="d2e0b"
        alignment="right"
        caption="({{ currentSourceRow.period_in_qty.toLocaleString() }})"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="in_qty"
        label="매장입고량"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.in_qty.toLocaleString() }}"
      />
      <Column
        id="88154"
        alignment="right"
        caption="({{ currentSourceRow.period_rt_in_qty.toLocaleString() }})"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="rt_in_qty"
        label="RT물량"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.rt_in_qty.toLocaleString() }}"
      />
      <Column
        id="276cf"
        alignment="right"
        caption="({{ currentSourceRow.period_net_sale_qty.toLocaleString() }})"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sales_qty"
        label="판매수량"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
        tooltip="판매-반품"
        valueOverride="{{ currentSourceRow.net_sales_qty.toLocaleString() }}"
      />
      <Column
        id="33932"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="stock_qty"
        label="재고수량"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="1c2f0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="rtn_qty"
        label="기타반품"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="8f132"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        caption="{{ (currentSourceRow.period_sale_qty / (currentSourceRow.period_in_qty + currentSourceRow.period_rt_in_qty)*100).toFixed(1) }}%"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="매장판매율"
        placeholder="Enter value"
        position="center"
        referenceId="shop_ratio"
        size={0}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.net_sales_qty / (currentSourceRow.stock_qty + currentSourceRow.net_sales_qty) }}"
      />
      <Column
        id="bf41a"
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
        referenceId="tot_ratio"
        size={0}
        summaryAggregationMode="none"
        tooltip="전 매장의 평균판매량을 의미합니다"
        valueOverride="{{ currentSourceRow.tot_sales_qty / (currentSourceRow.tot_stock_qty + currentSourceRow.tot_sales_qty) }}"
      />
      <Column
        id="2083f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="cust_rqty"
        label="고객반품"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="345a6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="adjt_qty"
        label="조정물량"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="bb430"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="판매율차이"
        placeholder="Enter value"
        position="center"
        referenceId="diff"
        size={0}
        summaryAggregationMode="none"
        textColor={
          '{{ currentSourceRow.sales_qty / (currentSourceRow.stock_qty + currentSourceRow.sales_qty) - currentSourceRow.tot_sales_qty / (currentSourceRow.tot_stock_qty + currentSourceRow.tot_sales_qty) > 0? "green": "red" }}'
        }
        valueOverride="{{ currentSourceRow.net_sales_qty / (currentSourceRow.stock_qty + currentSourceRow.net_sales_qty) - currentSourceRow.tot_sales_qty / (currentSourceRow.tot_stock_qty + currentSourceRow.tot_sales_qty) }}"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="엑셀 다운로드"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          params={{
            ordered: [{ options: { ordered: [{ fileType: "xlsx" }] } }],
          }}
          pluginId="inventoryTbl"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</ModalFrame>
