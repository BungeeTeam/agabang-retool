const data = {{ formatDataAsArray(periodicTargetSales.data).filter(i=> tabs1.value === '합계' ? true : i.onoff_flag===tabs1.value)  }}
const target = {{ formatDataAsArray(targetRate.data).filter(i=> tabs1.value === '합계' ? true : i.onoff_flag===tabs1.value)  }}

console.log(data)
console.log(target)


// 3. 기준값을 빠르게 찾기 위한 Map 생성
const targetMap = new Map();

data.forEach(item => {
  const key = `${item.biz_cd}|${item.year_unit}|${item.quarter_unit}|${item.month_unit}|${item.onoff_flag}`;
  targetMap.set(key, item.target_sales);
});

// 4. data에 target_rate 기반 target_sales 추가
const updatedData = target.map(item => {
  const key = `${item.biz_cd}|${item.year_unit}|${item.quarter_unit}|${item.month_unit}|${item.onoff_flag}`;
  const base_target_sales = targetMap.get(key);
  return {
    ...item,
target_sales: base_target_sales !== undefined && item.target_rate !== undefined
  ? Math.round(base_target_sales * item.target_rate)
  : 0
  };
});

console.log(updatedData)


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

const arr = updatedData
const groupKeys = ["biz_cd",                    "year_unit","quarter_unit","month_unit",
                   "sales_type", "season_nm"]
const sumKeys =["target_sales"]

const result = groupBySum(arr, groupKeys, sumKeys)
console.log(result.filter(i => i.target_sales >= 0))
return result//.filter(i => i.target_sales >= 0)