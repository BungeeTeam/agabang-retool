const currentYear = {{ thisYear.value }}
const sumKeys = ["rev"]
const groupKeys = ["area_cd", "area_nm"]
const data = {{ inputData.value }}
let arrData = formatDataAsArray(data)

const onoff_flag = {{ selectedRow.value.onoff_flag }}
arrData = arrData.filter(item => item.onoff_flag === onoff_flag?.replace("(전국)", ""))

const groupedArr = groupBySum(arrData, ["time_unit", ...groupKeys], sumKeys)
const targetArr = groupBySum(arrData.filter(obj => obj.time_unit === currentYear), groupKeys, ["target_sales"])
const result = pivotData(groupedArr, groupKeys, "time_unit", sumKeys)

return result
  .map(item => {
  const matched = targetArr.find((ele) =>
    groupKeys.every((key) => ele[key] === item[key])
  );
  return {...item, target_sales: matched ? matched.target_sales : 0}
})
  .sort((a, b) => b["2025"] - a["2025"])