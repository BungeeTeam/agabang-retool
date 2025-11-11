<Container
  id="container3"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0"
  showBody={true}
  showBorder={false}
  style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
>
  <Header>
    <Text
      id="containerTitle3"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="7e07a" viewKey="View 1">
    <Multiselect
      id="select_middle_cat"
      data="{{
  (() => {
    const selectedLargeCats = select_large_cat.value || [];
    if (selectedLargeCats.length === 0) return transform_categories.data.allMiddleCats;
    
    const middleCatSet = new Set();
    selectedLargeCats.forEach(largeCat => {
      const cats = transform_categories.data.middleCatsByLarge[largeCat];
      if (cats) {
        cats.forEach(cat => middleCatSet.add(cat.value));
      }
    });
    
    return [...middleCatSet].sort().map(cat => ({
      label: cat,
      value: cat
    }));
  })()
}}"
      emptyMessage="No options"
      label=""
      labels="{{ item.value }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="전체"
      showSelectionIndicator={true}
      textBefore="중분류"
      values="{{ item.value }}"
      wrapTags={true}
    >
      <Event
        event="change"
        method="clearValue"
        params={{ ordered: [] }}
        pluginId="select_small_cat"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Multiselect>
    <Select
      id="select_season"
      data="{{ get_season_list_dimstyle.data }}"
      emptyMessage="No options"
      label=""
      labels="{{ item.year_cd }}{{ item.season_cd }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="시즌"
      value={'"T1"'}
      values="{{ item.year_cd }}{{ item.season_cd }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_categories_by_brand"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Multiselect
      id="select_large_cat"
      data="{{ transform_categories.data.largeCats }}"
      emptyMessage="No options"
      label=""
      labels="{{ item.value }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="전체"
      showSelectionIndicator={true}
      textBefore="대분류"
      values="{{ item.value }}"
      wrapTags={true}
    >
      <Event
        event="change"
        method="clearValue"
        params={{ ordered: [] }}
        pluginId="select_middle_cat"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="clearValue"
        params={{ ordered: [] }}
        pluginId="select_small_cat"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Multiselect>
    <Multiselect
      id="select_small_cat"
      data="{{
  (() => {
    const selectedLargeCats = select_large_cat.value || [];
    const selectedMiddleCats = select_middle_cat.value || [];
    
    if (selectedLargeCats.length === 0 || selectedMiddleCats.length === 0) {
      return transform_categories.data.allSmallCats;
    }
    
    const smallCatSet = new Set();
    selectedLargeCats.forEach(largeCat => {
      selectedMiddleCats.forEach(middleCat => {
        const key = `${largeCat}_${middleCat}`;
        const cats = transform_categories.data.smallCatsByLargeMiddle[key];
        if (cats) {
          cats.forEach(cat => smallCatSet.add(cat.value));
        }
      });
    });
    
    return [...smallCatSet].sort().map(cat => ({
      label: cat,
      value: cat
    }));
  })()
}}"
      emptyMessage="No options"
      label=""
      labels="{{ item.value }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="전체"
      showSelectionIndicator={true}
      textBefore="소분류"
      values="{{ item.value }}"
      wrapTags={true}
    />
  </View>
</Container>
