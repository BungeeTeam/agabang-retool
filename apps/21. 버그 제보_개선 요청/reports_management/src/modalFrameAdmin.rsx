<ModalFrame
  id="modalFrameAdmin"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
  size="fullScreen"
>
  <Header>
    <Text
      id="modalTitle3"
      value="### {{ varSelectedRow.value.report_title }}"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton2"
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
        pluginId="modalFrameAdmin"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <KeyValue
      id="keyValue2"
      data="{
  '관련 페이지 주소': {{varSelectedRow.value.app_link }} ,
  '진행 상태': [{{varSelectedRow.value.status }}]
}"
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="wrap"
      itemLabelPosition="top"
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
        editableOptions={{}}
        format="tags"
        formatOptions={{ automaticColors: true }}
        hidden="false"
        label="진행 상태"
        optionList={{
          mode: "manual",
          manualData: [
            { ordered: [{ value: "처리 진행 중" }, { label: "처리 진행 중" }] },
          ],
        }}
      />
      <Event
        event="save"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="updateQuery2"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </KeyValue>
  </Header>
  <Body>
    <Text
      id="text30"
      value="{{varSelectedRow.value.report_description }}"
      verticalAlign="center"
    />
    <ToggleLink
      id="toggleLink5"
      hidden="{{ getFileAttachments.data[0].file_attachments.length <= 0}}"
      text="{{ self.value ? '첨부파일' : '첨부파일 숨기기' }}"
      value="true"
    />
    <Table
      id="table8"
      actionsOverflowPosition={1}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getFileAttachments.data[0].file_attachments }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicRowHeights={true}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      hidden="{{ toggleLink5.value }}"
      primaryKeyColumnId="47a92"
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
        editable={false}
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
          pluginId="table8"
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
          pluginId="table8"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Divider id="divider3" />
    <Text
      id="text3"
      value="###### 댓글({{ getReplies.data.length }}개)"
      verticalAlign="center"
    />
    <ListViewBeta
      id="listView3"
      data="{{ getReplies.data.map(i => i.id) }}"
      heightType="auto"
      hidden="{{ getReplies.data.length > 0 ? false : true}}"
      itemWidth="200px"
      margin="0"
      numColumns={3}
      padding="0"
    >
      <Include src="./container7.rsx" />
    </ListViewBeta>
    <Container
      id="container8"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      heightType="fixed"
      padding="12px"
      showBody={true}
      showFooter={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="containerTitle6"
          value="###### 댓글 추가하기"
          verticalAlign="center"
        />
      </Header>
      <View id="367e2" viewKey="View 1">
        <TextArea
          id="textArea3"
          autoResize={true}
          label=""
          labelPosition="top"
          minLines="10"
          placeholder="Enter value"
        />
      </View>
      <Footer>
        <FileInput
          id="fileInput3"
          _isUpgraded={true}
          iconBefore="bold/programming-browser-search"
          label=""
          labelPosition="top"
          maxCount={20}
          maxSize="250mb"
          placeholder="클릭하여 파일 첨부"
          selectionType="multiple"
          textBefore="파일 첨부"
        />
        <Button id="button3" iconAfter="bold/mail-send-email" text="제출하기">
          <Event
            event="click"
            method="run"
            params={{
              ordered: [
                {
                  src: "await updateRepliesAdmin.trigger();\nawait getReplies.trigger();\nmail.trigger();\n\n",
                },
              ],
            }}
            pluginId=""
            type="script"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </Footer>
    </Container>
  </Body>
</ModalFrame>
