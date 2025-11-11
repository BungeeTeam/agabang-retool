<SidebarFrame
  id="sidebarFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  isHiddenOnMobile={true}
  padding="8px 12px"
  showHeader={true}
  width="large"
>
  <Header>
    <Text id="text38" value="#### 플렉스 상세" verticalAlign="center" />
  </Header>
  <Body>
    <Multiselect
      id="bizMultiSelect"
      colorByIndex="{{ theme.tokens.primaryOpacity20 }}"
      data="{{ bizList.data }}"
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.biz_cd }}"
      label="사업부"
      labelPosition="top"
      labels="{{ item.biz_nm }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      style={{ ordered: [] }}
      value="{{ current_user.groups.map(i => i.name).includes('admin') ? ['A1','DS'] :
  current_user.groups.map(i => i.name).includes('아가방 부문') ? ['A1','DS'] : 
  current_user.groups.map(i => i.name).includes('에뜨와 부문') ? ['A4'] : 
  current_user.groups.map(i => i.name).includes('디즈니 부문') ? ['DS']:['A1']}}"
      values="{{ item.biz_cd }}"
      wrapTags={true}
    />
  </Body>
</SidebarFrame>
