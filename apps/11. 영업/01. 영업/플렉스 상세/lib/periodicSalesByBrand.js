const sumKeys = ["rev"]
const groupKeys = ["br_type"]
const data = {{ periodicFlexSalesQueryByStyle.data }}

let arrData = formatDataAsArray(data)

const selectedBr = {{ brMultiselect.value }}
arrData = arrData.map(obj => {
  if (selectedBr.includes(obj?.sub_br_nm)) {
    obj.br_type = obj.sub_br_nm
  } else if (selectedBr.includes(obj?.br_nm)) {
    obj.br_type = obj.br_nm
  } else {
    obj.br_type = "기타"
  }
  return obj
})

const groupedArr = groupBySum(arrData, ["time_unit", ...groupKeys], sumKeys)
const targetArr = groupBySum(arrData, groupKeys, ["target_sales"])
const result = pivotData(groupedArr, groupKeys, "time_unit", sumKeys)

return result
  .map(item => {
  const matched = targetArr.find((ele) =>
    groupKeys.every((key) => ele[key] === item[key])
  );
  return {...item, target_sales: matched ? matched.target_sales : 0}})
  .sort((a, b) => b.target_sales - a.target_sales)