function createTotalRow(data, groupKeys, sumKeys, label = "") {
  const totalRow = Object.fromEntries(groupKeys.map(k => [k, label]));
  sumKeys.forEach(sumKey => {
    totalRow[sumKey] = data.reduce((sum, item) => sum + (Number(item[sumKey]) || 0), 0);
  });
  return totalRow;
}


const sumKeys = ["rev_01","rev_02","rev_03"]
const groupKeys = ["shop_cd", "shop_nm", "open_dt", "close_dt" , "stat"]
const data = {{ tabs4.value === '전체' ? getShopStat.data : getShopStat.data.filter(i=>i.stat ===tabs4.value) }}

const result = {{ varSelectedChannel.value }} === null ? data : data.filter( i => i.tp_nm === {{ varSelectedChannel.value?.tp_nm }})


const totalRow = createTotalRow(result, groupKeys, sumKeys);

result.unshift(totalRow);

return result

