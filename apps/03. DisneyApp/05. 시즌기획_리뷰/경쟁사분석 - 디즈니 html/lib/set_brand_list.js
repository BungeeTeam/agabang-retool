// 모든 최상위 키의 하위 키 추출
const allSubKeys = Object.keys(get_items.data).flatMap(topKey => 
  Object.keys(get_items.data[topKey])
);

// 결과 출력
console.log(allSubKeys); // 모든 하위 키 배열 출력 ["디즈니", "압소바", "디즈니_1", ...]

const filterSubKeys = allSubKeys.filter(key => key !== "디즈니")


// 중복 제거 (필요시)
const uniqueSubKeys = [...new Set(filterSubKeys)];

// Retool 변수에 설정
var_brand_orders.setValue(uniqueSubKeys);