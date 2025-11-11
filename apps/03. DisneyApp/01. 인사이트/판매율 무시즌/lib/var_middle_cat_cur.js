// Reference external variables with curly brackets or using JS variables
const list = {{get_middle_cat_sales_data.data}}

//  console.log(`===?>asdfasdf??`)
//  console.log(list)
 
const result = list.reduce((obj, item) => {
  // 해당 cat_id 키가 없으면 빈 배열로 초기화
  if (!obj[item.cat_id]) {
    obj[item.cat_id] = [];
  }
  // 해당 cat_id 배열에 오브젝트 추가
  obj[item.cat_id].push(item);
  return obj;
}, {});

//  const test = result[20].map(item => item.middle_cat)
//  console.log(result[20].middle_cat)
//  console.log(test)

return result