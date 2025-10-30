<Container
  id="container5"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  margin="0"
  padding="12px"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Tabs
      id="select1"
      alignment="justify"
      hidden=""
      itemMode="static"
      margin="0px 0px"
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
        method="run"
        params={{
          ordered: [
            {
              src: "if (select1.value === 'period') {\n  dateRange.setStartValue(moment().startOf('month').format('YYYY-MM-DD'));\n  dateRange.setEndValue(moment().subtract(1,'days').format('YYYY-MM-DD'));\n} else {\n  dateRange.setStartValue(moment().startOf('year').format('YYYY-MM-DD'));\n  dateRange.setEndValue(moment().subtract(1,'days').format('YYYY-MM-DD'));\n}",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Tabs>
  </Header>
  <View id="e4d73" viewKey="View 1">
    <Tabs
      id="tabs1"
      itemMode="static"
      margin="4px 0px"
      value="{{ self.values[0] }}"
    >
      <Option id="d3d24" label="오프라인" value="오프라인" />
      <Option id="47702" label="온라인" value="온라인" />
      <Option id="215bc" label="온오프라인 합계" value="합계" />
    </Tabs>
    <DateRange
      id="dateRange"
      dateFormat="yyyy-MM-dd"
      disabled=""
      endPlaceholder="End date"
      firstDayOfWeek={0}
      hidden=""
      iconBefore="bold/interface-calendar-remove-alternate"
      label=""
      labelPosition="top"
      startPlaceholder="Start date"
      textBefore="조회기간"
      textBetween="-"
      value={{
        ordered: [
          { start: "{{ moment().subtract(7,'days').format('YYYY-MM-DD') }}" },
          { end: "{{ moment().subtract(1,'days').format('YYYY-MM-DD') }}" },
        ],
      }}
    />
    <Button
      id="button1"
      disabled="{{ !table1.data }}"
      iconBefore="bold/interface-download-button-2"
      style={{ ordered: [] }}
      styleVariant="outline"
      text="엑셀 다운로드"
    >
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: "if (select1.value === 'period') {\n  periodicExcelDownload.trigger();\n} else if (select1.value === 'month_unit') {\n  monthlyExcelDownload.trigger();\n} else if (select1.value === 'quarter_unit') {\n  quarterlyExcelDownload.trigger();\n}",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text3"
      disableMarkdown={true}
      horizontalAlign="right"
      value="* 단위: 백만원"
      verticalAlign="center"
    />
    <Table
      id="table1"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ periodic.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="{{ select1.value != 'period' }}"
      margin="0"
      rowBackgroundColor="{{ currentSourceRow.season_nm === '소계' ? '01488f33' :
  currentSourceRow.season_nm === '총계' ? '01488f60' :
  'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
    >
      <Column
        id="5c5f4"
        alignment="left"
        editable={false}
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="sales_type"
        label="정상/이월"
        placeholder="Enter value"
        position="center"
        size={61.453125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.season_cd === '0' ? item:'' }}"
      />
      <Column
        id="cc2cd"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="season_cd"
        label="Season cd"
        placeholder="Enter value"
        position="center"
        size={75.390625}
        summaryAggregationMode="none"
      />
      <Column
        id="b0152"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="season_nm"
        label="시즌"
        placeholder="Enter value"
        position="center"
        size={67.734375}
        summaryAggregationMode="none"
      />
      <Column
        id="c5d5d"
        alignment="right"
        backgroundColor="{{  'FDE68A60'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes( tableHeader.value[2]) }}"
        key="cur_rev"
        label="{{ tableHeader.value[2] }}"
        placeholder="Enter value"
        position="center"
        referenceId="cur_rev"
        size={78.46875}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000) }}"
      />
      <Column
        id="0db0c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[1]) }}"
        key="target_sales"
        label="{{ tableHeader.value[1] }}"
        placeholder="Enter value"
        position="center"
        referenceId="tableHeaderValue1"
        size={57.453125}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000)}}"
      />
      <Column
        id="4fe2f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[7]) }}"
        label="{{ tableHeader.value[7]  }}"
        placeholder="Enter value"
        position="center"
        referenceId="{{ tableHeader.value[7] }}"
        size={47.078125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_rev/currentSourceRow.target_sales }}"
      />
      <Column
        id="d0997"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[16]) }}"
        key="cur_sale_rate"
        label="{{ tableHeader.value[16] }}"
        placeholder="Enter value"
        position="center"
        referenceId="tableHeaderValue16"
        size={99.21875}
        summaryAggregationMode="none"
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
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[3]) }}"
        key="cur_tag"
        label="{{ tableHeader.value[3] }}"
        placeholder="Enter value"
        position="center"
        size={88.84375}
        summaryAggregationMode="none"
        valueOverride="{{ 1-currentSourceRow.cur_rev/item }}"
      />
      <Column
        id="c21f5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[4]) }}"
        key="prev_rev"
        label="{{ tableHeader.value[4] }}"
        placeholder="Enter value"
        position="center"
        referenceId="{{ tableHeader.value[4] }}"
        size={78.625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000) }}"
      />
      <Column
        id="648e3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[17]) }}"
        key="prev_sale_rate"
        label="{{ tableHeader.value[17] }}"
        placeholder="Enter value"
        position="center"
        size={99.359375}
        summaryAggregationMode="none"
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
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[5]) }}"
        key="prev_tag"
        label="{{ tableHeader.value[5] }}"
        placeholder="Enter value"
        position="center"
        referenceId="작년 할인율"
        size={88.984375}
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
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[6] ) }}"
        label="{{ tableHeader.value[6] }}"
        placeholder="Enter value"
        position="center"
        referenceId="매출증감"
        size={57.453125}
        summaryAggregationMode="none"
        valueOverride="{{ ((currentSourceRow.cur_rev-currentSourceRow.prev_rev)/1000000).toFixed(0) }}"
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
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[8]) }}"
        label="{{tableHeader.value[8]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[8]}}"
        size={48.25}
        summaryAggregationMode="none"
        valueOverride="{{ ratio = currentSourceRow.prev_rev === 0 
  ? 0 
  : (currentSourceRow.cur_rev / currentSourceRow.prev_rev)-1}}"
      />
      <Column
        id="afb07"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[10]) }}"
        key="cur_cost"
        label="{{tableHeader.value[10]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[10]}}"
        size={79.828125}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000) }}"
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
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[11]) }}"
        label="{{tableHeader.value[11]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[11]}}"
        size={90.21875}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.cur_cost/currentSourceRow.cur_tag }}"
      />
      <Column
        id="6262b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[12]) }}"
        key="prev_cost"
        label="{{tableHeader.value[12]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[12]}}"
        size={80.0625}
        summaryAggregationMode="none"
        valueOverride="{{ (item/1000000) }}"
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
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[13]) }}"
        key="prev_cost"
        label="{{tableHeader.value[13]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[13]}}"
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
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[14]) }}"
        label="{{tableHeader.value[14]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[14]}}"
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
        hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[15]) }}"
        label="{{tableHeader.value[15]}}"
        placeholder="Enter value"
        position="center"
        referenceId="{{tableHeader.value[15]}}"
        size={67.90625}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.cur_cost/currentSourceRow.cur_tag)-(currentSourceRow.prev_cost/currentSourceRow.prev_tag) }}"
      />
      <Event
        event="selectRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ current_user }}" }] }}
        pluginId="unitList"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <ListViewBeta
      id="listView1"
      _primaryKeys=""
      data="{{ unitList.value[select1.value] }}"
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
        margin="0"
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
            emptyMessage="No rows found"
            enableSaveActions={true}
            heightType="auto"
            margin="0"
            rowBackgroundColor="{{ currentSourceRow.season_nm === '소계' ? '01488f33' :
  currentSourceRow.season_nm === '총계' ? '01488f60' :
  'ffffff' }}"
            rowHeight="small"
            rowSelection="none"
            showBorder={true}
            showHeader={true}
          >
            <Column
              id="5c5f4"
              alignment="left"
              editable={false}
              format="string"
              formatOptions={{ automaticColors: true }}
              groupAggregationMode="none"
              key="sales_type"
              label="구분"
              placeholder="Enter value"
              position="center"
              size={36.71875}
              summaryAggregationMode="none"
              valueOverride="{{ currentSourceRow.season_cd === '0' ? item:'' }}"
            />
            <Column
              id="b0152"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              key="season_nm"
              label="' '"
              placeholder="Enter value"
              position="center"
              size={67.8125}
              summaryAggregationMode="none"
            />
            <Column
              id="c5d5d"
              alignment="right"
              backgroundColor="{{  'FDE68A60'}}"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="sum"
              hidden="{{ !checkboxTreeNew1.value.includes( tableHeader.value[2]) }}"
              key="cur_rev"
              label="{{ tableHeader.value[2] }}"
              placeholder="Enter value"
              position="center"
              referenceId="cur_rev"
              size={96.375}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000) }}"
            />
            <Column
              id="0db0c"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="sum"
              hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[1]) }}"
              key="target_sales"
              label="{{ tableHeader.value[1] }}"
              placeholder="Enter value"
              position="center"
              referenceId="rev_goal"
              size={93.8125}
              summaryAggregationMode="none"
              valueOverride="{{ item/1000000 }}"
            />
            <Column
              id="4fe2f"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="average"
              hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[7]) }}"
              label="{{ tableHeader.value[7] }}"
              placeholder="Enter value"
              position="center"
              referenceId="{{ tableHeader.value[7] }}"
              size={47.078125}
              summaryAggregationMode="none"
              valueOverride="{{ currentSourceRow.cur_rev /currentSourceRow.target_sales}}"
            />
            <Column
              id="975ea"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="average"
              hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[16]) }}"
              key="cur_sale_rate"
              label="{{ tableHeader.value[16] }}"
              placeholder="Enter value"
              position="center"
              referenceId="tableHeaderValue16"
              size={99.21875}
              summaryAggregationMode="none"
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
              hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[3]) }}"
              key="cur_tag"
              label="{{ tableHeader.value[3] }}"
              placeholder="Enter value"
              position="center"
              size={120.8125}
              summaryAggregationMode="none"
              valueOverride="{{ 1-currentSourceRow.cur_rev/item }}"
            />
            <Column
              id="c21f5"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="sum"
              hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[4]) }}"
              key="prev_rev"
              label="{{ tableHeader.value[4] }}"
              placeholder="Enter value"
              position="center"
              referenceId="{{ tableHeader.value[4] }}"
              size={95.453125}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000) }}"
            />
            <Column
              id="9922b"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="average"
              hidden="{{!checkboxTreeNew1.value.includes(tableHeader.value[17]) }}"
              key="prev_sale_rate"
              label="{{ tableHeader.value[17] }}"
              placeholder="Enter value"
              position="center"
              referenceId="tableHeaderValue17"
              size={99.359375}
              summaryAggregationMode="none"
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
              hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[5]) }}"
              key="prev_tag"
              label="{{tableHeader.value[5]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{tableHeader.value[5]}}"
              size={118.8125}
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
              hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[6]) }}"
              label="{{tableHeader.value[6]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{tableHeader.value[6]}}"
              size={57.453125}
              summaryAggregationMode="none"
              valueOverride="{{ ((currentSourceRow.cur_rev-currentSourceRow.prev_rev)/1000000).toFixed(0) }}"
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
              hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[8]) }}"
              label="{{tableHeader.value[8]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{tableHeader.value[8]}}"
              size={47.078125}
              summaryAggregationMode="none"
              valueOverride="{{ currentSourceRow.prev_rev === 0 
  ? 0 
  : (currentSourceRow.cur_rev / currentSourceRow.prev_rev)-1}}"
            />
            <Column
              id="afb07"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="sum"
              hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[10]) }}"
              key="cur_cost"
              label="{{tableHeader.value[10]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{tableHeader.value[10]}}"
              size={48.734375}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000) }}"
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
              hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[11]) }}"
              label="{{tableHeader.value[11]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{tableHeader.value[11]}}"
              size={51.59375}
              summaryAggregationMode="none"
              valueOverride="{{ currentSourceRow.cur_cost/currentSourceRow.cur_tag }}"
            />
            <Column
              id="6262b"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "0",
              }}
              groupAggregationMode="sum"
              hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[12]) }}"
              key="prev_cost"
              label="{{tableHeader.value[12]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{tableHeader.value[12]}}"
              size={79.828125}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000)}}"
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
              hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[13]) }}"
              key="prev_cost"
              label="{{tableHeader.value[13]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{tableHeader.value[13]}}"
              size={90.21875}
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
              hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[14]) }}"
              label="{{tableHeader.value[14]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{tableHeader.value[14]}}"
              size={80.0625}
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
              hidden="{{ !checkboxTreeNew1.value.includes(tableHeader.value[15]) }}"
              label="{{tableHeader.value[15]}}"
              placeholder="Enter value"
              position="center"
              referenceId="{{tableHeader.value[15]}}"
              size={90.4375}
              summaryAggregationMode="none"
              valueOverride="{{ (currentSourceRow.cur_cost/currentSourceRow.cur_tag)-(currentSourceRow.prev_cost/currentSourceRow.prev_tag) }}"
            />
            <Event
              event="selectRow"
              method="setValue"
              params={{ ordered: [{ value: "{{ current_user }}" }] }}
              pluginId="unitList"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
          </Table>
        </View>
      </Container>
    </ListViewBeta>
  </View>
</Container>
