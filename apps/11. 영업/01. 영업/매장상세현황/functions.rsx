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
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    transformer={
      '// // FILTER by selected options\n// let arrData = formatDataAsArray(data)\n\n// // by biz_div\n// arrData = arrData.filter(item => {{ bizMultiSelect.value }}.includes(item.biz_cd))                       \n\n// //  by brand\n// arrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))\n\n// //  by tp\n// const selectedTpCd = {{ tpSelect.value }}\n// if (selectedTpCd !== "-1") {\n//   arrData = arrData.filter(item => item.tp_cd === selectedTpCd)\n// }\n\n// //  by team\n// const selectedTeamCd = {{ teamSelect.value }}\n// if (selectedTeamCd !== "-1") {\n//   arrData = arrData.filter(item => item.team_cd === selectedTeamCd)\n// }\n\n// //  by user\n// const selectedUserCd = {{ userSelect.value }}\n// if (selectedUserCd !== "-1") {\n//   arrData = arrData.filter(item => item.user_cd === selectedUserCd)\n// }\n\n// //  by area\n// const selectedAreaCd = {{ areaSelect.value }}\n// if (selectedAreaCd !== "-1") {\n//   arrData = arrData.filter(item => item.area_cd === selectedAreaCd)\n// }\n\n// return formatDataAsObject(arrData)'
    }
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
    showSuccessToaster={false}
    transformer={
      '// FILTER by selected options\nlet arrData = formatDataAsArray(data)\narrData =  arrData.filter(item => item?.rev !== 0 || item?.target_sales > 0)\n\n//  by tp\nconst selectedTpCd = {{ tpSelect.value }}\nif (selectedTpCd !== "-1") {\n  arrData = arrData.filter(item => item.tp_cd === selectedTpCd)\n}\n\n//  by team\nconst selectedTeamCd = {{ teamSelect.value }}\nif (selectedTeamCd !== "-1") {\n  arrData = arrData.filter(item => item.team_cd === selectedTeamCd)\n}\n\n//  by user\nconst selectedUserCd = {{ userSelect.selectedItem.user_cd }}\nconst selectedUserTeamCd = {{ userSelect.selectedItem.team_cd }}\nif (selectedUserCd !== "-1") {\n  arrData = arrData.filter(item => item.user_cd === selectedUserCd && item.team_cd === selectedUserTeamCd)\n}\n\n//  by area\nconst selectedAreaCd = {{ areaSelect.value }}\nif (selectedAreaCd !== "-1") {\n  arrData = arrData.filter(item => item.area_cd === selectedAreaCd)\n}\n\nreturn formatDataAsObject(arrData)'
    }
    warningCodes={[]}
    watchedParams={[
      "areaSelect.value",
      "userSelect.selectedItem.team_cd",
      "userSelect.selectedItem.user_cd",
      "teamSelect.value",
      "tpSelect.value",
      "searchText.value",
      "brandMultiSelect.value.join(\"','\")",
      "bizMultiSelect.value.join(\"','\")",
      "moment(dateRange.value.end).subtract('years',2).year()",
      "dateRange.value.end",
      "dateRange.value.start",
    ]}
  />
</GlobalFunctions>
