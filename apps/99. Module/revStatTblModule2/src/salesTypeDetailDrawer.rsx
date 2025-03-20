<DrawerFrame
  id="salesTypeDetailDrawer"
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
  width="60%"
>
  <Header>
    <Text
      id="drawerTitle1"
      value="### {{ selectedSalesRow.value?.sales_type }} 매출 상세"
      verticalAlign="center"
    />
    <Button
      id="drawerCloseButton1"
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
        pluginId="salesTypeDetailDrawer"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Text
      id="text51"
      margin="0"
      value="###### 상위 카테고리별 매출 현황"
      verticalAlign="center"
    />
    <Text
      id="text53"
      horizontalAlign="right"
      margin="4px 12px"
      value="단위: 백만원"
      verticalAlign="center"
    />
    <Table
      id="salesTypeTbl3"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByFirstLevel.value.filter(item => item.sales_type === selectedSalesRow.value?.sales_type) }}"
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
      <Column
        id="ffcaf"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        label="상위분류"
        placeholder="Enter value"
        position="center"
        referenceId="대분ㄹ"
        size={57.515625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["first_lv_class"] }}'}
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
    </Table>
    <Spacer id="spacer14" />
    <Text
      id="text55"
      margin="0"
      value="###### 차상위 카테고리별 매출 현황"
      verticalAlign="center"
    />
    <Table
      id="salesTypeTbl4"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesBySecondLevel.value.filter(item => item.sales_type === selectedSalesRow.value?.sales_type) }}"
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
      <Column
        id="ffcaf"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        label="상위분류"
        placeholder="Enter value"
        position="center"
        referenceId="first_lv_class"
        size={57.515625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["first_lv_class"] }}'}
      />
      <Column
        id="91aea"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="차상위분류"
        placeholder="Enter value"
        position="center"
        referenceId="second_lv_class"
        size={67.890625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["second_lv_class"] }}'}
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
    </Table>
    <Spacer id="spacer15" />
    <Text
      id="text50"
      margin="0"
      value="###### 시즌계절별 매출 현황"
      verticalAlign="center"
    />
    <Text
      id="text56"
      horizontalAlign="right"
      margin="4px 12px"
      value="단위: 백만원"
      verticalAlign="center"
    />
    <Table
      id="salesTypeTbl2"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesBySeason.value.filter(item => item.sales_type === selectedSalesRow.value?.sales_type).sort((a, b) => a.season_seq - b.season_seq) }}"
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
      <Column
        id="ffcaf"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="시즌명"
        placeholder="Enter value"
        position="center"
        referenceId="sales_type"
        size={47.125}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["season_nm"] }}'}
      />
      <Column
        id="1fa8b"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="시즌코드"
        placeholder="Enter value"
        position="center"
        referenceId="column12"
        size={57.515625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["season_cd"] }}'}
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
        pluginId="selectedRow"
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
  </Body>
</DrawerFrame>
