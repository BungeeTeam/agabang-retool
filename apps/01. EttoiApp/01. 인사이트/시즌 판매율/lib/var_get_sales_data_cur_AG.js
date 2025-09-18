// row순서 부여하는 곳

const list = {{ get_sales_data_cur.data }}
//  const list = {{ query_sales_data.data }}

//  let name_list = ['시즌의류(B)','시즌의류(T)','시즌의류','시즌언더','시즌용품','정상소계','기획의류','기획언더','기획소계','총계']
//  let id_list = ['21','22','666','20','27','777','24','25','888','999']
let id_list = ['1','2','3','666','777','4','5','888','8','999']
let new_list = [];


function getPostionItem(_cat_id) {
  if(list){
    return list?.find((item) => item.cat_id == _cat_id);
  }
  return null
  
}

id_list.forEach((_name) => {
  let item = getPostionItem(_name)
  if(item){
    new_list.push(item);
  }
})


return new_list


//  //  const list = {{middle_cat_cur.data}}

//  const result = new_list.reduce((obj, item) => {
//    // 해당 cat_id 키가 없으면 빈 배열로 초기화
//    if (!obj[item.cat_id]) {
//      obj[item.cat_id] = [];
//    }
//    // 해당 cat_id 배열에 오브젝트 추가
//    obj[item.cat_id].push(item);
//    return obj;
//  }, {});

//  //  return result
//  return{
//    _table: new_list,
//    _array: result
//  }
