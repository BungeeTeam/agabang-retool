// Reference external variables with curly brackets or using JS variables
const _list = {{ var_week_data.value }}

//  const new_01_season_list = {{ get_season_code_list_new_01.data }}
//  const new_02_season_list = {{ get_season_code_list_new_02.data }}
//  const old_01_season_list = {{ get_season_code_list_old_01.data }}
//  const old_02_season_list = {{ get_season_code_list_old_02.data }}

const current_data = {{ get_week_list_current.data }}
const previous_data = {{ get_week_list_previous.data }}


let result_list = []

// 함수....
//  const getTotal = (data_list) => {
//    return _list.reduce((acc, cur) => {
//    return acc+parseInt(cur.sean_01_tot) 
//  }, 0)
//  }

// 합계....
let all_01_tot = _list.reduce((acc, cur) => {
  return acc+parseInt(cur.sean_01_tot) 
}, 0)
let all_02_tot = _list.reduce((acc, cur) => {
  return acc+parseInt(cur.sean_02_tot) 
}, 0)
let all_01_rate = _list.reduce((acc, cur) => {
  return acc+cur.sean_01_rate
}, 0.0)
let all_02_rate = _list.reduce((acc, cur) => {
  return acc+cur.sean_02_rate
}, 0.0)
let all_03_pos = _list.reduce((acc, cur) => {
  return acc+parseInt(cur.sean_03_pos) 
}, 0)
let all_03_rate = _list.reduce((acc, cur) => {
  return acc+cur.sean_03_rate
}, 0.0)


// 신상 ======= 
let new_01_tot = _list.reduce((acc, cur) => {
  if(cur.type==='new') return acc+parseInt(cur.sean_01_tot) 
  return acc
}, 0)
let new_02_tot = _list.reduce((acc, cur) => {
  if(cur.type==='new') return acc+parseInt(cur.sean_02_tot) 
  return acc
}, 0)
let new_01_rate = _list.reduce((acc, cur) => {
  //  console.log(`acc: ${acc}, cur.sean_01_rate: ${cur.sean_01_rate}`)
  if(cur.type==='new') return acc+cur.sean_01_rate
  return acc
}, 0.0)
let new_02_rate = _list.reduce((acc, cur) => {
  if(cur.type==='new') return acc+cur.sean_02_rate
  return acc
}, 0.0)
let new_03_pos = _list.reduce((acc, cur) => {
  if(cur.type==='new') return acc+parseInt(cur.sean_03_pos) 
  return acc
}, 0)
let new_03_rate = _list.reduce((acc, cur) => {
  if(cur.type==='new') return acc+cur.sean_03_rate
  return acc
}, 0.0)


result_list.push({
  type: 'new',
  sean_01_cd:"-",
  sean_01_nm:"소계",
  sean_01_tot:new_01_tot,
  sean_01_rate:new_01_rate,
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:new_02_tot,
  sean_02_rate:new_02_rate,
  sean_03_pos: new_03_pos,
  sean_03_rate:new_03_rate
})


//  _list.forEach((item, index) => {
//    item.sean_01_rate = (item.sean_01_tot/season_01_sum)
//    item.sean_02_rate = (item.sean_02_tot/season_02_sum)
//    item.sean_03_pos = item.sean_01_tot - item.sean_02_tot
//    if(item.sean_02_tot > 0 ){
//      item.sean_03_rate = (item.sean_03_pos / item.sean_02_tot)
//    }
//  })



// 이월 ======= 
let old_01_tot = _list.reduce((acc, cur) => {
  if(cur.type==='old') return acc+parseInt(cur.sean_01_tot) 
  return acc
}, 0)
let old_02_tot = _list.reduce((acc, cur) => {
  if(cur.type==='old') return acc+parseInt(cur.sean_02_tot) 
  return acc
}, 0)
let old_01_rate = _list.reduce((acc, cur) => {
  if(cur.type==='old') return acc+cur.sean_01_rate
  return acc
}, 0.0)
let old_02_rate = _list.reduce((acc, cur) => {
  if(cur.type==='old') return acc+cur.sean_02_rate
  return acc
}, 0.0)
let old_03_pos = _list.reduce((acc, cur) => {
  if(cur.type==='old') return acc+parseInt(cur.sean_03_pos) 
  return acc
}, 0)
let old_03_rate = _list.reduce((acc, cur) => {
  if(cur.type==='old') return acc+cur.sean_03_rate
  return acc
}, 0.0)


result_list.push({
  type: 'old',
  sean_01_cd:"-",
  sean_01_nm:"소계",
  sean_01_tot:old_01_tot,
  sean_01_rate:old_01_rate,
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:old_02_tot,
  sean_02_rate:old_02_rate,
  sean_03_pos: old_03_pos,
  sean_03_rate:old_03_rate
})

// 일반용품?? 8
let goods_01_tot = current_data.reduce((acc, cur) => {
  if(cur.category==='8') return acc+parseInt(cur.sale_amt) 
  return acc
}, 0)
let goods_02_tot = previous_data.reduce((acc, cur) => {
  if(cur.category==='8') return acc+parseInt(cur.sale_amt) 
  return acc
}, 0)

//  new_01_season_list.forEach((item) => {
//    item.tot = current_data.reduce((acc, cur) => {
//      if(cur.sesn_cd === item.year_sesn_cd && item.category==='8') return acc+parseInt(cur.sale_amt)
//      return acc
//    }, 0 )
//    console.log(`new_01.item.year_sesn_cd : ${item.year_sesn_cd}, ${item.year_sesn_nm_kor}, sum: ${item.tot}`)

result_list.push({
  type: 'goods',
  sean_01_cd:"-",
  sean_01_nm:"일반용품",
  sean_01_tot:goods_01_tot,
  sean_01_rate:goods_01_tot/all_01_tot,
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:goods_02_tot,
  sean_02_rate:goods_02_tot/all_02_tot,
  sean_03_pos: goods_01_tot-goods_02_tot,
  sean_03_rate:(goods_01_tot-goods_02_tot) / goods_02_tot
})

// 판촉 
let promotion_01_tot = current_data.reduce((acc, cur) => {
  if(cur.category==='7') return acc+parseInt(cur.sale_amt) 
  return acc
}, 0)
let promotion_02_tot = previous_data.reduce((acc, cur) => {
  if(cur.category==='7') return acc+parseInt(cur.sale_amt) 
  return acc
}, 0)

// 판촉.... push
result_list.push({
  type: 'promotion',
  sean_01_cd:"-",
  sean_01_nm:"판촉 등",
  sean_01_tot:promotion_01_tot,
  sean_01_rate:promotion_01_tot/all_01_tot,
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:promotion_02_tot,
  sean_02_rate:promotion_02_tot/all_02_tot,
  sean_03_pos: promotion_01_tot-promotion_02_tot,
  sean_03_rate:(promotion_01_tot-promotion_02_tot) / promotion_02_tot
})

// 합계.... push
result_list.push({
  type: 'all',
  sean_01_cd:"-",
  sean_01_nm:"합계",
  sean_01_tot:all_01_tot,
  sean_01_rate:all_01_rate,
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:all_02_tot,
  sean_02_rate:all_02_rate,
  sean_03_pos: all_03_pos,
  sean_03_rate:all_03_rate
})

return result_list