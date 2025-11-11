const arr = {{ formatDataAsArray(seasonInfoQuery.data) }}

const sumKeys = ["입고수량", "입고금액", "판매수량", "판매금액", "판매TAG가", "입고원가",  "스타일수", "컬러수", "출고수량"]

let arrayData = groupBySum(arr, [], sumKeys)

arrayData[0]["배수"] = (arrayData[0]["입고금액"] / 1.1) / arrayData[0]["입고원가"]
console.log(arrayData, arrayData[0]["입고원가"])
return arrayData

//  const dataArray = Object.entries(arrayData).map(([name, value]) => ({
//      name: name,
//      value: value
//  }));

//  return dataArray