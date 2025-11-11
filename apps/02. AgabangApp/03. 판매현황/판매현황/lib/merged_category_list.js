function transform(data){
  const result = {};

  const transform_data = formatDataAsArray(data)
  transform_data.forEach(item => {
    
    result[item.id] = item.item_nm_list
    
  });
  result[55] = ['전체']

  return result
}

function groupItemNamesByItGb(data) {
  const transform_data = formatDataAsArray(data)
  const arr = Object.values(transform_data); // 객체를 배열로 변환
  return arr.reduce((acc, cur) => {
    if (!acc[cur.it_gb]) {
      acc[cur.it_gb] = [];
    }
    acc[cur.it_gb].push(cur.item_nm);
    return acc;
  }, {});
}

const clothes_data = {{ get_category_list.data }}
const supplies_data = {{ get_supplies_category_list.data }}

console.log(supplies_data)

//  const transformed_data = supplies_data.map(
//    item => item.it_gb
//  )

const result_01 = transform(clothes_data)
const result_02 = groupItemNamesByItGb(supplies_data)
const merged = {...result_01,...result_02}
console.log(result_01)
console.log(result_02)

console.log(merged)

return merged