// Reference external variables with curly brackets or using JS variables
const objs = {{ get_item_list_new.data }}

const getTotalSum = (_list, _field) => {
  return _list.reduce((acc, cur) => {
    if(cur[_field]){
      return acc + parseInt(cur[_field]);
    }
    return acc;
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


  
  //  let _sum_sale_per_60 = getTotalSumFloat(values, 'sale_per_60')
  //  let _sum_sale_per_75 = getTotalSumFloat(values, 'sale_per_75')
  //  let _sum_sale_per_80 = getTotalSumFloat(values, 'sale_per_80')
  //  let _sum_sale_per_90 = getTotalSumFloat(values, 'sale_per_90')
  //  let _sum_sale_per_100 = getTotalSumFloat(values, 'sale_per_100')
  //  let _sum_sale_per_110 = getTotalSumFloat(values, 'sale_per_110')

  //  console.log(`_sum_60: ${_sum_sale_per_60}, _sum_75: ${_sum_sale_per_75}, _sum_80: ${_sum_sale_per_80}, _sum_90: ${_sum_sale_per_90}, _sum_100: ${_sum_sale_per_100}, _sum_110: ${_sum_sale_per_110}`)

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
    //  sale_per_3m: null,
    //  sale_per_6m: null,
    //  sale_per_12m: null,
    //  sale_per_18m: null,
    //  sale_per_2y: null,
    //  sale_per_3y: null,
    //  sale_per_4y: null,
    sale_per_3m: getTotalSumFloat(values, 'sale_per_3m'),
    sale_per_6m: getTotalSumFloat(values, 'sale_per_6m'),
    sale_per_12m: getTotalSumFloat(values, 'sale_per_12m'),
    sale_per_18m: getTotalSumFloat(values, 'sale_per_18m'),
    sale_per_2y: getTotalSumFloat(values, 'sale_per_2y'),
    sale_per_3y: getTotalSumFloat(values, 'sale_per_3y'),
    sale_per_4y: getTotalSumFloat(values, 'sale_per_4y'),

    sale_per_01: getTotalSumFloat(values, 'sale_per_01'),
    sale_per_03: getTotalSumFloat(values, 'sale_per_03'),
    sale_per_newborn: getTotalSumFloat(values, 'sale_per_newborn'),
    sale_per_free: getTotalSumFloat(values, 'sale_per_free'),
    sale_per_100X120: getTotalSumFloat(values, 'sale_per_100X120'),
    sale_per_100X130: getTotalSumFloat(values, 'sale_per_100X130'),
    sale_per_83X83: getTotalSumFloat(values, 'sale_per_83X83'),
    sale_per_85X85: getTotalSumFloat(values, 'sale_per_85X85'),
    sale_per_95X95: getTotalSumFloat(values, 'sale_per_95X95'),
    sale_per_105X135: getTotalSumFloat(values, 'sale_per_105X135'),
    sale_per_115X145: getTotalSumFloat(values, 'sale_per_115X145'),
    sale_per_mini: getTotalSumFloat(values, 'sale_per_mini'),
    sale_per_general: getTotalSumFloat(values, 'sale_per_general'),
    sale_per_seven: getTotalSumFloat(values, 'sale_per_seven'),
    sale_per_65: getTotalSumFloat(values, 'sale_per_65'),
    sale_per_70: getTotalSumFloat(values, 'sale_per_70'),
    sale_per_85: getTotalSumFloat(values, 'sale_per_85'),
    sale_per_95: getTotalSumFloat(values, 'sale_per_95'),
    sale_per_145: getTotalSumFloat(values, 'sale_per_145'),
    sale_per_155: getTotalSumFloat(values, 'sale_per_155'),
    sale_per_170: getTotalSumFloat(values, 'sale_per_170'),
    sale_per_15_16: getTotalSumFloat(values, 'sale_per_15_16'),
    sale_per_17_18: getTotalSumFloat(values, 'sale_per_17_18'),
    sale_per_40: getTotalSumFloat(values, 'sale_per_40'),
    sale_per_42: getTotalSumFloat(values, 'sale_per_42'),
    sale_per_44: getTotalSumFloat(values, 'sale_per_44'),
    sale_per_54: getTotalSumFloat(values, 'sale_per_54'),
    sale_per_S: getTotalSumFloat(values, 'sale_per_S'),
    sale_per_XL: getTotalSumFloat(values, 'sale_per_XL'),
    //  sale_per_6M: getTotalSumFloat(values, 'sale_per_6M'),
    //  sale_per_12M: getTotalSumFloat(values, 'sale_per_12M'),
    //  sale_per_18M: getTotalSumFloat(values, 'sale_per_18M'),
    //  sale_per_24M: getTotalSumFloat(values, 'sale_per_24M'),
    
    sale_per_60: getTotalSumFloat(values, 'sale_per_60'),
    sale_per_75: getTotalSumFloat(values, 'sale_per_75'),
    sale_per_80: getTotalSumFloat(values, 'sale_per_80'),
    sale_per_90: getTotalSumFloat(values, 'sale_per_90'),
    sale_per_100: getTotalSumFloat(values, 'sale_per_100'),
    sale_per_110: getTotalSumFloat(values, 'sale_per_110'),
    sale_per_120: getTotalSumFloat(values, 'sale_per_120'),
    sale_per_115: getTotalSumFloat(values, 'sale_per_115'),
    sale_per_125: getTotalSumFloat(values, 'sale_per_125'),
    sale_per_130: getTotalSumFloat(values, 'sale_per_130'),
    sale_per_135: getTotalSumFloat(values, 'sale_per_135'),
    sale_per_140: getTotalSumFloat(values, 'sale_per_140'),
    sale_per_150: getTotalSumFloat(values, 'sale_per_150'),
    sale_per_160: getTotalSumFloat(values, 'sale_per_160'),
    sale_per_7_8: getTotalSumFloat(values, 'sale_per_7_8'),
    sale_per_9_10: getTotalSumFloat(values, 'sale_per_9_10'),
    sale_per_11_12: getTotalSumFloat(values, 'sale_per_11_12'),
    sale_per_13_14: getTotalSumFloat(values, 'sale_per_13_14'),
    sale_per_46: getTotalSumFloat(values, 'sale_per_46'),
    sale_per_48: getTotalSumFloat(values, 'sale_per_48'),
    sale_per_50: getTotalSumFloat(values, 'sale_per_50'),
    sale_per_52: getTotalSumFloat(values, 'sale_per_52'),
    sale_per_M: getTotalSumFloat(values, 'sale_per_M'),
    sale_per_L: getTotalSumFloat(values, 'sale_per_L'),

    //  sale_per_01: null,
    //  sale_per_02: null,
    //  sale_per_03: null,
    //  sale_per_04: null,
    //  sale_per_05: null,
    //  sale_per_06: null,
    //  sale_per_07: null,
    //  sale_per_08: null,
    //  sale_per_09: null,
    //  sale_per_10: null,

    //  size_nm_01: null,
    //  size_nm_02: null,
    //  size_nm_03: null,
    //  size_nm_04: null,
    //  size_nm_05: null,
    //  size_nm_06: null,
    //  size_nm_07: null,
    //  size_nm_08: null,
    //  size_nm_09: null,
    //  size_nm_10: null,
    
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
  //objs[key].push(result)
  objs[key].unshift(result)
}

console.log(`==> objs: ${JSON.stringify(objs)}`)


//  let result = {
//    sty_cd: "",
//    sty_nm: "",
//    col_cd: "",
//    col_nm: "",
//    year_season: "",
//    cat_nm: "",
//    item_nm: "",
//    tot_in_qty: _sum_tot_in_qty,
//    tot_sale_qty: _sum_tot_sale_qty,
//    sale_per_tot: 0.97,
//    sale_per_3m: null,
//    sale_per_6m: null,
//    sale_per_12m: null,
//    sale_per_18m: null,
//    sale_per_2y: null,
//    sale_per_3y: null,
//    sale_per_4y: null,
//    tag_prce: "",
//    tot_in_tag_amt: _sum_tot_in_tag_amt,
//    tot_in_cost_amt: "",
//    tot_sale_amt: "",
//    tot_sale_tag: _sum_tot_sale_tag,
//    sale_tag_per: null,
//    sale_return_per: null,
//    online_sale_per: null,
//    shop_entropy: null,
//    shop_gini: null,
//    tot_inventory_qty: _sum_tot_inventory_qty
//  }

return objs