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
          id="text2"
          hidden="{{ toggleButton1.value }}"
          value="#### 판매유형별 매출 현황"
          verticalAlign="center"
        />
      </View>
    </Container>
  </Header>
  <Body>
    <Multiselect
      id="bizSelect"
      colorByIndex="{{ theme.tokens.primaryOpacity20 }}"
      data={
        '{{\n(() => {\n  const seen = new Set();\n  const result = shopInfoQuery\n    .data\n    .filter(item => {\n      const key = `${item.biz_cd}-${item.biz_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n    //  .sort((a, b) => a.biz_cd - b.biz_cd)\n\n    //  .sort((a, b) => a.biz_nm.localeCompare(b.biz_nm, "ko"))\n\n  //  result.unshift({biz_cd: "-1", biz_nm: "전체"})\n\n  return result\n})()\n}}'
      }
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
    <Spacer id="spacer1" />
    <Multiselect
      id="brandMultiSelect"
      captionByIndex=""
      colorByIndex=""
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
    <ToggleLink
      id="toggleLink1"
      hidden="{{ toggleButton1.value }}"
      text="{{ self.value ? '컬럼선택 열기' : '컬럼선택 닫기' }}"
      value="true"
    />
    <CheckboxGroup
      id="checkboxTreeNew1"
      groupLayout="tree"
      hidden="{{ toggleLink1.value||toggleButton1.value}}"
      itemMode="static"
      label=""
      labelPosition="top"
      value="{{ self.values.slice(0,11) }}"
    >
      <Option
        id="d129f"
        disabled={false}
        hidden={false}
        key="bbb313a3-baf4-4147-ab5c-fba3cc8dc620"
        value="매출"
      />
      <Option
        id="67edb"
        disabled={false}
        hidden={false}
        parentKey="bbb313a3-baf4-4147-ab5c-fba3cc8dc620"
        value="목표매출"
      />
      <Option
        id="e109d"
        disabled={false}
        hidden={false}
        parentKey="bbb313a3-baf4-4147-ab5c-fba3cc8dc620"
        value="{{ moment(dateRange.value?.start).format('YYYY') }}년 매출"
      />
      <Option
        id="86261"
        disabled={false}
        hidden={false}
        label="{{ moment(dateRange.value?.start).format('YYYY') }}년 매출비중"
        parentKey="bbb313a3-baf4-4147-ab5c-fba3cc8dc620"
        value="{{ moment(dateRange.value?.start).format('YYYY') }}년 매출비중"
      />
      <Option
        id="40336"
        disabled={false}
        hidden={false}
        parentKey="bbb313a3-baf4-4147-ab5c-fba3cc8dc620"
        value="{{ moment(dateRange.value?.start).format('YYYY') }}년 할인율"
      />
      <Option
        id="40978"
        disabled={false}
        hidden={false}
        parentKey="bbb313a3-baf4-4147-ab5c-fba3cc8dc620"
        value="{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 매출"
      />
      <Option
        id="a4e01"
        disabled={false}
        hidden={false}
        label="{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 매출비중"
        parentKey="bbb313a3-baf4-4147-ab5c-fba3cc8dc620"
        value="{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 매출비중"
      />
      <Option
        id="7b5df"
        disabled={false}
        hidden={false}
        parentKey="bbb313a3-baf4-4147-ab5c-fba3cc8dc620"
        value="{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 할인율"
      />
      <Option
        id="b0b08"
        disabled={false}
        hidden={false}
        parentKey="bbb313a3-baf4-4147-ab5c-fba3cc8dc620"
        value="매출증감"
      />
      <Option
        id="e164e"
        disabled={false}
        hidden={false}
        parentKey="bbb313a3-baf4-4147-ab5c-fba3cc8dc620"
        value="진행율"
      />
      <Option
        id="a9090"
        disabled={false}
        hidden={false}
        parentKey="bbb313a3-baf4-4147-ab5c-fba3cc8dc620"
        value="신장율"
      />
      <Option
        id="4abc0"
        disabled={false}
        hidden={false}
        key="a3eea"
        value="원가"
      />
      <Option
        id="768a4"
        disabled={false}
        hidden={false}
        parentKey="a3eea"
        value="{{ moment().format('YYYY') }}년 원가"
      />
      <Option
        id="19f27"
        disabled={false}
        hidden={false}
        parentKey="a3eea"
        value="{{ moment().format('YYYY') }}년 원가율"
      />
      <Option
        id="65723"
        disabled={false}
        hidden={false}
        parentKey="a3eea"
        value="{{ moment().subtract(1,'years').format('YYYY') }}년 원가"
      />
      <Option
        id="3531e"
        disabled={false}
        hidden={false}
        parentKey="a3eea"
        value="{{ moment().subtract(1,'years').format('YYYY') }}년 원가율"
      />
      <Option
        id="00efa"
        disabled={false}
        hidden={false}
        parentKey="a3eea"
        value="원가증감"
      />
      <Option
        id="41aab"
        disabled={false}
        hidden={false}
        parentKey="a3eea"
        value="원가율증감"
      />
    </CheckboxGroup>
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
