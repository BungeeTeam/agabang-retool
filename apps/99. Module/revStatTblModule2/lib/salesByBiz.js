const currentYear = {{ thisYear.value }}
const sumKeys = ["rev"]
const groupKeys = ["biz_cd", "biz_nm"]
const data = {{ inputData.value }}
const arrData = formatDataAsArray(data).filter(item => item.onoff_flag === "오프라인")

const groupedArr = groupBySum(arrData, ["time_unit", ...groupKeys], sumKeys)
const targetArr = groupBySum(arrData.filter(obj => obj.time_unit === currentYear), groupKeys, ["target_sales"])
const result = pivotData(groupedArr, groupKeys, "time_unit", sumKeys)
return result.map(item => {
  const matched = targetArr.find((ele) =>
    groupKeys.every((key) => ele[key] === item[key])
  );
  return {...item, target_sales: matched ? matched.target_sales : 0}
})