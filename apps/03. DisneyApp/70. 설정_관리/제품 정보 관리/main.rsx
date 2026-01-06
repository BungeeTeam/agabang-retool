<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css="" />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrame_bulk_edit.rsx" />
  <Include src="./src/modalFrame_production_upload.rsx" />
  <Include src="./src/modalFrameTutorial.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Include src="./src/container1.rsx" />
    <Table
      id="item_table2"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ query_get_info.data.filter(item => multiselect1.value.includes(item.year_season_cd)
) }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="150a1"
      rowHeight="medium"
      rowSelection="none"
      searchMode="caseInsensitive"
      searchTerm="{{search_text.value}}"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Include src="./src/item_table2ExpandedRow.rsx" />
      <Column
        id="150a1"
        alignment="right"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="false"
        key="id"
        label="ID"
        placeholder="Enter value"
        position="left"
        size={58.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="46f4d"
        alignment="center"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="sty_cd"
        label="품번(sty_cd)"
        placeholder="Enter value"
        position="left"
        size={85.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="8f6de"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="스타일명(sty_nm)"
        placeholder="Enter value"
        position="left"
        size={112.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="650c5"
        alignment="center"
        editable="false"
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="preview_cd"
        label="품평번호"
        position="center"
        size={110.78125}
        summaryAggregationMode="none"
        tooltip="품평회에서 부여한 코드를 입력하세요."
      />
      <Column
        id="7fe06"
        alignment="center"
        editable={false}
        format="string"
        groupAggregationMode="none"
        key="year_season"
        label="강제시즌할당"
        placeholder="Enter value"
        position="center"
        size={78.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="4e557"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sale_price"
        label="판가"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="5ed35"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sale_price_final"
        label="판가검토"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="4ebc5"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="cost_price"
        label="사전원가(v-,원)"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="e2afe"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="cost_price_final"
        label="확정원가(v-,원)"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="6ea3b"
        alignment="center"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="status"
        label="상태(status)"
        position="center"
        size={80.46875}
        summaryAggregationMode="none"
        tooltip="'SPOT, 영업, 리오더, 단종' 등 이 스타일의 특징이나 상태를 입력하세요."
      />
      <Column
        id="8a015"
        alignment="center"
        editable="false"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="true"
        key="cat_nm"
        label="카테고리(cat_nm)"
        optionList={{
          mode: "mapped",
          mappedData: "{{ variable1.value }}",
          valueByIndex: "{{ item.keywords }}",
          labelByIndex: "",
          colorByIndex: "{{ item.colors }}",
        }}
        placeholder="카테고리를 선택하세요"
        position="center"
        referenceId="cat_nm"
        size={107.46875}
        summaryAggregationMode="none"
        tooltip="ERP 코드보다 더 세분화된 MD팀 자체 카테고리를 입력할 수 있습니다.

여기에 입력한 카테고리는 엑셀 자동 생성이나 BI에 반영됩니다."
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="aed02"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="category_name"
        label="카테고리명(category_name)"
        placeholder="Enter value"
        position="center"
        size={163.390625}
        summaryAggregationMode="none"
      />
      <Column
        id="47f52"
        alignment="left"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: false }}
        groupAggregationMode="none"
        key="item_raw_nm"
        label="아이템(item_raw_nm)"
        optionList={{
          mode: "mapped",
          mappedData: "{{ var_item_list.value }}",
          valueByIndex: "{{ item }}",
          labelByIndex: "{{ item }}",
        }}
        placeholder="Enter value"
        position="center"
        size={130.765625}
        summaryAggregationMode="none"
        tooltip="각 아이템의 세부적인 분류를 추가합니다."
      />
      <Column
        id="1bc2c"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="concept"
        label="컨셉(concept)"
        placeholder="Enter value"
        position="center"
        size={91.703125}
        summaryAggregationMode="none"
      />
      <Column
        id="8f1bf"
        alignment="center"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="sex_nm"
        label="성별(sex_nm)"
        position="center"
        size={88.4375}
        summaryAggregationMode="none"
        tooltip="성별 구분이 필요한 상품의 경우, 코드를 입력하세요.

U: 남여공용
G: 여아용
B: 남아용"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="0718b"
        alignment="center"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="fabric"
        label="소재(fabric)"
        position="center"
        size={77.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="25bc9"
        alignment="center"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="prod_comp"
        label="생산처(prod_comp)"
        position="center"
        size={119.453125}
        summaryAggregationMode="none"
      />
      <Column
        id="aaf82"
        alignment="center"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="prod_country"
        label="생산국가(prod_country)"
        position="center"
        size={141.796875}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="91a4b"
        alignment="center"
        editable="false"
        format="date"
        formatOptions={{ dateFormat: "yyyy-MM-dd" }}
        groupAggregationMode="none"
        key="deli_dt"
        label="납기일(deli_dt)"
        position="center"
        size={93.671875}
        summaryAggregationMode="none"
      />
      <Column
        id="01897"
        alignment="center"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="designer_nm"
        label="디자이너(designer_nm)"
        position="center"
        size={138.984375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="f810c"
        alignment="right"
        editable="false"
        format="rating"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          size: "small",
          icons: "hearts",
        }}
        groupAggregationMode="sum"
        key="preview_score"
        label="품평 점수(preview_score)"
        placeholder="Enter value"
        position="center"
        size={157.125}
        statusIndicatorOptions={{
          manualData: [
            {
              ordered: [
                { showWhen: "{{item > 0}}" },
                { label: "{{item.toFixed(2)}}" },
                { icon: "" },
                { color: "rgba(255, 255, 255, 0.01)" },
                { tooltip: "" },
              ],
            },
          ],
        }}
        summaryAggregationMode="none"
      />
      <Column
        id="14e88"
        alignment="center"
        editable="false"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="preview_grade"
        label="품평 등급(preview_grade)"
        position="center"
        size={152.609375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="f31ac"
        alignment="left"
        cellTooltipMode="overflow"
        editable="false"
        format="multilineString"
        groupAggregationMode="none"
        key="opinion"
        label="품평의견(opinion)"
        position="center"
        size={165.671875}
        summaryAggregationMode="none"
      />
      <Column
        id="fe833"
        alignment="center"
        backgroundColor="{{ theme.highlight }}"
        editable="true"
        editableOptions={{ alwaysShowCheckboxes: true }}
        format="boolean"
        groupAggregationMode="none"
        key="colab_yn"
        label="콜라보여부(colab_yn)"
        placeholder="Enter value"
        position="center"
        size={125.6875}
        summaryAggregationMode="none"
        tooltip="이 제품이 콜라보 제품인지 표시합니다.

콜라보 제품인 경우 'TRUE'를, 아닌 경우 'FALSE'를 입력하세요.

콜라보 제품으로 지정되면 '아이템 차트' 엑셀 파일에서 별도의 파일로 집계되며,

Best & Worst 파일과 메뉴에서 무시즌 상품으로 처리됩니다."
      />
      <Column
        id="0f285"
        alignment="center"
        backgroundColor="{{ theme.highlight }}"
        editable="true"
        format="string"
        groupAggregationMode="none"
        key="colab_nm"
        label="콜라보명(colab_nm)"
        position="center"
        size={120.546875}
        summaryAggregationMode="none"
        tooltip="콜라보 상품인 경우, 콜라보 명칭을 입력하세요.

이 콜라보명에 따라 아이템 차트 등 파일 생성 시 자동 처리됩니다."
      />
      <Column
        id="fa46b"
        alignment="left"
        backgroundColor="{{ theme.highlight }}"
        editable="true"
        format="string"
        groupAggregationMode="none"
        key="memo"
        label="메모(memo)"
        position="center"
        size={80.46875}
        summaryAggregationMode="none"
        tooltip="이 스타일에 대한 각종 메모를 남길 수 있습니다."
      />
      <Column
        id="2eedd"
        alignment="center"
        backgroundColor="{{ theme.highlight }}"
        editable="true"
        editableOptions={{ alwaysShowCheckboxes: false }}
        format="boolean"
        groupAggregationMode="none"
        key="stat_exclude_yn"
        label="통계제외(stat_exclude_yn)"
        placeholder="Enter value"
        position="center"
        size={155.546875}
        summaryAggregationMode="none"
        tooltip="이 값이 TRUE인 경우, BEST & WORST 등 리포트에서 제외됩니다.

사은품으로 주로 제공되는 제품을 통계에서 제외할 수 있습니다."
      />
      <Column
        id="0e11c"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="color_1_nm"
        label="칼라1(color_1_nm)"
        placeholder="Enter value"
        position="center"
        size={118.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="50a27"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="color_1_qty"
        label="칼라1수량(color_1_qty)"
        placeholder="Enter value"
        position="center"
        size={139.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="4f9aa"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="color_2_nm"
        label="칼라2(color_2_nm)"
        placeholder="Enter value"
        position="center"
        size={118.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="21d54"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="color_2_qty"
        label="칼라2수량(color_2_qty)"
        placeholder="Enter value"
        position="center"
        size={139.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="1420b"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="color_3_nm"
        label="칼라3(color_3_nm)"
        placeholder="Enter value"
        position="center"
        size={118.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="2b6e1"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="color_3_qty"
        label="칼라3수량(color_3_qty)"
        placeholder="Enter value"
        position="center"
        size={139.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="972b1"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="color_4_nm"
        label="칼라4(color_4_nm)"
        placeholder="Enter value"
        position="center"
        size={118.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="f446c"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="color_4_qty"
        label="칼라4수량(color_4_qty)"
        placeholder="Enter value"
        position="center"
        size={139.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="838cb"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="color_5_nm"
        label="칼라5(color_5_nm)"
        placeholder="Enter value"
        position="center"
        size={118.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="21ecb"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="color_5_qty"
        label="칼라5수량(color_5_qty)"
        placeholder="Enter value"
        position="center"
        size={139.28125}
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
          pluginId="item_table2"
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
          pluginId="item_table2"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="save"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="update_changes"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</App>
