<GlobalFunctions>
  <Folder id="archive">
    <SqlQuery
      id="shopStatOverviewQueryNew"
      enableTransformer={true}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/shopStatOverviewQueryNew.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      showSuccessToaster={false}
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="setValue"
        params={{
          ordered: [
            {
              value:
                "{{shopStatOverviewQueryNew\n  .data\n  .filter(\n  item => item.sales_yr === moment(referenceDate.value).year() &&\n  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&\n  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD'))}}",
            },
          ],
        }}
        pluginId="thisYearList"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="success"
        method="setValue"
        params={{
          ordered: [
            {
              value:
                "{{shopStatOverviewQueryNew\n  .data\n  .filter(\n  item => item.sales_yr === moment(referenceDate.value).subtract(1,'years').year() &&\n  item.open_dt <= moment(referenceDate.value).subtract(1,'years').format('YYYY-MM-DD') &&\n  item.close_dt >= moment(referenceDate.value).subtract(1,'years').format('YYYY-MM-DD'))}}",
            },
          ],
        }}
        pluginId="lastYearList"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQuery>
    <State id="thisYearList" value="" />
    <State id="lastYearList" />
    <State
      id="thisYearListNew"
      value="{
'all': {{shopStatOverviewQueryNew.data.filter(
  item => item.sales_yr === moment(referenceDate.value).year())}},
'now_running': {{shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&
  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD'))  }},
'ongoing': {{shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.open_yr < moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&
  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD'))}},
'new': {{ shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.open_yr === moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD') &&
  item.close_dt >= moment(referenceDate.value).format('YYYY-MM-DD')) }},
'close' : {{ shopStatOverviewQueryNew
  .data
  .filter(
  item => item.sales_yr === moment(referenceDate.value).year() &&
  item.close_yr === moment(referenceDate.value).year() &&
  item.open_dt <= moment(referenceDate.value).format('YYYY-MM-DD')) }}
}"
    />
  </Folder>
  <SqlQuery
    id="shopInfoQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/shopInfoQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="getShopStat"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/getShopStat.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data).filter(i => i.biz_cd === {{ bizDivSelect.value }})"
    warningCodes={[]}
  />
  <Function
    id="groupByChannel"
    funcBody={include("./lib/groupByChannel.js", "string")}
  />
  <Function id="addTotal" funcBody={include("./lib/addTotal.js", "string")} />
  <State id="varSelectedChannel" />
</GlobalFunctions>
