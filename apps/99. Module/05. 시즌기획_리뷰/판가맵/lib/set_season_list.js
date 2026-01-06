const sel_season = select_season.value;

let year = Number(sel_season.substring(0,2));
let season = sel_season.substring(2,4);

let season_list = [
  year + season,
  (year-1) + season,
  (year-2) + season,  
]

var_season_list.setValue(season_list)

console.log(season_list)