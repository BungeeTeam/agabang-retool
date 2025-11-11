<GlobalFunctions>
  <SqlQuery
    id="get_week_list_current"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/get_week_list_current.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="let result = formatDataAsArray(data)

result.forEach((item) => {
  item.br_cd = item.sty_cd.substring(0,2)
  item.sesn_cd = item.sty_cd.substring(2,4)
  item.category = item.sty_cd.substring(4,5)
  item.it_gb_cd = item.sty_cd.substring(4,6)
  item.it_gb_nm = item.sty_nm.substring(0,3)
  //  console.log(`==>> category : ${item.category}, typepof: ${typeof item.category}`)
  
  return item
})


return result"
    warningCodes={[]}
  />
  <SqlQuery
    id="get_week_list_previous"
    enableTransformer={true}
    query={include("./lib/get_week_list_previous.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="let result = formatDataAsArray(data)

result?.forEach((item) => {
  item.br_cd = item.sty_cd.substring(0,2)
  item.sesn_cd = item.sty_cd.substring(2,4)
  item.category = item.sty_cd.substring(4,5)
  item.it_gb_cd = item.sty_cd.substring(4,6)
  item.it_gb_nm = item.sty_nm.substring(0,3)
})

return result"
    warningCodes={[]}
  />
  <SqlQuery
    id="get_season_code_list_new_01"
    enableTransformer={true}
    query={include("./lib/get_season_code_list_new_01.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="const result = formatDataAsArray(data)
return result"
    warningCodes={[]}
  />
  <SqlQuery
    id="get_season_code_list_new_02"
    enableTransformer={true}
    query={include("./lib/get_season_code_list_new_02.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="const result = formatDataAsArray(data)
return result"
    warningCodes={[]}
  />
  <SqlQuery
    id="get_season_code_list_old_01"
    enableTransformer={true}
    query={include("./lib/get_season_code_list_old_01.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="let result = formatDataAsArray(data)
return result"
    warningCodes={[]}
  />
  <SqlQuery
    id="get_season_code_list_old_02"
    enableTransformer={true}
    query={include("./lib/get_season_code_list_old_02.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="let result = formatDataAsArray(data)
return result"
    warningCodes={[]}
  />
  <Function
    id="var_week_data"
    funcBody={include("./lib/var_week_data.js", "string")}
  />
  <Function
    id="var_week_result"
    funcBody={include("./lib/var_week_result.js", "string")}
  />
  <Function
    id="var_goods_data"
    funcBody={include("./lib/var_goods_data.js", "string")}
  />
</GlobalFunctions>
