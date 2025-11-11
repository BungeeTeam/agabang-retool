// Get the appropriate amount to receive
const rtList = {{ rtListQuery.data }}

const exportedResult = rtList.map(obj => {
  const translatedObj = {}
  translatedObj["보낼매장코드"] = obj.shop_cd
  translatedObj["받을매장코드"] = obj.shop_cd_b
  translatedObj["스타일코드"] = obj.sty_cd
  translatedObj["칼라코드"] = obj.col_cd
  translatedObj["사이즈코드"] = obj.size_cd
  translatedObj["지시수량"] = obj.sendQty
  translatedObj["보낼매장명"] = obj.shop_nm
  translatedObj["입고후경과일"] = obj.days_after_in
  translatedObj["RT출고일"] = obj.rt_out_dt
  translatedObj["최근판매일"] = obj.fsale_dt
  translatedObj["재고수량"] = obj.stock_qty
  translatedObj["판매수량"] = obj.tot_sales_qty
  translatedObj["판매율"] = obj.sales_ratio
  translatedObj["색상판매율"] = obj.tot_col_sales_ratio
  translatedObj["해당시즌RT입고수량"] = obj.tot_rt_in_qty
  translatedObj["해당시즌RT출고수량"] = obj.tot_rt_out_qty
  translatedObj["받을매장명"] = obj.shop_nm_b
  translatedObj["받을매장재고량"] = obj.stock_qty_b
  translatedObj["받을매장판매량"] = obj.tot_sales_qty_b
  translatedObj["받을매장판매율"] = obj.sales_ratio_b
  translatedObj["받을매장색상판매량"] = obj.tot_col_sales_qty_b
  translatedObj["받을매장최근판매일"] = obj.fsale_dt_b
  translatedObj["받을매장색상재고량"] = obj.tot_col_stock_qty_b
  translatedObj["추천점수"] = obj.tot_score
  return translatedObj
})

return exportedResult