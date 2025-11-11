<ModalFrame
  id="modalFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="0"
  showOverlay={true}
  size="medium"
>
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
  <Module
    id="itemDetail1"
    brand_code="01"
    name="item_detail"
    pageUuid="17be4764-ecd2-11ef-8654-fbc4f3e414ec"
    sel_sty="{{ var_item_info.value }}"
  />
</ModalFrame>
