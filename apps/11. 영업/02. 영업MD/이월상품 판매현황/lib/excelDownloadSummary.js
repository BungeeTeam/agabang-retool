utils.changeLocale("ko")

const data = summaryData.value;

// 먼저 기본 계산을 모두 구해둠
const baseRows = data.map(row => {
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

  return {
    row,
    sale_tag,
    sale_amt,
    sale_qty,
    net_out_tag,
    net_out_amt,
    net_out_qty,
    ttl_out_tag,
    ttl_out_amt,
    ttl_out_qty,
    ttl_rtn_tag,
    ttl_rtn_amt,
    ttl_rtn_qty,
    // 기본 판매율/할인율(증감 제외)
    sale_rate_amt: net_out_amt !== 0 ? sale_amt / net_out_amt : null,
    sale_rate_qty: net_out_qty !== 0 ? sale_qty / net_out_qty : null,
    sale_discount_rate: sale_tag !== 0 ? 1 - (sale_amt / sale_tag) : null,
    out_discount_rate: net_out_tag !== 0 ? 1 - (net_out_amt / net_out_tag) : null
  }
});

// exportData 가공
const exportData = baseRows.map((item, idx) => {
  const {
    row, sale_tag, sale_amt, sale_qty,
    net_out_tag, net_out_amt, net_out_qty,
    ttl_out_tag, ttl_out_amt, ttl_out_qty,
    ttl_rtn_tag, ttl_rtn_amt, ttl_rtn_qty,
    sale_rate_amt, sale_rate_qty,
    sale_discount_rate, out_discount_rate
  } = item;

  let final_sale_rate_amt = sale_rate_amt;
  let final_sale_rate_qty = sale_rate_qty;
  let final_sale_discount_rate = sale_discount_rate;
  let final_out_discount_rate = out_discount_rate;

  // 👉 3번째 아이템(증감대비) 처리
  if (idx === 2) {
    const prev1 = baseRows[0];
    const prev2 = baseRows[1];

    final_sale_rate_amt = (prev1.sale_rate_amt ?? 0) - (prev2.sale_rate_amt ?? 0);
    final_sale_rate_qty = (prev1.sale_rate_qty ?? 0) - (prev2.sale_rate_qty ?? 0);

    final_sale_discount_rate = (prev1.sale_discount_rate ?? 0) - (prev2.sale_discount_rate ?? 0);
    final_out_discount_rate = (prev1.out_discount_rate ?? 0) - (prev2.out_discount_rate ?? 0);
  }

  const newRow = {
    "": row.sale_unit || "",
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

  if (switch1.value === true) {
    newRow["기간 누적 출고량"] = ttl_out_qty || 0;
    newRow["기간 누적 반품량"] = ttl_rtn_qty || 0;
    newRow["기간 누적 출고금액(실판가)"] = ttl_out_amt || 0;
    newRow["기간 누적 반품금액(실판가)"] = ttl_rtn_amt || 0;
    newRow["기간 누적 출고금액(TAG)"] = ttl_out_tag || 0;
    newRow["기간 누적 반품금액(TAG)"] = ttl_rtn_tag || 0;
  }

  return newRow;
});

// 파일명 생성
const fileName = `이월 판매현황-${bizMultiSelect2.selectedLabel}-${brandMultiSelect2.selectedLabel}-${yearSelect2.selectedLabel}(${endDate.value}마감 기준)`

utils.exportData(exportData, fileName, "xlsx")

//  // 서브브랜드별 매출 현황 테이블 데이터를 엑셀 다운로드용으로 변환
//  // 금액 컬럼은 원단위로 변환 (백만원 * 1000000)
//  // salesBySubBrand.value를 소스 데이터로 사용
//  // 주의: salesBySubBrand은 target_sales가 없음

//  utils.changeLocale("ko")

//  const data = summaryData.value;

//  // 테이블 컬럼 순서에 맞춰 데이터 변환
//  const exportData = data.map(row => {
//    //금액 숫자 변환
//    const sale_tag = Number(row.sale_tag);
//    const sale_amt = Number(row.sale_amt);
//    const sale_qty = Number(row.sale_qty);
//    const net_out_tag = Number(row.net_out_tag);
//    const net_out_amt = Number(row.net_out_amt);
//    const net_out_qty = Number(row.net_out_qty);
//    const ttl_out_tag = Number(row.ttl_out_tag);
//    const ttl_out_amt = Number(row.ttl_out_amt);
//    const ttl_out_qty = Number(row.ttl_out_qty);
//    const ttl_rtn_tag = Number(row.ttl_rtn_tag);
//    const ttl_rtn_amt = Number(row.ttl_rtn_amt);
//    const ttl_rtn_qty = Number(row.ttl_rtn_qty);
//    // 판매율 계산
//    const sale_rate_amt = net_out_amt !== 0 ? (sale_amt / net_out_amt) : null
//    const sale_rate_qty = net_out_qty !== 0 ? (sale_qty / net_out_qty): null
//   // 할인율 계산
//    const sale_discount_rate = sale_tag !== 0 ? 1- (sale_amt / sale_tag): null
//    const out_discount_rate = net_out_tag !== 0 ? 1- (net_out_amt / net_out_tag): null
  
//    // 테이블 컬럼 순서대로 구성 (target_sales 관련 컬럼 제외)
//    const newRow = {
//      // 1. 서브브랜드
//      "": row.sale_unit || "",
//      "판매금액(TAG)": sale_tag || "",
//      "실판매금액": sale_amt || "",
//      "판매수량": sale_qty || "",
//      "판매율(금액)": sale_rate_amt || "",
//      "판매율(수량)": sale_rate_qty || "",
//      "순출고금액(TAG)": net_out_tag || "",
//      "순출고금액(실판가)": net_out_amt || "",
//      "순출고수량": net_out_qty || "",
//      "재고금액(TAG)": net_out_tag - sale_tag || "",
//      "재고금액(실판가)": net_out_amt - sale_amt || "",
//      "재고수량": net_out_qty - sale_qty || "",
//      "할인율(판매)": sale_discount_rate || "",
//      "할인율(출고)": out_discount_rate || "",
//    };

//    // 기간 누적 출고,반품 데이터
//    if (switch1.value === true) {
//        newRow["기간 누적 출고량"] = ttl_out_qty || 0,
//        newRow["기간 누적 반품량"] = ttl_rtn_qty || 0,
//        newRow["기간 누적 출고금액(실판가)"] = ttl_out_amt || 0,
//        newRow["기간 누적 반품금액(실판가)"] = ttl_rtn_amt || 0,
//        newRow["기간 누적 출고금액(TAG)"] = ttl_out_tag || 0,
//        newRow["기간 누적 반품금액(TAG)"] = ttl_rtn_tag || 0
//    }
  
//    return newRow;
//  });

//  // 파일명 생성
//  const fileName = `이월 판매현황-${bizMultiSelect2.selectedLabel}-${brandMultiSelect2.selectedLabel}-${yearSelect2.selectedLabel}(${endDate.value}마감 기준)`

//  // 엑셀 다운로드
//  utils.exportData(exportData, fileName, "xlsx")

