<GlobalFunctions>
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
    id="salesBySeasonYear"
    funcBody={include("./lib/salesBySeasonYear.js", "string")}
  />
  <Function
    id="salesByStyle"
    funcBody={include("./lib/salesByStyle.js", "string")}
  />
  <Function
    id="salesByShop"
    funcBody={include("./lib/salesByShop.js", "string")}
  />
  <State id="selectedRow" value={'{"team_cd": "01", "biz_cd": "A1"}'} />
  <SqlQuery
    id="expectedTargetSalesQuery"
    enableTransformer={true}
    query={include("./lib/expectedTargetSalesQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="shopInfoQuery"
    query={include("./lib/shopInfoQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    warningCodes={[]}
  />
</GlobalFunctions>
