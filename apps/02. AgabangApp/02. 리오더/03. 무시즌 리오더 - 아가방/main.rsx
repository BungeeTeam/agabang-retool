<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <Include src="./header.rsx" />
  <Include src="./src/drawerFrame1.rsx" />
  <Include src="./src/modal_bulk_simulation.rsx" />
  <Include src="./src/modalFrame1.rsx" />
  <Include src="./src/modalFrame2.rsx" />
  <Include src="./src/modalFrame3.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Module
      id="module2무시즌리오더1"
      name="(module2) 무시즌 리오더"
      pageUuid="4b2917e6-3557-11f0-a449-53fc37faf403"
      var_brand_code="{{ var_brand_code.value }}"
    />
  </Frame>
</App>
