<Container
  id="container5"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="12px"
  showBody={true}
  style={{ ordered: [{ background: "tokens/356f4e7b" }] }}
>
  <Header>
    <Text
      id="containerTitle5"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="7ac0c" viewKey="View 1">
    <Statistic
      id="statistic15"
      currency="USD"
      decimalPlaces="0"
      label="최대 추가예상매출"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="1"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPadDecimal={true}
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue={
        '{{ (simulTbl3.data.reduce((acc, cur) => {\n  acc += cur["추가예상매출"]\n  return acc\n}, 0) / simulTbl3.data.reduce((acc, cur) => {\n  acc += Number(cur["판매금액"])\n  return acc\n}, 0)) }}'
      }
      showSeparators={true}
      value={
        '{{ simulTbl3.data.reduce((acc, cur) => {\n  acc += cur["추가예상매출"]\n  return acc\n}, 0) }}'
      }
    />
    <Statistic
      id="statistic13"
      currency="USD"
      decimalPlaces="0"
      label="총 최적발주수량"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="1"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPadDecimal={true}
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue={
        '{{ (simulTbl3.data.reduce((acc, cur) => {\n  acc += cur["최적발주수량"]\n  return acc\n}, 0) / simulTbl3.data.reduce((acc, cur) => {\n  acc += Number(cur["입고수량"])\n  return acc\n}, 0) - 1) }}'
      }
      showSeparators={true}
      value={
        '{{ simulTbl3.data.reduce((acc, cur) => {\n  acc += Number(cur["최적발주수량"])\n  return acc\n}, 0) }}'
      }
    />
    <Statistic
      id="statistic14"
      currency="USD"
      decimalPlaces="0"
      label="총 최적발주금액"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="1"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPadDecimal={true}
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue={
        '{{ (simulTbl3.data.reduce((acc, cur) => {\n  acc += cur["최적발주금액"]\n  return acc\n}, 0) / simulTbl3.data.reduce((acc, cur) => {\n  acc += Number(cur["입고금액"])\n  return acc\n}, 0) - 1) }}'
      }
      showSeparators={true}
      value={
        '{{ simulTbl3.data.reduce((acc, cur) => {\n  acc += cur["최적발주금액"]\n  return acc\n}, 0) }}'
      }
    />
    <Statistic
      id="statistic16"
      currency="USD"
      decimalPlaces="0"
      label="최대 추가감소비용"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="1"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPadDecimal={true}
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue={
        '{{ (simulTbl3.data.reduce((acc, cur) => {\n  acc += cur["예상감소비용"]\n  return acc\n}, 0) / simulTbl3.data.reduce((acc, cur) => {\n  acc += Number(cur["입고원가"])\n  return acc\n}, 0)) }}'
      }
      showSeparators={true}
      value={
        '{{ simulTbl3.data.reduce((acc, cur) => {\n  acc += cur["예상감소비용"]\n  return acc\n}, 0) }}'
      }
    />
    <Spacer id="spacer8" />
    <Statistic
      id="statistic18"
      currency="USD"
      decimalPlaces="1"
      formattingStyle="percent"
      label="총 판매율(금액)"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="1"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPadDecimal={true}
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value={
        '{{ simulTbl3.data.reduce((acc, cur) => {\n  acc += Number(cur["판매금액"])\n  return acc\n}, 0) / simulTbl3.data.reduce((acc, cur) => {\n  acc += Number(cur["최적발주금액"])\n  return acc\n}, 0) }}'
      }
    />
    <Statistic
      id="statistic17"
      currency="USD"
      decimalPlaces="1"
      formattingStyle="percent"
      label="총 판매율(수량)"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="1"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPadDecimal={true}
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      value={
        '{{ simulTbl3.data.reduce((acc, cur) => {\n  acc += Number(cur["판매수량"])\n  return acc\n}, 0) / simulTbl3.data.reduce((acc, cur) => {\n  acc += Number(cur["최적발주수량"])\n  return acc\n}, 0) }}'
      }
    />
  </View>
</Container>
