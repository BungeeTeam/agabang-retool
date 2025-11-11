<Container
  id="container_filter"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="12px"
  showBody={true}
>
  <Header>
    <Text
      id="containerTitle1"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="28726" viewKey="View 1">
    <Select
      id="select_season"
      data="{{ season_list.data }}"
      emptyMessage="No options"
      fallbackTextByIndex=""
      label=""
      labelAlign="right"
      labels="{{ item.year_sesn_nm_eng }}"
      labelWidth="20
"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="시즌"
      value="{{ season_list.data.year_sesn_nm_eng[2] }}"
      values="{{ item.year_sesn_nm_eng }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_season_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Select
      id="select_category"
      data={
        "{{\n(() => {\n  // 기존 로직: 중복 제거 및 정렬\n  const seen = new Set();\n  const categoryList = get_category_list_new.data\n    .filter(item => {\n      const key = `${item.large_cat}-${item.item_md_info_id}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n    })\n    .sort((a, b) => a.item_md_info_id - b.item_md_info_id);\n\n  // \"전체\" 옵션 객체 생성\n  // label은 '전체', value는 빈 문자열('')로 설정합니다.\n  const allOption = { large_cat: '전체', item_md_info_id: '' };\n\n  // 처리된 카테고리 목록의 맨 앞에 \"전체\" 옵션을 추가하여 반환\n  return [allOption, ...categoryList];\n})()\n}}"
      }
      emptyMessage="No options"
      label=""
      labelAlign="right"
      labels="{{ item.large_cat }}"
      labelWidth="20
"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="복종"
      value="'1'"
      values="{{ item.item_md_category_id }}"
    >
      <Option id="a08b8" label="배내저고리" value="Option 1" />
      <Option id="a3233" label="배내가운" value="Option 2" />
      <Option id="6d9f5" label="배내바디수트" value="Option 3" />
      <Option
        id="7f505"
        disabled={false}
        hidden={false}
        label="바디수트"
        value="Option 4"
      />
      <Option
        id="557d6"
        disabled={false}
        hidden={false}
        label="우주복"
        value="Option 5"
      />
      <Option
        id="f0218"
        disabled={false}
        hidden={false}
        label="내의"
        value="Option 6"
      />
      <Option
        id="ca17e"
        disabled={false}
        hidden={false}
        label="슬림내의"
        value="Option 7"
      />
    </Select>
    <Multiselect
      id="select_category_item"
      data={
        "{{\n(() => {\n  const seen = new Set();\n  let sourceData = get_category_list_new.data;\n\n  // 1. 특정 상위 카테고리가 선택된 경우에만 데이터 필터링\n  // ('전체'가 선택되면 select_category.value가 ''이므로 이 조건은 false가 됨)\n  if (select_category.value) {\n    sourceData = sourceData.filter(item => item.large_cat === select_category.selectedItem.large_cat);\n  }\n\n  // 2. 결정된 데이터 소스(전체 또는 일부)에서 고유한 하위 품목 목록 생성\n  const result = sourceData\n    .filter(item => {\n      const key = item.small_cat;\n      if (seen.has(key) || !key) return false;\n      seen.add(key);\n      return true;\n    })\n    .sort((a, b) => a.small_cat.localeCompare(b.small_cat, \"ko\"));\n\n  return result;\n})()\n}}"
      }
      emptyMessage="No options"
      iconByIndex=""
      label=""
      labelPosition="top"
      labels="{{ item.small_cat }}"
      overlayMaxHeight={375}
      placeholder="전체"
      showSelectionIndicator={true}
      textBefore="아이템"
      value="{{ (!select_category.value && select_category_item.options) ? select_category_item.options.map(option => option.small_cat) : [] }}"
      values="{{ item.small_cat }}"
      wrapTags={true}
    >
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
        pluginId="get_item_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Multiselect>
    <Select
      id="select_size_type"
      data="{{ get_size_info.data }}"
      emptyMessage="No options"
      hidden="true"
      label=""
      labels="{{ item.size_tp_nm }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="사이즈를 선택해주세요"
      showSelectionIndicator={true}
      textBefore="사이즈"
      value={'"00"'}
      values="{{ item.size_tp }}"
    />
    <TextInput
      id="textInput1"
      label=""
      labelPosition="top"
      placeholder="품번, 품명으로 검색할 수 있어요"
      textBefore="검색"
    >
      <Event
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_item_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </TextInput>
    <Switch
      id="switch_competitor"
      label="경쟁사 보기"
      value="false
"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_competitor_item_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Switch>
  </View>
</Container>
