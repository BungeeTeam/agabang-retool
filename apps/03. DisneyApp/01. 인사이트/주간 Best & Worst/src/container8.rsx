<Container
  id="container8"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
>
  <Header>
    <Text
      id="containerTitle8"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="488cc" viewKey="View 1">
    <DateRange
      id="dateRange"
      dateFormat="yyyy/MM/dd"
      disabled="{{query_get_data.isFetching}}"
      endPlaceholder="종료일"
      iconBefore="bold/interface-calendar-remove"
      label="조회 기간"
      labelWidth="15"
      startPlaceholder="시작일"
      textBetween="-"
      value={{
        ordered: [
          { start: "{{moment().add('day', -7)}}" },
          { end: "{{moment().add('day', -1)}}" },
        ],
      }}
    />
    <Multiselect
      id="multiselect1"
      data="{{ season_list.data }}"
      disabled="{{ checkbox1.value ? true : false }}"
      emptyMessage="No options"
      fallbackTextByIndex=""
      label="시즌 선택"
      labels="{{ item.year_season_label }}"
      labelWidth="15"
      overlayMaxHeight={375}
      placeholder="시즌을 선택해주세요"
      showSelectionIndicator={true}
      tooltipByIndex=""
      tooltipText="최근 30일간 판매 상승폭이 가장 큰 2개 시즌 기본 선택"
      value="{{ get_latest_seasons.data }}"
      values="{{ item.year_sesn_cd }}"
      wrapTags={true}
    />
    <Text id="text3" value="#### 🏆 기간 Best & Worst" verticalAlign="center" />
    <Checkbox
      id="checkbox1"
      hidden=""
      label="최근 5개년 무시즌 모아보기({{moment().year() - 4}} ~ {{moment().year()}})"
      labelWidth="100"
    />
    <Text
      id="text21"
      margin="0px 0px 4px 8px"
      style={{
        ordered: [
          { fontSize: "11px" },
          { fontWeight: "400" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      value="💡 조회 기간 동안 판매된 수량을 기준으로 Best & Worst 순위를 선정했습니다. "
      verticalAlign="center"
    />
    <SegmentedControl
      id="sel_category"
      data="{{ var_category_list.value }}"
      label=""
      labelPosition="top"
      labels="{{ item.cat_nm }}"
      paddingType="spacious"
      style={{
        ordered: [
          { background: "rgb(255, 255, 255)" },
          { border: "canvas" },
          { indicatorBackground: "primary" },
        ],
      }}
      value="57"
      values="{{ item.id }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list_new"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="setValue"
        params={{ ordered: [{ value: "{{self.value}}" }] }}
        pluginId="var_current_category"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </SegmentedControl>
  </View>
</Container>
