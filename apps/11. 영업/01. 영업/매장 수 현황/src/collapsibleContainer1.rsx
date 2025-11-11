<Container
  id="collapsibleContainer1"
  _gap="0px"
  _justify="space-between"
  _type="stack"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Text
      id="collapsibleTitle1"
      value="##### {{moment(referenceDate.value).format('YYYY') }}년 매장 수 현황 요약"
      verticalAlign="center"
    />
    <ToggleButton
      id="collapsibleToggle1"
      horizontalAlign="right"
      iconForFalse="bold/interface-arrows-button-down"
      iconForTrue="bold/interface-arrows-button-up"
      iconPosition="replace"
      styleVariant="outline"
      text="{{ self.value ? 'Hide' : 'Show' }}"
      value="{{ collapsibleContainer1.showBody }}"
    >
      <Event
        event="change"
        method="setShowBody"
        params={{ ordered: [{ showBody: "{{ self.value }}" }] }}
        pluginId="collapsibleContainer1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </ToggleButton>
    <Text
      id="text49"
      disableMarkdown={true}
      value="* 운영 매장의 기준: 기준일자에 미폐점 매장이면서 선택한 사업부에 귀속되는 매출 실적이 있는 오프라인 매장입니다."
      verticalAlign="center"
    />
  </Header>
  <View id="c270f" viewKey="View 1">
    <Statistic
      id="statistic15"
      currency="USD"
      label="운영 매장수"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryPrefix="전년대비"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue="{{ (groupByChannel.value[0].curr_open/ groupByChannel.value[0].prev_open)-1 }}"
      showSeparators={true}
      suffix="개"
      value="{{ groupByChannel.value[0].curr_open}} "
    />
    <Statistic
      id="statistic16"
      currency="USD"
      label="총 누적 매출액"
      positiveTrend="{{ self.value >= 0 }}"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryPrefix="전년대비"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue="{{ (groupByChannel.value[0].rev_01/ groupByChannel.value[0].rev_02)-1 }}"
      showSeparators={true}
      suffix="백만원"
      value="{{ (groupByChannel.value[0].rev_01/1000000).toFixed(0) }}"
    >
      <Event
        event="click"
        method="setValue"
        params={{
          ordered: [
            {
              value:
                "{{ shopStatOverviewQueryNew\n  .data\n  .filter(\n  item => item.sales_yr === moment(referenceDate.value).year() &&\n  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&\n  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD'))\n}} ",
            },
          ],
        }}
        pluginId="thisYearList"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Statistic>
    <Statistic
      id="statistic17"
      currency="USD"
      label="금년 오픈 매장수"
      positiveTrend="{{ self.value >= 0 }}"
      prefix="+"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryPrefix="전년대비"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      suffix="개"
      value="{{ groupByChannel.value[0].new_opened}} "
    />
    <Statistic
      id="statistic18"
      currency="USD"
      label="금년 폐점 매장수"
      positiveTrend="{{ self.value >= 0 }}"
      prefix="-"
      secondaryCurrency="USD"
      secondaryDecimalPlaces="2"
      secondaryEnableTrend={true}
      secondaryFormattingStyle="percent"
      secondaryPositiveTrend="{{ self.secondaryValue >= 0 }}"
      secondaryPrefix="전년대비"
      secondaryShowSeparators={true}
      secondarySignDisplay="trendArrows"
      secondaryValue=""
      showSeparators={true}
      suffix="개"
      value="{{ groupByChannel.value[0].new_closed}} "
    />
  </View>
</Container>
