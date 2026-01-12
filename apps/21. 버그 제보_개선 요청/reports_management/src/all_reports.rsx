<Screen
  id="all_reports"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title="제보/요청 내역 확인"
  urlSlug="all_reports"
>
  <SqlQuery
    id="query14"
    query={include("../lib/query14.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    type="main"
  >
    <TextInput
      id="textInput1"
      iconAfter="bold/interface-search"
      label=""
      labelPosition="top"
      placeholder="전체 제보/요청 내역에서 원하는 내용을 검색해 보세요. (예: '판매율 기능 개선', '김철수')"
      style={{ ordered: [{ borderRadius: "400px" }] }}
    />
    <Button
      id="button1"
      style={{ ordered: [{ borderRadius: "400px" }] }}
      text="+  새 요청 남기기"
    >
      <Event
        event="click"
        method="openUrl"
        params={{
          ordered: [
            {
              url: "https://agabang.cleave.work/app/reports_management/form#email={{ current_user.email }}&name={{ current_user.fullName }}",
            },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Table
      id="table1"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getReportsQuery.data }}"
      defaultFilters={{
        0: {
          ordered: [
            { id: "5a9b7" },
            { columnId: "41394" },
            { operator: "!=" },
            { value: "클리브" },
            { disabled: false },
          ],
        },
      }}
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="5965d"
      rowHeight="medium"
      searchTerm="{{ textInput1.value }}"
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
        size={48}
        summaryAggregationMode="none"
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
        editable="false"
        format="tag"
        formatOptions={{ automaticColors: false, icon: "", color: "" }}
        groupAggregationMode="none"
        key="status"
        label="진행 상태"
        optionList={{
          manualData: [
            { ordered: [{ value: "처리 진행 중" }, { color: "#a8d5e2" }] },
            { ordered: [{ value: "처리 완료" }, { color: "#c5d86d" }] },
            { ordered: [{ value: "반영 예정" }, { color: "#c7ceea" }] },
            { ordered: [{ value: "보류" }, { color: "#ff9aa2" }] },
            { ordered: [{ value: "접수 대기" }, { color: "#f9f7dc" }] },
            { ordered: [{ value: "담당자 지정" }, { color: "#ffd97d" }] },
          ],
        }}
        placeholder="Select option"
        position="center"
        size={98}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="updateRepliesAdmin"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
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
        size={96}
        summaryAggregationMode="none"
      />
      <Column
        id="f2dd6"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        hidden="true"
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
        label="자세히 보기"
        position="center"
        size={57}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="run"
          params={{
            ordered: [
              {
                src: "varSelectedRow.setValue(currentSourceRow);\nmodalFrameReportsDetailUser.show();\ngetReplies.trigger();",
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Event
        event="clickRow"
        method="run"
        params={{
          ordered: [
            {
              src: "varSelectedRow.setValue(currentSourceRow);\nmodalFrameReportsDetailUser.show();\nformatFiles.trigger();\ngetReplies.trigger();\ngetFileAttachments.trigger();\n",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</Screen>
