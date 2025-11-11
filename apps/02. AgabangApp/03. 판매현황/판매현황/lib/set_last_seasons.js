function generateSeasons() {

  const input = select_season.value;
  const year = Number(input.substring(0, 2)); // 입력값의 연도를 추출
  const season = input.substring(2, 4); // 입력값의 시즌을 추출
  
  // 현재 연도 포함 이전 두 연도를 포함한 배열 생성
  const seasons = [
    `${String(year - 2).padStart(2, '0')}${season}`, // 두 시즌 전
    `${String(year - 1).padStart(2, '0')}${season}`, // 한 시즌 전
    `${String(year).padStart(2, '0')}${season}` // 현재 시즌
  ];

  return seasons;
}

const seasons = generateSeasons()
var_last_seasons.setValue(seasons)
