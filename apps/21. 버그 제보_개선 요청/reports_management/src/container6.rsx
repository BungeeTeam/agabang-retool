<Container
  id="container6"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="0"
  showBody={true}
>
  <View id="7b7dc" viewKey="View 1">
    <Text
      id="modalTitle5"
      value="작성자: {{ getReplies.data.filter(i=>i.id === item)[0].sumitter_name}} | 작성일시: {{ moment(getReplies.data.filter(i=>i.id === item)[0].submitted_time).format('YYYY-MM-DD HH:MM')}}"
      verticalAlign="center"
    />
    <Divider id="divider2" />
    <Text
      id="text1"
      value="{{ getReplies.data.filter(i=>i.id === item)[0].contents}}"
      verticalAlign="center"
    />
    <ToggleLink
      id="toggleLink4"
      hidden="{{ getReplies.data.filter(i=>i.id === item)[0].file_attachments.length <= 0}}"
      text="{{ self.value ? '첨부파일' : '첨부파일 숨기기' }}"
      value="true"
    />
    <Table
      id="table7"
      actionsOverflowPosition={1}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getReplies.data.filter(i=>i.id === item)[0].file_attachments}}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicRowHeights={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden="{{ toggleLink4.value }}"
      primaryKeyColumnId="26ba2"
      rowHeight="small"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="26ba2"
        alignment="left"
        editable={false}
        format="image"
        formatOptions={{ widthType: "fit" }}
        groupAggregationMode="none"
        key="base64Data"
        placeholder="Enter value"
        position="center"
        size={60.953125}
        summaryAggregationMode="none"
      />
      <Column
        id="47a92"
        alignment="left"
        format="link"
        formatOptions={{ showUnderline: "hover", underlineStyle: "solid" }}
        groupAggregationMode="none"
        key="name"
        label="파일명"
        position="center"
        size={342.59375}
        summaryAggregationMode="none"
      />
      <Column
        id="6031c"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="type"
        label="파일 형식"
        placeholder="Enter value"
        position="center"
        size={104.453125}
        summaryAggregationMode="none"
      />
      <Action
        id="e2cd0"
        icon="bold/interface-download-button-2"
        label="첨부파일 다운로드"
      >
        <Event
          event="clickAction"
          method="run"
          params={{
            ordered: [
              {
                src: '//  utils.downloadFile(\n//    {\n//      data:currentSourceRow.base64Data,\n//      fileName:currentSourceRow.name,\n//      type:currentSourceRow.type\n//    }\n//  )\n\nconst file = currentSourceRow; // 필요에 맞게 변경\n\nconst b64 = file.base64Data.includes("base64,")\n  ? file.base64Data.split("base64,")[1]\n  : file.base64Data;\n\nconst bytes = Uint8Array.from(atob(b64), c => c.charCodeAt(0));\nconst blob = new Blob([bytes], { type: file.type || "application/octet-stream" });\n\nconst a = document.createElement("a");\na.href = URL.createObjectURL(blob);\na.download = file.name || "download";\na.click();',
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Action>
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
          pluginId="table7"
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
          pluginId="table7"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
</Container>
