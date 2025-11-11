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
    <TextInput
      id="textInput1"
      label="검색"
      labelAlign="right"
      placeholder="품명, 품번, 컬러 등"
    />
    <DateRange
      id="dateRange"
      dateFormat="yyyy/MM/dd"
      disabled="{{query_get_data.isFetching}}"
      endPlaceholder="종료일"
      iconBefore="bold/interface-calendar-remove"
      label="조회 기간"
      labelAlign="right"
      labelWidth="20"
      startPlaceholder="시작일"
      textBetween="-"
      value={{
        ordered: [
          { start: "{{ moment().add('day', -7) }}" },
          { end: "{{ moment().add('day', -1) }}" },
        ],
      }}
    />
    <Text id="text6" value="#### 🏆 기간 Best & Worst" verticalAlign="center" />
    <Multiselect
      id="multiselectSeoson"
      data="{{ season_list.data }}"
      disabled="{{ checkbox1.value ? true : false }}"
      emptyMessage="No options"
      fallbackTextByIndex=""
      label="시즌 선택"
      labelAlign="right"
      labels="{{ item.year_season_label }}"
      labelWidth="20"
      overlayMaxHeight={375}
      placeholder="시즌을 선택해주세요"
      showSelectionIndicator={true}
      tooltipByIndex=""
      tooltipText="최근 1개월간 가장 판매가 많은 시즌 2개가 자동 선택됩니다."
      value="{{ get_latest_seasons.data }}"
      values="{{ item.year_sesn_cd }}"
      wrapTags={true}
    />
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
      value="21"
      values="{{ item.id }}"
    />
  </View>
</Container>
