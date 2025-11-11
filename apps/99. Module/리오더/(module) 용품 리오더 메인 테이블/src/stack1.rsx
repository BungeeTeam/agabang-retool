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
      hidden=""
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
        pluginId="get_items_by_brand"
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
    <Select
      id="select_season"
      colorByIndex=""
      data="{{ season_list.data }}"
      emptyMessage="No options"
      hidden="true"
      label="시즌"
      labelPosition="top"
      labels="{{ item.year_nm}} {{ item.sesn_nm}}"
      overlayMaxHeight={375}
      placeholder="시즌을 선택해주세요."
      showSelectionIndicator={true}
      value="{{ getSeasonList.value[0].season_code }}"
      values="{{ item.season_code }}"
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
      <Event
        event="change"
        method="clearSelection"
        params={{ ordered: [] }}
        pluginId="table_main_list"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Multiselect
      id="select_item"
      data="{{CategorizedSalesTransformer.value}}"
      emptyMessage="No options"
      label="소분류(ERP 기준)"
      labelPosition="top"
      labels="{{ item.label }}"
      loading="{{ CategorizedSalesTransformer.isFetching }}"
      overlayMaxHeight={375}
      placeholder="카테고리를 선택해주세요."
      showClear={true}
      showSelectionIndicator={true}
      value={'["all"]'}
      values="{{ item.value }}"
      wrapTags={true}
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
    </Multiselect>
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
        pluginId="get_item_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Date>
    <Date
      id="inputSalesEndDate"
      dateFormat="yyyy-MM-dd"
      datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
      label="예상 판매 마감일"
      labelPosition="top"
      tooltipText="기본값: 오늘 날짜에 6개월을 더한 날짜"
      value="{{ getTargetEndDate.value }}"
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
    </Date>
  </View>
</Container>
