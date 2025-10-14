<Container
  id="container11"
  footerPadding="4px 12px"
  headerPadding="0"
  margin="0"
  padding="12px"
  showBody={true}
  showBorder={false}
  showHeader={true}
  showHeaderBorder={false}
>
  <Header>
    <Tabs
      id="tabsPeriod4"
      alignment="justify"
      itemMode="static"
      value="{{ self.values[0] }}"
    >
      <Option id="0e707" label="기간 선택" value="periodic" />
      <Option id="45abf" label="월" value="monthly" />
      <Option id="4e8ec" label="분기" value="quarterly" />
    </Tabs>
    <Divider id="divider4" margin="0" />
    <Tabs
      id="tabsOnOff4"
      itemMode="static"
      margin="4px 12px"
      style={{
        ordered: [
          { fontSize: "12px" },
          { fontWeight: "500" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      value="{{ self.values[0] }}"
    >
      <Option id="d3d24" label="오프라인" value="오프라인" />
      <Option id="47702" label="온라인" value="온라인" />
      <Option id="215bc" label="온오프라인 합계" value="합계" />
    </Tabs>
    <Tabs
      id="tabs4"
      itemMode="static"
      margin="4px 10px"
      targetContainerId="container11"
      value="{{ self.values[0] }}"
    >
      <Option id="519b8" label="중분류별" value="it_gb" />
      <Option id="528ab" label="소분류별" value="item" />
      <Option id="7366f" label="서브브랜드별" value="sub_brand" />
    </Tabs>
    <DateRange
      id="dateRange5"
      dateFormat="yyyy-MM-dd"
      disabled=""
      endPlaceholder="End date"
      firstDayOfWeek={0}
      hidden=""
      iconBefore="bold/interface-calendar-remove-alternate"
      label=""
      labelPosition="top"
      startPlaceholder="Start date"
      textBefore="판매 기간"
      textBetween="-"
      value={{
        ordered: [
          { start: "{{ moment().subtract(7,'days').format('YYYY-MM-DD') }}" },
          { end: "{{ moment().subtract(1,'days').format('YYYY-MM-DD') }}" },
        ],
      }}
    />
  </Header>
  <View id="9bd21" viewKey="View 1">
    <ListViewBeta
      id="listView4"
      _primaryKeys=""
      data="{{ unitList.value[tabsPeriod4.value] }}"
      itemWidth="200px"
      margin="0"
      numColumns={3}
      padding="0"
    >
      <Container
        id="container13"
        footerPadding="4px 12px"
        headerPadding="0"
        padding="12px"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Text
            id="containerTitle8"
            value="###### {{ item }} {{ tabsPeriod4.value === 'monthly' ? '월' :
tabsPeriod4.value === 'quarterly' ? '분기' : '' }}"
            verticalAlign="center"
          />
          <Text
            id="text11"
            horizontalAlign="right"
            value="단위: 수량 - 개 / 금액 - 백만원"
            verticalAlign="center"
          />
        </Header>
        <View id="79525" viewKey="View 1" />
      </Container>
    </ListViewBeta>
  </View>
</Container>
