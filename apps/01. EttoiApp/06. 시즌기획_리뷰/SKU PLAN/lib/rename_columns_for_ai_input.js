const inputs = make_table_data.data;

for (let cat in inputs) {
  const catData = inputs[cat]
  console.log(catData)
  inputs[cat] = catData.map(ele => {
    const newEle = {}
    newEle.상품분류 = ele.item_raw_nm
    newEle.season_1_sku = ele.season_1_sku
    newEle.season_1_총입고수량 = ele.season_1_tot_in_qty
    newEle.season_1_총판매수량 = ele.season_1_tot_sale_qty
    newEle.season_1_판매율 = ele.season_1_tot_sale_amt / ele.season_1_tot_in_amt,
    newEle.season_2_sku = ele.season_2_sku
    newEle.season_2_총입고수량 = ele.season_2_tot_in_qty
    newEle.season_2_총판매수량 = ele.season_2_tot_sale_qty
    newEle.season_2_판매율 = ele.season_2_tot_sale_amt / ele.season_2_tot_in_amt
    newEle.season_3_sku = ele.season_3_sku
    newEle.season_3_총입고수량 = ele.season_3_tot_in_qty
    newEle.season_3_총판매수량 = ele.season_3_tot_sale_qty,
    newEle.season_3_판매율 = ele.season_3_tot_sale_amt / ele.season_3_tot_in_amt
    return newEle
  })
}

return inputs