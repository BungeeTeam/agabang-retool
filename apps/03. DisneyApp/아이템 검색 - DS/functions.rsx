<GlobalFunctions>
  <SqlQuery
    id="get_item_list"
    query={include("./lib/get_item_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <State id="var_item_info" />
  <Function
    id="item_filtering"
    funcBody={include("./lib/item_filtering.js", "string")}
  />
</GlobalFunctions>
