<SidebarFrame
  id="sidebarFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  isHiddenOnMobile={true}
  padding="8px 12px"
  width="240px"
>
  <Body>
    <Text id="text1" value="#### 아소트 분석" verticalAlign="center" />
    <Spacer id="spacer4" />
    <NumberInput
      id="input_target_rate"
      currency="USD"
      inputValue={0}
      label="기준 판매율"
      labelPosition="top"
      placeholder="기준 판매율"
      showSeparators={true}
      showStepper={true}
      textAfter="%"
      value="40"
    />
    <Spacer id="spacer1" />
    <Select
      id="select1"
      data="{{var_season_code.value}}"
      emptyMessage="No options"
      label="시즌"
      labelPosition="top"
      labels="{{item.year_sesn_nm_kor}}"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value="{{self.data.filter(item => item.year_nm == moment().add(-1, 'year').format('YYYY'))[Math.ceil(Number(moment().format('M'))/3)].year_sesn_cd}}"
      values="{{item.year_sesn_cd}}"
    />
    <Spacer id="spacer2" />
    <TextInput
      id="input_search_keyword"
      label="검색"
      labelPosition="top"
      placeholder="검색어 입력"
    />
    <Spacer id="spacer3" />
    <SegmentedControl
      id="segmentedControl1"
      itemMode="static"
      label="조회 형태"
      labelPosition="top"
      paddingType="spacious"
      value="{{ self.values[0] }}"
    >
      <Option id="18620" label="요약" value="0" />
      <Option id="0531d" label="모든 데이터" value="1" />
      <Event
        event="change"
        method="setCurrentViewIndex"
        params={{ ordered: [{ viewIndex: "{{self.value}}" }] }}
        pluginId="tabbedContainer1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SegmentedControl>
    <Button
      id="button1"
      hidden="{{segmentedControl1.value == 0}}"
      text="데이터 다운로드"
    >
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="download_excel_data"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Body>
  <Footer>
    <Avatar
      id="avatar1"
      fallback="{{ current_user.fullName }}"
      imageSize={32}
      label="{{ current_user.fullName }}"
      labelCaption="{{ current_user.email }}"
      src="{{ current_user.profilePhotoUrl }}"
      style={{ ordered: [{ background: "automatic" }] }}
    />
  </Footer>
</SidebarFrame>
