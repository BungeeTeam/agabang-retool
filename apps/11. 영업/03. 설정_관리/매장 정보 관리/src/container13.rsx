<Container
  id="container13"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Spacer id="spacer4" />
    <Text
      id="containerTitle15"
      value="#### 채널 정보 관리"
      verticalAlign="center"
    />
    <Container
      id="container15"
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
          id="containerTitle18"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="296d3" viewKey="View 1">
        <Icon
          id="icon1"
          horizontalAlign="center"
          icon="bold/interface-alert-information-circle-alternate"
        />
        <Text
          id="text13"
          value={
            '채널별 분류를 관리하는 화면입니다. 채널 분류는 채널의 상위 카테고리로서 **"목표매출 달성현황**"화면에서 "**유통채널별 매출 집계**"에 사용됩니다.\n***채널 분류가 지정되지 않은 채널은 \'기존 채널명\'이 그대로 표시됩니다.***'
          }
          verticalAlign="center"
        />
      </View>
    </Container>
    <Link id="link1" text="어떻게 사용 하나요?">
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: "modalFrameUserguide.show();\nvarTutorial.setValue({\n  title: containerTitle15.value.slice(5),\n  body: `\n#### 🔧 설정 방법\n\n##### 1️⃣ 변경할 채널 분류명 선택\n- 분류를 달리하고자 하는 채널의 채널 분류명을 더블클릭합니다\n\n##### 2️⃣ 새로운 채널 분류명 입력\n- 원하는 채널 분류명을 **타이핑**하여 입력합니다\n- 예시: \\`아울렛\\`, \\`백화점\\`, \\`마트\\`, \\`온라인몰\\` 등\n\n##### 3️⃣ 변경사항 저장\n- 하단의 **save** 버튼을 클릭하여 설정을 완료합니다\n\n---\n\n#### ⚠️ 주의사항\n> 설정 후 **저장**을 하지 않으면 변경사항이 사라집니다!\n> 채널 분류가 지정되지 않은 경우 '미분류'로 표시됩니다!`\n});",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Link>
  </Header>
  <View id="053f3" label="채널 상위분류 설정" viewKey="View 1">
    <Select
      id="bizSelect"
      colorByIndex="{{ theme.tokens.primaryOpacity20 }}"
      data="{{
(() => {
  const seen = new Set();
  const result = channelListQuery
    .data
    .filter(item => {
      const key = `${item.biz_cd}-${item.biz_nm}`;
      if (seen.has(key)) return false;
      seen.add(key);
      return true;
  })
  return result
})()
}}"
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.biz_cd }}"
      hidden=""
      label=""
      labelPosition="top"
      labels="{{ item.biz_nm }}"
      overlayMaxHeight={375}
      placeholder="Select options"
      showSelectionIndicator={true}
      textBefore="사업부"
      value="{{ current_user.groups.map(i => i.name).includes('admin') ? 'A1' :
  current_user.groups.map(i => i.name).includes('아가방 부문') ? 'A1' : 
  current_user.groups.map(i => i.name).includes('에뜨와 부문') ? 'A4' : 
  current_user.groups.map(i => i.name).includes('디즈니 부문') ? 'DS':'A1'}}"
      values="{{ item.biz_cd }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get2YearsResult"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Container
      id="container14"
      _align="center"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      hidden="true"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle17"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="525ab" viewKey="View 1">
        <Button
          id="buttonModalExcludedShopOpen2"
          iconBefore="bold/interface-add-1"
          style={{
            ordered: [
              { borderRadius: "100px" },
              { fontSize: "10px" },
              { fontWeight: "600" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          text="채널 그룹 추가"
        >
          <Event
            event="click"
            method="show"
            params={{ ordered: [] }}
            pluginId="modalFrameAddGroup_archive"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <Text
          id="containerTitle16"
          style={{
            ordered: [
              { fontSize: "13px" },
              { fontWeight: "400" },
              { fontFamily: "Pretendaed Variable" },
            ],
          }}
          value="채널 그룹 목록"
          verticalAlign="center"
        />
      </View>
    </Container>
    <Table
      id="groupList"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getGroupList.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="채널 그룹이 없습니다"
      enableSaveActions={true}
      heightType="auto"
      hidden="true"
      primaryKeyColumnId="b7c9a"
      rowHeight="xsmall"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{}}
      toolbarPosition="bottom"
    >
      <Column
        id="b7c9a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="id"
        label="ID"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="4793f"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="biz_cd"
        label="Biz cd"
        placeholder="Select option"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="16278"
        alignment="center"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="group_nm"
        label="그룹명"
        placeholder="Select option"
        position="center"
        size={63.109375}
        sortMode="disabled"
        summaryAggregationMode="none"
      />
      <Column
        id="dee8d"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        label="채널 수"
        placeholder="Enter value"
        position="center"
        referenceId="채널수"
        size={50.125}
        summaryAggregationMode="none"
        valueOverride="{{ getChannelMappingList.data.filter(i=>i.sup_tp_nm === currentSourceRow.group_nm).length }} 개"
      />
      <Column
        id="ed440"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="icon"
        formatOptions={{ icon: "bold/interface-delete-bin-4" }}
        groupAggregationMode="sum"
        key="id"
        placeholder="Enter value"
        position="center"
        referenceId="delete"
        size={28}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="run"
          params={{
            ordered: [
              {
                src: "if(getChannelMappingList.data.filter(i=>i.sup_tp_nm === currentSourceRow.group_nm).length === 0 ){\n  deleteGroup.trigger()\n} else {\n  utils.showNotification(\n    {\n      description: `해당 그룹에 ${getChannelMappingList.data.filter(i=>i.sup_tp_nm === currentSourceRow.group_nm).length}개의 채널이 배정되어 있어 삭제할 수 없습니다. 먼저 채널을 다른 그룹으로 이동해주세요.`\n    }\n  )\n}",
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
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
          pluginId="groupList"
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
          pluginId="groupList"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Table
      id="table3"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ transformer1.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      disableSave="{{ getChannelMappingList.isFetching }}"
      emptyMessage="No rows found"
      enableSaveActions={true}
      rowHeight="small"
      showBorder={true}
      showColumnBorders={true}
      showFooter={true}
      showHeader={true}
    >
      <Column
        id="78f80"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="biz_cd"
        label="사업부코드"
        placeholder="Select option"
        position="center"
        size={48.640625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="3c7fe"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="biz_nm"
        label="사업부명"
        placeholder="Select option"
        position="center"
        size={94.21875}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="fb94f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="false"
        key="tp_cd"
        label="채널코드"
        placeholder="Enter value"
        position="center"
        size={69.078125}
        summaryAggregationMode="none"
      />
      <Column
        id="6d094"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="tp_nm"
        label="채널명"
        placeholder="Enter value"
        position="center"
        referenceId="tp_nm"
        size={288.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="bfee4"
        alignment="center"
        backgroundColor="rgba(1, 72, 143, 0)"
        editable="true"
        editableOptions={{ allowCustomValue: true }}
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_group_nm"
        label="채널 분류명"
        optionList={{ manualData: [{ ordered: [{ value: "아울렛" }] }] }}
        placeholder="채널 분류명 입력"
        position="center"
        referenceId="tp_group_nm"
        size={70.859375}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      />
      <Column
        id="e6003"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ icon: '{{  "/icon:bold/interface-edit-write-1"  }}' }}
        groupAggregationMode="sum"
        hidden="true"
        key="id"
        label="ID"
        placeholder="Enter value"
        position="center"
        size={36.15625}
        summaryAggregationMode="none"
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
          pluginId="table3"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="save"
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
        pluginId="upsertChannelGroupInfo"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </View>
</Container>
