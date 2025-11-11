<GlobalFunctions>
  <SqlQuery
    id="bizList"
    notificationDuration={4.5}
    query={include("./lib/bizList.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="subBrandList"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/subBrandList.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    transformer="let subBrandList = formatDataAsArray(data).map(item => item.sub_br_nm)
const brList = {{ periodicFlexSalesQuery.data }}
let arrData = formatDataAsArray(brList)

const uniqueNames = [...new Set(arrData.map(item => item.br_nm))]

const koreanCollator = new Intl.Collator('ko-KR');

return [...new Set([...uniqueNames, ...subBrandList])].filter(item => item !== null).sort(koreanCollator.compare)
"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="run"
      params={{ ordered: [] }}
      pluginId=""
      type="script"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <SqlQuery
    id="periodicFlexSalesQuery"
    cacheKeyTtl="10800"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/periodicFlexSalesQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    showSuccessToaster={false}
    transformer="// FILTER by selected options
let arrData = formatDataAsArray(data)
arrData = arrData.filter(item => item.rev && {{ bizMultiSelect.value }}.includes(item.biz_cd))
return formatDataAsObject(arrData)"
    warningCodes={[]}
  />
  <SqlQuery
    id="periodicFlexSalesQueryByStyle"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/periodicFlexSalesQueryByStyle.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    transformer="let arrData = formatDataAsArray(data)
arrData = arrData.filter(item => {{ bizMultiSelect.value }}.includes(item.biz_cd))
return formatDataAsObject(arrData)"
    warningCodes={[]}
  />
  <Function
    id="periodicSalesByBrand"
    funcBody={include("./lib/periodicSalesByBrand.js", "string")}
  />
  <Function
    id="periodSalesByBizShop"
    funcBody={include("./lib/periodSalesByBizShop.js", "string")}
  />
  <Function
    id="periodSalesByBrShop"
    funcBody={include("./lib/periodSalesByBrShop.js", "string")}
  />
  <Function
    id="perioidSalesByBiz"
    funcBody={include("./lib/perioidSalesByBiz.js", "string")}
  />
  <State id="selectedRow" value="{}" />
  <State id="currentYear" value="{{ new Date().getFullYear() }} " />
</GlobalFunctions>
