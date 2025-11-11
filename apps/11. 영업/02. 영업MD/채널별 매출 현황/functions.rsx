<GlobalFunctions>
  <Folder id="archive">
    <Function
      id="transformer4"
      funcBody={include("./lib/transformer4.js", "string")}
    />
    <State
      id="monthList"
      value="{{ [...Array(new Date().getMonth() + 10).keys()] }}"
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
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      transformer={
        '// // FILTER by selected options\n// let arrData = formatDataAsArray(data)\n\n// // by biz_div\n// arrData = arrData.filter(item => {{ bizSelect.value }}.includes(item.biz_cd))                       \n\n// //  by brand\n// arrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))\n\n// //  by tp\n// const selectedTpCd = {{ tpSelect.value }}\n// if (selectedTpCd !== "-1") {\n//   arrData = arrData.filter(item => item.tp_cd === selectedTpCd)\n// }\n\n// //  by team\n// const selectedTeamCd = {{ teamSelect.value }}\n// if (selectedTeamCd !== "-1") {\n//   arrData = arrData.filter(item => item.team_cd === selectedTeamCd)\n// }\n\n// //  by user\n// const selectedUserCd = {{ userSelect.value }}\n// if (selectedUserCd !== "-1") {\n//   arrData = arrData.filter(item => item.user_cd === selectedUserCd)\n// }\n\n// //  by area\n// const selectedAreaCd = {{ areaSelect.value }}\n// if (selectedAreaCd !== "-1") {\n//   arrData = arrData.filter(item => item.area_cd === selectedAreaCd)\n// }\n\n// return formatDataAsObject(arrData)'
      }
      warningCodes={[]}
    />
    <SqlQuery
      id="dailyShopOutCount2"
      enableTransformer={true}
      query={include("./lib/dailyShopOutCount2.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      transformer="return formatDataAsArray(data)
"
      warningCodes={[]}
    />
    <SqlQuery
      id="dailyShopOutCount"
      enableTransformer={true}
      query={include("./lib/dailyShopOutCount.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      transformer="return formatDataAsArray(data)
"
      warningCodes={[]}
    />
    <SqlQuery
      id="periodicSalesQuery"
      cacheKeyTtl="10800"
      enableCaching={true}
      enableTransformer={true}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/periodicSalesQuery.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      transformer={
        '// FILTER by selected options\nlet arrData = formatDataAsArray(data)\narrData =  arrData.filter(item => item.rev && item?.rev > 0)\n\n// by biz_div\narrData = arrData.filter(item => {{ bizSelect.value }}.includes(item.biz_cd))                       \n\n//  by brand\narrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))\n\n//  by tp\nconst selectedTpCd = {{ tpSelect.value }}\nif (selectedTpCd !== "-1") {\n  arrData = arrData.filter(item => item.tp_cd === selectedTpCd)\n}\n\n//  by team\nconst selectedTeamCd = {{ teamSelect.value }}\nif (selectedTeamCd !== "-1") {\n  arrData = arrData.filter(item => item.team_cd === selectedTeamCd)\n}\n\n//  by user\nconst selectedUserCd = {{ userSelect.value }}\nif (selectedUserCd !== "-1") {\n  arrData = arrData.filter(item => item.user_cd === selectedUserCd)\n}\n\n//  by area\nconst selectedAreaCd = {{ areaSelect.value }}\nif (selectedAreaCd !== "-1") {\n  arrData = arrData.filter(item => item.area_cd === selectedAreaCd)\n}\n\nreturn formatDataAsObject(arrData)'
      }
      warningCodes={[]}
    />
    <Function id="transformer3" />
  </Folder>
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
    cacheKeyTtl="40000"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/getSalesByShop.sql", "string")}
    queryTimeout="30000"
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
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
    id="query8"
    query={include("./lib/query8.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <SqlQuery
    id="query9"
    query={include("./lib/query9.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <SqlQuery
    id="query10"
    notificationDuration={4.5}
    query={include("./lib/query10.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="query11"
    query={include("./lib/query11.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
</GlobalFunctions>
