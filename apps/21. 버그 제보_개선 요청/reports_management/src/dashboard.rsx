<Screen
  id="dashboard"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title={null}
  urlSlug=""
>
  <SqlQueryUnified
    id="updateQuery2"
    actionType="BULK_UPDATE_BY_KEY"
    bulkUpdatePrimaryKey="id"
    changesetIsObject={true}
    changesetObject="{{ table3.changesetArray[0] }}"
    editorMode="gui"
    filterBy={
      '[{"key":"id","value":"{{ table3.changesetArray[0]?.id || \\"\\"}}","operation":"="}]'
    }
    notificationDuration={4.5}
    records="{{ table4.changesetArray }}"
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    tableName="user_reports"
    updateSetValueDynamically={true}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="getReportsQuery"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <Frame
    id="$main4"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Select
      id="select5"
      captionByIndex=""
      data="{{ Object.keys(getReportsQuery.data[0]) }}"
      emptyMessage="No options"
      labelPosition="top"
      labels=""
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value="{{ self.data[9] }}"
      values=""
    />
    <DateRange
      id="dateRange1"
      dateFormat="yyyy-MM-dd"
      endPlaceholder="End date"
      iconBefore="bold/interface-calendar-remove"
      label="조회기간"
      startPlaceholder="Start date"
      textBetween="~"
      value={{
        ordered: [
          { start: "{{ moment().startOf('month').format('YYYY-MM-DD') }}" },
          { end: "{{ moment().format('YYYY-MM-DD') }}" },
        ],
      }}
    />
    <Chart
      id="pieChart1"
      chartType="pie"
      colorArray={[
        "#11B5AE",
        "#4046CA",
        "#F68512",
        "#DE3C82",
        "#7E84FA",
        "#72E06A",
      ]}
      colorArrayDropDown={[
        "#11B5AE",
        "#4046CA",
        "#F68512",
        "#DE3C82",
        "#7E84FA",
        "#72E06A",
      ]}
      colorInputMode="colorArrayDropDown"
      datasource="{{ getReportsQuery.data }}"
      datasourceMode="source"
      gradientColorArray={[
        ["0.0", "{{ theme.canvas }}"],
        ["1.0", "{{ theme.primary }}"],
      ]}
      hoverTemplate="%{label}<br>%{value}<br>%{percent}<extra></extra>"
      hoverTemplateMode="source"
      labelData="{{ formatDataAsObject(getReportsQuery.data)[select5.value]}}"
      legendPosition="none"
      lineColor="{{ theme.surfacePrimary }}"
      lineWidth={2}
      pieDataHole={0.4}
      selectedPoints="[]"
      textTemplate="%{label}"
      textTemplateMode="source"
      textTemplatePosition="outside"
      title={null}
      valueData=""
    />
    <Table
      id="table4"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getReportsQuery.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="dba5d"
      rowHeight="small"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="dba5d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="id"
        label="ID"
        placeholder="Enter value"
        position="center"
        size={53}
        summaryAggregationMode="none"
      />
      <Column
        id="5e920"
        alignment="left"
        format="date"
        groupAggregationMode="none"
        key="submitted_at"
        label="Submitted at"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="fcdda"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="last_updated_at"
        label="Last updated at"
        placeholder="Enter value"
        position="center"
        size={115}
        summaryAggregationMode="none"
      />
      <Column
        id="d98ff"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="submitter_name"
        label="Submitter name"
        placeholder="Select option"
        position="center"
        size={183}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="ee617"
        alignment="left"
        format="link"
        formatOptions={{ showUnderline: "hover" }}
        groupAggregationMode="none"
        key="submitter_email"
        label="Submitter email"
        position="center"
        size={100}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="openUrl"
          params={{ ordered: [{ url: "mailto:{{ item }}" }] }}
          pluginId=""
          type="util"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="dbf44"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="submitter_department"
        label="Submitter department"
        placeholder="Enter value"
        position="center"
        size={123}
        summaryAggregationMode="none"
      />
      <Column
        id="3c45d"
        alignment="left"
        format="link"
        formatOptions={{ showUnderline: "hover" }}
        groupAggregationMode="none"
        key="app_link"
        label="App link"
        position="center"
        size={100}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="openUrl"
          params={{ ordered: [{ url: "{{ item }}" }] }}
          pluginId=""
          type="util"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="c3b9f"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="affected_app_version"
        label="Affected app version"
        placeholder="Enter value"
        position="center"
        size={138}
        summaryAggregationMode="none"
      />
      <Column
        id="f8fcd"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="category"
        label="Category"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="e4360"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="user_priority"
        label="User priority"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="38050"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="report_title"
        label="Report title"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="bbfb1"
        alignment="left"
        cellTooltipMode="overflow"
        format="multilineString"
        groupAggregationMode="none"
        key="report_description"
        label="Report description"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="16c0b"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="submitter_os_info"
        label="Submitter os info"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="6e16d"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="submitter_browser_info"
        label="Submitter browser info"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="3fce5"
        alignment="left"
        cellTooltipMode="overflow"
        format="tags"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="screenshot_1"
        label="Screenshot 1"
        placeholder="Select options"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="36ba3"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="assignee"
        label="Assignee"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="3d100"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="assigned_at"
        label="Assigned at"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="5062c"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="status"
        label="Status"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="4ec39"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="resolution_summary"
        label="Resolution summary"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="2278e"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="solution_details"
        label="Solution details"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="78745"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="resolved_at"
        label="Resolved at"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="e790c"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="resolved_version"
        label="Resolved version"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="a52a7"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="admin_notes"
        label="Admin notes"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="6cec5"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="related_ticket_id"
        label="Related ticket ID"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="bc033"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="admin_priority"
        label="Admin priority"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="d0f27"
        alignment="left"
        format="json"
        groupAggregationMode="none"
        key="file_attachments"
        label="File attachments"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
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
          pluginId="table4"
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
          pluginId="table4"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Frame>
</Screen>
