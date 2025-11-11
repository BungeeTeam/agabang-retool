<App>
  <Include src="./functions.rsx" />
  <CustomAppTheme
    id="$appTheme"
    _migrated={true}
    automatic={[
      "#fde68a",
      "#eecff3",
      "#a7f3d0",
      "#bfdbfe",
      "#c7d2fe",
      "#fecaca",
      "#fcd6bb",
    ]}
    borderRadius="4px"
    canvas="#f6f6f6"
    danger="#dc2626"
    defaultFont={{ size: "12px" }}
    h1Font={{ size: "36px" }}
    h2Font={{ size: "28px" }}
    h3Font={{ size: "24px" }}
    h4Font={{ size: "18px" }}
    h5Font={{ size: "16px" }}
    h6Font={{ size: "14px" }}
    highlight="#fde68a"
    info="#3170f9"
    primary="#f15a23"
    secondary=""
    success="#059669"
    surfacePrimary="#ffffff"
    surfacePrimaryBorder=""
    surfaceSecondary="#ffffff"
    surfaceSecondaryBorder=""
    tertiary=""
    textDark="#0d0d0d"
    textLight="#ffffff"
    warning="#cd6f00"
  />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <Include src="./header.rsx" />
  <Include src="./src/drawerFrame1.rsx" />
  <Include src="./src/modalFrame4.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Container
      id="container_filter"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle8"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="e5d16" viewKey="View 1">
        <Select
          id="sel_season"
          data="{{ get_season.data }}"
          emptyMessage="No options"
          iconBefore="bold/nature-ecology-leaf-protect"
          label=""
          labelPosition="top"
          labels="{{item.year_sesn_nm_kor}} ({{item.year_season}})"
          overlayMaxHeight={375}
          placeholder="Select an option"
          showSelectionIndicator={true}
          textBefore="시즌"
          value="25SM"
          values="{{ item.year_season }}"
        >
          <Event
            event="change"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="get_items"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Select>
        <Multiselect
          id="sel_category"
          data="{{get_category.data}}"
          emptyMessage="No options"
          label=""
          labelPosition="top"
          labels="{{ item.category_name }}"
          overlayMaxHeight={375}
          placeholder="Select options"
          showSelectionIndicator={true}
          textBefore="복종"
          value="[3]"
          values="{{ item.id }}"
          wrapTags={true}
        >
          <Option id="9c6ee" value="Option 1" />
          <Option id="060ce" value="Option 2" />
          <Option id="4a1a6" value="Option 3" />
          <Event
            event="change"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="get_items"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Multiselect>
        <Button
          id="button1"
          iconBefore="bold/interface-alert-warning-triangle"
          style={{ ordered: [{ background: "canvas" }] }}
          text="카테고리 업데이트"
        >
          <Event
            event="click"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="update_category_looxloo"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_items"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Container>
    <ListViewBeta
      id="listView_top"
      data="{{ sel_category.selectedLabels }}"
      heightType="auto"
      itemWidth="200px"
      margin="0"
      numColumns={3}
      padding="0"
    >
      <Include src="./src/container_category.rsx" />
    </ListViewBeta>
  </Frame>
</App>
