<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
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
      brand_code="'79'"
      margin="0"
      name="입고현황(시즌)"
      pageUuid="4cba04d2-ed93-11ef-abe4-ebf2d8297a67"
      yongpum_brand_code={"\"'79'\""}
    />
  </Frame>
</App>
