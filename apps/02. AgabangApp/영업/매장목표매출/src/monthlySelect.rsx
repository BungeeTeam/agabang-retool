<Container
  id="monthlySelect"
  _gap="0px"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  margin="0"
  padding="12px"
  showBody={true}
  showHeader={true}
  transition="fade"
>
  <Header>
    <Tabs
      id="timeUnitHeader"
      alignment="justify"
      heightType="fixed"
      itemMode="static"
      margin="0"
      navigateContainer={true}
      style={{ ordered: [] }}
      targetContainerId="monthlySelect"
      value="{{ self.values[0] }}"
    >
      <Option id="64c2b" value="Tab 1" />
      <Option id="be140" value="Tab 2" />
      <Option id="5acaa" value="Tab 3" />
    </Tabs>
  </Header>
  <View id="0330c" label="연도별" viewKey="yearly">
    <Date
      id="yearlyDate"
      dateFormat="yyyy-MM-dd"
      datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
      iconBefore="bold/interface-calendar"
      label=""
      labelPosition="top"
      textBefore="기준일자"
      value={'{{ new Date().toISOString().split("T")[0] }}'}
    />
    <Module
      id="revStatTblModule1"
      inputData="{{ yearlySalesQuery.data }}"
      inputDataByStyle="{{ yearlySalesByStyleQuery.data }}"
      name="revStatTblModule2"
      pageUuid="c2c2b498-f99c-11ef-b77a-2ba139bbf501"
    />
  </View>
  <View id="ef5a8" label="월별" viewKey="monthly">
    <SegmentedControl
      id="monthSelect"
      data="{{ monthList.value }}"
      disabled=""
      label=""
      labelPosition="top"
      labels={'{{ (item+1) + "월"}}'}
      margin="0"
      paddingType="spacious"
      value="{{ new Date().getMonth() }}"
      values="{{ item }}"
    />
    <ListViewBeta
      id="listView2"
      _primaryKeys="{{ item }}"
      data="{{ monthList.value }}"
      direction="horizontal"
      itemWidth="77px"
      layoutType="grid"
      margin="0"
      numColumns="12"
      padding="0"
    >
      <Statistic
        id="statistic1"
        align="center"
        decimalPlaces="1"
        formattingStyle="percent"
        hidden="{{ self.value == 0 }}"
        label="목표달성률"
        margin="0px 0px"
        positiveTrend="{{ self.value >= 0 }}"
        secondaryCurrency="USD"
        secondaryEnableTrend={true}
        secondaryFormattingStyle="percent"
        secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
        secondaryShowSeparators={true}
        secondarySignDisplay="trendArrows"
        secondaryValue=""
        showSeparators={true}
        style={{ ordered: [{ valueFontSize: "18px" }, { color: "primary" }] }}
        tooltipText="{{ formatDataAsArray(monthlySalesQuery.data)
  .filter(obj => {
    return obj.month === (item + 1) && obj.yr === (new Date()).getFullYear()
  })
  .reduce((acc, obj) => {
  return acc + Number(obj.target_sales);
}, 0) / 1000000 }}"
        value="{{ (() => {
  const monthlySales = formatDataAsArray(monthlySalesQuery.data)
  .filter(obj => {
    return obj.month === (item + 1) && obj.yr === (new Date()).getFullYear()
  })
  .reduce((acc, obj) => {
  return acc + Number(obj.rev);
}, 0) / 1000000

  const monthlyTarget = formatDataAsArray(monthlySalesQuery.data)
  .filter(obj => {
    return obj.month === (item + 1) && obj.yr === (new Date()).getFullYear()
  })
  .reduce((acc, obj) => {
  return acc + Number(obj.target_sales);
}, 0) / 1000000

  return monthlySales / monthlyTarget || 0
})()
}}"
      />
    </ListViewBeta>
    <Module
      id="revStatTblModule2"
      inputData="{{ formatDataAsObject(formatDataAsArray(monthlySalesQuery.data).filter(obj => obj.month == (monthSelect.value + 1))) }}"
      inputDataByStyle="{{ monthlySalesByStyleQuery.data }}"
      name="revStatTblModule2"
      pageUuid="c2c2b498-f99c-11ef-b77a-2ba139bbf501"
    />
  </View>
  <View id="89490" label="일별" viewKey="daily">
    <Date
      id="dailyDate"
      dateFormat="yyyy-MM-dd"
      datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
      iconBefore="bold/interface-calendar"
      label=""
      labelPosition="top"
      textBefore="기준일자"
      value={
        '{{ new Date(new Date().setDate(new Date().getDate() - 1)).toISOString().split("T")[0] }}'
      }
    />
    <Module
      id="revStatTblModule3"
      inputData="{{ dailySalesQuery.data }}"
      inputDataByStyle="{{ dailySalesByStyleQuery.data }}"
      name="revStatTblModule2"
      pageUuid="c2c2b498-f99c-11ef-b77a-2ba139bbf501"
    />
  </View>
  <View
    id="14b44"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="기간별"
    viewKey="periodic"
  >
    <DateRange
      id="dateRange"
      dateFormat="yyyy-MM-dd"
      endPlaceholder="종료일자"
      firstDayOfWeek={0}
      iconBefore="bold/interface-calendar-remove"
      label=""
      labelPosition="top"
      loading=""
      showClear={true}
      startPlaceholder="시작일자"
      textBefore="조회기간"
      textBetween="~"
      value={{ ordered: [{ start: "" }, { end: "" }] }}
    >
      <Event
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="periodicSalesQuery"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </DateRange>
    <Module
      id="revStatTblModule4"
      inputData="{{ periodicSalesQuery.data }}"
      inputDataByStyle="{{ periodicSalesByStyleQuery.data }}"
      name="revStatTblModule2"
      pageUuid="c2c2b498-f99c-11ef-b77a-2ba139bbf501"
    />
  </View>
  <Event
    event="click"
    method="trigger"
    params={{ ordered: [] }}
    pluginId="shopInfoQuery"
    type="datasource"
    waitMs="0"
    waitType="debounce"
  />
</Container>
