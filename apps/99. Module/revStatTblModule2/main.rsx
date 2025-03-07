<App>
  <Include src="./functions.rsx" />
  <GlobalWidgetProp id="inputData" defaultValue="{{ testQuery.data }}" />
  <GlobalWidgetProp id="inputDataByStyle" />
  <Include src="./src/bizModalFrame.rsx" />
  <Include src="./src/onoffModalFrame.rsx" />
  <Include src="./src/shopDetailModalFrame.rsx" />
  <Include src="./src/teamModalFrame.rsx" />
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
      <Text
        id="text1"
        value="##### 사업부별 매출 현황"
        verticalAlign="center"
      />
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
        hidden=""
        margin="0"
        primaryKeyColumnId="b7f5c"
        rowBackgroundColor=""
        rowSelection="none"
        showBorder={true}
        showColumnBorders={true}
        showHeader={true}
        style={{ headerBackground: "#f5f5f5" }}
        toolbarPosition="bottom"
      >
        <Column
          id="b7f5c"
          alignment="left"
          editable="false"
          format="string"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="tp_nm"
          label="사업부"
          optionList={{ mode: "manual" }}
          placeholder="Enter value"
          position="center"
          referenceId="biz_nm"
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
          size={52.3125}
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
          size={52.3125}
          summaryAggregationMode="none"
          valueOverride={
            '{{ self.data[i]["target_sales"] === 0 ? null: self.data[i]["target_sales"] }}'
          }
        />
        <Column
          id="b97a4"
          alignment="right"
          backgroundColor={
            '{{ item < 1 ? "rgba(237, 41, 57, 0.1)" : "green" }}'
          }
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
          summaryAggregationMode="none"
          textColor={'{{ item > 0 ? "green" : "red" }}'}
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
          size={52.3125}
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
          size={83.453125}
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
          size={83.453125}
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
          size={52.3125}
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
          size={83.453125}
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
          size={83.453125}
          summaryAggregationMode="none"
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
          size={100}
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
          method="show"
          params={{ ordered: [] }}
          pluginId="bizModalFrame"
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
      <Spacer id="spacer4" />
      <Text
        id="text3"
        value="##### 온오프라인 매출 현황"
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
        hidden=""
        margin="0"
        primaryKeyColumnId="b7f5c"
        rowBackgroundColor=""
        rowSelection="none"
        showBorder={true}
        showColumnBorders={true}
        showHeader={true}
        style={{ headerBackground: "#f5f5f5" }}
        toolbarPosition="bottom"
      >
        <Column
          id="b7f5c"
          alignment="left"
          editable="false"
          format="string"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="tp_nm"
          label="온오프라인"
          optionList={{ mode: "manual" }}
          placeholder="Enter value"
          position="center"
          referenceId="onoff_flag"
          size={67.90625}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["onoff_flag"] }}(전국)'}
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
          size={52.3125}
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
          size={52.3125}
          summaryAggregationMode="none"
          valueOverride={
            '{{ self.data[i]["target_sales"] === 0 ? null: self.data[i]["target_sales"] }}'
          }
        />
        <Column
          id="b97a4"
          alignment="right"
          backgroundColor={
            '{{ item < 1 ? "rgba(237, 41, 57, 0.1)" : "green" }}'
          }
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
          label="목표차액"
          placeholder="Enter value"
          position="center"
          referenceId="목표차액"
          size={57.515625}
          summaryAggregationMode="none"
          textColor={'{{ item > 0 ? "green" : "red" }}'}
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
          size={52.3125}
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
          size={83.453125}
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
          size={83.453125}
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
          size={52.3125}
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
          size={83.453125}
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
          size={83.453125}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2023"]}}'}
        />
        <Event
          event="clickRow"
          method="show"
          params={{ ordered: [] }}
          pluginId="onoffModalFrame"
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
      <Spacer id="spacer5" />
      <Text
        id="text2"
        value="##### 담당조직별 매출 현황"
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
        data="{{ salesByTeam.value }}"
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
        style={{ headerBackground: "#f5f5f5" }}
        toolbarPosition="bottom"
      >
        <Column
          id="b7f5c"
          alignment="left"
          editable="false"
          format="string"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="tp_nm"
          label="담당조직"
          placeholder="Enter value"
          position="center"
          referenceId="team_nm"
          size={57.515625}
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
          size={52.3125}
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
          size={52.3125}
          summaryAggregationMode="none"
          valueOverride={
            '{{ self.data[i]["target_sales"] === 0 ? null: self.data[i]["target_sales"] }}'
          }
        />
        <Column
          id="b97a4"
          alignment="right"
          backgroundColor={
            '{{ item < 1 ? "rgba(237, 41, 57, 0.1)" : "green" }}'
          }
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
          label="목표차액"
          placeholder="Enter value"
          position="center"
          referenceId="목표차액"
          size={57.515625}
          summaryAggregationMode="none"
          textColor={'{{ item > 0 ? "green" : "red" }}'}
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
          size={52.3125}
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
          size={83.453125}
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
          size={83.453125}
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
          size={52.3125}
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
          size={83.453125}
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
          size={83.453125}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["2025"] - self.data[i]["2023"]}}'}
        />
        <Column
          id="2d30f"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          hidden="true"
          label="team_cd"
          placeholder="Enter value"
          position="center"
          referenceId="team_cd"
          size={100}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["team_cd"] }}'}
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
        <Event
          event="clickRow"
          method="show"
          params={{ ordered: [] }}
          pluginId="teamModalFrame"
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
    </ModuleContainerWidget>
  </Frame>
</App>
