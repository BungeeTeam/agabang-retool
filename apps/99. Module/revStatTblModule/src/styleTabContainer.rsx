<Container
  id="styleTabContainer"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  hidden="{{ typeToggleBtn10.value == false }}"
  margin="0"
  padding="12px"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Tabs
      id="tabs2"
      itemMode="static"
      navigateContainer={true}
      targetContainerId="styleTabContainer"
      value="{{ self.values[0] }}"
    >
      <Option id="f7791" value="Tab 1" />
      <Option id="0d783" value="Tab 2" />
      <Option id="f7594" value="Tab 3" />
    </Tabs>
  </Header>
  <View id="43b7f" label="시즌별" viewKey="season">
    <Table
      id="typeStatTbl10"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByStyle.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden=""
      margin="0"
      primaryKeyColumnId="b7f5c"
      rowBackgroundColor=""
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
    >
      <Column
        id="b7f5c"
        alignment="left"
        editable="false"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="시즌"
        placeholder="Select option"
        position="center"
        referenceId="팀"
        size={36.75}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["year_nm"] }}'}
      />
      <Column
        id="b17a1"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        id="a312d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="25목표"
        placeholder="Enter value"
        position="center"
        referenceId="25목표"
        size={52.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="b97a4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="목표달성율"
        placeholder="Enter value"
        position="center"
        referenceId="목표달성율"
        size={67.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="b646b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="목표차액"
        placeholder="Enter value"
        position="center"
        referenceId="목표차액"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="8a9cb"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        size={83.4375}
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
        size={83.4375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2024"]}}'}
      />
      <Column
        id="ba994"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        size={83.4375}
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
        size={83.4375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2023"]}}'}
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
          pluginId="typeStatTbl10"
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
          pluginId="typeStatTbl10"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
  <View id="4682a" label="시즌계절별" viewKey="season_detail">
    <Table
      id="typeStatTbl11"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByStyle.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden=""
      margin="0"
      primaryKeyColumnId="b7f5c"
      rowBackgroundColor=""
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
    >
      <Column
        id="b7f5c"
        alignment="left"
        editable="false"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="시즌"
        placeholder="Select option"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["year_nm"] }}'}
      />
      <Column
        id="24511"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        label="계절"
        placeholder="Select option"
        position="center"
        referenceId="계절"
        size={36.75}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["season_nm"] }}'}
      />
      <Column
        id="b17a1"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        id="a312d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="25목표"
        placeholder="Enter value"
        position="center"
        referenceId="25목표"
        size={52.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="b97a4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="목표달성율"
        placeholder="Enter value"
        position="center"
        referenceId="목표달성율"
        size={67.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="8a9cb"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        size={83.4375}
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
        size={83.4375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2024"]}}'}
      />
      <Column
        id="ba994"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        size={83.4375}
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
        size={83.4375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2023"]}}'}
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
          pluginId="typeStatTbl11"
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
          pluginId="typeStatTbl11"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
  <View id="e7069" label="복종대분류" viewKey="it">
    <Table
      id="typeStatTbl12"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByStyle.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden=""
      margin="0"
      primaryKeyColumnId="b7f5c"
      rowBackgroundColor=""
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
    >
      <Column
        id="b7f5c"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editable="false"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="대분류"
        optionList={{ mode: "manual" }}
        placeholder="Select option"
        position="center"
        size={47.140625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["it_nm"] }}'}
      />
      <Column
        id="b17a1"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        id="a312d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="25목표"
        placeholder="Enter value"
        position="center"
        referenceId="25목표"
        size={52.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="b97a4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="목표달성율"
        placeholder="Enter value"
        position="center"
        referenceId="목표달성율"
        size={67.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="b646b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="목표차액"
        placeholder="Enter value"
        position="center"
        referenceId="목표차액"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="8a9cb"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        size={83.4375}
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
        size={83.4375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2024"]}}'}
      />
      <Column
        id="ba994"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        size={83.4375}
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
        size={83.4375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2023"]}}'}
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
          pluginId="typeStatTbl12"
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
          pluginId="typeStatTbl12"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
  <View
    id="e5cf6"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="복종중분류"
    viewKey="it_gb"
  >
    <Table
      id="typeStatTbl13"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByStyle.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden=""
      margin="0"
      primaryKeyColumnId="b7f5c"
      rowBackgroundColor=""
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
    >
      <Column
        id="b7f5c"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editable="false"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="대분류"
        placeholder="Select option"
        position="center"
        referenceId="팀"
        size={47.140625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["it_nm"] }}'}
      />
      <Column
        id="7263f"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        label="중분류"
        placeholder="Select option"
        position="center"
        referenceId="column12"
        size={47.140625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["it_gb_nm"] }}'}
      />
      <Column
        id="b17a1"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        id="a312d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="25목표"
        placeholder="Enter value"
        position="center"
        referenceId="25목표"
        size={52.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="b97a4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="목표달성율"
        placeholder="Enter value"
        position="center"
        referenceId="목표달성율"
        size={67.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="b646b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="목표차액"
        placeholder="Enter value"
        position="center"
        referenceId="목표차액"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="8a9cb"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        size={83.4375}
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
        size={83.4375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2024"]}}'}
      />
      <Column
        id="ba994"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        size={83.4375}
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
        size={83.4375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2023"]}}'}
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
          pluginId="typeStatTbl13"
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
          pluginId="typeStatTbl13"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
  <View
    id="f0f86"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="복종소분류"
    viewKey="item"
  >
    <Table
      id="typeStatTbl14"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByStyle.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden=""
      margin="0"
      primaryKeyColumnId="b7f5c"
      rowBackgroundColor=""
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
    >
      <Column
        id="b7f5c"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editable="false"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="대분류"
        placeholder="Select option"
        position="center"
        referenceId="팀"
        size={47.140625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["it_nm"] }}'}
      />
      <Column
        id="7263f"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        label="중분류"
        placeholder="Select option"
        position="center"
        referenceId="column12"
        size={47.140625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["it_gb_nm"] }}'}
      />
      <Column
        id="d4924"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        label="소분류"
        placeholder="Select option"
        position="center"
        referenceId="소분류"
        size={47.140625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["item_nm"] }}'}
      />
      <Column
        id="b17a1"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        id="a312d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="25목표"
        placeholder="Enter value"
        position="center"
        referenceId="25목표"
        size={52.296875}
        summaryAggregationMode="none"
      />
      <Column
        id="b97a4"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="목표달성율"
        placeholder="Enter value"
        position="center"
        referenceId="목표달성율"
        size={67.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="b646b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        label="목표차액"
        placeholder="Enter value"
        position="center"
        referenceId="목표차액"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="8a9cb"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        size={83.4375}
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
        size={83.4375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2024"]}}'}
      />
      <Column
        id="ba994"
        alignment="right"
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
        size={52.296875}
        summaryAggregationMode="none"
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
        size={83.4375}
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
        size={83.4375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2023"]}}'}
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
          pluginId="typeStatTbl14"
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
          pluginId="typeStatTbl14"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
</Container>
