<GlobalFunctions>
  <SqlQuery
    id="season_list_new"
    query={include("./lib/season_list_new.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showFailureToaster={false}
    warningCodes={[]}
  />
  <State id="var_brand_code" value="01" />
  <JavascriptQuery
    id="get_same_weekday"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_same_weekday.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showFailureToaster={false}
    showSuccessToaster={false}
  />
  <SqlQuery
    id="salesByColor"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/salesByColor.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="const arrData = formatDataAsArray(data)

let filteredData;

if({{ radioGroup1.value === 'odd' }}){
  filteredData = arrData.filter(i => i.season_cd === {{ season_select.selectedItem.sesn_cd}})
} else if({{ radioGroup1.value === 'even' }}){
 filteredData = arrData.filter(i => Number(i.season_cd) === {{ Number(season_select.selectedItem.sesn_cd)+1}})
} else{
 filteredData = arrData
}

return formatDataAsObject(filteredData)"
    warningCodes={[]}
  />
  <JavascriptQuery
    id="set_params_onLoad"
    notificationDuration={4.5}
    query={include("./lib/set_params_onLoad.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    runWhenPageLoadsDelay="1000"
    showFailureToaster={false}
    showSuccessToaster={false}
  />
  <Function
    id="salesByLargeCat"
    funcBody={include("./lib/salesByLargeCat.js", "string")}
  />
  <Function
    id="salesByMiddleCat"
    funcBody={include("./lib/salesByMiddleCat.js", "string")}
  />
  <Function
    id="compareByLargeCat"
    funcBody={include("./lib/compareByLargeCat.js", "string")}
  />
  <State id="var_clicked_middle_cat" />
  <Function
    id="compare_yoy"
    funcBody={include("./lib/compare_yoy.js", "string")}
  />
  <State
    id="tableHeader"
    value={
      '[\n  { "id": "ord_qty", "label": "발주수량","parentKey": "발주" },\n  { "id": "ord_tag_amt", "label": "발주금액(TAG)","parentKey": "발주"  },\n  { "id": "in_rate", "label": "입고율(TAG)" ,"parentKey": "입고" },\n  { "id": "st_count", "label": "총 컬러수","parentKey": "입고" },\n  { "id": "in_st_count", "label": "입고 컬러수","parentKey": "입고" },\n  { "id": "not_in_st_count", "label": "미입고 컬러수","parentKey": "입고" },\n  { "id": "in_st_rate", "label": "기획대비 컬러 입고율","parentKey": "입고" },\n  { "id": "out_st_count", "label": "출고 컬러수","parentKey": "출고" },\n  { "id": "not_out_st_count", "label": "미출고 컬러수","parentKey": "출고" },\n  { "id": "out_st_rate", "label": "입고대비 컬러 출고율","parentKey": "출고" },\n  { "id": "tot_in_qty", "label": "총입고수량","parentKey": "입고" },\n  { "id": "tot_sale_qty", "label": "총판매수량","parentKey": "누적판매" },\n  { "id": "tot_sale_rate_qty", "label": "판매율(수량)","parentKey": "누적판매" },\n  { "id": "tot_in_cost", "label": "누적입고구입가(+)","parentKey": "입고" },\n  { "id": "markup", "label": "배수","parentKey": "입고" },\n  { "id": "tot_in_tag", "label": "누적입고금액(TAG)","parentKey": "입고" },\n  { "id": "tot_sale_tag", "label": "누적판매금액(TAG)","parentKey": "누적판매" },\n  { "id": "tot_sale_amt", "label": "누적실판매금액","parentKey": "누적판매" },\n  { "id": "tot_sale_rate_tag", "label": "누적판매율(TAG)","parentKey": "누적판매" },\n  { "id": "tot_sale_rate_amt", "label": "누적판매율(실매출)","parentKey": "누적판매" },\n  { "id": "discount_rate", "label": "할인율" },\n  { "id": "in_ratio", "label": "입고비중(TAG)","parentKey": "비중" },\n  { "id": "sale_ratio", "label": "판매비중(TAG)","parentKey": "비중" },\n  { "id": "inven_qty", "label": "재고수량","parentKey": "재고" },\n  { "id": "inven_tag", "label": "재고금액(TAG)","parentKey": "재고" },\n  { "id": "month_sale_qty", "label": "월간 판매수량","parentKey": "월간" },\n  { "id": "month_sale_tag", "label": "월간 판매금액(TAG)","parentKey": "월간" },\n  { "id": "month_sale_amt", "label": "월간 실판매금액","parentKey": "월간" },\n  { "id": "p_week_sale_qty", "label": "전주 판매수량","parentKey": "전주" },\n  { "id": "p_week_sale_tag", "label": "전주 판매금액(TAG)","parentKey": "전주" },\n  { "id": "p_week_sale_amt", "label": "전주 실판매금액","parentKey": "전주" },\n  { "id": "p_week_sale_rate", "label": "전주 판매 진도율","parentKey": "전주" },\n  { "id": "week_sale_qty", "label": "금주 판매수량","parentKey": "금주" },\n  { "id": "week_sale_tag", "label": "금주 판매금액(TAG)","parentKey": "금주" },\n  { "id": "week_sale_amt", "label": "금주 실판매금액","parentKey": "금주" },\n  { "id": "week_sale_rate", "label": "금주 판매 진도율","parentKey": "금주" },\n  { "id": "diff_sale_rate", "label": "진도율 차" }\n]'
    }
  />
  <Function
    id="compareByMiddleCat"
    funcBody={include("./lib/compareByMiddleCat.js", "string")}
  />
  <State id="var_item_info" />
  <SqlQuery
    id="get_latest_season"
    enableTransformer={true}
    importedQueryInputs={{
      ordered: [
        { variable0: "{{ var_brand_code.value }}" },
        { variable1: "1" },
      ],
    }}
    isImported={true}
    notificationDuration={4.5}
    playgroundQueryName="get_latest_seasons"
    playgroundQueryUuid="c13b268b-11f4-4fa8-ac73-f0b48d384738"
    query={include("./lib/get_latest_season.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    retoolVersion="3.148.10"
    showFailureToaster={false}
    showSuccessToaster={false}
    transformer="const Data = formatDataAsArray(data);

const seasonArr = Data.map(item => {
  const prefix = item.year_season_cd[0]; // 알파벳
  let num = parseInt(item.year_season_cd[1], 10); // 숫자 한 자리

  if (num % 2 === 0) {
    num -= 1; // 짝수면 직전 홀수로
  }

  return `${prefix}${num}`;
});

return seasonArr;"
    warningCodes={[]}
  />
  <SqlQuery
    id="season_list"
    isImported={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    playgroundQueryName="season_list_without_0code"
    playgroundQueryUuid="2107b35d-c8c3-443b-953b-751d38a2dd84"
    query={include("./lib/season_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    retoolVersion="3.148.10"
    showFailureToaster={false}
    showSuccessToaster={false}
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <JavascriptQuery
    id="setDownloadTablehidden"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/setDownloadTablehidden.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showFailureToaster={false}
    showSuccessToaster={false}
  />
</GlobalFunctions>
