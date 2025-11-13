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


const sumKeys = ["st_count", "in_st_count", "out_st_count", 
                 "tot_in_qty", "tot_in_cost", "tot_in_tag",
                "tot_sale_qty","tot_sale_tag", "tot_sale_amt",
                 "month_sale_qty", "month_sale_tag", "month_sale_amt",
                 "p_week_sale_qty", "p_week_sale_tag", "p_week_sale_amt",
                 "week_sale_qty", "week_sale_tag", "week_sale_amt"
                ]
const groupKeys = ["year_nm", "year_cd","season_nm", "total","cat_group","apparel_group","large_cat","it", "middle_cat"]

const data = {{ salesByColor.data }}
let arrData = formatDataAsArray(data)

const groupedArr = groupBySum(arrData, groupKeys, sumKeys)

//  const groupedArr = groupBySum(arrData, groupKeys, sumKeys)


return groupedArr.sort((a, b) => {
  const yearDiff = b.year_nm - a.year_nm;
  if (yearDiff !== 0) return yearDiff;

  const first = a.large_cat.localeCompare(b.large_cat);
  if (first !== 0) return first;

  return a.middle_cat.localeCompare(b.middle_cat);
});