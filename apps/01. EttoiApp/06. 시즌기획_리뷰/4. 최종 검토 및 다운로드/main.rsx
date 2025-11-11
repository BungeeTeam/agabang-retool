<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <DocumentTitle id="$customDocumentTitle" value="최종 검토 및 다운로드 | ET" />
  <Include src="./header.rsx" />
  <Include src="./src/shop_sales.rsx" />
  <Include src="./src/splitPaneFrame1.rsx" />
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
      id="module최종검토및다운로드1"
      name="(module) 최종 검토 및 다운로드"
      pageUuid="6d686752-5722-11f0-a85e-e70fb4f4f4a2"
      var_brand_code="{{ var_brand_code.value }}"
    />
  </Frame>
</App>
