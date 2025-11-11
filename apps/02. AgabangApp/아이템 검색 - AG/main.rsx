<App>
  <Include src="./functions.rsx" />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrame1.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    style={{ ordered: [{ canvas: "surfacePrimary" }] }}
    type="main"
  >
    <Image
      id="image1"
      fit="contain"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      src="https://agabang-image.s3.ap-northeast-2.amazonaws.com/logo/agabang_logo.png"
    />
    <TextInput
      id="search_text"
      iconAfter="bold/interface-search"
      label=""
      labelPosition="top"
      margin="0"
      placeholder="품명, 품번으로 아이템을 검색해보세요"
      showClear={true}
      style={{ ordered: [{ borderRadius: "16px" }] }}
    />
    <Table
      id="table1"
      actionsOverflowPosition={1}
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ item_filtering.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="검색한 아이템이 없습니다"
      enableSaveActions={true}
      hidden="{{ search_text.value ? false : true }}"
      margin="0px 18px 4px 18px"
      rowBackgroundColor=""
      rowHeight="large"
      rowSelection="none"
      toolbarPosition="bottom"
    >
      <Column
        id="d4541"
        alignment="center"
        format="image"
        formatOptions={{
          icon: '{{ item === "success" ? "/icon:bold/interface-validation-check-circle" : "/icon:bold/interface-alert-warning-circle" }}',
          widthType: "fit",
        }}
        groupAggregationMode="none"
        hidden="false"
        label="제품사진"
        placeholder="Enter value"
        position="center"
        referenceId="제품사진"
        size={57.484375}
        summaryAggregationMode="none"
        valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{ currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg"
      />
      <Column
        id="4e0c1"
        alignment="center"
        caption="{{ currentSourceRow.sty_cd }}"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="품명"
        placeholder="Enter value"
        position="center"
        size={130.078125}
      />
      <Column
        id="2336c"
        alignment="left"
        caption="{{ currentSourceRow.sty_cd }}"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="sty_cd"
        label="Sty cd"
        placeholder="Enter value"
        position="center"
        size={0}
      />
      <Column
        id="2bdb2"
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
        size={0}
      />
      <Column
        id="44960"
        alignment="center"
        format="tag"
        formatOptions={{
          automaticColors: false,
          color:
            "{{ JSON.parse(retoolContext.configVars.var_color_dict)[item] }}",
        }}
        groupAggregationMode="none"
        key="col_nm"
        label="Col nm"
        placeholder="Select option"
        position="center"
        size={80.25}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="b430f"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="full_text"
        label="Full text"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <Action
        id="e7063"
        icon="bold/interface-link-circle-alternate"
        label="아이템 상세"
      >
        <Event
          event="clickAction"
          method="show"
          params={{ ordered: [] }}
          pluginId="modalFrame1"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickAction"
          method="setValue"
          params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
          pluginId="var_item_info"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
      </Action>
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="modalFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="var_item_info"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</App>
