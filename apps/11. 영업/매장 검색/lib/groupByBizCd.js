// Reference external variables with curly brackets or using JS variables
const data = {{ getShopList.data }}

const arrData = formatDataAsArray(data)

const groupKeys = ["shop_cd","shop_nm","biz_cd","biz_nm"]
const sumKeys = ["rev"]

const groupedData = groupBySum(arrData, groupKeys, sumKeys)

return groupedData