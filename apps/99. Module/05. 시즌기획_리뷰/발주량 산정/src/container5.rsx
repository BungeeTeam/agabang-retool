<Container
  id="container5"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
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
    <Include src="./container7.rsx" />
    <Table
      id="main_items_table"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_main_item_list.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      rowHeight="large"
      searchTerm="{{ main_items_tableSearchFilter.value }}"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="ac2b2"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="tag"
        formatOptions={{
          automaticColors: false,
          color:
            '{{ get_assort.data[currentSourceRow.sty_cd + currentSourceRow.col_cd] == null ? "" :  get_assort.data[currentSourceRow.sty_cd + currentSourceRow.col_cd].final_check == true ? "orange": "" }}',
        }}
        groupAggregationMode="sum"
        label="#LOT"
        placeholder="Select option"
        position="center"
        referenceId="lot"
        size={64}
        summaryAggregationMode="none"
        valueOverride={
          '{{ get_assort.data[currentSourceRow.sty_cd + currentSourceRow.col_cd] == null ? "" : get_assort.data[currentSourceRow.sty_cd + currentSourceRow.col_cd].final_check == false ? get_assort.data[currentSourceRow.sty_cd + currentSourceRow.col_cd].lot : get_assort.data[currentSourceRow.sty_cd + currentSourceRow.col_cd].final_lot  }}'
        }
      />
      <Column
        id="cdfa9"
        alignment="center"
        format="image"
        formatOptions={{ widthType: "fit" }}
        groupAggregationMode="none"
        label="사진"
        placeholder="Enter value"
        position="center"
        referenceId="img"
        size={59}
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
        position="center"
        size={97.34375}
        summaryAggregationMode="none"
      />
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
        size={85.84375}
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
        size={52.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="80f23"
        alignment="left"
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
        size={97.40625}
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
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="31ab0"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="small_cat"
        label="소분류"
        placeholder="Select option"
        position="center"
        size={83}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="c76d6"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="preview_grade"
        label="품평등급"
        placeholder="Select option"
        position="center"
        size={61}
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
        label="품평점수"
        placeholder="Enter value"
        position="center"
        size={59}
        summaryAggregationMode="none"
      />
      <Column
        id="7d74e"
        alignment="left"
        cellTooltipMode="overflow"
        format="multilineString"
        groupAggregationMode="none"
        key="opinion"
        label="품평의견"
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
          pluginId="main_items_table"
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
          pluginId="main_items_table"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="selectRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentRow }}" }] }}
        pluginId="var_main_item_info"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="selectRow"
        method="setValue"
        params={{
          ordered: [
            {
              value:
                "{{ get_assort.data[currentRow.sty_cd + currentRow.col_cd] == null ? [] : get_assort.data[currentRow.sty_cd + currentRow.col_cd].related_items }}",
            },
          ],
        }}
        pluginId="var_selected_related_items"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Container
      id="container8"
      disabled=""
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      hidden="true"
      padding="12px"
      showBody="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] != null }}"
      style={{ ordered: [{ background: "canvas" }, { border: "warning" }] }}
    >
      <Header>
        <Text
          id="containerTitle23"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="6c73f" viewKey="View 1">
        <Text
          id="text26"
          margin="0"
          value={
            '{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].final_check == false ? "##### ❗ 최종 결정 대기중" : "##### ✅ 최종 결정완료"  }}'
          }
          verticalAlign="center"
        />
        <NumberInput
          id="lot_qty_final"
          currency="USD"
          disabled="true"
          inputValue={0}
          label="Lot #"
          labelPosition="top"
          margin="4px 4px 4px 0"
          placeholder="Enter value"
          showSeparators={true}
          showStepper={true}
          value="{{ size_1_qty2.value + size_2_qty2.value + size_3_qty2.value + size_4_qty2.value + size_5_qty2.value + size_6_qty2.value + size_7_qty2.value + size_8_qty2.value + size_9_qty2.value + size_10_qty2.value }}"
        />
        <Include src="./container_assort_input_final.rsx" />
      </View>
    </Container>
    <Container
      id="container_qty_prod"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      heightType="fixed"
      margin="0"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle1"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="7e07a" viewKey="View 1">
        <ListViewBeta
          id="gridView_items"
          _primaryKeys="{{ i }}"
          data="{{ get_item_list.data }}"
          heightType="auto"
          itemWidth="200px"
          layoutType="grid"
          margin="0"
          maxHeight="100vh"
          numColumns="1"
          padding="0"
        >
          <Include src="./container_item.rsx" />
        </ListViewBeta>
      </View>
    </Container>
  </View>
</Container>
