<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <DocumentTitle id="$customDocumentTitle" value="정상 매출현황" />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrameShopSalesByCategory.rsx" />
  <Include src="./src/modalFrameShopSalesBySummary.rsx" />
  <Include src="./sidebar.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="0"
    sticky={null}
    type="main"
  >
    <ListViewBeta
      id="listView1"
      _primaryKeys=""
      data="{{ periodList.value[select1.value] }}"
      hidden="{{ select1.value === 'period' }}"
      itemWidth="200px"
      margin="0"
      numColumns={3}
      padding="0"
    >
      <Container
        id="container6"
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
          <Text
            id="containerTitle1"
            value="##### {{ item }} {{ select1.value === 'month_unit' ? '월' :'분기' }}"
            verticalAlign="center"
          />
        </Header>
        <View id="5bfbf" viewKey="View 1">
          <Table
            id="table2"
            autoColumnWidth={true}
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ select1.value === 'month_unit' ? monthly.value.filter(i => i.month_unit === item):quarterly.value.filter(i => i.quarter_unit === item)}}"
            defaultSelectedRow={{
              mode: "index",
              indexType: "display",
              index: 0,
            }}
            emptyMessage="{{ periodicSalesByStyleQuery.isFetching ? '데이터를 불러오는 중입니다' :'데이터가 없습니다' }}"
            enableSaveActions={true}
            heightType="auto"
            margin="0"
            rowBackgroundColor="{{ currentSourceRow.category_name === '소계' ? '01488f33' :
  currentSourceRow.category_name === '총계' ? '01488f60' :
  'ffffff' }}"
            rowHeight="small"
            rowSelection="none"
            showBorder={true}
            showFooter={true}
            showHeader={true}
          >
            <Column
              id="b0152"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              key="season_nm"
              label="시즌"
              placeholder="Enter value"
              position="center"
              size={47.140625}
              summaryAggregationMode="none"
            />
            <Column
              id="45fd6"
              alignment="left"
              format="string"
              formatOptions={{ automaticColors: true }}
              groupAggregationMode="none"
              key="category_name"
              label="대분류"
              placeholder="Enter value"
              position="center"
              size={57.515625}
              summaryAggregationMode="none"
              valueOverride="{{ _.startCase(item) }}"
            />
            <Column
              id="0db0c"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              hidden="{{!checkboxTreeNew1.value.includes(checkboxTreeNew1.values[1]) }}"
              label="{{ checkboxTreeNew1.values[1] }}"
              placeholder="Enter value"
              position="center"
              referenceId="rev_goal"
              size={57.515625}
              summaryAggregationMode="none"
            />
            <Column
              id="c5d5d"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="{{ !checkboxTreeNew1.value.includes( checkboxTreeNew1.values[2]) }}"
              key="cur_rev"
              label="{{ checkboxTreeNew1.values[2] }}"
              placeholder="Enter value"
              position="center"
              referenceId="cur_rev"
              size={79.828125}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000).toFixed(0) }}"
            />
            <Column
              id="62cc1"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="average"
              hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[3]) }}"
              key="cur_tag"
              label="{{ checkboxTreeNew1.values[3] }}"
              placeholder="Enter value"
              position="center"
              size={90.21875}
              summaryAggregationMode="none"
              valueOverride="{{ 1-currentSourceRow.cur_rev/item }}"
            />
            <Column
              id="c21f5"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[4]) }}"
              key="prev_rev"
              label="{{ checkboxTreeNew1.values[4] }}"
              placeholder="Enter value"
              position="center"
              referenceId="{{ checkboxTreeNew1.values[4] }}"
              size={80.0625}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000).toFixed(0) }}"
            />
            <Column
              id="f9e44"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="average"
              hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[5]) }}"
              key="prev_tag"
              label="{{checkboxTreeNew1.values[5]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{checkboxTreeNew1.values[5]}}"
              size={90.4375}
              summaryAggregationMode="none"
              valueOverride="{{ 1-(currentSourceRow.prev_rev/item) }}"
            />
            <Column
              id="03295"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[6]) }}"
              label="{{checkboxTreeNew1.values[6]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{checkboxTreeNew1.values[6]}}"
              size={57.515625}
              summaryAggregationMode="none"
              valueOverride="{{ ((currentSourceRow.cur_rev-currentSourceRow.prev_rev)/1000000).toFixed(0) }}"
            />
            <Column
              id="4fe2f"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              hidden="{{!checkboxTreeNew1.value.includes(checkboxTreeNew1.values[7]) }}"
              label="{{ checkboxTreeNew1.values[7] }}"
              placeholder="Enter value"
              position="center"
              referenceId="{{ checkboxTreeNew1.values[7] }}"
              size={47.140625}
              summaryAggregationMode="none"
            />
            <Column
              id="cbaee"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="average"
              hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[8]) }}"
              label="{{checkboxTreeNew1.values[8]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{checkboxTreeNew1.values[8]}}"
              size={47.140625}
              summaryAggregationMode="none"
              valueOverride="{{ ratio = currentSourceRow.prev_rev === 0 
  ? 0 
  : currentSourceRow.cur_rev / currentSourceRow.prev_rev }}"
            />
            <Column
              id="afb07"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[10]) }}"
              key="cur_cost"
              label="{{checkboxTreeNew1.values[10]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{checkboxTreeNew1.values[10]}}"
              size={79.828125}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000).toFixed(0) }}"
            />
            <Column
              id="7562d"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="average"
              hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[11]) }}"
              label="{{checkboxTreeNew1.values[11]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{checkboxTreeNew1.values[11]}}"
              size={90.21875}
              summaryAggregationMode="none"
              valueOverride="{{ currentSourceRow.cur_cost/currentSourceRow.cur_tag }}"
            />
            <Column
              id="6262b"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[12]) }}"
              key="prev_cost"
              label="{{checkboxTreeNew1.values[12]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{checkboxTreeNew1.values[12]}}"
              size={80.0625}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000).toFixed(0) }}"
            />
            <Column
              id="70b98"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="average"
              hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[13]) }}"
              key="prev_cost"
              label="{{checkboxTreeNew1.values[13]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{checkboxTreeNew1.values[13]}}"
              size={90.4375}
              summaryAggregationMode="none"
              valueOverride="{{ currentSourceRow.prev_cost/currentSourceRow.prev_tag }}"
            />
            <Column
              id="d68b5"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[14]) }}"
              label="{{checkboxTreeNew1.values[14]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{checkboxTreeNew1.values[14]}}"
              size={57.515625}
              summaryAggregationMode="none"
              valueOverride="{{ ((currentSourceRow.cur_cost-currentSourceRow.prev_cost)/1000000).toFixed(0) }}"
            />
            <Column
              id="0a7ee"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="average"
              hidden="{{ !checkboxTreeNew1.value.includes(checkboxTreeNew1.values[15]) }}"
              label="{{checkboxTreeNew1.values[15]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{checkboxTreeNew1.values[15]}}"
              size={67.90625}
              summaryAggregationMode="none"
              valueOverride="{{ (currentSourceRow.cur_cost/currentSourceRow.cur_tag)-(currentSourceRow.prev_cost/currentSourceRow.prev_tag) }}"
            />
            <Column
              id="c1ed1"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="true"
              key="month_unit"
              label="Month unit"
              placeholder="Enter value"
              position="center"
              size={77.015625}
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
                method="exportData"
                params={{
                  ordered: [
                    {
                      options: {
                        ordered: [
                          { fileType: "xlsx" },
                          {
                            fileName:
                              "({{ dateRange.value.end}} 마감) 정상/이월 판매데이터",
                          },
                          { includeHiddenColumns: false },
                        ],
                      },
                    },
                  ],
                }}
                pluginId="table2"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
            </ToolbarButton>
            <Event
              event="selectRow"
              method="setValue"
              params={{ ordered: [{ value: "{{ current_user }}" }] }}
              pluginId="periodList"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
          </Table>
        </View>
      </Container>
    </ListViewBeta>
    <Tabs
      id="select1"
      alignment="justify"
      hidden="true"
      itemMode="static"
      value="'period'"
    >
      <Option
        id="5c723"
        disabled={false}
        hidden={false}
        label="기간선택"
        value="period"
      />
      <Option id="761d0" label="월" value="month_unit" />
      <Option id="7a1e7" label="분기" value="quarter_unit" />
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="shopSalesBySummary"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="scrollToIndex"
        params={{ ordered: [{ index: "0" }] }}
        pluginId="listView1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Tabs>
    <Include src="./src/container5.rsx" />
  </Frame>
</App>
