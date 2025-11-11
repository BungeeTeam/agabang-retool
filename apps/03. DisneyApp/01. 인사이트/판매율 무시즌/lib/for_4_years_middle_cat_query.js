//  let cur_year_cd_num = season_select.selectedItem.year_cd?.charCodeAt()

let cur_year_cd_num = season_list_new.data.year_cd[0]?.charCodeAt()

//  console.log(`cur_year_cd_num: ${cur_year_cd_num}`)

/////// list 01 =======
let result_01 = await get_middle_cat_sales_data.trigger({
  additionalScope: {
    p_sean_cd: `${String.fromCharCode(cur_year_cd_num-0)}0`
  }
})
const middleList_01 = result_01.reduce((obj, item) => {
  // 해당 cat_id 키가 없으면 빈 배열로 초기화
  if (!obj[item.cat_id]) {
    obj[item.cat_id] = [];
  }
  // 해당 cat_id 배열에 오브젝트 추가
  obj[item.cat_id].push(item);
  return obj;
}, {});

/////// list 02 =======
let result_02 = await get_middle_cat_sales_data.trigger({
  additionalScope: {
    p_sean_cd: `${String.fromCharCode(cur_year_cd_num-1)}0`
  }
})
const middleList_02 = result_02.reduce((obj, item) => {
  // 해당 cat_id 키가 없으면 빈 배열로 초기화
  if (!obj[item.cat_id]) {
    obj[item.cat_id] = [];
  }
  // 해당 cat_id 배열에 오브젝트 추가
  obj[item.cat_id].push(item);
  return obj;
}, {});

/////// list 03 =======
let result_03 = await get_middle_cat_sales_data.trigger({
  additionalScope: {
    p_sean_cd: `${String.fromCharCode(cur_year_cd_num-2)}0`
  }
})
const middleList_03 = result_03.reduce((obj, item) => {
  // 해당 cat_id 키가 없으면 빈 배열로 초기화
  if (!obj[item.cat_id]) {
    obj[item.cat_id] = [];
  }
  // 해당 cat_id 배열에 오브젝트 추가
  obj[item.cat_id].push(item);
  return obj;
}, {});




/////// list 04 =======
let result_04 = await get_middle_cat_sales_data.trigger({
  additionalScope: {
    p_sean_cd: `${String.fromCharCode(cur_year_cd_num-3)}0`
  }
})
const middleList_04 = result_04.reduce((obj, item) => {
  // 해당 cat_id 키가 없으면 빈 배열로 초기화
  if (!obj[item.cat_id]) {
    obj[item.cat_id] = [];
  }
  // 해당 cat_id 배열에 오브젝트 추가
  obj[item.cat_id].push(item);
  return obj;
}, {});

var_middle_cat.setValue({
  var_01: middleList_01,
  var_02: middleList_02,
  var_03: middleList_03,
  var_04: middleList_04,
})

//  console.log(var_tes