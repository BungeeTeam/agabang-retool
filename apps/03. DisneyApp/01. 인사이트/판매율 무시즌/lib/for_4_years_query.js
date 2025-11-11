//  let cur_year_cd_num = season_select.selectedItem.year_cd?.charCodeAt()

let cur_year_cd_num = season_list_new.data.year_cd[0]?.charCodeAt()

//  console.log(`cur_year_cd_num: ${cur_year_cd_num}`) 
 
let id_list = [
  { cat_id:'57', cat_nm:'시즌의류' },
  { cat_id:'56', cat_nm:'시즌언더' },  
  { cat_id:'62', cat_nm:'시즌용품' },
  { cat_id:'777', cat_nm:'정상소계' },
  
  //  { cat_id:'59', cat_nm:'파자마' },
  { cat_id:'60', cat_nm:'기획의류' }, // 60:수영복/우비
  { cat_id:'59', cat_nm:'기획언더' },
  
  { cat_id:'888', cat_nm:'기획소계' },
  { cat_id:'999', cat_nm:'총계' },
]


let list_01 = []
let list_02 = []
let list_03 = []
let list_04 = []


const getCatIDItem = (_list, _cat_nm, _cat_id) => {
  let _item = _list?.find((item) => item.cat_id == _cat_id)
  //  console.log(`====== getCatIDItem : ${JSON.stringify(_item)}`)
  if(_item){
    _item.cat_nm = _cat_nm;
    return _item
  }
  return {
    cat_nm: _cat_nm,
    cat_id: _cat_id,
    year_cd: 0,
    tot_ord_qty: 0,
    tot_ord_tag: 0,
    in_rate_tag: 0,
    ord_st: 0,
    in_st: 0,
    not_in_st: 0,
    in_st_rate: 0,
    out_st: 0,
    not_out_st: 0,
    out_st_rate: 0,
    tot_in_qty: 0,
    tot_sale_qty: 0,
    sale_rate_qty: 0,
    tot_in_cost_amt: 0,
    mark_up: 0,
    tot_in_tag: 0,
    tot_sale_tag: 0,
    tot_sale_amt: 0,
    sale_rate_tag: 0,
    sale_rate_amt: 0,
    discount_rate: 0,
    inven_qty: 0,
    inven_tag: 0,
    ttl_index: 0,
    monthly_sale_qty: 0,
    monthly_sale_tag: 0,
    monthly_sale_amt: 0,
    last_week_sale_qty: 0,
    last_week_sale_tag: 0,
    last_week_sale_amt: 0,
    last_week_progress_rate: 0,
    this_week_sale_qty: 0,
    this_week_sale_tag: 0,
    this_week_sale_amt: 0,
    this_week_progress_rate: 0,
    sale_share_in: 0
  }
  
}


//////// list 01 ======
let result_01 = await get_large_cat_sales_data.trigger({
  additionalScope: {
    p_sean_cd: `${String.fromCharCode(cur_year_cd_num-0)}0`
  }
})
console.log(`====>>> 01`)
//  console.log(result_01)

id_list.forEach((_obj) => {
  let item = getCatIDItem(result_01, _obj.cat_nm, _obj.cat_id)
  // 2025년 정상토들러는 제외
  if(item && _obj.cat_id !== '3'){
    list_01.push(item);
  }
})

console.log(`====>>> 01 ====`)
//  console.log(list_01)

//////// list 02 ======
let result_02 = await get_large_cat_sales_data.trigger({
  additionalScope: {
    p_sean_cd: `${String.fromCharCode(cur_year_cd_num-1)}0`
  }
})
console.log(`====>>> 02`)
//  console.log(result_02)

id_list.forEach((_obj) => {
  let item = getCatIDItem(result_02, _obj.cat_nm, _obj.cat_id)
  if(item){
    list_02.push(item);
  }
})

//////// list 03 ======
let result_03 = await get_large_cat_sales_data.trigger({
  additionalScope: {
    p_sean_cd: `${String.fromCharCode(cur_year_cd_num-2)}0`
  }
})
console.log(`====>>> 03`)
//  console.log(result_03)

id_list.forEach((_obj) => {
  let item = getCatIDItem(result_03, _obj.cat_nm, _obj.cat_id)
  if(item){
    list_03.push(item);
  }
})


//////// list 04 ==== 
let result_04 = await get_large_cat_sales_data.trigger({
  additionalScope: {
    p_sean_cd: `${String.fromCharCode(cur_year_cd_num-3)}0`
  }
})
console.log(`====>>> 04`)
//  console.log(result_04)

id_list.forEach((_obj) => {
  let item = getCatIDItem(result_04, _obj.cat_nm, _obj.cat_id)
  if(item){
    list_04.push(item);
  }
})

var_large_cat.setValue({
  var_01: list_01,
  var_02: list_02,
  var_03: list_03,
  var_04: list_04,
})
