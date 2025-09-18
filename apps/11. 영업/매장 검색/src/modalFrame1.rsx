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
  size="fullScreen"
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
    id="storeDetailModule1"
    endDate="{{ moment().subtract(1,'days').format('YYYY-MM-DD') }}"
    inputData="{{ getShopList.data }}"
    name="storeDetailModule"
    pageUuid="f4960172-fb37-11ef-af6c-1f09ee775f43"
    startDate="{{ moment().subtract(8,'days').format('YYYY-MM-DD') }}"
  />
</ModalFrame>
