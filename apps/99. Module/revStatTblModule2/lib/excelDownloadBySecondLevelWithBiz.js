// 상품 종목별 매출상세 테이블 데이터를 엑셀 다운로드용으로 변환
// 금액 컬럼은 원단위로 변환 (백만원 * 1000000)
// salesBySecondLevelWithBiz.value를 소스 데이터로 사용
// 동적 카테고리 컬럼 구조 처리

utils.changeLocale("ko")

const data = salesBySecondLevelWithBiz.value
const fileName = text66.value.slice(6)

// 카테고리 목록 (신장율이 아닌 실제 매출 컬럼들)
const categoryKeys = [
  "기초류", "외의류", "발육", "섬유공산품", "시즌용품", 
  "일반용품위탁", "하드류", "기타"
]

// 데이터 변환
const exportData = data.map(row => {
  const newRow = {
    // 1. 사업부
    "사업부": row.biz_nm || ""
  }
  
  // 2. 각 카테고리별 매출 (원단위로 변환)
  categoryKeys.forEach(category => {
    if (row[category] !== null && row[category] !== undefined) {
      newRow[category] = (Number(row[category]) || 0) * 1000000
    } else {
      newRow[category] = 0
    }
  })
  
  // 3. 각 카테고리별 신장율 (퍼센트, 소수점 1자리)
  categoryKeys.forEach(category => {
    const growthRateKey = `${category}신장율`
    if (row[growthRateKey] !== null && row[growthRateKey] !== undefined) {
      // 신장율은 이미 계산되어 있으므로 그대로 사용 (퍼센트 단위)
      newRow[growthRateKey] = Number(row[growthRateKey]) || null
    } else {
      newRow[growthRateKey] = null
    }
  })
  
  return newRow
})

// 엑셀 다운로드
utils.exportData(exportData, fileName, "xlsx")

