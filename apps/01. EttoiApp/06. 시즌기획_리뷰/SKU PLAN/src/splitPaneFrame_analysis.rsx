<SplitPaneFrame
  id="splitPaneFrame_analysis"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden="true"
  isHiddenOnMobile={true}
  padding="8px 12px"
  position="right"
  showFooterBorder={false}
  showHeaderBorder={false}
  width="50%"
>
  <Text
    id="text3"
    style={{
      ordered: [
        { fontSize: "h4Font" },
        { fontWeight: "h4Font" },
        { fontFamily: "h4Font" },
      ],
    }}
    value="{{var_select_category.value}}"
    verticalAlign="center"
  />
  <Button
    id="button_analysis2"
    iconBefore="bold/interface-arrows-right"
    style={{ ordered: [{ background: "info" }] }}
  >
    <Event
      event="click"
      method="hide"
      params={{ ordered: [] }}
      pluginId="splitPaneFrame_analysis"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
  </Button>
  <Select
    id="select_ai_history"
    data="{{ get_ai_result.data }}"
    emptyMessage="No options"
    label=""
    labelPosition="top"
    labels={'{{ moment(item.reg_time).format("Y-MM-DD HH:mm:ss") }}'}
    overlayMaxHeight={375}
    showSelectionIndicator={true}
    textBefore="지난분석"
    value="{{ get_ai_result.data.id[0] }}"
    values="{{ item.id }}"
  />
  <TextArea
    id="textArea_prompt"
    autoResize={true}
    label="📝 요청 내용"
    labelPosition="top"
    minLines="4"
    value="{{ get_ai_result.data.id.length == 0 ? var_default_prompt.value : select_ai_history.selectedItem.prompt }}"
  />
  <Button
    id="button_analysis3"
    iconBefore="bold/interface-edit-magic-wand"
    style={{ ordered: [{ background: "warning" }] }}
    text="분석"
  >
    <Event
      event="click"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_analysis"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </Button>
  <Text
    id="text_ai_result"
    disableMarkdown={true}
    value="{{ get_ai_result.data.id.length == 0 ? '분석이 완료되면 여기에 결과가 출력됩니다' : select_ai_history.selectedItem.result }}"
    verticalAlign="center"
  />
</SplitPaneFrame>
