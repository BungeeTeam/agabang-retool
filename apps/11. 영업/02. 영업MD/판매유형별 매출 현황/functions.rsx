<GlobalFunctions>
  <Folder id="archive">
    <Function
      id="periodsalesBySupply"
      funcBody={include("./lib/periodsalesBySupply.js", "string")}
    />
    <Function
      id="quarterlySupply"
      funcBody={include("./lib/quarterlySupply.js", "string")}
    />
  </Folder>
  <SqlQuery
    id="shopInfoQuery"
    enableTransformer={true}
    query={include("./lib/shopInfoQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <State
    id="tableHeader"
    value="['매출',
'목표매출',
'{{ moment(dateRange.value?.end).format('YYYY') }}년 매출',
'{{ moment(dateRange.value?.end).format('YYYY') }}년 할인율',
'{{ moment(dateRange.value?.end).subtract(1,'years').format('YYYY') }}년 매출',
'{{ moment(dateRange.value?.end).subtract(1,'years').format('YYYY') }}년 할인율',
'매출증감',
'진행율',
'신장율',
'원가',
'{{ moment(dateRange.value?.end).format('YYYY') }}년 원가',
'{{ moment(dateRange.value?.end).format('YYYY') }}년 원가율',
'{{ moment(dateRange.value?.end).subtract(1,'years').format('YYYY') }}년 원가',
'{{ moment(dateRange.value?.end).subtract(1,'years').format('YYYY') }}년 원가율',
'원가증감',
'원가율증감',
'{{ moment(dateRange.value?.end).format('YYYY') }}년 매출비중',
'{{ moment(dateRange.value?.end).subtract(1,'years').format('YYYY') }}년 매출비중']

"
  />
  <State
    id="unitList"
    value="{
month_unit:[1,2,3,4,5,6,7,8,9,10,11,12],
quarter_unit: [1,2,3,4]
}"
  />
  <JavascriptQuery
    id="setPeriod"
    notificationDuration={4.5}
    query={include("./lib/setPeriod.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <SqlQuery
    id="periodicSalesByStyleQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/periodicSalesByStyleQuery.sql", "string")}
    queryFailureConditions={
      '[{"condition":"{{ error }}","message":"{{ data.isRetoolSystemError ? \'시스템 오류입니다.\':\'새로고침 해주세요\' }}"}]'
    }
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenPageLoads={true}
    transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)

// by biz_div
arrData = arrData.filter(item => {{ bizSelect.value }}.includes(item.biz_cd))                       

//  by brand
arrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))

return formatDataAsObject(arrData)"
    warningCodes={[]}
  />
  <SqlQuery
    id="periodicSalesBySupplyStyleQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/periodicSalesBySupplyStyleQuery.sql", "string")}
    queryFailureConditions={
      '[{"condition":"{{ error }}","message":"{{ data.isRetoolSystemError ? \'시스템 오류입니다.\':\'새로고침 해주세요\' }}"}]'
    }
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)

// by biz_div
arrData = arrData.filter(item => {{ bizSelect.value }}.includes(item.biz_cd))                       

//  by brand
arrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))

return formatDataAsObject(arrData)"
    warningCodes={[]}
  />
  <Function id="indexing" funcBody={include("./lib/indexing.js", "string")} />
  <Function
    id="monthlySupply"
    funcBody={include("./lib/monthlySupply.js", "string")}
  />
  <Function id="monthly" funcBody={include("./lib/monthly.js", "string")} />
  <Function id="quarterly" funcBody={include("./lib/quarterly.js", "string")} />
  <Function id="periodic" funcBody={include("./lib/periodic.js", "string")} />
  <SqlQuery
    id="periodicTargetSales"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/periodicTargetSales.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)

// by biz_div
arrData = arrData.filter(item => {{ bizSelect.value }}.includes(item.biz_cd))                       


return formatDataAsObject(arrData)"
    warningCodes={[]}
  />
  <SqlQueryUnified
    id="targetRate"
    query={include("./lib/targetRate.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    warningCodes={[]}
  />
  <Function
    id="targetSalesBySalesType"
    funcBody={include("./lib/targetSalesBySalesType.js", "string")}
  />
  <JavascriptQuery
    id="monthlyExcelDownload"
    notificationDuration={4.5}
    query={include("./lib/monthlyExcelDownload.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="quarterlyExcelDownload"
    notificationDuration={4.5}
    query={include("./lib/quarterlyExcelDownload.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="periodicExcelDownload"
    notificationDuration={4.5}
    query={include("./lib/periodicExcelDownload.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
</GlobalFunctions>
