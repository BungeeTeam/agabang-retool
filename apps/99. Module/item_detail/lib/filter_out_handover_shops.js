// 1. 각 쿼리로부터 데이터 가져오기 및 배열로 일관되게 포맷
const clickhouseResults = formatDataAsArray(get_shop_sales.data);
const shopHandoverData = formatDataAsArray(get_shop_handover.data);

if (clickhouseResults.length === 0) {
  return [];
}

// 2. 인수인계 이전 매장 코드(PREV_SHOP_CD) 목록 만들기
const prevShopCodesToFilterOut = new Set();
if (shopHandoverData.length > 0) {
  shopHandoverData.forEach(handoverEntry => {
    if (handoverEntry && typeof handoverEntry === 'object') {
      let prevShopCd = handoverEntry.PREV_SHOP_CD; // 대문자 우선 시도
      if (prevShopCd === undefined) {
        prevShopCd = handoverEntry.prev_shop_cd; // 소문자 시도
      }

      if (prevShopCd != null) {
        prevShopCodesToFilterOut.add(String(prevShopCd).trim());
      }
    }
  });
}

// 3. clickhouseResults 아이템 필터링
const filteredItems = clickhouseResults.filter((itemFromClickHouse, index) => {
  // 아이템 전체를 로그로 먼저 확인 (필요시 너무 길면 일부만)
  // console.log(`\n[FILTERING_ITEM_${index}] Full item data:`, JSON.stringify(itemFromClickHouse, null, 2));

  if (!(itemFromClickHouse && typeof itemFromClickHouse === 'object')) {
    return false;
  }

  const ACTUAL_SHOP_CODE_FIELD_NAME = 'A.shop_cd'; // <<<< 소문자 'shop_cd'로 변경!!!
  
  const shopCodeFromItemRaw = itemFromClickHouse[ACTUAL_SHOP_CODE_FIELD_NAME];

  if (shopCodeFromItemRaw == null) { // undefined 또는 null 체크
    return true;
  }

  const currentShopCodeTrimmed = String(shopCodeFromItemRaw).trim();
  
  let foundInSet = prevShopCodesToFilterOut.has(currentShopCodeTrimmed);
  
  if (foundInSet) {
    return false; // prev_shop_cd 목록에 있으면 필터링 (제거)
  } else {
    return true; // prev_shop_cd 목록에 없으면 결과에 포함
  }
});

return filteredItems;