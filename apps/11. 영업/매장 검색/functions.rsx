<GlobalFunctions>
  <SqlQuery
    id="shopInfoQuery"
    cacheKeyTtl="30000"
    enableCaching={true}
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/shopInfoQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="getShopList"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/getShopList.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer={
      '// FILTER by selected options\nlet arrData = formatDataAsArray(data)\narrData =  arrData\n  .filter(item => item?.rev !== 0)\n\nconst selectedBizCd = {{ select1.value }}\nif (selectedBizCd !== "-1") {\n  arrData = arrData.filter(item => item.biz_cd === selectedBizCd)\n}\n\nreturn formatDataAsObject(arrData)'
    }
    warningCodes={[]}
    watchedParams={["select1.value"]}
  />
  <Function
    id="groupByBizCd"
    funcBody={include("./lib/groupByBizCd.js", "string")}
  />
  <Function
    id="searchTextTransform"
    funcBody={include("./lib/searchTextTransform.js", "string")}
  />
  <Function id="transformer3" />
</GlobalFunctions>
