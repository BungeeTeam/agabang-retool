<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrameAddGroup_archive.rsx" />
  <Include src="./src/modalFrameExcluededShop.rsx" />
  <Include src="./src/modalFrameFlexShop.rsx" />
  <Include src="./src/modalFrameShopHandover.rsx" />
  <Include src="./src/modalFrameUserguide.rsx" />
  <Include src="./sidebar.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="0"
    sticky={null}
    type="main"
  >
    <Include src="./src/tabbedContainer1.rsx" />
    <Include src="./src/container13.rsx" />
  </Frame>
</App>
