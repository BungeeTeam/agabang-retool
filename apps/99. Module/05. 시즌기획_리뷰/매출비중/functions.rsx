<GlobalFunctions>
  <SqlQuery
    id="get_season_sales"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_season_sales.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="// Reference external variables with curly brackets or using JS variables
const arrData = formatDataAsArray(data)

// 사용 예시
const result = addRevenueRates(arrData); // data = 질문에 올린 배열


return result"
    warningCodes={[]}
  />
  <SqlQuery
    id="get_tot_sales"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_tot_sales.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="const arrData = formatDataAsArray(data);

const result = addRevenueRates(arrData); 

return result"
    warningCodes={[]}
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
    transformer="const arrData = formatDataAsArray(data);

const result = addRevenueRates(arrData); 

return result"
    warningCodes={[]}
  />
</GlobalFunctions>
