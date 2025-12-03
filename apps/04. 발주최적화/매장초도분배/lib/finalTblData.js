const selectedData = {{ shopPlan.value }}
const groupKeys = ["shop_cd", "shop_nm", "sty_cd", "col_cd", "sales_qty", "related_info"]
const allSizes = [...new Set(selectedData.map(item => item.size_cd).filter(Boolean))].sort() // 모든 사이즈 표시

const pivottedData = pivotData(selectedData, groupKeys, "size_cd", ["plan_qty"])
const normalizedData = pivottedData.map(row => {
  const newRow = { ...row }
  allSizes.forEach(size => {
    if (!(size in newRow)) {
      newRow[size] = 0
    }
  })
  //  newRow.idx = `${newRow.shop_cd}${newRow.sty_cd}${newRow.col_cd}`
  return newRow
})
return normalizedData.sort((a, b) => b?.sales_qty || 0 - a?.sales_qty || 0

