// Reference external variables with curly brackets or using JS variables
const new_01_season_list = {{ get_season_code_list_new_01.data }}
const new_02_season_list = {{ get_season_code_list_new_02.data }}

const old_01_season_list = {{ get_season_code_list_old_01.data }}
const old_02_season_list = {{ get_season_code_list_old_02.data }}

const current_data = {{ get_week_list_current.data }}
const previous_data = {{ get_week_list_previous.data }}

//  let new_data = []
let result_data = []

// 2025년 신상
new_01_season_list.forEach((item) => {
  item.tot = current_data.reduce((acc, cur) => {
    if(cur.sesn_cd === item.year_sesn_cd) return acc+parseInt(cur.sale_amt)
    return acc
  }, 0 )
  console.log(`new_01.item.year_sesn_cd : ${item.year_sesn_cd}, ${item.year_sesn_nm_kor}, sum: ${item.tot}`)

  result_data.push({
    type: 'new',
    sean_01_cd: item.year_sesn_cd,
    sean_01_nm: item.year_sesn_nm_kor,
    sean_01_tot: item.tot
  })
  return item
})

// 2024년 신상
new_02_season_list.forEach((item, index) => {
  item.tot = previous_data.reduce((acc, cur) => {
    if(cur.sesn_cd === item.year_sesn_cd) return acc+parseInt(cur.sale_amt) 
    return acc
  }, 0 )
  console.log(`new_02.item.year_sesn_cd : ${item.year_sesn_cd}, ${item.year_sesn_nm_kor}, sum: ${item.tot}, index: ${index}`)
  //  console.log(`new_02.new_data[${index}] : ${JSON.stringify(result_data[index])}`)

  if(result_data[index]){
    result_data[index]['sean_02_cd'] = item.year_sesn_cd
    result_data[index]['sean_02_nm'] = item.year_sesn_nm_kor
    result_data[index]['sean_02_tot'] = item.tot
  }
  
  return item
})






// 2025년 이월
old_01_season_list.forEach((item) => {
  item.tot = current_data.reduce((acc, cur) => {
    if(cur.sesn_cd === item.year_sesn_cd) return acc+parseInt(cur.sale_amt)
    return acc
  }, 0 )
  //  console.log(`old_01.item.year_sesn_cd : ${item.year_sesn_cd}, ${item.year_sesn_nm_kor}, sum: ${result}`)

  result_data.push({
    type: 'old',
    sean_01_cd: item.year_sesn_cd,
    sean_01_nm: item.year_sesn_nm_kor,
    sean_01_tot: item.tot
  })
  
  return item
})

console.log(`..result_data length : ${result_data?.length}`)
//  console.log(`..result_data ==>>  : ${JSON.stringify(result_data)}`)

// 2024년 이월
old_02_season_list.forEach((item, index) => {
  item.tot = previous_data.reduce((acc, cur) => {
    if(cur.sesn_cd === item.year_sesn_cd) return acc+parseInt(cur.sale_amt) 
    return acc
  }, 0 )
  //  console.log(`old_02.item.year_sesn_cd : ${item.year_sesn_cd}, ${item.year_sesn_nm_kor}, sum: ${result}`)

  let cnt = new_01_season_list?.length
  if(result_data[cnt+index]){
    result_data[cnt+index]['sean_02_cd'] = item.year_sesn_cd
    result_data[cnt+index]['sean_02_nm'] = item.year_sesn_nm_kor
    result_data[cnt+index]['sean_02_tot'] = item.tot
  }
  
  return item
})

let season_01_sum = result_data.reduce((acc, cur) => {
    return acc+parseInt(cur.sean_01_tot) 
  }, 0 )
let season_02_sum = result_data.reduce((acc, cur) => {
    return acc+parseInt(cur.sean_02_tot) 
  }, 0 )

console.log(`====>> season_01_sum : ${season_01_sum}`)
console.log(`====>> season_02_sum : ${season_02_sum}`)

result_data.forEach((item, index) => {
  item.sean_01_rate = (item.sean_01_tot/season_01_sum)
  item.sean_02_rate = (item.sean_02_tot/season_02_sum)
  item.sean_03_pos = item.sean_01_tot - item.sean_02_tot
  if(item.sean_02_tot > 0 ){
    item.sean_03_rate = (item.sean_03_pos / item.sean_02_tot)
  }
})
console.log(`====>> result_data?.length : ${result_data?.length}`)
//  console.log(`====>> result_data : ${JSON.stringify(result_data)}`)

return result_data