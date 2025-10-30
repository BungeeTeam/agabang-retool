// 월별 테이블 데이터를 엑셀 다운로드용으로 변환
// 금액 컬럼은 원단위로, 퍼센트 컬럼은 퍼센트로 변환

utils.changeLocale("ko")

const data = monthly.value
const headers = tableHeader.value

// 1월부터 12월 순서로 정렬
const sortedData = [...data].sort((a, b) => {
  // month_unit 기준 오름차순
  const monthCompare = a.month_unit - b.month_unit
  if (monthCompare !== 0) return monthCompare
  
  // 같은 월 내에서는 sales_type 내림차순 -> season_cd 오름차순
  const typeCompare = b.sales_type.localeCompare(a.sales_type)
  return typeCompare !== 0 ? typeCompare : Number(a.season_cd) - Number(b.season_cd)
})

// 데이터 변환
const exportData = sortedData.map(row => {
  const newRow = {}
  
  // 월 컬럼 (맨 앞)
  newRow["월"] = row.month_unit ? `${row.month_unit}` : ''
  
  // 기본 컬럼
  newRow["정상/이월"] = row.sales_type || ''
  newRow["시즌"] = row.season_nm || ''
  
  // 동적 헤더를 사용하여 컬럼 매핑
  // checkboxTreeNew1.value에 포함된 컬럼만 내보내기
  const selectedColumns = checkboxTreeNew1.value
 
  // 올해 매출 (headers[2])
  if (selectedColumns.includes(headers[2])) {
    newRow[headers[2]] = row.cur_rev || 0
  }
  
  // 목표매출 (headers[1])
  if (selectedColumns.includes(headers[1])) {
    newRow[headers[1]] = row.target_sales || 0
  }
  
  // 진행율 (headers[7])
  if (selectedColumns.includes(headers[7])) {
    newRow[headers[7]] = row.target_sales ? row.cur_rev / row.target_sales : 0
  }
  
  // 올해 매출비중 (headers[16])
  if (selectedColumns.includes(headers[16])) {
    newRow[headers[16]] = row.cur_sale_rate || 0
  }
  
  // 올해 할인율 (headers[3])
  if (selectedColumns.includes(headers[3])) {
    newRow[headers[3]] = row.cur_tag ? (1 - row.cur_rev / row.cur_tag) : 0
  }
  
  // 작년 매출 (headers[4])
  if (selectedColumns.includes(headers[4])) {
    newRow[headers[4]] = row.prev_rev || 0
  }
  
  // 작년 매출비중 (headers[17])
  if (selectedColumns.includes(headers[17])) {
    newRow[headers[17]] = row.prev_sale_rate || 0
  }
  
  // 작년 할인율 (headers[5])
  if (selectedColumns.includes(headers[5])) {
    newRow[headers[5]] = row.prev_tag ? (1 - row.prev_rev / row.prev_tag) : 0
  }
  
  // 매출증감 (headers[6])
  if (selectedColumns.includes(headers[6])) {
    newRow[headers[6]] = (row.cur_rev || 0) - (row.prev_rev || 0)
  }
  
  // 신장율 (headers[8])
  if (selectedColumns.includes(headers[8])) {
    newRow[headers[8]] = row.prev_rev === 0 ? 0 : (row.cur_rev / row.prev_rev) - 1
  }
  
  // 올해 원가 (headers[10])
  if (selectedColumns.includes(headers[10])) {
    newRow[headers[10]] = row.cur_cost || 0
  }
  
  // 올해 원가율 (headers[11])
  if (selectedColumns.includes(headers[11])) {
    newRow[headers[11]] = row.cur_tag ? row.cur_cost / row.cur_tag : 0
  }
  
  // 작년 원가 (headers[12])
  if (selectedColumns.includes(headers[12])) {
    newRow[headers[12]] = row.prev_cost || 0
  }
  
  // 작년 원가율 (headers[13])
  if (selectedColumns.includes(headers[13])) {
    newRow[headers[13]] = row.prev_tag ? row.prev_cost / row.prev_tag : 0
  }
  
  // 원가증감 (headers[14])
  if (selectedColumns.includes(headers[14])) {
    newRow[headers[14]] = (row.cur_cost || 0) - (row.prev_cost || 0)
  }
  
  // 원가율증감 (headers[15])
  if (selectedColumns.includes(headers[15])) {
    const curCostRate = row.cur_tag ? row.cur_cost / row.cur_tag : 0
    const prevCostRate = row.prev_tag ? row.prev_cost / row.prev_tag : 0
    newRow[headers[15]] = curCostRate - prevCostRate
  }
  
  return newRow
})

// 파일명 생성
const fileName = `(${dateRange.value.end} 마감) 월별 정상_이월 판매데이터`

// 엑셀 다운로드
utils.exportData(exportData, fileName, "xlsx")

