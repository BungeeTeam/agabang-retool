const sel_season = select_season.value;

// 현재 선택된 시즌의 연도와 시즌 분리
let year = Number(sel_season.substring(0, 2));
let season = sel_season.substring(2, 4);

// 사용자가 정한 시즌 갯수
const season_count = numberInput_years.value

// 시즌 목록 생성
let season_list = [];
for (let i = 0; i < season_count; i++) {
  season_list.push((year - (i+1)) + season);
}

// 결과값을 var_season_list에 설정
var_season_list.setValue(season_list);

return season_list;