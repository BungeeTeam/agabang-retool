const currentYear = {{ thisYear.value }}
const sumKeys = ["rev"]
const groupKeys = ["onoff_flag"]
const data = {{ inputData.value }}
const arrData = formatDataAsArray(data)

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
  .filter(obj => obj?.[currentYear] && obj[currentYear] !== 0)
  .sort((a, b) => a.onoff_flag.localeCompare(b.onoff_flag, "ko"))