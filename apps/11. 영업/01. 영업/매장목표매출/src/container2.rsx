<Container
  id="container2"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0px 4px"
  padding="12px"
  showBody={true}
>
  <Header>
    <Text
      id="containerTitle2"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="02310" viewKey="View 1">
    <Text
      id="text5"
      horizontalAlign="center"
      value="**총 매출**"
      verticalAlign="center"
    />
    <Text
      id="text6"
      horizontalAlign="center"
      value="**목표 매출**"
      verticalAlign="center"
    />
    <Text
      id="text8"
      horizontalAlign="center"
      value="**목표 달성률**"
      verticalAlign="center"
    />
    <ProgressCircle
      id="progressCircle1"
      horizontalAlign="center"
      margin="4px 2px"
      value="{{ formatDataAsArray(monthlySalesQuery.data).filter(item => item.yr === 2025 && item.onoff_flag === '오프라인').reduce((acc, cur) => acc + cur.rev, 0) / formatDataAsArray(monthlySalesQuery.data).filter(item => item.yr === 2025 && item.onoff_flag === '오프라인').reduce((acc, cur) => acc + cur.target_sales, 0) * 100 }}"
    />
    <Statistic
      id="statistic3"
      align="center"
      currency="KRW"
      formattingStyle="currency"
      label=""
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ formatDataAsArray(monthlySalesQuery.data).filter(item => item.yr === 2025 && item.onoff_flag === '오프라인').reduce((acc, cur) => acc + cur.rev, 0) }}"
    />
    <Statistic
      id="statistic4"
      align="center"
      currency="KRW"
      formattingStyle="currency"
      label=""
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value="{{ formatDataAsArray(monthlySalesQuery.data).filter(item => item.yr === 2025 && item.onoff_flag === '오프라인').reduce((acc, cur) => acc + cur.target_sales, 0) }}"
    />
    <Text
      id="text3"
      heightType="fill"
      horizontalAlign="center"
      margin="0px 4px"
      value="(단위: 백만원)"
      verticalAlign="center"
    />
    <Text
      id="text7"
      heightType="fill"
      horizontalAlign="center"
      margin="0px 4px"
      value="(단위: 백만원)"
      verticalAlign="center"
    />
  </View>
</Container>
