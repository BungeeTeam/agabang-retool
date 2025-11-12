<Container
  id="styleTabContainer"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  hidden=""
  margin="0"
  padding="0px"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Tabs
      id="tabs3"
      itemMode="static"
      margin="4px 0px"
      navigateContainer={true}
      style={{ ordered: [] }}
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
      id="typeStatTbl20"
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
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "#f5f5f5" }}
    >
      <Column
        id="b7f5c"
        alignment="left"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="시즌"
        placeholder="Enter value"
        position="center"
        referenceId="year_nm"
        size={44.609375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["year_nm"] }}'}
      />
      <Column
        id="b17a1"
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
        key="2025"
        label="{{(thisYear.value).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearRev"
        size={50.90625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()]}}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        size={51.0625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value-1).toString()]}}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearValue1ToStringSlice2대비신장율"
        size={82.15625}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value).toString()] / self.data[i][(thisYear.value-1).toString()] - 1 }}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearValue1ToStringSlice2대비신장액"
        size={82.15625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-1).toString()]}}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        size={51.171875}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value-2).toString()]}}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearValue2ToStringSlice2대비신장율"
        size={82.265625}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value).toString()] / self.data[i][(thisYear.value-2).toString()] - 1 }}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="23대비N신장액"
        size={82.265625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-2).toString()]}}"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="필터"
        type="filter"
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
          pluginId="excelDownloadByStyle"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
  <View id="4682a" label="시즌계절별" viewKey="season_detail">
    <Table
      id="typeStatTbl21"
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
      primaryKeyColumnId="2d619"
      rowBackgroundColor=""
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "#f5f5f5" }}
    >
      <Column
        id="b7f5c"
        alignment="left"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="시즌"
        placeholder="Enter value"
        position="center"
        size={36.71875}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["year_nm"] }}'}
      />
      <Column
        id="2d619"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        label="시즌코드"
        placeholder="Enter value"
        position="center"
        referenceId="season_cd"
        size={57.453125}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["year_cd"] }}'}
      />
      <Column
        id="24511"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        label="계절"
        placeholder="Enter value"
        position="center"
        referenceId="계절"
        size={36.71875}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["season_nm"] }}'}
      />
      <Column
        id="b17a1"
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
        key="2025"
        label="{{(thisYear.value).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearRev"
        size={50.90625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()]}}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        size={51.0625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value-1).toString()]}}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearValue1ToStringSlice2대비신장율"
        size={82.15625}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value).toString()] / self.data[i][(thisYear.value-1).toString()] - 1 }}"
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
        size={82.15625}
        summaryAggregationMode="none"
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
        label="{{(thisYear.value-2).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        size={51.171875}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value-2).toString()]}}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearValue2ToStringSlice2대비신장율"
        size={91.6875}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value)] / self.data[i][(thisYear.value-2).toString()] - 1 }}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="23대비N신장액"
        size={82.265625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-2).toString()]}}"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="필터"
        type="filter"
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
          pluginId="excelDownloadByStyle"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
  <View id="e7069" label="복종대분류" viewKey="it">
    <Table
      id="typeStatTbl22"
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
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "#f5f5f5" }}
    >
      <Column
        id="b7f5c"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="대분류"
        optionList={{ mode: "manual" }}
        placeholder="Enter value"
        position="center"
        size={75.984375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["it_nm"] }}'}
      />
      <Column
        id="b17a1"
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
        key="2025"
        label="{{(thisYear.value).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearRev"
        size={50.90625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()]}}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        size={51.0625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value-1).toString()]}}"
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
        label="{{ (thisYear.value-1).toString().slice(2) }}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearValue1ToStringSlice2대비신장율"
        size={82.15625}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value).toString()] / self.data[i][(thisYear.value-1).toString()] - 1 }}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearValue1ToStringSlice2대비신장액"
        size={82.15625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-1).toString()]}}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        size={51.171875}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value-2).toString()]}}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearValue2ToStringSlice2대비신장율"
        size={82.265625}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value)] / self.data[i][(thisYear.value-2).toString()] - 1 }}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="23대비N신장액"
        size={82.265625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-2).toString()]}}"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="필터"
        type="filter"
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
          pluginId="excelDownloadByStyle"
          type="datasource"
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
      id="typeStatTbl23"
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
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "#f5f5f5" }}
    >
      <Column
        id="b7f5c"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="대분류"
        placeholder="Enter value"
        position="center"
        referenceId="팀"
        size={75.984375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["it_nm"] }}'}
      />
      <Column
        id="7263f"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        label="중분류"
        placeholder="Enter value"
        position="center"
        referenceId="column12"
        size={47.078125}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["it_gb_nm"] }}'}
      />
      <Column
        id="b17a1"
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
        key="2025"
        label="{{(thisYear.value).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearRev"
        size={50.90625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()]}}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        size={51.0625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value-1).toString()]}}"
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
        label="{{ (thisYear.value-1).toString().slice(2) }}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearValue1ToStringSlice2대비신장율"
        size={82.15625}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value).toString()] / self.data[i][(thisYear.value-1).toString()] - 1 }}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearValue1ToStringSlice2대비신장액"
        size={82.15625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-1).toString()]}}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        size={51.171875}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value-2).toString()]}}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearValue2ToStringSlice2대비신장율"
        size={91.6875}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value)] / self.data[i][(thisYear.value-2).toString()] - 1 }}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="23대비N신장액"
        size={82.265625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-2).toString()]}}"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="필터"
        type="filter"
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
          pluginId="excelDownloadByStyle"
          type="datasource"
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
      id="typeStatTbl24"
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
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "#f5f5f5" }}
    >
      <Column
        id="b7f5c"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="대분류"
        placeholder="Enter value"
        position="center"
        referenceId="팀"
        size={75.984375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["it_nm"] }}'}
      />
      <Column
        id="7263f"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        label="중분류"
        placeholder="Enter value"
        position="center"
        referenceId="column12"
        size={64.484375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["it_gb_nm"] }}'}
      />
      <Column
        id="d4924"
        alignment="left"
        cellTooltip="{{ item }}"
        cellTooltipMode="custom"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        label="소분류"
        placeholder="Enter value"
        position="center"
        referenceId="소분류"
        size={47.078125}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["item_nm"] }}'}
      />
      <Column
        id="b17a1"
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
        key="2025"
        label="{{(thisYear.value).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearRev"
        size={50.90625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()]}}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="lastYearRev"
        size={51.0625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value-1).toString()]}}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="lastYearGrowthRate"
        size={82.15625}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value).toString()] / self.data[i][(thisYear.value-1).toString()] - 1 }}"
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
        label="{{(thisYear.value-1).toString().slice(2)}}대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="lastYearGrowth"
        size={82.15625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-1).toString()]}}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="yearBeforeLastRev"
        size={51.171875}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value-3).toString()]}}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="yearBeforeLastGrowthRate"
        size={82.265625}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value).toString()] / self.data[i][(thisYear.value-2).toString()] - 1 }}"
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
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="yearBeforeLastGrowth"
        size={82.265625}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-2).toString()]}}"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="필터"
        type="filter"
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
          pluginId="excelDownloadByStyle"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
</Container>
