<GlobalFunctions>
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
    id="getSalesByShop"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/getSalesByShop.sql", "string")}
    queryTimeout="30000"
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
    watchedParams={[
      "brandSelect.value",
      "bizSelect.value",
      "String.fromCharCode(seasonSelect.selectedItem.year_cd_ly.toUpperCase().charCodeAt(0)+1)",
      "seasonSelect.selectedItem.year_cd_ly",
      "itCodeSelect.value.slice(0,1)",
      "itCodeSelect.value",
      "dateRange.value?.start",
      "dateRange.value?.end",
      "Number(seasonSelect.selectedItem.season_cd) + switchGroup1.value[0] || null",
      "Number(seasonSelect.selectedItem.season_cd) + (switchGroup1.value[1]) || null",
    ]}
  />
  <SqlQuery
    id="getSeasonEndDate"
    cacheKeyTtl="3000"
    enableCaching={true}
    isMultiplayerEdited={false}
    query={include("./lib/getSeasonEndDate.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <Function
    id="salesByChannel"
    funcBody={include("./lib/salesByChannel.js", "string")}
  />
  <State id="varSelectedChannel" />
  <Function
    id="salesByShop"
    funcBody={include("./lib/salesByShop.js", "string")}
  />
  <State
    id="itCodeList"
    value="{
'DS':[
    {'it_code': '-1', 'label': '전체'},
    {'it_code': '2', 'label': '시즌의류(B)'},
    {'it_code': '3', 'label': '시즌의류(T)'},
    {'it_code': '1', 'label': '시즌언더'},
    {'it_code': '7', 'label': '시즌용품'},
    {'it_code': '4', 'label': '파자마'},
    {'it_code': '57', 'label': '기획언더'},
    {'it_code': '5', 'label': '기획의류'},
    {'it_code': '6', 'label': '위탁용품'},
    {'it_code': '8', 'label': '일반용품'},
    {'it_code': '9', 'label': '판촉부자재'}
],
'A1':[
    {'it_code': '-1', 'label': '전체'},
    {'it_code': '2', 'label': '시즌의류(B)'},
    {'it_code': '3', 'label': '시즌의류(T)'},
    {'it_code': '1', 'label': '시즌언더'},
    {'it_code': '7', 'label': '시즌용품'},
    {'it_code': '4', 'label': '파자마'},
    {'it_code': '57', 'label': '기획언더'},
    {'it_code': '5', 'label': '기획의류'},
    {'it_code': '6', 'label': '위탁용품'},
    {'it_code': '8', 'label': '일반용품'},
    {'it_code': '9', 'label': '판촉부자재'}
],
'A4':[
    {'it_code': '-1', 'label': '전체'},
    {'it_code': '2', 'label': '유아복'},
    {'it_code': '3', 'label': '토들러'},
    {'it_code': '1', 'label': '기초복'},
    {'it_code': '7', 'label': '시즌용품'},
    {'it_code': '4', 'label': '파자마'},
    {'it_code': '57', 'label': '기획언더'},
    {'it_code': '5', 'label': '기획의류'},
    {'it_code': '6', 'label': '위탁용품'},
    {'it_code': '8', 'label': '일반용품'},
    {'it_code': '9', 'label': '판촉부자재'}
],
'A12':[
    {'it_code': '-1', 'label': '전체'},
    {'it_code': '2', 'label': '시즌의류(B)'},
    {'it_code': '3', 'label': '시즌의류(T)'},
    {'it_code': '1', 'label': '시즌언더'},
    {'it_code': '7', 'label': '시즌용품'},
    {'it_code': '4', 'label': '파자마'},
    {'it_code': '57', 'label': '기획언더'},
    {'it_code': '5', 'label': '기획의류'},
    {'it_code': '6', 'label': '위탁용품'},
    {'it_code': '8', 'label': '일반용품'},
    {'it_code': '9', 'label': '판촉부자재'}
],
'A3':[
    {'it_code': '-1', 'label': '전체'},
    {'it_code': '2', 'label': '시즌의류(B)'},
    {'it_code': '3', 'label': '시즌의류(T)'},
    {'it_code': '1', 'label': '시즌언더'},
    {'it_code': '7', 'label': '시즌용품'},
    {'it_code': '4', 'label': '파자마'},
    {'it_code': '57', 'label': '기획언더'},
    {'it_code': '5', 'label': '기획의류'},
    {'it_code': '6', 'label': '위탁용품'},
    {'it_code': '8', 'label': '일반용품'},
    {'it_code': '9', 'label': '판촉부자재'}
],
'A9':[
    {'it_code': '-1', 'label': '전체'},
    {'it_code': '2', 'label': '시즌의류(B)'},
    {'it_code': '3', 'label': '시즌의류(T)'},
    {'it_code': '1', 'label': '시즌언더'},
    {'it_code': '7', 'label': '시즌용품'},
    {'it_code': '4', 'label': '파자마'},
    {'it_code': '57', 'label': '기획언더'},
    {'it_code': '5', 'label': '기획의류'},
    {'it_code': '6', 'label': '위탁용품'},
    {'it_code': '8', 'label': '일반용품'},
    {'it_code': '9', 'label': '판촉부자재'}
]
}"
  />
  <SqlQuery
    id="getSalesByShop_backup"
    cacheKeyTtl="40000"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/getSalesByShop_backup.sql", "string")}
    queryTimeout="30000"
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    warningCodes={[]}
  />
</GlobalFunctions>
