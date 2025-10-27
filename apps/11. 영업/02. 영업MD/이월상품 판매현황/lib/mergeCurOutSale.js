const out = {{ varResult.value.curOut }}
const sale = {{ varResult.value.curSale }}

// 병합 기준 컬럼 정의
const mergeFields = [
  "biz_cd", "biz_nm", "br_cd", "br_nm", "shop_cd", "shop_nm", "tp_cd", "tp_nm",
  "year_cd", "year_nm", "season_cd", "season_nm", "onoff_flag",
  "year_season_cd", "category_name", "category_order", "item_grade"
];

// Out 전용 필드
const outFields = ["net_out_qty","net_out_tag","net_out_amt","ttl_out_qty","ttl_rtn_qty","ttl_out_amt","ttl_rtn_amt","ttl_out_tag","ttl_rtn_tag"];

// Sale 전용 필드
const saleFields = ["sale_tag", "sale_qty", "sale_amt"];

// Key Generator Function
function generateKey(item) {
  return mergeFields.map(field => item[field]).join('|');
}

// Create Maps for Fast Lookup
const outMap = new Map(out.map(item => [generateKey(item), item]));
const saleMap = new Map(sale.map(item => [generateKey(item), item]));

// Merge Keys
const mergedKeys = new Set([...outMap.keys(), ...saleMap.keys()]);

// Final Merged Data
const mergedData = Array.from(mergedKeys).map(key => {
  const outItem = outMap.get(key);
  const saleItem = saleMap.get(key);

  // 공통 필드 처리
  const base = {};
  mergeFields.forEach(field => {
    base[field] = outItem?.[field] || saleItem?.[field] || 0;
  });

  // out 필드 처리 (숫자 0 기본값)
  outFields.forEach(field => {
    base[field] = outItem?.[field] || 0;
  });

  // sale 필드 처리 (문자열 "0" 기본값)
  saleFields.forEach(field => {
    base[field] = saleItem?.[field] || 0;
  });

  return base;
});

console.log(mergedData);

return mergedData