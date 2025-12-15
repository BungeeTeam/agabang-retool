// const cumData = {{ shopInventoryByStyleQuery.data }}
// const prdData = {{ shopInventoryByStyleInPeriodQuery.data }}

// const newData = cumData.map(item => {
//   const match = prdData.find(l => l.sty_cd === item.sty_cd);
//   return {
//     ...item,
//     period_in_qty: match ? match.period_in_qty : 0,
//     period_rt_in_qty: match ? match.period_rt_in_qty : 0,
//     period_sale_qty: match ? match.period_sale_qty : 0// match가 없으면 null로 설정
//   };
// });

const data = {{ mergeShopInventoryByStyleQuery.value }}

const sumKeys = ["in_qty", "rt_in_qty","net_sales_qty", "sales_qty", "cust_rqty", "rtn_qty", "adjt_qty", "stock_qty", "tot_sales_qty", "tot_stock_qty","period_in_qty", "period_rt_in_qty", "period_net_sale_qty", "period_sale_qty","period_cust_rqty"]

const currentYear = new Date().getFullYear();
const last5Years = Array.from({length: 6}, (_, i) => (currentYear + 1 - i).toString());

const keys = ["year_nm"]

const groupedArr = groupBySum(data, keys, sumKeys).filter(item => last5Years.includes(item.year_nm))

return groupedArr.sort((a, b) => b.year_nm - a.year_nm)