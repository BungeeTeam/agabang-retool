const data = {{ getSalesByShop2.data.filter(i=> tabs5.value === '합계' ? true : i.onoff_flag===tabs5.value) }}

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
  br_nm: '총계',
  it_gb_nm: '총계',
  ...totalSums
};

// 3. '소계'를 위한 데이터 확장 (기존 로직)
const expandedData = data.flatMap(item => [
  item,
  { ...item, br_cd: '소계', br_nm: '소계' }
]);

// 4. 아이템별 & 소계 그룹핑 (기존 로직)
const keysToGroup = ["br_cd", "br_nm", "it_gb_nm"];
const allGroups = groupBySum(expandedData, keysToGroup, sumKeys);

// 5. 정렬 (기존 로직)
allGroups.sort((a, b) => {
  if (a.it_gb_nm !== b.it_gb_nm) {
    return a.it_gb_nm.localeCompare(b.it_gb_nm);
  }
  const isASubtotal = a.br_cd === '소계';
  const isBSubtotal = b.br_cd === '소계';
  if (isASubtotal) return 1;
  if (isBSubtotal) return -1;
  return a.br_cd.localeCompare(b.br_cd);
});

// 6. 최종 결과 반환: 맨 앞에 '총계' 객체를 추가합니다.
return [grandTotalObject, ...allGroups];

// const data = {{ getSalesByShop2.data }};
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