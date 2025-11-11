<App>
  <Include src="./functions.rsx" />
  <GlobalWidgetProp id="brand_code" defaultValue="01" />
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
      isGlobalWidgetContainer={true}
      margin="0"
    >
      <Include src="./src/container1.rsx" />
    </ModuleContainerWidget>
  </Frame>
</App>
