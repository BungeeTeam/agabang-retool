<Container
  id="container9"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  margin="0px 2px"
  padding="0"
  showBody={true}
>
  <Header>
    <Text
      id="containerTitle9"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="e7063" viewKey="View 1">
    <Text id="text66" value="고객 영업 관련 지표" verticalAlign="center" />
    <Container
      id="container10"
      _gap="0px"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle10"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View
        id="c5532"
        disabled={false}
        hidden={false}
        iconPosition="left"
        viewKey="View 2"
      >
        <Statistic
          id="statistic3"
          currency="USD"
          label="기간내 판매한 영수증 갯수"
          positiveTrend="{{ self.value >= 0 }}"
          secondaryCurrency="USD"
          secondaryEnableTrend={true}
          secondaryFormattingStyle="percent"
          secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
          secondaryShowSeparators={true}
          secondarySignDisplay="trendArrows"
          secondaryValue=""
          showSeparators={true}
          value={'{{ shopReceiptStat.data["recp_cnt"] }}'}
        />
        <Statistic
          id="statistic4"
          currency="USD"
          decimalPlaces="2"
          label="영수증당 평균 판매갯수"
          labelCaption="사업부 매장 전체 평균 대비"
          positiveTrend="{{ self.value >= 0 }}"
          secondaryCurrency="USD"
          secondaryDecimalPlaces="1"
          secondaryEnableTrend={true}
          secondaryFormattingStyle="percent"
          secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
          secondaryShowSeparators={true}
          secondarySignDisplay="trendArrows"
          secondaryValue={
            '{{ shopReceiptStat.data["avg_selling_qty"] / shopReceiptStat.data["tot_avg_selling_qty"] - 1 }}'
          }
          showSeparators={true}
          value={'{{ shopReceiptStat.data["avg_selling_qty"] }}'}
        />
        <Statistic
          id="statistic5"
          currency="KRW"
          formattingStyle="currency"
          label="영수증당 평균 판매금액"
          labelCaption="사업부 매장 전체 평균 대비"
          positiveTrend="{{ self.value >= 0 }}"
          secondaryCurrency="USD"
          secondaryDecimalPlaces="1"
          secondaryEnableTrend={true}
          secondaryFormattingStyle="percent"
          secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
          secondaryShowSeparators={true}
          secondarySignDisplay="trendArrows"
          secondaryValue={
            '{{ shopReceiptStat.data["avg_selling_price"] / shopReceiptStat.data["tot_avg_selling_price"] - 1 }}'
          }
          showSeparators={true}
          value={'{{ shopReceiptStat.data["avg_selling_price"] }}'}
        />
      </View>
    </Container>
    <Text
      id="text67"
      margin="0px 8px"
      value="기간별 매출 지표"
      verticalAlign="center"
    />
    <Container
      id="container11"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle11"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="0473b" viewKey="View 1">
        <Statistic
          id="statistic6"
          currency="USD"
          label="어제의 매출"
          labelCaption={
            '{{ shopSalesQuery.data["sale_dt"].slice(-1) [0]}} 기준'
          }
          positiveTrend="{{ self.value >= 0 }}"
          secondaryCurrency="USD"
          secondaryEnableTrend={true}
          secondaryFormattingStyle="percent"
          secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
          secondaryShowSeparators={true}
          secondarySignDisplay="trendArrows"
          secondaryValue=""
          showSeparators={true}
          value={'{{ shopSalesQuery.data["판매금액"].slice(-1) }}'}
        />
        <Statistic
          id="statistic7"
          currency="USD"
          label="최근 일주일 동안의 매출"
          labelCaption={
            '{{ shopSalesQuery.data["sale_dt"].slice(-7) [0]}} ~ {{ shopSalesQuery.data["sale_dt"].slice(-1) [0]}} 기준'
          }
          positiveTrend="{{ self.value >= 0 }}"
          secondaryCurrency="USD"
          secondaryEnableTrend={true}
          secondaryFormattingStyle="percent"
          secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
          secondaryShowSeparators={true}
          secondarySignDisplay="trendArrows"
          secondaryValue=""
          showSeparators={true}
          value={
            '{{ shopSalesQuery.data["판매금액"].slice(-7).reduce((acc, cur) => acc + cur, 0) }}'
          }
        />
      </View>
    </Container>
  </View>
  <View
    id="7353c"
    disabled={false}
    hidden={false}
    iconPosition="left"
    viewKey="View 2"
  />
  <View
    id="54848"
    disabled={false}
    hidden={false}
    iconPosition="left"
    viewKey="View 3"
  >
    <Statistic
      id="statistic1"
      currency="USD"
      formattingStyle="currency"
      label="Gross volume"
      labelCaption="Since last month"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue={0.08}
      showSeparators={true}
      value={7552.8}
    />
    <Statistic
      id="statistic2"
      currency="USD"
      formattingStyle="currency"
      label="Gross volume"
      labelCaption="Since last month"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue={0.08}
      showSeparators={true}
      value={7552.8}
    />
  </View>
</Container>
