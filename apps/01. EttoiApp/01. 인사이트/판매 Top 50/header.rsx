<Frame
  id="$header"
  enableFullBleed={null}
  isHiddenOnDesktop={false}
  isHiddenOnMobile={true}
  padding="0"
  sticky={true}
  type="header"
>
  <Module
    id="ettoiTopNavigation1"
    margin="0"
    name="[Ettoi] Top Navigation"
    pageUuid="23db4ad0-584c-11ef-9b9e-67431c50447f"
  />
  <Button
    id="button1"
    hidden="{{!sidebarFrame1.hidden}}"
    style={{ ordered: [] }}
    styleVariant="outline"
    text="툴바 보기"
  >
    <Event
      event="click"
      method="setHidden"
      params={{ ordered: [{ hidden: false }] }}
      pluginId="sidebarFrame1"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
  </Button>
</Frame>
