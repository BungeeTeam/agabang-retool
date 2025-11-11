<App>
  <Include src="./functions.rsx" />
  <DocumentTitle id="$customDocumentTitle" value="매출비중 | ET" />
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
      name="매출비중"
      pageUuid="6c4e5b84-f01f-11ef-b5ad-db9325754cbc"
    />
  </Frame>
</App>
