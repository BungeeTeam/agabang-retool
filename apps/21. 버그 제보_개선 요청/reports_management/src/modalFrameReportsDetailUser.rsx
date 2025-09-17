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
      value="### {{ varSelectedRow.value.report_title }}"
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
        method="run"
        params={{ ordered: [{ src: "richTextEditor1.setValue('')" }] }}
        pluginId=""
        type="script"
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
        </View>
      </Container>
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
        <TextEditor id="richTextEditor1" margin="0" value="" />
        <Button
          id="button2"
          disabled="{{ current_user.fullName === '클리브' }}"
          iconAfter="bold/mail-send-email"
          text="제출하기"
        >
          <Event
            event="click"
            method="run"
            params={{
              ordered: [
                {
                  src: "await updateReplies.trigger();\ngetReplies.trigger();\nslackThreadAlert.trigger();",
                },
              ],
            }}
            pluginId=""
            type="script"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </Body>
</ModalFrame>
