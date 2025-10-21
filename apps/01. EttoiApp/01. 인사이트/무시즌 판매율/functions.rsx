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
      "let list = formatDataAsArray(data)\nconsole.log(list)\n\nconst getTotValue = (_key) =>  {\n  return list.reduce((acc, cur) => {\n    if (cur.cat_id === 6 || cur.cat_id === 7 || cur.cat_id === 10) {\n      return acc + parseInt(cur[_key]);\n    }\n    return acc;\n  }, 0);\n}\n\n\n//중간소계용 함수\nconst getIndexTotValue = (_idx, _key) => {\n  if(_idx === 1 || _idx === 2){\n    return list.reduce((acc, cur) => {\n      if (cur.ttl_index === _idx) {\n        return acc + parseInt(cur[_key]);\n      }\n      return acc;\n    }, 0);\n  }\n  return null\n}\n\n\nlet ttl_s_tot_ord_qty = getTotValue('tot_ord_qty'); // 발주수량\nlet ttl_s_tot_ord_tag = getTotValue('tot_ord_tag'); // 발주금액\n\nlet ttl_s_ord_st = getTotValue('ord_st');//총 컬러수\nlet ttl_s_in_st = getTotValue('in_st');// 현재 입고 컬러수\nlet ttl_s_not_in_st = getTotValue('not_in_st')// 미입고 컬러수\nlet ttl_s_out_st = getTotValue('out_st');//현재 출고 컬러수\nlet ttl_s_not_out_st = getTotValue('not_out_st'); //미출고 컬러수\n\nlet ttl_s_tot_in_qty = getTotValue('tot_in_qty'); //총입고량\nlet ttl_s_tot_sale_qty = getTotValue('tot_sale_qty'); // 총판매수량\nlet ttl_s_tot_in_cost_amt = getTotValue('tot_in_cost_amt'); // 총입고구입가\n\nlet ttl_s_tot_in_tag = getTotValue('tot_in_tag'); // 누적입고금액(TAG)\nlet ttl_s_tot_sale_tag = getTotValue('tot_sale_tag');// 누적판매금액(TAG)\nlet ttl_s_tot_sale_amt = getTotValue('tot_sale_amt');// 누적실판매금액\n\nlet ttl_s_inven_qty = getTotValue('inven_qty');//재고수량\nlet ttl_s_inven_tag = getTotValue('inven_tag');//재고금액\n\nlet ttl_s_monthly_sale_qty = getTotValue('monthly_sale_qty');//월간판매수량\nlet ttl_s_monthly_sale_tag = getTotValue('monthly_sale_tag');//월간판매금액(TAG)\nlet ttl_s_monthly_sale_amt = getTotValue('monthly_sale_amt');//월간실판매금액\n\nlet ttl_s_last_week_sale_qty = getTotValue('last_week_sale_qty');//지난주판매수량\nlet ttl_s_last_week_sale_tag = getTotValue('last_week_sale_tag');//지난주판매금액(TAG)\nlet ttl_s_last_week_sale_amt = getTotValue('last_week_sale_amt');//지난주실판매금액\n\nlet ttl_s_this_week_sale_qty = getTotValue('this_week_sale_qty');//이번주판매수량\nlet ttl_s_this_week_sale_tag = getTotValue('this_week_sale_tag');//이번주판매금액(TAG)\nlet ttl_s_this_week_sale_amt = getTotValue('this_week_sale_amt');//이번주실판매금액\n\n\nlet ttl_s_in_st_rate = ttl_s_in_st / ttl_s_ord_st; // 기획대비 입고율\nlet ttl_s_out_st_rate = ttl_s_out_st / ttl_s_ord_st; //기획대비컬러 출고율\nlet ttl_s_sale_rate_qty =  ttl_s_tot_sale_qty / ttl_s_tot_in_qty; // 판매율(수량)\nlet ttl_s_mark_up = ttl_s_tot_in_tag / ttl_s_tot_in_cost_amt; // 마크업\nlet ttl_s_sale_rate_tag = ttl_s_tot_sale_tag / ttl_s_tot_in_tag; // 누적 판매율(TAG)\nlet ttl_s_sale_rate_amt = ttl_s_tot_sale_amt / ttl_s_tot_in_tag; // 누적 판매율(실판매금액)\nlet ttl_s_discount_rate = 1 - (ttl_s_tot_sale_amt / ttl_s_tot_sale_tag); // 할인율\nlet ttl_s_last_week_progress_rate = ttl_s_last_week_sale_tag / ttl_s_tot_in_tag; //지난주 진도율\nlet ttl_s_this_week_progress_rate = ttl_s_this_week_sale_tag / ttl_s_tot_in_tag;//이번주 진도율\n//  let ttl_s_in_rate_tag = ttl_s_tot_in_qty/ttl_s_tot_ord_qty; // 입고율\nlet ttl_s_in_rate_tag = ttl_s_tot_in_tag/ttl_s_tot_ord_tag; // 입고율\n\n////////// 시즌용품 //////////\nlet result_01 = {\n  cat_nm:\"시즌용품\",\n  cat_id:666,\n  tot_ord_qty: ttl_s_tot_ord_qty,\n  tot_ord_tag: ttl_s_tot_ord_tag,\n  in_rate_tag: ttl_s_in_rate_tag,\n  ord_st: ttl_s_ord_st,  \n  in_st: ttl_s_in_st,  \n  not_in_st: ttl_s_not_in_st,  \n  in_st_rate: ttl_s_in_st_rate,  \n  out_st: ttl_s_out_st,  \n  not_out_st: ttl_s_not_out_st,  \n  out_st_rate: ttl_s_out_st_rate,  \n  tot_in_qty: ttl_s_tot_in_qty,  \n  tot_sale_qty: ttl_s_tot_sale_qty,  \n  sale_rate_qty: ttl_s_sale_rate_qty, \n  tot_in_cost_amt: ttl_s_tot_in_cost_amt,\n  mark_up:ttl_s_mark_up,\n  tot_in_tag: ttl_s_tot_in_tag,\n  tot_sale_tag: ttl_s_tot_sale_tag,  \n  tot_sale_amt: ttl_s_tot_sale_amt,\n  sale_rate_tag: ttl_s_sale_rate_tag,\n  sale_rate_amt: ttl_s_sale_rate_amt,\n  discount_rate: ttl_s_discount_rate,\n  inven_qty: ttl_s_inven_qty,\n  inven_tag: ttl_s_inven_tag,\n  ttl_index: 3,\n  monthly_sale_qty: ttl_s_monthly_sale_qty,\n  monthly_sale_tag: ttl_s_monthly_sale_tag,\n  monthly_sale_amt: ttl_s_monthly_sale_amt,\n  last_week_sale_qty: ttl_s_last_week_sale_qty,\n  last_week_sale_tag: ttl_s_last_week_sale_tag,\n  last_week_sale_amt: ttl_s_last_week_sale_amt,\n  last_week_progress_rate: ttl_s_last_week_progress_rate,\n  this_week_sale_qty: ttl_s_this_week_sale_qty,\n  this_week_sale_tag: ttl_s_this_week_sale_tag,\n  this_week_sale_amt: ttl_s_this_week_sale_amt,\n  this_week_progress_rate: ttl_s_this_week_progress_rate\n};\n\nlist.push(result_01);\n\n//정상소계 추가\nlet ttl_1_tot_ord_qty = getIndexTotValue(1, 'tot_ord_qty');\nlet ttl_1_tot_ord_tag = getIndexTotValue(1, 'tot_ord_tag');\nlet ttl_1_ord_st = getIndexTotValue(1, 'ord_st');\nlet ttl_1_in_st = getIndexTotValue(1, 'in_st');\nlet ttl_1_not_in_st = getIndexTotValue(1, 'not_in_st');\nlet ttl_1_out_st = getIndexTotValue(1, 'out_st');\nlet ttl_1_not_out_st = getIndexTotValue(1, 'not_out_st');\nlet ttl_1_tot_in_qty = getIndexTotValue(1, 'tot_in_qty');\nlet ttl_1_tot_sale_qty = getIndexTotValue(1, 'tot_sale_qty');\nlet ttl_1_tot_in_cost_amt = getIndexTotValue(1, 'tot_in_cost_amt');\nlet ttl_1_tot_in_tag = getIndexTotValue(1, 'tot_in_tag');\nlet ttl_1_tot_sale_tag = getIndexTotValue(1, 'tot_sale_tag');\nlet ttl_1_tot_sale_amt = getIndexTotValue(1, 'tot_sale_amt');\nlet ttl_1_inven_qty = getIndexTotValue(1, 'inven_qty');\nlet ttl_1_inven_tag = getIndexTotValue(1, 'inven_tag');\nlet ttl_1_monthly_sale_qty = getIndexTotValue(1, 'monthly_sale_qty');\nlet ttl_1_monthly_sale_tag = getIndexTotValue(1, 'monthly_sale_tag');\nlet ttl_1_monthly_sale_amt = getIndexTotValue(1, 'monthly_sale_amt');\nlet ttl_1_last_week_sale_qty = getIndexTotValue(1, 'last_week_sale_qty');\nlet ttl_1_last_week_sale_tag = getIndexTotValue(1, 'last_week_sale_tag');\nlet ttl_1_last_week_sale_amt = getIndexTotValue(1, 'last_week_sale_amt');\nlet ttl_1_this_week_sale_qty = getIndexTotValue(1, 'this_week_sale_qty');\nlet ttl_1_this_week_sale_tag = getIndexTotValue(1, 'this_week_sale_tag');\nlet ttl_1_this_week_sale_amt = getIndexTotValue(1, 'this_week_sale_amt');\n//  let ttl_1_tot_ord_qty = getIndexTotValue(1, 'tot_ord_qty');\n\n// 연산\nlet ttl_1_in_st_rate = ttl_1_in_st / ttl_1_ord_st; // 기획대비입고율\nlet ttl_1_out_st_rate = ttl_1_out_st / ttl_1_ord_st; // 기획대비출고율\nlet ttl_1_sale_rate_qty = ttl_1_tot_sale_qty / ttl_1_tot_in_qty; // 수량기준 판매율\nlet ttl_1_mark_up = ttl_1_tot_in_tag / ttl_1_tot_in_cost_amt; // 배수\nlet ttl_1_sale_rate_tag = ttl_1_tot_sale_tag / ttl_1_tot_in_tag; // 판매율(TAG)\nlet ttl_1_sale_rate_amt = ttl_1_tot_sale_amt / ttl_1_tot_in_tag; // 판매율(실매출)\nlet ttl_1_discount_rate = 1 - (ttl_1_tot_sale_amt / ttl_1_tot_sale_tag); // 할인율\nlet ttl_1_last_week_progress_rate = ttl_1_last_week_sale_tag / ttl_1_tot_in_tag; // 지난주 진도율\nlet ttl_1_this_week_progress_rate = ttl_1_this_week_sale_tag / ttl_1_tot_in_tag; // 이번주 진도율\n//  let ttl_1_in_rate_tag = ttl_1_tot_in_qty / ttl_1_tot_ord_qty; // 입고율\nlet ttl_1_in_rate_tag = ttl_1_tot_in_tag / ttl_1_tot_ord_tag; // 입고율\n\n////////// 정상소계 //////////\nlist.push({\n cat_nm:\"정상소계\",\n cat_id:777,\n tot_ord_qty: ttl_1_tot_ord_qty,  \n tot_ord_tag: ttl_1_tot_ord_tag,  \n in_rate_tag: ttl_1_in_rate_tag,  \n ord_st: ttl_1_ord_st,  \n in_st: ttl_1_in_st,  \n not_in_st: ttl_1_not_in_st,  \n in_st_rate: ttl_1_in_st_rate,  \n out_st: ttl_1_out_st,  \n not_out_st: ttl_1_not_out_st,  \n out_st_rate: ttl_1_out_st_rate,  \n tot_in_qty: ttl_1_tot_in_qty,  \n tot_sale_qty: ttl_1_tot_sale_qty,  \n sale_rate_qty: ttl_1_sale_rate_qty,  \n tot_in_cost_amt: ttl_1_tot_in_cost_amt,\n mark_up:ttl_1_mark_up,\n tot_in_tag: ttl_1_tot_in_tag,  \n tot_sale_tag: ttl_1_tot_sale_tag,  \n tot_sale_amt: ttl_1_tot_sale_amt,  \n sale_rate_tag: ttl_1_sale_rate_tag,  \n sale_rate_amt: ttl_1_sale_rate_amt,  \n discount_rate: ttl_1_discount_rate,  \n inven_qty: ttl_1_inven_qty,  \n inven_tag: ttl_1_inven_tag,  \n ttl_index: 1,\n monthly_sale_qty: ttl_1_monthly_sale_qty,  \n monthly_sale_tag: ttl_1_monthly_sale_tag,  \n monthly_sale_amt: ttl_1_monthly_sale_amt,  \n last_week_sale_qty: ttl_1_last_week_sale_qty,  \n last_week_sale_tag: ttl_1_last_week_sale_tag,  \n last_week_sale_amt: ttl_1_last_week_sale_amt,  \n last_week_progress_rate: ttl_1_last_week_progress_rate,  \n this_week_sale_qty: ttl_1_this_week_sale_qty,  \n this_week_sale_tag: ttl_1_this_week_sale_tag,  \n this_week_sale_amt: ttl_1_this_week_sale_amt,  \n this_week_progress_rate: ttl_1_this_week_progress_rate\n});\n\n\n//기획소계 추가\n\nlet ttl_2_tot_ord_qty = getIndexTotValue(2, 'tot_ord_qty');\nlet ttl_2_tot_ord_tag = getIndexTotValue(2, 'tot_ord_tag');\nlet ttl_2_ord_st = getIndexTotValue(2, 'ord_st');\nlet ttl_2_in_st = getIndexTotValue(2, 'in_st');\nlet ttl_2_not_in_st = getIndexTotValue(2, 'not_in_st');\nlet ttl_2_out_st = getIndexTotValue(2, 'out_st');\nlet ttl_2_not_out_st = getIndexTotValue(2, 'not_out_st');\nlet ttl_2_tot_in_qty = getIndexTotValue(2, 'tot_in_qty');\nlet ttl_2_tot_sale_qty = getIndexTotValue(2, 'tot_sale_qty');\nlet ttl_2_tot_in_cost_amt = getIndexTotValue(2, 'tot_in_cost_amt');\nlet ttl_2_tot_in_tag = getIndexTotValue(2, 'tot_in_tag');\nlet ttl_2_tot_sale_tag = getIndexTotValue(2, 'tot_sale_tag');\nlet ttl_2_tot_sale_amt = getIndexTotValue(2, 'tot_sale_amt');\nlet ttl_2_inven_qty = getIndexTotValue(2, 'inven_qty');\nlet ttl_2_inven_tag = getIndexTotValue(2, 'inven_tag');\nlet ttl_2_monthly_sale_qty = getIndexTotValue(2, 'monthly_sale_qty');\nlet ttl_2_monthly_sale_tag = getIndexTotValue(2, 'monthly_sale_tag');\nlet ttl_2_monthly_sale_amt = getIndexTotValue(2, 'monthly_sale_amt');\nlet ttl_2_last_week_sale_qty = getIndexTotValue(2, 'last_week_sale_qty');\nlet ttl_2_last_week_sale_tag = getIndexTotValue(2, 'last_week_sale_tag');\nlet ttl_2_last_week_sale_amt = getIndexTotValue(2, 'last_week_sale_amt');\nlet ttl_2_this_week_sale_qty = getIndexTotValue(2, 'this_week_sale_qty');\nlet ttl_2_this_week_sale_tag = getIndexTotValue(2, 'this_week_sale_tag');\nlet ttl_2_this_week_sale_amt = getIndexTotValue(2, 'this_week_sale_amt');\n\nlet ttl_2_in_st_rate = ttl_2_in_st / ttl_2_ord_st; // 기획대비입고율\nlet ttl_2_out_st_rate = ttl_2_out_st / ttl_2_ord_st; // 기획대비출고율\nlet ttl_2_sale_rate_qty = ttl_2_tot_sale_qty / ttl_2_tot_in_qty; // 수량기준 판매율\nlet ttl_2_mark_up = ttl_2_tot_in_tag / ttl_2_tot_in_cost_amt; // 배수\nlet ttl_2_sale_rate_tag = ttl_2_tot_sale_tag / ttl_2_tot_in_tag; // 판매율(TAG)\nlet ttl_2_sale_rate_amt = ttl_2_tot_sale_amt / ttl_2_tot_in_tag; // 판매율(실매출)\nlet ttl_2_discount_rate = 1 - (ttl_2_tot_sale_amt / ttl_2_tot_sale_tag); // 할인율\nlet ttl_2_last_week_progress_rate = ttl_2_last_week_sale_tag / ttl_2_tot_in_tag; // 지난주 진도율\nlet ttl_2_this_week_progress_rate = ttl_2_this_week_sale_tag / ttl_2_tot_in_tag; // 이번주 진도율\n//  let ttl_2_in_rate_tag = ttl_2_tot_in_qty / ttl_2_tot_ord_qty; // 입고율\nlet ttl_2_in_rate_tag = ttl_2_tot_in_tag / ttl_2_tot_ord_tag; // 입고율\n\n////////// 기획소계 //////////\nlist.push({\n cat_nm: \"기획소계\",\n cat_id: 888,\n tot_ord_qty: ttl_2_tot_ord_qty,\n tot_ord_tag: ttl_2_tot_ord_tag,\n in_rate_tag: ttl_2_in_rate_tag,\n ord_st: ttl_2_ord_st,\n in_st: ttl_2_in_st,\n not_in_st: ttl_2_not_in_st,\n in_st_rate: ttl_2_in_st_rate,\n out_st: ttl_2_out_st,\n not_out_st: ttl_2_not_out_st,\n out_st_rate: ttl_2_out_st_rate,\n tot_in_qty: ttl_2_tot_in_qty,\n tot_sale_qty: ttl_2_tot_sale_qty,\n sale_rate_qty: ttl_2_sale_rate_qty,\n tot_in_cost_amt: ttl_2_tot_in_cost_amt,\n mark_up:ttl_2_mark_up,\n tot_in_tag: ttl_2_tot_in_tag,\n tot_sale_tag: ttl_2_tot_sale_tag,\n tot_sale_amt: ttl_2_tot_sale_amt,\n sale_rate_tag: ttl_2_sale_rate_tag,\n sale_rate_amt: ttl_2_sale_rate_amt,\n discount_rate: ttl_2_discount_rate,\n inven_qty: ttl_2_inven_qty,\n inven_tag: ttl_2_inven_tag,\n ttl_index: 2,\n monthly_sale_qty: ttl_2_monthly_sale_qty,\n monthly_sale_tag: ttl_2_monthly_sale_tag,\n monthly_sale_amt: ttl_2_monthly_sale_amt,\n last_week_sale_qty: ttl_2_last_week_sale_qty,\n last_week_sale_tag: ttl_2_last_week_sale_tag,\n last_week_sale_amt: ttl_2_last_week_sale_amt,\n last_week_progress_rate: ttl_2_last_week_progress_rate,\n this_week_sale_qty: ttl_2_this_week_sale_qty,\n this_week_sale_tag: ttl_2_this_week_sale_tag,\n this_week_sale_amt: ttl_2_this_week_sale_amt,\n this_week_progress_rate: ttl_2_this_week_progress_rate\n});\n\n// 총계 추가\n\nlet ttl_0_tot_ord_qty = ttl_1_tot_ord_qty + ttl_2_tot_ord_qty;\nlet ttl_0_tot_ord_tag = ttl_1_tot_ord_tag + ttl_2_tot_ord_tag;\nlet ttl_0_ord_st = ttl_1_ord_st + ttl_2_ord_st;\nlet ttl_0_in_st = ttl_1_in_st + ttl_2_in_st;\nlet ttl_0_not_in_st = ttl_1_not_in_st + ttl_2_not_in_st;\n\nlet ttl_0_in_st_rate = ttl_0_in_st / ttl_0_ord_st; // 기획대비입고율\n\nlet ttl_0_out_st = ttl_1_out_st + ttl_2_out_st;\nlet ttl_0_not_out_st = ttl_1_not_out_st + ttl_2_not_out_st;\n\n\nlet ttl_0_out_st_rate = ttl_0_out_st / ttl_0_ord_st; // 기획대비출고율\n\nlet ttl_0_tot_in_qty = ttl_1_tot_in_qty + ttl_2_tot_in_qty;\nlet ttl_0_tot_sale_qty = ttl_1_tot_sale_qty + ttl_2_tot_sale_qty;\n\n\nlet ttl_0_sale_rate_qty = ttl_0_tot_sale_qty / ttl_0_tot_in_qty; // 수량기준 판매율\n\nlet ttl_0_tot_in_cost_amt = ttl_1_tot_in_cost_amt + ttl_2_tot_in_cost_amt;\nlet ttl_0_tot_in_tag = ttl_1_tot_in_tag + ttl_2_tot_in_tag;\n\nlet ttl_0_mark_up = ttl_0_tot_in_tag/ttl_0_tot_in_cost_amt; //배수\n\nlet ttl_0_tot_sale_tag = ttl_1_tot_sale_tag + ttl_2_tot_sale_tag;\nlet ttl_0_tot_sale_amt = ttl_1_tot_sale_amt + ttl_2_tot_sale_amt;\n\nlet ttl_0_sale_rate_tag = ttl_0_tot_sale_tag / ttl_0_tot_in_tag; // 판매율(TAG)\n\nlet ttl_0_sale_rate_amt = ttl_0_tot_sale_amt / ttl_0_tot_in_tag; // 판매율(실매출)\n\nlet ttl_0_discount_rate = 1 - (ttl_0_tot_sale_amt / ttl_0_tot_sale_tag); // 할인율\n\nlet ttl_0_inven_qty = ttl_1_inven_qty + ttl_2_inven_qty;\nlet ttl_0_inven_tag = ttl_1_inven_tag + ttl_2_inven_tag;\nlet ttl_0_monthly_sale_qty = ttl_1_monthly_sale_qty + ttl_2_monthly_sale_qty;\nlet ttl_0_monthly_sale_tag = ttl_1_monthly_sale_tag + ttl_2_monthly_sale_tag;\nlet ttl_0_monthly_sale_amt = ttl_1_monthly_sale_amt + ttl_2_monthly_sale_amt;\nlet ttl_0_last_week_sale_qty = ttl_1_last_week_sale_qty + ttl_2_last_week_sale_qty;\nlet ttl_0_last_week_sale_tag = ttl_1_last_week_sale_tag + ttl_2_last_week_sale_tag;\nlet ttl_0_last_week_sale_amt = ttl_1_last_week_sale_amt + ttl_2_last_week_sale_amt;\n\nlet ttl_0_last_week_progress_rate = ttl_0_last_week_sale_tag / ttl_0_tot_in_tag; // 지난주 진도율\n\nlet ttl_0_this_week_sale_qty = ttl_1_this_week_sale_qty + ttl_2_this_week_sale_qty;\nlet ttl_0_this_week_sale_tag = ttl_1_this_week_sale_tag + ttl_2_this_week_sale_tag;\nlet ttl_0_this_week_sale_amt = ttl_1_this_week_sale_amt + ttl_2_this_week_sale_amt;\n\n\nlet ttl_0_this_week_progress_rate = ttl_0_this_week_sale_tag / ttl_0_tot_in_tag; // 이번주 진도율\n\n//  let ttl_0_in_rate_tag = ttl_0_tot_in_qty / ttl_0_tot_ord_qty; // 입고율\nlet ttl_0_in_rate_tag = ttl_0_tot_in_tag / ttl_0_tot_ord_tag; // 입고율\n\n\n////////// 총계 //////////\nlist.push({\n cat_nm: \"총계\",\n cat_id: 999,\n tot_ord_qty: ttl_0_tot_ord_qty,\n tot_ord_tag: ttl_0_tot_ord_tag,\n in_rate_tag: ttl_0_in_rate_tag,\n ord_st: ttl_0_ord_st,\n in_st: ttl_0_in_st,\n not_in_st: ttl_0_not_in_st,\n in_st_rate: ttl_0_in_st_rate,\n out_st: ttl_0_out_st,\n not_out_st: ttl_0_not_out_st,\n out_st_rate: ttl_0_out_st_rate,\n tot_in_qty: ttl_0_tot_in_qty,\n tot_sale_qty: ttl_0_tot_sale_qty,\n sale_rate_qty: ttl_0_sale_rate_qty,\n tot_in_cost_amt: ttl_0_tot_in_cost_amt,\n mark_up:ttl_0_mark_up,\n tot_in_tag: ttl_0_tot_in_tag,\n tot_sale_tag: ttl_0_tot_sale_tag,\n tot_sale_amt: ttl_0_tot_sale_amt,\n sale_rate_tag: ttl_0_sale_rate_tag,\n sale_rate_amt: ttl_0_sale_rate_amt,\n discount_rate: ttl_0_discount_rate,\n inven_qty: ttl_0_inven_qty,\n inven_tag: ttl_0_inven_tag,\n ttl_index: 0,\n monthly_sale_qty: ttl_0_monthly_sale_qty,\n monthly_sale_tag: ttl_0_monthly_sale_tag,\n monthly_sale_amt: ttl_0_monthly_sale_amt,\n last_week_sale_qty: ttl_0_last_week_sale_qty,\n last_week_sale_tag: ttl_0_last_week_sale_tag,\n last_week_sale_amt: ttl_0_last_week_sale_amt,\n last_week_progress_rate: ttl_0_last_week_progress_rate,\n this_week_sale_qty: ttl_0_this_week_sale_qty,\n this_week_sale_tag: ttl_0_this_week_sale_tag,\n this_week_sale_amt: ttl_0_this_week_sale_amt,\n this_week_progress_rate: ttl_0_this_week_progress_rate\n});\n\n\n// 매출비중 컬럼 추가\n\nlist.forEach(item => {\n item.sale_share_in = Number(item.tot_in_tag) / ttl_0_tot_in_tag;\n item.sale_share_out = Number(item.tot_sale_tag) / ttl_0_tot_sale_tag;\n});\n\nconsole.log(list);\n\nreturn list"
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
  <State id="var_brand_code" value="07" />
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
