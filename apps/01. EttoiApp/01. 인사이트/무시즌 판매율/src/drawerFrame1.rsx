<DrawerFrame
  id="drawerFrame1"
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
      id="drawerTitle1"
      value="### Container title"
      verticalAlign="center"
    />
    <Button
      id="drawerCloseButton1"
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
        pluginId="drawerFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Module
      id="itemDetail1"
      brand_code="01"
      name="item_detail"
      pageUuid="17be4764-ecd2-11ef-8654-fbc4f3e414ec"
      sel_sty="{{ var_selected_item_info.value }}"
    />
  </Header>
  <Body>
    <Module
      id="itemDetail2"
      brand_code="{{ var_brand_code.value }}"
      margin="0"
      name="item_detail"
      pageUuid="17be4764-ecd2-11ef-8654-fbc4f3e414ec"
      sel_sty="{{ var_selected_item_info.value }}"
    />
  </Body>
</DrawerFrame>
