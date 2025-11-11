<Container
  id="container6"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0"
  showBody={true}
  showBorder={false}
  style={{ ordered: [{ background: "canvas" }] }}
>
  <Header>
    <Text
      id="containerTitle20"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="03c00" viewKey="View 1">
    <Text
      id="text28"
      margin="4px 12px"
      value="###### {{keyValue_item_info.data.sty_nm}} ({{ keyValue_item_info.data.sty_cd }})"
      verticalAlign="center"
    />
    <Image
      id="image1"
      fit="contain"
      heightType="fixed"
      margin="0"
      src="{{ var_main_item_info.value.img }}"
    >
      <Event
        event="click"
        method="openUrl"
        params={{ ordered: [{ url: "{{ var_main_item_info.value.img }}" }] }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Image>
    <Select
      id="select_size_type"
      data="{{ var_size_list.value }}"
      disabled="true"
      emptyMessage="No options"
      label=""
      labels="{{ item.size_type }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="사이즈"
      value="{{ var_selected_size_info.value.size_tp_nm }}"
      values="{{ item.size_type }}"
    />
    <KeyValue
      id="keyValue_item_info"
      data="{{var_main_item_info.value}}"
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="wrap"
      heightType="fixed"
      itemLabelPosition="top"
      labelWrap={true}
      margin="4px 12px"
    >
      <Property
        id="sty_nm"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="true"
        label="품명"
      />
      <Property
        id="sty_cd"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="true"
        label="품번"
      />
      <Property
        id="col_nm"
        editable="false"
        editableOptions={{}}
        format="tag"
        formatOptions={{
          automaticColors: false,
          color:
            "{{ JSON.parse(retoolContext.configVars.var_color_dict)[item] }}",
        }}
        hidden="false"
        label="컬러"
      />
      <Property
        id="cat_nm"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="복종"
      />
      <Property
        id="fabric"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="소재"
      />
      <Property
        id="preview_grade"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="등급"
      />
      <Property
        id="preview_score"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="점수"
      />
      <Property
        id="opinion"
        editable="false"
        editableOptions={{}}
        format="multilineString"
        formatOptions={{}}
        hidden="false"
        label="의견"
        valueOverride={'{{ item.replaceAll("\\n", " // ") }}'}
      />
      <Property
        id="img"
        editable="false"
        editableOptions={{}}
        format="link"
        formatOptions={{ showUnderline: "hover", underlineStyle: "solid" }}
        hidden="true"
        label="사진"
      />
      <Property
        id="col_cd"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="true"
        label="Col cd"
      />
      <Property
        id="lot"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="true"
        label="Lot"
      />
      <Property
        id="small_cat"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="소분류(복종명)"
      />
    </KeyValue>
    <Spacer id="spacer1" />
    <NumberInput
      id="lot_qty"
      currency="USD"
      disabled={
        '{{ md_assort_control.selectedItem.value == "qty" ? true : false }}'
      }
      hidden=""
      inputValue={0}
      label="Lot #"
      labelPosition="top"
      margin="4px 4px 4px 0"
      placeholder="Enter value"
      showSeparators={true}
      showStepper={true}
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd]?.final_check ?? false ? get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].final_lot : 
  get_lot_by_color.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_lot_by_color.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].lot }}
"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="set_md_qty"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </NumberInput>
    <Include src="./container_assort_input.rsx" />
    <Text
      id="text23"
      horizontalAlign="center"
      style={{
        ordered: [
          {
            color:
              '{{ ((size_1_per.value + size_2_per.value + size_3_per.value + size_4_per.value + size_5_per.value + size_6_per.value + size_7_per.value + size_8_per.value + size_9_per.value + size_10_per.value )*100).toFixed(0) != 100 ? "red": "#0D0D0D" }}',
          },
        ],
      }}
      value="{{ (100*(size_1_per.value + size_2_per.value + size_3_per.value + size_4_per.value + size_5_per.value + size_6_per.value + size_7_per.value + size_8_per.value + size_9_per.value + size_10_per.value)).toFixed(0) }}%"
      verticalAlign="center"
    />
  </View>
</Container>
