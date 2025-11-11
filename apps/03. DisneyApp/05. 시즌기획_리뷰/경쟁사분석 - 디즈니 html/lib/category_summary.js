const data = {{ get_items.data }}
const result = {};

// 각 카테고리 처리
for (const [category, brands] of Object.entries(data)) {
  if (!result[category]) {
    result[category] = {};
  }

  // 각 브랜드의 데이터를 처리
  for (const [brand, items] of Object.entries(brands)) {
    if (!result[category][brand]) {
      result[category][brand] = { count: 0, totalPrice: 0 };
    }

    //  let _total_price = result[category][brand].totalPrice
    //  try {
    //    result[category][brand].totalPrice += items?.reduce((sum, item) => sum + parseInt(item?.origin_price, 10), 0)
    //  }
    //  catch(e){
    //    result[category][brand].totalPrice += 0;
    //  }
    
    
    

    // SKU 수와 총 가격 합산
    result[category][brand].count += items?.length;
    result[category][brand].totalPrice += items?.reduce((sum, item) => sum + parseInt(item?.origin_price, 10), 0)
    //  try {
      //  console.log(`items : ${JSON.stringify(items)}`)
      //  result[category][brand].totalPrice += items?.reduce((sum, item) => sum + parseInt(item?.origin_price, 10), 0);
    //  }
    //  catch(e){
    //    console.log(e)
    //  }
      
    
  }

  // 브랜드 순서를 정렬된 순서로 재배치
  const sortedBrands = {};
  for (const brand of {{ var_brand_orders.value }}) {
    if (result[category][brand]) {
      sortedBrands[brand] = result[category][brand];
    }
  }
  result[category] = sortedBrands; // 정렬된 브랜드로 업데이트
}

// 포맷에 맞게 변환
for (const category in result) {
  for (const brand in result[category]) {
    const { count, totalPrice } = result[category][brand];
    const averagePrice = Math.round(totalPrice / count).toLocaleString(); // 평균 가격 계산
    result[category][brand] = `${count} SKU | ${averagePrice}원`; // 포맷팅된 결과 저장
  }
}

return result;