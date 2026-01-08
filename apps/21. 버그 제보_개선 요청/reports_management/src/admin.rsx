<Screen
  id="admin"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title="Admin"
  urlSlug="/admin/reports-management"
>
  <SqlQueryUnified
    id="updateQuery"
    actionType="BULK_UPDATE_BY_KEY"
    bulkUpdatePrimaryKey="id"
    changesetIsObject={true}
    changesetObject="{{ table3.changesetArray[0] }}"
    editorMode="gui"
    filterBy={
      '[{"key":"id","value":"{{ table3.changesetArray[0]?.id || \\"\\"}}","operation":"="}]'
    }
    notificationDuration={4.5}
    records="{{(() => {
 const currentDateTime = new Date();

const changedArr = table3.changesetArray;

const result = changedArr.map(item => {
  if (item.status === '처리 완료' || item.status === '해결 완료') {
    return {
      ...item,
      resolved_at: currentDateTime,
      last_updated_at: currentDateTime
    };
  }

  return {
    ...item,
    last_updated_at: currentDateTime
  };
});

return result;

})()}}"
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    tableName="user_reports"
    updateSetValueDynamically={true}
  />
  <JavascriptQuery
    id="saveAction"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("../lib/saveAction.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <State id="varChangeObject" />
  <SqlQueryUnified
    id="updateQueryForKanban"
    actionType="BULK_UPDATE_BY_KEY"
    bulkUpdatePrimaryKey="id"
    changesetIsObject={true}
    changesetObject="{{ table3.changesetArray[0] }}"
    editorMode="gui"
    filterBy={
      '[{"key":"id","value":"{{ table3.changesetArray[0]?.id || \\"\\"}}","operation":"="}]'
    }
    notificationDuration={4.5}
    records="{{(() => {
  const currentDateTime = new Date();

const changedArr = table3.changesetArray;

const result = changedArr.map(item => {
  if (item.status === '처리 완료' || item.status === '해결 완료') {
    return {
      ...item,
      resolved_at: currentDateTime,
      last_updated_at: currentDateTime
    };
  }

  return {
    ...item,
    last_updated_at: currentDateTime
  };
});

return result;

})()}}"
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    tableName="user_reports"
    updateSetValueDynamically={true}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="getReportsQuery"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <Frame
    id="$main2"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Tabs id="tabs1" itemMode="static" value="{{ self.values[0] }}">
      <Option id="86cf9" value="list" />
      <Option id="84e58" label="kanban" value="kanban" />
    </Tabs>
    <ListViewBeta
      id="listView1"
      _primaryKeys="{{ item.id }}"
      data="{{ statusList.value }}"
      heightType="auto"
      hidden="{{ tabs1.value != 'kanban' }}"
      itemWidth="200px"
      margin="0"
      numColumns={3}
      padding="0"
    >
      <Container
        id="container1"
        _gap="0px"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        overflowType="hidden"
        padding="0"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Text
            id="containerTitle1"
            value="#### {{ item }} ({{ getReportsQuery.data.filter(i=>i.status == item).length }} 개)"
            verticalAlign="center"
          />
        </Header>
        <View id="6aa27" viewKey="View 1">
          <Table
            id="table2"
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ getReportsQuery.data.filter(i=>i.status === item) }}"
            defaultSelectedRow={{
              mode: "index",
              indexType: "display",
              index: 0,
            }}
            emptyMessage="No Task"
            enableSaveActions={true}
            heightType="auto"
            margin="0"
            primaryKeyColumnId="5965d"
            rowHeight="medium"
            showBorder={true}
            showHeader={true}
            toolbarPosition="bottom"
          >
            <Column
              id="52973"
              alignment="left"
              caption="{{ currentSourceRow.re }}"
              format="multilineString"
              groupAggregationMode="none"
              key="report_title"
              label="제목"
              placeholder="Enter value"
              position="center"
              size={410}
              sortMode="disabled"
              summaryAggregationMode="none"
              valueOverride="{{ item }}"
            />
            <Column
              id="1c976"
              alignment="left"
              cellTooltipMode="overflow"
              format="html"
              groupAggregationMode="none"
              key="report_description"
              label="요청 상세"
              placeholder="Enter value"
              position="center"
              size={331}
              summaryAggregationMode="none"
            />
            <Column
              id="5965d"
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
              id="a10c8"
              alignment="center"
              format="string"
              formatOptions={{ automaticColors: true }}
              groupAggregationMode="none"
              key="category"
              label="문의 유형"
              placeholder="Enter value"
              position="center"
              size={99}
              summaryAggregationMode="none"
            />
            <Column
              id="9071a"
              alignment="center"
              format="multilineString"
              formatOptions={{ automaticColors: true }}
              groupAggregationMode="none"
              key="user_priority"
              label="우선 순위"
              optionList={{ mode: "manual" }}
              placeholder="Enter value"
              position="center"
              size={76}
              summaryAggregationMode="none"
              valueOverride="{{ item }}"
            />
            <Column
              id="5b4af"
              alignment="center"
              editable={true}
              format="tag"
              formatOptions={{ automaticColors: true }}
              groupAggregationMode="none"
              key="status"
              label="진행 상태"
              optionList={{
                manualData: [
                  { ordered: [{ value: "접수 대기" }] },
                  {
                    ordered: [
                      { value: "담당자 지정" },
                      { label: "담당자 지정" },
                    ],
                  },
                  { ordered: [{ value: "처리 진행 중" }] },
                  { ordered: [{ value: "보류" }] },
                  { ordered: [{ value: "해결 완료" }] },
                  { ordered: [{ value: "처리 완료" }] },
                ],
                mode: "manual",
              }}
              placeholder="Select option"
              position="center"
              size={98}
              summaryAggregationMode="none"
            />
            <Column
              id="41394"
              alignment="left"
              caption="{{ currentSourceRow.submitter_email }}"
              format="string"
              formatOptions={{ automaticColors: true }}
              groupAggregationMode="none"
              key="submitter_name"
              label="작성자"
              placeholder="Enter value"
              position="center"
              size={167}
              summaryAggregationMode="none"
              valueOverride="{{ item }}"
            />
            <Column
              id="3c66e"
              alignment="left"
              format="datetime"
              formatOptions={{
                dateFormat: "'yyyy-MM-dd'",
                manageTimeZone: true,
                valueTimeZone: "00:00",
                displayTimeZone: "local",
                timeFormat: "'HH:mm'",
              }}
              groupAggregationMode="none"
              key="submitted_at"
              label="작성일시"
              placeholder="Enter value"
              position="center"
              size={111}
              summaryAggregationMode="none"
            />
            <Column
              id="f2dd6"
              alignment="center"
              editable={false}
              format="string"
              groupAggregationMode="none"
              key="assignee"
              label="담당자"
              placeholder="Enter value"
              position="center"
              size={79}
              summaryAggregationMode="none"
              valueOverride="{{ item === null ? '담당자 미정' : item }}"
            />
            <Column
              id="cb221"
              alignment="center"
              cellTooltip="관련 페이지 바로가기"
              cellTooltipMode="custom"
              format="icon"
              formatOptions={{ icon: "bold/interface-link-circle-alternate" }}
              groupAggregationMode="none"
              key="app_link"
              label="바로가기"
              position="center"
              size={57}
              summaryAggregationMode="none"
            >
              <Event
                event="clickCell"
                method="openUrl"
                params={{ ordered: [{ url: "{{ item }}" }] }}
                pluginId=""
                type="util"
                waitMs="0"
                waitType="debounce"
              />
            </Column>
            <Event
              event="doubleClickRow"
              method="run"
              params={{
                ordered: [
                  {
                    src: "varSelectedRow.setValue(currentSourceRow)\nmodalFrameAdmin.show();\ngetImages.trigger();\ngetReplies.trigger();",
                  },
                ],
              }}
              pluginId=""
              type="script"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="save"
              method="run"
              params={{
                ordered: [
                  {
                    src: "await varChangeObject.setValue(table2.changesetArray)\n\nupdateQueryForKanban.trigger()",
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
    </ListViewBeta>
    <Table
      id="table3"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getReportsQuery.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="{{ tabs1.value != 'list' }}"
      primaryKeyColumnId="5965d"
      rowHeight="medium"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="5965d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="false"
        key="id"
        label="ID"
        placeholder="Enter value"
        position="center"
        size={54}
      />
      <Column
        id="8e8c8"
        alignment="center"
        editable="true"
        editableOptions={{ allowCustomValue: false }}
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="in_scope"
        label="반영 범위"
        optionList={{
          manualData: [
            {
              ordered: [
                { value: "범위 내" },
                { label: "범위 내" },
                { caption: "명확히 유지보수 범위 내에 들어옴" },
                { color: "#f8fab4" },
              ],
            },
            {
              ordered: [
                { value: "제한적 수용" },
                { label: "제한적 수용" },
                { caption: "리소스 투입 대비 임팩트를 고려하여 수용" },
                { color: "#fee2ad" },
              ],
            },
            {
              ordered: [
                { value: "범위 외" },
                { label: "범위 외" },
                { caption: "명확히 유지보수 범위 내에 들어오지 않음" },
                { color: "#f08787" },
              ],
            },
          ],
        }}
        placeholder="Select option"
        position="center"
        size={92}
      />
      <Column
        id="52973"
        alignment="left"
        caption="{{ currentSourceRow.re }}"
        format="multilineString"
        groupAggregationMode="none"
        key="report_title"
        label="제목"
        placeholder="Enter value"
        position="center"
        size={310}
        sortMode="disabled"
        valueOverride="{{ item }}"
      />
      <Column
        id="1c976"
        alignment="left"
        cellTooltipMode="overflow"
        format="html"
        groupAggregationMode="none"
        key="report_description"
        label="요청 상세"
        placeholder="Enter value"
        position="center"
        size={308}
      />
      <Column
        id="a10c8"
        alignment="left"
        editable="true"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="category"
        label="문의 유형"
        optionList={{
          manualData: [
            { ordered: [{ value: "오류 신고" }] },
            { ordered: [{ value: "기능 개선 요청" }] },
            { ordered: [{ value: "작동 오류" }] },
            { ordered: [{ value: "데이터 오류" }] },
            { ordered: [{ value: "기능 개선" }] },
            { ordered: [{ value: "오타/오기" }] },
            { ordered: [{ value: "사용 방법 문의" }] },
          ],
        }}
        placeholder="Select option"
        position="center"
        size={108}
      />
      <Column
        id="9071a"
        alignment="center"
        format="multilineString"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="user_priority"
        label="우선 순위"
        optionList={{ mode: "manual" }}
        placeholder="Enter value"
        position="center"
        size={76}
        valueOverride="{{ item }}"
      />
      <Column
        id="5b4af"
        alignment="center"
        editable="true"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="status"
        label="진행 상태"
        optionList={{
          manualData: [
            { ordered: [{ value: "접수 대기" }, { color: "#f9f7dc" }] },
            {
              ordered: [
                { value: "담당자 지정" },
                { label: "담당자 지정" },
                { color: "#ffd97d" },
              ],
            },
            { ordered: [{ value: "처리 진행 중" }, { color: "#a8d5e2" }] },
            { ordered: [{ value: "처리 완료" }, { color: "#c5d86d" }] },
            { ordered: [{ value: "반영 예정" }, { color: "#c7ceea" }] },
            { ordered: [{ value: "보류" }, { color: "#ff9aa2" }] },
            { ordered: [{ value: "반려" }] },
          ],
          mode: "manual",
        }}
        placeholder="Select option"
        position="center"
        size={98}
        summaryAggregationMode="none"
      />
      <Column
        id="41394"
        alignment="left"
        caption="{{ currentSourceRow.submitter_email }}"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="submitter_name"
        label="작성자"
        placeholder="Enter value"
        position="center"
        size={199}
        valueOverride="{{ item }}"
      >
        <Event
          event="clickCell"
          method="run"
          params={{
            ordered: [
              {
                src: "utils.copyToClipboard(currentSourceRow.submitter_email);\n\nutils.showNotification(\n  { title: '복사 성공',\n    notificationType: 'success',\n    description: '이메일 주소가 복사되었습니다.'\n  }\n)",
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="d8cd2"
        alignment="left"
        format="datetime"
        formatOptions={{
          dateFormat: "yyyy-MM-dd",
          timeFormat: "'HH:mm'",
          manageTimeZone: true,
          valueTimeZone: "00:00",
          displayTimeZone: "local",
        }}
        groupAggregationMode="none"
        key="last_updated_at"
        label="마지막 업데이트 일시"
        placeholder="Enter value"
        position="center"
        size={135}
      />
      <Column
        id="e87bf"
        alignment="left"
        editable={true}
        format="datetime"
        formatOptions={{ dateFormat: "yyyy-MM-dd", timeFormat: "'HH:mm'" }}
        groupAggregationMode="none"
        key="resolved_at"
        label="처리완료 일시"
        placeholder="Enter value"
        position="center"
        size={137}
        summaryAggregationMode="none"
      />
      <Column
        id="3c66e"
        alignment="left"
        format="datetime"
        formatOptions={{
          dateFormat: "'yyyy-MM-dd'",
          manageTimeZone: true,
          valueTimeZone: "00:00",
          displayTimeZone: "local",
          timeFormat: "'HH:mm'",
        }}
        groupAggregationMode="none"
        key="submitted_at"
        label="작성일시"
        placeholder="Enter value"
        position="center"
        size={111}
        summaryAggregationMode="none"
      />
      <Column
        id="f2dd6"
        alignment="center"
        editable={true}
        format="string"
        groupAggregationMode="none"
        key="assignee"
        label="담당자"
        placeholder="Enter value"
        position="center"
        size={79}
        valueOverride="{{ item === null ? '담당자 미정' : item }}"
      />
      <Column
        id="cb221"
        alignment="center"
        cellTooltip="관련 페이지 바로가기"
        cellTooltipMode="custom"
        format="icon"
        formatOptions={{ icon: "bold/interface-link-circle-alternate" }}
        groupAggregationMode="none"
        key="app_link"
        label="바로가기"
        position="center"
        size={74}
      >
        <Event
          event="clickCell"
          method="openUrl"
          params={{ ordered: [{ url: "{{ item }}" }] }}
          pluginId=""
          type="util"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="fd4f2"
        alignment="left"
        editable="true"
        format="tags"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="admin_category"
        label="관리자 카테고리"
        optionList={{
          manualData: [
            { ordered: [{ value: "오류" }] },
            { ordered: [{ value: "사용법 미숙지" }] },
            { ordered: [{ value: "기능 개선 요청" }] },
            { ordered: [{ value: "원천 데이터 이슈" }] },
          ],
        }}
        placeholder="Select options"
        position="center"
        referenceId="column13"
        size={116}
        summaryAggregationMode="none"
      />
      <Column
        id="55e6b"
        alignment="left"
        editable={true}
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="admin_priority"
        label="관리자 우선순위"
        optionList={{ manualData: [{ ordered: [{ value: "Option 1" }] }] }}
        placeholder="Select option"
        position="center"
        size={100}
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
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="refresh"
          pluginId="table3"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="doubleClickRow"
        method="run"
        params={{
          ordered: [
            {
              src: "varSelectedRow.setValue(currentSourceRow)\n//  modalFrameAdmin.show();\nmodalFrameReportsDetailUser.show();\ngetFileAttachments.trigger();\ngetReplies.trigger();",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
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
        pluginId="saveAction"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</Screen>
