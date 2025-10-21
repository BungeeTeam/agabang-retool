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
    <Text id="text3" value="##### Best & Worst" verticalAlign="center" />
    <DateRange
      id="dateRange"
      dateFormat="yyyy/MM/dd"
      disabled="{{query_get_data.isFetching}}"
      endPlaceholder="종료일"
      iconBefore="bold/interface-calendar-remove"
      label="조회 기간"
      labelWidth="25"
      startPlaceholder="시작일"
      textBetween="-"
      value={{
        ordered: [
          { start: "{{moment().add('day', -7)}}" },
          { end: "{{moment().add('day', -1)}}" },
        ],
      }}
    />
    <Select
      id="select_season"
      data="{{ season_list.data }}"
      disabled="{{query_get_data.isFetching || checkbox1.value}}"
      emptyMessage="No options"
      iconByIndex=""
      label="시즌"
      labels="{{ item.year_sesn_nm_kor.replace('사계절', '무시즌') }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="시즌 선택"
      showSelectionIndicator={true}
      value="{{var_current_season_code.value[0].year_sesn_cd}}"
      values="{{ item.year_sesn_cd }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="_deprecated_get_item_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Checkbox
      id="checkbox1"
      label="최근 5개년 무시즌 모아보기({{moment().year() - 4}} ~ {{moment().year()}})"
      labelWidth="100"
    />
  </View>
</Container>
