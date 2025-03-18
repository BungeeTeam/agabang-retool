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
    <Text
      id="text1"
      value="#### 영업부 목표매출 달성현황"
      verticalAlign="center"
    />
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
      value={'["A1"]'}
      values="{{ item.biz_cd }}"
      wrapTags={true}
    />
    <Spacer id="spacer1" />
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
