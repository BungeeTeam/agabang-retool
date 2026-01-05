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

const data = {{ formatDataAsArray(periodicSalesByStyleQuery.data).filter(i=> tabs1.value === '합계' ? true : i.onoff_flag===tabs1.value) }};


const categoryNameRules = [
  { when: item => ['1', '4'].includes(item.it), then: '기초정상' },
  { when: item => item.it === '5' && item.it_gb === '57', then: '기획내의' },
  { when: item => item.it === '5', then: '기획의류' },
  { when: item => item.it === '7', then: '시즌용품' },
  { when: item => ['2', '3'].includes(item.it), then: '정상의류' }
];

const categoryOrderRules = [
  { when: item => ['1', '4'].includes(item.it), then: '1' },
  { when: item => item.it === '5' && item.it_gb === '57', then: '3' },
  { when: item => item.it === '5' && (!item.it_gb || item.it_gb !== '57'), then: '4' },
  { when: item => item.it === '7', then: '5' },
  { when: item => ['2', '3'].includes(item.it), then: '2' }
];
const ruleMap = {
  category_name: categoryNameRules,  
  //  sales_type: salesTypeRules,     
  category_order: categoryOrderRules       
};
const defaultMap = {
  category_name: '기타',
  //  sales_type: '이월',
  category_order: '기타'
};


const result = applyMultipleIndexing(data,ruleMap,defaultMap)

console.log(result)

return result
