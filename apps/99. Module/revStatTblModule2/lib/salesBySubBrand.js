const sumKeys = ["rev"]
const data = {{ inputDataByStyle.value }}
let arrData = formatDataAsArray(data)
  .filter(item => item.onoff_flag === "오프라인")

const subBrList = ["부가부", "더블하트", "리우드", "디즈니", "엘츠", "마페띵", "스와들업", "베이이뵨", "꼬무신", "스토케", "디자인스킨", "아가방좋은"]
arrData = arrData.filter(item => item.biz_cd === {{ selectedRow.value.biz_cd }} && subBrList?.includes(item.sub_br_nm))

const keys = ["sub_br_nm", "sub_br_cd"]
const groupedArr = groupBySum(arrData, ["time_unit", ...keys], sumKeys)

const currentYear = new Date().getFullYear().toString();
let result = pivotData(groupedArr, keys, "time_unit", sumKeys)
result = result.filter(obj => obj.hasOwnProperty(currentYear) && obj[currentYear] !== 0)

return result.sort((a, b) => a.sub_br_nm.localeCompare(b.sub_br_nm, "ko"))