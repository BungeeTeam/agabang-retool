<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <GlobalWidgetProp id="var_brand_code" value="'01'" />
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
      var_brand_code="'01'"
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
                id="btn_reorder_simulation3"
                disabled="{{ selectedReorderItems.value?.length == 0 }}"
                heightType="auto"
                horizontalAlign="right"
                style={{ ordered: [] }}
                text="생산 데이터 요청 & 시뮬레이션"
                tooltipText="생산팀 요청 팀즈 메시지는 잠시 원활한 테스트를 위하여 안 나가게 해두었어요~! 모든 MD분들의 확인이 끝나면 켤 예정입니다."
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
        data="{{ getColorList.data
  .filter(item => item._type === 'header')
  .sort((a, b) => {
    // 인라인 상태 정규화 함수
    const norm = s => s && s.includes('긴급') ? 0 : (s && s.includes('주의') ? 1 : 2);

    // 1. 창고 재고 상태(wh_reorder_recommending_status): 긴급 > 주의 > 양호
    const aWh = norm(a.wh_reorder_recommending_status);
    const bWh = norm(b.wh_reorder_recommending_status);
    if (aWh !== bWh) return aWh - bWh;

    // 2. 전체 재고 상태(reorder_recommending_status): 긴급 > 주의 > 양호
    const aTot = norm(a.reorder_recommending_status);
    const bTot = norm(b.reorder_recommending_status);
    if (aTot !== bTot) return aTot - bTot;

    // 3. 리드타임동안 부족 수량(lead_time_shortage_qty): 많은 것 > 적은 것
    if ((b.lead_time_shortage_qty || 0) !== (a.lead_time_shortage_qty || 0)) return (b.lead_time_shortage_qty || 0) - (a.lead_time_shortage_qty || 0);

    // 4. 부족수량(shortage_qty): 많은 것 > 적은 것
    if ((b.shortage_qty || 0) !== (a.shortage_qty || 0)) return (b.shortage_qty || 0) - (a.shortage_qty || 0);

    // 5. 긴급 사이즈 수량(total_wh_urgent_size_count): 많은 것 > 적은 것
    if ((b.total_wh_urgent_size_count || 0) !== (a.total_wh_urgent_size_count || 0)) return (b.total_wh_urgent_size_count || 0) - (a.total_wh_urgent_size_count || 0);

    // 6. 재고량(current_stock_qty): 적은 것 > 많은 것
    const aStock = typeof a.current_stock_qty === 'number' ? a.current_stock_qty : Number(a.current_stock_qty) || 0;
    const bStock = typeof b.current_stock_qty === 'number' ? b.current_stock_qty : Number(b.current_stock_qty) || 0;
    if (aStock !== bStock) return aStock - bStock;

    // 7. 판매량(avg_monthly_sales): 많은 것 > 적은 것
    const aMonthly = Number(a.avg_monthly_sales_d180) || Number(a.avg_monthly_sales_d30) || 0;
    const bMonthly = Number(b.avg_monthly_sales_d180) || Number(b.avg_monthly_sales_d30) || 0;
    if (bMonthly !== aMonthly) return bMonthly - aMonthly;

    // 8. 상품 코드(sty_cd, col_cd): 알파벳 기준 역순
    if (a.sty_cd !== b.sty_cd) return String(b.sty_cd).localeCompare(String(a.sty_cd));
    if (a.col_cd !== b.col_cd) return String(b.col_cd).localeCompare(String(a.col_cd));

    return 0;
  })
}}"
        defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
        defaultSort={[]}
        emptyMessage={
          '{{ get_item_list.isFetching === true? "⏳ 조회 중입니다...":"조회된 내역이 없습니다." }}'
        }
        enableExpandableRows={true}
        groupedColumnConfig={{ expandByDefault: true, size: 83.203125 }}
        rowBackgroundColor=""
        rowHeight="medium"
        rowSelection="multiple"
        searchTerm="{{ textInput1.value }}"
        showBorder={true}
        showColumnBorders={true}
        showFooter={true}
        showHeader={true}
        style={{ rowSeparator: "rgba(224, 224, 224, 0.47)" }}
        toolbarPosition="bottom"
      >
        <Include src="./src/table_main_listExpandedRow.rsx" />
        <Column
          id="c6fdf"
          alignment="center"
          backgroundColor="{{ 
  currentSourceRow._type === 'header' ? 
    (currentSourceRow.wh_reorder_recommending_status.substring(0, 2) === '긴급' ? '#ffcccc' : 
     currentSourceRow.wh_reorder_recommending_status.substring(0, 2) === '주의' ? '#fff3cd' : 
     '#cce5cc') : 
    (currentSourceRow.parent_wh_reorder_recommending_status.substring(0, 2) === '긴급' ? '#ffcccc' : 
     currentSourceRow.parent_wh_reorder_recommending_status.substring(0, 2) === '주의' ? '#fff3cd' : 
     '#cce5cc')
}}"
          cellTooltip="창고재고를 기준으로 아래 3가지 중 하나라도 긴급/주의가 있으면 알려드려요.
{{
  (() => {
    // 값들을 안전하게 가져와서 정수로 변환
    const d7 = Math.round(Number(currentSourceRow.whDaysUntilOutOfStock_d7) || 0);
    const d30 = Math.round(Number(currentSourceRow.whDaysUntilOutOfStock_d30) || 0);
    const allTime = Math.round(Number(currentSourceRow.whDaysUntilOutOfStock) || 0);
    
    const sales7 = Math.round(Number(currentSourceRow.avg_daily_sales_d7) || 0);
    const sales30 = Math.round(Number(currentSourceRow.avg_daily_sales_d30) || 0);
    const salesAllTime = Math.round(Number(currentSourceRow.avg_daily_sales) || 0);
    
    // 상태 아이콘 가져오기
    const status7 = currentSourceRow.wh_status_d7 || '-';
    const status30 = currentSourceRow.wh_status_d30 || '-';
    const statusAllTime = currentSourceRow.wh_status || '-';
    
    // 최종 툴팁 구성
    return `- 최근 7일 기준: ${status7} (일판매량 ${sales7}개 | 재고 소진까지 D-${d7})
- 최근 30일 기준: ${status30} (일판매량 ${sales30}개 | 재고 소진까지 D-${d30})
- 전체 판매기간 기준: ${statusAllTime} (일판매량 ${salesAllTime}개 | 재고 소진까지 D-${allTime})`;
  })()
}}"
          cellTooltipMode="custom"
          format="string"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          key="wh_reorder_recommending_status"
          label="창고재고 기준 판단"
          placeholder="Enter value"
          position="left"
          size={64.796875}
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
  currentSourceRow._type === 'header' ? 
    (currentSourceRow.reorder_recommending_status.substring(0, 2) === '긴급' ? '#ffcccc' : 
     currentSourceRow.reorder_recommending_status.substring(0, 2) === '주의' ? '#fff3cd' : 
     '#cce5cc') : 
    (currentSourceRow.parent_reorder_recommending_status.substring(0, 2) === '긴급' ? '#ffcccc' : 
     currentSourceRow.parent_reorder_recommending_status.substring(0, 2) === '주의' ? '#fff3cd' : 
     '#cce5cc')
}}"
          cellTooltip="총재고를 기준으로 아래 3가지 중 하나라도 긴급/주의가 있으면 알려드려요.
{{
  (() => {
    // 값들을 안전하게 가져와서 정수로 변환
    const d7 = Math.round(Number(currentSourceRow.daysUntilOutOfStock_d7) || 0);
    const d30 = Math.round(Number(currentSourceRow.daysUntilOutOfStock_d30) || 0);
    const allTime = Math.round(Number(currentSourceRow.daysUntilOutOfStock) || 0);
    
    const sales7 = Math.round(Number(currentSourceRow.avg_daily_sales_d7) || 0);
    const sales30 = Math.round(Number(currentSourceRow.avg_daily_sales_d30) || 0);
    const salesAllTime = Math.round(Number(currentSourceRow.avg_daily_sales) || 0);
    
    // 상태 아이콘 가져오기
    const status7 = currentSourceRow.status_d7 || '-';
    const status30 = currentSourceRow.status_d30 || '-';
    const statusAllTime = currentSourceRow.status || '-';
    
    // 최종 툴팁 구성
    return `- 최근 7일 기준: ${status7} (일판매량 ${sales7}개 | 재고 소진까지 D-${d7})
- 최근 30일 기준: ${status30} (일판매량 ${sales30}개 | 재고 소진까지 D-${d30})
- 전체 판매기간 기준: ${statusAllTime} (일판매량 ${salesAllTime}개 | 재고 소진까지 D-${allTime})`;
  })()
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
          size={66.40625}
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
          formatOptions={{
            showUnderline: "hover",
            underlineStyle: "solid",
            widthType: "fill",
          }}
          groupAggregationMode="none"
          key="item_image"
          label="이미지"
          placeholder="Enter value"
          position="left"
          referenceId="이미지"
          size={55}
          summaryAggregationMode="none"
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
          size={147.3125}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow._type === 'header' ? item : null }}"
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
          id="e759a"
          alignment="center"
          editable="false"
          format="string"
          groupAggregationMode="none"
          hidden="true"
          key="sty_cd"
          label="품번"
          placeholder="Enter value"
          position="center"
          size={81.84375}
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
          size={100.828125}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow._type === 'header' ? item : null }}"
        />
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
          summaryAggregationMode="none"
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
          size={82.46875}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="f4b3a"
          alignment="center"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="item_nm"
          label="소분류 (ERP기준)"
          placeholder="Select option"
          position="center"
          size={102.4375}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow._type === 'header' ? item : null }}"
        />
        <Column
          id="d545f"
          alignment="center"
          format="tag"
          formatOptions={{ automaticColors: false }}
          groupAggregationMode="none"
          hidden="false"
          key="large_cat"
          label="대분류"
          placeholder="Select option"
          position="center"
          size={108.28125}
          summaryAggregationMode="none"
          tooltip={
            '업로드된 기획현황/생산현황표 기준으로 분류된 카테고리입니다.\n수정이 필요하면 "설정/관리 > 제품 정보 관리" 메뉴에서 엑셀 파일을 업로드해주세요.'
          }
          valueOverride="{{item}}"
        />
        <Column
          id="b697d"
          alignment="center"
          format="tag"
          formatOptions={{ automaticColors: false }}
          groupAggregationMode="none"
          hidden="{{var_brand_code.value == '07'}}"
          key="middle_cat"
          label="중분류"
          placeholder="Select option"
          position="center"
          size={103.921875}
          summaryAggregationMode="none"
          tooltip={
            '업로드된 기획현황/생산현황표 기준으로 분류된 카테고리입니다.\n수정이 필요하면 "설정/관리 > 제품 정보 관리" 메뉴에서 엑셀 파일을 업로드해주세요.'
          }
        />
        <Column
          id="99866"
          alignment="center"
          editable="false"
          format="tag"
          formatOptions={{ automaticColors: false }}
          groupAggregationMode="none"
          hidden="false"
          key="small_cat"
          label="소분류"
          position="center"
          size={99.265625}
          summaryAggregationMode="none"
          tooltip={
            '업로드된 기획현황/생산현황표 기준으로 분류된 카테고리입니다.\n수정이 필요하면 "설정/관리 > 제품 정보 관리" 메뉴에서 엑셀 파일을 업로드해주세요.'
          }
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
          id="8f74c"
          alignment="left"
          format="string"
          groupAggregationMode="none"
          hidden="true"
          key="br_nm"
          label="브랜드명"
          placeholder="Enter value"
          position="center"
          size={57.515625}
          summaryAggregationMode="none"
        />
        <Column
          id="8d947"
          alignment="center"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="false"
          key="series_name"
          label="시리즈명"
          placeholder="Select option"
          position="center"
          referenceId="series_name"
          size={110.875}
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
          size={127.734375}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow._type === 'header' ? item : '' }}"
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
          size={119.21875}
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
          size={69.4375}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow._type === 'header' ? item : null }}"
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
          size={73.609375}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow._type === 'header' ? item : null }}"
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
          size={62.703125}
          summaryAggregationMode="none"
          valueOverride="{{ currentSourceRow._type === 'header' ? item : null }}"
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
          size={103.140625}
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
          size={85.90625}
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
          size={86.109375}
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
          size={85.53125}
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
          size={86.484375}
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
          id="a092d"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="tot_out_qty"
          label="총 출고량"
          placeholder="Enter value"
          position="center"
          size={60.890625}
          summaryAggregationMode="none"
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
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="current_stock_qty"
          label="총재고"
          placeholder="Enter value"
          position="center"
          size={63.140625}
          summaryAggregationMode="none"
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
          size={70.515625}
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
          size={69.515625}
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
          id="c9444"
          alignment="center"
          cellTooltip="- 출고일: {{currentSourceRow.first_outbound_date}}
- 기준일: {{ currentSourceRow.reference_date }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="sales_period_until_reference_date"
          label="출고일~기준일"
          placeholder="Enter value"
          position="center"
          size={72.1875}
          summaryAggregationMode="none"
          tooltip="출고일부터 기준일까지의 일자수 = (기준일 - 출고일 + 1)로 계산"
          valueOverride="{{ item }}일"
        />
        <Column
          id="11549"
          alignment="center"
          cellTooltip="참고:
- 최근 7일: {{ (currentSourceRow.avg_daily_sales_d7).toFixed(1) }}
- 최근 30일: {{ (currentSourceRow.avg_daily_sales_d30).toFixed(1) }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="avg_daily_sales"
          label="일판매량"
          placeholder="Enter value"
          position="left"
          size={65.515625}
          summaryAggregationMode="none"
          tooltip="전체 판매기간 기준 일 평균 판매량"
          valueOverride="{{ item.toFixed(1) }}"
        />
        <Column
          id="a7b75"
          alignment="right"
          cellTooltip="참고:
- 전체 기간: {{ (currentSourceRow.avg_daily_sales).toFixed(1) }}
- 최근 30일: {{ (currentSourceRow.avg_daily_sales_d30).toFixed(1) }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "1",
          }}
          groupAggregationMode="sum"
          hidden="true"
          key="avg_daily_sales_d7"
          label="일판량 (최근 7일)"
          placeholder="Enter value"
          position="left"
          size={71.59375}
          summaryAggregationMode="none"
        />
        <Column
          id="c6fd0"
          alignment="right"
          cellTooltip="- 최근 30일: {{ (currentSourceRow.avg_monthly_sales_d30).toFixed(0) }}
- 최근 180일: {{ (currentSourceRow.avg_monthly_sales_d180).toFixed(0) }}
- 최근 365일: {{ (currentSourceRow.avg_monthly_sales_d365).toFixed(0) }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          hidden="true"
          key="effective_monthly_sales"
          label="월판매량"
          placeholder="Enter value"
          position="left"
          referenceId="effectiveMonthlySales"
          size={57.515625}
          summaryAggregationMode="none"
          tooltip="최근 180일 기준 월 판매량"
        />
        <Column
          id="6939a"
          alignment="left"
          format="date"
          formatOptions={{ dateFormat: "yyyy-MM-dd" }}
          groupAggregationMode="none"
          hidden="true"
          key="reference_date"
          label="기준일"
          placeholder="Enter value"
          position="center"
          size={86.484375}
          summaryAggregationMode="none"
        />
        <Column
          id="c8c05"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="false"
          key="lead_time_days"
          label="리드타임"
          placeholder="Enter value"
          position="center"
          size={73.515625}
          summaryAggregationMode="none"
          valueOverride="{{ item }}일"
        />
        <Column
          id="65399"
          alignment="right"
          cellTooltip="일판매량 * 리드타임
= {{ (currentSourceRow.avg_daily_sales).toFixed(2) }}.. * {{ currentSourceRow.lead_time_days }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="expected_sales_during_lead_time"
          label="리드타임동안 예상 판매량"
          placeholder="Enter value"
          position="center"
          referenceId="expectedSalesDuringLeadTime"
          size={84.9375}
          summaryAggregationMode="none"
        />
        <Column
          id="680de"
          alignment="right"
          cellTooltip="리드타임 동안의 예상 판매량 - 현재 재고량 = {{ (currentSourceRow.expected_sales_during_lead_time).toFixed(0) }} - {{ currentSourceRow.current_stock_qty }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="lead_time_shortage_qty"
          label="리드타임 동안 부족수량"
          placeholder="Enter value"
          position="center"
          size={81.546875}
          summaryAggregationMode="none"
          textColor={"{{ \n  item > 0 ? '#FF0000' : \"\" \n}}"}
          tooltip="리드타임 동안의 예상 판매량에서 현재 재고량을 뺀 값"
        />
        <Column
          id="615c2"
          alignment="right"
          cellTooltip="리드타임 동안 부족수량 / 목표 판매율 = {{ (currentSourceRow.lead_time_shortage_qty).toFixed(0) }} / {{ currentSourceRow.target_sale_rate }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          hidden="true"
          key="lead_time_recommended_reorder_qty"
          label="리드타임 필요 리오더 수량"
          placeholder="Enter value"
          position="center"
          size={140.3125}
          summaryAggregationMode="none"
          tooltip="리드타임 동안 부족수량을 목표 판매율로 나눈 값"
        />
        <Column
          id="f0806"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="lead_time_final_reorder_qty"
          label="리드타임 추천 리오더 수량"
          placeholder="Enter value"
          position="center"
          size={140.3125}
          summaryAggregationMode="none"
        />
        <Column
          id="8da6b"
          alignment="right"
          cellTooltip="- 리드타임: {{ currentSourceRow.lead_time_days }}일

- 총재고: {{ currentSourceRow.current_stock_qty }}
- 리드타임동안 판매량: {{ (currentSourceRow.expected_sales_during_lead_time).toFixed(0) }}"
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
          label="리드타임 후 예상 재고"
          placeholder="Enter value"
          position="center"
          size={68.546875}
          summaryAggregationMode="none"
          tooltip="리드타임 이후 남을 예상 재고"
        />
        <Column
          id="2edeb"
          alignment="left"
          format="date"
          formatOptions={{ dateFormat: "yyyy-MM-dd" }}
          groupAggregationMode="none"
          hidden="true"
          key="sales_end_date"
          label="판매 마감일"
          placeholder="Enter value"
          position="center"
          size={82.265625}
          summaryAggregationMode="none"
        />
        <Column
          id="b1356"
          alignment="center"
          editableOptions={{ showStepper: true }}
          format="string"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="expected_sales_period"
          label="기준일~예상 판매 마감일"
          placeholder="Enter value"
          position="center"
          size={85.453125}
          summaryAggregationMode="none"
          tooltip="예상 판매 마감일 - 기준일 + 1"
          valueOverride="{{ item }}일"
        />
        <Column
          id="abf86"
          alignment="right"
          cellTooltip="최근 7일 기준 일판매량 * 예상 판매기간
= {{ (currentSourceRow.avg_daily_sales_d7).toFixed(2) }}.. * {{ currentSourceRow.expected_sales_period }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="expected_sales_full_period"
          label="전체 기간 예상 판매량"
          placeholder="Enter value"
          position="center"
          referenceId="expectedSalesFullPeriod"
          size={75.546875}
          summaryAggregationMode="none"
        />
        <Column
          id="27c51"
          alignment="right"
          cellTooltip="전체기간 예상 판매량 - 현재 총재고
= {{ (currentSourceRow.expected_sales_full_period).toFixed(0) }} - {{ currentSourceRow.current_stock_qty }}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          key="shortage_qty"
          label="부족 수량"
          placeholder="Enter value"
          position="center"
          referenceId="shortageQty"
          size={64.890625}
          summaryAggregationMode="none"
          textColor={"{{ \n  item > 0 ? '#FF0000' : \"\" \n}}"}
        />
        <Column
          id="7110b"
          alignment="right"
          cellTooltip="(전체 기간 예상 판매량 - 현재고) ÷ 목표 판매율
= 부족수량 ÷ 목표 판매율
= ({{(currentSourceRow.expected_sales_full_period).toFixed(0)}} - {{currentSourceRow.current_stock_qty}}) ÷ {{ inputExpectedSalesRate.value }}"
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
          key="recommended_reorder_qty"
          label="필요 수량"
          placeholder="Enter value"
          position="center"
          size={60.890625}
          summaryAggregationMode="none"
          tooltip="(예상판매량 - 현재고) / 목표 판매율"
        />
        <Column
          id="527d6"
          alignment="right"
          cellTooltip="- 리오더 필요 수량: {{Math.round(currentSourceRow.recommended_reorder_qty)}}"
          cellTooltipMode="custom"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "0",
          }}
          groupAggregationMode="sum"
          hidden="true"
          key="final_reorder_qty"
          label="추천 수량"
          placeholder="Enter value"
          position="center"
          size={60.890625}
          summaryAggregationMode="none"
          tooltip="리오더 필요 수량을 10 단위로 반올림"
        />
        <Column
          id="405f7"
          alignment="left"
          editable={false}
          format="string"
          groupAggregationMode="none"
          hidden="true"
          key="groupId"
          label="Group ID"
          placeholder="Enter value"
          position="center"
          size={101.484375}
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
          size={515.453125}
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
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="avg_monthly_sales_d180"
          label="Avg monthly sales d 180"
          placeholder="Enter value"
          position="center"
          size={153.359375}
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
          cellTooltip={
            '{{ \n  item < currentSourceRow.lead_time_days ? "리드타임보다 소진일수가 짧습니다." : "" \n}}'
          }
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
          key="whDaysUntilOutOfStock_d7"
          label="창고재고 예상 소진일수"
          placeholder="Enter value"
          position="center"
          size={74.546875}
          summaryAggregationMode="none"
          textColor={
            "{{ \n  item < currentSourceRow.lead_time_days ? '#FF0000' : \"\" \n}}"
          }
          tooltip="잔여 창고재고와 최근 7일 판매량을 기준으로 예상 소진일수를 계산합니다. "
        />
        <Column
          id="e3af2"
          alignment="right"
          cellTooltip={
            '{{ \n  item < currentSourceRow.lead_time_days ? "리드타임보다 소진일수가 짧습니다." : "" \n}}'
          }
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
          key="daysUntilOutOfStock_d7"
          label="총재고 예상 소진일수"
          placeholder="Enter value"
          position="center"
          size={72.171875}
          summaryAggregationMode="none"
          textColor={
            "{{ \n  item < currentSourceRow.lead_time_days ? '#FF0000' : \"\" \n}}"
          }
          tooltip="잔여 총재고와 최근 7일 판매량을 기준으로 예상 소진일수를 계산합니다."
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
          id="9fec9"
          alignment="left"
          cellTooltipMode="overflow"
          format="tags"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="size_status_summary"
          label="Size status summary"
          placeholder="Select options"
          position="center"
          size={133.78125}
          summaryAggregationMode="none"
        />
        <Column
          id="2900e"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="total_urgent_size_count"
          label="Total urgent size count"
          placeholder="Enter value"
          position="center"
          size={145.5625}
          summaryAggregationMode="none"
        />
        <Column
          id="c218e"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="total_warning_size_count"
          label="Total warning size count"
          placeholder="Enter value"
          position="center"
          size={153.828125}
          summaryAggregationMode="none"
        />
        <Column
          id="6b5c1"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="total_wh_urgent_size_count"
          label="Total wh urgent size count"
          placeholder="Enter value"
          position="center"
          size={165.78125}
          summaryAggregationMode="none"
        />
        <Column
          id="9f3d2"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="total_wh_warning_size_count"
          label="Total wh warning size count"
          placeholder="Enter value"
          position="center"
          size={174.046875}
          summaryAggregationMode="none"
        />
        <Column
          id="f2475"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          key="out_rate"
          label="Out rate"
          placeholder="Enter value"
          position="center"
          size={66.3125}
          summaryAggregationMode="none"
          tooltip="출고율 (총 출고량/총 입고량)"
        />
        <Column
          id="96ec7"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="percent"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="average"
          hidden="true"
          key="sale_out_rate"
          label="Sale out rate"
          placeholder="Enter value"
          position="center"
          size={88.015625}
          summaryAggregationMode="none"
          tooltip="출고 대비 판매율 (총 판매량/총 출고량)"
        />
        <Column
          id="24918"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{
            showSeparators: true,
            notation: "standard",
            decimalPlaces: "",
          }}
          groupAggregationMode="sum"
          hidden="false"
          key="weekly_7d_sale_qty"
          label="최근 7일 판매량"
          placeholder="Enter value"
          position="left"
          size={66.84375}
          summaryAggregationMode="none"
          tooltip={
            '{{ (() => {\n  const now = new Date(); // 현재 날짜와 시간을 가져옵니다.\n  \n  // 어제 날짜를 계산합니다.\n  const yesterday = new Date(now);\n  yesterday.setDate(now.getDate() - 1);\n  \n  // 8일 전 날짜를 계산합니다.\n  const eightDaysAgo = new Date(now);\n  eightDaysAgo.setDate(now.getDate() - 7);\n  \n  // 날짜를 "MM/DD" 형식으로 포맷팅하는 함수입니다.\n  const formatDate = (date) => {\n    const month = date.getMonth() + 1; // 월은 0부터 시작하므로 1을 더합니다.\n    const day = date.getDate();\n    return `${month}/${day}`;\n  };\n  \n  // 포맷팅된 날짜를 반환합니다.\n  return `${formatDate(eightDaysAgo)} ~ ${formatDate(yesterday)} 판매량`;\n})() }}'
          }
        />
        <Column
          id="5b4a0"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_1_sale_qty"
          label="{{ (() => {
  const now = new Date(); // KST 기준 현재 시간 (실제로는 new Date())
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 // 월요일: 지난 주 월요일
      : thisMonday.getTime() // 그 외: 이번 주 월요일
  );
  
  const week1End = new Date(week1Start.getTime() + 6 * 24 * 60 * 60 * 1000); // 시작일 + 6일
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week1Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week1Start)}~${formatDate(week1End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={136.1875}
          statusIndicatorOptions={{
            manualData: [
              {
                ordered: [
                  {
                    showWhen: "{{ item >= currentSourceRow.week_2_sale_qty }}",
                  },
                  {
                    label:
                      "{{\n  (() => {\n    const currentWeek = Number(currentSourceRow.week_1_sale_qty) || 0;\n    const lastWeek = Number(currentSourceRow.week_2_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastWeek === 0) {\n      if (currentWeek === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"NEW\";  // 전주가 0일 때는 이번 주 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentWeek - lastWeek) / lastWeek) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
                  },
                  { color: "#D7EAE0" },
                  { icon: "bold/interface-arrows-up" },
                ],
              },
              {
                ordered: [
                  { showWhen: "{{ item < currentSourceRow.week_2_sale_qty }}" },
                  {
                    label:
                      "{{\n  (() => {\n    const currentWeek = Number(currentSourceRow.week_1_sale_qty) || 0;\n    const lastWeek = Number(currentSourceRow.week_2_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastWeek === 0) {\n      if (currentWeek === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"NEW\";  // 전주가 0일 때는 이번 주 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentWeek - lastWeek) / lastWeek) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
                  },
                  { color: "#F8DBD8" },
                  { icon: "bold/interface-arrows-down" },
                ],
              },
            ],
          }}
          summaryAggregationMode="none"
          tooltip="이번 주 판매량입니다.
전주 대비 증감도 함께 보여드려요.

전주 대비 증감율 = ((이번 주 판매량 - 전주 판매량) / 전주 판매량) * 100"
        />
        <Column
          id="6fbc8"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_2_sale_qty"
          label="{{ (() => {
  const now = new Date(); // KST 기준 현재 시간 (고정된 날짜로 테스트, 실제로는 new Date() 사용)
  
  // 현재 날짜의 요일 구하기 (0: 일요일, 1: 월요일, ...)
  const currentDay = now.getDay();
  
  // 이번 주 월요일 구하기
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  // week_1_sale_qty의 시작일 (SQL 쿼리와 동일)
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 // 월요일: 지난 주 월요일
      : thisMonday.getTime() // 그 외: 이번 주 월요일
  );
  
  // week_2_sale_qty의 시작일 (week_1_sale_qty에서 1주 전)
  const week2Start = new Date(week1Start.getTime() - 7 * 24 * 60 * 60 * 1000);
  
  // week_2_sale_qty의 종료일 (시작일 + 6일)
  const week2End = new Date(week2Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  // M/d 형식으로 포맷팅
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  // 월과 주차 계산
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1; // 월 (1~12)
    const year = date.getFullYear();
    
    // 해당 월의 첫 날
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    
    // 첫 번째 월요일 찾기
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    
    // 주차 계산: date가 속한 주가 월의 몇 번째 주인지
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week2Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week2Start)}~${formatDate(week2End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={134}
          statusIndicatorOptions={{
            manualData: [
              {
                ordered: [
                  {
                    showWhen: "{{ item >= currentSourceRow.week_3_sale_qty }}",
                  },
                  {
                    label:
                      "{{\n  (() => {\n    const currentWeek = Number(currentSourceRow.week_2_sale_qty) || 0;\n    const lastWeek = Number(currentSourceRow.week_3_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastWeek === 0) {\n      if (currentWeek === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"NEW\";  // 전주가 0일 때는 이번 주 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentWeek - lastWeek) / lastWeek) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
                  },
                  { color: "#D7EAE0" },
                  { icon: "bold/interface-arrows-up" },
                ],
              },
              {
                ordered: [
                  { showWhen: "{{ item < currentSourceRow.week_3_sale_qty }}" },
                  {
                    label:
                      "{{\n  (() => {\n    const currentWeek = Number(currentSourceRow.week_2_sale_qty) || 0;\n    const lastWeek = Number(currentSourceRow.week_3_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastWeek === 0) {\n      if (currentWeek === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"NEW\";  // 전주가 0일 때는 이번 주 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentWeek - lastWeek) / lastWeek) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
                  },
                  { color: "#F8DBD8" },
                  { icon: "bold/interface-arrows-down" },
                ],
              },
            ],
          }}
          summaryAggregationMode="none"
        />
        <Column
          id="dd671"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_3_sale_qty"
          label="{{ (() => {
  const now = new Date(); // KST 기준 현재 시간 (실제로는 new Date())
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week3Start = new Date(week1Start.getTime() - 2 * 7 * 24 * 60 * 60 * 1000); // week_1에서 2주 전
  const week3End = new Date(week3Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week3Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week3Start)}~${formatDate(week3End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={124.953125}
          summaryAggregationMode="none"
        />
        <Column
          id="58caa"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_4_sale_qty"
          label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week4Start = new Date(week1Start.getTime() - 3 * 7 * 24 * 60 * 60 * 1000); // week_1에서 3주 전
  const week4End = new Date(week4Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week4Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week4Start)}~${formatDate(week4End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={131.828125}
          summaryAggregationMode="none"
        />
        <Column
          id="08baf"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_5_sale_qty"
          label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week5Start = new Date(week1Start.getTime() - 4 * 7 * 24 * 60 * 60 * 1000); // week_1에서 4주 전
  const week5End = new Date(week5Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week5Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week5Start)}~${formatDate(week5End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={127.75}
          summaryAggregationMode="none"
        />
        <Column
          id="f086e"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_6_sale_qty"
          label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week6Start = new Date(week1Start.getTime() - 5 * 7 * 24 * 60 * 60 * 1000); // week_1에서 5주 전
  const week6End = new Date(week6Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week6Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week6Start)}~${formatDate(week6End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={129.46875}
          summaryAggregationMode="none"
        />
        <Column
          id="c16f8"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_7_sale_qty"
          label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week7Start = new Date(week1Start.getTime() - 6 * 7 * 24 * 60 * 60 * 1000); // week_1에서 6주 전
  const week7End = new Date(week7Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week7Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week7Start)}~${formatDate(week7End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={127.796875}
          summaryAggregationMode="none"
        />
        <Column
          id="a358b"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_8_sale_qty"
          label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week8Start = new Date(week1Start.getTime() - 7 * 7 * 24 * 60 * 60 * 1000); // week_1에서 7주 전
  const week8End = new Date(week8Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week8Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week8Start)}~${formatDate(week8End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={130.015625}
          summaryAggregationMode="none"
        />
        <Column
          id="bad2e"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_9_sale_qty"
          label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week9Start = new Date(week1Start.getTime() - 8 * 7 * 24 * 60 * 60 * 1000); // week_1에서 8주 전
  const week9End = new Date(week9Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week9Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week9Start)}~${formatDate(week9End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={125.4375}
          summaryAggregationMode="none"
        />
        <Column
          id="a8dcc"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_10_sale_qty"
          label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week10Start = new Date(week1Start.getTime() - 9 * 7 * 24 * 60 * 60 * 1000); // week_1에서 9주 전
  const week10End = new Date(week10Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week10Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week10Start)}~${formatDate(week10End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={124.78125}
          summaryAggregationMode="none"
        />
        <Column
          id="4664d"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_11_sale_qty"
          label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week11Start = new Date(week1Start.getTime() - 10 * 7 * 24 * 60 * 60 * 1000); // week_1에서 10주 전
  const week11End = new Date(week11Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week11Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week11Start)}~${formatDate(week11End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={129.21875}
          summaryAggregationMode="none"
        />
        <Column
          id="876fc"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          key="week_12_sale_qty"
          label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week12Start = new Date(week1Start.getTime() - 11 * 7 * 24 * 60 * 60 * 1000); // week_1에서 11주 전
  const week12End = new Date(week12Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week12Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week12Start)}~${formatDate(week12End)})`;
})() }}"
          placeholder="Enter value"
          position="center"
          size={122.515625}
          summaryAggregationMode="none"
        />
        <Column
          id="3d312"
          alignment="left"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="status_d7"
          label="Status d 7"
          placeholder="Select option"
          position="center"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="65cd9"
          alignment="right"
          editableOptions={{ showStepper: true }}
          format="decimal"
          formatOptions={{ showSeparators: true, notation: "standard" }}
          groupAggregationMode="sum"
          hidden="true"
          key="whDaysUntilOutOfStock"
          label="Wh days until out of stock"
          placeholder="Enter value"
          position="center"
          size={100}
          summaryAggregationMode="none"
        />
        <Column
          id="e39da"
          alignment="left"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="wh_status_d7"
          label="Wh status d 7"
          placeholder="Select option"
          position="center"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
        />
        <Column
          id="053bc"
          alignment="left"
          format="tag"
          formatOptions={{ automaticColors: true }}
          groupAggregationMode="none"
          hidden="true"
          key="wh_status"
          label="Wh status"
          placeholder="Select option"
          position="center"
          size={100}
          summaryAggregationMode="none"
          valueOverride="{{ _.startCase(item) }}"
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
            params={{
              ordered: [
                {
                  options: {
                    ordered: [
                      {
                        fileName:
                          "reorder_season_main_{{moment(new Date()).format('YYYY-MM-DD')}}",
                      },
                      { fileType: "xlsx" },
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
              size={85.984375}
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
              size={131.859375}
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
              size={66.03125}
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
              size={84.390625}
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
              size={214.78125}
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
              size={85.5}
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
              size={79.984375}
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
              size={88.65625}
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
              size={74.359375}
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
              size={59.984375}
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
              size={71.28125}
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
              size={81.796875}
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
              size={71.28125}
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
              size={71.28125}
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
              size={164.71875}
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
              size={138.96875}
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
              size={59.4375}
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
              size={174.8125}
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
