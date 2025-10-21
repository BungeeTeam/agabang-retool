<SidebarFrame
  id="sidebarFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  isHiddenOnMobile={true}
  padding="8px 12px"
  showHeader={true}
  showHeaderBorder={false}
  width="240px"
>
  <Header>
    <Container
      id="container1"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle1"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="3890c" viewKey="View 1">
        <Text
          id="text3"
          value="#### 판매 Top {{input_limit.value}}"
          verticalAlign="center"
        />
        <Button
          id="closeButton1"
          ariaLabel="Close"
          horizontalAlign="right"
          iconBefore="bold/interface-arrows-button-left-double"
          style={{ ordered: [{ border: "transparent" }] }}
          styleVariant="outline"
        >
          <Event
            event="click"
            method="setHidden"
            params={{ ordered: [] }}
            pluginId="sidebarFrame1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </Header>
  <Body>
    <DateRange
      id="input_date_range"
      dateFormat="yy/MM/dd"
      endPlaceholder="End date"
      iconBefore="bold/interface-calendar-remove"
      label="기간"
      labelPosition="top"
      startPlaceholder="Start date"
      textBetween="~"
      value={{
        ordered: [
          { start: "{{moment().add(-1, 'month')}}" },
          { end: "{{moment()}}" },
        ],
      }}
    />
    <Spacer id="spacer2" />
    <Select
      id="input_category"
      data="{{ get_category_list.data }}"
      emptyMessage="No options"
      label="카테고리"
      labelPosition="top"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value="전체"
      values="{{item}}"
    />
    <Spacer id="spacer3" />
    <Multiselect
      id="input_season"
      colorByIndex=""
      data="{{ get_season_code_list.data }}"
      emptyMessage="No options"
      label="출시 시즌"
      labelPosition="top"
      labels={'{{item.year_sesn_nm_eng.replace("NO", " 무시즌")}}'}
      overlayMaxHeight={375}
      placeholder="Select options"
      showSelectionIndicator={true}
      value="{{self.data.filter(item => item.year_nm == moment().year() && item.sesn_cd !== '0').reduce((acc, cur) => {acc.push(cur.year_sesn_cd); return acc}, [])}}"
      values="{{item.year_sesn_cd}}"
      wrapTags={true}
    />
    <Spacer id="spacer4" />
    <Select
      id="input_limit"
      emptyMessage="No options"
      itemMode="static"
      label="표시 개수"
      labelPosition="top"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value="50"
    >
      <Option id="9bfa4" value="10" />
      <Option id="9f487" value="20" />
      <Option id="c37a5" value="50" />
      <Option id="3d299" disabled={false} hidden={false} value="100" />
    </Select>
    <SegmentedControl
      id="input_sum_criteria"
      hidden="true"
      itemMode="static"
      label="집계 기준"
      labelPosition="top"
      paddingType="spacious"
      value="{{ self.values[0] }}"
    >
      <Option id="1f5e5" label="수량" value="qty" />
      <Option id="b937d" label="금액" value="amt" />
    </SegmentedControl>
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
