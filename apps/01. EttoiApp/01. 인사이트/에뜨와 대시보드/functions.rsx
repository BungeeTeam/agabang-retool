<GlobalFunctions>
  <SqlQuery
    id="get_shop_list"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_shop_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="get_sty_list"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_sty_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="get_season_list"
    notificationDuration={4.5}
    query={include("./lib/get_season_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="get_top_sty"
    notificationDuration={4.5}
    query={include("./lib/get_top_sty.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="get_top_shop"
    notificationDuration={4.5}
    query={include("./lib/get_top_shop.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="get_day_sales_trend"
    notificationDuration={4.5}
    query={include("./lib/get_day_sales_trend.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
</GlobalFunctions>
