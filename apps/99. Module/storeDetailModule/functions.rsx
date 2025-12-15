<GlobalFunctions>
  <Folder id="variables">
    <State
      id="selectedRow"
      value="{
shop_cd : '124901',
shop_nm: '월계이마트아가방갤러리'
}"
    />
    <State id="selectedInventoryRow" value="" />
    <State id="thisYear" value="{{ new Date().getFullYear() }} " />
  </Folder>
  <Folder id="excelDownload">
    <JavascriptQuery
      id="excelDownloadByShop"
      notificationDuration={4.5}
      query={include("./lib/excelDownloadByShop.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadShopSalesByMonth"
      notificationDuration={4.5}
      query={include("./lib/excelDownloadShopSalesByMonth.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <JavascriptQuery
      id="excelDownloadshopSalesByBrand"
      notificationDuration={4.5}
      query={include("./lib/excelDownloadshopSalesByBrand.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
  </Folder>
  <Function
    id="salesByShop"
    funcBody={include("./lib/salesByShop.js", "string")}
  />
  <SqlQuery
    id="shopInfoQuery"
    isMultiplayerEdited={false}
    query={include("./lib/shopInfoQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    warningCodes={[]}
  />
  <SqlQuery
    id="shopSalesByOnline"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/shopSalesByOnline.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
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
      'function groupBySum(arr, groupKeys, sumKeys) {\n  return Object.values(\n    arr.reduce((acc, item) => {\n      const key = groupKeys.map(k => item[k]).join("-");\n\n      if (!acc[key]) {\n        acc[key] = Object.fromEntries(groupKeys.map(k => [k, item[k]]));\n        sumKeys.forEach(sumKey => {\n          acc[key][sumKey] = Number(item[sumKey]) || 0;\n        });\n      } else {\n        sumKeys.forEach(sumKey => {\n          acc[key][sumKey] += Number(item[sumKey]) || 0;\n        });\n      }\n      return acc;\n    }, {})\n  );\n}\n\nfunction pivotData(data) {\n  data.sort((a, b) => {\n    if (a.연도 !== b.연도) return b.연도 - a.연도;\n    return a.정상구분.localeCompare(b.정상구분);\n  });\n\n  let pivoted = {};\n  data.forEach(row => {\n    let key = `${row.연도}-${row.정상구분}`;\n    if (!pivoted[key]) {\n      pivoted[key] = { 연도: row.연도, 정상구분: row.정상구분 };\n    }\n    pivoted[key][row.카테고리] = row.매출 || 0;\n  });\n\n  return Object.values(pivoted).sort((a, b) => b.연도 - a.연도)\n}\n\nlet arrayData = formatDataAsArray(data)\nif ({{ brandTabbedContainer.currentViewKey }} !== "-1") {\n  arrayData = arrayData.filter(item => item.biz_cd === {{ brandTabbedContainer.currentViewKey }})\n} \n\n// Add the row-wise totals\nconst totalsMap = arrayData.reduce((acc, cur) => {\n    const key = `${cur.연도}_${cur.카테고리}`;\n    if (!acc[key]) {\n        acc[key] = {\n            연도: cur.연도,\n            카테고리: cur.카테고리,\n            매출: 0,\n        };\n    }\n\n    acc[key].매출 += cur.매출;\n    return acc;\n}, {});\n\nconst totalRows = Object.values(totalsMap).map(totalItem => {\n    return {\n        연도: totalItem.연도,\n        정상구분: "총계",\n        할인구분: "총계",\n        카테고리: totalItem.카테고리,\n        매출: totalItem.매출,\n        shop_cd: null,\n        shop_nm: "합계",\n        biz_cd: null \n    };\n});\n\narrayData = [...arrayData, ...totalRows];\n\nif ({{is_on_sale_detail.value}}) {\n  arrayData = groupBySum(arrayData, ["연도", "정상구분", "할인구분", "카테고리"], ["매출"])\n  arrayData = arrayData\n    .map(row => ({\n      ...row,\n      정상구분: row.할인구분\n    }))\n    .map(({할인구분, ...rest}) => rest)\n} else {\n  arrayData = groupBySum(arrayData, ["연도", "정상구분", "카테고리"], ["매출"])\n}\n\narrayData = pivotData(arrayData)\n\n// Add the total\narrayData = arrayData.map(item => {\n  const total = Object.entries(item)\n    .filter(([key]) => key !== "연도" && key !== "정상구분")\n    .reduce((acc, [, value]) => acc + value, 0);\n  return {\n    ...item,\n    total\n  };\n});\n\nconst sumStat = groupBySum(arrayData.filter(item => item.정상구분 !== "총계"), ["연도"], ["total"])\n \narrayData = arrayData\n  .map(item => {\n    return {...item, ratio: item.total/(sumStat.filter(ele => ele.연도 === item.연도)[0]["total"])}\n  })\n\nreturn arrayData.sort((a, b) => {\n    const yearA = Number(a.연도);\n    const yearB = Number(b.연도);\n    if (yearA !== yearB) return yearB - yearA;\n    if (a.카테고리 !== b.카테고리) return a.카테고리.localeCompare(b.카테고리);\n    if (a.정상구분 === "총계" && b.정상구분 !== "총계") return 1;\n    if (a.정상구분 !== "총계" && b.정상구분 === "총계") return -1;\n    return a.정상구분.localeCompare(b.정상구분);\n});'
    }
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
    id="shopSalesQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/shopSalesQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer={
      'const timeOpt = {{ timeTabbedContainer.currentViewKey }}\nconst sumKeys = ["판매금액"]\n\nlet groupKeys\nif (timeOpt === "daily") {\n  groupKeys = ["yr", "sale_dt"]\n} else if (timeOpt === "month") {\n  groupKeys = ["yr", "year_month"]\n} else if (timeOpt === "qaurter") {\n  groupKeys = ["yr", "year_quarter"]\n} else {\n  groupKeys = ["yr"]\n}\n\nconst arrData = formatDataAsArray(data)\nconst groupedArr = groupBySum(arrData, groupKeys, sumKeys)\n\nconst currentYear = new Date().getFullYear()\nif (timeOpt === "month") {\n  const filteredArr = groupedArr.filter(item => item.yr >= currentYear - 2)\n  return formatDataAsObject(filteredArr)\n} else if (timeOpt === "daily") {\n  const startDate = {{ startDate.value }}\n  const filteredArr = groupedArr.filter(item => item.yr >= currentYear && item.sale_dt >= startDate)\n  return formatDataAsObject(filteredArr)\n}\n\nreturn formatDataAsObject(groupedArr) '
    }
    warningCodes={[]}
  />
  <SqlQuery
    id="shopTargetSalesQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/shopTargetSalesQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer={
      'const timeOpt = {{ timeTabbedContainer.currentViewKey }}\nconst sumKeys = ["목표매출"]\n\nlet groupKeys\nif (timeOpt === "daily") {\n  groupKeys = ["yr", "plan_dt"]\n} else if (timeOpt === "month") {\n  groupKeys = ["yr", "yr_month"]\n} else if (timeOpt === "qaurter") {\n  groupKeys = ["yr_quarter"]\n} else {\n  groupKeys = ["yr"]\n}\n\nconst arrData = formatDataAsArray(data)\nconst groupedArr = groupBySum(arrData, groupKeys, sumKeys)\n\nif (timeOpt === "month") {\n  const currentYear = new Date().getFullYear();\n  const filteredArr = groupedArr.filter(item => item.yr >= currentYear - 2)\n  return formatDataAsObject(filteredArr)\n} else if (timeOpt === "daily") {\n  const startDate = {{ startDate.value }}\n  const filteredArr = groupedArr.filter(item => item.plan_dt >= startDate)\n  return formatDataAsObject(filteredArr)\n} else {\n  return formatDataAsObject(groupedArr) \n}'
    }
    warningCodes={[]}
  />
  <SqlQuery
    id="shopSalesTrendByBrandQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/shopSalesTrendByBrandQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer={
      'let arrData = formatDataAsArray(data)\nconst curViewKey = {{ brTabbedContainer.currentViewKey }}\nif (curViewKey === "share") {\n  arrData = groupBySum(arrData, ["yr", "br_cd"], ["sales_price"])\n  const totalByYear = arrData.reduce((acc, cur) => {\n    const yr = cur.yr\n    if (!acc[yr]) {\n      acc[yr] = 0  \n    }\n    acc[yr] += cur?.sales_price || 0\n    return acc\n  }, {})\n  const groupedArr = pivotData(arrData, ["br_cd"], ["yr"], ["sales_price"])\n  groupedArr.map(obj => {\n    const keys = Object.keys(obj);\n    keys.forEach(key => {\n      if (key !== "br_cd") {\n        obj[key] /= totalByYear[key]\n      }\n    })\n    return obj\n  })\n  return groupedArr.sort((a, b) => a.br_cd - b.br_cd)\n} else {\n  arrData = arrData.filter(obj => obj.yr === {{ thisYear.value }})\n  arrData = groupBySum(arrData, ["br_cd"], ["sales_price"]).sort((a, b) => b.sales_price - a.sales_price)\n  return formatDataAsObject(arrData)  \n}'
    }
    warningCodes={[]}
  />
  <SqlQuery
    id="shopInventoryByStyleQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/shopInventoryByStyleQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer={
      'const selectedBr = {{ invenBrSelect.value }}\nlet arrData = formatDataAsArray(data)\nif (selectedBr !== "전체") {\n  arrData = arrData.filter(obj => obj.br_nm === selectedBr)\n}\nreturn arrData'
    }
    warningCodes={[]}
  />
  <SqlQuery
    id="shopInventoryByStyleInPeriodQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/shopInventoryByStyleInPeriodQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer={
      'const selectedBr = {{ invenBrSelect.value }}\nlet arrData = formatDataAsArray(data)\nif (selectedBr !== "전체") {\n  arrData = arrData.filter(obj => obj.br_nm === selectedBr)\n}\nreturn arrData'
    }
    warningCodes={[]}
  />
  <Function
    id="mergeShopInventoryByStyleQuery"
    funcBody={include("./lib/mergeShopInventoryByStyleQuery.js", "string")}
  />
  <Function
    id="shopInvenBySmallCatQuery"
    funcBody={include("./lib/shopInvenBySmallCatQuery.js", "string")}
  />
  <Function
    id="shopInvenByMiddleCatQuery"
    funcBody={include("./lib/shopInvenByMiddleCatQuery.js", "string")}
  />
  <Function
    id="shopInvenByLargeCatQuery"
    funcBody={include("./lib/shopInvenByLargeCatQuery.js", "string")}
  />
  <Function
    id="shopInvenByYear"
    funcBody={include("./lib/shopInvenByYear.js", "string")}
  />
  <Function
    id="shopInvenBySeason"
    funcBody={include("./lib/shopInvenBySeason.js", "string")}
  />
  <Function
    id="shopSalesByMonth"
    funcBody={include("./lib/shopSalesByMonth.js", "string")}
  />
  <SqlQuery
    id="rtInfoByShop"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/rtInfoByShop.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQuery
    id="shopSalesByBrandByMonth"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/shopSalesByBrandByMonth.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer={
      'function groupBySum(arr, groupKeys, sumKeys) {\n  return Object.values(\n    arr.reduce((acc, item) => {\n      const key = groupKeys.map(k => item[k]).join("-");\n\n      if (!acc[key]) {\n        acc[key] = Object.fromEntries(groupKeys.map(k => [k, item[k]]));\n        sumKeys.forEach(sumKey => {\n          acc[key][sumKey] = Number(item[sumKey]) || 0;\n        });\n      } else {\n        sumKeys.forEach(sumKey => {\n          acc[key][sumKey] += Number(item[sumKey]) || 0;\n        });\n      }\n      return acc;\n    }, {})\n  );\n}\n\nlet arrData = formatDataAsArray(data)\nconst selectedOpt = {{ tabbedContainer1.currentViewKey }}\nif (selectedOpt === "pie") {\n  arrData = groupBySum(arrData, ["br_cd"], ["sales_price"])\n}\n\nreturn formatDataAsObject(arrData)'
    }
    warningCodes={[]}
  />
  <SqlQuery
    id="shopTargetSalesByMonth"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/shopTargetSalesByMonth.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="// 원본 데이터
const rawData = formatDataAsArray(data)

// 월 이름 배열 (순서대로)
const months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];

// 데이터 변환 함수
function transformData(data) {
  // 사업부 코드별로 그룹화
  const grouped = data.reduce((acc, curr) => {
    if (!acc[curr.biz_cd]) {
      acc[curr.biz_cd] = {};
    }
    // 월 이름을 소문자로 변환
    const monthKey = curr.month_unit.toLowerCase();
    // target_sales를 숫자로 변환
    acc[curr.biz_cd][monthKey] = Number(curr.target_sales) || 0;
    return acc;
  }, {});

  // 결과 배열 생성
  const result = Object.keys(grouped).map(biz_cd => {
    const row = { biz_cd };
    let total = 0;

    // 각 월에 대해 값 할당 (없으면 0)
    months.forEach(month => {
      const value = grouped[biz_cd][month] || 0;
      row[month] = value;
      total += value;
    });

    // total 컬럼 추가
    row.total = total;

    // 컬럼 순서 재정렬 (br_cd, total, 월별 순서)
    const orderedRow = {
      biz_cd: row.biz_cd,
      total: row.total,
      ...months.reduce((acc, month) => {
        acc[month] = row[month];
        return acc;
      }, {})
    };

    return orderedRow;
  });

  return result;
}

// 데이터 변환 실행
const transformedData = transformData(rawData);

// 결과 출력
return transformedData"
    warningCodes={[]}
  />
  <SqlQuery
    id="shopReceiptStat"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/shopReceiptStat.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <Function
    id="shopSalesByMonth_backup"
    funcBody={include("./lib/shopSalesByMonth_backup.js", "string")}
  />
</GlobalFunctions>
