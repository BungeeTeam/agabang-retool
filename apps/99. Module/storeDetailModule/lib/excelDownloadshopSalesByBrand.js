// 매장별 브랜드별 매출 현황 테이블 데이터를 엑셀 다운로드용으로 변환
// 금액 컬럼은 원단위로 변환 (천원 * 1000)
// shopSalesByBrandQuery.data를 소스 데이터로 사용
// 동적 카테고리 컬럼 구조 처리

utils.changeLocale("ko")

const data = shopSalesByBrandQuery.data

// 카테고리 목록 (동적 컬럼)
const categoryKeys = [
  "기초류", "외의류", "시즌용품", "일반용품위탁", "섬유공산품", 
  "하드류", "발육", "화장품", "기타"
]

// 컬럼 순서 정의 (테이블 컬럼 순서와 동일)
const columnOrder = [
  "연도",
  "정상구분",
  ...categoryKeys,
  "비중",
  "total"
]

// 테이블 컬럼 순서에 맞춰 데이터 변환
const exportData = data.map(row => {
  const newRow = {}
  
  // 1. 연도
  newRow["연도"] = row["연도"] || ""
  
  // 2. 정상구분
  newRow["정상구분"] = row["정상구분"] || ""
  
  
  // 4. 카테고리별 매출 (원단위로 변환: 천원 * 1000)
  categoryKeys.forEach(category => {
    if (row[category] !== null && row[category] !== undefined) {
      newRow[category] = (Number(row[category]) || 0) * 1000
    } else {
      newRow[category] = null
    }
  })
  // 3. 비중 (퍼센트 값, 그대로 유지)
  newRow["비중"] = row["ratio"] !== null && row["ratio"] !== undefined ? row["ratio"] : null
  
  // 5. 총합 (원단위로 변환: 천원 * 1000)
  newRow["total"] = row["total"] !== null && row["total"] !== undefined 
    ? (Number(row["total"]) || 0) * 1000 
    : null
  
  // 컬럼 순서 보장을 위해 재정렬
  const orderedRow = {}
  columnOrder.forEach(columnName => {
    orderedRow[columnName] = newRow[columnName]
  })
  
  return orderedRow
})

// 파일명 생성 (원래 형식 유지)
const fileName = `[${head.value.slice(4)}] ${text18.value.slice(7)} (마감 일자:${endDate.value})`

// 엑셀 다운로드
utils.exportData(exportData, fileName, "xlsx")

