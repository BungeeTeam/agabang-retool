const data = {{ periodicFlexSalesQuery.data }}
const selectedBiz = {{ selectedRow.value.biz_cd }}

const filteredData = formatDataAsArray(data).filter(item => item.biz_cd === selectedBiz)

const currentYear = new Date().getFullYear();
return formatDataAsObject(filteredData.sort((a, b) => b?.[currentYear] - a?.[currentYear]))