// Reference external variables with curly brackets or using JS variables

const data = {{ getSalesData.value }}

const updatedArrData = data.map(obj => {
  // sales_type이 '용품'일 때만 season_nm과 season_cd 설정
  if (obj.sales_type === '용품') {
    let season_cd = ""; // 순서 고정용
    let season_nm = "";

    if (['01','02', '07', '79'].includes(obj.br_cd)) {
      season_nm = '브랜드용품';
      season_cd = '0';
    } else if (obj.br_cd === '71') {
      season_nm = '퓨토용품';
      season_cd = '3';
    } else if (obj.sub_br_nm === '스토케') {
      season_nm = '스토케';
      season_cd = '2';
    } else if (['57', '58', '59','72'].includes(obj.br_cd)) {
      season_nm = '온라인';
      season_cd = '4';
    } else {
      season_nm = '공용용품';
      season_cd = '1';
    }

    return { ...obj, season_nm, season_cd };
  }
  return obj;
});


const sumKeys = ["curr_qty", "curr_tag", "curr_amt", "curr_cost", "prev_qty", "prev_tag", "prev_amt", "prev_cost"];

const keysToGroup = ["sales_type", 
                     "season_cd" , "season_nm",
                    "quarter_unit"];

const allGroups = groupBySum(updatedArrData, keysToGroup, sumKeys);


function subTotals(dataArray, groupKeys, sumKeys) {
  const allKeys = new Set(dataArray.flatMap(item => Object.keys(item)));
  const groupKeySet = new Set(groupKeys);
  const sumKeySet = new Set(sumKeys);

  const grouped = dataArray.reduce((acc, item) => {
    const key = groupKeys.map(k => item[k]).join('-');
    if (!acc[key]) {
      const subtotal = {
        ...Object.fromEntries(groupKeys.map(k => [k, item[k]])),
        ...Object.fromEntries(sumKeys.map(k => [k, 0]))
      };
      acc[key] = { items: [], subtotal };
    }
    acc[key].items.push(item);
    sumKeys.forEach(sumKey => {
      acc[key].subtotal[sumKey] += Number(item[sumKey]) || 0;
    });
    return acc;
  }, {});

  return Object.values(grouped).flatMap(group => {
    const subtotalRow = group.subtotal;

    for (const key of allKeys) {
      // 그룹 키도 아니고 합산 키도 아닌 경우에만 '소계'를 할당합니다.
      if (!groupKeySet.has(key) && !sumKeySet.has(key)) {
        subtotalRow[key] = '소계';
      }
    }
    return [...group.items, subtotalRow];
  });
}

function total(dataArray, groupKeys, sumKeys) {
  const allKeys = new Set(dataArray.flatMap(item => Object.keys(item)));
  const groupKeySet = new Set(groupKeys);
  const sumKeySet = new Set(sumKeys);

  const grouped = dataArray.reduce((acc, item) => {
    const key = groupKeys.map(k => item[k]).join('-');
    if (!acc[key]) {
      const subtotal = {
        ...Object.fromEntries(groupKeys.map(k => [k, item[k]])),
        ...Object.fromEntries(sumKeys.map(k => [k, 0]))
      };
      acc[key] = { items: [], subtotal };
    }
    acc[key].items.push(item);
    sumKeys.forEach(sumKey => {
      acc[key].subtotal[sumKey] += Number(item[sumKey]) || 0;
    });
    return acc;
  }, {});

  return Object.values(grouped).flatMap(group => {
    const subtotalRow = group.subtotal;

    for (const key of allKeys) {
      if (!groupKeySet.has(key) && !sumKeySet.has(key)) {
        subtotalRow[key] = '총계';
      }
    }
    return [subtotalRow];
  });
}


const subTotalKeys = ['sales_type',"quarter_unit"]

const TotalKeys = ['quarter_unit']


const subTotal = subTotals(allGroups, subTotalKeys, sumKeys);
const grandTotal = total(allGroups,TotalKeys,sumKeys)

const result = [...subTotal,...grandTotal]

return result.sort((a, b) => {
 // 1차: sales_type 기준 (문자열 오름차순)
 const typeCompare = b.sales_type.localeCompare(a.sales_type);
 if (typeCompare !== 0) return typeCompare;

 // 2차: season_cd 기준 (숫자 내림차순)
 return Number(a.season_cd) - Number(b.season_cd);
});