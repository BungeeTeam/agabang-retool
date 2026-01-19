<Container
  id="container1"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Text id="containerTitle1" value="#### 매출비중" verticalAlign="center" />
    <Text
      id="text1"
      horizontalAlign="right"
      value="[단위: 백만원]"
      verticalAlign="center"
    />
  </Header>
  <View id="10302" viewKey="View 1">
    <SegmentedControl
      id="segmentedControl1"
      itemMode="static"
      label=""
      labelPosition="top"
      paddingType="spacious"
      value="{{ self.values[0] }}"
    >
      <Option id="d03c1" label="주간" value="week" />
      <Option id="17a26" label="월간" value="month" />
      <Option
        id="2d3f0"
        disabled={false}
        iconPosition="left"
        label="기간"
        value="period"
      />
      <Event
        event="change"
        method="run"
        params={{
          ordered: [
            {
              src: "if (segmentedControl1.value === 'week'){\ndateRange1.setStartValue(moment().subtract(7,'days').format('yyyy-MM-DD') );\ndateRange1.setEndValue(moment().subtract(1,'days').format('yyyy-MM-DD') ); \n} else if (segmentedControl1.value === 'month') {\n  // 지난달 전체: 지난달 1일 ~ 지난달 말일\n  dateRange1.setStartValue(\nmoment().startOf('month').format('YYYY-MM-DD')\n  );\ndateRange1.setEndValue(moment().subtract(1,'days').format('yyyy-MM-DD'));\n} else if (segmentedControl1.value === 'period') {\n  // 올해 누적(YTD): 올해 1/1 ~ 어제\ndateRange1.setStartValue(moment().startOf('year').format('YYYY-MM-DD'));\ndateRange1.setEndValue(moment().subtract(1, 'days').format('YYYY-MM-DD'));\n}",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </SegmentedControl>
    <Text
      id="text5"
      value="기간: {{ dateRange1.value.start }} ~ {{ dateRange1.value.end }} | 전년동기: {{ moment(dateRange1.value.start).subtract(1,'years').format('yyyy-MM-DD') }} ~ {{ moment(dateRange1.value.end).subtract(1,'years').format('yyyy-MM-DD') }} | 단위: 백만원"
      verticalAlign="center"
    />
    <DateRange
      id="dateRange1"
      dateFormat="yyyy-MM-dd"
      disabled=""
      endPlaceholder="End date"
      firstDayOfWeek={0}
      hidden="{{ segmentedControl1.value != 'period' }}"
      iconBefore="bold/interface-calendar-remove"
      label="기간(현재)"
      labelWidth="20"
      startPlaceholder="Start date"
      textBetween="-"
      value={{
        ordered: [
          { start: "{{ moment().subtract(7,'days').format('yyyy-MM-DD') }}" },
          { end: "{{ moment().subtract(1,'days').format('yyyy-MM-DD') }}" },
        ],
      }}
    />
    <Text id="text8" value="**시즌상품 매출비중**" verticalAlign="center" />
    <Table
      id="table2"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_season_sales.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowHeight="xsmall"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      style={{ rowSeparator: "#e0e0e0" }}
      toolbarPosition="bottom"
    >
      <Column
        id="c043a"
        alignment="center"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="saled_type"
        label="분류"
        placeholder="Select option"
        position="left"
        size={52.734375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="345a3"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="cur_season"
        label="시즌({{ moment(dateRange1.value.end).year()  }})"
        placeholder="Enter value"
        position="center"
        size={78.765625}
      />
      <Column
        id="da073"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="cur_rev_rate"
        label="매출비중({{ moment(dateRange1.value.end).year()  }})"
        placeholder="Enter value"
        position="center"
        size={94.25}
      />
      <Column
        id="001f4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="cur_rev"
        label="매출({{ moment(dateRange1.value.end).year()  }})"
        placeholder="Enter value"
        position="center"
        referenceId="매출MomentDateRange1ValueEndYear"
        size={73.515625}
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="b2277"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="prev_season"
        label="시즌 ({{ moment(dateRange1.value.end).year() -1  }})"
        placeholder="Enter value"
        position="center"
        size={78.765625}
      />
      <Column
        id="3af06"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="prev_rev_rate"
        label="매출비중({{ moment(dateRange1.value.end).year()-1  }})"
        placeholder="Enter value"
        position="center"
        size={94.0625}
      />
      <Column
        id="d0c3c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="prev_rev"
        label="매출({{ moment(dateRange1.value.end).year() -1 }})"
        placeholder="Enter value"
        position="center"
        size={73.3125}
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="18d0b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cur_rev"
        label="매출증감"
        placeholder="Enter value"
        position="right"
        referenceId="매출증감"
        size={84.25}
        summaryAggregationMode="none"
        valueOverride="{{ item - currentSourceRow.prev_rev }}"
      />
      <Column
        id="539f3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="신장율"
        placeholder="Enter value"
        position="right"
        referenceId="신장율"
        size={65.265625}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.cur_rev - currentSourceRow.prev_rev)/currentSourceRow.prev_rev }}"
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
          pluginId="table2"
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
          pluginId="table2"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Text id="text6" value="**소계**" verticalAlign="center" />
    <Table
      id="table5"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_tot_sales.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowHeight="xsmall"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="c1bdc"
        alignment="center"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="saled_type"
        label="분류"
        placeholder="Select option"
        position="left"
        size={52.734375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="66f64"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="33266"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="cur_rev_rate"
        label="매출비중({{ moment(dateRange1.value.end).year()  }})"
        placeholder="Enter value"
        position="center"
        size={94.25}
        summaryAggregationMode="none"
      />
      <Column
        id="c444e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="cur_rev"
        label="매출({{ moment(dateRange1.value.end).year()  }})"
        placeholder="Enter value"
        position="center"
        size={73.515625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000}}"
      />
      <Column
        id="2aa02"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="f2877"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="prev_rev_rate"
        label="매출비중({{ moment(dateRange1.value.end).year() -1 }})"
        placeholder="Enter value"
        position="center"
        size={94.0625}
        summaryAggregationMode="none"
      />
      <Column
        id="187e8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="prev_rev"
        label="매출({{ moment(dateRange1.value.end).year() -1 }})"
        placeholder="Enter value"
        position="center"
        size={73.3125}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="1d5f5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cur_rev"
        label="매출증감"
        placeholder="Enter value"
        position="right"
        referenceId="매출증감"
        size={94.484375}
        summaryAggregationMode="none"
        valueOverride="{{ item - currentSourceRow.prev_rev }}"
      />
      <Column
        id="a3301"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="신장율"
        placeholder="Enter value"
        position="right"
        referenceId="신장율"
        size={63.53125}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.cur_rev - currentSourceRow.prev_rev)/currentSourceRow.prev_rev }}"
      />
    </Table>
    <Text id="text7" value="**용품 세부**" verticalAlign="center" />
    <Table
      id="table6"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_supplies_sales.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowHeight="xsmall"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="cba64"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="second_lv_class"
        label="분류"
        placeholder="Enter value"
        position="left"
        size={67.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="d97d8"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        size={16}
        summaryAggregationMode="none"
      />
      <Column
        id="33266"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="cur_rev_rate"
        label="매출비중({{ moment(dateRange1.value.end).year()  }})"
        placeholder="Enter value"
        position="center"
        size={94.25}
        summaryAggregationMode="none"
      />
      <Column
        id="c444e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="cur_rev"
        label="매출({{ moment(dateRange1.value.end).year()  }})"
        placeholder="Enter value"
        position="center"
        size={73.515625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000}}"
      />
      <Column
        id="3445c"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        size={16}
        summaryAggregationMode="none"
      />
      <Column
        id="f2877"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="prev_rev_rate"
        label="매출비중({{ moment(dateRange1.value.end).year() -1 }})"
        placeholder="Enter value"
        position="center"
        size={94.0625}
        summaryAggregationMode="none"
      />
      <Column
        id="187e8"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="prev_rev"
        label="매출({{ moment(dateRange1.value.end).year() -1 }})"
        placeholder="Enter value"
        position="center"
        size={73.3125}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="1d5f5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cur_rev"
        label="매출증감"
        placeholder="Enter value"
        position="right"
        referenceId="매출증감"
        size={93.234375}
        summaryAggregationMode="none"
        valueOverride="{{ item - currentSourceRow.prev_rev }}"
      />
      <Column
        id="a3301"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="신장율"
        placeholder="Enter value"
        position="right"
        referenceId="신장율"
        size={68.078125}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.cur_rev - currentSourceRow.prev_rev)/currentSourceRow.prev_rev }}"
      />
    </Table>
  </View>
</Container>
