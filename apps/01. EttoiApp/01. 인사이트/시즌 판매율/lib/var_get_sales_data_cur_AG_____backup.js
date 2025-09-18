// Reference external variables with curly brackets or using JS variables
const list = {{ get_sales_data_cur.data }}

//로우 순서 지정
//  let new_list = new Array(10);
let new_list = [];

let pos_0 = list.find((item) => {
  if ( item.cat_nm == '시즌의류(B)')
    return item
});
let pos_1 = list.find((item) => item.cat_nm == '시즌의류(T)');
let pos_2 = list.find((item) => item.cat_nm == '시즌의류');
let pos_3 = list.find((item) => item.cat_nm == '시즌언더');
let pos_4 = list.find((item) => item.cat_nm == '시즌용품');
let pos_5 = list.find((item) => item.cat_nm == '정상소계');
let pos_6 = list.find((item) => item.cat_nm == '기획의류');
let pos_7 = list.find((item) => item.cat_nm == '기획언더');
let pos_8 = list.find((item) => item.cat_nm == '기획소계');
let pos_9 = list.find((item) => item.cat_nm == '총계');

if (pos_0) new_list.push(pos_0);
if (pos_1) new_list.push(pos_1);
if (pos_2) new_list.push(pos_2);
if (pos_3) new_list.push(pos_3);
if (pos_4) new_list.push(pos_4);
if (pos_5) new_list.push(pos_5);
if (pos_6) new_list.push(pos_6);
if (pos_6) new_list.push(pos_7);
if (pos_8) new_list.push(pos_8);
if (pos_9) new_list.push(pos_9);



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

return new_list