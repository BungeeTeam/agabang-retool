<GlobalFunctions>
  <State id="var_brand_code" value="'79'" />
  <SqlQuery
    id="season_list_new"
    query={include("./lib/season_list_new.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <JavascriptQuery
    id="get_same_weekday"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_same_weekday.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="set_params_onLoad"
    notificationDuration={4.5}
    query={include("./lib/set_params_onLoad.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    runWhenPageLoadsDelay="1000"
    showSuccessToaster={false}
  />
  <SqlQuery
    id="salesByColor"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/salesByColor.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="const arrData = formatDataAsArray(data)

let filteredData;

if({{ radioGroup1.value === 'odd' }}){
  filteredData = arrData.filter(i => i.season_cd === {{ season_select.selectedItem.sesn_cd}})
} else if({{ radioGroup1.value === 'even' }}){
 filteredData = arrData.filter(i => Number(i.season_cd) === {{ Number(season_select.selectedItem.sesn_cd)+1}})
} else{
 filteredData = arrData
}

return formatDataAsObject(filteredData)"
    warningCodes={[]}
  />
  <Function
    id="salesByLargeCat"
    funcBody={include("./lib/salesByLargeCat.js", "string")}
  />
  <Function
    id="salesByMiddleCat"
    funcBody={include("./lib/salesByMiddleCat.js", "string")}
  />
  <Function
    id="compareByLargeCat"
    funcBody={include("./lib/compareByLargeCat.js", "string")}
  />
  <State id="var_clicked_middle_cat" />
  <Function
    id="compare_yoy"
    funcBody={include("./lib/compare_yoy.js", "string")}
  />
  <Function
    id="compareByMiddleCat"
    funcBody={include("./lib/compareByMiddleCat.js", "string")}
  />
  <State id="var_item_info" />
  <JavascriptQuery
    id="setDownloadTablehidden"
    notificationDuration={4.5}
    query={include("./lib/setDownloadTablehidden.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
</GlobalFunctions>
