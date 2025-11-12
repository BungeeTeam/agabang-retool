// 매장판매구분별 매출 현황 테이블 데이터를 엑셀 다운로드용으로 변환
// 금액 컬럼은 원단위로 변환 (백만원 * 1000000)
// salesByGb.value를 소스 데이터로 사용
// 주의: salesByGb은 target_sales가 없음

utils.changeLocale("ko")

const data = salesByGb.value
const currentYear = thisYear.value
const lastYear = currentYear - 1
const yearBeforeLast = currentYear - 2

// 테이블 컬럼 순서에 맞춰 데이터 변환
const exportData = data.map(row => {
  // 금액 값 계산 (원단위로 변환)
  const currentRev = (Number(row[currentYear]) || 0) * 1000000
  const lastYearRev = (Number(row[lastYear]) || 0) * 1000000
  const yearBeforeLastRev = (Number(row[yearBeforeLast]) || 0) * 1000000
  
  // 신장율 계산
  const lastYearGrowthRate = lastYearRev !== 0 ? (currentRev / lastYearRev) - 1 : null
  const yearBeforeLastGrowthRate = yearBeforeLastRev !== 0 ? (currentRev / yearBeforeLastRev) - 1 : null
  
  // 테이블 컬럼 순서대로 구성 (target_sales 관련 컬럼 제외)
  const newRow = {
    // 1. 매장판매구분
    "매장판매구분": row.sale_gb || "",
    
    // 2. 현재 연도 실적 (원단위)
    [`${currentYear.toString().slice(2)}실적`]: currentRev,
    
    // 3. 전년도 실적 (원단위)
    [`${lastYear.toString().slice(2)}실적`]: lastYearRev,
    
    // 4. 전년 대비 신장율 (퍼센트, 소수점 1자리)
    [`${lastYear.toString().slice(2)}대비신장율`]: lastYearGrowthRate !== null ? lastYearGrowthRate : null,
    
    // 5. 전년 대비 신장액 (원단위)
    [`${lastYear.toString().slice(2)}대비신장액`]: currentRev - lastYearRev,
    
    // 6. 2년 전 실적 (원단위)
    [`${yearBeforeLast.toString().slice(2)}실적`]: yearBeforeLastRev,
    
    // 7. 2년 전 대비 신장율 (퍼센트, 소수점 1자리)
    [`${yearBeforeLast.toString().slice(2)}대비신장율`]: yearBeforeLastGrowthRate !== null ? yearBeforeLastGrowthRate : null,
    
    // 8. 2년 전 대비 신장액 (원단위)
    [`${yearBeforeLast.toString().slice(2)}대비신장액`]: currentRev - yearBeforeLastRev
  }
  
  return newRow
})

// 파일명 생성
const fileName = `판매형태별 매출 현황`

// 엑셀 다운로드
utils.exportData(exportData, fileName, "xlsx")

