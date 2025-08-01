const currentYear = new Date().getFullYear()
const sumKeys = ["rev"]
const groupKeys = ["shop_cd", "shop_nm"]
const data = {{ inputData.value }}
let arrData = formatDataAsArray(data)

const groupedArr = groupBySum(arrData, ["time_unit", ...groupKeys], sumKeys)
const targetArr = groupBySum(arrData.filter(obj => obj.time_unit === currentYear), groupKeys, ["target_sales"])
const result = pivotData(groupedArr, groupKeys, "time_unit", sumKeys)

const thisYear = new Date().getFullYear().toString()
return result
  .filter(ele => thisYear in ele)
  .map(item => {
  const matched = targetArr.find((ele) =>
    groupKeys.every((key) => ele[key] === item[key])
  );
  return {...item, target_sales: matched ? matched.target_sales : 0}
})
.sort((a, b) => b?.[thisYear] - a?.[thisYear])