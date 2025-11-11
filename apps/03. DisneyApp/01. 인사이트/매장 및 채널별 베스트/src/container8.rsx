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
    <Text
      id="text3"
      value="##### 매장 및 채널별 베스트"
      verticalAlign="center"
    />
    <Select
      id="select_main_type"
      emptyMessage="No options"
      itemMode="static"
      label="매장/채널"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value="shop"
    >
      <Option id="5fa84" label="매장별" value="shop" />
      <Option id="ceee0" label="유통채널별" value="channel" />
    </Select>
    <Select
      id="select_sub_type"
      captionByIndex="{{ select_main_type.selectedItem.value === 'shop' ? item.shop_cd : '' }}"
      data="{{ var_channel_data_list.value }}"
      emptyMessage="No options"
      hidden="{{ select_main_type.selectedItem.value === 'all' }}"
      hiddenByIndex=""
      iconByIndex={
        "{{  select_main_type.selectedItem.value === 'shop' ? \"/icon:bold/shopping-store-1\" : '' }}"
      }
      label=""
      labels="{{ item.shop_nm }}"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showClear={true}
      showSelectionIndicator={true}
      value="{{ self.values?.length > 0 ? self.values[0] : '' }}"
      values="{{ item.shop_cd }}"
    />
    <Multiselect
      id="season_select"
      data="{{ season_list_new.data }}"
      disabled="{{query_get_data.isFetching || checkbox1.value}}"
      emptyMessage="No options"
      label="시즌 선택"
      labels="{{ item.year_season_label }}"
      labelWidth="20"
      overlayMaxHeight={375}
      placeholder="Select options"
      showSelectionIndicator={true}
      tooltipByIndex="{{ item.year_sesn_nm_kor }}"
      value="{{ get_latest_seasons.data }}"
      values="{{ item.year_sesn_cd }}"
      wrapTags={true}
    />
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
    <Checkbox
      id="checkbox1"
      hidden=""
      label="최근 5개년 무시즌 모아보기({{moment().year() - 4}} ~ {{moment().year()}})"
      labelWidth="100"
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
