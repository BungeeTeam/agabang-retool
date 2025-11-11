<GlobalFunctions>
  <SqlQueryUnified
    id="get_reorder_simulation_targets"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/get_reorder_simulation_targets.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="setValue"
      params={{
        ordered: [
          {
            value:
              "{{ formatDataAsObject(self.data.filter(i=> multiselect1.value?.includes(i.id))).content.flat() }}",
          },
        ],
      }}
      pluginId="reorderSimulationTargets"
      type="state"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="getReorderReviewList"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <State id="reorderSimulationTargets" value="[]" />
  <JavascriptQuery
    id="getReorderReviewList"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/getReorderReviewList.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  >
    <Event
      event="success"
      method="setValue"
      params={{ ordered: [{ value: "{{  self.data.reviewedList }}" }] }}
      pluginId="editableReviewedList"
      type="state"
      waitMs="0"
      waitType="debounce"
    />
  </JavascriptQuery>
  <State id="editableReviewedList" value="[]" />
  <GoogleSheetsQuery
    id="get_manufactoring_team_input_data"
    enableTransformer={true}
    isMultiplayerEdited={false}
    resourceDisplayName="팀즈봇 연동 구글 시트"
    resourceName="bfb63675-9694-4519-851e-afbd7f4e9a81"
    sheetName={
      '{{ var_brand_code.value === \'01\' ? "agabang" : var_brand_code.value === \'07\' ? "ettoi" : var_brand_code.value === \'79\' ? "disney" : "test" }}'
    }
    spreadsheetId="1afJgasB6-Tl_8LTLQU3DD7z6FqYxtPS89gYD2PpMKHA"
    useRawSpreadsheetId={true}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="getReorderReviewList"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </GoogleSheetsQuery>
  <SqlQueryUnified
    id="insertMDDecisionsToDB"
    actionType="BULK_INSERT"
    editorMode="gui"
    notificationDuration={4.5}
    records="{{ getReorderReviewList.data.reviewedList.map(item => ({
  col_nm: item.col_nm,
  reorder_recommending_status: item.reorder_recommending_status,
  series_name: item.series_name,
  col_cd: item.col_cd,
  sty_nm: item.sty_nm,
  group_id: item.groupId, // 원본 키는 'groupId' (camelCase) 입니다.
  sty_cd: item.sty_cd,
  tag_price: item.tag_price,
  cust_nm: item.cust_nm,
  fabric: item.fabric,
  cost_price: item.cost_price,
  sh_stck_qty: item.sh_stck_qty,
  total_reorder_count: item.total_reorder_count,
  tot_in_qty: item.tot_in_qty,
  tot_sale_qty: item.tot_sale_qty,
  recommended_reorder_qty: item.recommended_reorder_qty,
  current_stock_qty: item.current_stock_qty,
  wh_stck_qty: item.wh_stck_qty,
  small_cat: item.small_cat,
  size_cd: item.size_cd,
  size_nm: item.size_nm,
  sale_rate: item.sale_rate,
  avg_monthly_sales_d_180: item.avg_monthly_sales_d180, // 원본 키는 'avg_monthly_sales_d180' 입니다.
  cust_cd: item.cust_cd,
  shop_gini: item.shop_gini,
  estimated_stock: item.estimated_stock,
  status_d_30: item.status_d30, // 원본 키는 'status_d30' 입니다.
  final_reorder_qty: item.final_reorder_qty, // 원본 키 'final_reorder_qty'가 존재합니다.
  middle_cat: item.middle_cat,
  large_cat: item.large_cat,
  avg_monthly_sales_d_30: item.avg_monthly_sales_d30, // 원본 키는 'avg_monthly_sales_d30' 입니다.
  avg_monthly_sales_d_365: item.avg_monthly_sales_d365, // 원본 키는 'avg_monthly_sales_d365' 입니다.
  days_until_out_of_stock_d_30: item.daysUntilOutOfStock_d30, // 원본 키는 'daysUntilOutOfStock_d30' (camelCase) 입니다.
  days_until_out_of_stock_d_180: item.daysUntilOutOfStock_d180, // 원본 키는 'daysUntilOutOfStock_d180' (camelCase) 입니다.
  emergency_stock: item.emergency_stock,
  target_sale_rate: item.target_sale_rate,
  expected_sales: item.expected_sales,
  status_d_180: item.status_d180, // 원본 키는 'status_d180' 입니다.
  status_d_365: item.status_d365, // 원본 키는 'status_d365' 입니다.
  lead_time_days: item.lead_time_days,
  moq: item.MOQ, // 원본 키 'moq'가 존재합니다. (대문자 'MOQ'도 존재)
  effective_monthly_sales: item.effective_monthly_sales,
  avg_daily_sales: item.avgDailySales, // 원본 키는 'avgDailySales' (camelCase) 입니다.
  avg_monthly_sales: item.avgMonthlySales, // 원본 키는 'avgMonthlySales' (camelCase) 입니다.
  expected_sales_period: item.expectedSalesPeriod, // 원본 키는 'expectedSalesPeriod' (camelCase) 입니다.
  expected_supply_qty: item.expectedSupplyQty, // 원본 키는 'expectedSupplyQty' (camelCase) 입니다.
  expected_sales_qty: item.expectedSalesQty, // 원본 키는 'expectedSalesQty' (camelCase) 입니다.
  days_until_out_of_stock_d_365: item.daysUntilOutOfStock_d365, // 원본 키는 'daysUntilOutOfStock_d365' (camelCase) 입니다.
  modifiable_cost_price: item.modifiableCostPrice, // 원본 키는 'modifiableCostPrice' (camelCase) 입니다.
  price_multiple: item.priceMultiple, // 원본 키는 'priceMultiple' (camelCase) 입니다.
  exclude_button: item.exclude_button, // 원본 키 'exclude_button'이 존재합니다.
  has_sheet_data: item.hasSheetData, // 원본 키는 'hasSheetData' (camelCase) 입니다.
  expected_sales_rate: item.expectedSalesRate, // 원본 키는 'expectedSalesRate' (camelCase) 입니다.
  note: item.note,
  total_expected_sales_qty: item.totalExpectedSalesQty, // 원본 키는 'totalExpectedSalesQty' (camelCase) 입니다.
  manufacturer_stock: item.manufacturer_stock, // 두 번째 샘플에만 존재합니다. 없을 수도 있음에 유의하세요.
  estimated_final_sale_rate: item.estimatedFinalSaleRate, // 원본 키는 'estimatedFinalSaleRate' (camelCase) 입니다.
  price_reorder_multiple: item.priceReorderMultiple, // 두 번째 샘플에만 존재합니다. 없을 수도 있음에 유의하세요.
  lead_time: item.leadTime, // 원본 키는 'leadTime' (camelCase) 입니다. ('lead_time_days'와 중복 가능성 있음)
  estimated_ending_stock: item.estimatedEndingStock, // *** 수정된 부분: 원본 키는 'estimatedEndingStock' (camelCase) 입니다. ***
  final_fixed_reorder_qty: item.finalFixedReorderQty, // 원본 키는 'finalFixedReorderQty' (camelCase) 입니다.
  type: 'supplies',

  // --- 아래 항목들은 item 객체에서 가져오는 것이 아닐 수 있습니다 ---
  created_by: current_user.email, // 현재 사용자 정보가 필요합니다. item에 관련 정보가 없다면 이 방식이 맞습니다.
  created_at: new Date(), // 현재 시간을 생성 시각으로 사용합니다. item에 생성 시각 정보가 없다면 이 방식이 맞습니다. (Date() 대신 new Date() 권장)
})) }}"
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    tableName="reorder_md_decision"
    updateSetValueDynamically={true}
  />
  <SqlQueryUnified
    id="get_reorder_moq_leadtime_info"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/get_reorder_moq_leadtime_info.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    resourceTypeOverride=""
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <JavascriptQuery
    id="saveTableEdits"
    notificationDuration={4.5}
    query={include("./lib/saveTableEdits.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
</GlobalFunctions>
