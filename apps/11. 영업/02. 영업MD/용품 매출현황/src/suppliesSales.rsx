<Screen
  id="suppliesSales"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title={null}
  urlSlug="SuppliesSales2"
>
  <Folder id="archive">
    <Function
      id="getPeriodicSalesByStyleQuery2"
      funcBody={include("../lib/getPeriodicSalesByStyleQuery2.js", "string")}
    />
    <Function
      id="groupByItGbSubBrand_backup2"
      funcBody={include("../lib/groupByItGbSubBrand_backup2.js", "string")}
    />
  </Folder>
  <Function
    id="filterBySelectedRow2"
    funcBody={include("../lib/filterBySelectedRow2.js", "string")}
  />
  <Function
    id="groupByItem2"
    funcBody={include("../lib/groupByItem2.js", "string")}
  />
  <SqlQuery
    id="getOutByShop2"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("../lib/getOutByShop2.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="getSalesByShop2"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("../lib/getSalesByShop2.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="let arrData = formatDataAsArray(data)
//  arrData = arrData.filter(item => item.cur_amt && item?.cur_amt > 0)

// by biz_div
arrData = arrData.filter(item => {{ bizMultiSelect3.value }}.includes(item.biz_cd))                       

//  by brand
arrData = arrData.filter(item => {{ brandMultiSelect3.value }}.includes(item.br_cd))


//  by sub-brand
arrData = arrData.filter(item => {{ subBrandMultiSelect2.value }}.includes(item.sub_br_cd))


return arrData"
    warningCodes={[]}
  />
  <State id="selectedRow2" />
  <Function
    id="groupBySubBrand2"
    funcBody={include("../lib/groupBySubBrand2.js", "string")}
  />
  <JavascriptQuery
    id="SuppliesSetValue2"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("../lib/SuppliesSetValue2.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
  <Function
    id="groupByItGb2"
    funcBody={include("../lib/groupByItGb2.js", "string")}
  />
  <Include src="./modalFrameShopList2.rsx" />
  <Frame
    id="$main6"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="0"
    sticky={null}
    type="main"
  >
    <Include src="./container11.rsx" />
  </Frame>
</Screen>
