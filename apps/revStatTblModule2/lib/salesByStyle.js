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
const arrData = formatDataAsArray(data)

if ({{ styleTabContainer.currentViewKey }} === "season") {
  const keys = ["year_cd", "year_nm"]
  const groupedArr = groupBySum(arrData, ["time_unit", ...keys], sumKeys)
  const result = pivotData(groupedArr, keys, "time_unit", sumKeys)
  return result
} else if ({{ styleTabContainer.currentViewKey }} === "season_detail") {
  const keys = ["season_cd", "season_nm", "year_cd", "year_nm"]
  const groupedArr = groupBySum(arrData, ["time_unit", ...keys], sumKeys)
  const result = pivotData(groupedArr, keys, "time_unit", sumKeys)
  return result
} else if ({{ styleTabContainer.currentViewKey }} === "it") {
  const keys = ["it", "it_nm"]
  const groupedArr = groupBySum(arrData, ["time_unit", ...keys], sumKeys)
  const result = pivotData(groupedArr, keys, "time_unit", sumKeys)
  return result
} else if ({{ styleTabContainer.currentViewKey }} === "it_gb") {
  const keys = ["it", "it_nm", "it_gb", "it_gb_nm"]
  const groupedArr = groupBySum(arrData, ["time_unit", ...keys], sumKeys)
  const result = pivotData(groupedArr, keys, "time_unit", sumKeys)
  return result
} else if ({{ styleTabContainer.currentViewKey }} === "item") {
  const keys = ["it", "it_nm", "it_gb", "it_gb_nm", "item", "item_nm"]
  const groupedArr = groupBySum(arrData, ["time_unit", ...keys], sumKeys)
  const result = pivotData(groupedArr, keys, "time_unit", sumKeys)
  return result
}