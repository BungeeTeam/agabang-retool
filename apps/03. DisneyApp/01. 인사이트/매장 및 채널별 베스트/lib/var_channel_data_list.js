// Reference external variables with curly brackets or using JS variables
const _shop_type = {{ select_main_type.selectedItem.value }}
let ret_data = []
console.log(`_shop_type : ${_shop_type}`)
switch(_shop_type){
  case 'shop': {
    ret_data = {{ formatDataAsArray(query_shop_list_new.data) }}
  } break;
  case 'channel': {
      ret_data = {{ formatDataAsArray(query_channel_list_new.data) }}
    for(let key in ret_data){
      ret_data[key].shop_cd = ret_data[key]?.channel_cd
      ret_data[key].shop_nm = ret_data[key]?.channel_gb
    }
  } break; 
}

//  switch(_shop_type){
//    case 'shop': {
//      ret_data = {{ formatDataAsArray(query_shop_list_new.data) }}
//    } break;
//    case 'channel': {
//      ret_data = {{ formatDataAsArray(query_channel_list_new.data) }}
//      for(let key in ret_data){
//        ret_data[key].shop_cd = ret_data[key]?.channel_gb
//        ret_data[key].shop_nm = ret_data[key]?.channel_gb
//      }
//    } break; 
//  }

return ret_data