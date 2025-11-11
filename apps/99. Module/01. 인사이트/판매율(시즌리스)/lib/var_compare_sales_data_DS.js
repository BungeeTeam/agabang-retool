//  // Reference external variables with curly brackets or using JS variables
const cur_list = {{ var_get_sales_data_cur_DS.value }}
const prev_list = {{ var_get_sales_data_prev_DS.value }}


// 현재 - 전년동기 빼기
let list = cur_list.map((curItem, index) => {
  let prevItem = prev_list[index] || {}; // prev_list가 없는 경우 빈 객체

  let result = {};
  for (let key in curItem) {
    if (key === "cat_id" || key === "cat_nm") {
      result[key] = curItem[key]; // cat_id와 cat_nm은 curItem 값 유지
    } else {
      let curValue = isNaN(curItem[key]) ? curItem[key] : Number(curItem[key]);
      let prevValue = isNaN(prevItem[key]) ? prevItem[key] : Number(prevItem[key]);
      result[key] = curValue - prevValue;
    }
  }
  return result;
});


//로우 순서 지정
//  let new_list = new Array(8);

let new_list = [];

let pos_0 = list.find((item) => {
  if ( item.cat_id == 57)
    return item
});
let pos_1 = list.find((item) => item.cat_id == 56);
let pos_2 = list.find((item) => item.cat_id == 62);
//  let pos_3 = list.find((item) => item.cat_id == 777);
//  let pos_4 = list.find((item) => item.cat_id == 60);
//  let pos_5 = list.find((item) => item.cat_id == 79);
//  let pos_6 = list.find((item) => item.cat_id == 888);
let pos_7 = list.find((item) => item.cat_id == 999);
//  let pos_8 = list.find((item) => item.cat_id == 888);
//  let pos_9 = list.find((item) => item.cat_id == 999);

new_list.push( pos_0 )
new_list.push( pos_1 )
new_list.push( pos_2 )
//  new_list.push( pos_3 )
//  new_list.push( pos_4 )
//  new_list.push( pos_5 )
//  new_list.push( pos_6 )
new_list.push( pos_7 )


//  new_list[0] = pos_0
//  new_list[1] = pos_1
//  new_list[2] = pos_2
//  new_list[3] = pos_3
//  new_list[4] = pos_4
//  new_list[5] = pos_5
//  new_list[6] = pos_6
//  new_list[7] = pos_7
//  new_list[8] = pos_8
//  new_list[9] = pos_9
console.log(new_list)

return new_list