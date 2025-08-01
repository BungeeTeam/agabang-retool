<Container
  id="container8"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0"
  showBody={true}
  showBorder={false}
>
  <Header>
    <Text
      id="containerTitle8"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="73da1" viewKey="View 1">
    <Text
      id="text63"
      hidden=""
      margin="2px 8px"
      value="###### 온라인 판매비율"
      verticalAlign="center"
    />
    <Text
      id="goalFiguretext"
      hidden="{{ goalProgress.value === 0 }}"
      margin="2px 8px"
      value="###### 목표달성률"
      verticalAlign="center"
    />
    <Text
      id="text58"
      hidden=""
      margin="2px 8px"
      value="###### 이동지시 이행률"
      verticalAlign="center"
    />
    <ProgressCircle
      id="progressCircle1"
      horizontalAlign="center"
      value={'{{ rtInfoByShop.data[0]["rt_ratio"] * 100}}'}
    />
    <ProgressCircle
      id="progressCircle2"
      horizontalAlign="center"
      value="{{ (shopSalesByOnline.data.online_sales / shopSalesByOnline.data.tot_sales) * 100 }}"
    />
    <ProgressCircle
      id="goalProgress"
      hidden="{{ self.value == 0 }}"
      horizontalAlign="center"
      style={{ ordered: [{ fill: "danger" }] }}
      value="{{ selectedRow.value.this_yr_target > 0 ?selectedRow.value.this_yr_sales / selectedRow.value.this_yr_target * 100 : 0 }}"
    />
  </View>
</Container>
