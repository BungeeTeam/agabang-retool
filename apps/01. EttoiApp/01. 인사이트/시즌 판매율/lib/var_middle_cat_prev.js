// Reference external variables with curly brackets or using JS variables
const list = {{middle_cat_prev.data}}

const result = list.reduce((obj, item) => {
  // 해당 cat_id 키가 없으면 빈 배열로 초기화
  if (!obj[item.cat_id]) {
    obj[item.cat_id] = [];
  }
  // 해당 cat_id 배열에 오브젝트 추가
  obj[item.cat_id].push(item);
  return obj;
}, {});

return result