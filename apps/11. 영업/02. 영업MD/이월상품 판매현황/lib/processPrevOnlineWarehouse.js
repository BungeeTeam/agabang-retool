// 전년동기 온라인 창고 데이터 처리 함수
// groupBySum 함수는 전역에서 사용

// 원시 데이터 가져오기
const rawData = {{ varResult.value.prevOnlineWarehouse }};

// 데이터가 없으면 빈 배열 반환
if (!Array.isArray(rawData)) {
  return [];
}

// 1. 브랜드 필터링
const filtered = rawData.filter(i => i.br_cd === {{ brandMultiSelect2.value }});

// 2. 카테고리별 그룹화 (year_season_cd 제거 - 매칭 키와 일치)
const sumKeys = ["net_out_qty","net_out_tag","net_out_amt","ttl_out_qty","ttl_rtn_qty","ttl_out_amt","ttl_rtn_amt","ttl_out_tag","ttl_rtn_tag"];
const keys = ["br_cd", "year_cd", "season_cd", "category_name"];

const groupedArr = groupBySum(filtered, keys, sumKeys);

return groupedArr;