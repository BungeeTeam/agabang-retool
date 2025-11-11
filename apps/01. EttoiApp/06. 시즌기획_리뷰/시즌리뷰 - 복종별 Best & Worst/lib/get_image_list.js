const sty_cd = var_sel_sty_info.value.sty_cd
const style_color = var_sel_sty_info.value.sty_cd + var_sel_sty_info.value.col_cd

let year = 0
const year_code = sty_cd.substring(2,3)
if ( year_code == 'P' ) {
  year = 2022
}
else if ( year_code == 'Q' ) {
  year = 2023
}
else if ( year_code == 'R' ) {
  year = 2024
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


const image_list = [
  { "title": "썸네일", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/thumb/"+ style_color + ".jpg"},
{ "title": "에뜨와 상단", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_" + year + "_" + season_name + ".jpg"},
{ "title": "상세페이지", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/"+ style_color + ".jpg"},
{ "title": "모델핏", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/" + season_category + "_model.jpg"},
{ "title": "사이즈표", "url": "https://item.nextmom.co.kr/magaline_img/goods/ettoi/" + year + "/ettoi_bottom_new.jpg"}
]

return image_list