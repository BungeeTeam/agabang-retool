<GlobalFunctions>
  <SqlQuery
    id="get_day_in_list"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/get_day_in_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="get_day_in_data"
    query={include("./lib/get_day_in_data.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <State id="var_sel_sty" value="" />
</GlobalFunctions>
