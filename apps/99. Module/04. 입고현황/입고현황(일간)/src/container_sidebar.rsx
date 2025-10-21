<Container
  id="container_sidebar"
  _gap="0px"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  margin="0"
  padding="0"
  showBody={true}
>
  <Header>
    <Text
      id="containerTitle1"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="a237a" viewKey="View 1">
    <Spacer id="spacer1" />
    <Text id="text1" value="#### 일간 입고 현황" verticalAlign="center" />
    <Spacer id="spacer2" />
    <MultiselectListbox
      id="sel_days"
      data="{{ get_day_in_list.data }}"
      emptyMessage="No options"
      label="📅 입고일 ( 최근 1개월 )"
      labelPosition="top"
      labels="{{ item.in_dt }} ({{ new Set((item.sty_cd)).size }}종)"
      margin="4px 4px"
      showSelectionIndicator={true}
      value="{{ [self.values[0]] }}"
      values="{{ item.in_dt }}"
    />
    <Spacer id="spacer3" />
    <TextInput
      id="search_box"
      label="🔎 검색"
      labelPosition="top"
      placeholder="검색어"
    />
  </View>
</Container>
