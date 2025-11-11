<Container
  id="container_filter"
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
  <View id="33666" viewKey="View 1">
    <Text
      id="text11"
      style={{
        ordered: [
          { fontSize: "16px" },
          { fontWeight: "600" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      value="📊   시즌리뷰: 복종별 판매율"
      verticalAlign="center"
    />
    <Date
      id="sel_start_date"
      dateFormat="yyyy-MM-dd"
      datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
      iconBefore="bold/interface-calendar"
      label=""
      labelPosition="top"
      textBefore="시작일"
      value="{{ new Date(new Date().setDate(new Date().getDate() - 365)) }}"
    />
    <Date
      id="sel_end_date"
      dateFormat="yyyy-MM-dd"
      datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
      iconBefore="bold/interface-calendar"
      label=""
      labelPosition="top"
      textBefore="종료일"
      value="{{ new Date() }}"
    />
    <Select
      id="select_season"
      data="{{ season_list.data }}"
      emptyMessage="No options"
      iconByIndex="bold/image-picture-gallery"
      label=""
      labelPosition="top"
      labels="{{ item.year_sesn_cd}} ({{ item.item_cnt ? item.item_cnt : 0}})"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="시즌"
      value="25SP"
      values="{{ item.year_sesn_cd }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <SegmentedControl
      id="sel_category"
      data="{{ var_category_list.value[brand_code.value]}}"
      label=""
      labelPosition="top"
      labels="{{ item.cat_nm }}"
      paddingType="spacious"
      style={{
        ordered: [
          { indicatorBackground: "rgba(252, 230, 139, 0.49)" },
          { background: "rgb(255, 255, 255)" },
          { border: "canvas" },
        ],
      }}
      value="{{ self.values[0] }}"
      values="{{ item.id }}"
    />
  </View>
</Container>
