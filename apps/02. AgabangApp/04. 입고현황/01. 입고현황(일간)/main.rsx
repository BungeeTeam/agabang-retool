<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css="" />
  <Include src="./header.rsx" />
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
      id="module1"
      brand_code="{{var_brand_code.value}}"
      name="입고현황(일간)"
      pageUuid="372e20d8-ed0e-11ef-b7e2-a70f83dbd708"
    />
  </Frame>
</App>
