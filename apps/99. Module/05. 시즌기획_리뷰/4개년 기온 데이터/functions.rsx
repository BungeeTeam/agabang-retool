<GlobalFunctions>
  <SqlQuery
    id="get_region"
    query={include("./lib/get_region.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <SqlQuery
    id="get_weather"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_weather.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="weather_table_data"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <JavascriptQuery
    id="weather_table_data"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/weather_table_data.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
</GlobalFunctions>
