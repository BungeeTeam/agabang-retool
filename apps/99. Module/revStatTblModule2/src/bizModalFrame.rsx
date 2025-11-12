<ModalFrame
  id="bizModalFrame"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
  size="fullScreen"
>
  <Header>
    <Text
      id="modalTitle5"
      value="### {{ selectedRow.value.biz_nm }} 매출 상세"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton3"
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
        pluginId="bizModalFrame"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Text
      id="text40"
      value="#### 판매형태별 매출 현황"
      verticalAlign="center"
    />
    <Text
      id="text39"
      horizontalAlign="right"
      margin="4px 12px"
      value="단위: 백만원"
      verticalAlign="center"
    />
    <Table
      id="salesTypeTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesBySalesType.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
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
      <Include src="./salesTypeTblExpandedRow.rsx" />
      <Column
        id="ffcaf"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="판매구분"
        placeholder="Enter value"
        position="center"
        referenceId="sales_type"
        size={57.453125}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["sales_type"] }}'}
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
        size={50.90625}
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
        referenceId="yearBeforeLastGrowthRate"
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
          pluginId="excelDownloadBySalesType"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="selectedSalesRow"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="salesTypeDetailDrawer"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Text
      id="text58"
      value="※ 정상/이월의 기준은 **각 시즌마다 반품이 가장 많은 달**에 추가 한 달(반품 확인을 위해)을 더해 정의합니다"
      verticalAlign="center"
    />
    <Spacer id="spacer16" />
    <Spacer id="spacer13" />
    <Text
      id="text47"
      value="#### 시즌 및 복종분류별 매출 현황"
      verticalAlign="center"
    />
    <Text
      id="text54"
      horizontalAlign="right"
      margin="4px 12px"
      value="단위: 백만원"
      verticalAlign="center"
    />
    <Include src="./styleTabContainer.rsx" />
    <Spacer id="spacer6" />
    <Spacer id="spacer12" />
    <Text
      id="text37"
      value="#### 서브브랜드별 매출 현황"
      verticalAlign="center"
    />
    <Text
      id="text48"
      horizontalAlign="right"
      margin="4px 12px"
      value="단위: 백만원"
      verticalAlign="center"
    />
    <Table
      id="subBrandTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesBySubBrand.value }}"
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
        label="서브브랜드"
        placeholder="Enter value"
        position="center"
        referenceId="팀"
        size={67.8125}
        sortMode="disabled"
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["sub_br_nm"] }}'}
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
        referenceId="yearBeforeLastRev"
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
          pluginId="excelDownloadBySubBrand"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</ModalFrame>
