<DrawerFrame
  id="drawerFrame_item_detail_new"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="0"
  showOverlay={true}
  width="large"
>
  <Header>
    <Text
      id="drawerTitle2"
      value="### Container title"
      verticalAlign="center"
    />
    <Button
      id="drawerCloseButton2"
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
        pluginId="drawerFrame_item_detail_new"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Module
      id="itemDetail2"
      brand_code="{{ brand_code.value }}"
      name="item_detail"
      pageUuid="17be4764-ecd2-11ef-8654-fbc4f3e414ec"
      sel_sty="{{  var_sel_sty.value }}"
    />
  </Body>
</DrawerFrame>
