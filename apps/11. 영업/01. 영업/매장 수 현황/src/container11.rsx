<Container
  id="container11"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  hidden="true"
  margin="0px 2px 4px 8px"
  padding="0"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Text
      id="containerTitle11"
      value="#### {{ moment(referenceDate.value).year() }}년 매장현황"
      verticalAlign="center"
    />
    <Text
      id="text8"
      disableMarkdown={true}
      horizontalAlign="right"
      value="* {{ moment(referenceDate.value).format('YYYY년 MM월 DD일')}} 기준"
      verticalAlign="center"
    />
  </Header>
  <View id="49a6d" viewKey="View 1">
    <Statistic
      id="statistic11"
      currency="USD"
      label="실질 운영 매장수"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryPrefix="전년대비"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue="{{ (shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&
  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD')).length-shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).subtract(1,'years').year() &&
  item.open_dt <= moment(referenceDate.value).subtract(1,'years').format('YYYY-MM-DD') &&
  item.close_dt >= moment(referenceDate.value).subtract(1,'years').format('YYYY-MM-DD')).length)/(shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).subtract(1,'years').year() &&
  item.open_dt <= moment(referenceDate.value).subtract(1,'years').format('YYYY-MM-DD') &&
  item.close_dt >= moment(referenceDate.value).subtract(1,'years').format('YYYY-MM-DD')).length)
}} "
      showSeparators={true}
      suffix="개"
      value="{{ shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&
  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD')).length
}} "
    />
    <Statistic
      id="statistic12"
      currency="USD"
      label="총 누적 매출액"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryPrefix="전년대비"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue="{{ (
  (shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year()).reduce((sum, obj) => sum + Number(obj.rev), 0)/1000000).toFixed(0)
    - 
    (shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).subtract(1,'years').year()).reduce((sum, obj) => sum + Number(obj.rev), 0)/1000000).toFixed(0)
   )
  /(shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).subtract(1,'years').year()).reduce((sum, obj) => sum + Number(obj.rev), 0)/1000000).toFixed(0)
}} "
      showSeparators={true}
      suffix="백만원"
      value="{{ (shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year()).reduce((sum, obj) => sum + Number(obj.rev), 0)/1000000).toFixed(0)
}} "
    >
      <Event
        event="click"
        method="setValue"
        params={{
          ordered: [
            {
              value:
                "{{ shopStatOverviewQueryNew\n  .data\n  .filter(\n  item => item.sales_yr === moment(referenceDate.value).year() &&\n  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&\n  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD'))\n}} ",
            },
          ],
        }}
        pluginId="thisYearList"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Statistic>
    <Spacer id="spacer1" />
    <Container
      id="container12"
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      padding="0"
      showBody={true}
      showHeader={true}
      showHeaderBorder={false}
    >
      <Header>
        <Text
          id="containerTitle12"
          style={{ ordered: [] }}
          value="###### 기존"
          verticalAlign="center"
        />
      </Header>
      <View id="f2b5c" viewKey="View 1">
        <Text
          id="text9"
          value="**매장수**
{{ shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.open_yr < moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&
  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD')).length
}} 개"
          verticalAlign="center"
        />
        <Text
          id="text10"
          value="**매출액**
{{ (shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.open_yr < moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&
  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD')).reduce((sum, obj) => sum + Number(obj.rev), 0)/1000000).toLocaleString(undefined, { maximumFractionDigits: 0 })
}} 백만원"
          verticalAlign="center"
        />
      </View>
      <Event
        event="click"
        method="setValue"
        params={{
          ordered: [
            {
              value:
                "{{ shopStatOverviewQueryNew\n  .data\n  .filter(\n  item => item.sales_yr === moment(referenceDate.value).year() &&\n  item.open_yr < moment(referenceDate.value).year() &&\n  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&\n  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD'))\n}}",
            },
          ],
        }}
        pluginId="thisYearList"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Container>
    <Container
      id="container13"
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      padding="0"
      showBody={true}
      showHeader={true}
      showHeaderBorder={false}
    >
      <Header>
        <Text
          id="containerTitle13"
          style={{ ordered: [] }}
          value="###### 신규"
          verticalAlign="center"
        />
      </Header>
      <View id="f2b5c" viewKey="View 1">
        <Text
          id="text11"
          value="**매장수**
{{ shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.open_yr === moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&
  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD')).length
}}  개"
          verticalAlign="center"
        />
        <Text
          id="text12"
          value="**매출액**
{{ (shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.open_yr === moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&
  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD')).reduce((sum, obj) => sum + Number(obj.rev), 0)/1000000).toLocaleString(undefined, { maximumFractionDigits: 0 })
}} 백만원"
          verticalAlign="center"
        />
      </View>
      <Event
        event="click"
        method="setValue"
        params={{
          ordered: [
            {
              value:
                "{{ shopStatOverviewQueryNew\n  .data\n  .filter(\n  item => item.sales_yr === moment(referenceDate.value).year() &&\n  item.open_yr === moment(referenceDate.value).year() &&\n  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&\n  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD'))\n}}",
            },
          ],
        }}
        pluginId="thisYearList"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Container>
    <Container
      id="container14"
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      padding="0"
      showBody={true}
      showHeader={true}
      showHeaderBorder={false}
    >
      <Header>
        <Text
          id="containerTitle14"
          style={{ ordered: [] }}
          value="###### 철수"
          verticalAlign="center"
        />
      </Header>
      <View id="f2b5c" viewKey="View 1">
        <Text
          id="text13"
          value="**매장수**
{{ shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.close_yr === moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD')).length
}} 개"
          verticalAlign="center"
        />
        <Text
          id="text14"
          value="**매출액**
{{ (shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.close_yr === moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD')).reduce((sum, obj) => sum + Number(obj.rev), 0)/1000000).toLocaleString(undefined, { maximumFractionDigits: 0 })
}}  백만원"
          verticalAlign="center"
        />
      </View>
      <Event
        event="click"
        method="setValue"
        params={{
          ordered: [
            {
              value:
                "{{ shopStatOverviewQueryNew\n  .data\n  .filter(\n  item => item.sales_yr === moment(referenceDate.value).year() &&\n  item.close_yr === moment(referenceDate.value).year() &&\n  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD'))\n}}",
            },
          ],
        }}
        pluginId="thisYearList"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Container>
    <Divider id="divider1" />
    <Text id="text15" value="###### [매장 리스트]" verticalAlign="center" />
    <Container
      id="container15"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="0"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Tabs
          id="tabs3"
          alignment="justify"
          itemMode="static"
          style={{ ordered: [] }}
          value="{{ self.values[0] }}"
        >
          <Option
            id="79129"
            disabled={false}
            hidden={false}
            iconPosition="left"
            label="운영"
            value="1"
          />
          <Option id="43482" label="기존" value="2" />
          <Option id="5e0ec" label="신규" value="3" />
          <Option id="de830" label="철수" value="4" />
          <Option
            id="35d7b"
            disabled={false}
            hidden={false}
            iconPosition="left"
            label="전체"
            value="0"
          />
          <Event
            event="change"
            method="setValue"
            params={{
              ordered: [
                {
                  value:
                    "{{ self.value === 0 ? shopStatOverviewQueryNew.data.filter(\n  item => item.sales_yr === 2025)\n  : self.value === 1 ? shopStatOverviewQueryNew\n  .data\n  .filter(\n  item => item.sales_yr === moment(referenceDate.value).year() &&\n  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&\n  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD'))\n : self.value === 2 ? shopStatOverviewQueryNew\n  .data\n  .filter(\n  item => item.sales_yr === moment(referenceDate.value).year() &&\n  item.open_yr < moment(referenceDate.value).year() &&\n  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&\n  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD'))\n: self.value === 3 ? shopStatOverviewQueryNew\n  .data\n  .filter(\n  item => item.sales_yr === moment(referenceDate.value).year() &&\n  item.open_yr === moment(referenceDate.value).year() &&\n  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&\n  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD'))\n: shopStatOverviewQueryNew\n  .data\n  .filter(\n  item => item.sales_yr === moment(referenceDate.value).year() &&\n  item.close_yr === moment(referenceDate.value).year() &&\n  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD'))\n }}",
                },
              ],
            }}
            pluginId="thisYearList"
            type="state"
            waitMs="0"
            waitType="debounce"
          />
        </Tabs>
      </Header>
      <View id="f2b5c" viewKey="View 1">
        <Table
          id="table2"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ thisYearList.value }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableSaveActions={true}
          margin="0"
          rowHeight="medium"
          showFooter={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Column
            id="5e850"
            alignment="center"
            editable={false}
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="new_shop_cd"
            label="매장코드"
            placeholder="Enter value"
            position="center"
            size={65.9375}
            summaryAggregationMode="none"
          />
          <Column
            id="c5ca8"
            alignment="left"
            editableOptions={{ showStepper: true }}
            format="string"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="sales_yr"
            label="판매년도"
            placeholder="Enter value"
            position="center"
            size={57.515625}
            summaryAggregationMode="none"
          />
          <Column
            id="91a4d"
            alignment="left"
            format="string"
            groupAggregationMode="none"
            label="매장구분"
            placeholder="Enter value"
            position="center"
            referenceId="매장구분"
            size={57.515625}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.open_yr === 2025 ? '신규'
  : currentSourceRow.close_yr === 2025 ? '철수' 
  : '기존' }}"
          />
          <Column
            id="30743"
            alignment="left"
            caption="{{ currentSourceRow.new_shop_cd }}"
            format="string"
            groupAggregationMode="none"
            key="shop_nm"
            label="매장명"
            placeholder="Enter value"
            position="center"
            size={170.9375}
            summaryAggregationMode="none"
          />
          <Column
            id="90f5f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="rev"
            label="매출액(백만원)"
            placeholder="Enter value"
            position="center"
            size={112.96875}
            summaryAggregationMode="none"
            valueOverride="{{ (item/1000000).toFixed(0) }}"
          />
          <Column
            id="f2c3e"
            alignment="left"
            editableOptions={{ showStepper: true }}
            format="string"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="open_yr"
            label="개점년도"
            placeholder="Enter value"
            position="center"
            size={57.515625}
            summaryAggregationMode="none"
          />
          <Column
            id="4287d"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="close_yr"
            label="폐점년도"
            placeholder="Enter value"
            position="center"
            size={57.515625}
            summaryAggregationMode="none"
          />
          <Column
            id="f057f"
            alignment="left"
            format="date"
            formatOptions={{ dateFormat: "yyyy-MM-dd" }}
            groupAggregationMode="none"
            key="open_dt"
            label="개점일"
            placeholder="Enter value"
            position="center"
            size={100.234375}
            summaryAggregationMode="none"
          />
          <Column
            id="059c0"
            alignment="left"
            format="string"
            formatOptions={{ dateFormat: "yyyy-MM-dd" }}
            groupAggregationMode="none"
            key="close_dt"
            label="폐점일"
            placeholder="Enter value"
            position="center"
            size={89.234375}
            summaryAggregationMode="none"
            valueOverride="{{ moment(item) > moment('2100-01-01') ? '-' : item }}"
          />
        </Table>
      </View>
    </Container>
  </View>
</Container>
