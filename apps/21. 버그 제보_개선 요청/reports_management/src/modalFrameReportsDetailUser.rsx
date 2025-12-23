<ModalFrame
  id="modalFrameReportsDetailUser"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
  size="large"
>
  <Header>
    <Text
      id="modalTitle1"
      value="##### {{ varSelectedRow.value.report_title }}"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton1"
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
        pluginId="modalFrameReportsDetailUser"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="clearValue"
        params={{ ordered: [] }}
        pluginId="textArea2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="modalTitle2"
      value="작성자: {{ varSelectedRow.value.submitter_name }} | 작성일시: {{ moment(varSelectedRow.value.submitted_at).format('YYYY-MM-DD HH:MM') }}"
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Text
      id="text29"
      value="{{varSelectedRow.value.report_description }}"
      verticalAlign="center"
    />
    <ToggleLink
      id="toggleLink3"
      hidden="{{ varSelectedRow.value.file_attachments.length <= 0}}"
      text="{{ self.value ? '첨부파일' : '첨부파일 숨기기' }}"
      value="true"
    />
    <Table
      id="table6"
      actionsOverflowPosition={1}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ varSelectedRow.value.file_attachments }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicRowHeights={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden="{{ toggleLink3.value }}"
      rowHeight="small"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="26ba2"
        alignment="left"
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
        id="29c65"
        icon="bold/interface-download-button-2"
        label="Action 1"
      >
        <Event
          event="clickAction"
          method="run"
          params={{
            ordered: [
              {
                src: "utils.downloadFile(\n  {\n    data:currentSourceRow.base64Data,\n    fileName:currentSourceRow.name,\n    type:currentSourceRow.type\n  }\n)",
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
          pluginId="table6"
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
          pluginId="table6"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <KeyValue
      id="keyValue3"
      data="{
  '관련 페이지 주소': {{varSelectedRow.value.app_link }} ,
  '진행 상태': [{{varSelectedRow.value.status }}]
}"
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="singleColumn"
      labelWrap={true}
    >
      <Property
        id="문의내역 상세"
        editable="false"
        editableOptions={{}}
        format="multilineString"
        formatOptions={{}}
        hidden="false"
        label="문의내역 상세"
      />
      <Property
        id="관련 페이지 주소"
        editable="false"
        editableOptions={{}}
        format="link"
        formatOptions={{ showUnderline: "hover", underlineStyle: "solid" }}
        hidden="false"
        label="관련 페이지 주소"
      />
      <Property
        id="진행 상태"
        editable="false"
        editableOptions={{}}
        format="tags"
        formatOptions={{ automaticColors: true }}
        hidden="false"
        label="진행 상태"
      />
    </KeyValue>
    <Divider id="divider1" />
    <Text
      id="text2"
      value="###### 댓글({{ getReplies.data.length }}개)"
      verticalAlign="center"
    />
    <ListViewBeta
      id="listView2"
      data="{{ getReplies.data.map(i => i.id) }}"
      heightType="auto"
      hidden="{{ getReplies.data.length > 0 ? false : true}}"
      itemWidth="200px"
      margin="0"
      numColumns={3}
      padding="0"
    >
      <Include src="./container6.rsx" />
    </ListViewBeta>
    <Container
      id="container5"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="containerTitle5"
          value="###### 댓글 추가하기"
          verticalAlign="center"
        />
      </Header>
      <View id="367e2" viewKey="View 1">
        <TextArea
          id="textArea2"
          autoResize={true}
          label=""
          labelPosition="top"
          minLines="5"
          placeholder="Enter value"
        />
        <Button
          id="button2"
          disabled="{{ !textArea2.value }}"
          iconAfter="bold/mail-send-email"
          loading="{{ updateReplies.isFetching || updateTs.isFetching }}"
          text="제출하기"
        >
          <Event
            event="click"
            method="run"
            params={{
              ordered: [
                {
                  src: "await updateReplies.trigger();\ngetReplies.trigger();\nupdateTs.trigger();",
                },
              ],
            }}
            pluginId=""
            type="script"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <FileButton
          id="fileButton1"
          _isUpgraded={true}
          appendNewSelection={true}
          iconBefore="bold/programming-browser-search"
          maxCount={20}
          maxSize="250mb"
          selectionType="multiple"
          styleVariant="outline"
          text="파일 첨부"
        />
      </View>
    </Container>
  </Body>
</ModalFrame>
