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

function createTotalRow(data, groupKeys, sumKeys, label = "총계") {
  const totalRow = Object.fromEntries(groupKeys.map(k => [k, label]));
  sumKeys.forEach(sumKey => {
    totalRow[sumKey] = data.reduce((sum, item) => sum + (Number(item[sumKey]) || 0), 0);
  });
  return totalRow;
}


const sumKeys = ["rev_01","rev_02","rev_03","curr_open","prev_open","new_opened","opened","new_closed","closed"]
const groupKeys = ["tp_cd", "tp_nm"]
const data = {{ getShopStat.data }}

const groupedArr = groupBySum(data, groupKeys, sumKeys)

const totalRow = createTotalRow(groupedArr, groupKeys, sumKeys);

groupedArr.unshift(totalRow);

return groupedArr