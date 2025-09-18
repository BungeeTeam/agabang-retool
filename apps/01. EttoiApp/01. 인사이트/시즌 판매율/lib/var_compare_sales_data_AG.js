const cur_list = {{ var_get_sales_data_cur_AG.value }}
const prev_list = {{ var_get_sales_data_prev_AG.value }}

// 모든 cat_id를 수집하여 중복 없이 저장
const allCatIds = [...new Set([
  ...cur_list.map(item => item.cat_id),
  ...prev_list.map(item => item.cat_id)
])];

// 각 cat_id에 대한 cur_list와 prev_list의 아이템을 찾아 결과 생성
let com_list = allCatIds.map(catId => {
  // 현재 및 이전 리스트에서 해당 cat_id를 가진 아이템 찾기
  const curItem = cur_list.find(item => item.cat_id === catId) || {};
  const prevItem = prev_list.find(item => item.cat_id === catId) || {};
  
  // 결과 객체 생성
  let result = {
    // cat_id와 cat_nm은 curItem에서 우선 가져오고, 없으면 prevItem에서 가져옴
    cat_id: catId,
    cat_nm: curItem.cat_nm || prevItem.cat_nm || ""
  };
  
  // 모든 키를 수집 (cat_id와 cat_nm 제외)
  const allKeys = [...new Set([
    ...Object.keys(curItem).filter(key => key !== "cat_id" && key !== "cat_nm"),
    ...Object.keys(prevItem).filter(key => key !== "cat_id" && key !== "cat_nm")
  ])];
  
  // 각 키에 대해 차이 계산
  allKeys.forEach(key => {
    const curValue = isNaN(curItem[key]) ? 0 : Number(curItem[key] || 0);
    const prevValue = isNaN(prevItem[key]) ? 0 : Number(prevItem[key] || 0);
    result[key] = curValue - prevValue;
  });
  
  return result;
});

// // Reference external variables with curly brackets or using JS variables
// const cur_list = {{ var_get_sales_data_cur_AG.value }}
// const prev_list = {{ var_get_sales_data_prev_AG.value }}


// // 현재 - 전년동기 빼기
// let com_list = cur_list.map((curItem, index) => {
//   let prevItem = prev_list[index] || {}; // prev_list가 없는 경우 빈 객체

//   let result = {};
//   for (let key in curItem) {
//     if (key === "cat_id" || key === "cat_nm") {
//       result[key] = curItem[key]; // cat_id와 cat_nm은 curItem 값 유지
//     } else {
//       let curValue = isNaN(curItem[key]) ? curItem[key] : Number(curItem[key]);
//       let prevValue = isNaN(prevItem[key]) ? prevItem[key] : Number(prevItem[key]);
//       result[key] = curValue - prevValue;
//     }
//   }
//   return result;
// });


let id_list = ['1','2','3','666','777','4','5','888','8','999']
let new_list = [];


function getPostionItem(_cat_id) {
  return com_list.find((item) => item.cat_id == _cat_id);
}

id_list.forEach((_name) => {
  let item = getPostionItem(_name)
  if(item){
    new_list.push(item);
  }
})


return new_list

// 로우 순서 지정

//  //  let new_list = new Array(10);
//  let new_list = [];
//  let pos_0 = com_list.find((item) => {
//    if ( item.cat_id == 21)
//      return item
//  });
//  let pos_1 = com_list.find((item) => item.cat_id == 22);
//  let pos_2 = com_list.find((item) => item.cat_id == 666);
//  let pos_3 = com_list.find((item) => item.cat_id == 20);
//  let pos_4 = com_list.find((item) => item.cat_id == 27);
//  let pos_5 = com_list.find((item) => item.cat_id == 777);
//  let pos_6 = com_list.find((item) => item.cat_id == 24);
//  let pos_7 = com_list.find((item) => item.cat_id == 25);
//  let pos_8 = com_list.find((item) => item.cat_id == 888);
//  let pos_9 = com_list.find((item) => item.cat_id == 999);

//  if (pos_0) new_list.push(pos_0);
//  if (pos_1) new_list.push(pos_1);
//  if (pos_2) new_list.push(pos_2);
//  if (pos_3) new_list.push(pos_3);
//  if (pos_4) new_list.push(pos_4);
//  if (pos_5) new_list.push(pos_5);
//  if (pos_6) new_list.push(pos_6);
//  if (pos_7) new_list.push(pos_7);
//  if (pos_8) new_list.push(pos_8);
//  if (pos_9) new_list.push(pos_9);

//  //  new_list[0] = pos_0
//  //  new_list[1] = pos_1
//  //  new_list[2] = pos_2
//  //  new_list[3] = pos_3
//  //  new_list[4] = pos_4
//  //  new_list[5] = pos_5
//  //  new_list[6] = pos_6
//  //  new_list[7] = pos_7
//  //  new_list[8] = pos_8
//  //  new_list[9] = pos_9

//  return new_list