// prepareApiPayload transformer 수정

const itemsArray = {{ selectedReorderItems.value }}.map(item => {
  // 데이터 구조에 따라 값을 가져오는 헬퍼 함수
  const getValue = (nestedPath, flatPath, defaultValue = null) => {
    // 중첩 구조 확인 (예: item.reference_info.sty_cd)
    if (nestedPath) {
      const paths = nestedPath.split('.');
      let value = item;
      for (const path of paths) {
        value = value?.[path];
        if (value === undefined) break;
      }
      if (value !== undefined) return value;
    }
    // 플랫 구조에서 값 찾기
    return item[flatPath] !== undefined ? item[flatPath] : defaultValue;
  };

  // 이미지 URL 생성
  const styCode = getValue('reference_info.sty_cd', 'sty_cd');
  const colCode = getValue('reference_info.col_cd', 'col_cd');
  const productImageUrl = colCode 
    ? `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${styCode}${colCode}.jpg`
    : `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${styCode}.jpg`;

  // details_url 생성
  const brandPrefix = styCode ? styCode.substring(0, 2) : '';
  const detailsUrl = brandPrefix === "07" 
    ? "https://agabang.cleave.work/app/reorder_season_ettoi"
    : brandPrefix === "79"
    ? "https://agabang.cleave.work/app/reorder_season_disney"
    : "https://agabang.cleave.work/app/reorder_season_agabang";

  // 월 판매량과 소진일수 계산
  const currentStock = getValue('reorder_info.현재 총재고', 'current_stock_qty', 0);
  const avgDailySalesD30 = getValue(null, 'avg_daily_sales_d30', 0) || 
                           (getValue(null, 'avg_monthly_sales_d30', 0) / 30);
  const avgDailySalesD180 = getValue(null, 'avg_daily_sales_d180', 0) || 
                            (getValue(null, 'avg_monthly_sales_d180', 0) / 30);
  const avgDailySalesD365 = getValue(null, 'avg_daily_sales_d365', 0) || 
                            (getValue(null, 'avg_monthly_sales_d365', 0) / 30);

  return {
    product_image_url: productImageUrl,
    style_code: getValue('reference_info.sty_cd', 'sty_cd'),
    style_name: getValue('reference_info.sty_nm', 'sty_nm'),
    color_code: getValue('reference_info.col_cd', 'col_cd'),
    color_name: getValue('reference_info.col_nm', 'col_nm'),
    color_key: getValue('reference_info.groupId', 'groupId'),
    manufacturer_name: getValue('production_info.생산업체', 'cust_nm'),
    tag_price: getValue('production_info.TAG가', 'tag_price'),
    cost_price: getValue('production_info.원가', 'cost_price'),
    recommended_reorder_qty: getValue('reorder_info.부족 수량', 'recommended_reorder_qty', 0),
    details_url: detailsUrl,
    current_stock_total: currentStock,
    current_stock_store: getValue('production_info.매장재고', 'sh_stck_qty', 0),
    current_stock_warehouse: getValue('production_info.창고재고', 'wh_stck_qty', 0),
    cumulative_sales_rate: getValue('sales_performance.누적 판매율(입고 기준)', 'sale_rate', 0),
    sales_monthly_30d: Math.round(getValue(null, 'avg_monthly_sales_d30', 0)),
    stock_out_days_30d: avgDailySalesD30 > 0 ? Math.floor(currentStock / avgDailySalesD30) : 999,
    sales_monthly_180d: Math.round(getValue(null, 'avg_monthly_sales_d180', 0)),
    stock_out_days_180d: avgDailySalesD180 > 0 ? Math.floor(currentStock / avgDailySalesD180) : 999,
    sales_monthly_365d: Math.round(getValue(null, 'avg_monthly_sales_d365', 0)),
    stock_out_days_365d: avgDailySalesD365 > 0 ? Math.floor(currentStock / avgDailySalesD365) : 999,
    initial_reorder_cost_price: getValue('production_info.리오더 원가', 'modifiableCostPrice') ?? getValue(null, 'cost_price'),
    initial_moq: getValue(null, 'moq', 1000) || getValue(null, 'MOQ', 1000),
    initial_lead_time: getValue('reorder_info.리드타임(일)', 'lead_time_days', 60),
    input_deadline: moment().add(3, 'days').format("YYYY-MM-DD")
  };
});

// simulation_url을 상위 레벨로 이동
const simulationUrl = {{ var_brand_code.value }} === "07" 
  ? "https://agabang.cleave.work/app/reorder_simulation_season_ettoi"
  : {{ var_brand_code.value }} === "79"
  ? "https://agabang.cleave.work/app/reorder_simulation_season_disney"
  : "https://agabang.cleave.work/app/reorder_simulation_season_agabang";

// 최종 페이로드 객체 생성
const payload = {
  items: itemsArray,
  simulation_url: simulationUrl,
  triggeredBy: {{ current_user.email }},
  br_cd: {{ var_brand_code.value }},
  "isSupplies": true,
  production : {{ multiselect1.selectedItems.map(i=>i.email) }}
};

// 생성된 페이로드 객체를 반환
return payload;