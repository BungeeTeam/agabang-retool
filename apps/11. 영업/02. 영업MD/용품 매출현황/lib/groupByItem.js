const data = {{ getSalesByShop.data.filter(i=> tabs3.value === '합계' ? true : i.onoff_flag===tabs3.value) }}

const sumKeys = ["cur_qty", "cur_tag", "cur_amt", "cur_cost", "prev_qty", "prev_tag", "prev_amt", "prev_cost"];

// 1. '총계' 계산: 원본 데이터(data)를 사용하여 중복 없이 합산합니다.
const totalSums = data.reduce((acc, item) => {
  sumKeys.forEach(key => {
    acc[key] = (acc[key] || 0) + (Number(item[key]) || 0);
  });
  return acc;
}, {});

// 2. '총계' 객체 생성: 최종 배열에 추가할 객체를 만듭니다.
const grandTotalObject = {
  br_cd: '총계',
  br_nm: '',
  it_gb_nm: '',
  item_nm: '',
  ...totalSums
};

// 3. '소계'를 위한 데이터 확장 (기존 로직)
const expandedData = data.flatMap(item => [
  item,
  { ...item, br_cd: '소계', br_nm: '' }
]);

// 4. 아이템별 & 소계 그룹핑 (기존 로직)
const keysToGroup = ["br_cd", "br_nm", "it_gb_nm","item_nm"];
const allGroups = groupBySum(expandedData, keysToGroup, sumKeys);

// 5. 정렬 (기존 로직)
allGroups.sort((a, b) => {
  // 1순위: 중분류(it_gb_nm)
  if (a.it_gb_nm !== b.it_gb_nm) {
    return a.it_gb_nm.localeCompare(b.it_gb_nm);
  }

  // 2순위: 아이템명(item_nm)
  if (a.item_nm !== b.item_nm) {
    return a.item_nm.localeCompare(b.item_nm);
  }

  // 3순위: 같은 브랜드 내에서 소계는 마지막으로 보냄
  const isASubtotal = a.br_cd === '소계';
  const isBSubtotal = b.br_cd === '소계';

  if (isASubtotal) return 1;
  if (isBSubtotal) return -1;

  // 둘 다 소계가 아니면 브랜드명(br_cd)으로 정렬
  return a.br_cd.localeCompare(b.br_cd);
});

// 6. 최종 결과 반환: 맨 앞에 '총계' 객체를 추가합니다.
return [grandTotalObject, ...allGroups];

// const data = {{ getSalesByShop.data }};
// const sumKeys = ["cur_qty", "cur_tag", "cur_amt", "cur_cost", "prev_qty", "prev_tag", "prev_amt", "prev_cost"];


// // 1. 데이터를 확장하여 '소계' 항목을 미리 만듭니다. (기존 로직)
// const expandedData = data.flatMap(item => [
//   item, // 원본 아이템
//   { ...item, br_cd: '소계', br_nm: '소계' } // '소계' 처리를 위한 복사본 아이템
// ]);


// // 2. 확장된 데이터를 한번에 그룹핑합니다. (기존 로직)
// const keysToGroup = ["br_cd", "br_nm", "it_gb_nm"];
// const allGroups = groupBySum(expandedData, keysToGroup, sumKeys);


// // 3. 최종 결과를 정렬합니다. (기존 로직)
// allGroups.sort((a, b) => {
//   if (a.it_gb_nm !== b.it_gb_nm) {
//     return a.it_gb_nm.localeCompare(b.it_gb_nm);
//   }
//   const isASubtotal = a.br_cd === '소계';
//   const isBSubtotal = b.br_cd === '소계';
//   if (isASubtotal) return 1;
//   if (isBSubtotal) return -1;
//   return a.br_cd.localeCompare(b.br_cd);
// });




// return allGroups;