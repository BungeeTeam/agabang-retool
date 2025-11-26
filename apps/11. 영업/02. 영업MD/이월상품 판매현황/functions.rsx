<GlobalFunctions>
  <State id="varSelectedRow" />
  <SqlQuery
    id="shopInfoQuery"
    enableTransformer={true}
    query={include("./lib/shopInfoQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="getOutEndDate"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/getOutEndDate.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="getSeasonEndDate"
    cacheKeyTtl="30000"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/getSeasonEndDate.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="const arrData = formatDataAsArray(data)

const updatedData = arrData.map(item => {
  if (item.br_cd === '79' && item.year_cd === 'S' && item.season_cd === '5') {
    return { ...item, last_season_end_dt: '2025-01-15' };
  }
  return item;
});

return formatDataAsObject(updatedData)"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get2YearsResult"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <SqlQuery
    id="getShopSaleByCategory"
    cacheKeyTtl={300}
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/getShopSaleByCategory.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    runWhenPageLoadsDelay="1000"
    showFailureToaster={false}
    successMessage="매출 데이터를 불러오는데 성공했습니다."
    transformer="let arrData = formatDataAsArray(data)

return arrData"
    warningCodes={[]}
  />
  <SqlQuery
    id="getShopOutByCategory"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/getShopOutByCategory.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    successMessage="출고 데이터를 불러오는데 성공했습니다."
    transformer="return formatDataAsArray(data)
  //  .filter(i=>i.br_cd === {{ brandMultiSelect2.value }})"
    warningCodes={[]}
  />
  <State id="varResult" />
  <JavascriptQuery
    id="setShopListFrameHidden"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/setShopListFrameHidden.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
    updateSetValueDynamically={true}
  />
  <JavascriptQuery
    id="get2YearsResult"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get2YearsResult.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoadsDelay="1000"
    showSuccessToaster={false}
    updateSetValueDynamically={true}
  >
    <Event
      event="success"
      method="refresh"
      params={{
        ordered: [
          {
            options: { ordered: [{ block: "nearest" }, { behavior: "auto" }] },
          },
        ],
      }}
      pluginId="table6"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
  </JavascriptQuery>
  <Function
    id="mergePrevOutSale"
    funcBody={include("./lib/mergePrevOutSale.js", "string")}
  />
  <Function
    id="mergeCurOutSale"
    funcBody={include("./lib/mergeCurOutSale.js", "string")}
  />
  <Function
    id="groupByCategory"
    funcBody={include("./lib/groupByCategory.js", "string")}
  />
  <Function
    id="groupByGrade"
    funcBody={include("./lib/groupByGrade.js", "string")}
  />
  <Function
    id="groupByShop"
    funcBody={include("./lib/groupByShop.js", "string")}
  />
  <Function
    id="summaryData"
    funcBody={include("./lib/summaryData.js", "string")}
  />
  <SqlQuery
    id="getOnlineWarehouseByCategory"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/getOnlineWarehouseByCategory.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    successMessage="온라인 창고 데이터를 불러오는데 성공했습니다."
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <Function
    id="shopDetailData"
    funcBody={include("./lib/shopDetailData.js", "string")}
  />
  <Function
    id="processCurrentOnlineWarehouse"
    funcBody={include("./lib/processCurrentOnlineWarehouse.js", "string")}
  />
  <Function
    id="processPrevOnlineWarehouse"
    funcBody={include("./lib/processPrevOnlineWarehouse.js", "string")}
  />
  <SqlQuery
    id="getDefaultSeason"
    enableTransformer={true}
    query={include("./lib/getDefaultSeason.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data).map(i=>i.year_season_cd)"
    warningCodes={[]}
  />
  <JavascriptQuery
    id="excelDownloadByCategory"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/excelDownloadByCategory.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="excelDownloadSummary"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/excelDownloadSummary.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="excelDownloadByShop"
    notificationDuration={4.5}
    query={include("./lib/excelDownloadByShop.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
</GlobalFunctions>
