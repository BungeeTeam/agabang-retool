const sty_cd = var_sel_sty_info.value.sty_cd
const style_color = var_sel_sty_info.value.sty_cd + var_sel_sty_info.value.col_cd

let year = 0
const year_code = sty_cd.substring(2,3)
if ( year_code == 'N' ) {
  year = 2020
}
else if ( year_code == 'O' ) {
  year = 2021
}
else if ( year_code == 'P' ) {
  year = 2022
}
else if ( year_code == 'Q' ) {
  year = 2023
}
else if ( year_code == 'R' ) {
  year = 2024
}
else if ( year_code == 'S' ) {
  year = 2025
}
else if ( year_code == 'T' ) {
  year = 2026
}


let season_name = ""
let season_category = ""
const season_code = sty_cd.substring(3,4)
if ( season_code == '0' ) {
  season_category = "";
  season_name = "";
}
else if ( season_code == '1' ) {
  season_category = "ss";
  season_name = "spring";
}
else if ( season_code == '3' ) {
  season_category = "ss";
  season_name = "summer";
}
else if ( season_code == '5' ) {
  season_category = "fw";
  season_name = "fall";
}
else if ( season_code == '7' ) {
  season_category = "fw";
  season_name = "winter";
}

//  let brand_image_path = 'ettoi'
//  let brand_image_extension = '.jpg'

//  switch(var_brand_code.value){
//    case '01': {
//      brand_image_path = 'agabang'
//      brand_image_extension = '_1.jpg'
//    } break;
//    //  case '02': {brand_image_path = 'ettoi'} break;
//    case '07': {
//      brand_image_path = 'ettoi'
//      brand_image_extension = '.jpg'
//    } break;
//    case '79': {
//      brand_image_path = 'agabang'
//      brand_image_extension = '_1.jpg'
//    } break;
//  }

//  switch(var_brand_code.value){
//    case '07': return [
//      { "title": "썸네일", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/thumb/"+ style_color + ".jpg"},
//      { "title": "에뜨와 상단", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_" + year + "_" + season_name + ".jpg"},
//      { "title": "상세페이지", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/"+ style_color + ".jpg"},
//      { "title": "모델핏", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/" + season_category + "_model.jpg"},
//      { "title": "사이즈표", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_bottom_new.jpg"}
//    ];
//    case '01': return [
//      { "title": "썸네일", "url": `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${style_color}.jpg`},
//      //  { "title": "에뜨와 상단", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_" + year + "_" + season_name + ".jpg"},
//      //  { "title": "상세페이지", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/"+ style_color + ".jpg"},
//      //  { "title": "모델핏", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/" + season_category + "_model.jpg"},
//      //  { "title": "사이즈표", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_bottom_new.jpg"}
//    ];
//    case '79': return [
//      { "title": "썸네일", "url": `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${style_color}.jpg`},
//      //  { "title": "에뜨와 상단", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_" + year + "_" + season_name + ".jpg"},
//      //  { "title": "상세페이지", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/"+ style_color + ".jpg"},
//      //  { "title": "모델핏", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/" + season_category + "_model.jpg"},
//      //  { "title": "사이즈표", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_bottom_new.jpg"}
//    ]
//  }

return [
  { "title": "썸네일", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/thumb/"+ style_color + ".jpg"},
  { "title": "에뜨와 상단", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_" + year + "_" + season_name + ".jpg"},
  { "title": "상세페이지", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/"+ style_color + ".jpg"},
  { "title": "모델핏", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/" + season_category + "_model.jpg"},
  { "title": "사이즈표", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_bottom_new.jpg"}
];



//  const image_list = [
//    { "title": "썸네일", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/thumb/"+ style_color + ".jpg"},
//    { "title": "에뜨와 상단", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_" + year + "_" + season_name + ".jpg"},
//    { "title": "상세페이지", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/"+ style_color + ".jpg"},
//    { "title": "모델핏", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/" + season_category + "_model.jpg"},
//    { "title": "사이즈표", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_bottom_new.jpg"}
  
//    //  { "title": "썸네일", "url": `https://item.nextmom.co.kr/magaline_img/goods/${brand_image_path}/${year}/thumb/${style_color}${brand_image_extension}`},
//    //  { "title": "에뜨와 상단", "url": `https://item.nextmom.co.kr/magaline_img/goods/${brand_image_path}/${year}/ettoi_${year}_${season_name}${brand_image_extension}`},
//    //  { "title": "상세페이지", "url": `https://item.nextmom.co.kr/magaline_img/goods/${brand_image_path}/${year}/${style_color}${brand_image_extension}`},
//    //  { "title": "모델핏", "url": `https://item.nextmom.co.kr/magaline_img/goods/${brand_image_path}/${year}/${season_category}_model${brand_image_extension}`},
//    //  { "title": "사이즈표", "url": `https://item.nextmom.co.kr/magaline_img/goods/${brand_image_path}/${year}/ettoi_bottom_new.jpg`}
//  ]

//  return image_list