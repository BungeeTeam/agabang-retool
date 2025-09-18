<ModalFrame
  id="modalFrame1"
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
    <Text id="modalTitle1" value="### 브랜드 이동" verticalAlign="center" />
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
        pluginId="modalFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Module
      id="ettoiTopNavigation1"
      name="[Ettoi] Top Navigation"
      pageUuid="23db4ad0-584c-11ef-9b9e-67431c50447f"
    />
    <Module
      id="disneyTopNavigation1"
      name="[Disney] Top Navigation"
      pageUuid="a07259aa-d6c6-11ef-a4e9-df284a657f5e"
    />
  </Body>
</ModalFrame>
