<Container
  id="container_items"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  hidden="{{ get_item_list.data[item] == null }}"
  padding="12px"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Text
      id="containerTitle22"
      heightType="fixed"
      value="###### {{ item }}"
      verticalAlign="center"
    />
    <Text
      id="containerTitle26"
      heightType="fixed"
      horizontalAlign="right"
      value="총 SKU : {{get_item_list.data[item] == null ? 0 : get_item_list.data[item].length}}"
      verticalAlign="center"
    />
  </Header>
  <View id="1ed63" viewKey="View 1">
    <Include src="./container21.rsx" />
    <Include src="./container17.rsx" />
    <Spacer id="spacer12" />
  </View>
</Container>
