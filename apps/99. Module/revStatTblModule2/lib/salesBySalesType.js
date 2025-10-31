const sumKeys = ["rev"]
const data = {{ inputDataByStyle.value }}
let arrData = formatDataAsArray(data)
  .filter(item => item.onoff_flag === "오프라인")
  .filter(item => item.biz_cd === {{ selectedRow.value.biz_cd }})

const keys = ["sales_type"]
const groupedArr = groupBySum(arrData, ["time_unit", ...keys], sumKeys)

let result = pivotData(groupedArr, keys, "time_unit", sumKeys)

return result
  .sort((a, b) => b.sales_type.localeCompare(a.sales_type, "ko"))