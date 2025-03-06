//  localStorage.setValue('br_cd', '01')
//  console.log(localStorage.values.br_cd)

//  console.log(`===>>> 아가방 header...`)

switch(current_user.email){
  // 에뜨와
  case 'ettoimd@gmail.com': {
    localStorage.setValue('br_cd', '01')
   //utils.openUrl('https://agabang.cleave.work/app/item-map-disney', {newTab: false})
  } break;
  // 디즈니 
  case 'ds.md@agabang.com': {
    //  localStorage.setValue('br_cd', '01')
    utils.openUrl('https://agabang.cleave.work/app/item-map-disney', {newTab: false})
  } break;
  // 아가방 
  case 'agabang223030@gmail.com': {
    localStorage.setValue('br_cd', '01')
    //  utils.openUrl('https://agabang.cleave.work/app/item-map-agabang', {newTab: false})
  } break;
  // 클리브
  case 'project@cleave.work': {
    localStorage.setValue('br_cd', '01')
    //  utils.openUrl('https://agabang.cleave.work/app/item-map-agabang', {newTab: false})
  } break;
}