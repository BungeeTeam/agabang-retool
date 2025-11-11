const arr = {{ formatDataAsArray(seasonInfoQuery2.data) }}

const sumKeys = ["입고수량", "입고금액", "판매수량", "판매금액", "판매TAG가", "입고원가",  "스타일수", "컬러수", "출고수량"]
let arrayData = groupBySum(arr, [], sumKeys)

return arrayData

//  const dataArray = Object.entries(arrayData).map(([name, value]) => ({
//      name: name,
//      value: value
//  }));

//  return dataArray