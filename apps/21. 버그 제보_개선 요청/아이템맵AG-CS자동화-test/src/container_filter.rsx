<Container
  id="container_filter"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0"
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
    <TextInput
      id="search_text"
      iconBefore="bold/interface-search"
      label=""
      labelPosition="top"
      labelWidth="10"
      margin="5px 8px 3px 8px"
      placeholder="카테고리, 상품명, 품번, 컬러, 소재"
      style={{
        ordered: [
          { fontSize: "10px" },
          { fontWeight: "400" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      textBefore="검색"
    >
      <Event
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list_new"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="blur"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list_new"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </TextInput>
    <Select
      id="select_season_type"
      captionByIndex=""
      colorByIndex=""
      data=""
      disabledByIndex=""
      emptyMessage="No options"
      fallbackTextByIndex=""
      hiddenByIndex=""
      iconByIndex=""
      imageByIndex=""
      itemMode="static"
      label=""
      labelPosition="top"
      labels=""
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="구분"
      tooltipByIndex=""
      value="season"
      values=""
    >
      <Option
        id="a7f07"
        disabled={false}
        hidden={false}
        label="시즌"
        value="season"
      />
      <Option
        id="d55b9"
        disabled="false"
        hidden={false}
        label="사계절
"
        value="season_less"
      />
      <Option
        id="19091"
        disabled="false"
        hidden={false}
        label="용품"
        value="yongpum"
      />
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list_new"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Multiselect
      id="season_select_new"
      data="{{ select_season_type.value === 'yongpum' ? code_brand.data :
 select_season_type.value === 'season' ? season_list.data 
: code_season.data }}"
      emptyMessage="No options"
      fallbackTextByIndex=""
      label=""
      labelPosition="top"
      labels="{{ select_season_type.value === 'season' ? item.year_season_label : 
  select_season_type.value === 'season_less' ? item.year_label 
: item.br_nm}}"
      overlayMaxHeight={375}
      placeholder="Select options"
      showSelectionIndicator={true}
      textBefore={
        '{{ select_season_type.value === \'season\' ? "시즌" \n  : select_season_type.value === \'season_less\' ? "연도" : "브랜드" }}'
      }
      tooltipText="최근 30일간 판매 상승폭이 가장 큰 2개 시즌이 기본으로 선택됩니다."
      value="{{ select_season_type.value === 'season' ? get_latest_seasons.data : 
  select_season_type.value === 'season_less' ? self.data.map(i=>i.year_sesn_cd).slice(0,2) : ['01'] }}"
      values="{{ select_season_type.value === 'yongpum' ? item.br_cd : item.year_sesn_cd}}"
      wrapTags={true}
    />
    <SegmentedControl
      id="segmentedControl_date_mode"
      itemMode="static"
      label=""
      paddingType="spacious"
      value="{{ self.values[0] }}"
    >
      <Option id="74c95" label="누적" value="cumulative" />
      <Option id="36c63" label="기간설정" value="period" />
      <Event
        event="change"
        method="trigger"
        params={{
          ordered: [
            {
              options: {
                object: {
                  onSuccess: null,
                  onFailure: null,
                  additionalScope: null,
                },
              },
            },
          ],
        }}
        pluginId="get_item_list_new"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        enabled={'{{ self.value == "period" }}'}
        event="change"
        method="showNotification"
        params={{
          ordered: [
            {
              options: {
                ordered: [
                  { notificationType: "info" },
                  {
                    description:
                      '"기간설정" 선택 시 입고수량은 첫 입고일로부터 종료일까지의 수량으로 계산됩니다. (시작일~종료일동안 입고된 수량이 아님)',
                  },
                  { title: "참고해주세요" },
                  { duration: "7" },
                ],
              },
            },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </SegmentedControl>
    <Container
      id="container_daterange"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      hidden={'{{segmentedControl_date_mode.value != "period"}}'}
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle12"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="1e83c" viewKey="View 1">
        <Date
          id="sel_start_date"
          dateFormat="yyyy-MM-dd"
          datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
          iconBefore="bold/interface-calendar"
          label=""
          labelPosition="top"
          textBefore="시작일"
          value="{{ new Date(new Date().setDate(new Date().getDate() - 365)) }}"
        >
          <Event
            event="blur"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="get_item_list_new"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Date>
        <Date
          id="sel_end_date"
          dateFormat="yyyy-MM-dd"
          datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
          iconBefore="bold/interface-calendar"
          label=""
          labelPosition="top"
          textBefore="종료일"
          value="{{ new Date() }}"
        >
          <Event
            event="blur"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="get_item_list_new"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Date>
      </View>
    </Container>
    <SegmentedControl
      id="sel_category"
      data="{{ var_category_list.value[['season_less'].includes(select_season_type.value) ? 'season_less' : 
  ['yongpum'].includes(select_season_type.value) ? 'yongpum' : 'season']}}"
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
      value="55"
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
