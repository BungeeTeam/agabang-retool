<GlobalFunctions>
  <State
    id="thisYear"
    value="{{ new Date().getFullYear() <=  moment(inputDateRange.value.start).year() ? new Date().getFullYear() : moment(inputDateRange.value.start).year() }} "
  />
  <State id="selectedSalesRow" value={'{"team_cd": "01", "biz_cd": "A1"}'} />
  <State id="selectedRow" value={'{"team_cd": "01", "biz_cd": "A1"}'} />
  <Function
    id="salesByType"
    funcBody={include("./lib/salesByType.js", "string")}
  />
  <Function
    id="salesByBiz"
    funcBody={include("./lib/salesByBiz.js", "string")}
  />
  <Function
    id="salesByOnoff"
    funcBody={include("./lib/salesByOnoff.js", "string")}
  />
  <Function
    id="salesByTeam"
    funcBody={include("./lib/salesByTeam.js", "string")}
  />
  <Function
    id="salesByArea"
    funcBody={include("./lib/salesByArea.js", "string")}
  />
  <Function
    id="salesByUser"
    funcBody={include("./lib/salesByUser.js", "string")}
  />
  <Function
    id="salesBySubBrand"
    funcBody={include("./lib/salesBySubBrand.js", "string")}
  />
  <Function
    id="salesBySalesType"
    funcBody={include("./lib/salesBySalesType.js", "string")}
  />
  <Function
    id="salesBySeason"
    funcBody={include("./lib/salesBySeason.js", "string")}
  />
  <Function
    id="salesByStyle"
    funcBody={include("./lib/salesByStyle.js", "string")}
  />
  <Function
    id="salesByFirstLevel"
    funcBody={include("./lib/salesByFirstLevel.js", "string")}
  />
  <Function
    id="salesBySecondLevel"
    funcBody={include("./lib/salesBySecondLevel.js", "string")}
  />
  <Function
    id="salesByShop"
    funcBody={include("./lib/salesByShop.js", "string")}
  />
  <Function id="salesByGb" funcBody={include("./lib/salesByGb.js", "string")} />
  <Function
    id="salesBySupply"
    funcBody={include("./lib/salesBySupply.js", "string")}
  />
  <Function
    id="salesBySecondLevelWithBiz"
    funcBody={include("./lib/salesBySecondLevelWithBiz.js", "string")}
  />
  <State id="variable4" value="" />
  <JavascriptQuery
    id="excelDownloadByBiz"
    notificationDuration={4.5}
    query={include("./lib/excelDownloadByBiz.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
</GlobalFunctions>
