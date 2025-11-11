<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <DocumentTitle id="$customDocumentTitle" value="발주량 산정 | ET" />
  <Include src="./header.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="0"
    sticky={null}
    type="main"
  >
    <Module
      id="module1"
      brand_code="{{ var_brand_code.value }}"
      margin="0"
      name="발주량 산정"
      pageUuid="47b45410-45d1-11f0-89e7-47d4b1558cae"
    />
  </Frame>
</App>
