<Container
  id="container5"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="12px"
  showBody={true}
>
  <Header>
    <Text
      id="containerTitle5"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="ff8ca" viewKey="View 1">
    <Select
      id="seasonSelect2"
      captionByIndex=""
      colorByIndex=""
      data="{{ seasonQuery2.data }}"
      disabledByIndex=""
      emptyMessage="No options"
      fallbackTextByIndex=""
      hiddenByIndex=""
      iconByIndex=""
      imageByIndex=""
      label=""
      labelAlign="right"
      labels="{{ item.collection_cd }}"
      labelWidth="20
"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      style={{ ordered: [{ adornmentBackground: "tokens/9dc0c2b5" }] }}
      textBefore="시즌"
      tooltipByIndex=""
      value=""
      values="{{ item.collection_cd }}"
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
      id="largeCatSelect2"
      data="{{ getUniqueByKeys(catInfoQuery2.data, ['large_cat', 'it']).sort((a, b) => a.it - b.it) }}"
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.it }}"
      label=""
      labelPosition="top"
      labels="{{ item.large_cat }}"
      loading=""
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="대분류"
      value={'"-1"'}
      values="{{ item.it }}"
    >
      <Event
        event="change"
        method="run"
        params={{
          ordered: [
            {
              src: "middleCatSelect2.resetValue()\nsmallCatSelect2.resetValue()\nstySelect2.resetValue()\nsizeSelect2.resetValue()\n//  styQuery.trigger()",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Select
      id="middleCatSelect2"
      data="{{ getUniqueByKeys(catInfoQuery2.data.filter(item => item.it === largeCatSelect2.value), ['middle_cat', 'it_gb']).sort((a, b) => Number(a.it) - Number(b.it)) }}"
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.it_gb }}"
      label=""
      labelPosition="top"
      labels="{{ item.middle_cat }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="중분류"
      value={'"-1"'}
      values="{{ item.it_gb }}"
    />
    <Select
      id="smallCatSelect2"
      captionByIndex="{{ item.item }}"
      data="{{ getUniqueByKeys(catInfoQuery2.data.filter(item => item.it === largeCatSelect2.value), ['small_cat', 'item']).sort((a, b) => Number(a.item) - Number(b.item)) }}"
      emptyMessage="No options"
      fallbackTextByIndex=""
      label=""
      labelPosition="top"
      labels="{{ item.small_cat }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="소분류"
      value={'"-1"'}
      values="{{ item.item }}"
    />
    <Multiselect
      id="stySelect2"
      captionByIndex="{{ item.sty_cd }}"
      data="{{ getUniqueByKeys(catInfoQuery2.data.filter(item => item.it === largeCatSelect2.value), ['sty_cd', 'sty_nm']).sort((a, b) => a.sty_cd - b.sty_cd) }}"
      emptyMessage="No options"
      label=""
      labelPosition="top"
      labels="{{ item.sty_nm }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="스타일"
      value="[]"
      values="{{ item.sty_cd }}"
      wrapTags={true}
    />
    <Select
      id="sizeSelect2"
      captionByIndex="사이즈코드: {{ item.size_cd }}"
      data={
        "{{ (() => {\n  const arr = getUniqueByKeys(catInfoQuery2.data.filter(item => item.it === largeCatSelect2.value), ['size_cd', 'size_nm']).sort((a, b) => a.size_cd - b.size_cd);\n  arr.unshift({size_cd: \"-1\", size_nm: \"전체\"});\n  return arr;\n})() }}"
      }
      emptyMessage="No options"
      fallbackTextByIndex=""
      label=""
      labelPosition="top"
      labels="{{ item.size_nm }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="사이즈"
      value={'"-1"'}
      values="{{ item.size_cd }}"
    />
  </View>
</Container>
