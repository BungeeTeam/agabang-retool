<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <GlobalWidgetProp id="var_brand_code" value="'01'" />
  <Include src="./src/drawerFrame1.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <ModuleContainerWidget
      id="moduleContainer"
      backgroundColor="white"
      brand_code="'07'"
      isGlobalWidgetContainer={true}
      var_brand_code="'01'"
    >
      <Module
        id="itemDetail1"
        brand_code="{{ var_brand_code.value }}"
        margin="0"
        name="item_detail"
        pageUuid="17be4764-ecd2-11ef-8654-fbc4f3e414ec"
        sel_sty="{{ var_main_item_info.value }}"
      />
      <Include src="./src/container5.rsx" />
    </ModuleContainerWidget>
  </Frame>
</App>
