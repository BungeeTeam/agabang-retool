// 서브브랜드별 매출 현황 테이블 데이터를 엑셀 다운로드용으로 변환
// 금액 컬럼은 원단위로 변환 (백만원 * 1000000)
// salesBySubBrand.value를 소스 데이터로 사용
// 주의: salesBySubBrand은 target_sales가 없음

utils.changeLocale("ko")

const data = groupByCategory.value;

// 테이블 컬럼 순서에 맞춰 데이터 변환
const exportData = data.map(row => {
  //금액 숫자 변환
  const sale_tag = Number(row.sale_tag);
  const sale_amt = Number(row.sale_amt);
  const sale_qty = Number(row.sale_qty);
  const net_out_tag = Number(row.net_out_tag);
  const net_out_amt = Number(row.net_out_amt);
  const net_out_qty = Number(row.net_out_qty);
  const ttl_out_tag = Number(row.ttl_out_tag);
  const ttl_out_amt = Number(row.ttl_out_amt);
  const ttl_out_qty = Number(row.ttl_out_qty);
  const ttl_rtn_tag = Number(row.ttl_rtn_tag);
  const ttl_rtn_amt = Number(row.ttl_rtn_amt);
  const ttl_rtn_qty = Number(row.ttl_rtn_qty);
  // 판매율 계산
  const sale_rate_amt = net_out_amt !== 0 ? (sale_amt / net_out_amt) : null
  const sale_rate_qty = net_out_qty !== 0 ? (sale_qty / net_out_qty): null
 // 할인율 계산
  const sale_discount_rate = sale_tag !== 0 ? 1- (sale_amt / sale_tag): null
  const out_discount_rate = net_out_tag !== 0 ? 1- (net_out_amt / net_out_tag): null
  
  // 테이블 컬럼 순서대로 구성 (target_sales 관련 컬럼 제외)
  const newRow = {
    // 1. 서브브랜드
    "등급": row.item_grade || "",
    "대분류": row.category_name || "",
    "판매금액(TAG)": sale_tag || 0,
    "실판매금액": sale_amt || 0,
    "판매수량": sale_qty || 0,
    "판매율(금액)": sale_rate_amt || 0,
    "판매율(수량)": sale_rate_qty || 0,
    "순출고금액(TAG)": net_out_tag || 0,
    "순출고금액(실판가)": net_out_amt || 0,
    "순출고수량": net_out_qty || 0,
    "재고금액(TAG)": net_out_tag - sale_tag || 0,
    "재고금액(실판가)": net_out_amt - sale_amt || 0,
    "재고수량": net_out_qty - sale_qty || 0,
    "할인율(판매)": sale_discount_rate || 0,
    "할인율(출고)": out_discount_rate || 0
  };

  // 기간 누적 출고,반품 데이터
  if (switch1.value === true) {
      newRow["기간 누적 출고량"] = ttl_out_qty || 0,
      newRow["기간 누적 반품량"] = ttl_rtn_qty || 0,
      newRow["기간 누적 출고금액(실판가)"] = ttl_out_amt || 0,
      newRow["기간 누적 반품금액(실판가)"] = ttl_rtn_amt || 0,
      newRow["기간 누적 출고금액(TAG)"] = ttl_out_tag || 0,
      newRow["기간 누적 반품금액(TAG)"] = ttl_rtn_tag || 0
  }
  
  return newRow;
});

// 파일명 생성
const fileName = `이월등급별 판매현황-${bizMultiSelect2.selectedLabel}-${brandMultiSelect2.selectedLabel}-${yearSelect2.selectedLabel}(${endDate.value}마감 기준)`

// 엑셀 다운로드
utils.exportData(exportData, fileName, "xlsx")

