// SQL 쿼리 'get_items_by_brand'의 전체 결과를 가져옵니다.
const rawData = {{ get_items_by_brand.data }};

// rawData 배열의 각 객체에서 'item_nm'을 label로, 'item'을 value로 매핑하여 새로운 배열을 만듭니다.
const smallCatData = rawData.map(item => ({
  // item.item_nm이 비어있거나 null, undefined일 경우 대체 텍스트를 사용합니다.
  label: item.item_nm ? item.item_nm : `소분류명 없음(코드: ${item.item})`,
  value: item.item
}));

// Retool Select Box에 표시할 "전체" 옵션을 정의합니다.
// value에 'all' 이라는 문자열을 다시 넣습니다.
const allOption = { label: "전체", value: "all" };

// "전체" 옵션을 가장 앞에 추가하고, 그 뒤에 변환된 카테고리 옵션들을 붙여서 최종 배열을 반환합니다.
return [allOption, ...smallCatData];