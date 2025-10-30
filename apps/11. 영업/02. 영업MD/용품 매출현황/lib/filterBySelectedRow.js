

const data = {{ getSalesByShop.data}}
  .filter(i=> {{tabs3.value}} === '합계' ? true : i.onoff_flag==={{tabs3.value}})
  //  .filter(i => !{{ selectedRow_old.value?.it_gb_nm }} ||  i.it_gb_nm === {{ selectedRow_old.value?.it_gb_nm }})
  //  .filter(i => ['소계', '총계'].includes({{ selectedRow_old.value?.br_cd }})|| i.item_nm === {{ selectedRow_old.value?.item_nm }})
  //  .filter(i => ['소계', '총계'].includes({{ selectedRow_old.value?.br_cd }}) || i.br_nm === {{ selectedRow_old.value?.br_nm }})
  //  .filter(i => !{{ selectedRow_old.value?.sub_br_nm }} || {{ selectedRow_old.value?.sub_br_nm === '소계' }} || i.sub_br_nm === {{ selectedRow_old.value?.sub_br_nm }});

const filteredDataSet = {
  '중분류별': data.filter(i => {
  const row = {{selectedRow_old.value}};
  if (row?.br_cd === '총계') return true;
  if (row?.br_cd === '소계') return row.it_gb_nm === i.it_gb_nm;
  return row.it_gb_nm === i.it_gb_nm && row.br_nm === i.br_nm;
}) ,
'소분류별': data.filter(i => {
  const row = {{selectedRow_old.value}};
  if (row?.br_cd === '총계') return true;
  if (row?.br_cd === '소계') return row.item_nm === i.item_nm && row.it_gb_nm === i.it_gb_nm;
  return row.it_gb_nm === i.it_gb_nm && row.br_nm === i.br_nm && row.item_nm === i.item_nm ;
})  ,
'서브브랜드별': data.filter(i => {
  const row = {{selectedRow_old.value}};
  if (row?.br_cd === '총계') return true;
  if (row?.sub_br_cd === '소계') return row.br_nm === i.br_nm;
  return row.sub_br_nm === i.sub_br_nm && row.br_nm === i.br_nm;
}) 
}

const filteredData = filteredDataSet[{{ tabs1.value }}]

const outData = {{ getOutByShop.data }}

console.log(data)
console.log(outData)

const sumKeys = ["cur_qty", "cur_tag", "cur_amt", "cur_cost", "prev_qty", "prev_tag", "prev_amt", "prev_cost"];

// 1. '총계' 계산: 원본 데이터(data)를 사용하여 중복 없이 합산합니다.
const totalSums = filteredData.reduce((acc, item) => {
  sumKeys.forEach(key => {
    acc[key] = (acc[key] || 0) + (Number(item[key]) || 0);
  });
  return acc;
}, {});

// 2. '총계' 객체 생성: 최종 배열에 추가할 객체를 만듭니다.
const grandTotalObject = {
  shop_cd: '총계',
  shop_nm: '총계',
  ...totalSums
};


// 4. 아이템별 & 소계 그룹핑 (기존 로직)
const keysToGroup = ["shop_cd", "shop_nm"];
const allGroups = groupBySum(filteredData, keysToGroup, sumKeys);


// 6. 최종 결과 반환: 맨 앞에 '총계' 객체를 추가합니다.
return [grandTotalObject, ...allGroups];



//  const outData = {{ getOutByShop.data }}

//  console.log(data)
//  console.log(outData)

//  const sumKeys = ["cur_qty", "cur_tag", "cur_amt", "cur_cost", "prev_qty", "prev_tag", "prev_amt", "prev_cost"];

//  // 1. '총계' 계산: 원본 데이터(data)를 사용하여 중복 없이 합산합니다.
//  const totalSums = data.reduce((acc, item) => {
//    sumKeys.forEach(key => {
//      acc[key] = (acc[key] || 0) + (Number(item[key]) || 0);
//    });
//    return acc;
//  }, {});

//  // 2. '총계' 객체 생성: 최종 배열에 추가할 객체를 만듭니다.
//  const grandTotalObject = {
//    shop_cd: '총계',
//    shop_nm: '총계',
//    ...totalSums
//  };


//  // 4. 아이템별 & 소계 그룹핑 (기존 로직)
//  const keysToGroup = ["shop_cd", "shop_nm"];
//  const allGroups = groupBySum(data, keysToGroup, sumKeys);


//  // 6. 최종 결과 반환: 맨 앞에 '총계' 객체를 추가합니다.
//  return [grandTotalObject, ...allGroups];