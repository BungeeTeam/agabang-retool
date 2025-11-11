<App>
  <Include src="./functions.rsx" />
  <Include src="./header.rsx" />
  <Include src="./src/bizDrawerFrame.rsx" />
  <Include src="./src/brDrawerFrame.rsx" />
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
          {
            start:
              '{{ moment().subtract(1, "days").startOf("month").format("YYYY-MM-DD") }}',
          },
          { end: '{{ moment().subtract(1, "days").format("YYYY-MM-DD") }} }}' },
        ],
      }}
    >
      <Event
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="periodicFlexSalesQuery"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </DateRange>
    <TextInput
      id="searchText"
      iconBefore="bold/interface-search"
      label=""
      labelPosition="top"
      placeholder="매장명, 매장코드로 검색해 보세요"
      style={{ ordered: [] }}
      textBefore="검색"
    />
    <Text
      id="text1"
      margin="4px 16px"
      value="##### 사업부별 매출 현황"
      verticalAlign="center"
    />
    <Text
      id="text35"
      horizontalAlign="right"
      margin="4px 12px"
      value="단위: 백만원"
      verticalAlign="center"
    />
    <Switch id="shareSwitch" label={'"매출비중" 함께보기'} />
    <Table
      id="typeStatTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ perioidSalesByBiz.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnFormatOptions={{ percent: { ordered: [] } }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      heightType="auto"
      hidden=""
      primaryKeyColumnId="f147a"
      rowBackgroundColor=""
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      showSummaryRow={true}
      style={{ headerBackground: "#f5f5f5" }}
      toolbarPosition="bottom"
    >
      <Column
        id="f147a"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="biz_cd"
        label="Biz cd"
        placeholder="Enter value"
        position="center"
        referenceId="biz_cd"
        size={0}
        summaryAggregationMode="none"
      />
      <Column
        id="afd73"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="biz_nm"
        label="사업부명"
        placeholder="Enter value"
        position="center"
        referenceId="biz_nm"
        size={78.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="b17a1"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        cellTooltip="{{ item }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2025"
        label="25실적"
        placeholder="Enter value"
        position="center"
        size={62.5}
        summaryAggregationMode="sum"
      />
      <Column
        id="a312d"
        alignment="right"
        editable={false}
        editableOptions={{ showStepper: false }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="25목표"
        placeholder="Enter value"
        position="center"
        referenceId="25목표"
        size={51.3125}
        summaryAggregationMode="sum"
        valueOverride={
          '{{ self.data[i]["target_sales"] === 0 ? null: self.data[i]["target_sales"] }}'
        }
      />
      <Column
        id="b97a4"
        alignment="right"
        backgroundColor={
          '{{ item < 1 ? "rgba(237, 41, 57, 0.1)" : "rgba(0, 100, 0, 0.1)" }}'
        }
        cellTooltip="{{ item }}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        hidden="false"
        label="목표달성율"
        placeholder="Enter value"
        position="center"
        referenceId="목표달성율"
        size={67.90625}
        summaryAggregationMode="none"
        valueOverride={
          '{{ self.data[i]["target_sales"] === 0 ? null : self.data[i]["2025"] / self.data[i]["target_sales"] }}'
        }
      />
      <Column
        id="b646b"
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
        label="목표차액"
        placeholder="Enter value"
        position="center"
        referenceId="목표차액"
        size={57.515625}
        summaryAggregationMode="sum"
        textColor={'{{ item > 0 ? "green" : "red" }}'}
        valueOverride={
          '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
        }
      />
      <Column
        id="dad1c"
        alignment="right"
        cellTooltip="{{ item }}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !shareSwitch.value }}"
        label="{{ currentYear.value.toString().slice(-2) }}매출비중"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearRevShare"
        size={72.078125}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i][currentYear.value + "_share"] }}'}
      />
      <Column
        id="8a9cb"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2024"
        label="24실적"
        placeholder="Enter value"
        position="center"
        size={63}
        summaryAggregationMode="sum"
      />
      <Column
        id="36681"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        hidden="{{ shareSwitch.value }}"
        label="24대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="24대비신장율"
        size={82.671875}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride={'{{ self.data[i]["2025"] / self.data[i]["2024"] - 1 }}'}
      />
      <Column
        id="e0872"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ shareSwitch.value }}"
        label="24대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="24대비신장액"
        size={82.671875}
        summaryAggregationMode="sum"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2024"]}}'}
      />
      <Column
        id="0510f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !shareSwitch.value }}"
        label="{{ (currentYear.value - 1).toString().slice(-2) }}매출비중"
        placeholder="Enter value"
        position="center"
        referenceId="lastYearRevenueShare"
        size={100}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i][(currentYear.value - 1) + "_share"] }}'}
      />
      <Column
        id="ba994"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2023"
        label="23실적"
        placeholder="Enter value"
        position="center"
        size={62.90625}
        summaryAggregationMode="sum"
      />
      <Column
        id="2783a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        hidden="{{ shareSwitch.value }}"
        label="23대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="23대비신장율"
        size={82.796875}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride={'{{ self.data[i]["2025"] / self.data[i]["2023"] - 1 }}'}
      />
      <Column
        id="cc18b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        hidden="{{ shareSwitch.value }}"
        label="23대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="23대비N신장액"
        size={82.796875}
        summaryAggregationMode="sum"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2023"]}}'}
      />
      <Column
        id="1b05e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ !shareSwitch.value }}"
        label="{{ (currentYear.value - 2).toString().slice(-2) }}매출비중"
        placeholder="Enter value"
        position="center"
        referenceId="secondLastYearRevenueShare"
        size={100}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i][(currentYear.value - 2) + "_share"] }}'}
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
          pluginId="typeStatTbl"
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
          pluginId="typeStatTbl"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentRow }}" }] }}
        pluginId="selectedRow"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="bizDrawerFrame"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Spacer id="spacer1" />
    <Text
      id="text36"
      margin="4px 16px"
      value="##### 브랜드별 매출 현황"
      verticalAlign="center"
    />
    <Multiselect
      id="brMultiselect"
      data="{{ subBrandList.data }}"
      emptyMessage="No options"
      label=""
      labelPosition="top"
      overlayMaxHeight={375}
      placeholder="Select options"
      showSelectionIndicator={true}
      textBefore="조회브랜드"
      value={'["아가방", "에뜨와", "디즈니베이비", "부가부"]'}
      values=""
      wrapTags={true}
    >
      <Option id="59010" value="Option 1" />
      <Option id="0323f" value="Option 2" />
      <Option id="e8470" value="Option 3" />
    </Multiselect>
    <Text
      id="text37"
      horizontalAlign="right"
      margin="4px 12px"
      value="단위: 천원"
      verticalAlign="center"
    />
    <Table
      id="typeStatTbl2"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ periodicSalesByBrand.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      heightType="auto"
      hidden=""
      primaryKeyColumnId="b25ad"
      rowBackgroundColor=""
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      showSummaryRow={true}
      style={{ headerBackground: "#f5f5f5" }}
      toolbarPosition="bottom"
    >
      <Column
        id="b25ad"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        key="br_type"
        label="브랜드"
        placeholder="Enter value"
        position="center"
        size={78.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="b17a1"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        cellTooltip="{{ item }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2025"
        label="25실적"
        placeholder="Enter value"
        position="center"
        size={63.46875}
        summaryAggregationMode="sum"
      >
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="testQuery"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="8a9cb"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2024"
        label="24실적"
        placeholder="Enter value"
        position="center"
        size={63.03125}
        summaryAggregationMode="sum"
      />
      <Column
        id="36681"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="24대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="24대비신장율"
        size={82.671875}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride={'{{ self.data[i]["2025"] / self.data[i]["2024"] - 1 }}'}
      />
      <Column
        id="e0872"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="24대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="24대비신장액"
        size={82.671875}
        summaryAggregationMode="sum"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2024"]}}'}
      />
      <Column
        id="ba994"
        alignment="right"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2023"
        label="23실적"
        placeholder="Enter value"
        position="center"
        size={62.078125}
        summaryAggregationMode="sum"
      />
      <Column
        id="2783a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="23대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="23대비신장율"
        size={82.796875}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride={'{{ self.data[i]["2025"] / self.data[i]["2023"] - 1 }}'}
      />
      <Column
        id="cc18b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="23대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="23대비N신장액"
        size={82.796875}
        summaryAggregationMode="sum"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2023"]}}'}
      />
      <Column
        id="68cbc"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        label="biz_cd"
        placeholder="Enter value"
        position="center"
        referenceId="biz_cd"
        size={52.328125}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["biz_cd"] }}'}
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
          params={{
            ordered: [{ options: { ordered: [{ fileType: "csv" }] } }],
          }}
          pluginId="typeStatTbl2"
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
          pluginId="typeStatTbl2"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="brDrawerFrame"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentRow }}" }] }}
        pluginId="selectedRow"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Spacer id="spacer2" />
    <Module
      id="storeDetailModule1"
      endDate="{{ dateRange.value.end }}"
      inputData="{{ periodicFlexSalesQuery.data }}"
      margin="4px 8px"
      name="storeDetailModule"
      pageUuid="f4960172-fb37-11ef-af6c-1f09ee775f43"
      startDate="{{ dateRange.value.start }}"
    />
  </Frame>
</App>
