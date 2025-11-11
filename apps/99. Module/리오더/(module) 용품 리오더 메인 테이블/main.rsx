<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <GlobalWidgetProp id="var_brand_code" value="01" />
  <Include src="./src/drawerFrame1.rsx" />
  <Include src="./src/modalFrame1.rsx" />
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
      var_brand_code="01"
    >
      <Container
        id="stack3"
        _align="center"
        _gap="0px"
        _justify="space-between"
        _type="stack"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        margin="0"
        padding="0"
        showBody={true}
        showBorder={false}
        style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
      >
        <View id="ff9f4" viewKey="View 1">
          <Include src="./src/stack1.rsx" />
          <Container
            id="stack2"
            _align="center"
            _gap="0px"
            _justify="end"
            _type="stack"
            footerPadding="4px 12px"
            headerPadding="4px 12px"
            padding="0"
            showBody={true}
            showBorder={false}
            style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
          >
            <View id="e69fb" viewKey="View 1">
              <Text
                id="selectedrows_count"
                horizontalAlign="right"
                style={{ ordered: [] }}
                value="**선택한 {{selectedReorderItems.value?.length || 0}}개 아이템**"
                verticalAlign="center"
              />
              <Button
                id="btn_reorder_simulation2"
                disabled="{{ selectedReorderItems.value?.length == 0 }}"
                heightType="auto"
                horizontalAlign="right"
                style={{ ordered: [] }}
                text="단종 처리"
              >
                <Event
                  event="click"
                  method="trigger"
                  params={{ ordered: [] }}
                  pluginId="bulkDiscontinueItems"
                  type="datasource"
                  waitMs="0"
                  waitType="debounce"
                />
                <Event
                  event="click"
                  method="showNotification"
                  params={{
                    ordered: [
                      {
                        options: {
                          ordered: [
                            { notificationType: "success" },
                            {
                              title:
                                "{{getSelectedItems.data?.count || 0}}건을 단종 처리했습니다!",
                            },
                            {
                              description:
                                "이제 이 아이템들은 리오더 점검 대상에서 제외할게요.",
                            },
                            { duration: "10" },
                          ],
                        },
                      },
                    ],
                  }}
                  pluginId=""
                  type="util"
                  waitMs="0"
                  waitType="debounce"
                />
              </Button>
              <Button
                id="btn_reorder_simulation"
                disabled="{{ selectedReorderItems.value?.length == 0 }}"
                heightType="auto"
                hidden="true"
                horizontalAlign="right"
                style={{ ordered: [] }}
                text="리오더 시뮬레이션"
              >
                <Event
                  event="click"
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
                  pluginId="insertReorderSimulationTargets"
                  type="datasource"
                  waitMs="0"
                  waitType="debounce"
                />
                <Event
                  event="click"
                  method="openUrl"
                  params={{
                    ordered: [
                      {
                        url: "{{ \n  var_brand_code.value === '01' \n  ? 'https://agabang.cleave.work/app/reorder_simulation_seasonless_agabang' \n  : var_brand_code.value === '07' \n    ? 'https://agabang.cleave.work/app/reorder_simulation_seasonless_ettoi'\n    : ''\n}}",
                      },
                    ],
                  }}
                  pluginId=""
                  type="util"
                  waitMs="0"
                  waitType="debounce"
                />
              </Button>
              <Button
                id="btn_reorder_simulation3"
                disabled="{{ selectedReorderItems.value?.length == 0 }}"
                heightType="auto"
                horizontalAlign="right"
                style={{ ordered: [] }}
                text="생산 데이터 요청 & 시뮬레이션"
              >
                <Event
                  event="click"
                  method="show"
                  params={{ ordered: [] }}
                  pluginId="modalFrame1"
                  type="widget"
                  waitMs="0"
                  waitType="debounce"
                />
              </Button>
            </View>
          </Container>
        </View>
      </Container>
      <Module
        id="itemDetail2"
        brand_code="'01'"
        margin="0"
        name="item_detail"
        pageUuid="17be4764-ecd2-11ef-8654-fbc4f3e414ec"
        sel_sty="{{clicked_item_sty_cd.value}}"
      />
      <SegmentedControl
        id="sel_category3"
        data=""
        disabledByIndex=""
        iconByIndex=""
        iconPositionByIndex=""
        itemMode="static"
        label=""
        labelPosition="top"
        labels=""
        paddingType="spacious"
        style={{
          ordered: [
            { background: "rgb(255, 255, 255)" },
            { border: "canvas" },
            { indicatorBackground: "primary" },
          ],
        }}
        value={'"긴급"'}
        values=""
      >
        <Option
          id="3b1af"
          disabled={false}
          iconPosition="left"
          label="전체: {{ table_main_list.data.filter(item => item.wh_reorder_recommending_status && item.wh_reorder_recommending_status.includes('')).length }}개"
          value={'{{ "" }}'}
        />
        <Option
          id="2c769"
          disabled={false}
          iconPosition="left"
          label="🔴 긴급: {{ table_main_list.data.filter(item => item.wh_reorder_recommending_status && item.wh_reorder_recommending_status.includes('긴급')).length }}개"
          value="긴급"
        />
        <Option
          id="42845"
          disabled={false}
          iconPosition="left"
          label="🟡 주의: {{ table_main_list.data.filter(item => item.wh_reorder_recommending_status && item.wh_reorder_recommending_status.includes('주의')).length }}개"
          value="주의"
        />
        <Option
          id="43c91"
          disabled={false}
          iconPosition="left"
          label="🟢 양호: {{ table_main_list.data.filter(item => item.wh_reorder_recommending_status && item.wh_reorder_recommending_status.includes('양호')).length }}개"
          value="양호"
        />
        <Event
          event="change"
          method="setFilter"
          params={{
            ordered: [
              {
                filter: {
                  ordered: [
                    { id: "{{ self.id }}" },
                    { columnId: "wh_reorder_recommending_status" },
                    { operator: "includes" },
                    { value: "{{ self.value }}" },
                  ],
                },
              },
            ],
          }}
          pluginId="table_main_list"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </SegmentedControl>
      <Table
        id="table_main_list"
        alwaysShowRowSelectionCheckboxes={true}
        cellSelection="none"
        clearChangesetOnSave={true}
        data="{{ getColorList.data }}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        defaultSort={[]}
        emptyMessage={
          '{{ get_item_list.isFetching === true? "⏳ 조회 중입니다...":"조회된 내역이 없습니다." }}'
        }
        groupedColumnConfig={{ expandByDefault: false, size: 115.203125 }}
        rowBackgroundColor=""
        rowHeight="large"
        rowSelection="multiple"
        searchTerm="{{ textInput1.value }}"
        showBorder={true}
        showColumnBorders={true}
        showFooter={true}
        showHeader={true}
        style={{}}
        toolbarPosition="bottom"
      >
        <Include src="./src/table_main_listExpandedRow.rsx" />
        <Column
          id="53bce"
          alignment="right"
          format="string"
          formatOptions={{
            automaticColors: false,
            color:
              "{{currentSourceRow.reorder_recommending_status && currentSourceRow.reorder_recommending_status.includes('긴급 🔴') ? '#FFCCCC' : \n  currentSourceRow.reorder_recommending_status && currentSourceRow.reorder_recommending_status.includes('주의 🟡') ? '#FFFFCC' : \n  currentSourceRow.reorder_recommending_status && currentSourceRow.reorder_recommending_status.includes('양호 🟢') ? '#CCFFCC' : ''}}",
          }}
          groupAggregationMode="none"
          hidden="true"
          key="reorder_recommending_status"
          label="리오더 판단"
          placeholder="Enter value"
          position="left"
          size={71.28125}
          textColor="#000000"
          valueOverride="{{ item }}"
        />
        <Column
          id="38069"
          alignment="center"
          format="string"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="reorder_recommending_status"
          label="판단(아이콘)"
          placeholder="Enter value"
          position="left"
          referenceId="reorder_recommending_status_brief"
          size={76.59375}
          valueOverride="{{currentSourceRow.reorder_recommending_status.substring(3)}}"
        />
        <Column
          id="c6fdf"
          alignment="center"
          backgroundColor="{{ 
  currentSourceRow.wh_reorder_recommending_status.substring(0, 2) === '긴급' ? '#ffcccc' : 
  currentSourceRow.wh_reorder_recommending_status.substring(0, 2) === '주의' ? '#fff3cd' : 
  '#cce5cc' 
}}"
          cellTooltip="창고재고를 기준으로 아래 3가지 중 하나라도 긴급/주의가 있으면 알려드려요.

{{
  `- 최근 30일 기준: ${currentSourceRow.wh_status_d30 || '-'} (월판매량 ${Math.round(Number(currentSourceRow.avg_monthly_sales_d30) || 0)}개 | 재고 소진까지 D-${Math.round(Number(currentSourceRow.whDaysUntilOutOfStock_d30) || 0)})
- 최근 6개월 기준: ${currentSourceRow.wh_status_d180 || '-'} (월판매량 ${Math.round(Number(currentSourceRow.avg_monthly_sales_d180) || 0)}개 | 재고 소진까지 D-${Math.round(Number(currentSourceRow.whDaysUntilOutOfStock_d180) || 0)})
- 최근 1년 기준: ${currentSourceRow.wh_status_d365 || '-'} (월판매량 ${Math.round(Number(currentSourceRow.avg_monthly_sales_d365) || 0)}개 | 재고 소진까지 D-${Math.round(Number(currentSourceRow.whDaysUntilOutOfStock_d365) || 0)})`
}}"
          cellTooltipMode="custom"
          format="string"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="wh_reorder_recommending_status"
          label="창고 기준 판단"
          placeholder="Enter value"
          position="left"
          size={85.03125}
          summaryAggregationMode="none"
          textColor="{{currentSourceRow.wh_reorder_recommending_status.substring(0, 2) === '긴급' ? '#8b0000' : 
  currentSourceRow.wh_reorder_recommending_status.substring(0, 2) === '주의' ? '#8a5a00' : 
  '#006400'}}"
          valueOverride="{{currentSourceRow.wh_reorder_recommending_status.substring(0, 2)}}"
        />
        <Column
          id="ac04d"
          alignment="center"
          backgroundColor="{{ 
  currentSourceRow.reorder_recommending_status.substring(0, 2) === '긴급' ? '#ffcccc' : 
  currentSourceRow.reorder_recommending_status.substring(0, 2) === '주의' ? '#fff3cd' : 
  '#cce5cc' 
}}"
          cellTooltip="총재고를 기준으로 아래 3가지 중 하나라도 긴급/주의가 있으면 알려드려요.

{{

  `- 최근 30일 기준: ${currentSourceRow.status_d30 || '-'} (월판매량 ${Math.round(Number(currentSourceRow.avg_monthly_sales_d30) || 0)}개 | 재고 소진까지 D-${Math.round(Number(currentSourceRow.daysUntilOutOfStock_d30) || 0)})

- 최근 6개월 기준: ${currentSourceRow.status_d180 || '-'} (월판매량 ${Math.round(Number(currentSourceRow.avg_monthly_sales_d180) || 0)}개 | 재고 소진까지 D-${Math.round(Number(currentSourceRow.daysUntilOutOfStock_d180) || 0)})

- 최근 1년 기준: ${currentSourceRow.status_d365 || '-'} (월판매량 ${Math.round(Number(currentSourceRow.avg_monthly_sales_d365) || 0)}개 | 재고 소진까지 D-${Math.round(Number(currentSourceRow.daysUntilOutOfStock_d365) || 0)})`

}}"
          cellTooltipMode="custom"
          format="string"
          formatOptions={{ automaticColors: false, color: "" }}
          groupAggregationMode="none"
          hidden="false"
          key="reorder_recommending_status"
          label="총재고 기준 판단"
          placeholder="Enter value"
          position="left"
          referenceId="tkd"
          size={95.40625}
          summaryAggregationMode="none"
          textColor="{{currentSourceRow.reorder_recommending_status.substring(0, 2) === '긴급' ? '#8b0000' : 
  currentSourceRow.reorder_recommending_status.substring(0, 2) === '주의' ? '#8a5a00' : 
  '#006400'}}"
          valueOverride="{{currentSourceRow.reorder_recommending_status.substring(0, 2)}}"
        />
        <Column
          id="5d4e6"
          alignment="center"
          format="image"
          formatOptions={{ widthType: "fit" }}
          groupAggregationMode="none"
          label="이미지"
          placeholder="Enter value"
          position="left"
          referenceId="이미지"
          size={63.140625}
          summaryAggregationMode="none"
          valueOverride="{{
  currentSourceRow.col_cd ? 
    `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${currentSourceRow.sty_cd}${currentSourceRow.col_cd}.jpg` : 
    `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${currentSourceRow.sty_cd}.jpg`
}}"
        >
          <Event
            event="clickCell"
            method="openUrl"
            params={{
              ordered: [
                {
                  url: "https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg",
                },
              ],
            }}
            pluginId=""
            type="util"
            waitMs="0"
            waitType="debounce"
          />
        </Column>
        <Column
          id="cf4c6"
          alignment="center"
          caption="{{ currentSourceRow.sty_cd}}{{ currentSourceRow.col_cd }}"
          editable="false"
          format="multilineString"
          groupAggregationMode="none"
          key="sty_nm"
          label="품명(스타일명)"
          placeholder="Enter value"
          position="left"
          size={189.296875}
          summaryAggregationMode="none"
        >
          <Event
            event="clickCell"
            method="show"
            params={{ ordered: [] }}
            pluginId="drawerFrame1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="clickCell"
            method="setValue"
            params={{ ordered: [{ value: "{{ currentSourceRow}}" }] }}
            pluginId="clicked_item_sty_cd"
            type="state"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="clickCell"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="get_discontinued_products"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Column>
        <Column
          id="49582"
          alignment="left"
          editable="true"
          editableOptions={{ alwaysShowCheckboxes: true }}
          format="button"
          formatOptions={{ variant: "outline", disabled: "" }}
          groupAggregationMode="none"
          hidden="true"
          key="is_discontinued"
          label="단종"
          placeholder="Enter value"
          position="left"
          size={53.015625}
        >
          <Event
            event="clickCell"
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
            pluginId="discontinuedProductsQuery"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="clickCell"
            method="showNotification"
            params={{
              ordered: [
                {
                  options: {
                    ordered: [
                      { notificationType: "success" },
                      {
                        title:
                          "단종 처리: {{ currentSourceRow.sty_nm }}({{ currentSourceRow.col_nm }})",
                      },
                      {
                        description:
                          "이제 이 아이템은 리오더 점검에서 제외됩니다.",
                      },
                    ],
                  },
                },
              ],
            }}
            pluginId=""
            type="util"
            waitMs="0"
            waitType="debounce"
          />
        </Column>
        <Column
          id="7b017"
          alignment="center"
          format="button"
          formatOptions={{ variant: "solid" }}
          groupAggregationMode="none"
          hidden="true"
          label="의사결정"
          placeholder="Enter value"
          position="left"
          referenceId="처리"
          size={65.515625}
          valueOverride="처리하기"
        >
          <Event
            event="clickCell"
            method="show"
            pluginId="modal_individual_simulation"
            type="widget"
            waitMs={0}
            waitType="debounce"
          />
          <Event
            event="clickCell"
            method="setValue"
            params={{ ordered: [{ value: "{{ currentSourceRow.sty_cd }}" }] }}
            pluginId="clicked_item_sty_cd"
            type="state"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="clickCell"
            method="setValue"
            params={{ ordered: [{ value: "{{ currentSourceRow.col_cd }}" }] }}
            pluginId="reorder_target_col_cd"
            type="state"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="clickCell"
            method="setValue"
            params={{
              ordered: [
                {
                  value:
                    "{{ currentSourceRow.sty_nm }}{{ currentSourceRow.col_nm }}",
                },
              ],
            }}
            pluginId="reorder_target_nm"
            type="state"
            waitMs="0"
            waitType="debounce"
          />
        </Column>
        <Column
          id="7347f"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="sum"
          hidden="true"
          key="size_nm"
          label="사이즈명"
          placeholder="Enter value"
          position="left"
          size={57.515625}
        />
        <Column
          id="84f82"
          alignment="center"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="it_gb_nm"
          label="중분류"
          placeholder="Select option"
          position="center"
          size={92.84375}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="8f74c"
          alignment="center"
          format="string"
          groupAggregationMode="none"
          hidden="false"
          key="br_nm"
          label="브랜드명"
          placeholder="Enter value"
          position="center"
          size={67.90625}
          summaryAggregationMode="none"
        />
        <Column
          id="e759a"
          alignment="center"
          editable="false"
          format="string"
          groupAggregationMode="none"
          hidden="false"
          key="sty_cd"
          label="품번"
          placeholder="Enter value"
          position="center"
          size={104.984375}
          summaryAggregationMode="none"
        />
        <Column
          id="2c59a"
          alignment="center"
          format="tag"
          formatOptions={{
            automaticColors: false,
            color:
              "{{ JSON.parse(retoolContext.configVars.var_color_dict)[item] }}",
          }}
          groupAggregationMode="none"
          hidden="false"
          key="col_nm"
          label="컬러명"
          placeholder="Select option"
          position="center"
          size={113.1875}
          summaryAggregationMode="none"
          valueOverride="{{item}}"
        />
        <Column
          id="f4b3a"
          alignment="center"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="item_nm"
          label="소분류"
          placeholder="Select option"
          position="center"
          size={134.140625}
          summaryAggregationMode="none"
          valueOverride="{{item}}"
        />
        <Column
          id="8d947"
          alignment="center"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="series_name"
          label="시리즈명"
          placeholder="Select option"
          position="center"
          referenceId="series_name"
          size={57.515625}
          summaryAggregationMode="none"
        />
        <Column
          id="f83d7"
          alignment="center"
          format="string"
          groupAggregationMode="none"
          key="cust_nm"
          label="제조사명"
          placeholder="Enter value"
          position="center"
          size={94.96875}
          summaryAggregationMode="none"
        />
        <Column
          id="5175f"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          hidden="true"
          key="fabric"
          label="소재"
          placeholder="Enter value"
          position="center"
          size={36.765625}
          summaryAggregationMode="none"
        />
        <Column
          id="430b5"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="tag_price"
          label="Tag가"
          placeholder="Enter value"
          position="center"
          size={78.859375}
        />
        <Column
          id="92b62"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="cost_price"
          label="원가"
          placeholder="Enter value"
          position="center"
          size={73.5625}
        />
        <Column
          id="4e062"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "2",
          }}
          groupAggregationMode="sum"
          key="price_multiple"
          label="배수"
          placeholder="Enter value"
          position="center"
          size={69.171875}
          summaryAggregationMode="none"
        />
        <Column
          id="395e5"
          alignment="center"
          format="date"
          formatOptions={{ dateFormat: "yyyy-MM-dd" }}
          groupAggregationMode="none"
          key="first_outbound_date"
          label="첫 출고일"
          placeholder="Enter value"
          position="center"
          size={117.15625}
          summaryAggregationMode="none"
        />
        <Column
          id="ab000"
          alignment="left"
          format="date"
          formatOptions={{ dateFormat: "yyyy-MM-dd" }}
          groupAggregationMode="none"
          hidden="true"
          key="first_inventory_date"
          label="첫 입고일"
          placeholder="Enter value"
          position="center"
          size={60.890625}
          summaryAggregationMode="none"
        />
        <Column
          id="6cfc6"
          alignment="left"
          editable="false"
          format="date"
          formatOptions={{ dateFormat: "yyyy-MM-dd" }}
          groupAggregationMode="none"
          hidden="true"
          key="last_inventory_date"
          label="마지막 입고일"
          placeholder="Enter value"
          position="center"
          size={81.65625}
          summaryAggregationMode="none"
        />
        <Column
          id="853ac"
          alignment="left"
          format="date"
          formatOptions={{ dateFormat: "yyyy-MM-dd" }}
          groupAggregationMode="none"
          hidden="true"
          key="first_sales_dt"
          label="첫 판매일"
          placeholder="Enter value"
          position="center"
          size={85.6875}
          summaryAggregationMode="none"
        />
        <Column
          id="d3998"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          hidden="true"
          key="last_sales_dt"
          label="마지막 판매일"
          placeholder="Enter value"
          position="center"
          size={85.828125}
          summaryAggregationMode="none"
        >
          <Event
            event="clickCell"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="getSizeList"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Column>
        <Column
          id="76458"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="tot_in_qty"
          label="총 입고량"
          placeholder="Enter value"
          position="center"
          size={60.890625}
        />
        <Column
          id="63459"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="tot_sale_qty"
          label="총 판매량"
          placeholder="Enter value"
          position="center"
          size={60.890625}
        />
        <Column
          id="cb2f0"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="average"
          key="sale_rate"
          label="누계 판매율"
          placeholder="Enter value"
          position="center"
          size={71.28125}
        />
        <Column
          id="0b389"
          alignment="right"
          cellTooltip="{{ item }}"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="current_stock_qty"
          label="총재고"
          placeholder="Enter value"
          position="center"
          size={57.140625}
          summaryAggregationMode="none"
          tooltip="=총입고량-총판매량+업체재고

(드물게 불량 반품 등의 이유로 인해 매장재고+창고재고+업체재고와 값이 다른 경우도 있습니다.)"
        />
        <Column
          id="ae9dd"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="false"
          key="sh_stck_qty"
          label="매장재고"
          placeholder="Enter value"
          position="center"
          size={69.515625}
          summaryAggregationMode="none"
        />
        <Column
          id="5fcd1"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="false"
          key="wh_stck_qty"
          label="창고재고"
          placeholder="Enter value"
          position="center"
          size={71.515625}
          summaryAggregationMode="none"
        />
        <Column
          id="1219c"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="manufacturer_color_stock"
          label="업체재고"
          placeholder="Enter value"
          position="center"
          referenceId="manufacturer_stock"
          size={70.515625}
          summaryAggregationMode="none"
        />
        <Column
          id="8d16e"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="total_reorder_count"
          label="과거 리오더 횟수"
          placeholder="Enter value"
          position="center"
          size={95.40625}
          summaryAggregationMode="none"
          tooltip="첫 입고를 제외하고, 해당 아이템이 50개 이상 입고된 일자 수"
        />
        <Column
          id="adc0b"
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
          id="8590f"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="size_cd"
          label="Size cd"
          placeholder="Enter value"
          position="center"
          size={57.3125}
        />
        <Column
          id="903fc"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          hidden="true"
          key="cust_cd"
          label="Cust cd"
          placeholder="Enter value"
          position="center"
          size={59.859375}
          summaryAggregationMode="none"
        />
        <Column
          id="fd0fb"
          alignment="left"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="_type"
          label="Type"
          placeholder="Select option"
          position="center"
          size={73.546875}
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="c8c05"
          alignment="right"
          cellTooltip="- 소분류: {{currentSourceRow.item_nm}}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="false"
          key="lead_time_days"
          label="리드타임"
          placeholder="Enter value"
          position="center"
          size={73.515625}
          summaryAggregationMode="none"
          tooltip="해당 아이템이 속한 소분류의 생산 리드타임 (일 단위)"
        />
        <Column
          id="4bd67"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="avg_monthly_sales_d30"
          label="Avg monthly sales d 30"
          placeholder="Enter value"
          position="center"
          size={148.015625}
          summaryAggregationMode="none"
        />
        <Column
          id="70104"
          alignment="right"
          cellTooltip="참고:
- 최근 30일 월판매량: {{ currentSourceRow.avg_monthly_sales_d30.toFixed(1) }}
- 최근 180일 월판매량: {{ currentSourceRow.avg_monthly_sales_d180.toFixed(1) }}
- 최근 365일 월판매량: {{ currentSourceRow.avg_monthly_sales_d365.toFixed(1) }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="false"
          key="avg_monthly_sales_d180"
          label="월 판매량"
          placeholder="Enter value"
          position="left"
          size={72.359375}
          summaryAggregationMode="none"
          tooltip="최근 180일 기준 월평균 판매량입니다.
※ 신규 상품(판매 180일 미만)은 실제 판매 기간의 일평균 판매량을 월 기준으로 환산하여 표시합니다."
          valueOverride="{{ item.toFixed(1) }}"
        />
        <Column
          id="5aa37"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="avg_monthly_sales_d365"
          label="Avg monthly sales d 365"
          placeholder="Enter value"
          position="center"
          size={155.296875}
          summaryAggregationMode="none"
        />
        <Column
          id="8da6b"
          alignment="right"
          cellTooltip="총재고 - 리드타임({{ currentSourceRow.lead_time_days}}일) 동안의 예상 판매량
= {{currentSourceRow.current_stock_qty}} - {{Math.round(currentSourceRow.expected_sales)}}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          hidden="false"
          key="estimated_stock"
          label="예상 재고"
          placeholder="Enter value"
          position="center"
          size={71.890625}
          summaryAggregationMode="none"
          tooltip="리드타임(소분류별로 상이) 동안 판매될 예상 수량을 고려하여 남을 것으로 예상되는 재고"
        />
        <Column
          id="5d428"
          alignment="right"
          cellTooltip="- 소분류: {{currentSourceRow.item_nm}}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="false"
          key="moq"
          label="MOQ"
          placeholder="Enter value"
          position="center"
          size={62.9375}
          summaryAggregationMode="none"
          tooltip="해당 아이템이 속한 소분류의 MOQ 수량"
        />
        <Column
          id="7110b"
          alignment="right"
          cellTooltip="(전체 기간 예상 판매량 + 비상 재고 - 현재고) ÷ 목표 판매율
= ({{currentSourceRow.expected_sales_full_period}} + {{currentSourceRow.emergency_stock}} - {{currentSourceRow.current_stock_qty}}) ÷ {{currentSourceRow.target_sale_rate}}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="recommended_reorder_qty"
          label="필요 수량"
          placeholder="Enter value"
          position="center"
          size={60.890625}
          summaryAggregationMode="none"
          tooltip="MOQ는 아직 고려하지 않고,리오더 필요한 수량을 계산한 값

=(전체 기간 예상 판매량 + 비상 재고 - 현재고) ÷ 목표 판매율"
        />
        <Column
          id="527d6"
          alignment="right"
          cellTooltip="- 리오더 필요 수량: {{Math.round(currentSourceRow.recommended_reorder_qty)}}
- MOQ: {{ currentSourceRow.moq }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="final_reorder_qty"
          label="추천 수량"
          placeholder="Enter value"
          position="center"
          size={60.890625}
          summaryAggregationMode="none"
          tooltip="필요 수량과 최소 주문 수량(MOQ) 중 큰 값"
        />
        <Column
          id="405f7"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          hidden="true"
          key="groupId"
          label="Group ID"
          placeholder="Enter value"
          position="center"
          size={100.9375}
        />
        <Column
          id="739c2"
          alignment="left"
          format="boolean"
          groupAggregationMode="none"
          hidden="true"
          key="_isExpanded"
          label="Is expanded"
          placeholder="Enter value"
          position="center"
          size={85.109375}
        />
        <Column
          id="d545f"
          alignment="left"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="large_cat"
          label="Large cat"
          placeholder="Select option"
          position="center"
          size={69.28125}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="b697d"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          hidden="true"
          key="middle_cat"
          label="Middle cat"
          placeholder="Enter value"
          position="center"
          size={75.453125}
        />
        <Column
          id="99866"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          hidden="true"
          key="small_cat"
          label="Small cat"
          placeholder="Enter value"
          position="center"
          size={67.75}
        />
        <Column
          id="dad07"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          hidden="true"
          key="item_image"
          label="Item image"
          placeholder="Enter value"
          position="center"
          size={78.609375}
        />
        <Column
          id="ff2f1"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="urgentCount"
          label="Urgent count"
          placeholder="Enter value"
          position="center"
          size={90.4375}
        />
        <Column
          id="3d430"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="warningCount"
          label="Warning count"
          placeholder="Enter value"
          position="center"
          size={97.796875}
        />
        <Column
          id="6fa31"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="daysUntilOutOfStock_d30"
          label="Days until out of stock d 30"
          placeholder="Enter value"
          position="center"
          size={171.9375}
        />
        <Column
          id="bd22f"
          alignment="right"
          backgroundColor={
            "{{ \n  item < currentSourceRow.lead_time_days ? '#ffcccc' : \"\" \n}}"
          }
          cellTooltip="창고재고÷(최근 180일 월평균 판매량÷30)
= {{currentSourceRow.wh_stck_qty}}÷({{currentSourceRow.avg_monthly_sales_d180}}÷30)"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          hidden="false"
          key="whDaysUntilOutOfStock_d180"
          label="창고재고 예상 소진일수 (최근 180일 기준)"
          placeholder="Enter value"
          position="center"
          size={96.734375}
          summaryAggregationMode="none"
          tooltip="창고재고가 모두 소진될 때까지 예상되는 일수.
잔여 창고재고와 최근 180일 월판량을 기준으로 예상 소진일수를 계산합니다.

리드타임보다 예상 소진일수가 짧으면 빨간색으로 색칠해서 보여드려요."
        />
        <Column
          id="e3af2"
          alignment="right"
          backgroundColor={
            "{{ \n  item < currentSourceRow.lead_time_days ? '#ffcccc' : \"\" \n}}"
          }
          cellTooltip="현재 총재고÷(최근 180일 월평균 판매량÷30)
= {{currentSourceRow.current_stock_qty}}÷({{currentSourceRow.avg_monthly_sales_d180}}÷30)"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          hidden="false"
          key="daysUntilOutOfStock_d180"
          label="총재고 예상 소진일수 (최근 180일 기준)"
          placeholder="Enter value"
          position="center"
          size={101.359375}
          summaryAggregationMode="none"
          tooltip="모든 재고가 소진될 때까지 예상되는 일수.
잔여 총재고와 최근 180일 판매량을 기준으로 예상 소진일수를 계산합니다.

리드타임보다 예상 소진일수가 짧으면 빨간색으로 색칠해서 보여드려요."
        />
        <Column
          id="cbb34"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="daysUntilOutOfStock_d365"
          label="Days until out of stock d 365"
          placeholder="Enter value"
          position="center"
          size={179.203125}
        />
        <Column
          id="0c659"
          alignment="left"
          caption="- 월판량: {{ currentSourceRow.avg_monthly_sales_d30.toFixed(0) }}
- 소진: D-{{currentSourceRow.whDaysUntilOutOfStock_d30.toFixed(0)}}"
          format="multilineString"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="wh_status_d30"
          label="최근 30일&창고재고 기준"
          placeholder="Enter value"
          position="center"
          size={138.984375}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="e598d"
          alignment="left"
          caption="- 월판량: {{ currentSourceRow.avg_monthly_sales_d180.toFixed(0) }}
- 소진: D-{{currentSourceRow.whDaysUntilOutOfStock_d180.toFixed(0)}}"
          format="multilineString"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="wh_status_d180"
          label="최근 180일&창고재고 기준"
          placeholder="Enter value"
          position="center"
          size={144.3125}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="d84d0"
          alignment="left"
          caption="- 월판량: {{ currentSourceRow.avg_monthly_sales_d365.toFixed(0) }}
- 소진: D-{{currentSourceRow.whDaysUntilOutOfStock_d365.toFixed(0)}}"
          format="multilineString"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="wh_status_d365"
          label="최근 365일&창고재고 기준"
          placeholder="Enter value"
          position="center"
          size={146.25}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="50824"
          alignment="left"
          caption="- 월판량: {{ currentSourceRow.avg_monthly_sales_d30.toFixed(0) }}
- 소진: D-{{currentSourceRow.daysUntilOutOfStock_d30.toFixed(0)}}"
          format="multilineString"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="status_d30"
          label="최근 30일&총재고 기준"
          placeholder="Enter value"
          position="center"
          size={128.59375}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="7268c"
          alignment="left"
          caption="- 월판량: {{ currentSourceRow.avg_monthly_sales_d180.toFixed(0) }}
- 소진: D-{{currentSourceRow.daysUntilOutOfStock_d180.toFixed(0)}}"
          format="multilineString"
          formatOptions={{
            automaticColors: false,
            color:
              "{{currentSourceRow.status_d180 && currentSourceRow.status_d180.includes('긴급 🔴') ? '#FFCCCC' : \n  currentSourceRow.status_d180 && currentSourceRow.status_d180.includes('주의 🟡') ? '#FFFFCC' : \n  currentSourceRow.status_d180 && currentSourceRow.status_d180.includes('양호 🟢') ? '#CCFFCC' : ''}}",
          }}
          groupAggregationMode="none"
          hidden="true"
          key="status_d180"
          label="최근 180일&총재고 기준"
          placeholder="Enter value"
          position="center"
          size={133.9375}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="84ccc"
          alignment="left"
          caption="- 월판량: {{ currentSourceRow.avg_monthly_sales_d365.toFixed(0) }}
- 소진: D-{{currentSourceRow.daysUntilOutOfStock_d365.toFixed(0)}}"
          format="multilineString"
          formatOptions={{
            automaticColors: false,
            color:
              "{{currentSourceRow.status_d365 && currentSourceRow.status_d365.includes('긴급 🔴') ? '#FFCCCC' : \n  currentSourceRow.status_d365 && currentSourceRow.status_d365.includes('주의 🟡') ? '#FFFFCC' : \n  currentSourceRow.status_d365 && currentSourceRow.status_d365.includes('양호 🟢') ? '#CCFFCC' : ''}}",
          }}
          groupAggregationMode="none"
          hidden="true"
          key="status_d365"
          label="최근 365일&총재고 기준"
          placeholder="Enter value"
          position="center"
          size={135.875}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="e26ae"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          key="target_sale_rate"
          label="Target sale rate"
          placeholder="Enter value"
          position="center"
          size={104.65625}
          summaryAggregationMode="none"
        />
        <Column
          id="4523c"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="emergency_stock"
          label="Emergency stock"
          placeholder="Enter value"
          position="center"
          size={113.890625}
          summaryAggregationMode="none"
        />
        <Column
          id="f1ca2"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="effective_monthly_sales"
          label="Effective monthly sales"
          placeholder="Enter value"
          position="center"
          size={147.515625}
          summaryAggregationMode="none"
        />
        <Column
          id="7c597"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="expected_sales"
          label="Expected sales"
          placeholder="Enter value"
          position="center"
          size={101.90625}
          summaryAggregationMode="none"
        />
        <Column
          id="f1393"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="expected_sales_full_period"
          label="Expected sales full period"
          placeholder="Enter value"
          position="center"
          size={161.875}
          summaryAggregationMode="none"
        />
        <Column
          id="cc7e6"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="expected_sales_period_months"
          label="Expected sales period months"
          placeholder="Enter value"
          position="center"
          size={187.359375}
          summaryAggregationMode="none"
        />
        <Column
          id="5201d"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          hidden="true"
          key="whDaysUntilOutOfStock_d30"
          label="최근 30일&창고 기준 소진일수"
          placeholder="Enter value"
          position="center"
          size={163.109375}
          summaryAggregationMode="none"
        />
        <Column
          id="343ea"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          hidden="true"
          key="whDaysUntilOutOfStock_d365"
          label="최근 365일&창고 기준 소진일수"
          placeholder="Enter value"
          position="center"
          size={170.390625}
          summaryAggregationMode="none"
        />
        <Column
          id="d8d3c"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="whUrgentCount"
          label="Wh urgent count"
          placeholder="Enter value"
          position="center"
          size={110.359375}
          summaryAggregationMode="none"
        />
        <Column
          id="f17f5"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="whWarningCount"
          label="Wh warning count"
          placeholder="Enter value"
          position="center"
          size={118.625}
          summaryAggregationMode="none"
        />
        <Column
          id="56cff"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_1_sale_qty"
          label="{{(() => {
  const now = new Date();
  const thisMonth = new Date(now.getFullYear(), now.getMonth(), 1);
  const year = thisMonth.getFullYear().toString().substring(2);
  const month = thisMonth.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}} "
          placeholder="Enter value"
          position="center"
          size={114.609375}
          statusIndicatorOptions={{
            manualData: [
              {
                ordered: [
                  {
                    showWhen:
                      "{{ currentSourceRow.month_1_sale_qty >= currentRow.month_2_sale_qty }}",
                  },
                  {
                    label:
                      "{{\n  (() => {\n    const currentMonth = Number(currentSourceRow.month_1_sale_qty) || 0;\n    const lastMonth = Number(currentSourceRow.month_2_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastMonth === 0) {\n      if (currentMonth === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"New\";  // 전월이 0일 때는 이번 달 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentMonth - lastMonth) / lastMonth) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
                  },
                  { color: "#D7EAE0" },
                  { icon: "bold/interface-arrows-up" },
                ],
              },
              {
                ordered: [
                  {
                    showWhen:
                      "{{ currentSourceRow.month_1_sale_qty < currentSourceRow.month_2_sale_qty }}",
                  },
                  {
                    label:
                      "{{\n  (() => {\n    const currentMonth = Number(currentSourceRow.month_1_sale_qty) || 0;\n    const lastMonth = Number(currentSourceRow.month_2_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastMonth === 0) {\n      if (currentMonth === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"New\";  // 전월이 0일 때는 이번 달 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentMonth - lastMonth) / lastMonth) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
                  },
                  { color: "#F8DBD8" },
                  { icon: "bold/interface-arrows-down" },
                ],
              },
            ],
          }}
          summaryAggregationMode="none"
          tooltip="이번 달 판매량입니다.
전월 대비 증감도 함께 보여드려요.

전월 대비 증감율 = ((이번 달 판매량 - 전월 판매량) / 전월 판매량) * 100"
        />
        <Column
          id="3c79b"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_2_sale_qty"
          label="{{(() => {
  const now = new Date();
  const oneMonthAgo = new Date(now.getFullYear(), now.getMonth() - 1, 1);
  const year = oneMonthAgo.getFullYear().toString().substring(2);
  const month = oneMonthAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={111.609375}
          statusIndicatorOptions={{
            manualData: [
              {
                ordered: [
                  {
                    showWhen: "{{ item >= currentSourceRow.month_3_sale_qty }}",
                  },
                  {
                    label:
                      "{{\n  (() => {\n    const currentMonth = Number(currentSourceRow.month_2_sale_qty) || 0;\n    const lastMonth = Number(currentSourceRow.month_3_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastMonth === 0) {\n      if (currentMonth === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"New\";  // 전월이 0일 때는 이번 달 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentMonth - lastMonth) / lastMonth) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
                  },
                  { color: "#D7EAE0" },
                  { icon: "bold/interface-arrows-up" },
                ],
              },
              {
                ordered: [
                  {
                    showWhen: "{{ item < currentSourceRow.month_3_sale_qty }}",
                  },
                  {
                    label:
                      "{{\n  (() => {\n    const currentMonth = Number(currentSourceRow.month_2_sale_qty) || 0;\n    const lastMonth = Number(currentSourceRow.month_3_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastMonth === 0) {\n      if (currentMonth === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"New\";  // 전월이 0일 때는 이번 달 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentMonth - lastMonth) / lastMonth) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
                  },
                  { color: "#F8DBD8" },
                  { icon: "bold/interface-arrows-down" },
                ],
              },
            ],
          }}
          summaryAggregationMode="none"
          tooltip="지난 달 판매량입니다.
전월 대비 증감도 함께 보여드려요.

증감율 = ((지난 달 판매량 - 지지난 달 판매량) / 지난 달 판매량) * 100"
        />
        <Column
          id="cc904"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_3_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 2, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={62.390625}
          summaryAggregationMode="none"
        />
        <Column
          id="cdf4d"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_4_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 3, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={62.328125}
          summaryAggregationMode="none"
        />
        <Column
          id="f78be"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_5_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 4, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={61.953125}
          summaryAggregationMode="none"
        />
        <Column
          id="4eade"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_6_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 5, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={60.265625}
          summaryAggregationMode="none"
        />
        <Column
          id="aea00"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_7_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 6, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={67.75}
          summaryAggregationMode="none"
        />
        <Column
          id="2a252"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_8_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 7, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={66.0625}
          summaryAggregationMode="none"
        />
        <Column
          id="c13b7"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_9_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 8, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={67.984375}
          summaryAggregationMode="none"
        />
        <Column
          id="a6664"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_10_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 9, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={62.390625}
          summaryAggregationMode="none"
        />
        <Column
          id="b632e"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_11_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 10, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={62.3125}
          summaryAggregationMode="none"
        />
        <Column
          id="2828f"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_12_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 11, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={61.765625}
          summaryAggregationMode="none"
        />
        <Column
          id="57c37"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_13_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 12, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          referenceId="month_13_sale_qty"
          size={62.390625}
          summaryAggregationMode="none"
        />
        <Column
          id="be52b"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          hidden="true"
          key="recent_6month_avg_sale_qty"
          label="최근 6개월 평균 판매량"
          placeholder="Enter value"
          position="center"
          size={127.03125}
          summaryAggregationMode="none"
        />
        <Column
          id="7afc1"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          hidden="true"
          key="recent_12month_avg_sale_qty"
          label="최근 12개월 평균 판매량"
          placeholder="Enter value"
          position="center"
          size={132.375}
          summaryAggregationMode="none"
        />
        <Column
          id="5809d"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="manufacturer_total_stock"
          label="Manufacturer total stock"
          placeholder="Enter value"
          position="center"
          size={155.234375}
          summaryAggregationMode="none"
        />
        <Column
          id="6446e"
          alignment="left"
          cellTooltipMode="overflow"
          format="tags"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="manufacturer_stock_details"
          label="Manufacturer stock details"
          placeholder="Select options"
          position="center"
          size={167.328125}
          summaryAggregationMode="none"
        />
        <Column
          id="9bc72"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="bufferDays_d30"
          label="Buffer days d 30"
          placeholder="Enter value"
          position="center"
          size={110.265625}
          summaryAggregationMode="none"
        />
        <Column
          id="845d6"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="bufferDays_d180"
          label="Buffer days d 180"
          placeholder="Enter value"
          position="center"
          size={115.59375}
          summaryAggregationMode="none"
        />
        <Column
          id="47d7a"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="bufferDays_d365"
          label="Buffer days d 365"
          placeholder="Enter value"
          position="center"
          size={117.546875}
          summaryAggregationMode="none"
        />
        <Column
          id="bad2f"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="whBufferDays_d30"
          label="Wh buffer days d 30"
          placeholder="Enter value"
          position="center"
          size={131.75}
          summaryAggregationMode="none"
        />
        <Column
          id="168a1"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          key="whBufferDays_d180"
          label="Wh buffer days d 180"
          placeholder="Enter value"
          position="center"
          size={137.09375}
          summaryAggregationMode="none"
        />
        <Column
          id="ce7d4"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="whBufferDays_d365"
          label="Wh buffer days d 365"
          placeholder="Enter value"
          position="center"
          size={139.03125}
          summaryAggregationMode="none"
        />
        <Column
          id="4ae52"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="item"
          label="Item"
          placeholder="Enter value"
          position="center"
          size={40.890625}
          summaryAggregationMode="none"
        />
        <Column
          id="437ec"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_14_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 13, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={63}
          summaryAggregationMode="none"
        />
        <Column
          id="2d559"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_15_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 14, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={63}
          summaryAggregationMode="none"
        />
        <Column
          id="e518b"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_16_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 15, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={63}
          summaryAggregationMode="none"
        />
        <Column
          id="0d705"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_17_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 16, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={62}
          summaryAggregationMode="none"
        />
        <Column
          id="430a7"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_18_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 17, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={62}
          summaryAggregationMode="none"
        />
        <Column
          id="41301"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_19_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 18, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={67}
          summaryAggregationMode="none"
        />
        <Column
          id="2ab7c"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_20_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 19, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={67}
          summaryAggregationMode="none"
        />
        <Column
          id="64a37"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_21_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 20, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={64}
          summaryAggregationMode="none"
        />
        <Column
          id="87590"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_22_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 21, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={62}
          summaryAggregationMode="none"
        />
        <Column
          id="c8b74"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_23_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 22, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={62}
          summaryAggregationMode="none"
        />
        <Column
          id="9ebc0"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="month_24_sale_qty"
          label="{{(() => {
  const now = new Date();
  const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 23, 1);
  const year = twoMonthsAgo.getFullYear().toString().substring(2);
  const month = twoMonthsAgo.getMonth() + 1;
  return `${year}년 ${month}월`;
})()}}"
          placeholder="Enter value"
          position="center"
          size={62}
          summaryAggregationMode="none"
        />
        <ToolbarButton
          id="1a"
          icon="bold/interface-text-formatting-filter-2"
          label="Filter"
          type="filter"
        />
        <ToolbarButton
          id="31d66"
          icon="bold/interface-download-button-2"
          label="Download"
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
                          "reorder_supplies_main_{{moment(new Date()).format('YYYY-MM-DD')}}",
                      },
                      { includeHiddenColumns: false },
                    ],
                  },
                },
              ],
            }}
            pluginId="table_main_list"
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
        />
        <Event
          event="save"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="discontinuedProductsQuery"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
        <Event
          event="changeRowSelection"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="getSelectedItems"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Table>
      <Container
        id="collapsibleContainer_discontinued_items"
        _gap="0px"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="12px"
        showHeader={true}
      >
        <Header>
          <Text
            id="collapsibleTitle1"
            value="#### 단종 아이템 목록"
            verticalAlign="center"
          />
          <ToggleButton
            id="collapsibleToggle1"
            horizontalAlign="right"
            iconForFalse="bold/interface-arrows-button-down"
            iconForTrue="bold/interface-arrows-button-up"
            iconPosition="replace"
            styleVariant="outline"
            text="{{ self.value ? 'Hide' : 'Show' }}"
            value="{{ collapsibleContainer_discontinued_items.showBody }}"
          >
            <Event
              event="change"
              method="setShowBody"
              params={{ ordered: [{ showBody: "{{ self.value }}" }] }}
              pluginId="collapsibleContainer_discontinued_items"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToggleButton>
        </Header>
        <View id="f474a" viewKey="View 1">
          <TextInput
            id="textInput2"
            label=""
            labelPosition="top"
            placeholder="품번, 품명, 컬러명 등을 입력하세요"
          />
          <Table
            id="table_discontinued_items"
            autoColumnWidth={true}
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ get_discontinued_products.data }}"
            defaultSelectedRow={{
              mode: "index",
              indexType: "display",
              index: 0,
            }}
            defaultSort={[{ object: { columnId: "39959", direction: "desc" } }]}
            emptyMessage={
              '{{ get_discontinued_products.isFetching === true? "⏳ 조회 중입니다...":"조회된 내역이 없습니다." }}'
            }
            enableSaveActions={true}
            primaryKeyColumnId="39959"
            rowHeight="small"
            searchTerm="{{ textInput2.value }}"
            showBorder={true}
            showFooter={true}
            showHeader={true}
            toolbarPosition="bottom"
          >
            <Column
              id="39959"
              alignment="right"
              editable={false}
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="true"
              key="id"
              label="ID"
              placeholder="Enter value"
              position="center"
              size={45.09375}
              summaryAggregationMode="none"
            />
            <Column
              id="3ff7a"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              key="sty_cd"
              label="품번"
              placeholder="Enter value"
              position="center"
              size={83.546875}
              summaryAggregationMode="none"
            />
            <Column
              id="5433e"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              key="sty_nm"
              label="품명"
              placeholder="Enter value"
              position="center"
              size={130.828125}
              summaryAggregationMode="none"
            />
            <Column
              id="e574e"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              key="col_nm"
              label="컬러명"
              placeholder="Enter value"
              position="center"
              size={63.65625}
              summaryAggregationMode="none"
            />
            <Column
              id="3b82d"
              alignment="left"
              format="boolean"
              groupAggregationMode="none"
              hidden="true"
              key="is_discontinued"
              label="Is discontinued"
              placeholder="Enter value"
              position="center"
              size={101.90625}
              summaryAggregationMode="none"
            />
            <Column
              id="1f90f"
              alignment="left"
              format="date"
              formatOptions={{ dateFormat: "yyyy-MM-dd" }}
              groupAggregationMode="none"
              key="discontinued_date"
              label="단종 등록일"
              placeholder="Enter value"
              position="center"
              size={81.671875}
              summaryAggregationMode="none"
            />
            <Column
              id="5bccf"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              key="discontinued_by"
              label="등록자/출처"
              placeholder="Enter value"
              position="center"
              size={212.234375}
              summaryAggregationMode="none"
            />
            <Column
              id="ed059"
              alignment="left"
              format="tag"
              formatOptions={{
                automaticColors: true,
                icon: "bold/interface-remove-circle",
              }}
              groupAggregationMode="none"
              label="단종 제외"
              placeholder="Select option"
              position="center"
              referenceId="단종목록에서제외"
              size={85.4375}
              summaryAggregationMode="none"
              valueOverride="제외하기"
            >
              <Event
                event="clickCell"
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
                pluginId="remove_from_discontinued_items_list"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
              <Event
                event="clickCell"
                method="showNotification"
                params={{
                  ordered: [
                    {
                      options: {
                        ordered: [
                          { notificationType: "info" },
                          {
                            title:
                              "{{ currentSourceRow.sty_nm}}({{ currentSourceRow.sty_cd}})",
                          },
                          { description: "단종 목록에서 제외했습니다." },
                        ],
                      },
                    },
                  ],
                }}
                pluginId=""
                type="util"
                waitMs="0"
                waitType="debounce"
              />
            </Column>
            <Column
              id="61b70"
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
                pluginId="table_discontinued_items"
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
                pluginId="table_discontinued_items"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
            </ToolbarButton>
          </Table>
        </View>
      </Container>
      <Container
        id="collapsibleContainer_discontinued_items2"
        _gap="0px"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        hidden=""
        padding="12px"
        showHeader={true}
      >
        <Header>
          <Text
            id="collapsibleTitle2"
            value="#### 리오더 확정 이력"
            verticalAlign="center"
          />
          <ToggleButton
            id="collapsibleToggle2"
            horizontalAlign="right"
            iconForFalse="bold/interface-arrows-button-down"
            iconForTrue="bold/interface-arrows-button-up"
            iconPosition="replace"
            styleVariant="outline"
            text="{{ self.value ? 'Hide' : 'Show' }}"
            value="{{ collapsibleContainer_discontinued_items2.showBody }}"
          >
            <Event
              event="change"
              method="setShowBody"
              params={{ ordered: [{ showBody: "{{ self.value }}" }] }}
              pluginId="collapsibleContainer_discontinued_items2"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToggleButton>
        </Header>
        <View id="f474a" viewKey="View 1">
          <TextInput
            id="textInput3"
            label=""
            labelPosition="top"
            placeholder="품번, 품명, 컬러명 등을 입력하세요"
          />
          <Table
            id="table_reorder_history"
            autoColumnWidth={true}
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ get_reorder_history.data }}"
            defaultSelectedRow={{
              mode: "index",
              indexType: "display",
              index: 0,
            }}
            emptyMessage={
              '{{ get_reorder_history.isFetching === true? "⏳ 조회 중입니다...":"조회된 내역이 없습니다." }}'
            }
            enableSaveActions={true}
            primaryKeyColumnId="e91ad"
            searchTerm="{{ textInput3.value }}"
            showBorder={true}
            showFooter={true}
            showHeader={true}
            toolbarPosition="bottom"
          >
            <Column
              id="c4788"
              alignment="right"
              editable={false}
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="true"
              key="id"
              label="ID"
              placeholder="Enter value"
              position="center"
              size={36.75}
              summaryAggregationMode="none"
            />
            <Column
              id="d29b3"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              key="sty_cd"
              label="품번"
              placeholder="Enter value"
              position="center"
              size={80.703125}
              summaryAggregationMode="none"
            />
            <Column
              id="5b0fc"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              key="sty_nm"
              label="품명"
              placeholder="Enter value"
              position="center"
              size={114.390625}
              summaryAggregationMode="none"
            />
            <Column
              id="0bc5d"
              alignment="left"
              editableOptions={{ showStepper: true }}
              format="string"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="true"
              key="col_cd"
              label="컬러코드"
              placeholder="Enter value"
              position="center"
              size={57.515625}
              summaryAggregationMode="none"
            />
            <Column
              id="88f09"
              alignment="left"
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
              size={80.203125}
              summaryAggregationMode="none"
              valueOverride="{{ _.startCase(item) }}"
            />
            <Column
              id="5f04a"
              alignment="right"
              format="string"
              formatOptions={{ automaticColors: true }}
              groupAggregationMode="none"
              key="size_nm"
              label="사이즈명"
              placeholder="Enter value"
              position="center"
              size={57.453125}
              summaryAggregationMode="none"
              valueOverride={"{{ item.replace(/[\"\"\\[\\]]/g, '') }}"}
            />
            <Column
              id="0ce15"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="string"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="final_reorder_qty"
              label="리오더 수량"
              placeholder="Enter value"
              position="center"
              size={70.828125}
              summaryAggregationMode="none"
              valueOverride={"{{ item.replace(/[\"\"\\[\\]]/g, '') }}"}
            />
            <Column
              id="7a7c6"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="tag_price"
              label="리오더 Tag가"
              placeholder="Enter value"
              position="center"
              size={80.296875}
              summaryAggregationMode="none"
            />
            <Column
              id="90e15"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="modifiable_cost_price"
              label="리오더 원가"
              placeholder="Enter value"
              position="center"
              size={70.828125}
              summaryAggregationMode="none"
            />
            <Column
              id="01622"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "2",
              }}
              groupAggregationMode="sum"
              key="price_reorder_multiple"
              label="리오더 배수"
              placeholder="Enter value"
              position="center"
              size={70.828125}
              summaryAggregationMode="none"
              valueOverride="{{ item }}"
            />
            <Column
              id="3c940"
              alignment="left"
              format="link"
              formatOptions={{
                showUnderline: "hover",
                underlineStyle: "solid",
              }}
              groupAggregationMode="none"
              key="created_by"
              label="저장한 임직원"
              position="center"
              size={157.515625}
              summaryAggregationMode="none"
            />
            <Column
              id="32e6a"
              alignment="left"
              format="datetime"
              formatOptions={{ dateFormat: "yyyy-MM-dd" }}
              groupAggregationMode="none"
              key="created_at"
              label="저장 일시"
              placeholder="Enter value"
              position="center"
              size={130.609375}
              summaryAggregationMode="none"
            />
            <Column
              id="59490"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              key="md_memo"
              label="MD 메모"
              placeholder="Enter value"
              position="center"
              size={58.171875}
              summaryAggregationMode="none"
            />
            <Column
              id="d0022"
              alignment="left"
              format="tag"
              formatOptions={{
                automaticColors: true,
                icon: '{{  currentSourceRow.exclude_at_reorder_target_list==true?"/icon:bold/interface-add-circle":""  }}',
              }}
              groupAggregationMode="none"
              key="exclude_at_reorder_target_list"
              label="리오더 점검 대상에 다시 포함하기"
              placeholder="Select option"
              position="center"
              referenceId="점검예외처리제외"
              size={173.15625}
              summaryAggregationMode="none"
              tooltip="리오더 확정 이력이 있어 점검 대상에서 제외되었던 해당 컬러를 다시 점검 대상에 포함하려면 클릭해주세요. 상단 테이블에 재노출됩니다."
              valueOverride={'{{ item==true? "포함하기":"이미 포함되어있음" }}'}
            >
              <Event
                enabled="{{ currentSourceRow.exclude_at_reorder_target_list == true }}"
                event="clickCell"
                method="trigger"
                params={{ ordered: [] }}
                pluginId="remove_from_reorder_history_table"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
            </Column>
            <Column
              id="e91ad"
              alignment="left"
              editable={false}
              format="string"
              groupAggregationMode="none"
              hidden="true"
              key="group_id"
              label="Group ID"
              placeholder="Enter value"
              position="center"
              size={98.515625}
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
                pluginId="table_reorder_history"
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
                pluginId="table_reorder_history"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
            </ToolbarButton>
          </Table>
        </View>
      </Container>
    </ModuleContainerWidget>
  </Frame>
</App>
