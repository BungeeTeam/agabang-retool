// 원본 데이터
const categories = get_categories_by_brand_for_reference.data;

// 대분류 추출 (null 제외, 중복 제거)
const largeCats = [...new Set(categories
  .filter(item => item.large_cat !== null)
  .map(item => item.large_cat))]
  .sort()
  .map(cat => ({
    label: cat,
    value: cat
  }));

// 중분류 추출 (대분류별로 그룹화)
const middleCatsByLarge = {};
categories
  .filter(item => item.large_cat !== null && item.middle_cat !== null)
  .forEach(item => {
    if (!middleCatsByLarge[item.large_cat]) {
      middleCatsByLarge[item.large_cat] = new Set();
    }
    middleCatsByLarge[item.large_cat].add(item.middle_cat);
  });

// Set을 배열로 변환
Object.keys(middleCatsByLarge).forEach(key => {
  middleCatsByLarge[key] = [...middleCatsByLarge[key]].sort().map(cat => ({
    label: cat,
    value: cat
  }));
});

// 소분류 추출 (대분류_중분류별로 그룹화)
const smallCatsByLargeMiddle = {};
categories
  .filter(item => item.large_cat !== null && item.middle_cat !== null && item.small_cat !== null)
  .forEach(item => {
    const key = `${item.large_cat}_${item.middle_cat}`;
    if (!smallCatsByLargeMiddle[key]) {
      smallCatsByLargeMiddle[key] = new Set();
    }
    smallCatsByLargeMiddle[key].add(item.small_cat);
  });

// Set을 배열로 변환
Object.keys(smallCatsByLargeMiddle).forEach(key => {
  smallCatsByLargeMiddle[key] = [...smallCatsByLargeMiddle[key]].sort().map(cat => ({
    label: cat,
    value: cat
  }));
});

// 모든 중분류 목록 (대분류 필터링 없이)
const allMiddleCats = [...new Set(categories
  .filter(item => item.middle_cat !== null)
  .map(item => item.middle_cat))]
  .sort()
  .map(cat => ({
    label: cat,
    value: cat
  }));

// 모든 소분류 목록 (필터링 없이)
const allSmallCats = [...new Set(categories
  .filter(item => item.small_cat !== null)
  .map(item => item.small_cat))]
  .sort()
  .map(cat => ({
    label: cat,
    value: cat
  }));

return {
  largeCats: largeCats,
  allMiddleCats: allMiddleCats,
  allSmallCats: allSmallCats,
  middleCatsByLarge: middleCatsByLarge,
  smallCatsByLargeMiddle: smallCatsByLargeMiddle
};