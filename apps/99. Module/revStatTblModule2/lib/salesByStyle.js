const sumKeys = ["rev"]
const data = {{ inputDataByStyle.value }}
let arrData = formatDataAsArray(data)
  .filter(item => item.onoff_flag === "오프라인")

arrData = arrData
  .filter(item => item.biz_cd === {{ selectedRow.value.biz_cd }})
  .filter(item => (item.it_nm != '') && (item.it_gb_nm != '') && (item.item_nm != ''))

const viewConfig = {
  season: {
    keys: ["year_cd", "year_nm"],
    sortFn: (a, b) => b.year_nm.replace('이하', '') - a.year_nm.replace('이하', ''),
  },
  season_detail: {
    keys: ["season_nm", "season_seq", "year_cd", "year_nm"],
    sortFn: (a, b) => b.year_nm.replace('이하', '') - a.year_nm.replace('이하', '') || a.season_seq - b.season_seq,
  },
  it: {
    keys: ["it", "it_nm"],
    sortFn: (a, b) => a.it_nm.localeCompare(b.it_nm, "ko"),
  },
  it_gb: {
    keys: ["it", "it_nm", "it_gb", "it_gb_nm"],
    sortFn: (a, b) => a.it_nm.localeCompare(b.it_nm, "ko") || a.it_gb_nm.localeCompare(b.it_gb_nm, "ko"),
  },
  item: {
    keys: ["it", "it_nm", "it_gb", "it_gb_nm", "item", "item_nm"],
    sortFn: (a, b) => a.it_nm.localeCompare(b.it_nm, "ko") ||  a.it_gb_nm.localeCompare(b.it_gb_nm, "ko") || a.item_nm.localeCompare(b.item_nm, "ko"),
  },
}

const currentKey = {{ styleTabContainer.currentViewKey }};
if (currentKey === "season_detail") {
  arrData = arrData.map(item => {
    let season_seq
    if (item.season_nm === "겨울") {
      season_seq = 0  
    } else if (item.season_nm === "가을") {
      season_seq = 1 
    } else if (item.season_nm === "여름") {
      season_seq = 2  
    } else if (item.season_nm === "봄") {
      season_seq = 3  
    } else if (item.season_nm === "사계절") {
      season_seq = 4  
    }
    item.season_seq = season_seq
    return item
  })
}

const currentYear = new Date().getFullYear().toString();
if (viewConfig[currentKey]) {
  const { keys, sortFn } = viewConfig[currentKey];
  const groupedArr = groupBySum(arrData, ["time_unit", ...keys], sumKeys);
  let result = pivotData(groupedArr, keys, "time_unit", sumKeys);
result = result.filter(obj => obj.hasOwnProperty(currentYear) && obj[currentYear] > 0)
  return result.sort(sortFn);
}