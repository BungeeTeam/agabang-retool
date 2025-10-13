const data = {{ getPeriodicSalesByStyleQuery.value }};
const sumKeys = ["rev"];

// 1. 데이터를 확장하여 '소계' 항목을 미리 만듭니다.
// flatMap을 사용해 각 원본 데이터에 대해 [원본, 소계용 복사본] 두 개의 항목을 생성합니다.
const expandedData = data.flatMap(item => [
  item, // 원본 아이템
  { ...item, sub_br_cd: '소계', sub_br_nm: '소계' } // '소계' 처리를 위한 복사본 아이템
]);

// 2. 확장된 데이터를 한번에 그룹핑합니다.
// 이제 'it_gb_nm'까지 포함하여 그룹핑하면 아이템별 합계와 브랜드별 '소계'가 동시에 계산됩니다.
const keysToGroup = ["time_unit", "br_cd", "br_nm", "sub_br_cd", "sub_br_nm", "it_gb_nm"];
const allGroups = groupBySum(expandedData, keysToGroup, sumKeys);

// 3. 결과를 피벗합니다.
const keysToPivot = ["br_cd", "br_nm", "sub_br_cd", "sub_br_nm", "it_gb_nm"];
const pivotArr = pivotData(allGroups, keysToPivot, "time_unit", sumKeys);

// 4. 최종 결과를 정렬합니다.
pivotArr.sort((a, b) => {
  // 1순위: 브랜드 코드가 다르면 브랜드 코드로 정렬
  if (a.it_gb_nm !== b.it_gb_nm) {
    return a.it_gb_nm.localeCompare(b.it_gb_nm);
  }

  // 2순위: 브랜드(sub_br_nm)
  if (a.br_nm !== b.br_nm) {
    return a.br_nm.localeCompare(b.br_nm);
  }
  
  // 3순위: 같은 브랜드 내에서 정렬 규칙 적용
  const isASubtotal = a.sub_br_nm === '소계';
  const isBSubtotal = b.sub_br_nm === '소계';

  if (isASubtotal) return 1; // a가 '소계'면 무조건 뒤로 보냄
  if (isBSubtotal) return -1; // b가 '소계'면 a를 앞으로 보냄

  // 둘 다 '소계'가 아니면 아이템명으로 정렬
  return a.sub_br_nm.localeCompare(b.sub_br_nm);
});

return pivotArr;