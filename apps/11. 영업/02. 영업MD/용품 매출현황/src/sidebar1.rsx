<SidebarFrame
  id="sidebarFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  isHiddenOnMobile={true}
  padding="8px 12px"
  width="{{ toggleButton1.value ? '50px' : 'large'}}"
>
  <Container
    id="stack1"
    _align="center"
    _gap="0px"
    _justify="space-between"
    _type="stack"
    footerPadding="4px 12px"
    headerPadding="4px 12px"
    heightType="fixed"
    margin="0"
    overflowType="hidden"
    padding="0"
    showBody={true}
    showBorder={false}
  >
    <View id="82cad" viewKey="View 1">
      <ToggleButton
        id="toggleButton1"
        horizontalAlign="right"
        iconForFalse="bold/interface-arrows-button-left-double"
        iconForTrue="bold/interface-arrows-button-right-duoble"
        iconPosition="right"
        margin="0"
        style={{ ordered: [{ border: "rgba(207, 207, 207, 0)" }] }}
        styleVariant="outline"
        text="{{ self.value ? '' : '' }}"
        value="false"
      />
      <Text
        id="text1"
        hidden="{{ toggleButton1.value }}"
        value="#### 용품 매출현황"
        verticalAlign="center"
      />
    </View>
  </Container>
  <Spacer id="spacer1" />
  <Multiselect
    id="bizMultiSelect"
    colorByIndex="{{ theme.tokens.primaryOpacity20 }}"
    data="{{
(() => {
  const seen = new Set();
  const result = shopInfoQuery
    .data
    .filter(item => {
      const key = `${item.biz_cd}-${item.biz_nm}`;
      if (seen.has(key)) return false;
      seen.add(key);
      return true;
  })

  return result
})()
}}"
    emptyMessage="No options"
    fallbackTextByIndex="{{ item.biz_cd }}"
    hidden="{{ toggleButton1.value }}"
    label="사업부"
    labelPosition="top"
    labels="{{ item.biz_nm }}"
    margin="0"
    overlayMaxHeight={375}
    placeholder="Select an option"
    showSelectionIndicator={true}
    value="{{ current_user.groups.map(i => i.name).includes('admin') ? ['A1'] :
  current_user.groups.map(i => i.name).includes('아가방 부문') ? ['A1'] : 
  current_user.groups.map(i => i.name).includes('에뜨와 부문') ? ['A4'] : 
  current_user.groups.map(i => i.name).includes('디즈니 부문') ? ['DS']:['A1']}}"
    values="{{ item.biz_cd }}"
    wrapTags={true}
  >
    <Event
      event="inputValueChange"
      method="trigger"
      params={{ ordered: [] }}
      pluginId=""
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </Multiselect>
  <Spacer id="spacer2" />
  <Multiselect
    id="brandMultiSelect"
    captionByIndex=""
    colorByIndex=""
    data="{{
(() => {
  const seen = new Set();
  const result = shopInfoQuery.data
    .filter(item => item.br_cd !== null && bizMultiSelect.value.includes(item.biz_cd))
    .filter(item => {
      const key = `${item.br_cd}-${item.br_nm}`;
      if (seen.has(key)) return false;
      seen.add(key);
      return true;
  })
  .sort((a, b) => a.br_cd - b.br_cd)
  return result
})()
}}"
    disabledByIndex=""
    emptyMessage="No options"
    fallbackTextByIndex="{{ item.br_cd }}"
    hidden="{{ toggleButton1.value }}"
    hiddenByIndex=""
    iconByIndex=""
    imageByIndex=""
    label="브랜드"
    labelPosition="top"
    labels="{{ item.br_nm }}"
    margin="0"
    overlayMaxHeight={375}
    placeholder="Select an option"
    showSelectionIndicator={true}
    style={{ ordered: [] }}
    tooltipByIndex=""
    value="{{ self.values }}"
    values="{{ item.br_cd }}"
    wrapTags={true}
  />
  <Spacer id="spacer3" />
  <Multiselect
    id="subBrandMultiSelect"
    captionByIndex=""
    colorByIndex=""
    data="{{
(() => {
  const seen = new Set();
  const result = shopInfoQuery.data
    .filter(item => item.br_cd !== null && bizMultiSelect.value.includes(item.biz_cd) && brandMultiSelect.value.includes(item.br_cd))
    .filter(item => {
      const key = `${item.sub_br_cd}-${item.sub_br_nm}`;
      if (seen.has(key)) return false;
      seen.add(key);
      return true;
  })
  .sort((a, b) => a.sub_br_cd - b.sub_br_cd)
  return result
})()
}}"
    disabledByIndex=""
    emptyMessage="No options"
    fallbackTextByIndex=""
    hidden="{{ toggleButton1.value || tabs1.value != '서브브랜드별' }}"
    hiddenByIndex=""
    hideLabel={false}
    iconByIndex=""
    imageByIndex=""
    label="서브브랜드"
    labelPosition="top"
    labels="{{ item.sub_br_nm }}"
    margin="0"
    overlayMaxHeight={375}
    placeholder="Select an option"
    showSelectionIndicator={true}
    style={{ ordered: [] }}
    tooltipByIndex=""
    value="{{ self.values }}"
    values="{{ item.sub_br_cd }}"
    wrapTags={true}
  />
</SidebarFrame>
