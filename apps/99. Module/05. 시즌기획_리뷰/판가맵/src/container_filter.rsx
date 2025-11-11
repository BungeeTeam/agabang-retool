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
      value="25WT"
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
        '{{\n(() => {\n  const seen = new Set();\n  const result = get_category_list_new.data\n   // .filter(item => item.br_cd !== null && bizMultiSelect.value.includes(item.biz_cd))\n    .filter(item => {\n      const key = `${item.large_cat}-${item.item_md_info_id}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n  .sort((a, b) => a.item_md_info_id - b.item_md_info_id)\n    //  .sort((a, b) => a.br_nm.localeCompare(b.br_nm, "ko"))\n  return result\n})()\n}}'
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
      textBefore="대분류"
      value="{{ self.data[0].item_md_category_id }}"
      values="{{ item.item_md_category_id}}"
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
    <Select
      id="select_category_item2"
      data={
        '{{\n(() => {\n  const seen = new Set();\n  const result = get_category_list_new.data\n    .filter(item => item.large_cat === select_category.selectedItem.large_cat)\n    .filter(item => {\n      const key = `${item.middle_cat}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n  .sort((a, b) => a.middle_cat - b.middle_cat)\n    //  .sort((a, b) => a.br_nm.localeCompare(b.br_nm, "ko"))\n  return result\n})()\n}}'
      }
      emptyMessage="No options"
      label=""
      labelPosition="top"
      labels="{{ item.middle_cat }}"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="중분류"
      value="{{ self.data[0].middle_cat }}"
      values="{{ item.middle_cat }}"
    >
      <Event
        event="change"
        method="run"
        params={{
          ordered: [
            {
              src: 'console.log("select_category_item.value:", select_category_item2.value);\n\n// 빈 객체인지 확인하는 함수\nconst isEmptyObject = (obj) => obj && typeof obj === "object" && Object.keys(obj).length === 0;\n\n// 값이 없거나 빈 객체일 경우 알림 표시\nif (!select_category_item2.value || isEmptyObject(select_category_item2.value)) {\n  console.log("조건 충족: 알림 표시");\n  utils.showNotification({\n    title: "먼저 아이템 분류를 선택해야 합니다.",\n    description: "조회하고 싶은 아이템을 골라주세요. (예: 우주복)",\n    notificationType: "warning"\n  });\n  return;\n}\nget_item_list.trigger();',
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Multiselect
      id="select_category_item"
      data={
        '{{\n(() => {\n  const seen = new Set();\n  const result = get_category_list_new.data\n    .filter(item => item.large_cat === select_category.selectedItem.large_cat)\n    .filter(item => item.middle_cat === select_category_item2.selectedItem.middle_cat)\n    .filter(item => {\n      const key = `${item.small_cat}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n  .sort((a, b) => a.small_cat - b.small_cat)\n    //  .sort((a, b) => a.br_nm.localeCompare(b.br_nm, "ko"))\n  return result\n})()\n}}'
      }
      emptyMessage="No options"
      label=""
      labelPosition="top"
      labels="{{ item.small_cat }}"
      overlayMaxHeight={375}
      showSelectionIndicator={true}
      textBefore="소분류"
      value="[{{ self.data[0].small_cat }}]"
      values="{{ item.small_cat }}"
      wrapTags={true}
    >
      <Event
        event="change"
        method="run"
        params={{
          ordered: [
            {
              src: 'console.log("select_category_item.value:", select_category_item.value);\n\n// 빈 객체인지 확인하는 함수\nconst isEmptyObject = (obj) => obj && typeof obj === "object" && Object.keys(obj).length === 0;\n\n// 값이 없거나 빈 객체일 경우 알림 표시\nif (!select_category_item.value || isEmptyObject(select_category_item.value)) {\n  console.log("조건 충족: 알림 표시");\n  utils.showNotification({\n    title: "먼저 아이템 분류를 선택해야 합니다.",\n    description: "조회하고 싶은 아이템을 골라주세요. (예: 우주복)",\n    notificationType: "warning"\n  });\n  return;\n}\nget_item_list.trigger();',
            },
          ],
        }}
        pluginId=""
        type="script"
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
    <Switch
      id="switch_competitor"
      hidden="{{ brand_code.value === '01' || brand_code.value === '79' }}"
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
