<ModalFrame
  id="onoffModalFrame"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showFooter={true}
  showHeader={true}
  showOverlay={true}
  size="fullScreen"
>
  <Header>
    <Text
      id="onoffModalFrameHeader"
      value="### {{ selectedRow.value.onoff_flag }} 매출 상세"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton4"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ ordered: [{ border: "transparent" }] }}
      styleVariant="outline"
    >
      <Event
        event="click"
        method="setHidden"
        params={{ ordered: [{ hidden: true }] }}
        pluginId="onoffModalFrame"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Text
      id="text60"
      value="#### 판매형태별 매출 현황"
      verticalAlign="center"
    />
    <Text
      id="text62"
      horizontalAlign="right"
      margin="4px 12px"
      value="단위: 백만원"
      verticalAlign="center"
    />
    <Table
      id="salesTypeTbl5"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByGb.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      groupByColumns={{}}
      heightType="auto"
      hidden=""
      margin="0"
      rowBackgroundColor=""
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "#f5f5f5" }}
    >
      <Column
        id="ffcaf"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="매장판매구분"
        placeholder="Enter value"
        position="center"
        referenceId="sale_gb"
        size={78.21875}
        valueOverride={'{{ self.data[i]["sale_gb"] }}'}
      />
      <Column
        id="5db18"
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
        label="{{(thisYear.value).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearRev"
        size={50.9375}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()]}}"
      />
      <Column
        id="fc51e"
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
        key="rev"
        label="{{(thisYear.value-1).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="lastYearRev"
        size={51.09375}
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
        size={82.203125}
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
        size={82.203125}
        summaryAggregationMode="none"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-1).toString()]}}"
      />
      <Column
        id="fc213"
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
        label="{{(thisYear.value-2).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="yearBeforeLastRev"
        size={51.1875}
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
        size={82.296875}
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
        size={82.296875}
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
          pluginId="excelDownloadByGB"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Spacer id="spacer19" />
    <Spacer id="spacer20" />
    <Text
      id="text61"
      hidden={'{{ selectedRow.value?.onoff_flag?.includes("온라인") }}'}
      value="#### 지역별 매출 현황"
      verticalAlign="center"
    />
    <Text
      id="text46"
      hidden={'{{ selectedRow.value?.onoff_flag?.includes("온라인") }}'}
      horizontalAlign="right"
      margin="4px 12px"
      value="단위: 백만원"
      verticalAlign="center"
    />
    <Table
      id="typeStatTbl25"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByArea.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden={'{{ selectedRow.value?.onoff_flag?.includes("온라인") }}'}
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
        label="지역"
        placeholder="Enter value"
        position="center"
        referenceId="팀"
        size={36.734375}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["area_nm"] }}'}
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
        size={50.9375}
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
        size={50.9375}
        summaryAggregationMode="none"
        valueOverride={
          '{{ self.data[i]["target_sales"] === 0 ? null: self.data[i]["target_sales"] }}'
        }
      />
      <Column
        id="b97a4"
        alignment="right"
        backgroundColor={'{{ item < 1 ? "rgba(237, 41, 57, 0.1)" : null }}'}
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
        size={67.859375}
        summaryAggregationMode="none"
        valueOverride={
          '{{ self.data[i]["target_sales"] === 0 ? null : self.data[i][thisYear.value] / self.data[i]["target_sales"] }}'
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
        size={57.484375}
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
        size={51.09375}
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
        size={82.203125}
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
        size={82.203125}
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
        size={51.1875}
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
        size={82.296875}
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
        size={82.296875}
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
          pluginId="excelDownloadByArea"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</ModalFrame>
