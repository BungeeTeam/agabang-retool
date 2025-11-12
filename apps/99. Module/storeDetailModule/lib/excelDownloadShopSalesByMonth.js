// 매장별 월별 매출 현황 테이블 데이터를 엑셀 다운로드용으로 변환
// 금액 컬럼은 원단위로 변환 (천원 * 1000)
// shopSalesByMonth.value를 소스 데이터로 사용

utils.changeLocale("ko")

const data = shopSalesByMonth.value
const currentYear = moment(startDate.value).year()

// 월별 컬럼 키 목록
const monthKeys = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec']
const monthLabels = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']

// 퍼센트 지표 구분 (이 값들은 원단위 변환하지 않음)
const percentMetrics = ['목표달성율', '원가율']

// 테이블 컬럼 순서에 맞춰 데이터 변환
const exportData = data.map(row => {
  const newRow = {}
  
  // 1. 구분 컬럼
  newRow['구분'] = row['구분'] || ""
  
  // 2. 합계 컬럼 (금액 또는 퍼센트)
  const isPercentRow = percentMetrics.some(metric => row['구분'] && row['구분'].includes(metric))
  
  if (isPercentRow) {
    // 퍼센트 지표는 그대로 유지 (0~1 사이 값)
    newRow['합계'] = row['total'] !== null && row['total'] !== undefined ? row['total'] : null
  } else {
    // 금액 지표는 원단위로 변환 (천원 * 1000)
    newRow['합계'] = row['total'] !== null && row['total'] !== undefined 
      ? (Number(row['total']) || 0) 
      : null
  }
  
  // 3. 월별 컬럼들 (1월~12월)
  monthKeys.forEach((monthKey, index) => {
    if (isPercentRow) {
      // 퍼센트 지표는 그대로 유지
      newRow[monthLabels[index]] = row[monthKey] !== null && row[monthKey] !== undefined 
        ? row[monthKey] 
        : null
    } else {
      // 금액 지표는 원단위로 변환 (천원 * 1000)
      newRow[monthLabels[index]] = row[monthKey] !== null && row[monthKey] !== undefined 
        ? (Number(row[monthKey]) || 0) 
        : null
    }
  })
  
  return newRow
})

// 파일명 생성
const fileName = `${head.value.slice(4)} 월별 매출 현황(${moment().format('YYYY-MM-DD')})`

// 엑셀 다운로드
utils.exportData(exportData, fileName, "xlsx")

