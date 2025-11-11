// group by 후 합계 계산
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

// shop count를 계산하는 함수
function addShopCounts(arr, groupedData, groupKeys) {
  // tp_cd별로 shop_cd를 추적하기 위한 맵
  const shopTracking = {};
  
  // 원본 데이터를 순회하면서 tp_cd별 shop_cd 수집
  arr.forEach(item => {
    const key = groupKeys.map(k => item[k]).join("-");
    
    if (!shopTracking[key]) {
      shopTracking[key] = {
        shopsWithOut: new Set(),
        shopsWithSale: new Set(),
        shopsWithOut_ly: new Set(),
        shopsWithSale_ly: new Set()
      };
    }
    
    // out_qty가 0보다 큰 경우 shop_cd 추가
    if (Number(item.out_qty) > 0 && item.shop_cd) {
      shopTracking[key].shopsWithOut.add(item.shop_cd);
    }
    
    // sale_qty가 0보다 큰 경우 shop_cd 추가
    if (Number(item.sale_qty) > 0 && item.shop_cd) {
      shopTracking[key].shopsWithSale.add(item.shop_cd);
    }
    
    // out_qty_ly가 0보다 큰 경우 shop_cd 추가
    if (Number(item.out_qty_ly) > 0 && item.shop_cd) {
      shopTracking[key].shopsWithOut_ly.add(item.shop_cd);
    }
    
    // sale_qty_ly가 0보다 큰 경우 shop_cd 추가
    if (Number(item.sale_qty_ly) > 0 && item.shop_cd) {
      shopTracking[key].shopsWithSale_ly.add(item.shop_cd);
    }
  });

  // groupedData에 shop count 추가
  return groupedData.map(group => {
    const key = groupKeys.map(k => group[k]).join("-");
    const tracking = shopTracking[key];
    
    return {
      ...group,
      shop_out_count: tracking ? tracking.shopsWithOut.size : 0,
      shop_sale_count: tracking ? tracking.shopsWithSale.size : 0,
      shop_out_count_ly: tracking ? tracking.shopsWithOut_ly.size : 0,
      shop_sale_count_ly: tracking ? tracking.shopsWithSale_ly.size : 0
    };
  });
}

// 판매율을 계산하는 함수
function addSaleRates(data) {
  return data.map(item => {
    // 현재년도 판매율 계산
    const sale_qty_rate = item.out_qty > 0 
      ? (item.sale_qty / item.out_qty) 
      : 0;
    
    const sale_tag_rate = item.out_tag > 0 
      ? (item.sale_tag / item.out_tag) 
      : 0;
    
    const sale_amt_rate = item.out_tag > 0 
      ? (item.sale_amt / item.out_tag) 
      : 0;

    const sale_tag_rate_tag = item.out_tag > 0 
      ? (item.sale_tag / item.out_tag) 
      : 0;

    // 전년도 판매율 계산
    const sale_qty_rate_ly = item.out_qty_ly > 0 
      ? (item.sale_qty_ly / item.out_qty_ly) 
      : 0;
    
    const sale_tag_rate_ly = item.out_tag_ly > 0 
      ? (item.sale_tag_ly / item.out_tag_ly) 
      : 0;
    
    const sale_amt_rate_ly = item.out_tag_ly > 0 
      ? (item.sale_amt_ly / item.out_tag_ly) 
      : 0;

    const sale_tag_rate_tag_ly = item.out_tag_ly > 0 
      ? (item.sale_tag_ly / item.out_tag_ly) 
      : 0;
    
    return {
      ...item,
      sale_qty_rate: sale_qty_rate,
      sale_tag_rate: sale_tag_rate,
      sale_amt_rate: sale_amt_rate,
      sale_tag_rate_tag: sale_tag_rate_tag,
      sale_qty_rate_ly: sale_qty_rate_ly,
      sale_tag_rate_ly: sale_tag_rate_ly,
      sale_amt_rate_ly: sale_amt_rate_ly,
      sale_tag_rate_tag_ly: sale_tag_rate_tag_ly
    };
  });
}

// 전년대비 증감률과 증감량을 계산하는 함수
function addYoYGrowth(data) {
  return data.map(item => {
    // 출고매장수 증감
    const shop_out_count_diff = item.shop_out_count - item.shop_out_count_ly;  // 증감량
    const shop_out_count_growth = item.shop_out_count_ly > 0 
      ? ((item.shop_out_count - item.shop_out_count_ly) / item.shop_out_count_ly)
      : 0;  // 증감률(%)

    // 판매매장수 증감
    const shop_sale_count_diff = item.shop_sale_count - item.shop_sale_count_ly;  // 증감량
    const shop_sale_count_growth = item.shop_sale_count_ly > 0 
      ? ((item.shop_sale_count - item.shop_sale_count_ly) / item.shop_sale_count_ly)
      : 0;  // 증감률(%)
    
    // 입고수량 증감
    const out_qty_diff = item.out_qty - item.out_qty_ly;  // 증감량
    const out_qty_growth = item.out_qty_ly > 0 
      ? ((item.out_qty - item.out_qty_ly) / item.out_qty_ly)
      : 0;  // 증감률(%)
    
    // 입고금액 증감
    const out_amt_diff = item.out_amt - item.out_amt_ly;  // 증감량
    const out_amt_growth = item.out_amt_ly > 0 
      ? ((item.out_amt - item.out_amt_ly) / item.out_amt_ly)
      : 0;  // 증감률(%)

    // 정가 기준 입고금액 증감
    const out_tag_diff = item.out_tag - item.out_tag_ly;  // 증감량
    const out_tag_growth = item.out_tag_ly > 0 
      ? ((item.out_tag - item.out_tag_ly) / item.out_tag_ly)
      : 0;  // 증감률(%)
    
    // 판매수량 증감
    const sale_qty_diff = item.sale_qty - item.sale_qty_ly;  // 증감량
    const sale_qty_growth = item.sale_qty_ly > 0 
      ? ((item.sale_qty - item.sale_qty_ly) / item.sale_qty_ly)
      : 0;  // 증감률(%)
    
    // TAG 판매금액 증감
    const sale_tag_diff = item.sale_tag - item.sale_tag_ly;  // 증감량
    const sale_tag_growth = item.sale_tag_ly > 0 
      ? ((item.sale_tag - item.sale_tag_ly) / item.sale_tag_ly)
      : 0;  // 증감률(%)
    
    // 실판매금액 증감
    const sale_amt_diff = item.sale_amt - item.sale_amt_ly;  // 증감량
    const sale_amt_growth = item.sale_amt_ly > 0 
      ? ((item.sale_amt - item.sale_amt_ly) / item.sale_amt_ly)
      : 0;  // 증감률(%)
    
    return {
      ...item,
      // 매장수 증감량 및 증감률
      shop_out_count_diff: shop_out_count_diff,
      shop_out_count_growth: shop_out_count_growth,
      shop_sale_count_diff: shop_sale_count_diff,
      shop_sale_count_growth: shop_sale_count_growth,
      // 증감량 (차이)
      out_qty_diff: out_qty_diff,
      out_amt_diff: out_amt_diff,
      out_tag_diff: out_tag_diff,
      sale_qty_diff: sale_qty_diff,
      sale_tag_diff: sale_tag_diff,
      sale_amt_diff: sale_amt_diff,
      // 증감률 (%)
      out_qty_growth: out_qty_growth,
      out_amt_growth: out_amt_growth,
      out_tag_growth: out_tag_growth,
      sale_qty_growth: sale_qty_growth,
      sale_tag_growth: sale_tag_growth,
      sale_amt_growth: sale_amt_growth
    };
  });
}

// 소계 row를 추가하는 함수
function addSubtotalRow(data, sumKeys, arrData) {
  // 소계 계산
  const subtotal = {
    shop_cd: '소계',
    shop_nm: '소계',
    tp_nm: '소계'
  };
  
  // 합계 필드들 계산
  sumKeys.forEach(key => {
    subtotal[key] = data.reduce((sum, item) => sum + (item[key] || 0), 0);
  });
  
  // 전체 unique shop count 계산 (원본 데이터 사용)
  if (arrData) {
    const allShopsWithOut = new Set();
    const allShopsWithSale = new Set();
    const allShopsWithOut_ly = new Set();
    const allShopsWithSale_ly = new Set();
    
    arrData.forEach(item => {
      if (item.shop_cd) {
        if (Number(item.out_qty) > 0) allShopsWithOut.add(item.shop_cd);
        if (Number(item.sale_qty) > 0) allShopsWithSale.add(item.shop_cd);
        if (Number(item.out_qty_ly) > 0) allShopsWithOut_ly.add(item.shop_cd);
        if (Number(item.sale_qty_ly) > 0) allShopsWithSale_ly.add(item.shop_cd);
      }
    });
    
    subtotal.shop_out_count = allShopsWithOut.size;
    subtotal.shop_sale_count = allShopsWithSale.size;
    subtotal.shop_out_count_ly = allShopsWithOut_ly.size;
    subtotal.shop_sale_count_ly = allShopsWithSale_ly.size;
  } else {
    // 원본 데이터가 없으면 그룹별 합계 사용
    subtotal.shop_out_count = data.reduce((sum, item) => sum + (item.shop_out_count || 0), 0);
    subtotal.shop_sale_count = data.reduce((sum, item) => sum + (item.shop_sale_count || 0), 0);
    subtotal.shop_out_count_ly = data.reduce((sum, item) => sum + (item.shop_out_count_ly || 0), 0);
    subtotal.shop_sale_count_ly = data.reduce((sum, item) => sum + (item.shop_sale_count_ly || 0), 0);
  }
  
  // 현재년도 전체 판매율 계산 (가중평균)
  subtotal.sale_qty_rate = subtotal.out_qty > 0 
    ? subtotal.sale_qty / subtotal.out_qty
    : 0;
  
  subtotal.sale_tag_rate = subtotal.out_tag > 0 
    ? subtotal.sale_tag / subtotal.out_tag
    : 0;
  
  subtotal.sale_amt_rate = subtotal.out_tag > 0 
    ? subtotal.sale_amt / subtotal.out_tag
    : 0;

  subtotal.sale_tag_rate_tag = subtotal.out_tag > 0 
    ? subtotal.sale_tag / subtotal.out_tag
    : 0;
    
  // 전년도 전체 판매율 계산 (가중평균)
  subtotal.sale_qty_rate_ly = subtotal.out_qty_ly > 0 
    ? subtotal.sale_qty_ly / subtotal.out_qty_ly
    : 0;
  
  subtotal.sale_tag_rate_ly = subtotal.out_tag_ly > 0 
    ? subtotal.sale_tag_ly / subtotal.out_tag_ly
    : 0;
  
  subtotal.sale_amt_rate_ly = subtotal.out_tag_ly > 0 
    ? subtotal.sale_amt_ly / subtotal.out_tag_ly
    : 0;

  subtotal.sale_tag_rate_tag_ly = subtotal.out_tag_ly > 0 
    ? subtotal.sale_tag_ly / subtotal.out_tag_ly
    : 0;
  
  // 소계의 전년대비 증감 계산
  // 증감량
  subtotal.out_qty_diff = subtotal.out_qty - subtotal.out_qty_ly;
  subtotal.out_amt_diff = subtotal.out_amt - subtotal.out_amt_ly;
  subtotal.out_tag_diff = subtotal.out_tag - subtotal.out_tag_ly;
  subtotal.sale_qty_diff = subtotal.sale_qty - subtotal.sale_qty_ly;
  subtotal.sale_tag_diff = subtotal.sale_tag - subtotal.sale_tag_ly;
  subtotal.sale_amt_diff = subtotal.sale_amt - subtotal.sale_amt_ly;

  subtotal.shop_out_count_diff = subtotal.shop_out_count - subtotal.shop_out_count_ly;
  subtotal.shop_sale_count_diff = subtotal.shop_sale_count - subtotal.shop_sale_count_ly;

  // 증감률
  subtotal.out_qty_growth = subtotal.out_qty_ly > 0 
    ? ((subtotal.out_qty - subtotal.out_qty_ly) / subtotal.out_qty_ly )
    : 0;
  subtotal.out_amt_growth = subtotal.out_amt_ly > 0 
    ? ((subtotal.out_amt - subtotal.out_amt_ly) / subtotal.out_amt_ly)
    : 0;
  subtotal.out_tag_growth = subtotal.out_tag_ly > 0 
    ? ((subtotal.out_tag - subtotal.out_tag_ly) / subtotal.out_tag_ly)
    : 0;
  subtotal.sale_qty_growth = subtotal.sale_qty_ly > 0 
    ? ((subtotal.sale_qty - subtotal.sale_qty_ly) / subtotal.sale_qty_ly)
    : 0;
  subtotal.sale_tag_growth = subtotal.sale_tag_ly > 0 
    ? ((subtotal.sale_tag - subtotal.sale_tag_ly) / subtotal.sale_tag_ly)
    : 0;
  subtotal.sale_amt_growth = subtotal.sale_amt_ly > 0 
    ? ((subtotal.sale_amt - subtotal.sale_amt_ly) / subtotal.sale_amt_ly)
    : 0;

  subtotal.shop_out_count_growth = subtotal.shop_out_count_ly > 0 
    ? ((subtotal.shop_out_count - subtotal.shop_out_count_ly) / subtotal.shop_out_count_ly)
    : 0;
  subtotal.shop_sale_count_growth = subtotal.shop_sale_count_ly > 0 
    ? ((subtotal.shop_sale_count - subtotal.shop_sale_count_ly) / subtotal.shop_sale_count_ly)
    : 0;
    
  // 소계 row를 데이터 끝에 추가
  return [...data, subtotal];
}

const sumKeys = ["sale_qty", "sale_tag", "sale_amt", "out_qty", "out_amt", "out_tag",
                "sale_qty_ly", "sale_tag_ly", "sale_amt_ly", "out_qty_ly", "out_amt_ly", "out_tag_ly"]
const groupKeys = ["shop_cd", "shop_nm", "tp_nm"]
const data = {{ (varSelectedChannel.value === null || varSelectedChannel.value?.tp_nm ==='소계') ? getSalesByShop.data : formatDataAsObject(formatDataAsArray(getSalesByShop.data).filter(i => i.tp_nm === varSelectedChannel.value?.tp_nm ))}}
let arrData = formatDataAsArray(data).filter(i => i.onoff_flag = '오프라인')

// 먼저 기존 groupBySum 실행
const groupedArr = groupBySum(arrData, groupKeys, sumKeys)

// shop count 추가
const withShopCounts = addShopCounts(arrData, groupedArr, groupKeys)

// 판매율 추가
const withRates = addSaleRates(withShopCounts)

// 전년대비 증감 추가
const withGrowth = addYoYGrowth(withRates)

// 소계 row 추가 (원본 데이터도 전달)
const finalResult = addSubtotalRow(withGrowth, sumKeys, arrData)

return finalResult.sort((a, b) => {
  // 소계가 항상 맨 위로
  if (a.shop_cd === '소계') return -1;
  if (b.shop_cd === '소계') return 1;
  
  // 나머지는 sale_tag_rate 기준으로 정렬
  return a.sale_tag_rate - b.sale_tag_rate;
})
