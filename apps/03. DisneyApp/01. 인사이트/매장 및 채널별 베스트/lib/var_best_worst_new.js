// Reference external variables with curly brackets or using JS variables
let _list = []

const _type = {{ select_main_type.value }}
switch (_type){
  case 'shop': {
    _list = {{ formatDataAsArray(query_get_data.data) }}
  } break;
  case 'channel': {
    _list = {{ formatDataAsArray(query_get_data_channel_new.data) }}
  } break;
}
//  console.log(_list)
let _best_list = []
let _worst_list = []

for(const item of _list){
  console.log(_list)
  switch(item.sort){
    case 'BEST': {
      _best_list.push(item)
    } break;
    case 'WORST': {
      _worst_list.push(item)
    } break;
  }
}

return {
  best: _best_list,
  worst: _worst_list,
}