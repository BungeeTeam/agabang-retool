// Reference external variables with curly brackets or using JS variables
const current_data = {{ get_week_list_current.data }}
const previous_data = {{ get_week_list_previous.data }}


let result_list = []

// 함수....
const getGoodsTotal = (_list) => {
  return _list?.reduce((acc, cur) => {
    // 일반 용품 카테고리 및 코드값
    if(cur.category==='8' || cur.it_gb_cd==='84' || cur.it_gb_cd==='85' || cur.it_gb_cd==='88' || cur.it_gb_nm==='부가부' || cur.it_gb_nm==='요요2'){
      return acc+parseInt(cur.sale_amt) 
    } 
    return acc
  }, 0)
}

const getGubunCodeValue = (_list, _code) => {
  return _list?.reduce((acc, cur) => {
    if(cur.it_gb_cd===_code) return acc+parseInt(cur.sale_amt) 
    return acc
  }, 0)
}
const getGubunNameValue = (_list, _name) => {
  return _list?.reduce((acc, cur) => {
    if(cur.it_gb_nm===_name) return acc+parseInt(cur.sale_amt) 
    return acc
  }, 0)
}
const getCategoryValue = (_list, _category) => {
  return _list?.reduce((acc, cur) => {
    if(cur.category===_category) return acc+parseInt(cur.sale_amt) 
    return acc
  }, 0)
}

// 합계..
const all_01_tot = getGoodsTotal(current_data)
const all_02_tot = getGoodsTotal(previous_data)

// 섬유1 =======
const fiber1_01_tot = getGubunCodeValue(current_data, '84')
const fiber1_02_tot = getGubunCodeValue(previous_data, '84')

result_list.push({
  type: '섬유1',
  sean_01_cd:"-",
  sean_01_nm:"섬유1",
  sean_01_tot:fiber1_01_tot,
  sean_01_rate:fiber1_01_tot/all_01_tot,
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:fiber1_02_tot,
  sean_02_rate:fiber1_02_tot/all_02_tot,
  sean_03_pos: fiber1_01_tot-fiber1_02_tot,
  sean_03_rate:(fiber1_01_tot-fiber1_02_tot) / fiber1_02_tot
})

// 섬유2 ======= 
const fiber2_01_tot = getGubunCodeValue(current_data, '85')
const fiber2_02_tot = getGubunCodeValue(previous_data, '85')

result_list.push({
  type: '섬유2',
  sean_01_cd:"-",
  sean_01_nm:"섬유2",
  sean_01_tot:fiber2_01_tot,
  sean_01_rate:fiber2_01_tot/all_01_tot,
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:fiber2_02_tot,
  sean_02_rate:fiber2_02_tot/all_02_tot,
  sean_03_pos: fiber2_01_tot-fiber2_02_tot,
  sean_03_rate:(fiber2_01_tot-fiber2_02_tot) / fiber2_02_tot
})

// 부가부 ======= 
const goods1_01_tot = getGubunNameValue(current_data, '부가부')
const goods1_02_tot = getGubunNameValue(previous_data, '부가부')

result_list.push({
  type: '부가부',
  sean_01_cd:"-",
  sean_01_nm:"부가부",
  sean_01_tot:goods1_01_tot,
  sean_01_rate:goods1_01_tot/all_01_tot,
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:goods1_02_tot,
  sean_02_rate:goods1_02_tot/all_02_tot,
  sean_03_pos: goods1_01_tot-goods1_02_tot,
  sean_03_rate:(goods1_01_tot-goods1_02_tot) / goods1_02_tot
})

// 요요2 ======= 
const goods2_01_tot = getGubunNameValue(current_data, '요요2')
const goods2_02_tot = getGubunNameValue(previous_data, '요요2')

result_list.push({
  type: '요요2',
  sean_01_cd:"-",
  sean_01_nm:"요요",
  sean_01_tot:goods2_01_tot,
  sean_01_rate:goods2_01_tot/all_01_tot,
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:goods2_02_tot,
  sean_02_rate:goods2_02_tot/all_02_tot,
  sean_03_pos: goods2_01_tot-goods2_02_tot,
  sean_03_rate:(goods2_01_tot-goods2_02_tot) / goods2_02_tot
})

// ?? ======= 
const goods3_01_tot = getGubunCodeValue(current_data, '88')
const goods3_02_tot = getGubunCodeValue(previous_data, '88')

result_list.push({
  type: '-',
  sean_01_cd:"-",
  sean_01_nm:"-",
  sean_01_tot:goods3_01_tot,
  sean_01_rate:goods3_01_tot/all_01_tot,
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:goods3_02_tot,
  sean_02_rate:goods3_02_tot/all_02_tot,
  sean_03_pos: goods3_01_tot-goods3_02_tot,
  sean_03_rate:(goods3_01_tot-goods3_02_tot) / goods3_02_tot
})

// 기타 ======= 
const goods_01_all_tot = getCategoryValue(current_data, '8')
const goods_02_all_tot = getCategoryValue(previous_data, '8')


result_list.push({
  type: '기타',
  sean_01_cd:"-",
  sean_01_nm:"기타",
  sean_01_tot:goods_01_all_tot-fiber1_01_tot-fiber2_01_tot-goods1_01_tot-goods2_01_tot-goods3_01_tot,
  sean_01_rate:goods3_01_tot/all_01_tot,
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:goods_02_all_tot-fiber1_02_tot-fiber2_02_tot-goods1_02_tot-goods2_02_tot-goods3_02_tot,
  sean_02_rate:goods3_02_tot/all_02_tot,
  sean_03_pos: goods3_01_tot-goods3_02_tot,
  sean_03_rate:(goods3_01_tot-goods3_02_tot) / goods3_02_tot
})

// 합계 ======= 






// 합계.... push
result_list.push({
  type: 'all',
  sean_01_cd:"-",
  sean_01_nm:"합계",
  sean_01_tot:all_01_tot,
  sean_01_rate:'-',
  sean_02_cd:"-",
  sean_02_nm:"-",
  sean_02_tot:all_02_tot,
  sean_02_rate:'-',
  sean_03_pos: '-',
  sean_03_rate:'-'
})

return result_list