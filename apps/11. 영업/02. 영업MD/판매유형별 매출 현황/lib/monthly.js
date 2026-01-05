function transformSalesData(data, groupKeys, sumKeys) {
  const getKey = item => groupKeys.map(k => item[k]).join("|");

  const grouped = {};

  data.forEach(entry => {
    const key = getKey(entry);
    if (!grouped[key]) {
      grouped[key] = Object.fromEntries(groupKeys.map(k => [k, entry[k]]));
      sumKeys.forEach(k => {
        grouped[key][`cur_${k}`] = 0;
        grouped[key][`prev_${k}`] = 0;
      });
    }

    sumKeys.forEach(k => {
      const value = Number(entry[k]) || 0;
      // is_current_period 플래그를 사용하여 cur/prev 구분
      if (entry.is_current_period === 1) {
        grouped[key][`cur_${k}`] += value;
      } else if (entry.is_current_period === 0) {
        grouped[key][`prev_${k}`] += value;
      }
    });
  });

  return Object.values(grouped);
}

function mergeTargetSales(result, targets, mappingKeys) {
  const targetMap = new Map(
    targets.map(item => [
      mappingKeys.map(k => item[k]).join("|"),
      item.target_sales
    ])
  );

  result.forEach(item => {
    const key = mappingKeys.map(k => item[k]).join("|");
    if (targetMap.has(key)) {
      item.target_sales = targetMap.get(key);
    }
  });
}

function fillDefaultValues(targets, referenceKeys, defaultValues) {
  targets.forEach(item => {
    referenceKeys.forEach(k => {
      if (!(k in item)) item[k] = defaultValues[k];
    });
  });
}

function calculateSaleRates(result) {
  const monthlyTotals = {};

  result.forEach(item => {
    if (item.sales_type === '총계') {
      const month = item.month_unit;
      monthlyTotals[month] = {
        cur_rev: Number(item.cur_rev) || 0,
        prev_rev: Number(item.prev_rev) || 0
      };
    }
  });

  result.forEach(item => {
    const { cur_rev, prev_rev } = monthlyTotals[item.month_unit] || {};
    item.cur_sale_rate = cur_rev > 0 ? item.cur_rev / cur_rev : 0;
    item.prev_sale_rate = prev_rev > 0 ? item.prev_rev / prev_rev : 0;
  });
}

// === 실행 영역 ===

const data = {{ indexing.value }};
const sumKeys = ["rev", "tag", "cost"];
const groupKeys = ["year_unit", "quarter_unit", "month_unit", "season_cd", "season_nm", "sales_type","is_current_period"];
const groupedArr = groupBySum(data, groupKeys, sumKeys);

const analysisKeys = ["season_cd", "season_nm", "quarter_unit", "month_unit", "sales_type"];
const result = transformSalesData(groupedArr, analysisKeys, sumKeys);

const target_new = {{ targetSalesBySalesType.value }};
mergeTargetSales(result, target_new, ["season_nm", "month_unit", "quarter_unit", "sales_type"]);

const totalGroupKeys = ["sales_type", "quarter_unit", "month_unit"];
const totalSumKeys = [
  "target_sales", "cur_rev", "prev_rev",
  "cur_tag", "prev_tag", "cur_cost", "prev_cost"
];

const totalArr = groupBySum(result, totalGroupKeys, totalSumKeys);
fillDefaultValues(totalArr, Object.keys(groupedArr[0] || {}), {
  season_cd: "9",
  season_nm: "소계"
});
result.push(...totalArr);

const supply = {{ monthlySupply.value }};
result.push(...supply);

const finalTotals = groupBySum(
  result.filter(r => r.season_nm === "소계"),
  ["quarter_unit", "month_unit"],
  totalSumKeys
);

fillDefaultValues(finalTotals, ["sales_type", "season_cd", "season_nm"], {
  sales_type: "총계",
  season_cd: "999",
  season_nm: "총계"
});
result.push(...finalTotals);

calculateSaleRates(result);

// 정렬: sales_type 기준 내림차순 → season_cd 기준 오름차순
return result.sort((a, b) => {
  const typeCompare = b.sales_type.localeCompare(a.sales_type);
  return typeCompare !== 0 ? typeCompare : Number(a.season_cd) - Number(b.season_cd);
});