<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <Include src="./header.rsx" />
  <Include src="./src/drawerFrame1.rsx" />
  <Include src="./src/modal_bulk_simulation.rsx" />
  <Include src="./src/modalFrame1.rsx" />
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
      id="module시즌리오더메인테이블1"
      name="(module) 시즌 리오더 메인 테이블"
      pageUuid="c1da5a5a-3a00-11f0-accb-931dcd8f8aab"
      var_brand_code="{{ var_brand_code.value }}"
    />
  </Frame>
</App>
