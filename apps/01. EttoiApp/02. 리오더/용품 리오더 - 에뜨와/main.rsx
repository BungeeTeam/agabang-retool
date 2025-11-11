<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <Include src="./header.rsx" />
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
    <Module
      id="module용품리오더메인테이블1"
      name="(module) 용품 리오더 메인 테이블"
      pageUuid="35296352-3b82-11f0-b398-4356568493d2"
      var_brand_code="{{var_brand_code.value}}"
    />
  </Frame>
</App>
