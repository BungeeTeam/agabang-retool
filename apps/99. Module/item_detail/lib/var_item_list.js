// Reference external variables with curly brackets or using JS variables
const objs = {{ get_item_list.data }}

console.log(objs)
const getTotalSum = (_list, _field) => {
  return _list.reduce((acc, cur) => {
    return acc + parseInt(cur[_field]);
  }, 0);
};

const getTotalSumFloat = (_list, _field) => {
  return _list.reduce((acc, cur) => {
    if(cur[_field]){
      return acc + parseFloat(cur[_field]);
    }
    return acc;
  }, 0);
};

for(const [key, values] of Object.entries(objs)){
  //  console.log(`==> key: ${key}, values: ${JSON.stringify(values)}`)
  //  console.log(`==> key: ${key}`)
  //  console.log(objs[key])
  

  let _sum_tot_in_qty = getTotalSum(values, 'tot_in_qty')
  let _sum_tot_inventory_qty = getTotalSum(values, 'tot_inventory_qty')
  let _sum_tot_sale_qty = getTotalSum(values, 'tot_sale_qty')
  let _sum_tot_in_tag_amt = getTotalSum(values, 'tot_in_tag_amt')
  let _sum_tot_sale_tag = getTotalSum(values, 'tot_sale_tag')

//    * 판매율(수량) =  해당 복종의 판매수량(tot_sale_qty) / 해당 복종의 입고수량(tot_in_qty)
//  * 판매율(금액) = 해당 복종의 판매금액(tot_sale_tag) / 해당 복종의 입고금액(tot_in_tag_amt)
//  * 평균 TAG가 = 해당 복종의 입고금액(TAG)tot_in_tag_amt / 입고수량(tot_in_qty) 
  
  let _rate_sale_per_tot = _sum_tot_sale_qty / _sum_tot_in_qty // 판매율(수량)
  let _rate_sale_tag_per = _sum_tot_sale_tag / _sum_tot_in_tag_amt  // 판매율(금액)
  let _avg_tot_tag_prce = _sum_tot_in_tag_amt / _sum_tot_in_qty  // 평균 TAG가

  let result = {
    sty_cd: "",
    sty_nm: "소계",
    col_cd: "",
    col_nm: "",
    year_season: "",
    cat_nm: "",
    item_nm: "",
    tot_in_qty: _sum_tot_in_qty,
    tot_sale_qty: _sum_tot_sale_qty,
    //  sale_per_tot: 0.97,
    //  sale_per_tot: null,
    //  sale_per_tot: _rate_sale_per_tot,
    sale_per_tot: _rate_sale_per_tot?.toFixed(3),
    sale_per_3m: null,
    sale_per_6m: null,
    sale_per_12m: null,
    sale_per_18m: null,
    sale_per_2y: null,
    sale_per_3y: null,
    sale_per_4y: null,


    sale_per_free: getTotalSumFloat(values, 'sale_per_free'),
    sale_per_60: getTotalSumFloat(values, 'sale_per_60'),
    sale_per_75: getTotalSumFloat(values, 'sale_per_75'),
    sale_per_80: getTotalSumFloat(values, 'sale_per_80'),
    sale_per_90: getTotalSumFloat(values, 'sale_per_90'),
    sale_per_100: getTotalSumFloat(values, 'sale_per_100'),
    sale_per_110: getTotalSumFloat(values, 'sale_per_110'),
    sale_per_120: getTotalSumFloat(values, 'sale_per_120'),
    sale_per_130: getTotalSumFloat(values, 'sale_per_130'),
    sale_per_115: getTotalSumFloat(values, 'sale_per_115'),
    sale_per_125: getTotalSumFloat(values, 'sale_per_125'),
    sale_per_140: getTotalSumFloat(values, 'sale_per_140'),
    sale_per_150: getTotalSumFloat(values, 'sale_per_150'),
    sale_per_160: getTotalSumFloat(values, 'sale_per_160'),
    sale_per_7_8: getTotalSumFloat(values, 'sale_per_7_8'),
    sale_per_9_10: getTotalSumFloat(values, 'sale_per_9_10'),
    sale_per_11_12: getTotalSumFloat(values, 'sale_per_11_12'),
    sale_per_13_14: getTotalSumFloat(values, 'sale_per_13_14'),
    sale_per_15_16: getTotalSumFloat(values, 'sale_per_15_16'),
    sale_per_42: getTotalSumFloat(values, 'sale_per_42'),
    sale_per_44: getTotalSumFloat(values, 'sale_per_44'),
    sale_per_46: getTotalSumFloat(values, 'sale_per_46'),
    sale_per_48: getTotalSumFloat(values, 'sale_per_48'),
    sale_per_50: getTotalSumFloat(values, 'sale_per_50'),
    sale_per_52: getTotalSumFloat(values, 'sale_per_52'),
    sale_per_S: getTotalSumFloat(values, 'sale_per_S'),
    sale_per_M: getTotalSumFloat(values, 'sale_per_M'),
    sale_per_L: getTotalSumFloat(values, 'sale_per_L'),
    
    
    
    //  tag_prce: "",
    tag_prce: _avg_tot_tag_prce,
    tot_in_tag_amt: _sum_tot_in_tag_amt,
    tot_in_cost_amt: "",
    tot_sale_amt: "",
    tot_sale_tag: _sum_tot_sale_tag,
    sale_tag_per: _rate_sale_tag_per?.toFixed(3),
    sale_return_per: null,
    online_sale_per: null,
    shop_entropy: null,
    shop_gini: null,
    tot_inventory_qty: _sum_tot_inventory_qty,
    bg_color: 'f6f6f6'
  }
  objs[key].push(result)
}

console.log(`===== result ==`)
console.log(objs)

return objs