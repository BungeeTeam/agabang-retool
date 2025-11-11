// parse_cascader_path.js
// Cascader에서 선택한 경로를 파싱

const selectedPath = cascaderNew1.value || '';

const result = {
  large_cat: null,
  middle_cat: null,
  small_cat: null,
  // 필터링 시 사용할 플래그
  large_all: false,   // 대분류 전체 선택 여부
  middle_all: false,  // 중분류 전체 선택 여부
  small_all: false,   // 소분류 전체 선택 여부
  // 디버깅용
  full_path: selectedPath,
  selected_level: 0,   // 선택된 레벨 (0: 미선택, 1: 대분류, 2: 중분류, 3: 소분류)
  is_brand_07: var_brand_code.value === '07',  // br_cd = '07' 여부
  is_middle_null: false  // middle_cat이 NULL인 경우 (0코드 등)
};

// 빈 값 처리
if (!selectedPath || selectedPath === '') {
  return result;
}

// 문자열 "_ALL_"인 경우 처리
if (selectedPath === "_ALL_") {
  result.large_all = true;
  result.selected_level = 1;
  return result;
}

// "/"로 구분된 경로 파싱
if (selectedPath.includes('/')) {
  const parts = selectedPath.split('/');
  
  // 대분류
  result.large_cat = parts[0] === '_ALL_' ? null : parts[0];
  result.large_all = parts[0] === '_ALL_';
  result.selected_level = 1;
  
  // '0코드' 여부 확인
  result.is_middle_null = (result.large_cat === '0코드');
  
  if (result.is_brand_07 || result.is_middle_null) {
    // br_cd = '07'이거나 middle_cat이 NULL인 경우: 대분류/소분류 구조
    if (parts.length >= 2) {
      // 두 번째 부분이 소분류
      result.small_cat = parts[1] === '_ALL_' ? null : parts[1];
      result.small_all = parts[1] === '_ALL_';
      if (result.is_brand_07) {
        result.middle_cat = result.large_cat;  // br_cd = '07'인 경우 중분류는 대분류와 동일
      }
      // '0코드'인 경우 middle_cat은 null로 유지
      result.selected_level = 3;  // 소분류 레벨로 설정
    }
  } else {
    // 일반적인 경우: 대분류/중분류/소분류 구조
    // 중분류
    if (parts.length >= 2) {
      result.middle_cat = parts[1] === '_ALL_' ? null : parts[1];
      result.middle_all = parts[1] === '_ALL_';
      result.selected_level = 2;
    }
    
    // 소분류
    if (parts.length >= 3) {
      result.small_cat = parts[2] === '_ALL_' ? null : parts[2];
      result.small_all = parts[2] === '_ALL_';
      result.selected_level = 3;
    }
  }
} else {
  // 단일 값 (대분류만 선택)
  result.large_cat = selectedPath;
  result.selected_level = 1;
  result.is_middle_null = (result.large_cat === '0코드');
}

return result;