<GlobalFunctions>
  <SqlQuery
    id="season_list_new"
    query={include("./lib/season_list_new.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="run"
      params={{
        ordered: [
          {
            src: "await for_4_years_query.trigger()\nawait await for_4_years_middle_cat_query.trigger()",
          },
        ],
      }}
      pluginId=""
      type="script"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <SqlQuery
    id="get_middle_cat_sales_data"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/get_middle_cat_sales_data.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="let list = formatDataAsArray(data)
return list"
    warningCodes={[]}
  />
  <JavascriptQuery
    id="for_4_years_middle_cat_query"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/for_4_years_middle_cat_query.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <State id="var_middle_cat" />
  <SqlQuery
    id="get_large_cat_sales_data"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/get_large_cat_sales_data.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer={
      "let list = formatDataAsArray(data)\nconsole.log(list)\n\n//  { cat_id:'57', cat_nm:'시즌의류' },\n//    { cat_id:'56', cat_nm:'시즌언더' },  \n//    { cat_id:'62', cat_nm:'시즌용품' },\n//    { cat_id:'777', cat_nm:'정상소계' },\n  \n//    { cat_id:'59', cat_nm:'파자마' },\n//    { cat_id:'60', cat_nm:'기획의류' }, // 60:수영복/우비\n//    { cat_id:'666', cat_nm:'기획언더' },\n  \n//    { cat_id:'888', cat_nm:'기획소계' },\n//    { cat_id:'999', cat_nm:'총계' },\n\nconst getNormalTot = (_key) =>  {\n  return list.reduce((acc, cur) => {\n    if (cur.cat_id === 57 || cur.cat_id === 56 || cur.cat_id === 62) {\n      return acc + parseInt(cur[_key]);\n    }\n    return acc;\n  }, 0);\n}\n\nconst getPlanTot = (_key) =>  {\n  return list.reduce((acc, cur) => {\n    if (cur.cat_id === 59 || cur.cat_id === 60) {\n      return acc + parseInt(cur[_key]);\n    }\n    return acc;\n  }, 0);\n}\n\nlet normal_tot_ord_qty = getNormalTot('tot_ord_qty'); // 발주수량\nlet normal_tot_ord_tag = getNormalTot('tot_ord_tag'); // 발주금액\n\nlet normal_ord_st = getNormalTot('ord_st');//총 컬러수\nlet normal_in_st = getNormalTot('in_st');// 현재 입고 컬러수\nlet normal_not_in_st = getNormalTot('not_in_st')// 미입고 컬러수\nlet normal_out_st = getNormalTot('out_st');//현재 출고 컬러수\nlet normal_not_out_st = getNormalTot('not_out_st'); //미출고 컬러수\n\nlet normal_tot_in_qty = getNormalTot('tot_in_qty'); //총입고량\nlet normal_tot_sale_qty = getNormalTot('tot_sale_qty'); // 총판매수량\nlet normal_tot_in_cost_amt = getNormalTot('tot_in_cost_amt'); // 총입고구입가\n\nlet normal_tot_in_tag = getNormalTot('tot_in_tag'); // 누적입고금액(TAG)\nlet normal_tot_sale_tag = getNormalTot('tot_sale_tag');// 누적판매금액(TAG)\nlet normal_tot_sale_amt = getNormalTot('tot_sale_amt');// 누적실판매금액\n\nlet normal_inven_qty = getNormalTot('inven_qty');//재고수량\nlet normal_inven_tag = getNormalTot('inven_tag');//재고금액\n\nlet normal_monthly_sale_qty = getNormalTot('monthly_sale_qty');//월간판매수량\nlet normal_monthly_sale_tag = getNormalTot('monthly_sale_tag');//월간판매금액(TAG)\nlet normal_monthly_sale_amt = getNormalTot('monthly_sale_amt');//월간실판매금액\n\nlet normal_last_week_sale_qty = getNormalTot('last_week_sale_qty');//지난주판매수량\nlet normal_last_week_sale_tag = getNormalTot('last_week_sale_tag');//지난주판매금액(TAG)\nlet normal_last_week_sale_amt = getNormalTot('last_week_sale_amt');//지난주실판매금액\n\nlet normal_this_week_sale_qty = getNormalTot('this_week_sale_qty');//이번주판매수량\nlet normal_this_week_sale_tag = getNormalTot('this_week_sale_tag');//이번주판매금액(TAG)\nlet normal_this_week_sale_amt = getNormalTot('this_week_sale_amt');//이번주실판매금액\n\n\nlet normal_in_st_rate = normal_in_st / normal_ord_st; // 기획대비 입고율\nlet normal_out_st_rate = normal_out_st / normal_ord_st; //기획대비컬러 출고율\nlet normal_sale_rate_qty =  normal_tot_sale_qty / normal_tot_in_qty; // 판매율(수량)\nlet normal_mark_up = normal_tot_in_tag / normal_tot_in_cost_amt; // 마크업\nlet normal_sale_rate_tag = normal_tot_sale_tag / normal_tot_in_tag; // 누적 판매율(TAG)\nlet normal_sale_rate_amt = normal_tot_sale_amt / normal_tot_in_tag; // 누적 판매율(실판매금액)\nlet normal_discount_rate = 1 - (normal_tot_sale_amt / normal_tot_sale_tag); // 할인율\nlet normal_last_week_progress_rate = normal_last_week_sale_tag / normal_tot_in_tag; //지난주 진도율\nlet normal_this_week_progress_rate = normal_this_week_sale_tag / normal_tot_in_tag;//이번주 진도율\n//  let ttl_s_in_rate_tag = ttl_s_tot_in_qty/ttl_s_tot_ord_qty; // 입고율\nlet normal_in_rate_tag = normal_tot_in_tag/normal_tot_ord_tag; // 입고율\n\n////////// 정상소계 //////////\nlet result_01 = {\n  cat_nm:\"정상소계\",\n  cat_id:777,\n  tot_ord_qty: normal_tot_ord_qty,\n  tot_ord_tag: normal_tot_ord_tag,\n  in_rate_tag: normal_in_rate_tag,\n  ord_st: normal_ord_st,  \n  in_st: normal_in_st,  \n  not_in_st: normal_not_in_st,  \n  in_st_rate: normal_in_st_rate,  \n  out_st: normal_out_st,  \n  not_out_st: normal_not_out_st,  \n  out_st_rate: normal_out_st_rate,  \n  tot_in_qty: normal_tot_in_qty,  \n  tot_sale_qty: normal_tot_sale_qty,  \n  sale_rate_qty: normal_sale_rate_qty, \n  tot_in_cost_amt: normal_tot_in_cost_amt,\n  mark_up:normal_mark_up,\n  tot_in_tag: normal_tot_in_tag,\n  tot_sale_tag: normal_tot_sale_tag,  \n  tot_sale_amt: normal_tot_sale_amt,\n  sale_rate_tag: normal_sale_rate_tag,\n  sale_rate_amt: normal_sale_rate_amt,\n  discount_rate: normal_discount_rate,\n  inven_qty: normal_inven_qty,\n  inven_tag: normal_inven_tag,\n  ttl_index: 3,\n  monthly_sale_qty: normal_monthly_sale_qty,\n  monthly_sale_tag: normal_monthly_sale_tag,\n  monthly_sale_amt: normal_monthly_sale_amt,\n  last_week_sale_qty: normal_last_week_sale_qty,\n  last_week_sale_tag: normal_last_week_sale_tag,\n  last_week_sale_amt: normal_last_week_sale_amt,\n  last_week_progress_rate: normal_last_week_progress_rate,\n  this_week_sale_qty: normal_this_week_sale_qty,\n  this_week_sale_tag: normal_this_week_sale_tag,\n  this_week_sale_amt: normal_this_week_sale_amt,\n  this_week_progress_rate: normal_this_week_progress_rate\n};\n\nlist.push(result_01);\n\n\n\nlet plan_tot_ord_qty = getPlanTot('tot_ord_qty'); // 발주수량\nlet plan_tot_ord_tag = getPlanTot('tot_ord_tag'); // 발주금액\n\nlet plan_ord_st = getPlanTot('ord_st');//총 컬러수\nlet plan_in_st = getPlanTot('in_st');// 현재 입고 컬러수\nlet plan_not_in_st = getPlanTot('not_in_st')// 미입고 컬러수\nlet plan_out_st = getPlanTot('out_st');//현재 출고 컬러수\nlet plan_not_out_st = getPlanTot('not_out_st'); //미출고 컬러수\n\nlet plan_tot_in_qty = getPlanTot('tot_in_qty'); //총입고량\nlet plan_tot_sale_qty = getPlanTot('tot_sale_qty'); // 총판매수량\nlet plan_tot_in_cost_amt = getPlanTot('tot_in_cost_amt'); // 총입고구입가\n\nlet plan_tot_in_tag = getPlanTot('tot_in_tag'); // 누적입고금액(TAG)\nlet plan_tot_sale_tag = getPlanTot('tot_sale_tag');// 누적판매금액(TAG)\nlet plan_tot_sale_amt = getPlanTot('tot_sale_amt');// 누적실판매금액\n\nlet plan_inven_qty = getPlanTot('inven_qty');//재고수량\nlet plan_inven_tag = getPlanTot('inven_tag');//재고금액\n\nlet plan_monthly_sale_qty = getPlanTot('monthly_sale_qty');//월간판매수량\nlet plan_monthly_sale_tag = getPlanTot('monthly_sale_tag');//월간판매금액(TAG)\nlet plan_monthly_sale_amt = getPlanTot('monthly_sale_amt');//월간실판매금액\n\nlet plan_last_week_sale_qty = getPlanTot('last_week_sale_qty');//지난주판매수량\nlet plan_last_week_sale_tag = getPlanTot('last_week_sale_tag');//지난주판매금액(TAG)\nlet plan_last_week_sale_amt = getPlanTot('last_week_sale_amt');//지난주실판매금액\n\nlet plan_this_week_sale_qty = getPlanTot('this_week_sale_qty');//이번주판매수량\nlet plan_this_week_sale_tag = getPlanTot('this_week_sale_tag');//이번주판매금액(TAG)\nlet plan_this_week_sale_amt = getPlanTot('this_week_sale_amt');//이번주실판매금액\n\n\nlet plan_in_st_rate = plan_in_st / plan_ord_st; // 기획대비 입고율\nlet plan_out_st_rate = plan_out_st / plan_ord_st; //기획대비컬러 출고율\nlet plan_sale_rate_qty =  plan_tot_sale_qty / plan_tot_in_qty; // 판매율(수량)\nlet plan_mark_up = plan_tot_in_tag / plan_tot_in_cost_amt; // 마크업\nlet plan_sale_rate_tag = plan_tot_sale_tag / plan_tot_in_tag; // 누적 판매율(TAG)\nlet plan_sale_rate_amt = plan_tot_sale_amt / plan_tot_in_tag; // 누적 판매율(실판매금액)\nlet plan_discount_rate = 1 - (plan_tot_sale_amt / plan_tot_sale_tag); // 할인율\nlet plan_last_week_progress_rate = plan_last_week_sale_tag / plan_tot_in_tag; //지난주 진도율\nlet plan_this_week_progress_rate = plan_this_week_sale_tag / plan_tot_in_tag;//이번주 진도율\n//  let ttl_s_in_rate_tag = ttl_s_tot_in_qty/ttl_s_tot_ord_qty; // 입고율\nlet plan_in_rate_tag = plan_tot_in_tag/plan_tot_ord_tag; // 입고율\n\n////////// 정상소계 //////////\nlet result_02 = {\n  cat_nm:\"기획소계\",\n  cat_id:888,\n  tot_ord_qty: plan_tot_ord_qty,\n  tot_ord_tag: plan_tot_ord_tag,\n  in_rate_tag: plan_in_rate_tag,\n  ord_st: plan_ord_st,  \n  in_st: plan_in_st,  \n  not_in_st: plan_not_in_st,  \n  in_st_rate: plan_in_st_rate,  \n  out_st: plan_out_st,  \n  not_out_st: plan_not_out_st,  \n  out_st_rate: plan_out_st_rate,  \n  tot_in_qty: plan_tot_in_qty,  \n  tot_sale_qty: plan_tot_sale_qty,  \n  sale_rate_qty: plan_sale_rate_qty, \n  tot_in_cost_amt: plan_tot_in_cost_amt,\n  mark_up:plan_mark_up,\n  tot_in_tag: plan_tot_in_tag,\n  tot_sale_tag: plan_tot_sale_tag,  \n  tot_sale_amt: plan_tot_sale_amt,\n  sale_rate_tag: plan_sale_rate_tag,\n  sale_rate_amt: plan_sale_rate_amt,\n  discount_rate: plan_discount_rate,\n  inven_qty: plan_inven_qty,\n  inven_tag: plan_inven_tag,\n  ttl_index: 3,\n  monthly_sale_qty: plan_monthly_sale_qty,\n  monthly_sale_tag: plan_monthly_sale_tag,\n  monthly_sale_amt: plan_monthly_sale_amt,\n  last_week_sale_qty: plan_last_week_sale_qty,\n  last_week_sale_tag: plan_last_week_sale_tag,\n  last_week_sale_amt: plan_last_week_sale_amt,\n  last_week_progress_rate: plan_last_week_progress_rate,\n  this_week_sale_qty: plan_this_week_sale_qty,\n  this_week_sale_tag: plan_this_week_sale_tag,\n  this_week_sale_amt: plan_this_week_sale_amt,\n  this_week_progress_rate: plan_this_week_progress_rate\n};\n\nlist.push(result_02);\n\n\n\n\n\n// 총계 추가\n\nlet ttl_0_tot_ord_qty = normal_tot_ord_qty + plan_tot_ord_qty;\nlet ttl_0_tot_ord_tag = normal_tot_ord_tag + plan_tot_ord_tag;\nlet ttl_0_ord_st = normal_ord_st + plan_ord_st;\nlet ttl_0_in_st = normal_in_st + plan_in_st;\nlet ttl_0_not_in_st = normal_not_in_st + plan_not_in_st;\n\nlet ttl_0_in_st_rate = ttl_0_in_st / ttl_0_ord_st; // 기획대비입고율\n\nlet ttl_0_out_st = normal_out_st + plan_out_st;\nlet ttl_0_not_out_st = normal_not_out_st + plan_not_out_st;\n\n\nlet ttl_0_out_st_rate = ttl_0_out_st / ttl_0_ord_st; // 기획대비출고율\n\nlet ttl_0_tot_in_qty = normal_tot_in_qty + plan_tot_in_qty;\nlet ttl_0_tot_sale_qty = normal_tot_sale_qty + plan_tot_sale_qty;\n\n\nlet ttl_0_sale_rate_qty = ttl_0_tot_sale_qty / ttl_0_tot_in_qty; // 수량기준 판매율\n\nlet ttl_0_tot_in_cost_amt = normal_tot_in_cost_amt + plan_tot_in_cost_amt;\nlet ttl_0_tot_in_tag = normal_tot_in_tag + plan_tot_in_tag;\n\nlet ttl_0_mark_up = ttl_0_tot_in_tag/ttl_0_tot_in_cost_amt; //배수\n\nlet ttl_0_tot_sale_tag = normal_tot_sale_tag + plan_tot_sale_tag;\nlet ttl_0_tot_sale_amt = normal_tot_sale_amt + plan_tot_sale_amt;\n\nlet ttl_0_sale_rate_tag = ttl_0_tot_sale_tag / ttl_0_tot_in_tag; // 판매율(TAG)\n\nlet ttl_0_sale_rate_amt = ttl_0_tot_sale_amt / ttl_0_tot_in_tag; // 판매율(실매출)\n\nlet ttl_0_discount_rate = 1 - (ttl_0_tot_sale_amt / ttl_0_tot_sale_tag); // 할인율\n\nlet ttl_0_inven_qty = normal_inven_qty + plan_inven_qty;\nlet ttl_0_inven_tag = normal_inven_tag + plan_inven_tag;\nlet ttl_0_monthly_sale_qty = normal_monthly_sale_qty + plan_monthly_sale_qty;\nlet ttl_0_monthly_sale_tag = normal_monthly_sale_tag + plan_monthly_sale_tag;\nlet ttl_0_monthly_sale_amt = normal_monthly_sale_amt + plan_monthly_sale_amt;\nlet ttl_0_last_week_sale_qty = normal_last_week_sale_qty + plan_last_week_sale_qty;\nlet ttl_0_last_week_sale_tag = normal_last_week_sale_tag + plan_last_week_sale_tag;\nlet ttl_0_last_week_sale_amt = normal_last_week_sale_amt + plan_last_week_sale_amt;\n\nlet ttl_0_last_week_progress_rate = ttl_0_last_week_sale_tag / ttl_0_tot_in_tag; // 지난주 진도율\n\nlet ttl_0_this_week_sale_qty = normal_this_week_sale_qty + plan_this_week_sale_qty;\nlet ttl_0_this_week_sale_tag = normal_this_week_sale_tag + plan_this_week_sale_tag;\nlet ttl_0_this_week_sale_amt = normal_this_week_sale_amt + plan_this_week_sale_amt;\n\n\nlet ttl_0_this_week_progress_rate = ttl_0_this_week_sale_tag / ttl_0_tot_in_tag; // 이번주 진도율\n\n//  let ttl_0_in_rate_tag = ttl_0_tot_in_qty / ttl_0_tot_ord_qty; // 입고율\nlet ttl_0_in_rate_tag = ttl_0_tot_in_tag / ttl_0_tot_ord_tag; // 입고율\n\n\n////////// 총계 //////////\nlist.push({\n cat_nm: \"총계\",\n cat_id: 999,\n tot_ord_qty: ttl_0_tot_ord_qty,\n tot_ord_tag: ttl_0_tot_ord_tag,\n in_rate_tag: ttl_0_in_rate_tag,\n ord_st: ttl_0_ord_st,\n in_st: ttl_0_in_st,\n not_in_st: ttl_0_not_in_st,\n in_st_rate: ttl_0_in_st_rate,\n out_st: ttl_0_out_st,\n not_out_st: ttl_0_not_out_st,\n out_st_rate: ttl_0_out_st_rate,\n tot_in_qty: ttl_0_tot_in_qty,\n tot_sale_qty: ttl_0_tot_sale_qty,\n sale_rate_qty: ttl_0_sale_rate_qty,\n tot_in_cost_amt: ttl_0_tot_in_cost_amt,\n mark_up:ttl_0_mark_up,\n tot_in_tag: ttl_0_tot_in_tag,\n tot_sale_tag: ttl_0_tot_sale_tag,\n tot_sale_amt: ttl_0_tot_sale_amt,\n sale_rate_tag: ttl_0_sale_rate_tag,\n sale_rate_amt: ttl_0_sale_rate_amt,\n discount_rate: ttl_0_discount_rate,\n inven_qty: ttl_0_inven_qty,\n inven_tag: ttl_0_inven_tag,\n ttl_index: 0,\n monthly_sale_qty: ttl_0_monthly_sale_qty,\n monthly_sale_tag: ttl_0_monthly_sale_tag,\n monthly_sale_amt: ttl_0_monthly_sale_amt,\n last_week_sale_qty: ttl_0_last_week_sale_qty,\n last_week_sale_tag: ttl_0_last_week_sale_tag,\n last_week_sale_amt: ttl_0_last_week_sale_amt,\n last_week_progress_rate: ttl_0_last_week_progress_rate,\n this_week_sale_qty: ttl_0_this_week_sale_qty,\n this_week_sale_tag: ttl_0_this_week_sale_tag,\n this_week_sale_amt: ttl_0_this_week_sale_amt,\n this_week_progress_rate: ttl_0_this_week_progress_rate\n});\n\n\n// 매출비중 컬럼 추가\n\nlist.forEach(item => {\n item.sale_share_in = Number(item.tot_in_tag) / ttl_0_tot_in_tag;\n item.sale_share_out = Number(item.tot_sale_tag) / ttl_0_tot_sale_tag;\n});\n\nconsole.log(list);\n\nreturn list"
    }
    warningCodes={[]}
  />
  <JavascriptQuery
    id="for_4_years_query"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/for_4_years_query.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <State id="var_large_cat" />
  <State id="var_brand_code" value="79" />
  <Function
    id="var_middle_cat_cur"
    funcBody={include("./lib/var_middle_cat_cur.js", "string")}
  />
  <State id="var_clicked_middle_cat" />
  <SqlQuery
    id="get_item_status"
    isMultiplayerEdited={false}
    query={include("./lib/get_item_status.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    warningCodes={[]}
  />
  <Function
    id="var_item_status_list"
    funcBody={include("./lib/var_item_status_list.js", "string")}
  />
  <State id="var_selected_item_info" />
  <State
    id="var_hide_column"
    value={
      '{"true": ["in_st","not_in_st","in_st_rate","out_st","not_out_st","out_st_rate"]}'
    }
  />
  <State id="var_middle_data" value="" />
  <Function id="var_middle_cat_prev" />
  <JavascriptQuery
    id="period"
    notificationDuration={4.5}
    query={include("./lib/period.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <Function
    id="period_prev_1year"
    funcBody={include("./lib/period_prev_1year.js", "string")}
  />
  <Function
    id="period_prev_2year"
    funcBody={include("./lib/period_prev_2year.js", "string")}
  />
  <Function
    id="period_prev_3year"
    funcBody={include("./lib/period_prev_3year.js", "string")}
  />
</GlobalFunctions>
