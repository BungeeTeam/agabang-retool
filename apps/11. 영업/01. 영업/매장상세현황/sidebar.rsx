<SidebarFrame
  id="sidebarFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden=""
  isHiddenOnMobile={true}
  padding="8px 12px"
  showHeader={true}
  width="large"
>
  <Header>
    <Text id="text1" value="#### 매장 상세 현황" verticalAlign="center" />
  </Header>
  <Body>
    <Multiselect
      id="bizMultiSelect"
      colorByIndex="{{ theme.tokens.primaryOpacity20 }}"
      data={
        '{{\n(() => {\n  const seen = new Set();\n  const result = shopInfoQuery\n    .data\n    .filter(item => {\n      const key = `${item.biz_cd}-${item.biz_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n    //  .sort((a, b) => a.biz_cd - b.biz_cd)\n\n    //  .sort((a, b) => a.biz_nm.localeCompare(b.biz_nm, "ko"))\n\n  //  result.unshift({biz_cd: "-1", biz_nm: "전체"})\n\n  return result\n})()\n}}'
      }
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
      value=""
      values="{{ item.biz_cd }}"
      wrapTags={true}
    />
    <Spacer id="spacer5" />
    <Multiselect
      id="brandMultiSelect"
      captionByIndex=""
      colorByIndex=""
      data={
        '{{\n(() => {\n  const seen = new Set();\n  const result = shopInfoQuery.data\n    .filter(item => item.br_cd !== null && bizMultiSelect.value.includes(item.biz_cd))\n    .filter(item => {\n      const key = `${item.br_cd}-${item.br_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n  .sort((a, b) => a.br_cd - b.br_cd)\n    //  .sort((a, b) => a.br_nm.localeCompare(b.br_nm, "ko"))\n  return result\n})()\n}}'
      }
      disabledByIndex=""
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.br_cd }}"
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
    <Spacer id="spacer1" />
    <Select
      id="tpSelect"
      data={
        '{{\n(() => {\n  const seen = new Set();\n  let result = shopInfoQuery\n    .data\n    .filter(item => item.tp_nm != \'\')\n    .filter(item => {\n      const key = `${item.tp_cd}-${item.tp_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n  .map(item => ({ tp_cd: item.tp_cd, tp_nm: item.tp_nm }))\n  .sort((a, b) => a.tp_nm.localeCompare(b.tp_nm, "ko"))\n\n  result.unshift({tp_cd: "-1", tp_nm: "전체"})\n\n  return result\n})()\n}}'
      }
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.tp_cd }}"
      label=""
      labelPosition="top"
      labels="{{ item.tp_nm }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="유통채널"
      value=""
      values="{{ item.tp_cd }}"
    />
    <Spacer id="spacer2" />
    <Select
      id="teamSelect"
      data={
        '{{\n(() => {\n  const seen = new Set();\n  let result = shopInfoQuery\n    .data\n    .filter(item => item.team_cd != \'\' && bizMultiSelect.value.includes(item.biz_cd))\n    .filter(item => {\n      const key = `${item.team_cd}-${item.team_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n  .map(item => ({ team_cd: item.team_cd, team_nm: item.team_nm }))\n  .sort((a, b) => a.team_nm.localeCompare(b.team_nm, "ko"))\n\n  result.unshift({team_cd: "-1", team_nm: "전체"})\n\n  return result\n})()\n}}'
      }
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.tp_cd }}"
      label=""
      labelPosition="top"
      labels="{{ item.team_nm }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="담당조직"
      value=""
      values="{{ item.team_cd }}"
    />
    <Spacer id="spacer3" />
    <Select
      id="userSelect"
      data={
        '{{\n(() => {\n  const seen = new Set();\n  let result = shopInfoQuery\n    .data\n    .filter(item => item.user_cd != \'\')\n    .filter(item => bizMultiSelect.value.includes(item.biz_cd))\n    .filter(item => {\n      const key = `${item.user_cd}-${item.user_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n  .sort((a, b) => a.user_nm.localeCompare(b.user_nm, "ko"))\n\n  result.unshift({user_cd: "-1", user_nm: "전체"})\n\n  return result\n})()\n}}'
      }
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.user_nm }}"
      label=""
      labelPosition="top"
      labels="{{ item.user_nm }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="담당자명"
      value=""
      values="{{ item.user_cd }}"
    />
    <Spacer id="spacer4" />
    <Select
      id="areaSelect"
      data={
        '{{\n(() => {\n  const seen = new Set();\n  let result = shopInfoQuery\n    .data\n    .filter(item => item.area_cd != \'\')\n    .filter(item => {\n      const key = `${item.area_cd}-${item.area_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n  .sort((a, b) => a.area_nm.localeCompare(b.area_nm, "ko"))\n\n  result.unshift({area_cd: "-1", area_nm: "전체"})\n\n  return result\n})()\n}}'
      }
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.area_cd }}"
      label=""
      labelPosition="top"
      labels="{{ item.area_nm }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="매장지역"
      value=""
      values="{{ item.area_cd }}"
    />
  </Body>
  <Footer>
    <Avatar
      id="avatar1"
      fallback="{{ current_user.fullName }}"
      imageSize={32}
      label="{{ current_user.fullName }}"
      labelCaption="{{ current_user.email }}"
      margin="4px 4px"
      src="{{ current_user.profilePhotoUrl }}"
      style={{ ordered: [{ background: "automatic" }] }}
    />
  </Footer>
</SidebarFrame>
