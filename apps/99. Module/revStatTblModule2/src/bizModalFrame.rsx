<ModalFrame
  id="bizModalFrame"
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
        size={57.515625}
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
        label="25실적"
        placeholder="Enter value"
        position="center"
        referenceId="2025"
        size={52.296875}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2025"]}}'}
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
        label="24실적"
        placeholder="Enter value"
        position="center"
        referenceId={'"2024"'}
        size={52.296875}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2024"]}}'}
      />
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
        label="23실적"
        placeholder="Enter value"
        position="center"
        referenceId="2023"
        size={52.296875}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["2023"]}}'}
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
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentRow }}" }] }}
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
        size={67.890625}
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
          pluginId="subBrandTbl"
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
          pluginId="subBrandTbl"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</ModalFrame>
