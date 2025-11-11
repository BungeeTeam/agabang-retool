<ModalFrame
  id="modalFrame5"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showOverlay={true}
>
  <Text
    id="modalTitle5"
    value="##### 📝 메모 남기기
{{sel_season.selectedLabel}} - {{var_category_info.value}}"
    verticalAlign="center"
  />
  <Button
    id="modalCloseButton5"
    ariaLabel="Close"
    horizontalAlign="right"
    iconBefore="bold/interface-delete-1"
    style={{ ordered: [{ border: "transparent" }] }}
    styleVariant="outline"
  >
    <Event
      event="click"
      method="setHidden"
      params={{ ordered: [{ hidden: true }] }}
      pluginId="modalFrame5"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
  </Button>
  <TextArea
    id="category_memo_textarea"
    autoResize={true}
    label=""
    labelPosition="top"
    minLines="10"
    placeholder="메모를 남겨주세요"
    value="{{get_category_memo.data[sel_season.value][var_category_info.value]}}"
  />
  <Button id="button2" text="저장">
    <Event
      event="click"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="update_category_memo"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </Button>
</ModalFrame>
