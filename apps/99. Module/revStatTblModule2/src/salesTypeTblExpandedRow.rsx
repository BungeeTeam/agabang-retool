<ExpandedRow id="salesTypeTblExpandedRow">
  <Table
    id="yearSeasonTbl"
    autoColumnWidth={true}
    cellSelection="none"
    clearChangesetOnSave={true}
    data="{{ salesBySeason.value?.filter(item => item.sales_type === currentRow.sales_type).sort((a, b) => b.year_nm - a.year_nm) }}"
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
      label="판매형태"
      placeholder="Enter value"
      position="center"
      referenceId="sales_type"
      size={57.515625}
      summaryAggregationMode="none"
      valueOverride={'{{ self.data[i]["sales_type"] }}'}
    />
    <Column
      id="8c800"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      label="시즌연도"
      placeholder="Enter value"
      position="center"
      referenceId="year_nm"
      size={57.515625}
      summaryAggregationMode="none"
      valueOverride={'{{ self.data[i]["year_nm"] }}'}
    />
    <Column
      id="7f196"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      label="시즌계절"
      placeholder="Enter value"
      position="center"
      referenceId="season_nm"
      size={57.515625}
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
      size={52.84375}
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
      valueOverride={'{{ self.data[i]["target_sales"] }}'}
    />
    <Column
      id="b97a4"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="average"
      hidden="true"
      label="목표달성율"
      placeholder="Enter value"
      position="center"
      referenceId="목표달성율"
      size={67.890625}
      summaryAggregationMode="none"
      textColor={'{{ item > 1 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'}
      valueOverride={
        '{{ self.data[i]["2025"] / self.data[i]["target_sales"] }}'
      }
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
      textColor={'{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'}
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
      size={52.828125}
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
      size={83.96875}
      summaryAggregationMode="none"
      textColor={'{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'}
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
      size={83.96875}
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
      size={52.84375}
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
      size={83.984375}
      summaryAggregationMode="none"
      textColor={'{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'}
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
      size={83.984375}
      summaryAggregationMode="none"
      valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2023"]}}'}
    />
  </Table>
</ExpandedRow>
