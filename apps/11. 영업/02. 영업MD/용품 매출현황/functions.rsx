<GlobalFunctions>
  <Folder id="variables">
    <State id="varAppTitle" />
    <State id="varDateRange" />
    <State
      id="selectedRow"
      value="{
'title' : '매장리스트 타이틀 예시'
}"
    />
    <State id="varApp" />
    <SqlQuery
      id="shopInfoQuery"
      enableTransformer={true}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/shopInfoQuery.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      showSuccessToaster={false}
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    />
  </Folder>
  <SqlQuery
    id="periodicSalesByStyleQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/periodicSalesByStyleQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)

// by biz_div
arrData = arrData.filter(item => {{ bizMultiSelect2.value }}.includes(item.biz_cd))                       

//  by brand
arrData = arrData.filter(item => {{ brandMultiSelect2.value }}.includes(item.br_cd))

//  by sub_brand
arrData = arrData.filter(item => {{ subBrandMultiSelect3.value }}.includes(item.sub_br_cd))

return arrData"
    warningCodes={[]}
  />
  <State
    id="unitList"
    value="{
periodic:[''],
monthly:[1,2,3,4,5,6,7,8,9,10,11,12],
quarterly: [1,2,3,4]
}"
  />
</GlobalFunctions>
