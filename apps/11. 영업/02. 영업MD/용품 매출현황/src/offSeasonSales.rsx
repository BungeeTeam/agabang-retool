<Screen
  id="offSeasonSales"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title={null}
  urlSlug=""
>
  <JavascriptQuery
    id="offSeasonSetValue"
    notificationDuration={4.5}
    query={include("../lib/offSeasonSetValue.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
  <Frame
    id="$main5"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="0"
    sticky={null}
    type="main"
  >
    <Container
      id="container8"
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
          id="tabsPeriod3"
          alignment="justify"
          itemMode="static"
          value="{{ self.values[0] }}"
        >
          <Option id="0e707" label="기간 선택" value="periodic" />
          <Option id="45abf" label="월" value="monthly" />
          <Option id="4e8ec" label="분기" value="quarterly" />
        </Tabs>
        <Divider id="divider3" margin="0" />
        <Container
          id="container9"
          _align="center"
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
          <Header>
            <Text
              id="containerTitle5"
              value="#### Container title"
              verticalAlign="center"
            />
          </Header>
          <View id="9bd21" viewKey="View 1">
            <DateRange
              id="dateRange4"
              dateFormat="yyyy-MM-dd"
              disabled=""
              endPlaceholder="End date"
              firstDayOfWeek={0}
              hidden=""
              iconBefore="bold/interface-calendar-remove-alternate"
              label=""
              labelPosition="top"
              startPlaceholder="Start date"
              textBefore="조회기간"
              textBetween="-"
              value={{
                ordered: [
                  {
                    start:
                      "{{ moment().subtract(7,'days').format('YYYY-MM-DD') }}",
                  },
                  {
                    end: "{{ moment().subtract(1,'days').format('YYYY-MM-DD') }}",
                  },
                ],
              }}
            />
            <Tabs
              id="tabsOnOff3"
              itemMode="static"
              margin="4px 12px"
              value="{{ self.values[0] }}"
            >
              <Option id="d3d24" label="오프라인" value="오프라인" />
              <Option id="47702" label="온라인" value="온라인" />
              <Option id="215bc" label="온오프라인 합계" value="합계" />
            </Tabs>
          </View>
        </Container>
      </Header>
      <View id="9bd21" viewKey="View 1">
        <ListViewBeta
          id="listView3"
          _primaryKeys=""
          data="{{ unitList.value[tabsPeriod3.value] }}"
          itemWidth="200px"
          margin="0"
          numColumns={3}
          padding="0"
        >
          <Container
            id="container10"
            footerPadding="4px 12px"
            headerPadding="0"
            padding="12px"
            showBody={true}
            showHeader={true}
          >
            <Header>
              <Text
                id="containerTitle6"
                value="###### {{ item }} {{ tabsPeriod3.value === 'monthly' ? '월' :
tabsPeriod3.value === 'quarterly' ? '분기' : '' }}"
                verticalAlign="center"
              />
              <Text
                id="text8"
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
  </Frame>
</Screen>
