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
  </Header>
  <Body>
    <Text
      id="text30"
      value="{{varSelectedRow.value.report_description }}"
      verticalAlign="center"
    />
    <KeyValue
      id="keyValue2"
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
    <Image
      id="image1"
      hidden="{{ !getImages.data[0] }}"
      horizontalAlign="center"
      retoolFileObject="{{ getImages.data[0] }}"
      src="https://picsum.photos/id/1025/800/600"
      srcType="retoolFileObject"
    >
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getImages"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Image>
    <Image
      id="image2"
      hidden="{{ !getImages.data[1] }}"
      horizontalAlign="center"
      retoolFileObject="{{ getImages.data[1] }}"
      src="https://picsum.photos/id/1025/800/600"
      srcType="retoolFileObject"
    />
    <Image
      id="image3"
      hidden="{{ !getImages.data[2] }}"
      horizontalAlign="center"
      retoolFileObject="{{ getImages.data[2] }}"
      src="https://picsum.photos/id/1025/800/600"
      srcType="retoolFileObject"
    />
    <Image
      id="image4"
      hidden="{{ !getImages.data[3] }}"
      horizontalAlign="center"
      retoolFileObject="{{ getImages.data[3] }}"
      src="https://picsum.photos/id/1025/800/600"
      srcType="retoolFileObject"
    />
    <Divider id="divider3" />
    <Button id="button4" text="첨부파일 다운로드">
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: "utils.downloadFile({base64Binary: getImages.data['0'].base64Data },'파일 다운로드','xlsx')",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
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
      <Container
        id="container7"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="0"
        showBody={true}
      >
        <View id="7b7dc" viewKey="View 1">
          <Text
            id="modalTitle6"
            value="작성자: {{ getReplies.data.filter(i=>i.id === item)[0].sumitter_name}} | 작성일시: {{ moment(getReplies.data.filter(i=>i.id === item)[0].submitted_time).format('YYYY-MM-DD HH:MM')}}"
            verticalAlign="center"
          />
          <Divider id="divider4" />
          <Text
            id="text4"
            value="{{ getReplies.data.filter(i=>i.id === item)[0].contents}}"
            verticalAlign="center"
          />
        </View>
      </Container>
    </ListViewBeta>
    <Container
      id="container8"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
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
        <TextEditor id="richTextEditor2" margin="0" value="" />
        <Button id="button3" iconAfter="bold/mail-send-email" text="제출하기">
          <Event
            event="click"
            method="run"
            params={{
              ordered: [
                {
                  src: "  await updateRepliesAdmin.trigger();\n  await getReplies.trigger();\nmail.trigger();\n",
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
