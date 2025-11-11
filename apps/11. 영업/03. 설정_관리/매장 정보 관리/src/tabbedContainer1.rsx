<Container
  id="tabbedContainer1"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  padding="12px"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Spacer id="spacer1" />
    <Text id="text8" value="#### 매장 정보 관리" verticalAlign="center" />
    <Spacer id="spacer2" />
    <Tabs
      id="tabs1"
      itemMode="static"
      margin="0"
      navigateContainer={true}
      style={{ ordered: [] }}
      targetContainerId="tabbedContainer1"
      value="{{ self.values[0] }}"
    >
      <Option id="5915d" value="Tab 1" />
      <Option id="48ee2" value="Tab 2" />
      <Option id="fe70e" value="Tab 3" />
    </Tabs>
  </Header>
  <View id="5ccbf" label="매출 제외 매장" viewKey="shopExclude">
    <Container
      id="container16"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle19"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="296d3" viewKey="View 1">
        <Icon
          id="icon2"
          horizontalAlign="center"
          icon="bold/interface-alert-information-circle-alternate"
        />
        <Text
          id="text14"
          value="매출 집계 대상에서 제외할 매장을 지정합니다. 매장을 제외 목록에 추가하거나 삭제할 수 있습니다."
          verticalAlign="center"
        />
      </View>
    </Container>
    <Link id="link2" text="어떻게 사용 하나요?">
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: "modalFrameUserguide.show();\nvarTutorial.setValue(\n  {\n    title: tabs1.selectedLabel, body: `\n#### ➕ 매장 추가하기\n\n##### 1️⃣ 추가 모드 시작\n- **매장 추가** 버튼을 클릭합니다\n\n##### 2️⃣ 매장 선택\n- **매장명** 또는 **매장코드**로 검색하여 추가할 매장을 선택합니다\n\n##### 3️⃣ 메모 작성 (선택사항)\n- 필요한 경우 **비고**에 메모를 작성합니다\n- 예시: 제외 사유, 특이사항 등\n\n##### 4️⃣ 추가 완료\n- 하단의 **추가** 버튼을 클릭하여 완료합니다\n\n---\n\n#### ❌ 매장 삭제하기\n\n##### 🗑️ 간단 삭제\n- 각 매장 **맨 우측**의 **삭제 아이콘**을 클릭합니다\n\n---\n\n#### ⚠️ 주의사항\n> 매장을 제외하면 **모든 실적 보고서**에서 해당 매장 데이터가 빠집니다!\n---\n#### 💡 주요 포인트\n- 추가된 매장은 모든 매출 집계에서 자동으로 제외됩니다\n- 삭제 시 해당 매장은 다시 매출 집계 대상에 포함됩니다\n- 비고란을 활용하여 제외 사유를 기록해두면 관리에 도움이 됩니다\n`\n  }\n)",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Link>
    <Container
      id="container7"
      _align="center"
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle7"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="525ab" viewKey="View 1">
        <Text
          id="containerTitle6"
          style={{
            ordered: [
              { fontSize: "13px" },
              { fontWeight: "400" },
              { fontFamily: "Pretendaed Variable" },
            ],
          }}
          value="매장 목록 ({{ getExcludedShopList.data.shop_cd.length }})"
          verticalAlign="center"
        />
        <Button
          id="buttonModalExcludedShopOpen"
          iconBefore="bold/interface-add-1"
          style={{
            ordered: [
              { borderRadius: "100px" },
              { fontSize: "10px" },
              { fontWeight: "600" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          text="매장 추가"
        >
          <Event
            event="click"
            method="show"
            params={{ ordered: [] }}
            pluginId="modalFrameExcluededShop"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <TextInput
          id="textInput3"
          iconAfter="bold/interface-search"
          label=""
          labelPosition="top"
          margin="4px 4px 4px 300px"
          placeholder="매장명, 매장코드로 검색하세요"
          showClear={true}
          style={{ ordered: [{ borderRadius: "50px" }] }}
        />
      </View>
    </Container>
    <Table
      id="excludedShopTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getExcludedShopList.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      disableSave="{{ getExcludedShopList.isFetching }}"
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="36815"
      rowHeight="small"
      searchTerm="{{ textInput3.value }}"
      showFooter={true}
      showHeader={true}
    >
      <Column
        id="56c9f"
        alignment="left"
        editable={true}
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="shop_cd"
        label="매장코드"
        placeholder="매장코드 6자리"
        position="center"
        size={57.71875}
        summaryAggregationMode="none"
      />
      <Column
        id="e95f9"
        alignment="left"
        editable={true}
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="매장명"
        position="center"
        referenceId="shop_nm"
        size={140.453125}
        summaryAggregationMode="none"
      />
      <Column
        id="78787"
        alignment="left"
        editable="true"
        format="string"
        groupAggregationMode="none"
        key="remark"
        label="비고"
        position="center"
        size={217.75}
        summaryAggregationMode="none"
      />
      <Column
        id="36815"
        alignment="right"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="icon"
        formatOptions={{ icon: "bold/interface-delete-bin-4" }}
        groupAggregationMode="sum"
        hidden="false"
        key="id"
        placeholder="Enter value"
        position="center"
        referenceId="delete"
        size={28}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="deleteExcluedShopInfo"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="getExcludedShopList"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="엑셀 다운로드"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          params={{
            ordered: [
              {
                options: {
                  ordered: [
                    { fileType: "xlsx" },
                    {
                      fileName:
                        "매출 제외 매장 목록({{ moment().format('YYYY-MM-DD') }} 기준)",
                    },
                    { includeHiddenColumns: false },
                  ],
                },
              },
            ],
          }}
          pluginId="excludedShopTbl"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="save"
        method="run"
        params={{
          ordered: [
            {
              src: 'const change = excludedShopTbl.changesetArray[0] || excludedShopTbl.newRows\nconsole.log(change)\nif ("id" in change) {\n  console.log("update")\n  await updateExcludedShopInfo.trigger()\n} else {\n  console.log("insert")\n  await insertExcludedShopInfo.trigger()\n}',
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </View>
  <View id="c75f7" label="매장 인수인계" viewKey="shopHandover">
    <Container
      id="container17"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle20"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="296d3" viewKey="View 1">
        <Icon
          id="icon3"
          horizontalAlign="center"
          icon="bold/interface-alert-information-circle-alternate"
        />
        <Text
          id="text15"
          value="변경 전후의 매장 코드를 연결하여 실적이 끊어지지 않고 누적되도록 관리합니다.
***플렉스 매장의 매장 코드가 변경된 경우, 플렉스로 분류된 매장 리스트도 함께 변경해야 합니다.***"
          verticalAlign="center"
        />
      </View>
    </Container>
    <Link id="link3" text="어떻게 사용 하나요?">
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: "modalFrameUserguide.show();\nvarTutorial.setValue(\n  {\n    title: tabs1.selectedLabel,\n    body: `\n#### ➕ 매장 추가 방법\n\n##### 1️⃣ 추가 모드 시작\n- **매장 추가** 버튼을 클릭합니다\n\n##### 2️⃣ 신규 매장 선택\n- **신규매장 선택**에서 매장명 또는 매장코드로 검색합니다\n- 새로운 매장코드가 발급된 신규 매장을 선택하여여야 합니다 \n\n##### 3️⃣ 이전 매장 선택\n- **이전매장 선택**에서 매장명 또는 매장코드로 검색합니다\n- 새로운 매장코드와 연결할 과거 매장을 선택하여야 합니다.\n\n##### 4️⃣ 인수인계 날짜 설정\n- 인수인계가 진행된 **날짜**를 선택합니다\n\n##### 5️⃣ 메모 작성 (선택사항)\n- 필요한 경우 **비고**에 메모를 작성합니다\n\n##### 6️⃣ 저장 완료\n- **추가** 버튼을 클릭하여 저장합니다\n\n---\n\n#### ❌ 삭제 방법\n\n##### 🗑️ 간단 삭제\n- 테이블에서 각 매장 **맨 우측**의 **삭제 아이콘**을 클릭합니다\n\n---\n\n#### ⚠️ 주의사항\n\n##### 🔄 매장코드 2회 이상 변경 시\n\n**예시:** 매장코드가 \\`A → B → C\\`로 변경된 경우\n- \\`A → C\\` **1개**\n- \\`B → C\\` **1개**\n- 총 **2개**를 등록해야 합니다\n\n##### 🔄 추가 변경 발생 시\n\n**예시:** \\`A → B → C\\`에서 \\`D\\`로 또 변경된 경우\n\n###### 📝 처리 순서:\n1. **과거 매칭 기록 삭제**\n2. **새로운 매칭 등록:**\n  - \\`A → D\\`\n  - \\`B → D\\`\n  - \\`C → D\\`\n  - 총 **3개** 등록\n\n##### 📌 핵심 원칙\n> **신규 매장 코드**는 항상 **최신의 매장코드**가 되어야 합니다!\n\n---\n\n#### 💡 주요 포인트\n- 모든 과거 매장코드는 최신 매장코드로 연결되어야 합니다\n- 중간 단계 매장코드도 모두 최신 매장코드와 연결해야 합니다\n- 코드가 변경된 매장이 플렉스 매장에 해당할 경우 플렉스 매장 리스트 업데이트가 따로 필요합니다`\n  }\n)",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Link>
    <Container
      id="container8"
      _align="center"
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle9"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="525ab" viewKey="View 1">
        <TextInput
          id="textInput1"
          iconAfter="bold/interface-search"
          label=""
          labelPosition="top"
          margin="4px 4px 4px 300px"
          placeholder="매장명, 매장코드로 검색하세요"
          showClear={true}
          style={{ ordered: [{ borderRadius: "50px" }] }}
        />
        <Text
          id="containerTitle4"
          style={{
            ordered: [
              { fontSize: "13px" },
              { fontWeight: "400" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          value="매장 목록 ({{ getShopHandoverList.data.shop_cd.length }})"
          verticalAlign="center"
        />
        <Button
          id="buttonModalShopHandoverOpen"
          iconBefore="bold/interface-add-1"
          style={{
            ordered: [
              { borderRadius: "100px" },
              { fontSize: "10px" },
              { fontWeight: "600" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          text="매장 추가"
        >
          <Event
            event="click"
            method="show"
            params={{ ordered: [] }}
            pluginId="modalFrameShopHandover"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
    <Table
      id="shopHandoverTbl"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getShopHandoverList.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      disableSave="{{ getShopHandoverList.isFetching }}"
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="36815"
      rowHeight="small"
      searchTerm="{{ textInput1.value }}"
      showFooter={true}
      showHeader={true}
    >
      <Column
        id="56c9f"
        alignment="left"
        editable={true}
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="shop_cd"
        label="매장코드"
        placeholder="신규 매장코드 6자리"
        position="center"
        size={57.84375}
        summaryAggregationMode="none"
      />
      <Column
        id="e95f9"
        alignment="left"
        editable={true}
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="신규 매장명"
        position="center"
        referenceId="shop_nm"
        size={134.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="9f7ad"
        alignment="left"
        editable={true}
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="prev_shop_cd"
        label="이전매장코드"
        placeholder="이전 매장코드 6자리"
        position="center"
        size={78.234375}
      />
      <Column
        id="659fe"
        alignment="left"
        editable={true}
        format="string"
        groupAggregationMode="none"
        key="prev_shop_nm"
        label="이전매장명"
        placeholder="이전매장명"
        position="center"
        size={167.21875}
      >
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="getShopHandoverList"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="7821d"
        alignment="center"
        editable="true"
        format="date"
        formatOptions={{ dateFormat: "yyyy-MM-dd" }}
        groupAggregationMode="none"
        key="update_dt"
        label="인수인계 일자"
        position="center"
        size={83.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="78787"
        alignment="left"
        editable="true"
        format="string"
        groupAggregationMode="none"
        key="remark"
        label="비고"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="36815"
        alignment="right"
        cellTooltip="삭제하기"
        cellTooltipMode="custom"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="icon"
        formatOptions={{ icon: "bold/interface-delete-bin-4" }}
        groupAggregationMode="sum"
        hidden="false"
        key="id"
        placeholder="Enter value"
        position="center"
        referenceId="delete"
        size={28}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="deletShopHandoverInfo"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="getShopHandoverList"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="엑셀 다운로드"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          params={{
            ordered: [
              {
                options: {
                  ordered: [
                    { fileType: "xlsx" },
                    {
                      fileName:
                        "매장 인수인계 목록({{ moment().format('YYYY-MM-DD') }} 기준)",
                    },
                  ],
                },
              },
            ],
          }}
          pluginId="shopHandoverTbl"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="save"
        method="run"
        params={{
          ordered: [
            {
              src: 'const change = shopHandoverTbl.changesetArray[0] || {}\nconsole.log(change)\nif ("id" in change) {\n  console.log("update")\n  await updateShopHandoverInfo.trigger()\n} else {\n  console.log("insert")\n  await insertShopHandoverInfo.trigger()\n}',
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </View>
  <View
    id="68826"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="플렉스 매장"
    viewKey="shopFlex"
  >
    <Container
      id="container18"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle21"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="296d3" viewKey="View 1">
        <Icon
          id="icon4"
          horizontalAlign="center"
          icon="bold/interface-alert-information-circle-alternate"
        />
        <Text
          id="text16"
          value="플렉스로 분류할 매장을 설정하는 화면입니다.
리스트에 매장을 추가하거나 삭제하여 플렉스 상세에서 확인할 매장 목록을 설정할 수 있습니다."
          verticalAlign="center"
        />
      </View>
    </Container>
    <Link id="link4" text="어떻게 사용 하나요?">
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: "modalFrameUserguide.show();\nvarTutorial.setValue(\n  {\n    title: tabs1.selectedLabel,\n    body: `\n#### ➕ 매장 추가하기\n\n##### 1️⃣ 추가 모드 시작\n- **매장 추가** 버튼을 클릭합니다\n\n##### 2️⃣ 매장 선택\n- **매장명** 또는 **매장코드**로 검색하여 추가할 매장을 선택합니다\n\n##### 3️⃣ 메모 작성 (선택사항)\n- 필요한 경우 **비고**에 메모를 작성합니다\n- 예시: 플렉스 매장 특성, 추가 정보 등\n\n##### 4️⃣ 추가 완료\n- 하단의 **추가** 버튼을 클릭하여 완료합니다\n\n---\n\n#### ❌ 매장 삭제하기\n\n##### 🗑️ 간단 삭제\n- 각 매장 **맨 우측**의 **삭제 아이콘**을 클릭합니다\n\n---\n#### ⚠️ 주의사항\n> 플렉스 리스트에서 삭제하면 **플렉스 상세** 화면에서 더 이상 확인할 수 없습니다!\n> 매장코드이 중도에 변경된다면 플랙스 매장 리스트에서도 기존 매장 삭제 후 재등록이 필요합니다.\n\n---\n\n#### 💡 주요 포인트\n- 추가된 매장은 플렉스 상세 화면에서 확인할 수 있습니다\n- 비고란을 활용하여 플렉스 매장의 특성을 기록해두세요\n`\n  }\n)",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Link>
    <Container
      id="container9"
      _align="center"
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle11"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="525ab" viewKey="View 1">
        <Text
          id="containerTitle2"
          style={{
            ordered: [
              { fontSize: "13px" },
              { fontWeight: "400" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          value="매장 목록 ({{ getFlexShopList.data.shop_cd.length }})"
          verticalAlign="center"
        />
        <Button
          id="buttonModalFlexShopOpen"
          iconBefore="bold/interface-add-1"
          style={{
            ordered: [
              { borderRadius: "100px" },
              { fontSize: "10px" },
              { fontWeight: "600" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          text="매장 추가"
        >
          <Event
            event="click"
            method="show"
            params={{ ordered: [] }}
            pluginId="modalFrameFlexShop"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <TextInput
          id="textInput2"
          iconAfter="bold/interface-search"
          label=""
          labelPosition="top"
          margin="4px 4px 4px 300px"
          placeholder="매장명, 매장코드로 검색하세요"
          showClear={true}
          style={{ ordered: [{ borderRadius: "50px" }] }}
        />
      </View>
    </Container>
    <Table
      id="flexShopTbl"
      autoColumnWidth={true}
      clearChangesetOnSave={true}
      data="{{ getFlexShopList.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      disableSave="{{ getFlexShopList.isFetching }}"
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="e828d"
      rowHeight="small"
      searchTerm="{{ textInput2.value }}"
      showFooter={true}
      showHeader={true}
    >
      <Column
        id="b16dd"
        alignment="left"
        editable="true"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="shop_cd"
        label="매장코드"
        placeholder="Enter value"
        position="center"
        size={57.59375}
        summaryAggregationMode="none"
      />
      <Column
        id="28daa"
        alignment="left"
        editable={true}
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="center"
        size={190.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="8ced6"
        alignment="left"
        editable="true"
        format="string"
        groupAggregationMode="none"
        key="remark"
        label="비고"
        position="center"
        size={36.734375}
        summaryAggregationMode="none"
      />
      <Column
        id="e828d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="icon"
        formatOptions={{ icon: "bold/interface-delete-bin-4" }}
        groupAggregationMode="sum"
        hidden="false"
        key="id"
        placeholder="Enter value"
        position="center"
        referenceId="delete"
        size={28}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="deleteFlexShopInfo"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="getFlexShopList"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="엑셀 다운로드"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          params={{
            ordered: [
              {
                options: {
                  ordered: [
                    { fileType: "xlsx" },
                    {
                      fileName:
                        "플렉스 매장 목록({{ moment().format('YYYY-MM-DD') }} 기준)",
                    },
                  ],
                },
              },
            ],
          }}
          pluginId="flexShopTbl"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="save"
        method="run"
        params={{
          ordered: [
            {
              src: 'const change = flexShopTbl.changesetArray[0] || {}\nconsole.log(change)\nif ("id" in change) {\n  console.log("update")\n  await updateFlexShopInfo.trigger()\n} else {\n  console.log("insert")\n  await insertFlexShopInfo.trigger()\n}',
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </View>
</Container>
