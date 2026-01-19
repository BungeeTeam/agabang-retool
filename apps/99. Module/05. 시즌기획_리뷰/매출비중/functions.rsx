<GlobalFunctions>
  <SqlQuery
    id="get_sales_by_type"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_sales_by_type.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <Function
    id="transformer4"
    funcBody={include("./lib/transformer4.js", "string")}
  />
  <SqlQuery
    id="get_sales_by_tot"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_sales_by_tot.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <Function
    id="transformer2"
    funcBody={include("./lib/transformer2.js", "string")}
  />
  <SqlQuery
    id="get_supplies_sales"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_supplies_sales.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <Function
    id="transformer3"
    funcBody={include("./lib/transformer3.js", "string")}
  />
</GlobalFunctions>
