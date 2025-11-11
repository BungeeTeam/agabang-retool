<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <GlobalWidgetProp id="var_brand_code" value="'07'" />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrame3.rsx" />
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
      isGlobalWidgetContainer={true}
      var_brand_code="'07'"
    >
      <Text
        id="text31"
        value="#### 핵심 개념 이해하기
리오더 시뮬레이션은 다음 세 가지 핵심 요소를 중심으로 진행됩니다:

- 현재 상태: 현재 재고와 판매 데이터
- 설정 값: 목표 판매율, 판매 기간, 리드타임 등
- 계산 결과: 리오더 수량 및 예상 결과

#### 주요 값 설명
1. 입력 데이터
    - 총 재고량: 현재 보유한 총 재고 수량 (매장 재고 + 창고 재고)
    - 업체 재고: 생산업체가 보유한 추가 재고
    - 일평균 판매량: 과거 판매 데이터 기반 일일 평균 판매량(180일 > 365일 > 30일 순 우선적용)

2. 설정 값
    - 확정 리드타임: 리오더 발주부터 입고까지 소요되는 일수
    - 예상 판매기간: 리오더 이후 상품 판매를 예상하는 기간(월)
    - 목표 판매율: 리오더한 상품의 판매 목표 비율(기본 80%)
    - 확정 MOQ: 최소 주문 가능 수량
    - 안전 재고: 최소한으로 유지해야 할 재고(일반적으로 매장 수 × 1)

3. 계산 값
    - 리드타임 예상 판매량: 리드타임 동안 예상되는 판매량
    - 전체 기간 예상 판매량: 설정한 판매 기간 동안 예상되는 총 판매량
    - 리오더 필요 수량: 계산된 리오더 필요 수량 (반올림 전).
      - (전체 기간 예상 판매량 + 안전 재고 - (총 재고량 + 업체 재고)) ÷ 목표 판매율
    - 최종 리오더 수량: 리오더 필요량을 10단위로 올리고 MOQ와 비교해 최종 결정
      - MAX(리오더 필요량 올림값, 확정 MOQ)
    - 예상 잔여 재고: 리오더 후 판매 기간이 지난 후 예상되는 남은 재고
      - (총 재고량 + 업체 재고 + 최종 리오더 수량) - 전체 기간 예상 판매량
    - 예상 최종 판매율: 리오더와 예상 판매를 포함한 최종 예상 판매율
      - (누계 판매량 + 전체 기간 예상 판매량) ÷ (총 입고량 + 최종 리오더 수량)"
        verticalAlign="center"
      />
      <Container
        id="stack11"
        _align="center"
        _flexWrap={true}
        _gap="0px"
        _type="stack"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        margin="0"
        padding="0"
        showBody={true}
        showBorder={false}
        style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
      >
        <View id="5bfc2" viewKey="View 1">
          <Text
            id="text37"
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
        </View>
      </Container>
      <Container
        id="stack12"
        _flexWrap={true}
        _gap="0px"
        _justify="end"
        _type="stack"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        margin="0"
        padding="0"
        showBody={true}
        showBorder={false}
        style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
      >
        <View id="55a72" viewKey="View 1">
          <NumberInput
            id="inputExpectedSalesRate"
            currency="USD"
            format="percent"
            inputValue={0}
            label="목표 판매율"
            labelWidth="50"
            showSeparators={true}
            showStepper={true}
            value="0.8"
          />
          <Button id="button4" disabled="" text="전체 아이템에 적용하기">
            <Event
              event="click"
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
              pluginId="getReorderReviewList"
              type="datasource"
              waitMs="0"
              waitType="debounce"
            />
          </Button>
          <NumberInput
            id="inputExpectedSalesPeriod"
            currency="USD"
            inputValue={0}
            label="예상 판매기간(월)"
            labelWidth="65"
            showSeparators={true}
            showStepper={true}
            value="6"
          />
          <Multiselect
            id="multiselect1"
            captionByIndex="{{ item.content[0].sty_nm }} 외 {{ item.content.length - 1 }}개"
            data="{{ get_reorder_simulation_targets.data }}"
            emptyMessage="No options"
            label="시뮬레이션 저장 일시"
            labels="{{ moment(item.timestamp).format('YYYY-MM-DD HH:MM') }}"
            labelWidth="20"
            overlayMaxHeight={375}
            placeholder="리오더 일시를 선택해주세요"
            showSelectionIndicator={true}
            value="[{{ self.data[0].id }}]"
            values="{{ item.id }}"
            wrapTags={true}
          >
            <Event
              event="change"
              method="run"
              params={{
                ordered: [
                  {
                    src: "await reorderSimulationTargets.setValue( formatDataAsObject(get_reorder_simulation_targets.data.filter(i=> multiselect1.value.includes(i.id))).content.flat())\ngetReorderReviewList.trigger();\n",
                  },
                ],
              }}
              pluginId=""
              type="script"
              waitMs="0"
              waitType="debounce"
            />
          </Multiselect>
        </View>
      </Container>
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
        enableSaveActions={true}
        groupedColumnConfig={{ expandByDefault: false, size: 115.203125 }}
        heightType="auto"
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
        <Include src="./src/table_reorder_targets2ExpandedRow.rsx" />
        <Column
          id="7f450"
          alignment="center"
          backgroundColor="{{ currentSourceRow.wh_reorder_recommending_status.substring(0, 2) === '긴급' ? '#ffcccc' : currentSourceRow.wh_reorder_recommending_status.substring(0, 2) === '주의' ? '#fff3cd' : '#cce5cc' }}"
          format="string"
          groupAggregationMode="none"
          key="wh_reorder_recommending_status"
          label="창고 재고 기준 리오더 판단"
          placeholder="Enter value"
          position="left"
          size={74}
          summaryAggregationMode="none"
          textColor="{{currentSourceRow.wh_reorder_recommending_status.substring(0, 2) === '긴급' ? '#8b0000' : 
  currentSourceRow.wh_reorder_recommending_status.substring(0, 2) === '주의' ? '#8a5a00' : 
  '#006400'}}"
        />
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
          size={70.28125}
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
          size={60.140625}
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
          editable="false"
          format="multilineString"
          groupAggregationMode="none"
          key="sty_nm"
          label="품명(스타일명)"
          placeholder="Enter value"
          position="left"
          size={97.546875}
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
          id="e759a"
          alignment="center"
          editable="false"
          format="multilineString"
          groupAggregationMode="none"
          hidden="false"
          key="sty_cd"
          label="품번"
          placeholder="Enter value"
          position="left"
          size={87.859375}
          summaryAggregationMode="none"
        />
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
          size={78.359375}
          summaryAggregationMode="none"
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
          size={109.828125}
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
          size={72.171875}
        />
        <Column
          id="92b62"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="false"
          key="cost_price"
          label="기존 원가"
          placeholder="Enter value"
          position="center"
          size={74.171875}
          summaryAggregationMode="none"
          tooltip="리오더 전 원가"
        />
        <Column
          id="10b2c"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "2",
          }}
          groupAggregationMode="sum"
          hidden="false"
          key="priceMultiple"
          label="기존 배수"
          placeholder="Enter value"
          position="center"
          size={62.765625}
          summaryAggregationMode="none"
          tooltip="=Tag가/기존 원가
(단, 기존 원가 > 0)"
          valueOverride="{{(item).toFixed(2)}}"
        />
        <Column
          id="d014b"
          alignment="right"
          backgroundColor="{{ currentSourceRow.has_sheet_data ? 'lightgreen' : '#FDE68A' }}"
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
          size={80.28125}
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
            decimalPlaces: "2",
          }}
          groupAggregationMode="sum"
          key="priceReorderMultiple"
          label="리오더 배수"
          placeholder="Enter value"
          position="center"
          size={88.28125}
          summaryAggregationMode="none"
          tooltip="=Tag가/리오더 원가 단, 리오더 원가 > 0이먀 리오더 원가 변경 후 Save 시 재계산됨.
"
          valueOverride="{{(item).toFixed(2)}}"
        />
        <Column
          id="0b389"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="current_stock_qty"
          label="총 재고량"
          placeholder="Enter value"
          position="center"
          size={76.90625}
          summaryAggregationMode="none"
          tooltip="=총입고량-총판매량+업체재고

(드물게 불량 반품 등의 이유로 인해 매장재고+창고재고+업체재고와 값이 다른 경우도 있습니다.)"
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
          size={79.90625}
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
          size={80.90625}
          summaryAggregationMode="none"
          tooltip="매장에 보유 중인 재고 수량"
        />
        <Column
          id="caefb"
          alignment="right"
          backgroundColor="{{ currentSourceRow.has_sheet_data ? 'lightgreen' : '#FDE68A' }}"
          editable="true"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="manufacturer_stock"
          label="업체 재고"
          placeholder="Enter value"
          position="center"
          size={77.90625}
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
          size={84.53125}
        />
        <Column
          id="3d64d"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="lead_time_days"
          label="리드타임"
          placeholder="Enter value"
          position="center"
          size={57.53125}
          summaryAggregationMode="none"
        />
        <Column
          id="55899"
          alignment="right"
          backgroundColor="{{ currentSourceRow.has_sheet_data ? 'lightgreen' : '#FDE68A' }}"
          editable="true"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="confirmed_lead_time"
          label="확정 리드타임"
          placeholder="Enter value"
          position="center"
          size={96.65625}
          summaryAggregationMode="none"
        />
        <Column
          id="4ff57"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="moq"
          label="MOQ"
          placeholder="Enter value"
          position="center"
          size={64.953125}
          summaryAggregationMode="none"
          tooltip="생산 가능한 최소 주문 수량"
        />
        <Column
          id="1e807"
          alignment="right"
          backgroundColor="{{ currentSourceRow.has_sheet_data == true ? 'lightgreen' : '#FDE68A' }}"
          editable="true"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="confirmed_moq"
          label="확정 MOQ"
          placeholder="Enter value"
          position="center"
          size={86.078125}
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
          size={161.28125}
          summaryAggregationMode="none"
          tooltip="생산팀에서 입력한 특이사항 등 코멘트"
        />
        <Column
          id="cb2f0"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="string"
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
          size={90.28125}
          summaryAggregationMode="none"
          tooltip="=총 판매 수량/총 입고 수량"
          valueOverride="{{(item * 100).toFixed(0) + '%'}}"
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
          size={52.265625}
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
          size={57.328125}
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
          size={57.546875}
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
          size={65.953125}
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
          size={51.28125}
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
          size={99.546875}
        />
        <Column
          id="f9099"
          alignment="right"
          backgroundColor="{{ theme.highlight }}"
          editable="true"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "",
          }}
          groupAggregationMode="sum"
          key="avgMonthlySales"
          label="월 판매량"
          placeholder="Enter value"
          position="center"
          size={95.359375}
          summaryAggregationMode="none"
          tooltip="기본값: 180일간 총 판매량 ÷ 6(개월)"
          valueOverride="{{ item.toFixed(0) }}"
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
          size={130.171875}
          summaryAggregationMode="none"
          tooltip={
            '리오더 생산기간(리드타임) 동안 예상되는 판매 수량\n= 일평균 판매량 × 확정 리드타임\n\n기본값으로 채워지는 일평균 판매량은 다음 우선순위로 선택함:\n1. 최근 180일 데이터가 있으면 해당 기간의 일평균\n2. 180일 데이터가 없으면 최근 365일 데이터의 일평균\n3. 위 두 기간 데이터가 없으면 최근 30일 데이터의 일평균\n\n그리고 이 테이블에서 "월 판매량"을 변경하는 경우, 해당 월 판매량에 맞춰 다시 계산함\n= (입력된 월 판매량/30) × 확정 리드타임'
          }
          valueOverride="{{ item.toFixed(0) }}"
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
          size={117.734375}
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
          id="95488"
          alignment="right"
          backgroundColor="{{ theme.highlight }}"
          editable="true"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          key="target_sale_rate"
          label="목표 판매율"
          placeholder="Enter value"
          position="center"
          size={90.28125}
          summaryAggregationMode="none"
          tooltip="리오더한 상품의 판매 목표 비율로, 리오더 필요 수량 계산 시 분모로 사용됨.

기본 80%로 설정하며, 이는 입고된 상품 중 80%가 판매될 것을 목표로 한다는 의미임. "
          valueOverride="{{(item * 100).toFixed(0) + '%'}}"
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
          size={134.546875}
          summaryAggregationMode="none"
          valueOverride="{{ item.toFixed(0) }}"
        />
        <Column
          id="91e86"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="string"
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
          size={111.421875}
          summaryAggregationMode="none"
          tooltip="= (누계 판매량 + 전체 기간 예상 판매량) / (총 입고량 + 최종 리오더 수량)"
          valueOverride="{{(item * 100).toFixed(0) + '%'}}"
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
          size={72.90625}
          summaryAggregationMode="none"
          tooltip="매장 dp용 수량으로, (매장 수×1) 으로 계산"
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
          size={83.28125}
          summaryAggregationMode="none"
          tooltip="=(전체 기간 예상 판매량 + 안전 재고 - 총 재고량)"
          valueOverride="{{ item.toFixed(0) }}"
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
          size={109.421875}
          summaryAggregationMode="none"
          tooltip={
            '"(전체 기간 예상 판매량 + 안전 재고 - 총 재고량 ) / 목표 판매율"을 10단위 올림한 값'
          }
          valueOverride="{{ item.toFixed(0) }}"
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
          size={110.421875}
          tooltip="리오더 필요 수량과 MOQ 중 큰 값을 채워둔 최종 리오더할 수량.
실제 MD분들이 원하는 값으로 수정해서 저장하시면 됩니다!"
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
          size={97.03125}
          summaryAggregationMode="none"
          tooltip="리오더 후 예상 판매기간이 지난 후 남을 것으로 예상되는 재고량

=(총 재고량 + 리오더 확정 수량) - 전체 기간 예상 판매량"
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
          size={147.53125}
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
          size={101.734375}
          summaryAggregationMode="none"
        />
        <Column
          id="01609"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="tot_in_qty"
          label="Tot in qty"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
        />
        <Column
          id="e10c6"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="tot_sale_qty"
          label="Tot sale qty"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
        />
        <Column
          id="7c35f"
          alignment="left"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="moq_lead_time_source"
          label="Moq lead time source"
          placeholder="Select option"
          position="center"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="e7239"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          hidden="true"
          key="item"
          label="Item"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
        />
        <Action
          id="5bebd"
          icon="bold/interface-delete-bin-2"
          label="리오더 제외"
        >
          <Event
            event="clickAction"
            method="run"
            params={{
              ordered: [
                {
                  src: "// 현재 클릭된 행의 고유 식별자(sty_cd, col_cd) 가져오기\n// Retool 테이블 내에서 현재 행 데이터는 'currentRow' 또는 'item' 변수로 접근 가능합니다.\n// 사용 중인 Retool 버전에 따라 변수 이름이 다를 수 있으니 확인하세요.\n// 여기서는 'currentRow'를 예시로 사용합니다.\nconst styleCodeToRemove = currentSourceRow.sty_cd;\nconst colorCodeToRemove = currentSourceRow.col_cd;\n\n// selectedReorderItems 상태에서 현재 값 가져오기\nconst currentItems = editableReviewedList.value || [];\n\n// 클릭된 행에 해당하는 항목을 제외한 새 배열 생성\nconst updatedItems = currentItems.filter(item =>\n    !(item.sty_cd === styleCodeToRemove && item.col_cd === colorCodeToRemove)\n);\n\n// 업데이트된 배열로 selectedReorderItems 상태 업데이트\neditableReviewedList.setValue(updatedItems);\n\n// 중요: getReorderReviewList 쿼리가 selectedReorderItems 변경 시 자동으로\n// 재실행되도록 설정되어 있어야 합니다. 만약 자동으로 안되면 아래 주석 해제\n//  getReorderReviewList.trigger();",
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
      <Button id="button5" text="리오더 내역 저장 & 엑셀 다운로드">
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
                        "SUPPLIES_REORDER_{{moment(new Date()).format('YYYY-MM-DD')}}",
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
    </ModuleContainerWidget>
  </Frame>
</App>
