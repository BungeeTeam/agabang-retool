function total(dataArray, sumKeys) {
  const sumKeySet = new Set(sumKeys);

  // 1. sumKeys에 해당하는 값들의 총합을 먼저 계산합니다.
  const sums = dataArray.reduce((acc, item) => {
    for (const key of sumKeys) {
      acc[key] = (acc[key] || 0) + (Number(item[key]) || 0);
    }
    return acc;
  }, {});

  const allKeys = new Set(dataArray.flatMap(item => Object.keys(item)));

  // 3. 최종 총계 객체를 만듭니다.
  const grandTotal = {};
  for (const key of allKeys) {
    if (sumKeySet.has(key)) {
      grandTotal[key] = sums[key];
    } else {
      grandTotal[key] = '총계';
    }
  }
  return grandTotal;
}


const data = {{ varSelectedRow.value?.category_name === '소계' ? groupByGrade.value.filter(i => 
  (tabs1.value === '합계'? 1===1 : i.onoff_flag === tabs1.value) &&
  i.item_grade === varSelectedRow.value.item_grade &&
  i.season_nm === varSelectedRow.value.season_nm)
  
  :varSelectedRow.value?.category_name === '총계' ? groupByShop.value.filter(i => 
  (tabs1.value === '합계'? 1===1 : i.onoff_flag === tabs1.value))
  
  : mergeCurOutSale.value.filter(i => 
  (tabs1.value === '합계' ? 1===1 : i.onoff_flag === tabs1.value) &&
  i.item_grade === varSelectedRow.value.item_grade &&
  i.season_nm === varSelectedRow.value.season_nm&&
  i.category_name === varSelectedRow.value.category_name) }}

  const sumKeys = ["sale_tag","sale_qty","sale_amt","net_out_qty","net_out_tag","net_out_amt","ttl_out_qty","ttl_rtn_qty","ttl_out_amt","ttl_rtn_amt","ttl_out_tag","ttl_rtn_tag"]


const ttl = total(data,sumKeys)

data.push(ttl)

return data.sort((a, b) => {
  // 1. '총계'를 맨 위로
  if (a.shop_nm === '총계') return -1;
  if (b.shop_nm === '총계') return 1;

  // 2. 금액 판매율 낮은 순
  return (a.sale_tag / a.net_out_tag) - (b.sale_tag / b.net_out_tag);
}); 