<ModalFrame
  id="modal_bulk_simulation"
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
  style={{ ordered: [] }}
>
  <Header>
    <Text
      id="modalTitle2"
      value="### 리오더 시뮬레이션"
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
        pluginId="modal_bulk_simulation"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Table
      id="table_reorder_targets"
      alwaysShowRowSelectionCheckboxes={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getReorderReviewList.data.reviewedList }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[]}
      emptyMessage="No rows found"
      groupedColumnConfig={{ expandByDefault: false, size: 115.203125 }}
      heightType="auto"
      rowBackgroundColor=""
      rowHeight="large"
      rowSelection="multiple"
      showBorder={true}
      showColumnBorders={true}
      showFooter={true}
      showHeader={true}
      style={{}}
      toolbarPosition="bottom"
    >
      <Include src="./table_reorder_targetsExpandedRow.rsx" />
      <Column
        id="53bce"
        alignment="center"
        backgroundColor="{{ currentSourceRow.reorder_recommending_status.substring(0, 2) === '긴급' ? '#ffcccc' : currentSourceRow.reorder_recommending_status.substring(0, 2) === '주의' ? '#fff3cd' : '#cce5cc' }}"
        format="string"
        formatOptions={{
          automaticColors: false,
          color:
            "{{currentSourceRow.reorder_recommending_status && currentSourceRow.reorder_recommending_status.includes('긴급 🔴') ? '#FFCCCC' : \n  currentSourceRow.reorder_recommending_status && currentSourceRow.reorder_recommending_status.includes('주의 🟡') ? '#FFFFCC' : \n  currentSourceRow.reorder_recommending_status && currentSourceRow.reorder_recommending_status.includes('양호 🟢') ? '#CCFFCC' : ''}}",
        }}
        groupAggregationMode="none"
        hidden="false"
        key="reorder_recommending_status"
        label="리오더 판단"
        placeholder="Enter value"
        position="left"
        size={71.265625}
        summaryAggregationMode="none"
        textColor="{{currentSourceRow.reorder_recommending_status.substring(0, 2) === '긴급' ? '#8b0000' : 
  currentSourceRow.reorder_recommending_status.substring(0, 2) === '주의' ? '#8a5a00' : 
  '#006400'}}"
        valueOverride="{{currentSourceRow.reorder_recommending_status.substring(0, 2)}}"
      />
      <Column
        id="5d4e6"
        alignment="center"
        format="image"
        formatOptions={{ widthType: "fit" }}
        groupAggregationMode="none"
        label="이미지"
        placeholder="Enter value"
        position="left"
        referenceId="이미지"
        size={65.984375}
        summaryAggregationMode="none"
        valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg"
      >
        <Event
          event="clickCell"
          method="openUrl"
          params={{
            ordered: [
              {
                url: "https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg",
              },
            ],
          }}
          pluginId=""
          type="util"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="cf4c6"
        alignment="center"
        caption="({{ currentSourceRow.sty_cd }})"
        editable="false"
        format="multilineString"
        groupAggregationMode="none"
        key="sty_nm"
        label="품명(스타일명)"
        placeholder="Enter value"
        position="left"
        size={166.671875}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="show"
          params={{ ordered: [] }}
          pluginId="drawerFrame1"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickCell"
          method="setValue"
          params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
          pluginId="clicked_item_sty_cd"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="2c59a"
        alignment="center"
        format="tag"
        formatOptions={{
          automaticColors: false,
          color:
            "{{ JSON.parse(retoolContext.configVars.var_color_dict)[item] }}",
        }}
        groupAggregationMode="none"
        hidden="false"
        key="col_nm"
        label="컬러명"
        placeholder="Select option"
        position="left"
        size={82.8125}
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="430b5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tag_price"
        label="Tag가"
        placeholder="Enter value"
        position="center"
        size={69.171875}
      />
      <Column
        id="92b62"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="cost_price"
        label="원가"
        placeholder="Enter value"
        position="center"
        size={64.390625}
      />
      <Column
        id="d014b"
        alignment="right"
        backgroundColor="{{ currentSourceRow.hasSheetData ? 'lightgreen' : '' }}"
        caption="{{ currentSourceRow.hasSheetData ? '생산팀 입력' : '' }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="modifiableCostPrice"
        label="리오더 원가"
        placeholder="Enter value"
        position="center"
        size={84}
        summaryAggregationMode="none"
      />
      <Column
        id="8cecd"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="sum"
        key="priceMultiple"
        label="배수"
        placeholder="Enter value"
        position="center"
        size={64}
        summaryAggregationMode="none"
      />
      <Column
        id="e8de3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="sum"
        key="priceReorderMultiple"
        label="리오더 배수"
        placeholder="Enter value"
        position="center"
        size={74}
        summaryAggregationMode="none"
      />
      <Column
        id="853ac"
        alignment="left"
        format="date"
        formatOptions={{ dateFormat: "yyyy-MM-dd" }}
        groupAggregationMode="none"
        hidden="true"
        key="first_sales_dt"
        label="첫 판매일"
        placeholder="Enter value"
        position="center"
        size={89.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="d3998"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="last_sales_dt"
        label="마지막 판매일"
        placeholder="Enter value"
        position="center"
        size={89.21875}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="getSizeList"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="ab000"
        alignment="left"
        format="date"
        formatOptions={{ dateFormat: "yyyy-MM-dd" }}
        groupAggregationMode="none"
        hidden="true"
        key="first_inventory_date"
        label="첫 입고일"
        placeholder="Enter value"
        position="center"
        size={89.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="6cfc6"
        alignment="left"
        editable="false"
        format="date"
        formatOptions={{ dateFormat: "yyyy-MM-dd" }}
        groupAggregationMode="none"
        hidden="true"
        key="last_inventory_date"
        label="마지막 입고일"
        placeholder="Enter value"
        position="center"
        size={89.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="76458"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="tot_in_qty"
        label="총 입고량"
        placeholder="Enter value"
        position="center"
        size={73.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="63459"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="tot_sale_qty"
        label="총 판매량"
        placeholder="Enter value"
        position="center"
        size={73.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="0b389"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="multilineString"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="current_stock_qty"
        label="총 재고량"
        placeholder="Enter value"
        position="center"
        size={78.890625}
        summaryAggregationMode="none"
      />
      <Column
        id="e95df"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="false"
        key="wh_stck_qty"
        label="창고 재고"
        placeholder="Enter value"
        position="center"
        size={83.375}
        summaryAggregationMode="none"
      />
      <Column
        id="5d486"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="false"
        key="sh_stck_qty"
        label="매장 재고"
        placeholder="Enter value"
        position="center"
        size={79.640625}
        summaryAggregationMode="none"
      />
      <Column
        id="32149"
        alignment="right"
        backgroundColor="{{ currentSourceRow.hasSheetData ? 'lightgreen' : '' }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="leadTime"
        label="리드타임"
        placeholder="Enter value"
        position="center"
        size={68}
        summaryAggregationMode="none"
      />
      <Column
        id="1fede"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="cust_nm"
        label="생산업체"
        placeholder="Enter value"
        position="center"
        size={113.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="c1585"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="note"
        label="생산팀 비고"
        placeholder="Enter value"
        position="center"
        size={102}
        summaryAggregationMode="none"
      />
      <Column
        id="5e4f7"
        alignment="right"
        backgroundColor="{{ currentSourceRow.hasSheetData ? 'lightgreen' : '' }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="MOQ"
        label="MOQ (최소 생산 수량)"
        placeholder="Enter value"
        position="center"
        size={58}
        summaryAggregationMode="none"
      />
      <Column
        id="cb2f0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        key="sale_rate"
        label="누계 판매율"
        placeholder="Enter value"
        position="center"
        size={76.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="acfb5"
        alignment="right"
        backgroundColor="{{ theme.highlight }}"
        editable="true"
        editableOptions={{ showStepper: true, min: "0", max: "100" }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="expectedSalesRate"
        label="목표 판매율"
        placeholder="Enter value"
        position="center"
        size={75}
        summaryAggregationMode="none"
      />
      <Column
        id="e759a"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sty_cd"
        label="Sty cd"
        placeholder="Enter value"
        position="center"
        size={85.84375}
      />
      <Column
        id="adc0b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="col_cd"
        label="Col cd"
        placeholder="Enter value"
        position="center"
        size={52.25}
      />
      <Column
        id="8590f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="size_cd"
        label="Size cd"
        placeholder="Enter value"
        position="center"
        size={57.3125}
      />
      <Column
        id="405f7"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="groupId"
        label="Group ID"
        placeholder="Enter value"
        position="center"
        size={106.8125}
        summaryAggregationMode="none"
      />
      <Column
        id="739c2"
        alignment="left"
        format="boolean"
        groupAggregationMode="none"
        hidden="true"
        key="_isExpanded"
        label="Is expanded"
        placeholder="Enter value"
        position="center"
        size={85.09375}
        summaryAggregationMode="none"
      />
      <Column
        id="d545f"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="large_cat"
        label="Large cat"
        placeholder="Select option"
        position="center"
        size={69.28125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="b697d"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="middle_cat"
        label="Middle cat"
        placeholder="Enter value"
        position="center"
        size={75.453125}
        summaryAggregationMode="none"
      />
      <Column
        id="99866"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="small_cat"
        label="Small cat"
        placeholder="Enter value"
        position="center"
        size={67.75}
        summaryAggregationMode="none"
      />
      <Column
        id="dad07"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="item_image"
        label="Item image"
        placeholder="Enter value"
        position="center"
        size={78.609375}
        summaryAggregationMode="none"
      />
      <Column
        id="ff2f1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="urgentCount"
        label="Urgent count"
        placeholder="Enter value"
        position="center"
        size={90.4375}
        summaryAggregationMode="none"
      />
      <Column
        id="3d430"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="warningCount"
        label="Warning count"
        placeholder="Enter value"
        position="center"
        size={97.796875}
        summaryAggregationMode="none"
      />
      <Column
        id="1af16"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="size_nm"
        label="Size nm"
        placeholder="Enter value"
        position="center"
        size={60.625}
        summaryAggregationMode="none"
      />
      <Column
        id="c468e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="estimated_stock"
        label="Estimated stock"
        placeholder="Enter value"
        position="center"
        size={106.921875}
        summaryAggregationMode="none"
      />
      <Column
        id="4817d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="total_reorder_count"
        label="총 리오더 횟수"
        placeholder="Enter value"
        position="center"
        size={85.015625}
        summaryAggregationMode="none"
      />
      <Column
        id="fdc35"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="daysUntilOutOfStock_d30"
        label="Days until out of stock d 30"
        placeholder="Enter value"
        position="center"
        size={172.34375}
        summaryAggregationMode="none"
      />
      <Column
        id="d2166"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="daysUntilOutOfStock_d180"
        label="Days until out of stock d 180"
        placeholder="Enter value"
        position="center"
        size={180.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="fd841"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="daysUntilOutOfStock_d365"
        label="Days until out of stock d 365"
        placeholder="Enter value"
        position="center"
        size={180.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="d7ab6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="avg_monthly_sales_d30"
        label="Avg monthly sales d 30"
        placeholder="Enter value"
        position="center"
        size={148.421875}
        summaryAggregationMode="none"
      />
      <Column
        id="f24cf"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="avg_monthly_sales_d180"
        label="Avg monthly sales d 180"
        placeholder="Enter value"
        position="center"
        size={156.1875}
        summaryAggregationMode="none"
      />
      <Column
        id="0ffcc"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="avg_monthly_sales_d365"
        label="Avg monthly sales d 365"
        placeholder="Enter value"
        position="center"
        size={156.1875}
        summaryAggregationMode="none"
      />
      <Column
        id="a23b3"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="status_d30"
        label="Status d 30"
        placeholder="Enter value"
        position="center"
        size={82.125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="4d746"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="status_d180"
        label="Status d 180"
        placeholder="Enter value"
        position="center"
        size={89.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="98a4b"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="status_d365"
        label="Status d 365"
        placeholder="Enter value"
        position="center"
        size={89.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="06796"
        alignment="left"
        format="boolean"
        groupAggregationMode="none"
        hidden="true"
        key="is_discontinued"
        label="Is discontinued"
        placeholder="Enter value"
        position="center"
        size={101.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="d49ba"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="_type"
        label="Type"
        placeholder="Enter value"
        position="center"
        size={57.53125}
        summaryAggregationMode="none"
      />
      <Column
        id="68d0d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="cust_cd"
        label="Cust cd"
        placeholder="Enter value"
        position="center"
        size={74.9375}
        summaryAggregationMode="none"
      />
      <Column
        id="305f2"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="br_nm"
        label="Br nm"
        placeholder="Select option"
        position="center"
        size={79.125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="4e472"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="fabric"
        label="Fabric"
        placeholder="Enter value"
        position="center"
        size={73.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="7e255"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="reorder_recommending_status_brief"
        label="Reorder recommending status brief"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="727ee"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="avgDailySales"
        label="Avg daily sales"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="f9099"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="avgMonthlySales"
        label="최근 180일 월판량"
        placeholder="Enter value"
        position="center"
        size={114}
        summaryAggregationMode="none"
      />
      <Column
        id="72338"
        alignment="right"
        backgroundColor="{{ theme.highlight }}"
        editable="true"
        editableOptions={{ showStepper: true, min: "1" }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "",
        }}
        groupAggregationMode="sum"
        key="expectedSalesPeriod"
        label="예상 판매기간(월)"
        placeholder="Enter value"
        position="center"
        size={103}
        summaryAggregationMode="none"
      >
        <Event
          event="changeCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="getReorderReviewList"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="82fb6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="expectedSalesQty"
        label="목표 판매량"
        placeholder="Enter value"
        position="center"
        size={74}
        summaryAggregationMode="none"
        tooltip="일판량*리드타임"
      />
      <Column
        id="2c53a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="expectedSupplyQty"
        label="목표 생산량"
        placeholder="Enter value"
        position="center"
        size={76}
        summaryAggregationMode="none"
        tooltip="(목표판매량+매장dp용재고-현재고)/목표판매율"
      />
      <Column
        id="7110b"
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
        key="recommended_reorder_qty"
        label="필요 수량"
        placeholder="Enter value"
        position="center"
        size={68.890625}
        summaryAggregationMode="none"
        tooltip="(현재고 - 매장수 × 1 + 생산 리드타임 동안 예상 판매량) ÷ 목표 판매율"
      />
      <Column
        id="527d6"
        alignment="right"
        editable="true"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="final_reorder_qty"
        label="리오더 추천 수량"
        placeholder="Enter value"
        position="center"
        size={100.265625}
        summaryAggregationMode="none"
        tooltip="추천 수량과 최소 주문 수량(MOQ) 중 큰 값"
        valueOverride="{{Math.max(currentSourceRow.MOQ, currentSourceRow.recommended_reorder_qty)}}"
      />
      <Column
        id="1912c"
        alignment="right"
        backgroundColor="{{ theme.highlight }}"
        editable="true"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="final_reorder_qty"
        label="리오더 확정 수량"
        position="center"
        referenceId="finalFixedReorderQty"
        size={100}
        summaryAggregationMode="none"
        tooltip="입력의 편의를 위해 리오더 추천 수량과 동일한 값으로 미리 채워둡니다"
      />
      <Column
        id="b3e8a"
        alignment="left"
        format="boolean"
        groupAggregationMode="none"
        hidden="true"
        key="hasSheetData"
        label="Has sheet data"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="b300a"
        alignment="center"
        format="button"
        formatOptions={{ automaticColors: true, variant: "solid" }}
        groupAggregationMode="none"
        key="exclude_button"
        label="리오더 제외"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Event
        event="save"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="discontinuedProductsQuery"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Button id="button4" text="전체 아이템에 적용하기">
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getReorderReviewList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="refresh"
        params={{ ordered: [] }}
        pluginId="table_reorder_targets"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <NumberInput
      id="inputExpectedSalesRate"
      currency="USD"
      format="percent"
      inputValue={0}
      label="목표 판매율"
      showSeparators={true}
      showStepper={true}
      value="0.8"
    />
    <NumberInput
      id="inputExpectedSalesPeriod"
      currency="USD"
      inputValue={0}
      label="예상 판매기간(월)"
      showSeparators={true}
      showStepper={true}
      value="6"
    />
  </Body>
  <Footer>
    <Button id="button3" text="리오더 내역 저장 & 엑셀 다운로드">
      <Event
        event="click"
        method="exportData"
        params={{
          ordered: [
            { fileType: "xlsx" },
            { data: "{{ table_reorder_targets.data }}" },
            { options: { ordered: [{ sheetName: "리오더_확정내역" }] } },
            {
              fileName:
                "리오더_확정내역_{{new Date().toISOString().slice(2, 10).replace(/-/g, '.')}}_{{current_user.fullName}}",
            },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Footer>
</ModalFrame>
