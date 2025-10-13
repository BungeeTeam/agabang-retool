

const data = {{ getSalesByShop2.data}}
  .filter(i=> {{tabs5.value}} === '합계' ? true : i.onoff_flag==={{tabs5.value}})
  .filter(i => !{{ selectedRow2.value?.it_gb_nm }} ||  i.it_gb_nm === {{ selectedRow2.value?.it_gb_nm }})
  .filter(i => !{{ selectedRow2.value?.item_nm }} || i.item_nm === {{ selectedRow2.value?.item_nm }})
  .filter(i => !{{ selectedRow2.value?.br_nm }} || {{ selectedRow2.value?.br_nm === '소계' }} || i.br_nm === {{ selectedRow2.value?.br_nm }})
  .filter(i => !{{ selectedRow2.value?.sub_br_nm }} || {{ selectedRow2.value?.sub_br_nm === '소계' }} || i.sub_br_nm === {{ selectedRow2.value?.sub_br_nm }});


const outData = {{ getOutByShop2.data }}

console.log(data)
console.log(outData)

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
  shop_cd: '총계',
  shop_nm: '총계',
  ...totalSums
};


// 4. 아이템별 & 소계 그룹핑 (기존 로직)
const keysToGroup = ["shop_cd", "shop_nm"];
const allGroups = groupBySum(data, keysToGroup, sumKeys);


// 6. 최종 결과 반환: 맨 앞에 '총계' 객체를 추가합니다.
return [grandTotalObject, ...allGroups];