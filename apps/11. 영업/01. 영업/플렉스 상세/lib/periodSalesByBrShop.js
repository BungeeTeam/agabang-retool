const data = {{ periodicFlexSalesQueryByStyle.data }}
const selectedBr = {{ selectedRow.value.br_type }}
const brList = {{ brMultiselect.value }}
let arrData = formatDataAsArray(data)

arrData = arrData.map(obj => {
  if (brList.includes(obj?.sub_br_nm)) {
    obj.br_type = obj.sub_br_nm
  } else if (brList.includes(obj?.br_nm)) {
    obj.br_type = obj.br_nm
  } else {
    obj.br_type = "기타"
  }
  return obj
})

arrData = arrData.filter(item => selectedBr === item.br_type)

const sumKeys = ["rev"]
const groupKeys = ["shop_cd", "shop_nm", "br_nm"]

const groupedArr = groupBySum(arrData, ["time_unit", ...groupKeys], sumKeys)
const result = pivotData(groupedArr, groupKeys, "time_unit", sumKeys)

const currentYear = new Date().getFullYear(); // ex. 2025
return result
  .sort((a, b) => b?.[currentYear] - a?.[currentYear])