<Screen
  id="agabangPage"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title="agabangPage"
  urlSlug=""
>
  <SqlQuery
    id="seasonInfoQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("../lib/seasonInfoQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer={
      'const changeset = {{ simulTbl.changesetArray }}\nconst simulArr = {{ ordOptQuery.data }}\nlet arrData = formatDataAsArray(data)\n\n// Apply changes and calculate dependent columns\narrData = arrData.map((row) => {\n  const change = changeset.find(ele => ele.rn === row.rn)\n  console.log(change)\n  if (change) {\n    const changedTargetRatio = change.target_sales_ratio\n    const simul = simulArr.find(ele => ele.rn === row.rn && ele.adjusted_ratio === changedTargetRatio)\n    row["목표판매율"] = changedTargetRatio\n    row["최적발주수량"] = simul["adjusted_ord_qty"]\n    row["최적발주금액"] = simul["adjusted_ord_amt"]\n  }\n  row["발주수량차"] = row["최적발주수량"] - row["입고수량"]\n  row["추가예상매출"] = row["발주수량차"] > 0 ? row["발주수량차"] * row["판매금액"] / row["판매수량"] : 0\n  row["예상감소비용"] = row["발주수량차"] < 0 ? row["발주수량차"] * row["입고원가"] / row["입고수량"] : 0\n  row["목표판매율_수량"] = row["판매수량"] / row["최적발주수량"]\n  row["목표판매율_금액"] = row["판매금액"] / row["최적발주금액"]\n  row["배수"] = row["판매금액"] / row["최적발주금액"]\n  return row\n});\n\nreturn formatDataAsObject(arrData)'
    }
    warningCodes={[]}
  />
  <Function
    id="seasonSummary"
    funcBody={include("../lib/seasonSummary.js", "string")}
  />
  <SqlQuery
    id="ordOptQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("../lib/ordOptQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <State id="aiAnswerResult" />
  <RetoolAIQuery
    id="openAIAPI"
    action="chatResponseGeneration"
    chatHistory="{{ orderOptChat.messageHistory.slice(1, orderOptChat.messageHistory.length) }}"
    chatInput="{{orderOptChat.lastMessage }}"
    confirmationMessage="## 해당 내용으로 AI에게 문의 하시겠습니까?"
    defaultModelInitialized={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    model="gpt-5"
    notificationDuration={4.5}
    providerId="retoolAICustom::5c36a95f-99d9-4d17-83d0-5763f1247393"
    providerName="OpenAIResponses"
    queryDisabledMessage="Message is too short"
    resourceDisplayName="retool_ai"
    resourceName="retool_ai"
    resourceTypeOverride=""
    showSuccessToaster={false}
    streamResponse={false}
    systemMessage="당신은 매출 증대를  위한 다음 시즌 기획을 담당하는 유아복 패션브랜드의 경험 많은 전문가입니다. 귀하의 역할은 다음과 같습니다:\n\n

**핵심 업무:**\n
- 정량적 데이터와 정성적 시장 요인을 함께 분석\n
- 날씨 패턴, 경제 상황, 패션 트렌드 종합 고려\n
- 비즈니스 성장을 이끄는 전략적 인사이트 제공\n
- 클라이언트 이해관계자에게 전문적 제안 전달\n\n

**분석 프레임워크:**\n
1. **데이터 분석**: 과거 실적, 계절별 패턴, 카테고리 트렌드\n
2. **외부 요인**: 날씨 영향, 경제 지표, 소비자 행동 변화\n
3. **시장 인텔리전스**: 경쟁사 분석, 트렌딩 스타일, 인구통계학적 변화\n
4. **전략적 제안**: 명확한 근거가 있는 실행 가능한 인사이트\n\n

**응답 요구사항:**\n
- 클라이언트 프레젠테이션에 적합한 전문적, 컨설팅 톤 유지\n
- 데이터 기반 논리로 제안사항 뒷받침\n
- 항상 심화 분석을 위한 3-5가지 추가 조사 영역으로 마무리\n
- 경영진 요약, 상세 분석, 다음 단계로 명확하게 구조화된 응답"
  >
    <Event
      event="success"
      method="setValue"
      params={{ ordered: [] }}
      pluginId="aiAnswerResult"
      type="state"
      waitMs="0"
      waitType="debounce"
    />
  </RetoolAIQuery>
  <State id="isHidden" value="false" />
  <Include src="./header.rsx" />
  <Include src="./AIReviewModal.rsx" />
  <Include src="./alertModal.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    type="main"
  >
    <Container
      id="container2"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="4px 0px"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle2"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="b8957" viewKey="View 1">
        <Text
          id="text6"
          value="###### 발주최적화 시뮬레이션 안내"
          verticalAlign="center"
        />
        <Text
          id="text7"
          value={
            '해당 시뮬레이션은 특정 시즌의 발주 및 판매 결과를 통해 다음 시즌의 적절 발주 수량을 제안합니다. 최적발주수량은 특정 시즌의 데이터를 바탕으로 다음 시즌에 달성하고자 하는 <b>"목표판매율"</b>을 기반합니다. 즉, 특정 시즌을 회고하고, 다음 시즌에 달성하고자 하는 <b>"목표판매율"</b>을 설정하면 이에 맞는 최적 발주수량을 AI 및 ML을 통해 제안합니다.\n\n각 시즌은 정상 판매만 반영하기 위해 시즌의 최초 판매 시작 이후 1년 간의 판매만 집계합니다. 또한, 발주량의 경우 최적의 발주량을 계산하기 위해, 각 매장간 창고로부터 입고된 수량 뿐 아니라 RT로 입고된 수량까지 고려합니다.\n\n아래의 <b>"카테고리별 시뮬레이션"</b>에서 <b>"목표판매율"</b>에 따른 적절 발주수량을 시뮬레이션해볼 수 있으며, 그 아래 <b>카테고리별 주요 지표가 담긴 테이블</b>에서 <b>"목표판매율(수량)"</b>을 조절하면서 각 카테고리별로 적절 목표판매율도 조절하실 수 있습니다'
          }
          verticalAlign="center"
        />
      </View>
    </Container>
    <Spacer id="spacer4" />
    <Select
      id="seasonSelect"
      captionByIndex=""
      colorByIndex=""
      data="{{ recentSeasonQuery.data }}"
      disabledByIndex=""
      emptyMessage="No options"
      fallbackTextByIndex=""
      hiddenByIndex=""
      iconByIndex=""
      imageByIndex=""
      label=""
      labelAlign="right"
      labels="{{ item.season_alias }}"
      labelWidth="20
"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      style={{ ordered: [{ adornmentBackground: "tokens/9dc0c2b5" }] }}
      textBefore="시즌"
      tooltipByIndex=""
      value=""
      values="{{ item.season_alias }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_season_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Text
      id="text1"
      margin="4px 4px"
      value="###### **시즌 주요 지표**"
      verticalAlign="center"
    />
    <Table
      id="summaryTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ seasonSummary.value }}"
      defaultFilters={{
        0: {
          ordered: [
            { columnId: "" },
            { operator: "includes" },
            { value: "" },
            { id: "7b6f5" },
          ],
        },
      }}
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      margin="0"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
      toolbarPosition="bottom"
    >
      <Column
        id="ba7e1"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="스타일수"
        label="스타일수"
        placeholder="Enter value"
        position="center"
        size={57.46875}
        summaryAggregationMode="none"
      />
      <Column
        id="71411"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="컬러수"
        label="컬러수"
        placeholder="Enter value"
        position="center"
        size={47.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="d5573"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="입고수량"
        label="입고수량"
        placeholder="Enter value"
        position="center"
        size={68.390625}
        summaryAggregationMode="none"
      />
      <Column
        id="f8d53"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="입고금액"
        label="입고금액"
        placeholder="Enter value"
        position="center"
        size={100.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="5b55d"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="입고원가"
        label="입고원가"
        placeholder="Enter value"
        position="center"
        size={94.125}
        summaryAggregationMode="none"
      />
      <Column
        id="bee31"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="출고수량"
        label="출고수량"
        placeholder="Enter value"
        position="center"
        size={63.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="c8418"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
        }}
        groupAggregationMode="sum"
        key="배수"
        label="배수"
        placeholder="Enter value"
        position="center"
        referenceId="column12"
        size={40.59375}
        summaryAggregationMode="none"
      />
      <Column
        id="94ffd"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="판매수량"
        label="판매수량"
        placeholder="Enter value"
        position="center"
        size={62.140625}
        summaryAggregationMode="none"
      />
      <Column
        id="60d5e"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="판매율(수량)"
        placeholder="Enter value"
        position="center"
        referenceId="sales_ratio_qty"
        size={76.03125}
        summaryAggregationMode="none"
        valueOverride={
          '{{ self.data[i]["판매수량"] /      self.data[i]["입고수량"] }}'
        }
      />
      <Column
        id="29483"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="판매TAG가"
        label="판매TAG가"
        placeholder="Enter value"
        position="center"
        size={104.390625}
        summaryAggregationMode="none"
      />
      <Column
        id="f6237"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="판매금액"
        label="판매금액"
        placeholder="Enter value"
        position="center"
        size={98.484375}
        summaryAggregationMode="none"
      />
      <Column
        id="91d09"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="판매율(금액)"
        placeholder="Enter value"
        position="center"
        referenceId="sales_ratio_amt"
        size={76.03125}
        summaryAggregationMode="none"
        valueOverride={
          '{{ self.data[i]["판매금액"] /      self.data[i]["입고금액"] }}'
        }
      />
    </Table>
    <Text
      id="text4"
      margin="4px 4px"
      value="###### **카테고리별 시뮬레이션**"
      verticalAlign="center"
    />
    <NumberInput
      id="targetRatioInput"
      currency="USD"
      format="percent"
      inputValue={0}
      label=""
      labelPosition="top"
      margin="4px 0px"
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      style={{ ordered: [{ adornmentBackground: "tokens/9dc0c2b5" }] }}
      textBefore="목표판매율"
      value="0.62"
    />
    <Text
      id="text5"
      margin="4px 4px"
      value="[시뮬레이션 요약]"
      verticalAlign="center"
    />
    <Button
      id="button1"
      iconBefore="bold/interface-edit-magic-wand"
      margin="4px 0px"
      style={{ ordered: [{ background: "tokens/9dc0c2b5" }] }}
      text="AI로 리뷰하기"
    >
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: "if (simulTbl.data.length === 0) {\n  alertModal.show()\n} else {\n  AIReviewModal.show()\n}",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Include src="./container1.rsx" />
    <Spacer id="spacer3" />
    <Table
      id="simulTbl"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ seasonInfoQuery.data }}"
      defaultFilters={{
        0: {
          ordered: [
            { columnId: "" },
            { operator: "includes" },
            { value: "" },
            { id: "6ea3d" },
          ],
        },
      }}
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      includeRowInChangesetArray={true}
      margin="0"
      primaryKeyColumnId="26683"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      showSummaryRow={true}
      style={{
        headerBackground: "tokens/356f4e7b",
        summaryRowBackground: "tokens/9dc0c2b5",
        editedCellIndicator: "primary",
      }}
    >
      <Column
        id="0cc5d"
        alignment="left"
        editable="false"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="대분류"
        label="대분류"
        placeholder="Select option"
        position="left"
        size={93.703125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="cab3b"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="중분류"
        label="중분류"
        placeholder="Enter value"
        position="left"
        size={109.4375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="d3839"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="소분류"
        label="소분류"
        placeholder="Enter value"
        position="left"
        size={86.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="ba7e1"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="스타일수"
        label="스타일수"
        placeholder="Enter value"
        position="center"
        size={70.515625}
        summaryAggregationMode="sum"
      />
      <Column
        id="71411"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="컬러수"
        label="컬러수"
        placeholder="Enter value"
        position="center"
        size={56.140625}
        summaryAggregationMode="sum"
      />
      <Column
        id="d5573"
        alignment="left"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="입고수량"
        label="입고수량"
        placeholder="Enter value"
        position="center"
        size={77.484375}
        summaryAggregationMode="sum"
      />
      <Column
        id="f8d53"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="입고금액"
        label="입고금액"
        placeholder="Enter value"
        position="center"
        size={97.171875}
        summaryAggregationMode="sum"
      />
      <Column
        id="5b55d"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="입고원가"
        label="입고원가"
        placeholder="Enter value"
        position="center"
        size={88.875}
        summaryAggregationMode="sum"
      />
      <Column
        id="98b81"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
        }}
        groupAggregationMode="sum"
        key="입고배수"
        label="배수"
        placeholder="Enter value"
        position="center"
        size={66.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="94ffd"
        alignment="left"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="판매수량"
        label="판매수량"
        placeholder="Enter value"
        position="center"
        size={74.453125}
        summaryAggregationMode="sum"
      />
      <Column
        id="60d5e"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="판매율(수량)"
        placeholder="Enter value"
        position="center"
        referenceId="sales_ratio_qty"
        size={87.59375}
        valueOverride={
          '{{ self.data[i]["판매수량"] /      self.data[i]["입고수량"] }}'
        }
      />
      <Column
        id="29483"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="판매TAG가"
        label="판매TAG가"
        placeholder="Enter value"
        position="center"
        size={96.296875}
        summaryAggregationMode="sum"
      />
      <Column
        id="f6237"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="판매금액"
        label="판매금액"
        placeholder="Enter value"
        position="center"
        size={97.078125}
        summaryAggregationMode="sum"
      />
      <Column
        id="91d09"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="판매율(금액)"
        placeholder="Enter value"
        position="center"
        referenceId="sales_ratio_amt"
        size={77.59375}
        valueOverride={
          '{{ self.data[i]["판매금액"] /      self.data[i]["입고금액"] }}'
        }
      />
      <Column
        id="c58a4"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="할인율"
        label="할인율"
        placeholder="Enter value"
        position="center"
        size={62.140625}
        summaryAggregationMode="none"
      />
      <Column
        id="0ff79"
        alignment="center"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="최적발주수량"
        label="최적발주수량"
        placeholder="Enter value"
        position="center"
        referenceId="adjusted_ord_qty"
        size={86.28125}
        summaryAggregationMode="sum"
      />
      <Column
        id="bb4aa"
        alignment="center"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="최적발주금액"
        label="최적발주금액"
        placeholder="Enter value"
        position="center"
        size={97.5625}
        summaryAggregationMode="sum"
      />
      <Column
        id="65737"
        alignment="center"
        backgroundColor="#01488f"
        editable="true"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="목표판매율"
        label="목표판매율(수량)"
        placeholder="Enter value"
        position="center"
        referenceId="target_sales_ratio"
        size={100.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="fe6b3"
        alignment="center"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="목표판매율_금액"
        label="목표판매율(금액)"
        placeholder="Enter value"
        position="center"
        size={105.359375}
        summaryAggregationMode="none"
      />
      <Column
        id="d0a84"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="발주수량차"
        label="발주수량차"
        placeholder="Enter value"
        position="center"
        referenceId="ord_diff"
        size={87.90625}
        summaryAggregationMode="sum"
        textColor={'{{ item > 0 ? "green" : "red" }}'}
      />
      <Column
        id="c4f16"
        alignment="center"
        backgroundColor="{{ theme.tokens.primaryOpacity20 }}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        hidden="true"
        key="목표판매율_수량"
        label="목표판매율(수량)"
        placeholder="Enter value"
        position="center"
        size={109}
        summaryAggregationMode="none"
      />
      <Column
        id="bee31"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="출고수량"
        label="출고수량"
        placeholder="Enter value"
        position="center"
        size={58.359375}
        summaryAggregationMode="sum"
      />
      <Column
        id="f3c83"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="판매율(수량)"
        label="판매율 수량"
        placeholder="Enter value"
        position="center"
        size={71.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="cda45"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="판매율(금액)"
        label="판매율 금액"
        placeholder="Enter value"
        position="center"
        size={71.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="26683"
        alignment="right"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="rn"
        label="Rn"
        placeholder="Enter value"
        position="center"
        referenceId="rn"
        size={31.40625}
        summaryAggregationMode="none"
      />
      <Column
        id="6995d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="추가예상매출"
        label="추가예상매출"
        placeholder="Enter value"
        position="center"
        size={84.734375}
        summaryAggregationMode="sum"
        textColor={'{{ item > 0 ? "green" : "" }}'}
      />
      <Column
        id="83bce"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="예상감소비용"
        label="예상감소비용"
        placeholder="Enter value"
        position="center"
        size={91.515625}
        summaryAggregationMode="sum"
        textColor={'{{ item < 0 ? "red" : "" }}'}
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
          pluginId="simulTbl"
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
          pluginId="simulTbl"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="save"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="recentSeasonQuery"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</Screen>
