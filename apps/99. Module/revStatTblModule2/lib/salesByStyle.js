function groupBySum(arr, groupKeys, sumKeys) {
  return Object.values(
    arr.reduce((acc, item) => {
      const key = groupKeys.map(k => item[k]).join("-");

      if (!acc[key]) {
        acc[key] = Object.fromEntries(groupKeys.map(k => [k, item[k]]));
        sumKeys.forEach(sumKey => {
          acc[key][sumKey] = Number(item[sumKey]) || 0;
        });
      } else {
        sumKeys.forEach(sumKey => {
          acc[key][sumKey] += Number(item[sumKey]) || 0;
        });
      }
      return acc;
    }, {})
  );
}

function pivotData(data, groupKeys, pivotKey, sumKeys) {
  const pivotMap = {};

  data.forEach(item => {
    // Create a unique key based on selected group keys
    const groupKey = groupKeys.map(k => item[k]).join("-");

    if (!pivotMap[groupKey]) {
      // Initialize object with only group keys
      pivotMap[groupKey] = Object.fromEntries(groupKeys.map(k => [k, item[k]]));
    }

    // Ensure numeric fields exist and sum them
    sumKeys.forEach(sumKey => {
      pivotMap[groupKey][item[pivotKey]] = 
        (pivotMap[groupKey][item[pivotKey]] || 0) + Number(item[sumKey] || 0);
    });
  });

  return Object.values(pivotMap);
}

const sumKeys = ["rev"]
const data = {{ inputDataByStyle.value }}
let arrData = formatDataAsArray(data)

arrData = arrData.filter(item => item.biz_cd === {{ selectedRow.value.biz_cd }})

const viewConfig = {
  season: {
    keys: ["sales_type", "year_cd", "year_nm"],
    sortFn: (a, b) => b.year_nm - a.year_nm,
  },
  season_detail: {
    keys: ["season_nm", "season_seq", "year_cd", "year_nm"],
    sortFn: (a, b) => b.year_nm - a.year_nm || a.season_seq - b.season_seq,
  },
  it: {
    keys: ["it", "it_nm"],
    sortFn: (a, b) => a.it_nm.localeCompare(b.it_nm, "ko"),
  },
  it_gb: {
    keys: ["it", "it_nm", "it_gb", "it_gb_nm"],
    sortFn: (a, b) => a.it_nm.localeCompare(b.it_nm, "ko") && a.it_gb_nm.localeCompare(b.it_gb_nm, "ko"),
  },
  item: {
    keys: ["it", "it_nm", "it_gb", "it_gb_nm", "item", "item_nm"],
    sortFn: (a, b) => a.it_nm.localeCompare(b.it_nm, "ko") && a.it_gb_nm.localeCompare(b.it_gb_nm, "ko") && a.item_nm.localeCompare(b.item_nm, "ko"),
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

if (viewConfig[currentKey]) {
  const { keys, sortFn } = viewConfig[currentKey];
  const groupedArr = groupBySum(arrData, ["time_unit", ...keys], sumKeys);
  const result = pivotData(groupedArr, keys, "time_unit", sumKeys);
  return result.sort(sortFn);
}