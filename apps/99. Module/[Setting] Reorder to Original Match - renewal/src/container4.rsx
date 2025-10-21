<Container
  id="container4"
  _gap="0px"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  padding="12px"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Container
      id="stack3"
      _align="center"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="b4440" viewKey="View 1">
        <Text
          id="containerTitle2"
          style={{
            ordered: [
              { fontSize: "18px" },
              { fontWeight: "600" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          value="리오더 - 원 제품 매칭"
          verticalAlign="center"
        />
        <Container
          id="stack2"
          _direction="vertical"
          _gap="0px"
          _type="stack"
          footerPadding="4px 12px"
          headerPadding="4px 12px"
          margin="0"
          padding="0"
          showBody={true}
          showBorder={false}
        >
          <View id="8593e" viewKey="View 1">
            <ToggleLink
              id="toggleLink1"
              allowWrap={true}
              margin="12px 8px 4px 0px"
              style={{
                ordered: [
                  { fontSize: "12px" },
                  { fontWeight: "600" },
                  { fontFamily: "pretendard variable" },
                  { text: "#00a0e6" },
                ],
              }}
              text="{{ self.value ? '매칭방법 접기' : '매칭방법 확인하기' }}"
            >
              <Event
                event="change"
                method="trigger"
                params={{ ordered: [] }}
                pluginId="summary_sebu_prev"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
            </ToggleLink>
            <Text
              id="text26"
              disableMarkdown={true}
              hidden="{{ toggleLink1.value ? false : true }}"
              imageWidth="fill"
              margin="0px 8px 4px 12px"
              style={{
                ordered: [
                  { fontSize: "10px" },
                  { fontWeight: "400" },
                  { fontFamily: "pretendard variable" },
                  { background: "rgba(0, 0, 0, 0.14)" },
                ],
              }}
              value="1. 리오더 한 아이템(새로운 품번)을 선택합니다.
2. 원 아이템(과거 품번)을 선택합니다.
3. 저장 버튼을 누릅니다.
* 우측 테이블에서 매칭이 완료된 리스트를 확인합니다.
* 잘못 저장하였을시 우측 테이블에서 삭제 후 다시 매칭해주세요."
              verticalAlign="center"
            />
          </View>
        </Container>
      </View>
    </Container>
  </Header>
  <View id="6940f" viewKey="View 1">
    <Select
      id="reorder_sty_cd_select"
      captionByIndex="{{ item.sty_cd }}"
      colorByIndex=""
      data="{{ get_item_list_original.data }}"
      emptyMessage="검색 결과 없음"
      imageByIndex="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{ item.sty_cd }}.jpg
"
      label="1. 리오더 아이템 선택(신 품번)"
      labelPosition="top"
      labels="{{ item.sty_nm }} ({{ item.sty_cd }})"
      overlayMaxHeight={375}
      placeholder="리오더 스타일을 선택하세요"
      showClear={true}
      showSelectionIndicator={true}
      value=""
      values="{{ item.sty_cd }}"
    >
      <Option id="5eff2" value="Option 1" />
      <Option id="579b4" value="Option 2" />
      <Option id="977c1" value="Option 3" />
      <Event
        event="inputValueChange"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list_original"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Spacer id="spacer8" />
    <Select
      id="sty_cd_select"
      captionByIndex="{{ item.sty_cd }}"
      colorByIndex=""
      data="{{ get_item_list_reorder.data }}"
      emptyMessage="검색 결과 없음"
      imageByIndex="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{ item.sty_cd }}.jpg
"
      label="2. 기존 아이템 선택(구 품번)"
      labelPosition="top"
      labels="{{ item.sty_nm }} ({{ item.sty_cd }})"
      overlayMaxHeight={375}
      placeholder="기존 스타일을 선택하세요"
      showClear={true}
      showSelectionIndicator={true}
      value=""
      values="{{ item.sty_cd }}"
    >
      <Event
        event="inputValueChange"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list_original"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Spacer id="spacer9" />
    <Container
      id="container8"
      enableFullBleed={true}
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      heightType="fixed"
      overflowType="hidden"
      padding="12px"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="containerTitle8"
          style={{
            ordered: [
              { fontSize: "12px" },
              { fontWeight: "600" },
              { fontFamily: "pretendard variable" },
            ],
          }}
          value="기존 아이템 사진"
          verticalAlign="center"
        />
      </Header>
      <View id="02d86" viewKey="View 1">
        <Image
          id="image4"
          hidden="{{ sty_cd_select.selectedItem === null ? true : false}}"
          horizontalAlign="center"
          maintainSpaceWhenHidden={true}
          src="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{ sty_cd_select.value }}.jpg
"
        />
      </View>
    </Container>
    <Spacer id="spacer10" />
    <Button id="button3" text="저장">
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: "const reorderStyCd = reorder_sty_cd_select.selectedItem.sty_cd;\nconst baseStyCd = sty_cd_select.selectedItem.sty_cd;\n\nconst reorderChar = reorderStyCd.charAt(2).toUpperCase();\nconst baseChar = baseStyCd.charAt(2).toUpperCase();\n\nconst numericValue = reorderChar.charCodeAt(0) - baseChar.charCodeAt(0);\n\nif (numericValue < 0) {\n  utils.showNotification({\n    title: '입력 위치가 잘못되었습니다.',\n    description: '새 품번은 위쪽에, 기존 품번은 아래쪽에 입력해주세요!',\n    notificationType: 'warning'\n  });\n} else {\ninsert_match.trigger().then(() => { get_matched_list.trigger();\n  utils.showNotification({\n    title: '완료',\n    description: '등록 완료! 목록을 새로고침했어요 😊',\n    notificationType: 'success'\n  });\n})\n}",
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
