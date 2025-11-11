let cur_year_cd_num = season_select.selectedItem.year_cd?.charCodeAt()
console.log(cur_year_cd_num)

let _y_cd = `${String.fromCharCode(cur_year_cd_num)}0`
console.log(`_y_cd01 : ${_y_cd}`)

let result_01 = await get_sales_data_new2.trigger({
  additionalScope: {
    p_sean_cd: `${_y_cd}`
  }
})
console.log(`====>>> 01`)
console.log(result_01)



//  let new_list = []
//  const _result_01 = Object.entries(result_01)

let list_01 = new Array(8)
for(const [key, values] of Object.entries(result_01)) {
  console.log(`====>>> 01 .......`)
  //  console.log(key)
  console.log(values['cat_nm'])
  if(values['cat_nm'] === '시즌의류'){
    list_01[0] = values
  }
  if(values['cat_nm'] === '시즌언더'){
    list_01[1] = values
  }
  if(values['cat_nm'] === '시즌용품'){
    list_01[2] = values
  }
  if(values['cat_nm'] === '정상소계'){
    list_01[3] = values
  }
  if(values['cat_nm'] === '기획의류'){
    list_01[4] = values
  }
  if(values['cat_nm'] === '기획언더'){
    list_01[5] = values
  }  
  if(values['cat_nm'] === '기획소계'){
    list_01[6] = values
  }
  if(values['cat_nm'] === '총계'){
   list_01[7] = values
  }
}

if(!list_01[1]){
  list_01[1] = {
    cat_nm: "시즌언더",
cat_id: 0,
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
};

if(!list_01[2]){
  list_01[2] = {
    cat_nm: "시즌용품",
cat_id: 0,
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
};

if(!list_01[4]){
  list_01[4] = {
    cat_nm: "기획의류",
cat_id: 0,
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
};

if(!list_01[5]){
  list_01[5] = {
    cat_nm: "기획언더",
cat_id: 0,
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
};

//  let new_list = new Array(Object.entries(result_01).length+3)

console.log(`====>>> 01 ====`)
console.log(list_01)


//  let list_01 = [];

//  let pos_1 = result_01.find((item) => item.cat_id == 22);
//  if (pos_1) list_01.push(pos_1);

//  var_test.setValue({
//    var_01: result_01,
//  })

_y_cd = `${String.fromCharCode(--cur_year_cd_num)}0`
console.log(`_y_cd02 : ${_y_cd}`)
let result_02 = await get_sales_data_new2.trigger({
  additionalScope: {
    p_sean_cd: `${_y_cd}`
  }
})
console.log(`====>>> 02`)
//  console.log(result_02)

//  var_test.setValue({...var_test,
//    var_02: result_02
//  })

let list_02 = new Array(8)
for(const [key, values] of Object.entries(result_02)) {
  console.log(`====>>> 01 .......`)
  //  console.log(key)
  console.log(values['cat_nm'])
  if(values['cat_nm'] === '시즌의류'){
   list_02[0] = values
  }
  if(values['cat_nm'] === '시즌언더'){
    list_02[1] = values
  }
  if(values['cat_nm'] === '시즌용품'){
    list_02[2] = values
  }
  if(values['cat_nm'] === '정상소계'){
   list_02[3] = values
  }
  if(values['cat_nm'] === '기획의류'){
   list_02[4] = values
  }
  if(values['cat_nm'] === '기획언더'){
    list_02[5] = values
  }  
  if(values['cat_nm'] === '기획소계'){
   list_02[6] = values
  }
  if(values['cat_nm'] === '총계'){
   list_02[7] = values
  }
};

if(!list_02[1]){
  list_02[1] = {
    cat_nm: "시즌언더",
cat_id: 0,
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
};

if(!list_02[2]){
  list_02[2] = {
    cat_nm: "시즌용품",
cat_id: 0,
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
};

if(!list_02[4]){
  list_02[4] = {
    cat_nm: "기획의류",
cat_id: 0,
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
};

if(!list_02[5]){
  list_02[5] = {
    cat_nm: "기획언더",
cat_id: 0,
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
};

_y_cd = `${String.fromCharCode(--cur_year_cd_num)}0`
console.log(`_y_cd03 : ${_y_cd}`)
let result_03 = await get_sales_data_new2.trigger({
  additionalScope: {
    p_sean_cd: `${_y_cd}`
  }
})
console.log(`====>>> 03`)
//  console.log(result_03)

//  var_test.setValue({...var_test, 
//    var_03: result_03,
//  })


let list_03 = new Array(8)
for(const [key, values] of Object.entries(result_03)) {
  console.log(`====>>> 01 .......`)
  //  console.log(key)
  console.log(values['cat_nm'])
  if(values['cat_nm'] === '시즌의류'){
   list_03[0] = values
  }
  if(values['cat_nm'] === '시즌언더'){
    list_03[1] = values
  }
  if(values['cat_nm'] === '시즌용품'){
    list_03[2] = values
  }
  if(values['cat_nm'] === '정상소계'){
   list_03[3] = values
  }
  if(values['cat_nm'] === '기획의류'){
   list_03[4] = values
  }
  if(values['cat_nm'] === '기획언더'){
    list_03[5] = values
  }  
  if(values['cat_nm'] === '기획소계'){
   list_03[6] = values
  }
  if(values['cat_nm'] === '총계'){
   list_03[7] = values
  }
}


if(!list_03[1]){
  list_03[1] = {
    cat_nm: "시즌언더",
cat_id: 0,
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
};

if(!list_03[2]){
  list_03[2] = {
    cat_nm: "시즌용품",
cat_id: 0,
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
};

if(!list_03[4]){
  list_03[4] = {
    cat_nm: "기획의류",
cat_id: 0,
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
};

if(!list_03[5]){
  list_03[5] = {
    cat_nm: "기획언더",
cat_id: 0,
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
};

_y_cd = `${String.fromCharCode(--cur_year_cd_num)}0`
console.log(`_y_cd04 : ${_y_cd}`)
let result_04 = await get_sales_data_new2.trigger({
  additionalScope: {
    p_sean_cd: `${_y_cd}`
  }
})
console.log(`====>>> 04`)
//  console.log(result_04)

//  var_test.setValue({...var_test, 
//    var_04: result_04,
//  })

let list_04 = new Array(8)
for(const [key, values] of Object.entries(result_04)) {
  console.log(`====>>> 01 .......`)
  //  console.log(key)
  console.log(values['cat_nm'])
  if(values['cat_nm'] === '시즌의류'){
   list_04[0] = values
  }
  if(values['cat_nm'] === '시즌언더'){
    list_04[1] = values
  }
  if(values['cat_nm'] === '시즌용품'){
    list_04[2] = values
  }
  if(values['cat_nm'] === '정상소계'){
   list_04[3] = values
  }
  if(values['cat_nm'] === '기획의류'){
   list_04[4] = values
  }
  if(values['cat_nm'] === '기획언더'){
    list_04[5] = values
  }  
  if(values['cat_nm'] === '기획소계'){
   list_04[6] = values
  }
  if(values['cat_nm'] === '총계'){
   list_04[7] = values
  }
};


if(!list_04[1]){
  list_04[1] = {
    cat_nm: "시즌언더",
cat_id: 0,
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
};

if(!list_04[2]){
  list_04[2] = {
    cat_nm: "시즌용품",
cat_id: 0,
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
};

if(!list_04[4]){
  list_04[4] = {
    cat_nm: "기획의류",
cat_id: 0,
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
};

if(!list_04[5]){
  list_04[5] = {
    cat_nm: "기획언더",
cat_id: 0,
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
};

var_test.setValue({
  var_01: list_01,
  var_02: list_02,
  var_03: list_03,
  var_04: list_04,
})

//  console.log(var_tes