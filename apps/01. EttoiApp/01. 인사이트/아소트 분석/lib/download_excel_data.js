const _data_raw = var_data_excel_formatted.value
const _size_col_header = ['3M', '6M', '12M', '18M', '2Y', '3Y', '4Y']

const _data = _data_raw.map(item => {
  return Object.values(item).reduce((acc, cur) => {
    acc.push(cur)
    return acc
  }, [])
})

const worksheet = XLSX.utils.aoa_to_sheet(_data)

const applyBackgroundColor = (ws, range) => {
  for(let R = range.s.r; R <= Math.min(range.s.r + 4, range.e.r); ++R) {
    for(let C = range.s.c; C <= range.e.c; ++C) {
      const cellAddress = XLSX.utils.encode_cell({r: R, c: C})
      if(!ws[cellAddress]) continue;

      ws[cellAddress].s = {
        fill: {
          patternType: "solid", // solid 패턴 타입 설정
          fgColor: { rgb: "FFFF00" }, // 배경색 설정 (노란색)
        },
        border: {
          top: { style: "thin", color: { rgb: "000000" } },
          bottom: { style: "thin", color: { rgb: "000000" } },
          left: { style: "thin", color: { rgb: "000000" } },
          right: { style: "thin", color: { rgb: "000000" } },
        },
        alignment: {
          horizontal: "center", // 중앙 정렬
          vertical: "center",
        },
      }
    }
  }
}

const mergeCells = (ws) => {
  // merges 정보 만들기
  if (!Array.isArray(ws["!merges"])) {
    ws["!merges"] = [];
  }

  // 각 열을 순환하면서 처리
  for (let col = 0; col < _data[0].length; col++) {

    if(!_size_col_header.includes(_data[0][col])) {
      ws["!merges"].push({
          s: { r: 0, c: col },
          e: { r: 5, c: col },
        })
    }
    
  }
}

const workbook = XLSX.utils.book_new()
const range = XLSX.utils.decode_range(worksheet['!ref'])

applyBackgroundColor(worksheet, range)
mergeCells(worksheet)

XLSX.utils.book_append_sheet(workbook, worksheet, "assort")
XLSX.writeFile(workbook, `assort_${moment().format('YYYY_MM_DD')}.xlsx`)

console.log(worksheet['!merges'], {
  bookType: 'xlsx',
  cellStyles: true
})

return workbook