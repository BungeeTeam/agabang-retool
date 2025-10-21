<App>
  <Include src="./functions.rsx" />
  <GlobalWidgetProp id="brand_code" description="브랜드코드" value="01" />
  <Include src="./src/drawerFrame_item_detail_new.rsx" />
  <Include src="./src/drawerFrame1.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <ModuleContainerWidget
      id="moduleContainer"
      backgroundColor="white"
      brand_code="01"
      isGlobalWidgetContainer={true}
    >
      <Include src="./src/container_sidebar.rsx" />
      <Table
        id="day_in_table"
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ get_day_in_data.data }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        margin="0px 8px"
        rowHeight="medium"
        searchTerm="{{ search_box.value }}"
        showBorder={true}
        showFooter={true}
        showHeader={true}
      >
        <Column
          id="7fd7a"
          alignment="center"
          format="date"
          formatOptions={{ dateFormat: "yyyy-MM-dd" }}
          groupAggregationMode="none"
          key="in_dt"
          label="입고일"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
        />
        <Column
          id="db1a8"
          alignment="center"
          format="image"
          formatOptions={{ widthType: "fit" }}
          groupAggregationMode="none"
          key="sty_cd"
          label="이미지"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
          valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg"
        />
        <Column
          id="1c942"
          alignment="center"
          caption="{{ currentSourceRow.sty_cd }}"
          format="string"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="sty_nm"
          label="스타일명"
          placeholder="Enter value"
          position="center"
          size={183}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="a100f"
          alignment="center"
          format="tag"
          formatOptions={{
            automaticColors: false,
            color:
              "{{ JSON.parse(retoolContext.configVars.var_color_dict)[item] }}",
          }}
          groupAggregationMode="none"
          key="col_nm"
          label="컬러명"
          placeholder="Select option"
          position="center"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="efa6c"
          alignment="center"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="size_nm"
          label="사이즈 이름"
          placeholder="Select option"
          position="center"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="fc436"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="in_qty"
          label="입고수량"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
        />
        <Column
          id="7b9cc"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="tot_in_qty"
          label="누적입고수량"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
        />
        <Column
          id="6f04c"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="tot_sale_qty"
          label="누적 판매수량"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
        />
        <Column
          id="a6e82"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          key="sale_per"
          label="누적 판매율"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
        />
        <Column
          id="dc7d9"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          placeholder="Enter value"
          position="center"
          referenceId="spacer"
          size={100}
          summaryAggregationMode="none"
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
          label="엑셀 다운로드"
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
                      { fileName: "일간 입고 현황" },
                    ],
                  },
                },
              ],
            }}
            pluginId="day_in_table"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </ToolbarButton>
        <Event
          event="clickRow"
          method="show"
          params={{ ordered: [] }}
          pluginId="drawerFrame_item_detail_new"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickRow"
          method="setValue"
          params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
          pluginId="var_sel_sty"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickRow"
          method={null}
          params={{ ordered: [] }}
          pluginId=""
          type="state"
          waitMs="0"
          waitType="debounce"
        />
      </Table>
    </ModuleContainerWidget>
  </Frame>
</App>
