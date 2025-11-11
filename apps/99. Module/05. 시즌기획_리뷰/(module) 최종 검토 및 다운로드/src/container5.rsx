<Container
  id="container5"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  margin="0"
  padding="0"
  showBody={true}
  showBorder={false}
>
  <Header>
    <Text
      id="containerTitle19"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="03c00" viewKey="View 1">
    <TextInput
      id="main_items_tableSearchFilter"
      iconBefore="bold/interface-search-circle"
      label=""
      placeholder="품명/품번 검색"
    />
    <Select
      id="select_season"
      data="{{ get_season_list.data }}"
      emptyMessage="No options"
      label=""
      labels="{{ item.season_code }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="시즌"
      value="{{ get_season_list.data.season_code[0] }}"
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
        pluginId="get_md_categories_by_brand"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Cascader2
      id="cascaderNew1"
      _captionByIndex={["", "", "", "", "", ""]}
      _colorByIndex={["", "", "", "", "", ""]}
      _disabledByIndex={["", "", "", "", "", ""]}
      _fallbackTextByIndex={["", "", "", "", "", ""]}
      _hasMigratedNestedItems={true}
      _hiddenByIndex={["", "", "", "", "", ""]}
      _iconByIndex={["", "", "", "", "", ""]}
      _ids={["31583", "03d9d", "2927f", "a04c3", "68a42", "3fe66"]}
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
      label=""
      labelPosition="top"
      labels="{{ item.label }}"
      labelWrap={true}
      overlayMaxHeight={375}
      parentKeyByIndex="{{ item.parent }}"
      placeholder="전체"
      textBefore="카테고리"
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
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_main_item_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Cascader2>
    <Select
      id="select_size_type"
      data="{{ get_size_info.data }}"
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.size_tp }}"
      label=""
      labels="{{ item.size_tp_nm }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="저장된 아이템에 맞게 조회됩니다."
      showSelectionIndicator={true}
      textBefore="사이즈"
      value="{{ get_size_info.data[0].size_tp }}"
      values="{{ item.size_tp }}"
    />
    <Table
      id="main_items_table"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_main_item_list.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: "0" }}
      emptyMessage="아직 {{select_season.value}} 시즌에 저장된 아이템이 없습니다.
발주량 산정 후 확인해주세요."
      enableSaveActions={true}
      rowHeight="large"
      searchTerm="{{ main_items_tableSearchFilter.value }}"
      showBorder={true}
      showColumnBorders={true}
      showFooter={true}
      showHeader={true}
    >
      <Column
        id="cdfa9"
        alignment="center"
        format="image"
        formatOptions={{ widthType: "fit" }}
        groupAggregationMode="none"
        label="사진"
        placeholder="Enter value"
        position="left"
        referenceId="img"
        size={73}
        summaryAggregationMode="none"
        valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{ currentSourceRow.sty_cd }}{{ currentSourceRow.col_cd }}.jpg"
      />
      <Column
        id="e5d3e"
        alignment="left"
        caption="{{ currentSourceRow.sty_cd }}"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="품명"
        placeholder="Enter value"
        position="left"
        size={141.609375}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="setValue"
          params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
          pluginId="var_main_item_info"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickCell"
          method="show"
          params={{ ordered: [] }}
          pluginId="drawerFrame1"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="9d9c6"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sty_cd"
        label="Sty cd"
        placeholder="Enter value"
        position="center"
        size={76.609375}
        summaryAggregationMode="none"
      />
      <Column
        id="8afa1"
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
        size={52.25}
        summaryAggregationMode="none"
      />
      <Column
        id="80f23"
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
        size={97.640625}
        summaryAggregationMode="none"
      />
      <Column
        id="49e7a"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="large_cat"
        label="대분류"
        placeholder="Enter value"
        position="center"
        size={84}
        summaryAggregationMode="none"
      />
      <Column
        id="be1dc"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="middle_cat"
        label="중분류"
        placeholder="Enter value"
        position="center"
        size={84}
        summaryAggregationMode="none"
      />
      <Column
        id="df1db"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="small_cat"
        label="소분류"
        placeholder="Enter value"
        position="center"
        size={93}
        summaryAggregationMode="none"
      />
      <Column
        id="3e3d0"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="fabric"
        label="소재"
        placeholder="Enter value"
        position="center"
        size={109.34375}
        summaryAggregationMode="none"
      />
      <Column
        id="c76d6"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="preview_grade"
        label="등급"
        placeholder="Select option"
        position="center"
        size={61.765625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="d8370"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="preview_score"
        label="점수"
        placeholder="Enter value"
        position="center"
        size={63.765625}
        summaryAggregationMode="none"
      />
      <Column
        id="7d74e"
        alignment="left"
        cellTooltipMode="overflow"
        format="multilineString"
        groupAggregationMode="none"
        key="opinion"
        label="매장의견"
        placeholder="Enter value"
        position="center"
        size={154.515625}
        summaryAggregationMode="none"
        valueOverride={'{{ item == 0 ? "" : item }}'}
      />
      <Column
        id="31e20"
        alignment="left"
        cellTooltipMode="overflow"
        format="string"
        groupAggregationMode="none"
        key="md_memo"
        label="MD의견"
        placeholder="Enter value"
        position="center"
        size={150.0625}
        summaryAggregationMode="none"
      />
      <Column
        id="90b99"
        alignment="left"
        cellTooltipMode="overflow"
        format="string"
        groupAggregationMode="none"
        key="final_memo"
        label="팀장의견"
        placeholder="Enter value"
        position="center"
        size={153.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="27255"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="price_memo"
        label="최종의견"
        placeholder="Enter value"
        position="center"
        size={147.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="ce33d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="final_lot"
        label="최종수량"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="cc853"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[0] || "-" }} '}
        placeholder="Enter value"
        position="center"
        referenceId="size_1"
        size={51.984375}
        summaryAggregationMode="none"
        valueOverride={
          '{{ JSON.parse(item).size_1.qty.toFixed(0) == "0" ? "" : JSON.parse(item).size_1.qty.toLocaleString() }}'
        }
      />
      <Column
        id="84b85"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[1] || "-" }}'}
        placeholder="Enter value"
        position="center"
        referenceId="size_2"
        size={52.796875}
        summaryAggregationMode="none"
        valueOverride={
          '{{ JSON.parse(item).size_2.qty.toFixed(0) == "0" ? "" : JSON.parse(item).size_2.qty.toFixed(0).toLocaleString() }}'
        }
      />
      <Column
        id="3099c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[2] || "-" }}'}
        placeholder="Enter value"
        position="center"
        referenceId="size_3"
        size={53.5625}
        summaryAggregationMode="none"
        valueOverride={
          '{{ JSON.parse(item).size_3.qty.toFixed(0) == "0" ? "" : JSON.parse(item).size_3.qty.toLocaleString() }}'
        }
      />
      <Column
        id="58698"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[3] || "-" }}'}
        placeholder="Enter value"
        position="center"
        referenceId="size_4"
        size={46.5625}
        summaryAggregationMode="none"
        valueOverride={
          '{{ JSON.parse(item).size_4.qty.toFixed(0) == "0" ? "" : JSON.parse(item).size_4.qty.toLocaleString() }}'
        }
      />
      <Column
        id="1a865"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[4] || "-" }}'}
        placeholder="Enter value"
        position="center"
        referenceId="size_5_per"
        size={48.890625}
        summaryAggregationMode="none"
        valueOverride={
          '{{ JSON.parse(item).size_5.qty.toFixed(0) == "0" ? "" : JSON.parse(item).size_5.qty.toLocaleString() }}'
        }
      />
      <Column
        id="b3448"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[5] || "-" }}'}
        placeholder="Enter value"
        position="center"
        referenceId="size_6"
        size={44.6875}
        summaryAggregationMode="none"
        valueOverride={
          '{{ JSON.parse(item).size_6.qty.toFixed(0) == "0" ? "" : JSON.parse(item).size_6.qty.toLocaleString() }}'
        }
      />
      <Column
        id="f5344"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[6] || "-" }}'}
        placeholder="Enter value"
        position="center"
        referenceId="size_7"
        size={39.984375}
        summaryAggregationMode="none"
        valueOverride={
          '{{ JSON.parse(item).size_7.qty.toFixed(0) == "0" ? "" : JSON.parse(item).size_7.qty.toLocaleString() }}'
        }
      />
      <Column
        id="8aa2b"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[7] || "-" }}'}
        placeholder="Enter value"
        position="center"
        referenceId="size_8"
        size={40.78125}
        summaryAggregationMode="none"
        valueOverride={
          '{{ ( JSON.parse(item)?.size_8?.qty.toFixed(0)|| "0" ) == "0" ? "" : JSON.parse(item).size_8.qty.toLocaleString() }}'
        }
      />
      <Column
        id="f2c60"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[8] || "-" }}'}
        placeholder="Enter value"
        position="center"
        referenceId="size_9"
        size={46.578125}
        summaryAggregationMode="none"
        valueOverride={
          '{{ ( JSON.parse(item)?.size_9?.qty.toFixed(0)|| "0" ) == "0" ? "" : JSON.parse(item).size_9.qty.toLocaleString() }}'
        }
      />
      <Column
        id="b2373"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[9] || "-" }}'}
        placeholder="Enter value"
        position="center"
        referenceId="size_10"
        size={44.640625}
        summaryAggregationMode="none"
        valueOverride={
          '{{ ( JSON.parse(item)?.size_10?.qty.toFixed(0)|| "0" ) == "0" ? "" : JSON.parse(item).size_10.qty.toLocaleString() }}'
        }
      />
      <Column
        id="28ba8"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[0] || "-" }}(%)'}
        placeholder="Enter value"
        position="center"
        referenceId="size_1_per"
        size={79.421875}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (JSON.parse(item).size_1.per*100).toFixed() == "0" ? "" : (JSON.parse(item).size_1.per.toFixed(2)*100).toLocaleString(0) + "%" }}'
        }
      />
      <Column
        id="921a6"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[1] || "-" }}(%)'}
        placeholder="Enter value"
        position="center"
        referenceId="size_2_per"
        size={80.21875}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (JSON.parse(item).size_2.per*100).toFixed() == "0" ? "" : (JSON.parse(item).size_2.per.toFixed(2)*100).toLocaleString(0) + "%" }}'
        }
      />
      <Column
        id="07a12"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[2] || "-" }}(%)'}
        placeholder="Enter value"
        position="center"
        referenceId="size_3_per"
        size={76.609375}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (JSON.parse(item).size_3.per*100).toFixed() == "0" ? "" : (JSON.parse(item).size_3.per.toFixed(2)*100).toLocaleString(0) + "%" }}'
        }
      />
      <Column
        id="f4779"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[3] || "-" }}(%)'}
        placeholder="Enter value"
        position="center"
        referenceId="size_4_per"
        size={71.46875}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (JSON.parse(item).size_4.per*100).toFixed() == "0" ? "" : (JSON.parse(item).size_4.per.toFixed(2)*100).toLocaleString(0) + "%" }}'
        }
      />
      <Column
        id="7de62"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[4] || "-" }}(%)'}
        placeholder="Enter value"
        position="center"
        referenceId="size_5"
        size={72.34375}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (JSON.parse(item).size_5.per*100).toFixed() == "0" ? "" : (JSON.parse(item).size_5.per.toFixed(2)*100).toLocaleString(0) + "%" }}'
        }
      />
      <Column
        id="0ee75"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[5] || "-" }}(%)'}
        placeholder="Enter value"
        position="center"
        referenceId="size_6_per"
        size={72.140625}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (JSON.parse(item).size_6.per*100).toFixed() == "0" ? "" : (JSON.parse(item).size_6.per.toFixed(2)*100).toLocaleString(0) + "%" }}'
        }
      />
      <Column
        id="cfe5c"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[6] || "-" }}(%)'}
        placeholder="Enter value"
        position="center"
        referenceId="size_7_per"
        size={67.421875}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (JSON.parse(item).size_7.per*100).toFixed() == "0" ? "" : (JSON.parse(item).size_7.per.toFixed(2)*100).toLocaleString(0) + "%" }}'
        }
      />
      <Column
        id="21463"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[7] || "-" }}(%)'}
        placeholder="Enter value"
        position="center"
        referenceId="size_8_per"
        size={63.21875}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (JSON.parse(item)?.size_8?.per*100 || 0 ).toFixed() == "0" ? "" : (JSON.parse(item).size_8.per.toFixed(2)*100).toLocaleString(0) + "%" }}'
        }
      />
      <Column
        id="c1bfd"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[8] || "-" }}(%)'}
        placeholder="Enter value"
        position="center"
        referenceId="size_9_per"
        size={69.015625}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (JSON.parse(item)?.size_9?.per*100 || 0 ).toFixed() == "0" ? "" : (JSON.parse(item).size_9.per.toFixed(2)*100).toLocaleString(0) + "%" }}'
        }
      />
      <Column
        id="f637e"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="final_assort"
        label={'{{ var_selected_size_info.value?.size_nm_list[9] || "-" }}(%)'}
        placeholder="Enter value"
        position="center"
        referenceId="size_10_per"
        size={65.09375}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (JSON.parse(item)?.size_10?.per*100 || 0 ).toFixed() == "0" ? "" : (JSON.parse(item).size_10.per.toFixed(2)*100).toLocaleString(0) + "%" }}'
        }
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="필터"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="다운로드"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          params={{
            ordered: [
              {
                options: {
                  ordered: [
                    { fileType: "xlsx" },
                    {
                      fileName:
                        "assort_list_{{moment(new Date()).format('YYYY-MM-DD')}}",
                    },
                    { includeHiddenColumns: true },
                  ],
                },
              },
            ],
          }}
          pluginId="main_items_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <ToolbarButton
        id="4d"
        icon="bold/interface-arrows-round-left"
        label="새로고침"
        type="custom"
      >
        <Event
          event="clickToolbar"
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
          pluginId="get_main_item_list"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
</Container>
