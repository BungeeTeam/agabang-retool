<Container
  id="container_sidebar"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  margin="0"
  padding="12px"
  showBody={true}
  style={{ ordered: [{ borderRadius: "0px" }] }}
>
  <Header>
    <Text
      id="containerTitle1"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="066f0" viewKey="View 1">
    <Text id="text1" value="##### 시즌별 입출고 현황" verticalAlign="center" />
    <Select
      id="select_item_type"
      emptyMessage="No options"
      itemMode="static"
      label="🏷️ 구분"
      labelPosition="top"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value="season"
    >
      <Option id="99fa1" label="시즌" value="season" />
      <Option id="13165" label="사계절" value="season_less" />
      <Option id="8b4b0" label="용품" value="yongpum" />
      <Option
        id="218b6"
        disabled={false}
        hidden={false}
        label="짝수 시즌코드"
        value="mart"
      />
    </Select>
    <Spacer id="spacer2" />
    <Multiselect
      id="select_brand"
      data="{{ code_brand.data }}"
      emptyMessage="No options"
      hidden="{{ select_item_type.value === 'yongpum' ? false : true }}"
      label="🛍 브랜드"
      labelPosition="top"
      labels="{{ item.br_nm }}"
      overlayMaxHeight={375}
      placeholder="브랜드 선택"
      showSelectionIndicator={true}
      value="[{{ brand_code.value }}]"
      values="{{ item.br_cd }}"
      wrapTags={true}
    />
    <Spacer
      id="spacer1"
      hidden="{{ select_item_type.value === 'yongpum' ? false : true }}"
    />
    <Select
      id="season_select"
      data="{{season_list_new.data}}"
      emptyMessage="No options"
      label="🗓️ 시즌"
      labelPosition="top"
      labels="{{ select_item_type.value === 'yongpum' ? item.year_nm:
  select_item_type.value === 'season_less' ? item.year_nm:
  item.year_sesn_nm_eng }}"
      overlayMaxHeight={375}
      placeholder="시즌을 선택해주세요"
      showSelectionIndicator={true}
      value="{{ select_item_type.value === 'yongpum' ? 'S0':
  select_item_type.value === 'season_less' ? 'S0':
  select_item_type.value === 'season' ? get_latest_season.data :
  'S4' }}"
      values="{{ item.year_sesn_cd}}"
    />
    <Spacer id="spacer3" />
    <Select
      id="category_select"
      data="{{ select_item_type.value === 'yongpum'? var_category_list.value.yongpum : var_category_list.value[brand_code.value] }}"
      emptyMessage="No options"
      label="🏷 대분류"
      labelPosition="top"
      labels="{{ item.cat_nm }}"
      overlayMaxHeight={375}
      placeholder="대분류를 선택해주세요"
      showSelectionIndicator={true}
      value="999"
      values="{{ item.id}}"
    />
    <Spacer id="spacer4" />
    <TextInput
      id="search_text"
      iconAfter="bold/interface-search"
      label="🔎 검색"
      labelPosition="top"
      placeholder="상품명/입고현황/출고현황"
      showClear={true}
    />
  </View>
</Container>
