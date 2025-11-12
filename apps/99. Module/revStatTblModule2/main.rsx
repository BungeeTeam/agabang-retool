<App>
  <Include src="./functions.rsx" />
  <GlobalWidgetProp id="inputData" defaultValue="{{ testQuery.data }}" />
  <GlobalWidgetProp id="inputDataByStyle" />
  <GlobalWidgetProp
    id="inputDateRange"
    description=""
    value={'{\n  "start": "2024-09-01",\n  "end": "2024-12-31"\n}'}
  />
  <Include src="./src/bizModalFrame.rsx" />
  <Include src="./src/onoffModalFrame.rsx" />
  <Include src="./src/salesTypeDetailDrawer.rsx" />
  <Include src="./src/tpModalFrame.rsx" />
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
      inputDataByStyle=""
      inputDateRange={'{\n  "start": "2024-09-01",\n  "end": "2024-12-31"\n}'}
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
        id="text35"
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
        dynamicColumnProperties={{ formatByIndex: "auto" }}
        emptyMessage="No rows found"
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
          label="사업부"
          optionList={{ mode: "manual" }}
          placeholder="Enter value"
          position="center"
          referenceId="biz_nm"
          size={47.078125}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["biz_nm"] }}'}
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
          label="{{(thisYear.value).toString().slice(2)}}실적"
          placeholder="Enter value"
          position="center"
          referenceId="thisYearRev"
          size={51.0625}
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
          id="a312d"
          alignment="right"
          editable="false"
          editableOptions={{ showStepper: false }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          label="{{(thisYear.value).toString().slice(2)}}목표"
          placeholder="Enter value"
          position="center"
          referenceId="thisYearTarget"
          size={51.0625}
          summaryAggregationMode="none"
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
          size={67.8125}
          summaryAggregationMode="none"
          valueOverride={
            '{{ self.data[i]["target_sales"] === 0 ? null : self.data[i][(thisYear.value).toString()] / self.data[i]["target_sales"] }}'
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
          size={57.453125}
          summaryAggregationMode="none"
          textColor={'{{ item > 0 ? "green" : "red" }}'}
          valueOverride={
            '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
          }
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
          label="{{(thisYear.value-1).toString().slice(2)}}실적"
          placeholder="Enter value"
          position="center"
          referenceId="lastYearRev"
          size={51.171875}
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
          size={82.265625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride="{{ self.data[i][thisYear.value.toString()] / self.data[i][(thisYear.value-1).toString()] - 1 }}"
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
          size={82.265625}
          summaryAggregationMode="none"
          valueOverride="{{ self.data[i][thisYear.value.toString()] - self.data[i][(thisYear.value-1).toString()]}}"
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
          size={50.796875}
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
          referenceId="yearBeforeLastGrowthRate"
          size={81.890625}
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
          referenceId="yeatBeforeLastGrowth"
          size={81.890625}
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
            pluginId="excelDownloadByBiz"
            type="datasource"
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
          params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
          pluginId="selectedRow"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
      </Table>
      <Spacer id="spacer8" />
      <Spacer id="spacer9" />
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
          label="온오프라인"
          optionList={{ mode: "manual" }}
          placeholder="Enter value"
          position="center"
          referenceId="onoff_flag"
          size={67.8125}
          summaryAggregationMode="none"
          valueOverride={'{{ self.data[i]["onoff_flag"] }}(전국)'}
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
          size={51.0625}
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
          label="{{(thisYear.value).toString().slice(2)}}목표"
          placeholder="Enter value"
          position="center"
          referenceId="thisYearTarget"
          size={51.0625}
          summaryAggregationMode="none"
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
          size={67.8125}
          summaryAggregationMode="none"
          valueOverride={
            '{{ self.data[i]["target_sales"] === 0 ? null : self.data[i][(thisYear.value).toString()] / self.data[i]["target_sales"] }}'
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
          size={57.453125}
          summaryAggregationMode="none"
          textColor={'{{ item > 0 ? "green" : "red" }}'}
          valueOverride={
            '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
          }
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
          label="{{(thisYear.value-1).toString().slice(2)}}실적"
          placeholder="Enter value"
          position="center"
          referenceId="lastYearRev"
          size={51.171875}
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
          size={82.265625}
          summaryAggregationMode="none"
          textColor={
            '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
          }
          valueOverride="{{ self.data[i][thisYear.value.toString()] / self.data[i][(thisYear.value-1).toString()] - 1 }}"
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
          size={82.265625}
          summaryAggregationMode="none"
          valueOverride="{{ self.data[i][thisYear.value.toString()] - self.data[i][(thisYear.value-1).toString()]}}"
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
          size={50.796875}
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
          referenceId="yearBeforeLastGrowthRate"
          size={81.890625}
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
          referenceId="yeatBeforeLastGrowth"
          size={81.890625}
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
            pluginId="excelDownloadByOnOff"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </ToolbarButton>
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
          params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
          pluginId="selectedRow"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
      </Table>
      <Text
        id="text57"
        value="※ 온라인 매출의 경우, 오프라인 매장의 온라인 매출이 아닌 **온라인 전용 매장의 매출**을 의미합니다"
        verticalAlign="center"
      />
      <Spacer id="spacer7" />
      <Spacer id="spacer5" />
      <Text
        id="text2"
        value="##### 유통채널, 팀, 담당자별 매출 현황"
        verticalAlign="center"
      />
      <Text
        id="text28"
        horizontalAlign="right"
        margin="4px 12px"
        value="단위: 백만원"
        verticalAlign="center"
      />
      <Container
        id="salesTabbedContainer"
        _direction="vertical"
        _gap="0px"
        currentViewKey="{{ self.viewKeys[0] }}"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        margin="0"
        padding="0"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Tabs
            id="tabs4"
            itemMode="static"
            margin="0"
            navigateContainer={true}
            targetContainerId="salesTabbedContainer"
            value="{{ self.values[0] }}"
          >
            <Option id="bc9e8" value="Tab 1" />
            <Option id="8f0cd" value="Tab 2" />
            <Option id="d6b17" value="Tab 3" />
          </Tabs>
        </Header>
        <View id="2ed7b" label="유통채널별" viewKey="type">
          <Table
            id="typeStatTbl2"
            autoColumnWidth={true}
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ salesByType.value }}"
            defaultSelectedRow={{
              mode: "index",
              indexType: "display",
              index: 0,
            }}
            emptyMessage="No rows found"
            enableSaveActions={true}
            groupByColumns={{}}
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
            showSummaryRow={true}
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
              label="유통채널"
              placeholder="Enter value"
              position="center"
              referenceId="tp_group_nm"
              size={57.453125}
              sortMode="disabled"
              summaryAggregationMode="none"
              valueOverride={'{{ self.data[i]["tp_group_nm"] }}'}
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
              size={51.0625}
              summaryAggregationMode="sum"
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
              label="{{(thisYear.value).toString().slice(2)}}목표"
              placeholder="Enter value"
              position="center"
              referenceId="thisYearTarget"
              size={51.0625}
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
              size={67.8125}
              summaryAggregationMode="none"
              valueOverride={
                '{{ self.data[i]["target_sales"] === 0 ? null : self.data[i][(thisYear.value).toString()] / self.data[i]["target_sales"] }}'
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
              size={57.453125}
              summaryAggregationMode="sum"
              textColor={'{{ item > 0 ? "green" : "red" }}'}
              valueOverride={
                '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
              }
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
              label="{{(thisYear.value-1).toString().slice(2)}}실적"
              placeholder="Enter value"
              position="center"
              referenceId="lastYearRev"
              size={51.171875}
              summaryAggregationMode="sum"
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
              size={82.265625}
              summaryAggregationMode="none"
              textColor={
                '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
              }
              valueOverride="{{ self.data[i][thisYear.value.toString()] / self.data[i][(thisYear.value-1).toString()] - 1 }}"
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
              size={82.265625}
              summaryAggregationMode="sum"
              valueOverride="{{ self.data[i][thisYear.value.toString()] - self.data[i][(thisYear.value-1).toString()]}}"
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
              size={50.796875}
              summaryAggregationMode="sum"
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
              referenceId="yearBeforeLastGrowthRate"
              size={81.890625}
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
              referenceId="yeatBeforeLastGrowth"
              size={81.890625}
              summaryAggregationMode="sum"
              valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-2).toString()]}}"
            />
            <Column
              id="2d30f"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              hidden="true"
              label="tp_cd"
              placeholder="Enter value"
              position="center"
              referenceId="tp_cd"
              size={100}
              summaryAggregationMode="none"
              valueOverride={'{{ self.data[i]["tp_cd"] }}'}
            />
            <ToolbarButton
              id="a31a4"
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
                pluginId="excelDownloadByType"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
            </ToolbarButton>
            <Event
              event="clickRow"
              method="show"
              params={{ ordered: [] }}
              pluginId="tpModalFrame"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="clickRow"
              method="setValue"
              params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
              pluginId="selectedRow"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
          </Table>
        </View>
        <View id="79fda" label="팀별" viewKey="team">
          <Table
            id="typeStatTbl26"
            autoColumnWidth={true}
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ salesByTeam.value }}"
            defaultSelectedRow={{
              mode: "index",
              indexType: "display",
              index: 0,
            }}
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
            showSummaryRow={true}
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
              label="팀"
              placeholder="Enter value"
              position="center"
              referenceId="team_nm"
              size={26.359375}
              sortMode="disabled"
              summaryAggregationMode="none"
              valueOverride={'{{ self.data[i]["team_nm"] }}'}
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
              size={51.0625}
              summaryAggregationMode="sum"
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
              label="{{(thisYear.value).toString().slice(2)}}목표"
              placeholder="Enter value"
              position="center"
              referenceId="thisYearTarget"
              size={51.0625}
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
              size={67.8125}
              summaryAggregationMode="none"
              valueOverride={
                '{{ self.data[i]["target_sales"] === 0 ? null : self.data[i][(thisYear.value).toString()] / self.data[i]["target_sales"] }}'
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
              size={57.453125}
              summaryAggregationMode="sum"
              textColor={'{{ item > 0 ? "green" : "red" }}'}
              valueOverride={
                '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
              }
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
              label="{{(thisYear.value-1).toString().slice(2)}}실적"
              placeholder="Enter value"
              position="center"
              referenceId="lastYearRev"
              size={51.171875}
              summaryAggregationMode="sum"
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
              size={82.265625}
              summaryAggregationMode="none"
              textColor={
                '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
              }
              valueOverride="{{ self.data[i][thisYear.value.toString()] / self.data[i][(thisYear.value-1).toString()] - 1 }}"
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
              size={82.265625}
              summaryAggregationMode="sum"
              valueOverride="{{ self.data[i][thisYear.value.toString()] - self.data[i][(thisYear.value-1).toString()]}}"
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
              size={50.796875}
              summaryAggregationMode="sum"
              valueOverride="{{ self.data[i][(thisYear.value-2).toString()]}}"
            >
              <Event
                event="clickCell"
                method="trigger"
                params={{ ordered: [] }}
                pluginId=""
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
            </Column>
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
              size={81.890625}
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
              referenceId="yeatBeforeLastGrowth"
              size={81.890625}
              summaryAggregationMode="sum"
              valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-2).toString()]}}"
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
                pluginId="excelDownloadByTeam"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
            </ToolbarButton>
            <Event
              event="clickRow"
              method="show"
              params={{ ordered: [] }}
              pluginId="tpModalFrame"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="clickRow"
              method="setValue"
              params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
              pluginId="selectedRow"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
          </Table>
        </View>
        <View id="33d57" label="담당자별" viewKey="person">
          <Table
            id="typeStatTbl27"
            autoColumnWidth={true}
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ salesByUser.value }}"
            defaultSelectedRow={{
              mode: "index",
              indexType: "display",
              index: 0,
            }}
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
            showSummaryRow={true}
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
              label="담당자명"
              placeholder="Enter value"
              position="center"
              referenceId="user_nm"
              size={57.453125}
              sortMode="disabled"
              summaryAggregationMode="none"
              valueOverride={'{{ self.data[i]["user_nm"] }}'}
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
              size={51.0625}
              summaryAggregationMode="sum"
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
              label="{{(thisYear.value).toString().slice(2)}}목표"
              placeholder="Enter value"
              position="center"
              referenceId="thisYearTarget"
              size={51.0625}
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
              size={67.8125}
              summaryAggregationMode="none"
              valueOverride={
                '{{ self.data[i]["target_sales"] === 0 ? null : self.data[i][(thisYear.value).toString()] / self.data[i]["target_sales"] }}'
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
              size={57.453125}
              summaryAggregationMode="sum"
              textColor={'{{ item > 0 ? "green" : "red" }}'}
              valueOverride={
                '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
              }
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
              label="{{(thisYear.value-1).toString().slice(2)}}실적"
              placeholder="Enter value"
              position="center"
              referenceId="lastYearRev"
              size={51.171875}
              summaryAggregationMode="sum"
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
              size={82.265625}
              summaryAggregationMode="none"
              textColor={
                '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
              }
              valueOverride="{{ self.data[i][thisYear.value.toString()] / self.data[i][(thisYear.value-1).toString()] - 1 }}"
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
              size={82.265625}
              summaryAggregationMode="sum"
              valueOverride="{{ self.data[i][thisYear.value.toString()] - self.data[i][(thisYear.value-1).toString()]}}"
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
              size={50.796875}
              summaryAggregationMode="sum"
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
              referenceId="yearBeforeLastGrowthRate"
              size={81.890625}
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
              referenceId="yeatBeforeLastGrowth"
              size={81.890625}
              summaryAggregationMode="sum"
              valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-2).toString()]}}"
            />
            <Column
              id="2d30f"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              hidden="true"
              label="user_cd"
              placeholder="Enter value"
              position="center"
              referenceId="user_cd"
              size={100}
              summaryAggregationMode="none"
              valueOverride={'{{ self.data[i]["user_cd"] }}'}
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
                pluginId="excelDownloadByUser"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
            </ToolbarButton>
            <Event
              event="clickRow"
              method="show"
              params={{ ordered: [] }}
              pluginId="tpModalFrame"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="clickRow"
              method="setValue"
              params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
              pluginId="selectedRow"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
          </Table>
        </View>
      </Container>
      <Spacer id="spacer23" />
      <Text
        id="text66"
        value="##### 상품 종목별 매출상세"
        verticalAlign="center"
      />
      <Table
        id="salesBySecondLevelTbl"
        autoColumnWidth={true}
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ salesBySecondLevelWithBiz.value }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        heightType="auto"
        margin="4px 4px"
        rowHeight="medium"
        rowSelection="none"
        showBorder={true}
        showColumnBorders={true}
        showHeader={true}
        style={{ headerBackground: "tokens/356f4e7b" }}
      >
        <Column
          id="6304e"
          alignment="left"
          format="string"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="biz_nm"
          label="사업부"
          placeholder="Enter value"
          position="center"
          referenceId="biz_nm"
          size={47.078125}
          summaryAggregationMode="none"
          valueOverride="{{ item }}"
        />
        <Column
          id="71866"
          alignment="right"
          caption="{{ currentSourceRow.기초류신장율 ?? '-'}}%"
          cellTooltip="{{ item?.toFixed(0) }}"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="기초류"
          label="기초류"
          placeholder="Enter value"
          position="center"
          size={47.078125}
          summaryAggregationMode="none"
          textColor={
            '{{  currentSourceRow.기초류신장율 > 0 ?  "green" : "red"  }}'
          }
          valueOverride="{{ item }}"
        />
        <Column
          id="0ecd5"
          alignment="right"
          caption="{{ currentSourceRow.외의류신장율 ?? '-'}}%"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="외의류"
          label="외의류"
          placeholder="Enter value"
          position="center"
          size={47.078125}
          summaryAggregationMode="none"
          textColor={
            '{{ currentSourceRow.외의류신장율 > 0 ?  "green" : "red"  }}'
          }
          valueOverride="{{ item }}"
        />
        <Column
          id="fb989"
          alignment="right"
          caption="{{ currentSourceRow.발육신장율 ?? '-' }}%"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="발육"
          label="발육"
          placeholder="Enter value"
          position="center"
          size={36.71875}
          summaryAggregationMode="none"
          textColor={
            '{{ currentSourceRow.발육신장율 > 0 ?  "green" : "red"  }}'
          }
          valueOverride="{{ item }}"
        />
        <Column
          id="2ec84"
          alignment="right"
          caption="{{ currentSourceRow.섬유공산품신장율 ?? '-'}}%"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="섬유공산품"
          label="섬유공산품"
          placeholder="Enter value"
          position="center"
          size={67.8125}
          summaryAggregationMode="none"
          textColor={
            '{{ currentSourceRow.섬유공산품신장율 > 0 ? "green" :"red"   }}'
          }
          valueOverride="{{ item }}"
        />
        <Column
          id="e0b93"
          alignment="right"
          caption="{{ currentSourceRow.시즌용품신장율 ?? '-'}}%"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="시즌용품"
          label="시즌용품"
          placeholder="Enter value"
          position="center"
          size={57.453125}
          summaryAggregationMode="none"
          textColor={
            '{{ currentSourceRow.시즌용품신장율 > 0 ?  "green": "red"   }}'
          }
          valueOverride="{{ item }}"
        />
        <Column
          id="b9ad0"
          alignment="right"
          caption="{{ currentSourceRow.일반용품위탁신장율 ?? '-'}}%"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="일반용품위탁"
          label="일반용품위탁"
          placeholder="Enter value"
          position="center"
          size={78.1875}
          summaryAggregationMode="none"
          textColor={
            '{{ currentSourceRow.일반용품위탁신장율 > 0  ?  "green" : "red"   }}'
          }
          valueOverride="{{ item }}"
        />
        <Column
          id="4866d"
          alignment="right"
          caption="{{ currentSourceRow.하드류신장율 ?? '-'}}%"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="하드류"
          label="하드류"
          placeholder="Enter value"
          position="center"
          size={47.078125}
          summaryAggregationMode="none"
          textColor={
            '{{ currentSourceRow.하드류신장율 > 0 ? "green" : "red"  }}'
          }
          valueOverride="{{ item }}"
        />
        <Column
          id="cf1aa"
          alignment="right"
          caption="{{ currentSourceRow.기타신장율 ?? '-'}}%"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="기타"
          label="기타"
          placeholder="Enter value"
          position="center"
          size={36.71875}
          summaryAggregationMode="none"
          textColor={'{{ currentSourceRow.기타신장율 > 0 ? "green" : "red"  }}'}
          valueOverride="{{ item }}"
        />
        <Column
          id="ccb12"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          label="기초류 신장율"
          placeholder="Enter value"
          position="center"
          referenceId="기초류신장율"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.기초류신장율 *100 }}"
        />
        <Column
          id="28bd4"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          label="외의류 신장율"
          placeholder="Enter value"
          position="center"
          referenceId="외의류신장율"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.외의류신장율 *100 }}"
        />
        <Column
          id="6f74f"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          label="발육 신장율"
          placeholder="Enter value"
          position="center"
          referenceId="발육신장율"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.발육신장율 *100 }}"
        />
        <Column
          id="785c3"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          label="섬유공산품 신장율"
          placeholder="Enter value"
          position="center"
          referenceId="섬유공산품신장율"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.섬유공산품신장율 *100 }}"
        />
        <Column
          id="2de14"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          label="시즌용품 신장율"
          placeholder="Enter value"
          position="center"
          referenceId="시즌용품신장율"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.시즌용품신장율 * 100}}"
        />
        <Column
          id="b09bb"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          label="일반용품위탁 신장율"
          placeholder="Enter value"
          position="center"
          referenceId="일반용품위탁신장율"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.일반용품위탁신장율 *100 }}"
        />
        <Column
          id="34169"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          label="하드류 신장율"
          placeholder="Enter value"
          position="center"
          referenceId="하드류신장율"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.하드류신장율 *100 }}"
        />
        <Column
          id="62c32"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          label="기타 신장율"
          placeholder="Enter value"
          position="center"
          referenceId="기타신장율"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.기타신장율 *100 }}"
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
            pluginId="excelDownloadBySecondLevelWithBiz"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </ToolbarButton>
      </Table>
    </ModuleContainerWidget>
  </Frame>
</App>
