<SidebarFrame
  id="sidebarFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  isHiddenOnMobile={true}
  padding="8px 12px"
  width="{{ toggleButton1.value ? '50px' :'large'  }}"
>
  <Container
    id="stack2"
    _align="center"
    _gap="0px"
    _justify="space-between"
    _type="stack"
    footerPadding="4px 12px"
    headerPadding="4px 12px"
    hidden=""
    margin="0"
    padding="0"
    showBody={true}
    showBorder={false}
  >
    <View id="e152e" viewKey="View 1">
      <Text
        id="text49"
        hidden="{{ toggleButton1.value }}"
        value="#### 채널별 매출현황"
        verticalAlign="center"
      />
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
    </View>
  </Container>
  <Spacer id="spacer4" />
  <Select
    id="bizSelect"
    colorByIndex="{{ theme.tokens.primaryOpacity20 }}"
    data={
      '{{\n(() => {\n  const seen = new Set();\n  const result = shopInfoQuery\n    .data\n    .filter(item => {\n      const key = `${item.biz_cd}-${item.biz_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n    //  .sort((a, b) => a.biz_cd - b.biz_cd)\n\n    //  .sort((a, b) => a.biz_nm.localeCompare(b.biz_nm, "ko"))\n\n  //  result.unshift({biz_cd: "-1", biz_nm: "전체"})\n\n  return result\n})()\n}}'
    }
    emptyMessage="No options"
    fallbackTextByIndex="{{ item.biz_cd }}"
    hidden="{{ toggleButton1.value }}"
    label=""
    labelPosition="top"
    labels="{{ item.biz_nm }}"
    margin="0"
    overlayMaxHeight={375}
    placeholder="Select an option"
    showSelectionIndicator={true}
    style={{ ordered: [] }}
    textBefore="사업부"
    value="{{ current_user.groups.map(i => i.name).includes('admin') ? 'A1' :
  current_user.groups.map(i => i.name).includes('아가방 부문') ? 'A1' : 
  current_user.groups.map(i => i.name).includes('에뜨와 부문') ? 'A4' : 
  current_user.groups.map(i => i.name).includes('디즈니 부문') ? 'DS':'A1'}}"
    values="{{ item.biz_cd }}"
  />
  <Spacer id="spacer1" />
  <Select
    id="brandSelect"
    captionByIndex=""
    colorByIndex="{{ theme.tokens.primaryOpacity20 }}"
    data={
      '{{\n(() => {\n  const seen = new Set();\n  const result = shopInfoQuery.data\n    .filter(item => item.br_cd !== null && bizSelect.value.includes(item.biz_cd))\n    .filter(item => {\n      const key = `${item.br_cd}-${item.br_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n  .sort((a, b) => a.br_cd - b.br_cd)\n    //  .sort((a, b) => a.br_nm.localeCompare(b.br_nm, "ko"))\n  return result\n})()\n}}'
    }
    disabledByIndex=""
    emptyMessage="No options"
    fallbackTextByIndex="{{ item.br_cd }}"
    hidden="{{ toggleButton1.value }}"
    hiddenByIndex=""
    iconByIndex=""
    imageByIndex=""
    label=""
    labelPosition="top"
    labels="{{ item.br_nm }}"
    margin="0"
    overlayMaxHeight={375}
    placeholder="Select an option"
    showSelectionIndicator={true}
    textBefore="브랜드"
    tooltipByIndex=""
    value="{{ self.data[0].br_cd }}"
    values="{{ item.br_cd }}"
  />
  <Spacer id="spacer2" />
  <Select
    id="seasonSelect"
    captionByIndex=""
    colorByIndex="{{ theme.tokens.primaryOpacity20 }}"
    data="{{ getSeasonEndDate.data }}"
    disabledByIndex=""
    emptyMessage="No options"
    fallbackTextByIndex="{{ String.fromCharCode(item.year_cd_ly.toUpperCase().charCodeAt(0)+1) +  item.season_cd }}"
    hidden="{{ toggleButton1.value }}"
    hiddenByIndex=""
    iconByIndex=""
    imageByIndex=""
    label=""
    labelPosition="top"
    labels="{{ item.year_season_kor }}"
    margin="0"
    overlayMaxHeight={375}
    placeholder="Select an option"
    showSelectionIndicator={true}
    textBefore=" 시즌"
    tooltipByIndex=""
    value="'25년 겨울'"
    values="{{ item.year_season_kor }}"
  />
  <SwitchGroup
    id="switchGroup1"
    itemMode="static"
    label=""
    labelPosition="top"
    minCount="1"
    value="{{ [self.values[0]] }}"
  >
    <Option id="e8bc3" label="홀수 시즌코드" value="0" />
    <Option id="995e5" label="짝수 시즌코드" value="1" />
  </SwitchGroup>
  <Spacer id="spacer3" />
  <Select
    id="itCodeSelect"
    captionByIndex=""
    colorByIndex="{{ theme.tokens.primaryOpacity20 }}"
    data="{{ itCodeList.value[bizSelect.selectedItem.biz_cd] }}"
    disabledByIndex=""
    emptyMessage="No options"
    fallbackTextByIndex="{{ item.it_code }}"
    hidden="{{ toggleButton1.value }}"
    hiddenByIndex=""
    iconByIndex=""
    imageByIndex=""
    label=""
    labelPosition="top"
    labels="{{ item.label }}"
    margin="0"
    overlayMaxHeight={375}
    placeholder="Select an option"
    showSelectionIndicator={true}
    textBefore="복종 대분류"
    tooltipByIndex=""
    value="'-1'"
    values="{{ item.it_code }}"
  />
</SidebarFrame>
