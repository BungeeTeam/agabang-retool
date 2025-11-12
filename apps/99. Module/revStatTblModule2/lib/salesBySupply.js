// 현재는 사용하지 않는 테이블

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

const data = {{ inputDataByStyle.value }}
let arrData = formatDataAsArray(data)

// Filter
arrData = arrData
  .filter(item => item.onoff_flag === "오프라인" && item.sales_type === "용품")

arrData = arrData.map(obj => {
  let supply = ""
  if (['01', '07', '79'].includes(obj.br_cd)) {
    supply = '브랜드용품'
  } else if (obj.br_cd === '71') {
    supply = '퓨토용품'
  } else if (obj.sub_br_nm === '스토케') {
    supply = '스토케'
  } else {
    supply = '공용용품'
  }
  return { ...obj, supply }
})

const sumKeys = ["rev"]
const groupKeys = ["first_lv_class", "supply"]
const groupedArr = groupBySum(arrData, ["time_unit", ...groupKeys], sumKeys)
const result = pivotData(groupedArr, groupKeys, "time_unit", sumKeys)

return result.sort((a, b) => a.supply.localeCompare(b.supply, "ko"))