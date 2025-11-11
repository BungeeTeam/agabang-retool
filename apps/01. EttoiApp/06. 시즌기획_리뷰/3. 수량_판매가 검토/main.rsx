<App>
  <Include src="./functions.rsx" />
  <UrlFragments id="$urlFragments" value={{ ordered: [{ "": "" }] }} />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <DocumentTitle id="$customDocumentTitle" value="수량/판매가 검토 | ET" />
  <Include src="./header.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Include src="./src/container_filter.rsx" />
    <Container
      id="container_year_label"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle5"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="28726" viewKey="View 1">
        <Text
          id="text3"
          heightType="fixed"
          horizontalAlign="center"
          margin="0"
          style={{ ordered: [{ background: "highlight" }] }}
          value="**{{ var_season_list.value[0] }}**"
          verticalAlign="center"
        />
        <Text
          id="text4"
          horizontalAlign="center"
          value="**{{ var_season_list.value[1] }}**"
          verticalAlign="center"
        />
        <Text
          id="text5"
          horizontalAlign="center"
          value="**{{ var_season_list.value[2] }}**"
          verticalAlign="center"
        />
      </View>
    </Container>
    <ListViewBeta
      id="listView1"
      _primaryKeys="{{ item }}"
      data="{{ var_price_list.value }}"
      itemWidth="200px"
      margin="0"
      numColumns={3}
      padding="0"
    >
      <Container
        id="container_price"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        margin="0"
        padding="0"
        showBody={true}
        style={{ ordered: [{ background: "canvas" }] }}
      >
        <Header>
          <Text
            id="containerTitle6"
            value="#### {{ item }}"
            verticalAlign="center"
          />
        </Header>
        <View id="bff08" viewKey="View 1">
          <Text
            id="text6"
            horizontalAlign="center"
            value="##### {{ item.toLocaleString() }}원"
            verticalAlign="center"
          />
          <Include src="./src/container_price_product.rsx" />
        </View>
      </Container>
    </ListViewBeta>
  </Frame>
</App>
