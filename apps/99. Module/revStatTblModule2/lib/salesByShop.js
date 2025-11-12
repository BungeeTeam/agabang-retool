const sumKeys = ["rev"]
let groupKeys = ["shop_cd", "shop_nm"]
const data = {{ inputData.value }}
let arrData = formatDataAsArray(data).filter(item => item.onoff_flag === "오프라인")

if ({{ salesTabbedContainer.currentViewKey }} === "type") {
  arrData = arrData.filter(item => item.tp_group_nm === {{ selectedRow.value.tp_group_nm }})  
} else if ({{ salesTabbedContainer.currentViewKey }} === "team") {
  arrData = arrData.filter(item => item.team_cd === {{ selectedRow.value.team_cd }})  
} else if ({{ salesTabbedContainer.currentViewKey }} === "person") {
  arrData = arrData.filter(item => item.user_cd === {{ selectedRow.value.user_cd }})  
}

const groupedArr = groupBySum(arrData, ["time_unit", ...groupKeys], sumKeys)
const targetArr = groupBySum(arrData, groupKeys, ["target_sales"])
const result = pivotData(groupedArr, groupKeys, "time_unit", sumKeys)

const currentYear = new Date().getFullYear();
return result.map(item => {
  const matched = targetArr.find((ele) =>
    groupKeys.every((key) => ele[key] === item[key])
  );
  return {...item, target_sales: matched ? matched.target_sales : 0}
})
  //  .filter(obj => obj?.[currentYear] > 0 || obj.target_sales > 0)
  .sort((a, b) => b.target_sales - a.target_sales)