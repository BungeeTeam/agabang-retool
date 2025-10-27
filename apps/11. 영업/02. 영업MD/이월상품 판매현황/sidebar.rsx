<SidebarFrame
  id="sidebarFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden=""
  isHiddenOnMobile={true}
  padding="8px 6px"
  showHeader={true}
  width="{{ toggleButton1.value ? '50px' : 'large' }}"
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
          value="#### 이월상품 매출현황"
          verticalAlign="center"
        />
      </View>
    </Container>
  </Header>
  <Body>
    <Spacer id="spacer5" />
    <Select
      id="bizMultiSelect2"
      colorByIndex="{{ theme.tokens.primaryOpacity20 }}"
      data={
        '{{\n(() => {\n  const seen = new Set();\n  const result = shopInfoQuery\n    .data\n    .filter(item => {\n      const key = `${item.biz_cd}-${item.biz_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n    //  .sort((a, b) => a.biz_cd - b.biz_cd)\n\n    //  .sort((a, b) => a.biz_nm.localeCompare(b.biz_nm, "ko"))\n\n  //  result.unshift({biz_cd: "-1", biz_nm: "전체"})\n\n  return result\n})()\n}}'
      }
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.biz_cd }}"
      hidden="{{ toggleButton1.value}}"
      label="사업부"
      labelPosition="top"
      labels="{{ item.biz_nm }}"
      overlayMaxHeight={375}
      placeholder="Select options"
      showSelectionIndicator={true}
      value="{{ current_user.groups.map(i => i.name).includes('admin') ? 'A1' :
  current_user.groups.map(i => i.name).includes('아가방 부문') ? 'A1' : 
  current_user.groups.map(i => i.name).includes('에뜨와 부문') ? 'A4' : 
  current_user.groups.map(i => i.name).includes('디즈니 부문') ? 'DS':'A1'}}"
      values="{{ item.biz_cd }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get2YearsResult"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="run"
        params={{
          ordered: [
            {
              src: "get2YearsResult.trigger();\ntable20.refresh();\ntable2.refresh();",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Spacer id="spacer3" />
    <Select
      id="brandMultiSelect2"
      data={
        '{{\n(() => {\n  const seen = new Set();\n  const result = shopInfoQuery.data\n    .filter(item => item.br_cd !== null && bizMultiSelect2.value.includes(item.biz_cd))\n    .filter(item => {\n      const key = `${item.br_cd}-${item.br_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n  .sort((a, b) => a.br_cd - b.br_cd)\n    //  .sort((a, b) => a.br_nm.localeCompare(b.br_nm, "ko"))\n  return result\n})()\n}}'
      }
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.br_cd }}"
      hidden="{{ toggleButton1.value }}"
      label="브랜드"
      labelPosition="top"
      labels="{{ item.br_nm}}"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value="{{ self.data[0].br_cd }}"
      values="{{ item.br_cd }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get2YearsResult"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="run"
        params={{
          ordered: [
            {
              src: "get2YearsResult.trigger();\ntable20.refresh();\ntable2.refresh();",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Spacer id="spacer2" />
    <Select
      id="yearSelect2"
      captionByIndex="{{ item.last_season_end_dt }}"
      colorByIndex=""
      data="{{ getSeasonEndDate.data }}"
      emptyMessage="No options"
      hidden="{{ toggleButton1.value }}"
      label="기준년도"
      labelPosition="top"
      labels="{{ item.year_nm }}년 {{ item.season_nm }}({{ item.season_cd }}) 이월 {{ item.year_codes }}"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      tooltipText="지난 30일간 판매량이 가장 많은 시즌이 기본으로 선택됩니다."
      value="{{ getDefaultSeason.data[0] }}"
      values="{{ item.year_season_cd }}"
    >
      <Event
        event="change"
        method="run"
        params={{
          ordered: [
            {
              src: "get2YearsResult.trigger();\ntable20.refresh();\ntable2.refresh();",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Spacer id="spacer4" />
    <Date
      id="endDate"
      dateFormat="yyyy-MM-dd"
      datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
      hidden="{{ toggleButton1.value }}"
      iconBefore="bold/interface-calendar"
      label="판매마감일"
      labelPosition="top"
      value="{{ moment().subtract(1,'days').format('YYYY-MM-DD') }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get2YearsResult"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="run"
        params={{
          ordered: [
            {
              src: "get2YearsResult.trigger();\ntable20.refresh();\ntable2.refresh();",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Date>
    <Spacer id="spacer6" />
    <Switch
      id="switch1"
      hidden="{{ toggleButton1.value }}"
      label="기간 누적 출고/반품 보기"
      labelAlign="right"
      labelPosition="left"
    />
    <ToggleLink
      id="toggleLink1"
      hidden="{{ toggleButton1.value}}"
      margin="0px 4px"
      text="{{ self.value ? '컬럼선택 열기' : '컬럼선택 닫기' }}"
      value="true"
    />
    <CheckboxGroup
      id="checkboxTreeNew1"
      groupLayout="tree"
      hidden="{{ toggleLink1.value || toggleButton1.value }}"
      itemMode="static"
      label=""
      labelPosition="top"
      margin="0px 8px"
      value="{{ self.values }}"
    >
      <Option id="7f051" key="d3444" label="출고" value="출고" />
      <Option
        id="cc32a"
        key="d9098"
        label="순출고금액(TAG)"
        parentKey="d3444"
        value="1"
      />
      <Option
        id="bed3a"
        label="순출고금액(실판가)"
        parentKey="d3444"
        value="2"
      />
      <Option
        id="19bc6"
        key="32da5"
        label="순출고수량"
        parentKey="d3444"
        value="3"
      />
      <Option id="dfa97" key="01ef6" label="재고" value="재고" />
      <Option id="cdfca" label="재고금액(TAG)" parentKey="01ef6" value="4" />
      <Option id="b55b6" label="재고금액(실판가)" parentKey="01ef6" value="5" />
      <Option id="3e2a1" label="재고수량" parentKey="01ef6" value="6" />
      <Option id="a91c9" key="a445c" label="판매" value="판매" />
      <Option
        id="868cf"
        disabled={false}
        hidden={false}
        label="판매금액(TAG)"
        parentKey="a445c"
        value="7"
      />
      <Option
        id="59d19"
        disabled={false}
        hidden={false}
        label="실판매금액"
        parentKey="a445c"
        value="8"
      />
      <Option
        id="5cec4"
        disabled={false}
        hidden={false}
        label="판매수량"
        parentKey="a445c"
        value="9"
      />
      <Option
        id="02ed3"
        disabled={false}
        hidden={false}
        label="판매율"
        parentKey="a445c"
        value="10"
      />
      <Option
        id="91a76"
        disabled={false}
        hidden={false}
        label="수량판매율"
        parentKey="a445c"
        value="11"
      />
      <Option
        id="bb649"
        disabled={false}
        hidden={false}
        key="960aa"
        label="할인율"
        value="12"
      />
      <Option
        id="ccb0e"
        disabled={false}
        hidden={false}
        key="ec9a1"
        label="할인율(판매)"
        parentKey="960aa"
        value="13"
      />
      <Option
        id="4db1d"
        disabled={false}
        hidden={false}
        label="할인율(출고)"
        parentKey="960aa"
        value="14"
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
