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
    id="yearlySalesQuery"
    cacheKeyTtl="3600"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/yearlySalesQuery.sql", "string")}
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
    transformer={
      '// FILTER by selected options\nlet arrData = formatDataAsArray(data)\n\n// by biz_div\nif({{ bizMultiSelect.value }} != "-1") {\n arrData = arrData.filter(item => item.biz_cd === {{ bizMultiSelect.value }})                       \n}\n\n//  by brand\narrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))\n\n// by sub-brand\n//  arrData = arrData.filter(item => {{ subBrandMultiSelect.value}}.includes(item.sub_br_cd))\n\n// by on or offline\narrData = arrData.filter(item => item.onoff_flag === {{ onoffControl.value }})\n\nreturn formatDataAsObject(arrData)'
    }
    warningCodes={[]}
  />
  <SqlQuery
    id="dailySalesQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/dailySalesQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showSuccessToaster={false}
    transformer={
      '// FILTER by selected options\nlet arrData = formatDataAsArray(data)\n\n// by biz_div\nif({{ bizMultiSelect.value }} != "-1") {\n arrData = arrData.filter(item => item.biz_cd === {{ bizMultiSelect.value }})                       \n}\n\n//  by brand\narrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))\n\n// by sub-brand\n//  arrData = arrData.filter(item => {{ subBrandMultiSelect.value}}.includes(item.sub_br_cd))\n\n// by on or offline\narrData = arrData.filter(item => item.onoff_flag === {{ onoffControl.value }})\n\nreturn formatDataAsObject(arrData)'
    }
    warningCodes={[]}
  />
  <SqlQuery
    id="periodicSalesQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/periodicSalesQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showSuccessToaster={false}
    transformer={
      '// FILTER by selected options\nlet arrData = formatDataAsArray(data)\n\n// by biz_div\nif({{ bizMultiSelect.value }} != "-1") {\n arrData = arrData.filter(item => item.biz_cd === {{ bizMultiSelect.value }})                       \n}\n\n//  by brand\narrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))\n\n// by sub-brand\n//  arrData = arrData.filter(item => {{ subBrandMultiSelect.value}}.includes(item.sub_br_cd))\n\n// by on or offline\narrData = arrData.filter(item => item.onoff_flag === {{ onoffControl.value }})\n\nreturn formatDataAsObject(arrData)'
    }
    warningCodes={[]}
  />
  <SqlQuery
    id="yearlySalesByStyleQuery"
    cacheKeyTtl="3600"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/yearlySalesByStyleQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showSuccessToaster={false}
    transformer={
      '// FILTER by selected options\nlet arrData = formatDataAsArray(data)\n\n// by biz_div\nif({{ bizMultiSelect.value }} != "-1") {\narrData = arrData.filter(item => item.biz_cd === {{ bizMultiSelect.value }})                       \n}\n\n//  by brand\narrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))\n\nreturn formatDataAsObject(arrData)'
    }
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
    transformer={
      '// FILTER by selected options\nlet arrData = formatDataAsArray(data)\n\n// by biz_div\nif({{ bizMultiSelect.value }} != "-1") {\narrData = arrData.filter(item => item.biz_cd === {{ bizMultiSelect.value }})                       \n}\n\n//  by brand\narrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))\n\n// by sub-brand\n//  arrData = arrData.filter(item => {{ subBrandMultiSelect.value}}.includes(item.sub_br_cd))\n\n// by on or offline\narrData = arrData.filter(item => item.onoff_flag === {{ onoffControl.value }})\n\nreturn formatDataAsObject(arrData)'
    }
    warningCodes={[]}
  />
  <SqlQuery
    id="dailySalesByStyleQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/dailySalesByStyleQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showSuccessToaster={false}
    transformer={
      '// FILTER by selected options\nlet arrData = formatDataAsArray(data)\n\n// by biz_div\nif({{ bizMultiSelect.value }} != "-1") {\narrData = arrData.filter(item => item.biz_cd === {{ bizMultiSelect.value }})                       \n}\n\n//  by brand\narrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))\n\n// by sub-brand\n//  arrData = arrData.filter(item => {{ subBrandMultiSelect.value}}.includes(item.sub_br_cd))\n\n// by on or offline\narrData = arrData.filter(item => item.onoff_flag === {{ onoffControl.value }})\n\nreturn formatDataAsObject(arrData)'
    }
    warningCodes={[]}
  />
  <SqlQuery
    id="periodicSalesByStyleQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/periodicSalesByStyleQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showSuccessToaster={false}
    transformer={
      '// FILTER by selected options\nlet arrData = formatDataAsArray(data)\n\n// by biz_div\nif({{ bizMultiSelect.value }} != "-1") {\narrData = arrData.filter(item => item.biz_cd === {{ bizMultiSelect.value }})                       \n}\n\n//  by brand\narrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))\n\n// by sub-brand\n//  arrData = arrData.filter(item => {{ subBrandMultiSelect.value}}.includes(item.sub_br_cd))\n\n// by on or offline\narrData = arrData.filter(item => item.onoff_flag === {{ onoffControl.value }})\n\nreturn formatDataAsObject(arrData)'
    }
    warningCodes={[]}
  />
</GlobalFunctions>
