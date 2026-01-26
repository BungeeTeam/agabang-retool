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
    <Container
      id="stack9"
      _align="center"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="46940" viewKey="View 1">
        <Text
          id="text29"
          margin="4px 4px 4px 0px"
          style={{
            ordered: [
              { fontSize: "20px" },
              { fontWeight: "700" },
              { fontFamily: "pretendard variable" },
            ],
          }}
          value="리오더 시뮬레이션"
          verticalAlign="center"
        />
        <Icon
          id="icon1"
          icon="bold/interface-alert-information-circle"
          margin="0"
        >
          <Event
            event="click"
            method="show"
            params={{ ordered: [] }}
            pluginId="modalFrame3"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Icon>
      </View>
    </Container>
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
    <Button id="button4" text="전체 아이템에 적용하기">
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getReorderReviewList2"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="refresh"
        params={{ ordered: [] }}
        pluginId="table_reorder_targets2"
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
    <Table
      id="table_reorder_targets2"
      actionsOverflowPosition={1}
      alwaysShowRowSelectionCheckboxes={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{editableReviewedList.value}}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[]}
      emptyMessage="No rows found"
      enableExpandableRows={true}
      enableSaveActions={true}
      groupedColumnConfig={{ expandByDefault: false, size: 115.203125 }}
      primaryKeyColumnId="405f7"
      rowBackgroundColor=""
      rowHeight="large"
      showBorder={true}
      showColumnBorders={true}
      showFooter={true}
      showHeader={true}
      style={{}}
      toolbarPosition="bottom"
    >
      <Include src="./table_reorder_targets2ExpandedRow.rsx" />
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
        size={71.25}
        textColor="{{currentSourceRow.reorder_recommending_status.substring(0, 2) === '긴급' ? '#8b0000' : 
  currentSourceRow.reorder_recommending_status.substring(0, 2) === '주의' ? '#8a5a00' : 
  '#006400'}}"
        valueOverride="{{currentSourceRow.reorder_recommending_status.substring(0, 2)}}"
      />
      <Column
        id="5d4e6"
        alignment="center"
        format="image"
        formatOptions={{
          showUnderline: "hover",
          underlineStyle: "solid",
          widthType: "fit",
        }}
        groupAggregationMode="none"
        key="image_url"
        label="이미지"
        placeholder="Enter value"
        position="left"
        referenceId="이미지"
        size={68.984375}
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
        size={114}
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
        size={82.796875}
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="405f7"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="groupId"
        label="Group ID"
        placeholder="Enter value"
        position="center"
        size={108.265625}
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
        size={75.15625}
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
        size={74.390625}
      />
      <Column
        id="10b2c"
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
        size={62.578125}
        summaryAggregationMode="none"
        tooltip="=Tag가/원가
(단, 원가 > 0)"
      />
      <Column
        id="d014b"
        alignment="right"
        backgroundColor="{{ currentSourceRow.has_sheet_data ? 'lightgreen' : '' }}"
        caption="{{ currentSourceRow.has_sheet_data ? '생산팀 입력' : '' }}"
        editable="true"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="modifiableCostPrice"
        label="리오더 원가"
        placeholder="Enter value"
        position="center"
        size={87.25}
        summaryAggregationMode="none"
        tooltip="리오더 시 적용될 원가"
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
        size={91.25}
        summaryAggregationMode="none"
        tooltip="=Tag가/리오더 원가 단, 리오더 원가 > 0이먀 리오더 원가 변경 후 Save 시 재계산됨.
"
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
        size={74.890625}
        summaryAggregationMode="none"
        tooltip="시스템 상 집계된 총 재고 수량 (총 입고량 - 총 판매량)"
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
        size={84.890625}
        summaryAggregationMode="none"
        tooltip="창고에 보관 중인 재고 수량"
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
        size={79.890625}
        summaryAggregationMode="none"
        tooltip="매장에 보유 중인 재고 수량"
      />
      <Column
        id="caefb"
        alignment="right"
        backgroundColor="{{ currentSourceRow.has_sheet_data ? 'lightgreen' : '' }}"
        editable="true"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="manufacturer_stock"
        label="업체 재고"
        placeholder="Enter value"
        position="center"
        size={79.890625}
        summaryAggregationMode="none"
        tooltip="생산처(공장)에서 보유 중인 재고.
수정 후 Save 시 '총 재고량'과 합산되어 리오더 수량 및 기말 재고 계산에 영향을 줌."
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
        size={79.71875}
      />
      <Column
        id="3d64d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="lead_time_days"
        label="리드타임"
        placeholder="Enter value"
        position="center"
        size={76.25}
      />
      <Column
        id="55899"
        alignment="right"
        backgroundColor="{{ currentSourceRow.has_sheet_data ? 'lightgreen' : '' }}"
        editable={true}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="confirmed_lead_time"
        label="확정 리드타임"
        placeholder="Enter value"
        position="center"
        size={90.828125}
      />
      <Column
        id="4ff57"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="moq"
        label="MOQ"
        placeholder="Enter value"
        position="center"
        size={66.125}
        tooltip="생산 가능한 최소 주문 수량"
      />
      <Column
        id="1e807"
        alignment="right"
        backgroundColor="{{ currentSourceRow.has_sheet_data ? 'lightgreen' : '' }}"
        editable="true"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="confirmed_moq"
        label="확정 MOQ"
        placeholder="Enter value"
        position="center"
        size={103.6875}
        summaryAggregationMode="none"
        tooltip="리오더 시 생산 가능한 최소 주문 수량"
      />
      <Column
        id="c1585"
        alignment="center"
        backgroundColor="{{ currentSourceRow.has_sheet_data ? 'lightgreen' : '' }}"
        format="string"
        groupAggregationMode="none"
        key="note"
        label="생산팀 비고"
        placeholder="Enter value"
        position="center"
        size={97.25}
        tooltip="생산팀에서 입력한 특이사항 등 코멘트"
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
        size={90.25}
        tooltip="=총 판매 수량/총 입고 수량"
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
        size={87.296875}
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
        size={52.234375}
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
        size={57.296875}
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
        size={60.609375}
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
        size={57.515625}
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
        size={65.921875}
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
        size={51.25}
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
        size={99.515625}
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
        size={118.328125}
        tooltip="=180일간 총 판매량 ÷ 6(월)"
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
        size={121.71875}
        tooltip="리오더 이후 판매가 예상되는 기간"
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
        id="91e86"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        hidden="false"
        key="estimatedFinalSaleRate"
        label="예상 누계 판매율"
        placeholder="Enter value"
        position="center"
        size={101.390625}
        summaryAggregationMode="none"
        tooltip="= (누계 판매량 + 전체 기간 예상 판매량) / (총 입고량 + 최종 리오더 수량)"
      />
      <Column
        id="95488"
        alignment="right"
        backgroundColor="{{ theme.highlight }}"
        editable="true"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="target_sale_rate"
        label="목표 판매율"
        placeholder="Enter value"
        position="center"
        size={92.640625}
        summaryAggregationMode="none"
        tooltip="리오더한 상품의 판매 목표 비율로, 리오더 필요 수량 계산 시 분모로 사용됨.

기본 80%로 설정하며, 이는 입고된 상품 중 80%가 판매될 것을 목표로 한다는 의미임. "
      />
      <Column
        id="4e6e5"
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
        key="totalExpectedSalesQty"
        label="전체 기간 예상 판매량"
        placeholder="Enter value"
        position="center"
        size={136.53125}
      />
      <Column
        id="ed702"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="emergency_stock"
        label="안전 재고"
        placeholder="Enter value"
        position="center"
        size={76.890625}
        summaryAggregationMode="none"
        tooltip="매장 dp용 수량으로, (매장 수×1) 으로 계산"
      />
      <Column
        id="9b30a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="expected_sales"
        label="리드타임 예상 판매량"
        placeholder="Enter value"
        position="center"
        size={142.890625}
        tooltip="리오더 생산기간(리드타임) 동안 예상되는 판매 수량
= 일평균 판매량 × 확정 리드타임

여기서 사용된 일평균 판매량은 다음 우선순위로 선택함:
1. 최근 180일 데이터가 있으면 해당 기간의 일평균
2. 180일 데이터가 없으면 최근 365일 데이터의 일평균
3. 위 두 기간 데이터가 없으면 최근 30일 데이터의 일평균"
      />
      <Column
        id="c4f7d"
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
        key="estimatedEndingStock"
        label="예상 잔여 재고"
        placeholder="Enter value"
        position="center"
        size={106.921875}
        summaryAggregationMode="none"
        tooltip="리오더 후 예상 판매기간이 지난 후 남을 것으로 예상되는 재고량"
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
        size={90.25}
        summaryAggregationMode="none"
        tooltip="=(전체 기간 예상 판매량 + 안전 재고 - (총 재고량 + 업체 재고)) / 목표 판매율"
      />
      <Column
        id="cf6bf"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="recommended_reorder_qty"
        label="리오더 필요 수량"
        placeholder="Enter value"
        position="center"
        size={114.875}
        summaryAggregationMode="none"
        tooltip={
          '"(전체 기간 예상 판매량 + 안전 재고 - (총 재고량 + 업체 재고)) / 목표 판매율"을 10단위로 반올림'
        }
      />
      <Column
        id="60812"
        alignment="right"
        backgroundColor="{{ theme.highlight }}"
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
        label="리오더 확정 수량"
        placeholder="Enter value"
        position="center"
        size={119.1875}
        tooltip="리오더 필요 수량과 MOQ 중 큰 값을 채워둔 최종 리오더할 수량.
실제 MD분들이 원하는 값으로 수정해서 저장하시면 됩니다!"
      />
      <Column
        id="d08a3"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="effective_monthly_sales"
        label="Effective monthly sales"
        placeholder="Enter value"
        position="center"
        size={147.515625}
      />
      <Column
        id="2abab"
        alignment="left"
        format="boolean"
        groupAggregationMode="none"
        hidden="true"
        key="has_sheet_data"
        label="Has sheet data"
        placeholder="Enter value"
        position="center"
        size={101.703125}
      />
      <Action id="5bebd" icon="bold/interface-delete-bin-2" label="리오더 제외">
        <Event
          event="clickAction"
          method="run"
          params={{
            ordered: [
              {
                src: "// 현재 클릭된 행의 고유 식별자(sty_cd, col_cd) 가져오기\n// Retool 테이블 내에서 현재 행 데이터는 'currentRow' 또는 'item' 변수로 접근 가능합니다.\n// 사용 중인 Retool 버전에 따라 변수 이름이 다를 수 있으니 확인하세요.\n// 여기서는 'currentRow'를 예시로 사용합니다.\nconst styleCodeToRemove = currentSourceRow.sty_cd;\nconst colorCodeToRemove = currentSourceRow.col_cd;\n\n// selectedReorderItems 상태에서 현재 값 가져오기\nconst currentItems = selectedReorderItems.value || [];\n\n// 클릭된 행에 해당하는 항목을 제외한 새 배열 생성\nconst updatedItems = currentItems.filter(item =>\n    !(item.sty_cd === styleCodeToRemove && item.col_cd === colorCodeToRemove)\n);\n\n// 업데이트된 배열로 selectedReorderItems 상태 업데이트\nselectedReorderItems.setValue(updatedItems);\n\n// 중요: getReorderReviewList 쿼리가 selectedReorderItems 변경 시 자동으로\n// 재실행되도록 설정되어 있어야 합니다. 만약 자동으로 안되면 아래 주석 해제\ngetReorderReviewList2.trigger();",
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Action>
      <Event
        event="save"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="saveTableEdits"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Text id="text1" verticalAlign="center" />
    <Container
      id="stack7"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="8593e" viewKey="View 1">
        <Text
          id="text27"
          margin="4px 4px 4px 0px"
          style={{
            ordered: [
              { fontSize: "20px" },
              { fontWeight: "700" },
              { fontFamily: "pretendard variable" },
            ],
          }}
          value="🧸 용품 판매현황"
          verticalAlign="center"
        />
        <Container
          id="stack8"
          _direction="vertical"
          _gap="0px"
          _type="stack"
          footerPadding="4px 12px"
          headerPadding="4px 12px"
          margin="0"
          padding="0"
          showBody={true}
          showBorder={false}
        >
          <View id="8593e" viewKey="View 1">
            <ToggleLink
              id="toggleLink3"
              allowWrap={true}
              margin="12px 8px 4px 0px"
              style={{
                ordered: [
                  { fontSize: "12px" },
                  { fontWeight: "600" },
                  { fontFamily: "pretendard variable" },
                  { text: "#00a0e6" },
                ],
              }}
              text="{{ self.value ? '집계방법 접기' : '집계방법 확인하기' }}"
            >
              <Event
                event="change"
                method="trigger"
                params={{ ordered: [] }}
                pluginId="summary_sebu_prev"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
            </ToggleLink>
            <Text
              id="text28"
              disableMarkdown={true}
              hidden="{{ toggleLink3.value ? false : true }}"
              imageWidth="fill"
              margin="0px 8px 4px 12px"
              style={{
                ordered: [
                  { fontSize: "10px" },
                  { fontWeight: "400" },
                  { fontFamily: "pretendard variable" },
                  { background: "rgba(0, 0, 0, 0.14)" },
                ],
              }}
              value="1. 브랜드 코드: 01, 02, 58, 71, 72, 73, 74, 76, 77, 75, 79
   단, 아래 내용은 예외 처리되어요
        - 브랜드 코드 76: 더블하트, 스와들업만 포함
        - 브랜드 코드 77: 스토케는 제외
2. 시즌코드: 0
3. 대분류코드: 6 또는 8
4. 조회 기간 내 ‘1건 이상’ 구매가 발생한 상품"
              verticalAlign="center"
            />
          </View>
        </Container>
      </View>
    </Container>
  </Body>
  <Footer>
    <Button id="button3" text="리오더 내역 저장 & 엑셀 다운로드">
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="insertMDDecisionsToDB"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="exportData"
        params={{
          ordered: [
            {
              options: {
                ordered: [
                  {
                    fileName:
                      "리오더_확정내역_{{new Date().toISOString().slice(2, 10).replace(/-/g, '.')}}_{{current_user.fullName}}",
                  },
                  { fileType: "xlsx" },
                  { includeHiddenColumns: false },
                ],
              },
            },
          ],
        }}
        pluginId="table_reorder_targets2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Footer>
</ModalFrame>
