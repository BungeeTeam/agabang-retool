<GlobalFunctions>
  <State id="thisYear" value="{{ new Date().getFullYear() }}" />
  <State
    id="monthList"
    value="{{ [...Array(12)].map((_,i) =>{
	return i;
}) }}"
  />
  <SqlQuery
    id="shopInfoQuery"
    cacheKeyTtl="3600"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/shopInfoQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    retoolVersion="3.114.3"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="monthlySalesQuery"
    cacheKeyTtl="3600"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/monthlySalesQuery.sql", "string")}
    queryFailureConditions={'[{"condition":"","message":""}]'}
    queryTimeout="60000"
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showFailureToaster={false}
    showSuccessToaster={false}
    transformer="let arrData = formatDataAsArray(data)

const bizLists = {{ bizMultiSelect.value }}
const brLists = {{ brandMultiSelect.value }}

arrData = arrData.filter(item => bizLists.includes(item.biz_cd) && brLists.includes(item.br_cd))

return formatDataAsObject(arrData)"
    warningCodes={[]}
    watchedParams={["bizMultiSelect.value", "brandMultiSelect.value"]}
  />
  <SqlQuery
    id="periodicSalesQuery"
    cacheKeyTtl="10800"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/periodicSalesQuery.sql", "string")}
    queryTimeout="60000"
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showFailureToaster={false}
    showSuccessToaster={false}
    transformer="let arrData = formatDataAsArray(data)

const bizLists = {{ bizMultiSelect.value }}
const brLists = {{ brandMultiSelect.value }}

arrData = arrData.filter(item => bizLists.includes(item.biz_cd) && brLists.includes(item.br_cd))

return formatDataAsObject(arrData)"
    warningCodes={[]}
    watchedParams={["bizMultiSelect.value", "brandMultiSelect.value"]}
  />
  <SqlQuery
    id="monthlySalesByStyleQuery"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/monthlySalesByStyleQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="periodicSalesByStyleQuery"
    cacheKeyTtl="10800"
    enableCaching={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/periodicSalesByStyleQuery.sql", "string")}
    queryTimeout="60000"
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <Function
    id="salesBySecondLevelWithBiz"
    funcBody={include("./lib/salesBySecondLevelWithBiz.js", "string")}
  />
</GlobalFunctions>
