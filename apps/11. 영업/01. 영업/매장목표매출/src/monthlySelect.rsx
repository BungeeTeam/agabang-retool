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
  <View id="ef5a8" label="월별현황" viewKey="monthly">
    <SegmentedControl
      id="monthSelect"
      data="{{ monthList.value }}"
      disabled=""
      label=""
      labelPosition="top"
      labels={'{{ (item + 1) + "월"}}'}
      margin="0"
      paddingType="spacious"
      value="{{ new Date().getMonth() }}"
      values="{{ item }}"
    />
    <Module
      id="revStatTblModule2"
      inputData="{{ formatDataAsObject(formatDataAsArray(monthlySalesQuery.data).filter(obj => obj.month == (monthSelect.value + 1))) }}"
      inputDataByStyle="{{ monthlySalesByStyleQuery.data }}"
      inputDateRange={
        "{\n  \"start\": {{ moment([moment().year(),monthSelect.value]).startOf('month').format('YYYY-MM-DD') }} ,\n  \"end\": {{ moment([moment().year(),monthSelect.value]).endOf('month').format('YYYY-MM-DD') }}\n}"
      }
      name="revStatTblModule2"
      pageUuid="c2c2b498-f99c-11ef-b77a-2ba139bbf501"
    />
  </View>
  <View
    id="490e1"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="연도요약"
    viewKey="yearly"
  >
    <Text
      id="text2"
      margin="4px 0px"
      value="#### {{ thisYear.value }} 연간 오프라인 매출 현황"
      verticalAlign="center"
    />
    <Text
      id="text10"
      horizontalAlign="right"
      margin="0px 4px"
      style={{ ordered: [{ color: "rgba(114, 114, 114, 1)" }] }}
      value={
        '조회기간: {{ moment().startOf("year").format("YYYY-MM-DD") }} ~ {{ moment().subtract(1, "days").format("YYYY-MM-DD") }}'
      }
      verticalAlign="center"
    />
    <Include src="./container2.rsx" />
    <Text
      id="text9"
      margin="4px 0px"
      value="#### {{ thisYear.value }} 월별 오프라인 매출 달성률 현황"
      verticalAlign="center"
    />
    <ListViewBeta
      id="listView4"
      data="{{ [...Array(12).keys()]}}"
      direction="horizontal"
      heightType="auto"
      layoutType="grid"
      margin="0"
      numColumns="6"
      padding="0"
    >
      <Container
        id="container1"
        _direction="vertical"
        _gap="0px"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        heightType="fixed"
        margin="4px 4px"
        overflowType="hidden"
        padding="18px"
        showBody={true}
        showHeader={true}
        style={{ ordered: [{ headerBackground: "tokens/356f4e7b" }] }}
      >
        <Header>
          <Text
            id="containerTitle1"
            value="**{{ item + 1 }}월 달성률**"
            verticalAlign="center"
          />
        </Header>
        <View id="bcc70" viewKey="View 1">
          <ProgressCircle
            id="progressCircle2"
            hidden="{{ self.value === 0 }}"
            horizontalAlign="center"
            margin="0"
            value={
              '{{ (() => {\n  const monthlySales = formatDataAsArray(monthlySalesQuery.data)\n  .filter(item => item?.onoff_flag === "오프라인")\n  .filter(obj => {\n    return obj.month === (item + 1) && obj.yr === (new Date()).getFullYear()\n  })\n  .reduce((acc, obj) => {\n  return acc + Number(obj.rev);\n}, 0) / 1000000\n\n  const monthlyTarget = formatDataAsArray(monthlySalesQuery.data)\n  .filter(item => item?.onoff_flag === "오프라인")\n  .filter(obj => {\n    return obj.month === (item + 1) && obj.yr === (new Date()).getFullYear()\n  })\n  .reduce((acc, obj) => {\n  return acc + Number(obj.target_sales);\n}, 0) / 1000000\n\n  return monthlySales / monthlyTarget *  100 || 0\n})()\n}}'
            }
          />
        </View>
      </Container>
    </ListViewBeta>
    <Text
      id="text11"
      margin="4px 0px"
      value="#### 상품종목별 매출 상세"
      verticalAlign="center"
    />
    <Text
      id="text12"
      heightType="fill"
      horizontalAlign="right"
      margin="0px 4px"
      value="(단위: 백만원)"
      verticalAlign="center"
    />
    <Table
      id="salesBySecondLevelTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesBySecondLevelWithBiz.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      margin="4px 4px"
      primaryKeyColumnId="e73d4"
      rowHeight="medium"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
      toolbarPosition="bottom"
    >
      <Column
        id="e73d4"
        alignment="left"
        editable={false}
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="biz_cd"
        label="Biz cd"
        placeholder="Select option"
        position="center"
        size={50.671875}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="cc716"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="sale_yr"
        label="Sale yr"
        placeholder="Enter value"
        position="center"
        size={54.78125}
        summaryAggregationMode="none"
      />
      <Column
        id="6304e"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="biz_nm"
        label="사업부"
        placeholder="Enter value"
        position="center"
        referenceId="biz_nm"
        size={78.21875}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      />
      <Column
        id="71866"
        alignment="right"
        caption="{{ currentSourceRow.기초류신장율 ?? '-'}}%"
        cellTooltip="{{ item?.toFixed(0) }}"
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
        size={48.234375}
        summaryAggregationMode="none"
        textColor={
          '{{  currentSourceRow.기초류신장율 > 0 ?  "green" : "red"  }}'
        }
        valueOverride="{{ item }}"
      />
      <Column
        id="0ecd5"
        alignment="right"
        caption="{{ currentSourceRow.외의류신장율 ?? '-'}}%"
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
        size={47.109375}
        summaryAggregationMode="none"
        textColor={
          '{{ currentSourceRow.외의류신장율 > 0 ?  "green" : "red"  }}'
        }
        valueOverride="{{ item }}"
      />
      <Column
        id="fb989"
        alignment="right"
        caption="{{ currentSourceRow.발육신장율 ?? '-' }}%"
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
        size={55.890625}
        summaryAggregationMode="none"
        textColor={'{{ currentSourceRow.발육신장율 > 0 ?  "green" : "red"  }}'}
        valueOverride="{{ item }}"
      />
      <Column
        id="2ec84"
        alignment="right"
        caption="{{ currentSourceRow.섬유공산품신장율 ?? '-'}}%"
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
        textColor={
          '{{ currentSourceRow.섬유공산품신장율 > 0 ? "green" :"red"   }}'
        }
        valueOverride="{{ item }}"
      />
      <Column
        id="e0b93"
        alignment="right"
        caption="{{ currentSourceRow.시즌용품신장율 ?? '-'}}%"
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
        size={57.484375}
        summaryAggregationMode="none"
        textColor={
          '{{ currentSourceRow.시즌용품신장율 > 0 ?  "green": "red"   }}'
        }
        valueOverride="{{ item }}"
      />
      <Column
        id="b9ad0"
        alignment="right"
        caption="{{ currentSourceRow.일반용품위탁신장율 ?? '-'}}%"
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
        textColor={
          '{{ currentSourceRow.일반용품위탁신장율 > 0  ?  "green" : "red"   }}'
        }
        valueOverride="{{ item }}"
      />
      <Column
        id="4866d"
        alignment="right"
        caption="{{ currentSourceRow.하드류신장율 ?? '-'}}%"
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
        size={55.765625}
        summaryAggregationMode="none"
        textColor={'{{ currentSourceRow.하드류신장율 > 0 ? "green" : "red"  }}'}
        valueOverride="{{ item }}"
      />
      <Column
        id="cf1aa"
        alignment="right"
        caption="{{ currentSourceRow.기타신장율 ?? '-'}}%"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="기타"
        label="기타"
        placeholder="Enter value"
        position="center"
        size={53.109375}
        summaryAggregationMode="none"
        textColor={'{{ currentSourceRow.기타신장율 > 0 ? "green" : "red"  }}'}
        valueOverride="{{ item }}"
      />
    </Table>
  </View>
  <View
    id="14b44"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="기간별현황"
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
      value={{
        ordered: [
          { start: '{{ moment().startOf("year").format("YYYY-MM-DD") }}' },
          { end: '{{ moment().subtract(1, "days").format("YYYY-MM-DD") }} }}' },
        ],
      }}
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
      inputDateRange="{{ dateRange.value }}"
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
