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
      id="module용품리오더시뮬레이션테이블형1"
      name="(module) 용품 리오더 시뮬레이션 - 테이블형"
      pageUuid="570dfb3c-3b9f-11f0-abda-73cafb211a8e"
      var_brand_code="{{ var_brand_code.value }}"
    />
  </Frame>
</App>
