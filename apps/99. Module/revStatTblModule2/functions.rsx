<GlobalFunctions>
  <Folder id="transform">
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
    <Function
      id="salesByGb"
      funcBody={include("./lib/salesByGb.js", "string")}
    />
    <Function
      id="salesBySecondLevelWithBiz"
      funcBody={include("./lib/salesBySecondLevelWithBiz.js", "string")}
    />
  </Folder>
  <Folder id="excelDownload">
    <JavascriptQuery
      id="excelDownloadByType"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadByType.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadByBiz"
      notificationDuration={4.5}
      query={include("./lib/excelDownloadByBiz.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadByOnOff"
      notificationDuration={4.5}
      query={include("./lib/excelDownloadByOnOff.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadByTeam"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadByTeam.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadByArea"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadByArea.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadByUser"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadByUser.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadBySubBrand"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadBySubBrand.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadBySalesType"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadBySalesType.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadBySeason"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadBySeason.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadByStyle"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadByStyle.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadByFirstLevel"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadByFirstLevel.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadBySecondLevel"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadBySecondLevel.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadByShop"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadByShop.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadByGB"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadByGB.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadBySecondLevelWithBiz"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/excelDownloadBySecondLevelWithBiz.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
  </Folder>
  <Folder id="archive">
    <State id="variable4" value="" />
    <Function
      id="salesBySupply"
      funcBody={include("./lib/salesBySupply.js", "string")}
    />
  </Folder>
  <State
    id="thisYear"
    value="{{ new Date().getFullYear() <=  moment(inputDateRange.value.start).year() ? new Date().getFullYear() : moment(inputDateRange.value.start).year() }} "
  />
  <State id="selectedSalesRow" value={'{"team_cd": "01", "biz_cd": "A1"}'} />
  <State id="selectedRow" value={'{"team_cd": "01", "biz_cd": "A1"}'} />
</GlobalFunctions>
