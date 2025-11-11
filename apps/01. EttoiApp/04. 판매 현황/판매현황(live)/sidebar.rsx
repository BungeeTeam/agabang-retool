<SidebarFrame
  id="sidebarFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  isHiddenOnMobile={true}
  padding="8px 12px"
  width="{{ toggleButton1.value ?'50px' : '240px' }}"
>
  <Body>
    <Container
      id="stack1"
      _align="center"
      _flexWrap={true}
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="47b83" viewKey="View 1">
        <Text
          id="containerTitle2"
          hidden="{{ toggleButton1.value }}"
          value="#### 판매현황"
          verticalAlign="center"
        />
        <ToggleButton
          id="toggleButton1"
          horizontalAlign="stretch"
          iconForFalse="bold/interface-arrows-button-left-double"
          iconForTrue="bold/interface-arrows-button-right-duoble"
          iconPosition="right"
          style={{ ordered: [{ border: "rgba(245, 245, 245, 0)" }] }}
          styleVariant="outline"
          text="{{ self.value ? '' : '' }}"
        />
      </View>
    </Container>
    <Spacer id="spacer13" />
    <Select
      id="select_item_type"
      captionByIndex=""
      colorByIndex=""
      data=""
      disabledByIndex=""
      emptyMessage="No options"
      fallbackTextByIndex=""
      hidden="{{ toggleButton1.value }}"
      hiddenByIndex=""
      iconByIndex=""
      imageByIndex=""
      itemMode="static"
      label="🏷️ 구분"
      labelPosition="top"
      labels=""
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      tooltipByIndex=""
      value="season"
      values=""
    >
      <Option
        id="a7f07"
        disabled={false}
        hidden={false}
        label="시즌"
        value="season"
      />
      <Option
        id="d55b9"
        disabled="false"
        hidden={false}
        label="사계절
"
        value="season_less"
      />
      <Option
        id="19091"
        disabled="false"
        hidden={false}
        label="출산용품"
        value="yongpum"
      />
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list_new"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Spacer id="spacer16" />
    <Multiselect
      id="select_brand"
      captionByIndex=""
      colorByIndex=""
      data="{{ code_brand.data }}"
      disabledByIndex=""
      emptyMessage="No options"
      fallbackTextByIndex=""
      hidden="{{ select_item_type.value != 'yongpum' ||  toggleButton1.value}}"
      hiddenByIndex=""
      iconByIndex=""
      imageByIndex=""
      label="🛍 브랜드"
      labelPosition="top"
      labels="{{ item.sub_br_nm }}"
      overlayMaxHeight={375}
      placeholder="Select options"
      showSelectionIndicator={true}
      tooltipByIndex=""
      value="['에뜨와']"
      values="{{ item.sub_br_nm }}"
      wrapTags={true}
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list_new"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Multiselect>
    <Spacer
      id="spacer17"
      hidden="{{ select_item_type.value === 'yongpum' ? false : true }}"
    />
    <Select
      id="select_season"
      data="{{ code_season.data }}"
      emptyMessage="No options"
      hidden="{{ toggleButton1.value }}"
      iconByIndex="bold/image-picture-gallery"
      label="🍁 시즌"
      labelPosition="top"
      labels="{{ select_item_type.value === 'yongpum' ? item.year_nm
  : select_item_type.value === 'season_less' ? item.year_nm 
  : item.year_sesn_nm_eng}}"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value="{{ select_item_type.value === 'yongpum' ? self.data[1].year_sesn_nm_eng:
  select_item_type.value === 'season_less' ? self.data[1].year_sesn_nm_eng:
  select_item_type.value === 'season' ?  get_latest_season.data[0]:
   get_latest_season.data[0] }}"
      values="{{ item.year_sesn_nm_eng }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list_new"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_last_seasons"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="setValue"
        params={{ ordered: [] }}
        pluginId="search_text"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Spacer id="spacer14" />
    <TextInput
      id="search_text"
      formDataKey="{{ self.id }} {{sel_category.value}}"
      hidden="{{ toggleButton1.value }}"
      label="🔍 검색"
      labelPosition="top"
      labelWidth="10"
      placeholder="검색어를 입력하세요."
    >
      <Event
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list_new"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </TextInput>
    <Spacer id="spacer15" />
    <SegmentedControl
      id="segmentedControl_date_mode"
      hidden="{{ toggleButton1.value }}"
      itemMode="static"
      label="🗓️ 조회 기간"
      labelPosition="top"
      paddingType="spacious"
      value="{{ self.values[0] }}"
    >
      <Option id="74c95" label="누적" value="cumulative" />
      <Option id="36c63" label="기간설정" value="period" />
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list_new"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SegmentedControl>
    <Container
      id="container_daterange"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      hidden={
        '{{segmentedControl_date_mode.value != "period" || toggleButton1.value}}'
      }
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle7"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="1e83c" viewKey="View 1">
        <Date
          id="sel_start_date"
          dateFormat="yyyy-MM-dd"
          datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
          iconBefore="bold/interface-calendar"
          label=""
          labelPosition="top"
          textBefore="시작일"
          value="{{ new Date(new Date().setDate(new Date().getDate() - 210)) }}"
        />
        <Date
          id="sel_end_date"
          dateFormat="yyyy-MM-dd"
          datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
          iconBefore="bold/interface-calendar"
          label=""
          labelPosition="top"
          textBefore="종료일"
          value="{{ new Date(new Date().setDate(new Date().getDate() - 1)) }}"
        />
      </View>
    </Container>
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
