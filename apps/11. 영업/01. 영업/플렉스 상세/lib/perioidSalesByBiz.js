const data = {{ periodicFlexSalesQuery.data }}
let arrData = formatDataAsArray(data)

const sumKeys = ["rev"]
const groupKeys = ["biz_cd", "biz_nm"]

const groupedArr = groupBySum(arrData, ["time_unit", ...groupKeys], sumKeys)
const targetArr = groupBySum(arrData, groupKeys, ["target_sales"])
const result = pivotData(groupedArr, groupKeys, "time_unit", [sumKeys])

const yearKeys = getLastNYears(3)
const totalRevByYears = {};
yearKeys.forEach(year => {
  totalRevByYears[year] = result.reduce((acc, cur) => acc + (cur[year] || 0), 0)
})

return result.map(item => {
  yearKeys.forEach(yr => {
    const revShare = totalRevByYears[yr] > 0? ((item[yr] || 0) / totalRevByYears[yr]) : 0;
    item[`${yr}_share`] = revShare;
  })
  const matched = targetArr.find((ele) =>
    groupKeys.every((key) => ele[key] === item[key])
  );
  return {...item, target_sales: matched ? matched.target_sales : 0}
})