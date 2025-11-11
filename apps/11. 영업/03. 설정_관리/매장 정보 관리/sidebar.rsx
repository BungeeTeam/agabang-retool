<SidebarFrame
  id="sidebarFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  isHiddenOnMobile={true}
  padding="8px 12px"
  showHeader={true}
  width="large"
>
  <Header>
    <Text
      id="text9"
      style={{ ordered: [] }}
      value="#### 설정/관리 "
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Navigation
      id="navigation1"
      itemMode="static"
      orientation="vertical"
      retoolFileObject={{ ordered: [] }}
    >
      <Option
        id="07522"
        disabled={false}
        hidden={false}
        icon="bold/shopping-store-1"
        iconPosition="left"
        itemType="custom"
        label="매장 정보 관리"
      >
        <Event
          event="click"
          method="run"
          params={{
            ordered: [
              {
                src: "tabbedContainer1.setHidden(false)\ncontainer13.setHidden(true)",
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Option>
      <Option
        id="a590d"
        disabled={false}
        hidden={false}
        icon="bold/shipping-transfer-cart"
        iconPosition="left"
        itemType="custom"
        label="채널 정보 관리"
      >
        <Event
          event="click"
          method="run"
          params={{
            ordered: [
              {
                src: "tabbedContainer1.setHidden(true)\ncontainer13.setHidden(false)",
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Option>
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: "tabs1.setValue('shopFlex')\ntabbedContainer1.setHidden(false)\ncontainer13.setHidden(true)",
            },
          ],
        }}
        pluginId=""
        targetId="6a04f"
        type="script"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: "tabs1.setValue('shopExclude')\ntabbedContainer1.setHidden(false)\ncontainer13.setHidden(true)",
            },
          ],
        }}
        pluginId=""
        targetId="1c12d"
        type="script"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: "tabs1.setValue('shopHandover')\ntabbedContainer1.setHidden(false)\ncontainer13.setHidden(true)",
            },
          ],
        }}
        pluginId=""
        targetId="a4ae1"
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Navigation>
  </Body>
  <Footer>
    <Avatar
      id="avatar1"
      fallback="{{ current_user.fullName }}"
      imageSize={32}
      label="{{ current_user.fullName }}"
      labelCaption="{{ current_user.email }}"
      margin="4px 4px"
      src="{{ current_user.profilePhotoUrl }}"
      style={{ ordered: [{ background: "automatic" }] }}
    />
  </Footer>
</SidebarFrame>
