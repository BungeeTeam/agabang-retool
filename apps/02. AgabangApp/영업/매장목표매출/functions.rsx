<GlobalFunctions>
  <State
    id="monthList"
    value="{{ [...Array(new Date().getMonth() + 10).keys()] }}"
  />
  <SqlQuery
    id="shopInfoQuery"
    cacheKeyTtl="21600"
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
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)

// by biz_div
arrData = arrData.filter(item => {{ bizMultiSelect.value }}.includes(item.biz_cd))                       

//  by brand
arrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))

return formatDataAsObject(arrData)"
    warningCodes={[]}
  />
  <SqlQuery
    id="periodicSalesQuery"
    cacheKeyTtl="3600"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/periodicSalesQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showSuccessToaster={false}
    transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)

// by biz_div
arrData = arrData.filter(item => {{ bizMultiSelect.value }}.includes(item.biz_cd))                       

//  by brand
arrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))

return formatDataAsObject(arrData)"
    warningCodes={[]}
  />
  <SqlQuery
    id="monthlySalesByStyleQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/monthlySalesByStyleQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showSuccessToaster={false}
    transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)

// by biz_div
arrData = arrData.filter(item => {{ bizMultiSelect.value }}.includes(item.biz_cd))                       

//  by brand
arrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))

return formatDataAsObject(arrData)"
    warningCodes={[]}
  />
  <SqlQuery
    id="periodicSalesByStyleQuery"
    cacheKeyTtl="3600"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/periodicSalesByStyleQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showSuccessToaster={false}
    transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)

// by biz_div
arrData = arrData.filter(item => {{ bizMultiSelect.value }}.includes(item.biz_cd))                       

//  by brand
arrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))

return formatDataAsObject(arrData)"
    warningCodes={[]}
  />
</GlobalFunctions>
