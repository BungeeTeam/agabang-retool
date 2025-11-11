<DrawerFrame
  id="bizDrawerFrame"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showFooter={true}
  showHeader={true}
  showOverlay={true}
  width="large"
>
  <Header>
    <Text
      id="drawerTitle1"
      value="### {{ selectedRow.value.biz_nm }} 매장목록"
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
        pluginId="bizDrawerFrame"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Module
      id="storeDetailModule2"
      endDate="{{ dateRange.value.end }}"
      inputData="{{ periodSalesByBizShop.value }}"
      name="storeDetailModule"
      pageUuid="f4960172-fb37-11ef-af6c-1f09ee775f43"
      startDate="{{ dateRange.value.start }}"
    />
  </Body>
</DrawerFrame>
