<Container
  id="container11"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  hidden="true"
  margin="0"
  padding="12px"
  showBody={true}
  showBorder={false}
  style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
>
  <View id="914b9" viewKey="View 1">
    <Multiselect
      id="select_season2"
      data="{{
  (() => {
    const selectedSeason = select_season.value || '';
    const dataArray = formatDataAsArray(get_season_list_dimstyle.data);
    
    if (!selectedSeason || dataArray.length === 0) return [];
    
    return dataArray
      .filter(item => {
        if (!item || !item.year_cd || !item.season_cd) return false;
        
        // 연도 비교
        if (item.year_cd < selectedSeason[0]) return true;
        if (item.year_cd > selectedSeason[0]) return false;
        
        // 같은 연도일 때 시즌 비교
        return parseInt(item.season_cd) < parseInt(selectedSeason[1]);
      })
      .map(item => ({
        value: item.year_cd + item.season_cd,
        label: item.year_nm + ' ' + item.season_nm
      }));
  })()
}}"
      emptyMessage="No options"
      label=""
      labels="{{item.value}}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="전체"
      showSelectionIndicator={true}
      textBefore="시즌"
      values="{{item.value}}"
      wrapTags={true}
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_categories_by_brand_for_reference"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Multiselect>
    <TextInput
      id="search_text"
      iconBefore="bold/interface-search"
      label=""
      placeholder="품명/컬러/소재로 검색하세요"
      showClear={true}
    />
    <Button
      id="button4"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ ordered: [{ background: "canvas" }] }}
    >
      <Event
        event="click"
        method="run"
        params={{ ordered: [{ src: "container11.setHidden(true)" }] }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Multiselect
      id="select_large_cat2"
      data="{{ transform_categories_for_reference.data.largeCats }}"
      emptyMessage="No options"
      label=""
      labels="{{ item.value }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="전체"
      showSelectionIndicator={true}
      textBefore="대분류"
      value="{{ select_large_cat.value }}"
      values="{{ item.value }}"
      wrapTags={true}
    >
      <Event
        event="change"
        method="clearValue"
        params={{ ordered: [] }}
        pluginId="select_middle_cat2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="clearValue"
        params={{ ordered: [] }}
        pluginId="select_small_cat2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Multiselect>
    <Multiselect
      id="select_middle_cat2"
      data="{{
  (() => {
    const selectedLargeCats = select_large_cat2.value || [];
    if (selectedLargeCats.length === 0) return transform_categories_for_reference.data.allMiddleCats;
    
    const middleCatSet = new Set();
    selectedLargeCats.forEach(largeCat => {
      const cats = transform_categories_for_reference.data.middleCatsByLarge[largeCat];
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
      value="{{ select_middle_cat.value }}"
      values="{{ item.value }}"
      wrapTags={true}
    >
      <Event
        event="change"
        method="clearValue"
        params={{ ordered: [] }}
        pluginId="select_small_cat2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Multiselect>
    <Multiselect
      id="select_small_cat2"
      data="{{
  (() => {
    const selectedLargeCats = select_large_cat2.value || [];
    const selectedMiddleCats = select_middle_cat2.value || [];
    
    // 대분류나 중분류가 선택되지 않았으면 모든 소분류 반환
    if (selectedLargeCats.length === 0 || selectedMiddleCats.length === 0) {
      return transform_categories_for_reference.data.allSmallCats;
    }
    
    const smallCatSet = new Set();
    selectedLargeCats.forEach(largeCat => {
      selectedMiddleCats.forEach(middleCat => {
        const key = `${largeCat}_${middleCat}`;
        const cats = transform_categories_for_reference.data.smallCatsByLargeMiddle[key];
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
      value="{{ select_small_cat.value }}"
      values="{{ item.value }}"
      wrapTags={true}
    />
    <Table
      id="table_items_related"
      cellSelection="none"
      clearChangesetOnSave={true}
      data={
        '{{ \n  (() => {\n    const dataArray = formatDataAsArray(get_related_item_list.data);\n    \n    // 시즌 필터\n    const seasonFiltered = (!select_season2.value || select_season2.value.length === 0 || select_season2.value.includes("전체"))\n      ? dataArray\n      : dataArray.filter(item => \n          select_season2.value.includes(item.year_cd + item.season_cd)\n        );\n    \n    // 대분류 필터\n    const largeCatFiltered = (!select_large_cat2.value || select_large_cat2.value.length === 0 || select_large_cat2.value.includes("전체"))\n      ? seasonFiltered\n      : seasonFiltered.filter(item => {\n          // "복종X" 처리\n          if (select_large_cat2.value.includes("복종X") && !item.large_cat) {\n            return true;\n          }\n          // 일반 대분류 처리\n          return select_large_cat2.value.includes(item.large_cat);\n        });\n    \n    // 중분류 필터 (select_middle_cat2가 있다면)\n    const middleCatFiltered = (!select_middle_cat2?.value || select_middle_cat2.value.length === 0)\n      ? largeCatFiltered\n      : largeCatFiltered.filter(item => \n          select_middle_cat2.value.includes(item.middle_cat)\n        );\n    \n    // 소분류 필터 (select_small_cat2가 있다면)\n    const finalFiltered = (!select_small_cat2?.value || select_small_cat2.value.length === 0)\n      ? middleCatFiltered\n      : middleCatFiltered.filter(item => \n          select_small_cat2.value.includes(item.small_cat)\n        );\n    \n    return finalFiltered;\n  })()\n}}'
      }
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      rowHeight="large"
      searchTerm="{{ search_text.value }}"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="53602"
        alignment="center"
        format="image"
        formatOptions={{ widthType: "fit" }}
        groupAggregationMode="none"
        placeholder="Enter value"
        position="left"
        referenceId="img"
        size={69}
        summaryAggregationMode="none"
        valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg"
      />
      <Column
        id="0efe5"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sty_cd"
        label="Sty cd"
        placeholder="Enter value"
        position="center"
        size={85.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="7c3f0"
        alignment="left"
        caption="{{ currentSourceRow.sty_cd }}"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="품명"
        placeholder="Enter value"
        position="left"
        size={141.28125}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      >
        <Event
          event="clickCell"
          method="setValue"
          params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
          pluginId="var_sty_data"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickCell"
          method="show"
          params={{ ordered: [] }}
          pluginId="drawerFrame_item_detail_new"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="55e07"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="col_cd"
        label="Col cd"
        placeholder="Enter value"
        position="center"
        size={52.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="f3770"
        alignment="center"
        format="tag"
        formatOptions={{
          automaticColors: false,
          color:
            "{{ JSON.parse(retoolContext.configVars.var_color_dict)[item] }}",
        }}
        groupAggregationMode="none"
        key="col_nm"
        label="컬러"
        placeholder="Select option"
        position="center"
        size={88.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="8bbf5"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="fabric"
        label="소재"
        placeholder="Enter value"
        position="center"
        size={106.421875}
        summaryAggregationMode="none"
      />
      <Column
        id="a5921"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="sum"
        hidden="false"
        key="small_cat"
        label="소분류"
        placeholder="Select option"
        position="center"
        size={90.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="44c01"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sale_per"
        label="판매율(수량)"
        placeholder="Enter value"
        position="center"
        size={81.140625}
        summaryAggregationMode="none"
      />
      <Column
        id="72a47"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="입고량"
        placeholder="Enter value"
        position="center"
        size={50.40625}
        summaryAggregationMode="none"
      />
      <Column
        id="68c33"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_sale_qty"
        label="판매량"
        placeholder="Enter value"
        position="center"
        size={50.40625}
        summaryAggregationMode="none"
      />
      <Column
        id="62bbc"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sale_amt_per"
        label="판매율(금액)"
        placeholder="Enter value"
        position="center"
        size={78}
        summaryAggregationMode="none"
      />
      <Column
        id="923e5"
        alignment="center"
        format="button"
        formatOptions={{ variant: "solid" }}
        groupAggregationMode="none"
        label="추가"
        placeholder="Enter value"
        position="right"
        referenceId="추가"
        size={49.765625}
        summaryAggregationMode="none"
        valueOverride="+"
      >
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="add_item"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="52d2a"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="year_sesn_nm_eng"
        label="Year sesn nm eng"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          pluginId="table_items_related"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="refresh"
          pluginId="table_items_related"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
</Container>
