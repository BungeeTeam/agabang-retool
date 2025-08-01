const cumData = {{ shopInventoryByStyleQuery.data }}
const prdData = {{ shopInventoryByStyleInPeriodQuery.data }}

const newData = cumData.map(item => {
  const match = prdData.find(l => l.sty_cd === item.sty_cd);
  return {
    ...item,
    period_in_qty: match ? match.period_in_qty : 0,
    period_rt_in_qty: match ? match.period_rt_in_qty : 0,
    period_net_sale_qty: match ? match.period_net_sale_qty : 0,
    period_sale_qty: match ? match.period_sale_qty : 0,
    period_cust_rqty: match ? match.period_cust_rqty : 0,// match가 없으면 null로 설정
  };
});


return newData