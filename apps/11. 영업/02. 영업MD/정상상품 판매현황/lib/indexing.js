/**
 * 여러 조건 세트를 동시에 적용하여 각 객체에 여러 개의 키-값을 추가하는 함수
 *
 * @param {Array<Object>} items - 인덱싱할 대상 객체 배열
 * @param {Object} ruleMap - 키: 조건 배열(rules)의 형태로 구성된 맵
 * @param {Object} [defaultMap={}] - 조건이 일치하지 않을 경우 각 키에 대해 사용할 기본값 설정
 * @returns {Array<Object>} - 각 객체에 지정된 키-값이 추가된 새로운 배열
 */
function applyMultipleIndexing(items, ruleMap, defaultMap = {}) {
  return items.map(item => {
    const updated = { ...item };

    for (const [targetKey, rules] of Object.entries(ruleMap)) {
      const matchedRule = rules.find(rule => rule.when(item));
      updated[targetKey] = matchedRule ? matchedRule.then : (defaultMap[targetKey] || '');
    }

    return updated;
  });
}

const data = {{ formatDataAsArray(periodicSalesByStyleQuery.data).filter(i=> tabs1.value === '합계' ? true : i.onoff_flag===tabs1.value).filter(i=>i.sales_type==='정상') }};

const categoryNameRules = [
  { when: item => item.it === '1', then: '시즌언더' },
  { when: item => item.it === '2', then: '시즌의류(B)' },
  { when: item => item.it === '3', then: '시즌의류(T)' },
  { when: item => item.it === '4', then: '파자마' },
  { when: item => item.it === '5' && item.it_gb === '57', then: '기획언더' },
  { when: item => item.it === '5', then: '기획의류' },
  { when: item => item.it === '6', then: '위탁용품' },
  { when: item => item.it === '7', then: '시즌용품' },
  { when: item => item.it === '8', then: '일반용품' },
  { when: item => item.it === '9', then: '판촉부자재' }
];

//  const salesTypeRules = [
//    { when: item => item.year_unit === '2025'&&(
//      (item.season_cd === '0'&&parseInt(item.year_nm.match(/\d+/)[0])<= 2023)||(item.season_cd != '0'&&parseInt(item.year_nm.match(/\d+/)[0])<= 2024)
//    ), then: '정상' },
//    { when: item => item.year_unit === '2024'&&(
//      (item.season_cd === '0'&&parseInt(item.year_nm.match(/\d+/)[0])<= 2022)||(item.season_cd != '0'&&parseInt(item.year_nm.match(/\d+/)[0])<= 2023)
//    ), then: '정상' }
//  ];

//  const salesTypeRules = [
//    { when: item => item.year_unit === 2025&&(
//      (item.season_cd === '0'&&['2024','2025'].includes(item.year_nm)||(item.season_cd != '0'&& item.year_nm === '2025' ))
//    ), then: '정상' },
//    { when: item => item.year_unit === 2024&&(
//      (item.season_cd === '0'&&['2023','2024'].includes(item.year_nm)||(item.season_cd != '0'&& item.year_nm === '2024' ))
//    ), then: '정상' }
//  ];

//  const categoryOrderRules = [
//    { when: item => ['1', '4'].includes(item.it), then: '1' },
//    { when: item => item.it === '5' && item.it_gb === '57', then: '3' },
//    { when: item => item.it === '5' && (!item.it_gb || item.it_gb !== '57'), then: '4' },
//    { when: item => item.it === '7', then: '5' },
//    { when: item => ['2', '3'].includes(item.it), then: '2' }
//  ];
const categoryOrderRules = [
  { when: item => item.it === '1', then: '2' },
  { when: item => item.it === '2', then: '0' },
  { when: item => item.it === '3', then: '1' },
  { when: item => item.it === '4', then: '4' },
  { when: item => item.it === '5' && item.it_gb === '57', then: '6' },
  { when: item => item.it === '5', then: '5' },
  { when: item => item.it === '6', then: '7' },
  { when: item => item.it === '7', then: '3' },
  { when: item => item.it === '8', then: '8' },
  { when: item => item.it === '9', then: '9' }
];

const ruleMap = {
  category_name: categoryNameRules,  
  //  sales_type: salesTypeRules,     
  category_order: categoryOrderRules       
};
const defaultMap = {
  category_name: '기타',
  //  sales_type: '이월',
  category_order: '8'
};


const result = applyMultipleIndexing(data,ruleMap,defaultMap)

console.log(result)

return result
