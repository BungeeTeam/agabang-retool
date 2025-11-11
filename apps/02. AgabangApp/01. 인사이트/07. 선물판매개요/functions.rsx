<GlobalFunctions>
  <SqlQuery
    id="giftSalesQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/giftSalesQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <Instrumentation
    id="testAnalytics"
    hasConditionsEnabled={true}
    properties={[
      { ordered: [{ pluginId: "giftSalesQuery" }, { property: "finished" }] },
    ]}
  />
  <SqlQuery
    id="giftSalesByBrandQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/giftSalesByBrandQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="giftSalesByBrandStatistics"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/giftSalesByBrandStatistics.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="giftSalesTrend"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/giftSalesTrend.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
</GlobalFunctions>
