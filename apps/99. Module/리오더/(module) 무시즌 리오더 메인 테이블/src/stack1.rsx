<Container
  id="stack1"
  _align="center"
  _gap="0px"
  _type="stack"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0"
  showBody={true}
  showBorder={false}
  style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
>
  <View id="bead2" viewKey="View 1">
    <Cascader2
      id="cascaderNew1"
      _captionByIndex={["", "", "", "", "", ""]}
      _colorByIndex={["", "", "", "", "", ""]}
      _disabledByIndex={["", "", "", "", "", ""]}
      _fallbackTextByIndex={["", "", "", "", "", ""]}
      _hasMigratedNestedItems={true}
      _hiddenByIndex={["", "", "", "", "", ""]}
      _iconByIndex={["", "", "", "", "", ""]}
      _ids={["89896", "b1d24", "facba", "98e31", "2d9e6", "c1a6f"]}
      _imageByIndex={["", "", "", "", "", ""]}
      _keyByIndex={[
        "Pants-TEMPLATE_DEFAULT",
        "Denim-TEMPLATE_DEFAULT",
        "Jeans-TEMPLATE_DEFAULT",
        "Shoes-TEMPLATE_DEFAULT",
        "Sneakers-TEMPLATE_DEFAULT",
        "Boots-TEMPLATE_DEFAULT",
      ]}
      _labels={["", "", "", "", "", ""]}
      _parentKeyByIndex={[
        "",
        "Pants-TEMPLATE_DEFAULT",
        "Denim-TEMPLATE_DEFAULT",
        "",
        "Shoes-TEMPLATE_DEFAULT",
        "Shoes-TEMPLATE_DEFAULT",
      ]}
      _tooltipByIndex={["", "", "", "", "", ""]}
      _values={["Pants", "Denim", "Jeans", "Shoes", "Sneakers", "Boots"]}
      data="{{ get_md_categories_by_brand.data }}"
      emptyMessage="No options"
      label="카테고리(MD 기준)"
      labelPosition="top"
      labels="{{ item.label }}"
      labelWrap={true}
      overlayMaxHeight={375}
      parentKeyByIndex="{{ item.parent }}"
      placeholder="전체"
      value={'"_ALL_"'}
      values="{{ item.value }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="parse_cascader_path"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="clearSelection"
        params={{ ordered: [] }}
        pluginId="table_main_list"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Cascader2>
    <TextInput
      id="textInput1"
      label="검색"
      labelPosition="top"
      placeholder="품번, 품명 등을 입력하세요"
    />
    <Select
      id="select_brand"
      data="{{ var_brand_list.value }}"
      emptyMessage="No options"
      label="브랜드"
      labelPosition="top"
      labels="{{ item.br_nm }}"
      overlayMaxHeight={375}
      placeholder="브랜드를 선택해주세요."
      showSelectionIndicator={true}
      value="all"
      values="{{ item.value }}"
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
      <Event
        event="change"
        method="clearSelection"
        params={{ ordered: [] }}
        pluginId="table_main_list"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_erp_categories_by_brand"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="change"
        method="resetValue"
        params={{ ordered: [] }}
        pluginId="select_item"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Date
      id="inputReferenceDate"
      dateFormat="yyyy-MM-dd"
      datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
      hidden="true"
      label="기준일"
      labelPosition="top"
      maxDate="{{new Date(new Date().setDate(new Date().getDate() - 1))}}"
      value="{{ new Date(new Date().setDate(new Date().getDate() -1 )) }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getColorList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Date>
    <Date
      id="inputSalesEndDate"
      dateFormat="yyyy-MM-dd"
      datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
      hidden="true"
      label="예상 판매 마감일"
      labelPosition="top"
      value="{{
  (() => {
    const today = new Date();
    const currentMonth = today.getMonth() + 1;
    const currentYear = today.getFullYear();

    let defaultDate;

    if (currentMonth >= 5 && currentMonth <= 7) {
      defaultDate = new Date(currentYear, 7, 31);
    } else if (currentMonth >= 8 && currentMonth <= 11) {
      defaultDate = new Date(currentYear, 11, 31);
    } else if (currentMonth === 12) {
      defaultDate = new Date(currentYear + 1, 1, 28);
    } else if (currentMonth === 1) {
      defaultDate = new Date(currentYear, 1, 28);
    } else if (currentMonth >= 2 && currentMonth <= 4) {
      defaultDate = new Date(currentYear, 4, 15);
    } else {
      // Fallback for unexpected cases, or if you prefer the original +90 days logic
      defaultDate = new Date(today.setDate(today.getDate() + 90));
    }
    return defaultDate;
  })()
}}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getColorList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Date>
  </View>
</Container>
