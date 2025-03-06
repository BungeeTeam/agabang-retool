<App>
  <Include src="./functions.rsx" />
  <GlobalWidgetProp id="inputData" defaultValue="{{ testQuery.data }}" />
  <GlobalWidgetProp id="inputDataByStyle" />
  <Include src="./src/shopDetailModalFrame.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <ModuleContainerWidget
      id="moduleContainer"
      backgroundColor="white"
      inputData=""
      inventoryData=""
      isGlobalWidgetContainer={true}
      margin="0"
    >
      <ToggleButton
        id="typeToggleBtn"
        horizontalAlign="stretch"
        iconForFalse="bold/interface-arrows-down-circle-2"
        iconForTrue="bold/interface-arrows-right-circle-2"
        iconPosition="right"
        margin="2px 4px"
        style={{ ordered: [] }}
        text="{{ self.value ? '숨기기' : '펼치기' }}"
        value="false"
      />
      <Text id="text1" value="### 사업부별 매출 현황" verticalAlign="center" />
      <Text
        id="text28"
        horizontalAlign="right"
        margin="4px 12px"
        value="단위: 백만원"
        verticalAlign="center"
      />
      <Table
        id="typeStatTbl"
        autoColumnWidth={true}
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ salesByBiz.value }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        heightType="auto"
        hidden="{{ typeToggleBtn.value == false }}"
        margin="0"
        primaryKeyColumnId="b7f5c"
        rowBackgroundColor=""
        rowSelection="none"
        showBorder={true}
        showColumnBorders={true}
        showHeader={true}
        toolbarPosition="bottom"
      >
        <Column
          id="b7f5c"
          alignment="left"
          editable="false"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="tp_nm"
          label="사업부"
          optionList={{ mode: "manual" }}
          placeholder="Select option"
          position="center"
          size={47.140625}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["biz_nm"] }}'}
        />
        <Column
          id="b17a1"
          alignment="right"
          cellTooltip="{{ item }}"
          cellTooltipMode="custom"
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
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          hidden="false"
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
          cellTooltip="{{ item }}"
          cellTooltipMode="custom"
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
          size={67.890625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 1 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["target_sales"] }}'
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
          summaryAggregationMode="none"
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2024"] - 1 }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2023"] - 1 }}'
          }
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
      </Table>
      <Text
        id="text8"
        value="{{ selectedShopInfo.value.shop_cd }}"
        verticalAlign="center"
      />
      <ToggleButton
        id="typeToggleBtn3"
        horizontalAlign="stretch"
        iconForFalse="bold/interface-arrows-down-circle-2"
        iconForTrue="bold/interface-arrows-right-circle-2"
        iconPosition="right"
        margin="2px 4px"
        style={{ ordered: [] }}
        text="{{ self.value ? '숨기기' : '펼치기' }}"
        value="false"
      />
      <Text
        id="text3"
        value="### 온오프라인 매출 현황"
        verticalAlign="center"
      />
      <Text
        id="text36"
        horizontalAlign="right"
        margin="4px 12px"
        value="단위: 백만원"
        verticalAlign="center"
      />
      <Table
        id="typeStatTbl3"
        autoColumnWidth={true}
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ salesByOnoff.value }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        heightType="auto"
        hidden=" {{ typeToggleBtn3.value == false }}"
        margin="0"
        primaryKeyColumnId="b7f5c"
        rowBackgroundColor=""
        rowSelection="none"
        showBorder={true}
        showColumnBorders={true}
        showHeader={true}
        toolbarPosition="bottom"
      >
        <Column
          id="b7f5c"
          alignment="left"
          editable="false"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="tp_nm"
          label="온오프라인"
          optionList={{ mode: "manual" }}
          placeholder="Select option"
          position="center"
          size={67.890625}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["onoff_flag"] }}'}
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
          size={52.296875}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["target_sales"] }}'}
        />
        <Column
          id="b97a4"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="average"
          label="목표달성율"
          placeholder="Enter value"
          position="center"
          referenceId="목표달성율"
          size={67.890625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 1 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["target_sales"] }}'
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
          label="목표차액"
          placeholder="Enter value"
          position="center"
          referenceId="목표차액"
          size={57.515625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2024"] - 1 }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2023"] - 1 }}'
          }
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
            pluginId="typeStatTbl3"
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
            pluginId="typeStatTbl3"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </ToolbarButton>
      </Table>
      <ToggleButton
        id="typeToggleBtn2"
        horizontalAlign="stretch"
        iconForFalse="bold/interface-arrows-down-circle-2"
        iconForTrue="bold/interface-arrows-right-circle-2"
        iconPosition="right"
        margin="2px 4px"
        style={{ ordered: [] }}
        text="{{ self.value ? '숨기기' : '펼치기' }}"
        value="false"
      />
      <Text
        id="text2"
        value="### 유통채널별 매출 현황"
        verticalAlign="center"
      />
      <Text
        id="text35"
        horizontalAlign="right"
        margin="4px 12px"
        value="단위: 백만원"
        verticalAlign="center"
      />
      <Table
        id="typeStatTbl2"
        autoColumnWidth={true}
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ salesByType.value }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        heightType="auto"
        hidden="{{ typeToggleBtn2.value == false }}"
        margin="0"
        primaryKeyColumnId="b7f5c"
        rowBackgroundColor=""
        rowSelection="none"
        showBorder={true}
        showColumnBorders={true}
        showHeader={true}
        toolbarPosition="bottom"
      >
        <Column
          id="b7f5c"
          alignment="left"
          editable={false}
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="tp_nm"
          label="유통"
          placeholder="Select option"
          position="center"
          size={36.75}
          summaryAggregationMode="none"
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
          size={52.296875}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["target_sales"] }}'}
        />
        <Column
          id="b97a4"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="average"
          label="목표달성율"
          placeholder="Enter value"
          position="center"
          referenceId="목표달성율"
          size={67.890625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 1 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["target_sales"] }}'
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
          label="목표차액"
          placeholder="Enter value"
          position="center"
          referenceId="목표차액"
          size={57.515625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2024"] - 1 }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2023"] - 1 }}'
          }
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
      </Table>
      <ToggleButton
        id="typeToggleBtn4"
        horizontalAlign="stretch"
        iconForFalse="bold/interface-arrows-down-circle-2"
        iconForTrue="bold/interface-arrows-right-circle-2"
        iconPosition="right"
        margin="2px 4px"
        style={{ ordered: [] }}
        text="{{ self.value ? '숨기기' : '펼치기' }}"
        value="false"
      />
      <Text id="text4" value="### 팀별 매출 현황" verticalAlign="center" />
      <Text
        id="text34"
        horizontalAlign="right"
        margin="4px 12px"
        value="단위: 백만원"
        verticalAlign="center"
      />
      <Table
        id="typeStatTbl4"
        autoColumnWidth={true}
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ salesByTeam.value }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        heightType="auto"
        hidden="{{ typeToggleBtn4.value == false }}"
        margin="0"
        primaryKeyColumnId="b7f5c"
        rowBackgroundColor=""
        rowSelection="none"
        showBorder={true}
        showColumnBorders={true}
        showHeader={true}
        toolbarPosition="bottom"
      >
        <Column
          id="b7f5c"
          alignment="left"
          editable="false"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="tp_nm"
          label="팀"
          placeholder="Select option"
          position="center"
          referenceId="팀"
          size={26.375}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["team_nm"] }}'}
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
          size={52.296875}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["target_sales"] }}'}
        />
        <Column
          id="b97a4"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="average"
          label="목표달성율"
          placeholder="Enter value"
          position="center"
          referenceId="목표달성율"
          size={67.890625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 1 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["target_sales"] }}'
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
          label="목표차액"
          placeholder="Enter value"
          position="center"
          referenceId="목표차액"
          size={57.515625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2024"] - 1 }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2023"] - 1 }}'
          }
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
            pluginId="typeStatTbl4"
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
            pluginId="typeStatTbl4"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </ToolbarButton>
      </Table>
      <ToggleButton
        id="typeToggleBtn5"
        horizontalAlign="stretch"
        iconForFalse="bold/interface-arrows-down-circle-2"
        iconForTrue="bold/interface-arrows-right-circle-2"
        iconPosition="right"
        margin="2px 4px"
        style={{ ordered: [] }}
        text="{{ self.value ? '숨기기' : '펼치기' }}"
        value="false"
      />
      <Text id="text5" value="### 담당자별 매출 현황" verticalAlign="center" />
      <Text
        id="text33"
        horizontalAlign="right"
        margin="4px 12px"
        value="단위: 백만원"
        verticalAlign="center"
      />
      <Table
        id="typeStatTbl5"
        autoColumnWidth={true}
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ salesByUser.value }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        heightType="auto"
        hidden="{{ typeToggleBtn5.value == false }}"
        margin="0"
        primaryKeyColumnId="b7f5c"
        rowBackgroundColor=""
        rowSelection="none"
        showBorder={true}
        showColumnBorders={true}
        showHeader={true}
        toolbarPosition="bottom"
      >
        <Column
          id="b7f5c"
          alignment="left"
          editable="false"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="tp_nm"
          label="담당자"
          placeholder="Select option"
          position="center"
          referenceId="팀"
          size={47.140625}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["user_nm"] }}'}
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
          size={52.296875}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["target_sales"] }}'}
        />
        <Column
          id="b97a4"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="average"
          label="목표달성율"
          placeholder="Enter value"
          position="center"
          referenceId="목표달성율"
          size={67.890625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 1 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["target_sales"] }}'
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
          label="목표차액"
          placeholder="Enter value"
          position="center"
          referenceId="목표차액"
          size={57.515625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2024"] - 1 }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2023"] - 1 }}'
          }
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
            pluginId="typeStatTbl5"
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
            pluginId="typeStatTbl5"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </ToolbarButton>
      </Table>
      <ToggleButton
        id="typeToggleBtn6"
        horizontalAlign="stretch"
        iconForFalse="bold/interface-arrows-down-circle-2"
        iconForTrue="bold/interface-arrows-right-circle-2"
        iconPosition="right"
        margin="2px 4px"
        style={{ ordered: [] }}
        text="{{ self.value ? '숨기기' : '펼치기' }}"
        value="false"
      />
      <Text id="text6" value="### 지역별 매출 현황" verticalAlign="center" />
      <Text
        id="text32"
        horizontalAlign="right"
        margin="4px 12px"
        value="단위: 백만원"
        verticalAlign="center"
      />
      <Table
        id="typeStatTbl6"
        autoColumnWidth={true}
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ salesByArea.value }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        heightType="auto"
        hidden="{{ typeToggleBtn6.value == false }}"
        margin="0"
        primaryKeyColumnId="b7f5c"
        rowBackgroundColor=""
        rowSelection="none"
        showBorder={true}
        showColumnBorders={true}
        showHeader={true}
        toolbarPosition="bottom"
      >
        <Column
          id="b7f5c"
          alignment="left"
          editable="false"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="tp_nm"
          label="지역"
          placeholder="Select option"
          position="center"
          referenceId="팀"
          size={36.75}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["area_nm"] }}'}
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
          size={52.296875}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["target_sales"] }}'}
        />
        <Column
          id="b97a4"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="average"
          label="목표달성율"
          placeholder="Enter value"
          position="center"
          referenceId="목표달성율"
          size={67.890625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 1 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["target_sales"] }}'
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
          label="목표차액"
          placeholder="Enter value"
          position="center"
          referenceId="목표차액"
          size={57.515625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2024"] - 1 }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2023"] - 1 }}'
          }
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
            pluginId="typeStatTbl6"
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
            pluginId="typeStatTbl6"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </ToolbarButton>
      </Table>
      <ToggleButton
        id="typeToggleBtn11"
        horizontalAlign="stretch"
        iconForFalse="bold/interface-arrows-down-circle-2"
        iconForTrue="bold/interface-arrows-right-circle-2"
        iconPosition="right"
        margin="2px 4px"
        style={{ ordered: [] }}
        text="{{ self.value ? '숨기기' : '펼치기' }}"
        value="false"
      />
      <Text
        id="text26"
        value="### 서브브랜드별 매출 현황"
        verticalAlign="center"
      />
      <Text
        id="text31"
        horizontalAlign="right"
        margin="4px 12px"
        value="단위: 백만원"
        verticalAlign="center"
      />
      <Table
        id="typeStatTbl15"
        autoColumnWidth={true}
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ salesBySubBrand.value }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        heightType="auto"
        hidden="{{ typeToggleBtn11.value == false }}"
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
          label="서브브랜드"
          placeholder="Select option"
          position="center"
          referenceId="팀"
          size={67.890625}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["sub_br_nm"] }}'}
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
          textColor={
            '{{ item > 1 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
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
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2024"] - 1 }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2023"] - 1 }}'
          }
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
            pluginId="typeStatTbl15"
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
            pluginId="typeStatTbl15"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </ToolbarButton>
      </Table>
      <ToggleButton
        id="typeToggleBtn10"
        horizontalAlign="stretch"
        iconForFalse="bold/interface-arrows-down-circle-2"
        iconForTrue="bold/interface-arrows-right-circle-2"
        iconPosition="right"
        margin="2px 4px"
        style={{ ordered: [] }}
        text="{{ self.value ? '숨기기' : '펼치기' }}"
        value="false"
      />
      <Text id="text25" value="### 상품별 매출 현황" verticalAlign="center" />
      <Text
        id="text30"
        horizontalAlign="right"
        margin="4px 12px"
        value="단위: 백만원"
        verticalAlign="center"
      />
      <Include src="./src/styleTabContainer.rsx" />
      <Text
        id="text27"
        style={{ ordered: [{ color: "info" }] }}
        value="**더 알고 싶은 매장이 있다면 더블클릭해 보세요!**"
        verticalAlign="center"
      />
      <ToggleButton
        id="typeToggleBtn7"
        horizontalAlign="stretch"
        iconForFalse="bold/interface-arrows-down-circle-2"
        iconForTrue="bold/interface-arrows-right-circle-2"
        iconPosition="right"
        margin="2px 4px"
        style={{ ordered: [] }}
        text="{{ self.value ? '숨기기' : '펼치기' }}"
        value="false"
      />
      <Text
        id="text7"
        value="### 매장별 매출 현황({{ salesByShop.value.length }})"
        verticalAlign="center"
      />
      <Text
        id="text29"
        horizontalAlign="right"
        margin="4px 12px"
        value="단위: 백만원"
        verticalAlign="center"
      />
      <Table
        id="typeStatTbl7"
        autoColumnWidth={true}
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ salesByShop.value }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        heightType="auto"
        hidden="{{ typeToggleBtn7.value == false }}"
        margin="4px 12px 4px 0px"
        rowBackgroundColor=""
        rowSelection="none"
        showBorder={true}
        showColumnBorders={true}
        showHeader={true}
        toolbarPosition="bottom"
      >
        <Column
          id="d6a02"
          alignment="left"
          editable={false}
          format="string"
          groupAggregationMode="none"
          key="shop_nm"
          label="상점명"
          placeholder="Enter value"
          position="center"
          size={47.140625}
          summaryAggregationMode="none"
        />
        <Column
          id="c2bd0"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="sum"
          label="25실적"
          placeholder="Enter value"
          position="center"
          referenceId="25T"
          size={52.296875}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["2025"] }}'}
        />
        <Column
          id="a312d"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="sum"
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
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="average"
          label="목표달성율"
          placeholder="Enter value"
          position="center"
          referenceId="목표달성율"
          size={67.890625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 1 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["target_sales"] }}'
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
            decimalPlaces: "1",
          }}
          groupAggregationMode="sum"
          label="목표차액"
          placeholder="Enter value"
          position="center"
          referenceId="목표차액"
          size={57.515625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride={
            '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
          }
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2024"] - 1 }}'
          }
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
          id="6940c"
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
          valueOverride={
            '{{ self.data[i]["2025"] / self.data[i]["2023"] - 1 }}'
          }
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
        <Column
          id="66312"
          alignment="right"
          editable={false}
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="shop_cd"
          label="Shop cd"
          placeholder="Enter value"
          position="center"
          size={65.9375}
          summaryAggregationMode="none"
        />
        <Column
          id="3edf6"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          key="2022"
          label="2022"
          placeholder="Enter value"
          position="center"
          size={67.921875}
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
            pluginId="typeStatTbl7"
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
            pluginId="typeStatTbl7"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </ToolbarButton>
        <Event
          event="doubleClickRow"
          method="show"
          params={{ ordered: [] }}
          pluginId="shopDetailModalFrame"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="doubleClickRow"
          method="setValue"
          params={{ ordered: [{ value: "{{ currentRow }}" }] }}
          pluginId="selectedShopInfo"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
      </Table>
    </ModuleContainerWidget>
  </Frame>
</App>
