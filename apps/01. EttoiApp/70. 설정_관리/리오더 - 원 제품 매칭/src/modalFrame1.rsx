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
  style={{ ordered: [{ background: "canvas" }] }}
>
  <Header>
    <Text
      id="modalTitle1"
      heightType="fixed"
      value="#### {{sel_s3_key.value.split('/')[2] }}"
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
        pluginId="modalFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Image
      id="image3"
      fit="contain"
      heightType="fixed"
      horizontalAlign="center"
      src="https://ettoi-image.s3.ap-northeast-2.amazonaws.com/{{encodeURIComponent(sel_s3_key.value)}}"
    />
    <Spacer id="spacer6" />
  </Body>
</ModalFrame>
