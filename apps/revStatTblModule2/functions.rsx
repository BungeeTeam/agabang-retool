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
    id="salesByStyle"
    funcBody={include("./lib/salesByStyle.js", "string")}
  />
  <Function
    id="salesByShop"
    funcBody={include("./lib/salesByShop.js", "string")}
  />
  <State id="selectedShopInfo" value={'""'} />
  <SqlQuery
    id="shopInfoQuery"
    query={include("./lib/shopInfoQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    warningCodes={[]}
  />
  <SqlQuery
    id="shopInventoryQuery"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/shopInventoryQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="shopSalesQuaterlyQuery"
    enableTransformer={true}
    query={include("./lib/shopSalesQuaterlyQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="function pivotData(data) {
  const arrayedData = formatDataAsArray(data)
  const pivoted = {}
  arrayedData.map((row) => {
    let year = row.sales_year
    let q = `q${row.sales_q}`
    if(!pivoted[year]) {
      pivoted[year] = { sales_year: year}
    }
    pivoted[year][q] = row?.판매금액 || 0
  })

  for (const year in pivoted) {
    pivoted[year].total = (Number(pivoted[year]?.q1) || 0) 
      + (Number(pivoted[year]?.q2) || 0)
      + (Number(pivoted[year]?.q3) || 0) 
      + (Number(pivoted[year]?.q4) || 0)
  }
  return Object.values(pivoted)
}

return pivotData(data).sort((a, b) => b.sales_year - a.sales_year)"
    warningCodes={[]}
  />
  <SqlQuery
    id="shopSalesByBrandQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/shopSalesByBrandQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer={
      'function groupBySum(arr, groupKeys, sumKeys) {\n  return Object.values(\n    arr.reduce((acc, item) => {\n      const key = groupKeys.map(k => item[k]).join("-");\n\n      if (!acc[key]) {\n        acc[key] = Object.fromEntries(groupKeys.map(k => [k, item[k]]));\n        sumKeys.forEach(sumKey => {\n          acc[key][sumKey] = Number(item[sumKey]) || 0;\n        });\n      } else {\n        sumKeys.forEach(sumKey => {\n          acc[key][sumKey] += Number(item[sumKey]) || 0;\n        });\n      }\n      return acc;\n    }, {})\n  );\n}\n\nfunction pivotData(data) {\n\n\n  data.sort((a, b) => {\n    if (a.연도 !== b.연도) return b.연도 - a.연도;\n    return a.정상구분.localeCompare(b.정상구분);\n  });\n\n  let pivoted = {};\n  data.forEach(row => {\n    let key = `${row.연도}-${row.정상구분}`;\n    if (!pivoted[key]) {\n      pivoted[key] = { 연도: row.연도, 정상구분: row.정상구분 };\n    }\n    pivoted[key][row.카테고리] = row.매출 || 0;\n  });\n\n  return Object.values(pivoted).sort((a, b) => b.연도 - a.연도)\n}\nlet arrayData = formatDataAsArray(data)\nif ({{ brandTabbedContainer.currentViewKey }} !== "-1") {\n  arrayData = arrayData.filter(item => item.br_cd === {{ brandTabbedContainer.currentViewKey }})\n} \narrayData = groupBySum(arrayData, ["연도", "정상구분", "카테고리"], ["매출"])\narrayData = pivotData(arrayData)\n\n// Add the total\narrayData = arrayData.map(item => {\n  const total = Object.entries(item)\n    .filter(([key]) => key !== "연도" && key !== "정상구분")\n    .reduce((acc, [, value]) => acc + value, 0);\n  \n  return {\n    ...item,\n    total\n  };\n});\n\nconst sumStat = groupBySum(arrayData, ["연도"], ["total"])\n \nreturn arrayData.map(item => ({...item, ratio: item.total/(sumStat.filter(ele => ele.연도 === item.연도)[0]["total"])}))'
    }
    warningCodes={[]}
  />
  <SqlQuery
    id="shopSalesMonthlyQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/shopSalesMonthlyQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <SqlQuery
    id="totalInventoryQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/totalInventoryQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="shopTargetSalesMonthlyQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/shopTargetSalesMonthlyQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
</GlobalFunctions>
