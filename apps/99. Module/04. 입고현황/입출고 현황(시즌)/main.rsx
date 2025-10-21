<App>
  <Include src="./functions.rsx" />
  <GlobalWidgetProp id="brand_code" description="브랜드 코드" value="'07'" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <GlobalWidgetProp
    id="yongpum_brand_code"
    description="용품 브랜드 코드"
    value={"\"'02','01'\""}
  />
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
      brand_code="'07'"
      isGlobalWidgetContainer={true}
      selected_category="'999'"
      selected_season="'S1'"
      yongpum_brand_code={"\"'02','01'\""}
    >
      <Include src="./src/container_sidebar.rsx" />
      <Text
        id="text2"
        style={{
          ordered: [
            { fontSize: "15px" },
            { fontWeight: "600" },
            { fontFamily: "pretendard variable" },
          ],
        }}
        value="[입고현황 요약]"
        verticalAlign="center"
      />
      <Table
        id="table1"
        autoColumnWidth={true}
        cellSelection="none"
        clearChangesetOnSave={true}
        data="[
{'구분': '컬러 수',
'총계': {{get_item_list.data.length }},
'입고예정일 없음':{{ get_item_list.data.filter(i => i.in_state === '입고예정일 없음').length }},
'미입고':{{ get_item_list.data.filter(i => i.in_state === '미입고').length }},
'입고':{{ get_item_list.data.filter(i => i.in_state === '입고').length }},
'미출고': {{ get_item_list.data.filter(i => i.in_state === '입고').length - get_item_list.data.filter(i => i.out_state === '출고').length }},
'출고': {{ get_item_list.data.filter(i => i.out_state === '출고').length }}
},
  {'구분': '비중',
'총계': '{{(get_item_list.data.length/get_item_list.data.length * 100).toFixed(0) }}%',
'입고예정일 없음':'{{ (get_item_list.data.filter(i => i.in_state === '입고예정일 없음').length/get_item_list.data.length *100).toFixed(2) }}%',
'미입고':'{{ (get_item_list.data.filter(i => i.in_state === '미입고').length/get_item_list.data.length*100).toFixed(2) }}%',
'입고':'{{ (get_item_list.data.filter(i => i.in_state === '입고').length/get_item_list.data.length * 100).toFixed(2) }}%',
'미출고': '{{ ((get_item_list.data.filter(i => i.in_state === '입고').length - get_item_list.data.filter(i => i.out_state === '출고').length)/get_item_list.data.length * 100).toFixed(2) }}%',
'출고': '{{ (get_item_list.data.filter(i => i.out_state === '출고').length/get_item_list.data.length * 100).toFixed(2) }}%'
}
]"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        emptyMessage="No rows found"
        enableSaveActions={true}
        heightType="auto"
        rowHeight="small"
        rowSelection="none"
        showBorder={true}
        showHeader={true}
        style={{ headerBackground: "tokens/356f4e7b" }}
        toolbarPosition="bottom"
      >
        <Column
          id="3b50a"
          alignment="left"
          format="markdown"
          groupAggregationMode="none"
          key="구분"
          label="구분"
          placeholder="Enter value"
          position="left"
          size={50.328125}
          sortMode="disabled"
          summaryAggregationMode="none"
          valueOverride="**{{ item }}**"
        />
        <Column
          id="f4d55"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="총계"
          label="총계"
          placeholder="Enter value"
          position="center"
          size={46.328125}
          summaryAggregationMode="none"
        />
        <Column
          id="40b24"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          key="입고예정일 없음"
          label="입고예정일 없음"
          placeholder="Enter value"
          position="center"
          size={92.03125}
          summaryAggregationMode="none"
        />
        <Column
          id="76a1b"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          key="미입고"
          label="미입고"
          placeholder="Enter value"
          position="center"
          size={50.9375}
          summaryAggregationMode="none"
        />
        <Column
          id="bd525"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="입고"
          label="입고"
          placeholder="Enter value"
          position="center"
          size={55.75}
          summaryAggregationMode="none"
        />
        <Column
          id="b189c"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="미출고"
          label="미출고"
          placeholder="Enter value"
          position="center"
          size={50.9375}
          summaryAggregationMode="none"
        />
        <Column
          id="f00d2"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="출고"
          label="출고"
          placeholder="Enter value"
          position="center"
          size={55.75}
          summaryAggregationMode="none"
        />
      </Table>
      <Text
        id="text3"
        style={{
          ordered: [
            { fontSize: "15px" },
            { fontWeight: "600" },
            { fontFamily: "pretendard variable" },
          ],
        }}
        value="[아이템 리스트]"
        verticalAlign="center"
      />
      <Table
        id="item_list"
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ get_item_list.data }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        dynamicRowHeights={true}
        emptyMessage="상품이 없습니다"
        enableSaveActions={true}
        linkedFilterId=""
        rowBackgroundColor=""
        rowHeight="small"
        searchTerm="{{search_text.value}}"
        showBorder={true}
        showFooter={true}
        showHeader={true}
      >
        <Column
          id="a232f"
          alignment="center"
          format="image"
          formatOptions={{ widthType: "fit" }}
          groupAggregationMode="none"
          label="제품사진"
          placeholder="Enter value"
          position="left"
          referenceId="item_image"
          size={71}
          summaryAggregationMode="none"
          valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg"
        />
        <Column
          id="2d821"
          alignment="center"
          caption="{{ currentSourceRow.sty_cd }}"
          editable={false}
          format="string"
          groupAggregationMode="none"
          key="sty_cd"
          label="품명"
          placeholder="Enter value"
          position="left"
          size={147.1875}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.sty_nm}}"
        />
        <Column
          id="06437"
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
          position="left"
          size={98.828125}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="7a6a4"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="plan_qty"
          label="기획수량"
          placeholder="Enter value"
          position="center"
          size={76.515625}
          summaryAggregationMode="none"
          tooltip="기획수량"
        />
        <Column
          id="a182e"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="tot_in_qty"
          label="입고수량"
          placeholder="Enter value"
          position="center"
          size={57.515625}
          summaryAggregationMode="none"
          tooltip="누적입고수량"
        />
        <Column
          id="625e6"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="{{ radioGroup1.value === 'out' }}"
          key="shortfall_qty"
          label="미입고량"
          placeholder="Enter value"
          position="center"
          size={68.515625}
          summaryAggregationMode="none"
          valueOverride={
            '{{ currentSourceRow.shortfall_qty <= 0 ? "입고완료": currentSourceRow.shortfall_qty }}'
          }
        />
        <Column
          id="8f900"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="average"
          hidden="{{ radioGroup1.value === 'out' }}"
          key="in_rate"
          label="입고율"
          placeholder="Enter value"
          position="center"
          size={61.0625}
          summaryAggregationMode="none"
        />
        <Column
          id="a715b"
          alignment="left"
          cellTooltip="{{ item }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="progress"
          formatOptions={{
            min: 0,
            max: "100",
            positiveTrend: "99",
            negativeTrend: "90",
          }}
          groupAggregationMode="average"
          hidden="{{ radioGroup1.value === 'out' }}"
          key="in_rate"
          placeholder="Enter value"
          position="center"
          size={54.140625}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.in_rate * 100 }}"
        />
        <Column
          id="9d191"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="tag"
          formatOptions={{
            automaticColors: false,
            icon: "{{ item === '미입고' ?  \"/icon:bold/interface-alert-warning-triangle-alternate\" : ''}}",
            color:
              "{{ item === '미입고' ?  '#FF8A8A' : \nitem === '입고'?'#CFF0CC':'#9DAFD7'}}",
          }}
          groupAggregationMode="sum"
          hidden="{{ radioGroup1.value === 'out' }}"
          key="in_state"
          label="입고현황"
          placeholder="Select option"
          position="center"
          size={113.03125}
          summaryAggregationMode="none"
        />
        <Column
          id="95447"
          alignment="center"
          format="string"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="{{ radioGroup1.value === 'out' }}"
          key="delay_state"
          label="입고 지연 여부"
          placeholder="Enter value"
          position="center"
          size={116}
          summaryAggregationMode="none"
          textColor="{{ item === '지연'  ? '#D9381E' : '#000000' }}"
        />
        <Column
          id="d21fb"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="lead_time"
          label="리드타임(일)"
          placeholder="Enter value"
          position="center"
          size={76.59375}
          summaryAggregationMode="none"
        />
        <Column
          id="484ce"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="{{ radioGroup1.value === 'out' }}"
          key="delay_days"
          label="입고 지연 일수"
          placeholder="Enter value"
          position="center"
          referenceId="delay_days"
          size={101}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow.delay_days <= 0 ? null : currentSourceRow.delay_days}}"
        />
        <Column
          id="02ba0"
          alignment="center"
          format="string"
          groupAggregationMode="none"
          hidden="{{ radioGroup1.value === 'out' }}"
          key="deli_dt"
          label="납기일"
          placeholder="Enter value"
          position="center"
          size={89.234375}
          summaryAggregationMode="none"
          tooltip="입고예정일"
        />
        <Column
          id="4d6c2"
          alignment="center"
          format="string"
          groupAggregationMode="none"
          hidden="{{ radioGroup1.value === 'out' }}"
          key="fin_dt"
          label="초입고일"
          placeholder="Enter value"
          position="center"
          size={89.234375}
          summaryAggregationMode="none"
          tooltip="최초입고일"
        />
        <Column
          id="b1d55"
          alignment="center"
          format="string"
          groupAggregationMode="none"
          hidden="{{ radioGroup1.value === 'out' }}"
          key="ord_dt"
          label="발주일자"
          placeholder="Enter value"
          position="center"
          size={89.234375}
          summaryAggregationMode="none"
        />
        <Column
          id="437fe"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="ord"
          label="Ord"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
        />
        <Column
          id="1fbb9"
          alignment="center"
          format="tag"
          formatOptions={{
            automaticColors: false,
            color:
              "{{ item === '미출고' ?  '#FF8A8A' : \nitem === '출고'?'#CFF0CC':'#9DAFD7'}}",
            icon: "{{ item === '미출고' ?  \"/icon:bold/interface-alert-warning-triangle-alternate\" : ''}}",
          }}
          groupAggregationMode="none"
          hidden="{{ radioGroup1.value === 'in' }}"
          key="out_state"
          label="출고현황"
          placeholder="Select option"
          position="center"
          referenceId="out_state"
          size={91}
          summaryAggregationMode="none"
        />
        <Column
          id="41e19"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="{{ radioGroup1.value === 'in' }}"
          key="tot_out_qty"
          label="출고수량"
          placeholder="Enter value"
          position="center"
          size={81}
          summaryAggregationMode="none"
        />
        <Column
          id="57ceb"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="average"
          key="out_rate"
          label="출고율"
          placeholder="Enter value"
          position="center"
          size={62}
          summaryAggregationMode="none"
        />
        <Column
          id="e6a86"
          alignment="left"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="progress"
          formatOptions={{
            min: 0,
            max: "1",
            positiveTrend: "1",
            negativeTrend: "0.59",
          }}
          groupAggregationMode="average"
          key="out_rate"
          placeholder="Enter value"
          position="center"
          referenceId="tot_out_rate"
          size={68}
          summaryAggregationMode="none"
        />
        <Column
          id="55b0f"
          alignment="center"
          format="date"
          formatOptions={{ dateFormat: "yyyy-MM-dd" }}
          groupAggregationMode="none"
          hidden="{{ radioGroup1.value === 'in' }}"
          key="fwrk_dt"
          label="초출고일"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
        />
        <Column
          id="67331"
          alignment="center"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="cust_nm"
          label="생산업체"
          placeholder="Select option"
          position="center"
          size={135.796875}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="36fef"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          placeholder="Enter value"
          position="center"
          size={16}
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
                      { includeHiddenColumns: false },
                      {
                        fileName:
                          "[{{select_item_type.selectedLabel }}/{{ season_select.selectedLabel }}]{{ text1.value.slice(6) }}",
                      },
                    ],
                  },
                },
              ],
            }}
            pluginId="item_list"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </ToolbarButton>
        <Event
          event="clickRow"
          method="setValue"
          params={{ ordered: [{ value: "{{currentSourceRow}}" }] }}
          pluginId="var_sel_sty_info"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="clickRow"
          method="show"
          params={{ ordered: [] }}
          pluginId="drawerFrame_item_detail_new"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </Table>
    </ModuleContainerWidget>
  </Frame>
</App>
