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
        <Text id="text3" value="#### 급상승 매장" verticalAlign="center" />
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
    <Date
      id="base_day"
      dateFormat="yyyy-MM-dd"
      datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
      iconBefore="bold/interface-calendar"
      label="기준일자"
      labelPosition="top"
      value="{{ new Date(new Date().setDate(new Date().getDate() - 1)).toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\./g, '-').replace(/ /g, '') }}"
    >
      <Event
        event="blur"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="rise_top"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Date>
    <Spacer id="spacer4" />
    <Slider
      id="min_sales_qty"
      label="최소 일간 판매량"
      labelPosition="top"
      max="30"
      min="5"
      step={1}
      value="10"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="rise_top"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Slider>
    <Slider
      id="min_week_sales_qty"
      label="최소 주간 판매량(평균)"
      labelPosition="top"
      max="50"
      min="10"
      step={1}
      value="20"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="rise_top"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Slider>
    <Button
      id="button2"
      hidden="true"
      iconBefore="bold/mail-send-email"
      text="Teams 전송"
    >
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="teams_send"
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
