<ModalFrame
  id="modalFrameAddGroup_archive"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
>
  <Header>
    <Text
      id="modalTitle8"
      value="##### 채널 그룹 추가"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton7"
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
        pluginId="modalFrameAddGroup_archive"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Container
      id="container20"
      _align="center"
      _direction="vertical"
      _gap="10px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      padding="10px"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle24"
          style={{
            ordered: [
              { fontSize: "12px" },
              { fontWeight: "500" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          value="###### 매장 추가"
          verticalAlign="center"
        />
      </Header>
      <View id="70ea3" viewKey="View 1">
        <TextInput
          id="group_nm"
          label="그룹명"
          labelPosition="top"
          labelWidth="25"
          placeholder="그룹명을 입력하세요"
        />
        <Button id="flexShopAddButton2" heightType="auto" text="추가">
          <Event
            event="click"
            method="setValue"
            params={{
              ordered: [
                {
                  value:
                    "[{\nbiz_cd: {{ bizSelect.value }}\n,group_nm: {{ group_nm.value }}\n}]",
                },
              ],
            }}
            pluginId="varGroupName"
            type="state"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="click"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="insertGroup"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </Body>
</ModalFrame>
