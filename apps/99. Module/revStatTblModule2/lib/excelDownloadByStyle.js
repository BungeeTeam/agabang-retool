// 스타일별 매출 현황 테이블 데이터를 엑셀 다운로드용으로 변환
// 금액 컬럼은 원단위로 변환 (백만원 * 1000000)
// salesByStyle.value를 소스 데이터로 사용
// 동적 구조: viewKey에 따라 컬럼 구조가 다름 (season, season_detail, it, it_gb, item)

utils.changeLocale("ko")

const data = salesByStyle.value
const currentYear = thisYear.value
const lastYear = currentYear - 1
const viewKey = styleTabContainer.currentViewKey

// viewKey에 따른 컬럼 매핑
const columnMapping = {
  season: {
    labelKey: "year_nm",
    labelName: "시즌"
  },
  season_detail: {
    labelKey: "season_nm",
    labelName: "시즌계절",
    additionalKeys: [
      { key: "year_nm", name: "시즌연도" }
    ]
  },
  it: {
    labelKey: "it_nm",
    labelName: "IT명"
  },
  it_gb: {
    labelKey: "it_nm",
    labelName: "IT명",
    additionalKeys: [
      { key: "it_gb_nm", name: "ITGB명" }
    ]
  },
  item: {
    labelKey: "it_nm",
    labelName: "IT명",
    additionalKeys: [
      { key: "it_gb_nm", name: "ITGB명" },
      { key: "item_nm", name: "아이템명" }
    ]
  }
}

const mapping = columnMapping[viewKey] || columnMapping.season

// 테이블 컬럼 순서에 맞춰 데이터 변환
const exportData = data.map(row => {
  // 금액 값 계산 (원단위로 변환)
  const currentRev = (Number(row[currentYear]) || 0) * 1000000
  const lastYearRev = (Number(row[lastYear]) || 0) * 1000000
  
  // 신장율 계산
  const lastYearGrowthRate = lastYearRev !== 0 ? (currentRev / lastYearRev) - 1 : null
  
  // 기본 컬럼 구성
  const newRow = {
    // 1. 첫 번째 라벨 컬럼
    [mapping.labelName]: row[mapping.labelKey] || ""
  }
  
  // 2. 추가 컬럼들 (있는 경우)
  if (mapping.additionalKeys) {
    mapping.additionalKeys.forEach(({ key, name }) => {
      newRow[name] = row[key] || ""
    })
  }
  
  // 3. 현재 연도 실적 (원단위)
  newRow[`${currentYear.toString().slice(2)}실적`] = currentRev
  
  // 4. 전년도 실적 (원단위)
  newRow[`${lastYear.toString().slice(2)}실적`] = lastYearRev
  
  // 5. 전년 대비 신장율 (퍼센트, 소수점 1자리)
  newRow[`${lastYear.toString().slice(2)}대비신장율`] = lastYearGrowthRate !== null ? lastYearGrowthRate : null
  
  return newRow
})

// 파일명 생성
const fileName = `${tabs3.selectedLabel} 매출 현황(${moment().format('YYYY-MM-DD')})`

// 엑셀 다운로드
utils.exportData(exportData, fileName, "xlsx")

