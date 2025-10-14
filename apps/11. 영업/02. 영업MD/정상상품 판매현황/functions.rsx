<GlobalFunctions>
  <Folder id="archive">
    <Function
      id="periodsalesBySupply"
      funcBody={include("./lib/periodsalesBySupply.js", "string")}
    />
    <State
      id="periodList"
      value="{
month_unit:[1,2,3,4,5,6,7,8,9,10,11,12],
quarter_unit: [1,2,3,4]
}"
    />
    <Function id="monthly" funcBody={include("./lib/monthly.js", "string")} />
    <Function
      id="monthlySupply"
      funcBody={include("./lib/monthlySupply.js", "string")}
    />
    <Function
      id="quarterly"
      funcBody={include("./lib/quarterly.js", "string")}
    />
    <Function
      id="quarterlySupply"
      funcBody={include("./lib/quarterlySupply.js", "string")}
    />
    <SqlQuery
      id="periodicSalesBySupplyStyleQuery"
      enableTransformer={true}
      isMultiplayerEdited={false}
      query={include("./lib/periodicSalesBySupplyStyleQuery.sql", "string")}
      queryFailureConditions={'[{"condition":"","message":""}]'}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      runWhenModelUpdates={false}
      showFailureToaster={false}
      transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)

// by biz_div
arrData = arrData.filter(item => {{ bizSelect.value }}.includes(item.biz_cd))                       

//  by brand
//  arrData = arrData.filter(item => {{ brandSelect.value }}.includes(item.br_cd))

return formatDataAsObject(arrData)"
      warningCodes={[]}
    />
    <Function
      id="quarterly_backup"
      funcBody={include("./lib/quarterly_backup.js", "string")}
    />
  </Folder>
  <State
    id="tableHeader"
    value="['매출',
'목표매출',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 매출',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 할인율',
'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 매출',
'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 할인율',
'매출증감',
'진행율',
'매출 신장율',
'원가',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 원가',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 원가율',
'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 원가',
'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 원가율',
'원가증감',
'원가율증감',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 매출비중',
'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 매출비중',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 수량 판매율 (누적)',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 실판가 판매율 (누적)',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 판매수량',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 입고수량',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 입고금액',
'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 판매수량',

'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 입고금액',
'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 입고수량',
'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 수량 판매율 (누적)',
'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 실판가 판매율 (누적)',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 매출 (누적)',
'{{ moment(dateRange.value?.start).format('YYYY') }}년 판매수량 (누적)',
'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 매출 (누적)',
'{{ moment(dateRange.value?.start).subtract(1,'years').format('YYYY') }}년 판매수량 (누적)']

"
  />
  <SqlQuery
    id="shopInfoQuery"
    enableTransformer={true}
    query={include("./lib/shopInfoQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="periodicSalesByStyleQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/periodicSalesByStyleQuery.sql", "string")}
    queryFailureConditions={
      '[{"condition":"{{ error }}","message":"쿼리오류"}]'
    }
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)

// by biz_div
arrData = arrData.filter(item => {{ bizSelect.value }}.includes(item.biz_cd))                       

//  by brand
//  arrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))

return formatDataAsObject(arrData)"
    warningCodes={[]}
  />
  <Function id="indexing" funcBody={include("./lib/indexing.js", "string")} />
  <Function
    id="periodicSalesByCategory"
    funcBody={include("./lib/periodicSalesByCategory.js", "string")}
  />
  <Function id="summary" funcBody={include("./lib/summary.js", "string")} />
  <SqlQuery
    id="shopSalesSummary"
    isMultiplayerEdited={false}
    query={include("./lib/shopSalesSummary.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    warningCodes={[]}
  />
  <State id="varShopSalesSummary" />
  <SqlQuery
    id="shopSalesCatogory"
    cacheKeyTtl="3"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/shopSalesCatogory.sql", "string")}
    queryTimeout="30000"
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <State id="varShopSalesCatogory" />
  <Function id="transformer10" />
</GlobalFunctions>
