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

const keys = ["year_nm", "season_nm", "it_nm"]
const groupedArr = groupBySum(data, keys, sumKeys)

return groupedArr.sort((a, b) => a.it_nm.localeCompare(b.it_nm, "ko"))