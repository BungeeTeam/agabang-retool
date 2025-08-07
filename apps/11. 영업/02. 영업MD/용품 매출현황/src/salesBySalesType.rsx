<Screen
  id="salesBySalesType"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title={null}
  urlSlug=""
>
  <JavascriptQuery
    id="setValue"
    notificationDuration={4.5}
    query={include("../lib/setValue.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="periodicSalesByStyleQuery"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </JavascriptQuery>
  <Function
    id="getSalesData"
    funcBody={include("../lib/getSalesData.js", "string")}
  />
  <Function id="monthly" funcBody={include("../lib/monthly.js", "string")} />
  <Function
    id="quarterly"
    funcBody={include("../lib/quarterly.js", "string")}
  />
  <Function id="periodic" funcBody={include("../lib/periodic.js", "string")} />
  <SqlQuery
    id="periodicTargetSales"
    enableTransformer={true}
    query={include("../lib/periodicTargetSales.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)

// by biz_div
arrData = arrData.filter(item => {{ bizMultiSelect2.value }}.includes(item.biz_cd))                       


return formatDataAsObject(arrData)"
    warningCodes={[]}
  />
  <SqlQueryUnified
    id="targetRate"
    query={include("../lib/targetRate.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    warningCodes={[]}
  />
  <Function
    id="targetSalesBySalesType"
    funcBody={include("../lib/targetSalesBySalesType.js", "string")}
  />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  />
  <Frame
    id="$main3"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="0"
    sticky={null}
    type="main"
  >
    <Container
      id="containerSalesType"
      footerPadding="4px 12px"
      headerPadding="0"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
      showHeader={true}
      showHeaderBorder={false}
    >
      <Header>
        <Tabs
          id="tabsPeriod"
          alignment="justify"
          itemMode="static"
          value="{{ self.values[0] }}"
        >
          <Option id="0e707" label="기간 선택" value="periodic" />
          <Option id="45abf" label="월" value="monthly" />
          <Option id="4e8ec" label="분기" value="quarterly" />
          <Event
            event="change"
            method="run"
            params={{
              ordered: [
                {
                  src: "if (tabsPeriod.value === 'monthly' || tabsPeriod.value === 'quarterly' ){\n  dateRange2.setRange([moment().startOf('year').format('YYYY-MM-DD'), moment().subtract(1,'days').format('YYYY-MM-DD')])\n} else {\n  dateRange2.setRange([moment().subtract(7,'days').format('YYYY-MM-DD'), moment().subtract(1,'days').format('YYYY-MM-DD')])\n}\nsetValue.trigger()\nperiodicSalesByStyleQuery.trigger()",
                },
              ],
            }}
            pluginId=""
            type="script"
            waitMs="0"
            waitType="debounce"
          />
        </Tabs>
        <Divider id="divider1" margin="0" />
        <Container
          id="container3"
          _align="center"
          _gap="0px"
          _justify="space-between"
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
              id="containerTitle1"
              value="#### Container title"
              verticalAlign="center"
            />
          </Header>
          <View id="9bd21" viewKey="View 1">
            <DateRange
              id="dateRange2"
              dateFormat="yyyy-MM-dd"
              disabled=""
              endPlaceholder="End date"
              firstDayOfWeek={0}
              hidden=""
              iconBefore="bold/interface-calendar-remove-alternate"
              label=""
              labelPosition="top"
              startPlaceholder="Start date"
              textBefore="판매 기간"
              textBetween="-"
              value={{
                ordered: [
                  {
                    start:
                      "{{ moment().subtract(7,'days').format('YYYY-MM-DD') }}",
                  },
                  {
                    end: "{{ moment().subtract(1,'days').format('YYYY-MM-DD') }}",
                  },
                ],
              }}
            >
              <Event
                event="change"
                method="trigger"
                params={{ ordered: [] }}
                pluginId="periodicSalesByStyleQuery"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
              <Event
                event="change"
                method="trigger"
                params={{ ordered: [] }}
                pluginId="setValue"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
            </DateRange>
            <Tabs
              id="tabsOnOff"
              itemMode="static"
              margin="4px 12px"
              value="{{ self.values[0] }}"
            >
              <Option id="d3d24" label="오프라인" value="오프라인" />
              <Option id="47702" label="온라인" value="온라인" />
              <Option id="215bc" label="온오프라인 합계" value="합계" />
            </Tabs>
          </View>
        </Container>
      </Header>
      <View id="9bd21" viewKey="View 1">
        <ListViewBeta
          id="listView1"
          _primaryKeys=""
          data="{{ unitList.value[tabsPeriod.value] }}"
          itemWidth="200px"
          margin="0"
          numColumns={3}
          padding="0"
        >
          <Container
            id="container4"
            footerPadding="4px 12px"
            headerPadding="0"
            padding="0"
            showBody={true}
            showHeader={true}
          >
            <Header>
              <Text
                id="containerTitle2"
                value="###### {{ item }} {{ tabsPeriod.value === 'monthly' ? '월' :
tabsPeriod.value === 'quarterly' ? '분기' : '기간: '+ dateRange2.value.start +' ~ '+ dateRange2.value.end}}"
                verticalAlign="center"
              />
              <Switch
                id="switchCostOnOff"
                label="원가 보기"
                labelAlign="right"
                labelPosition="left"
              />
              <Text
                id="text6"
                horizontalAlign="right"
                value="단위: 수량 - 개 / 금액 - 백만원"
                verticalAlign="center"
              />
            </Header>
            <View id="79525" viewKey="View 1">
              <Table
                id="tableSalesType"
                autoColumnWidth={true}
                cellSelection="none"
                clearChangesetOnSave={true}
                data="{{ tabsPeriod.value === 'periodic' ? periodic.value :
  tabsPeriod.value === 'monthly' ? monthly.value.filter(i => i.month_unit === item) :
  quarterly.value.filter(i => i.quarter_unit === item)}}"
                defaultSelectedRow={{
                  mode: "index",
                  indexType: "display",
                  index: 0,
                }}
                emptyMessage="No rows found"
                enableSaveActions={true}
                heightType="auto"
                rowBackgroundColor="{{ currentSourceRow.season_nm === '소계' ? '01488f33' :
  currentSourceRow.season_nm === '총계' ? '01488f60' :
  'ffffff' }}"
                rowHeight="small"
                rowSelection="none"
                showHeader={true}
              >
                <Column
                  id="cf1a8"
                  alignment="left"
                  format="string"
                  formatOptions={{ automaticColors: true }}
                  groupAggregationMode="none"
                  key="sales_type"
                  label="구분"
                  placeholder="Enter value"
                  position="center"
                  size={36.734375}
                  summaryAggregationMode="none"
                  valueOverride="{{ currentSourceRow.season_nm === '소계' ? '' : item }}"
                />
                <Column
                  id="5f8f0"
                  alignment="left"
                  format="string"
                  formatOptions={{ automaticColors: true }}
                  groupAggregationMode="none"
                  key="season_nm"
                  label="''"
                  placeholder="Enter value"
                  position="center"
                  size={16}
                  valueOverride="{{ item }}"
                />
                <Column
                  id="b7488"
                  alignment="right"
                  backgroundColor="rgba(253, 230, 138, 0.3)"
                  editableOptions={{ showStepper: true }}
                  format="decimal"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="sum"
                  key="curr_amt"
                  label="{{ moment(dateRange2.value.end).format('YY') }}년 실매출"
                  placeholder="Enter value"
                  position="center"
                  size={74.703125}
                  summaryAggregationMode="none"
                  valueOverride="{{ item/1000000 }}"
                />
                <Column
                  id="e0506"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="decimal"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="sum"
                  key="curr_tag"
                  label="{{ moment(dateRange2.value.end).format('YY') }}년 매출(TAG)"
                  placeholder="Enter value"
                  position="center"
                  size={94.703125}
                  summaryAggregationMode="none"
                  valueOverride="{{ item/1000000 }}"
                />
                <Column
                  id="5b95b"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="decimal"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="sum"
                  key="target_sales"
                  label="목표매출"
                  placeholder="Enter value"
                  position="center"
                  size={57.484375}
                  summaryAggregationMode="none"
                  valueOverride="{{ item/1000000 }}"
                />
                <Column
                  id="ab7ef"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="percent"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="average"
                  label="진행율"
                  placeholder="Enter value"
                  position="center"
                  referenceId="진행율"
                  size={47.109375}
                  summaryAggregationMode="none"
                  valueOverride="{{ currentSourceRow.curr_amt/currentSourceRow.target_sales }}"
                />
                <Column
                  id="c8950"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="decimal"
                  formatOptions={{ showSeparators: true, notation: "standard" }}
                  groupAggregationMode="sum"
                  hidden="true"
                  key="curr_qty"
                  label="{{ moment(dateRange2.value.end).format('YY') }}년 판매수량"
                  placeholder="Enter value"
                  position="center"
                  size={85.0625}
                  summaryAggregationMode="none"
                />
                <Column
                  id="cf2b8"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="percent"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="average"
                  key="cur_sale_rate"
                  label="{{ moment(dateRange2.value.end).format('YY') }}년 매출비중"
                  placeholder="Enter value"
                  position="center"
                  size={85.0625}
                  summaryAggregationMode="none"
                  tooltip="실매출 기준"
                />
                <Column
                  id="faa33"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="percent"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="average"
                  label="{{ moment(dateRange2.value.end).format('YY') }}년 할인율"
                  placeholder="Enter value"
                  position="center"
                  referenceId="curr_discount_rate"
                  size={74.703125}
                  summaryAggregationMode="none"
                  valueOverride="{{ 1-(currentSourceRow.curr_amt/currentSourceRow.curr_tag) }}"
                />
                <Column
                  id="b1ab9"
                  alignment="right"
                  backgroundColor="rgba(253, 230, 138, 0.3)"
                  editableOptions={{ showStepper: true }}
                  format="decimal"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="sum"
                  key="prev_amt"
                  label="{{ moment(dateRange2.value.end).subtract(1,'year').format('YY') }}년 실매출"
                  placeholder="Enter value"
                  position="center"
                  size={74.84375}
                  summaryAggregationMode="none"
                  valueOverride="{{ item/1000000 }}"
                />
                <Column
                  id="a5358"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="decimal"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="sum"
                  key="prev_tag"
                  label="{{ moment(dateRange2.value.end).subtract(1,'year').format('YY') }}년 매출(TAG)"
                  placeholder="Enter value"
                  position="center"
                  size={94.84375}
                  summaryAggregationMode="none"
                  valueOverride="{{ item/1000000 }}"
                />
                <Column
                  id="35d04"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="decimal"
                  formatOptions={{ showSeparators: true, notation: "standard" }}
                  groupAggregationMode="sum"
                  hidden="true"
                  key="prev_qty"
                  label="{{ moment(dateRange2.value.end).subtract(1,'year').format('YY') }}년 판매수량"
                  placeholder="Enter value"
                  position="center"
                  size={85.21875}
                  summaryAggregationMode="none"
                />
                <Column
                  id="ee403"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="percent"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="average"
                  key="prev_sale_rate"
                  label="{{ moment(dateRange2.value.end).subtract(1,'year').format('YY') }}년 매출비중"
                  placeholder="Enter value"
                  position="center"
                  size={85.21875}
                  summaryAggregationMode="none"
                  tooltip="실매출 기준"
                />
                <Column
                  id="a98f3"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="percent"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="average"
                  label="{{ moment(dateRange2.value.end).subtract(1,'year').format('YY') }}년 할인율"
                  placeholder="Enter value"
                  position="center"
                  referenceId="prev_discount_rate"
                  size={74.84375}
                  summaryAggregationMode="none"
                  valueOverride="{{ 1-(currentSourceRow.prev_amt/currentSourceRow.prev_tag) }}"
                />
                <Column
                  id="21020"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="decimal"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="sum"
                  label="매출증감"
                  placeholder="Enter value"
                  position="center"
                  referenceId="sale_amt_diff"
                  size={57.484375}
                  summaryAggregationMode="none"
                  tooltip="실매출 기준"
                  valueOverride="{{ (currentSourceRow.curr_amt - currentSourceRow.prev_amt)/1000000 }}"
                />
                <Column
                  id="9ac3c"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="percent"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="average"
                  label="매출신장율"
                  placeholder="Enter value"
                  position="center"
                  referenceId="매출신장율"
                  size={67.859375}
                  summaryAggregationMode="none"
                  valueOverride="{{ ratio = currentSourceRow.prev_amt === 0 
  ? 0 
  : (currentSourceRow.curr_amt / currentSourceRow.prev_amt)-1}}"
                />
                <Column
                  id="010ee"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="decimal"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="sum"
                  hidden="{{ !switchCostOnOff.value }}"
                  key="curr_cost"
                  label="{{ moment(dateRange2.value.end).format('YY') }}년 원가"
                  placeholder="Enter value"
                  position="center"
                  size={64.328125}
                  summaryAggregationMode="none"
                  valueOverride="{{ item/1000000 }}"
                />
                <Column
                  id="e158f"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="decimal"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="sum"
                  hidden="{{ !switchCostOnOff.value }}"
                  key="prev_cost"
                  label="{{ moment(dateRange2.value.end).subtract(1,'year').format('YY') }}년 원가"
                  placeholder="Enter value"
                  position="center"
                  size={64.46875}
                  summaryAggregationMode="none"
                  valueOverride="{{ item/1000000 }}"
                />
                <Column
                  id="4110a"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="percent"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="average"
                  hidden="{{ !switchCostOnOff.value }}"
                  label="{{ moment(dateRange2.value.end).format('YY') }}년 원가율"
                  placeholder="Enter value"
                  position="center"
                  referenceId="curr_cost_rate"
                  size={100}
                  summaryAggregationMode="none"
                  valueOverride="{{ currentSourceRow.curr_cost/currentSourceRow.curr_amt }}"
                />
                <Column
                  id="447aa"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="percent"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="average"
                  hidden="{{ !switchCostOnOff.value }}"
                  label="{{ moment(dateRange2.value.end).subtract(1,'year').format('YY') }}년 원가율"
                  placeholder="Enter value"
                  position="center"
                  referenceId="prev_cost_rate"
                  size={100}
                  summaryAggregationMode="none"
                  valueOverride="{{ currentSourceRow.prev_cost/currentSourceRow.prev_amt }}"
                />
                <Column
                  id="a391f"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="decimal"
                  formatOptions={{
                    showSeparators: true,
                    notation: "standard",
                    decimalPlaces: "0",
                  }}
                  groupAggregationMode="sum"
                  hidden="{{ !switchCostOnOff.value }}"
                  label="원가증감"
                  placeholder="Enter value"
                  position="center"
                  referenceId="cost_diff"
                  size={100}
                  summaryAggregationMode="none"
                  valueOverride="{{ (currentSourceRow.curr_cost - currentSourceRow.prev_cost)/1000000 }}"
                />
                <Column
                  id="50418"
                  alignment="right"
                  editableOptions={{ showStepper: true }}
                  format="string"
                  formatOptions={{ showSeparators: true, notation: "standard" }}
                  groupAggregationMode="sum"
                  hidden="{{ !switchCostOnOff.value }}"
                  label="원가율증감"
                  placeholder="Enter value"
                  position="center"
                  referenceId="cost_rate_diff"
                  size={100}
                  summaryAggregationMode="none"
                  valueOverride="{{ (((currentSourceRow.curr_cost/currentSourceRow.curr_amt) - (currentSourceRow.prev_cost/currentSourceRow.prev_amt))*100).toFixed(0) }}%p"
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
                    pluginId="tableSalesType"
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
                    pluginId="tableSalesType"
                    type="widget"
                    waitMs="0"
                    waitType="debounce"
                  />
                </ToolbarButton>
              </Table>
            </View>
          </Container>
        </ListViewBeta>
      </View>
    </Container>
  </Frame>
</Screen>
