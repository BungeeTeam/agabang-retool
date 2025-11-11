<ModalFrame
  id="alertModal3"
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
    <Text id="modalTitle6" verticalAlign="center" />
    <Button
      id="modalCloseButton6"
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
        pluginId="alertModal3"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Text
      id="text20"
      disableMarkdown={true}
      horizontalAlign="center"
      style={{
        ordered: [
          { fontSize: "h6Font" },
          { fontWeight: "h6Font" },
          { fontFamily: "h6Font" },
          { background: "rgba(158, 116, 116, 0)" },
        ],
      }}
      value="⚠️ 발주 최적화 시뮬레이션을 먼저 진행해 주세요"
      verticalAlign="center"
    />
  </Body>
</ModalFrame>
