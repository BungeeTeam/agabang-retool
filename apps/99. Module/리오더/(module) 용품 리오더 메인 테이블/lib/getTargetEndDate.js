// 용품은 오늘 + 6개월을 기본 판매 마감일로 사용

// 오늘 날짜를 가져옵니다.
const today = new Date();

// 오늘 날짜에 6개월을 더합니다.
// setMonth()는 현재 월(0부터 시작)에 값을 더하거나 뺄 수 있으며,
// 다음 연도로 넘어가는 것을 자동으로 처리합니다.
today.setMonth(today.getMonth() + 6);

// 결과를 YYYY-MM-DD 형식의 문자열로 포맷팅합니다.
const year = today.getFullYear();
const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1, 두 자리로 패딩
const day = String(today.getDate()).padStart(2, '0');     // 날짜를 두 자리로 패딩

// 포맷된 날짜 문자열을 반환합니다.
return `${year}-${month}-${day}`;


// 추후 select_season.value에 따라 특정 날짜를 계산하여 판매 마감일을 반환해야하면 아래 주석 해제하기

// // 현재 날짜를 가져옵니다.
// const today = new Date();
// const currentYear = today.getFullYear();

// // select_season.value는 "R1" 또는 "S3", "Q7"과 같은 문자열 형태라고 가정합니다.
// const rawSeasonValue = {{select_season.value}}; // Retool 컴포넌트 값 참조

// // select_season 쿼리의 전체 결과를 가져옵니다.
// const seasonList = {{ select_season.data }};

// let seasonYearCodeChar;
// let seasonCodeStr;
// let targetYear = currentYear; // 기본 연도는 현재 연도로 설정 (유효하지 않은 값 대비)

// if (typeof rawSeasonValue === 'string' && rawSeasonValue.length >= 2) {
//   seasonYearCodeChar = rawSeasonValue.substring(0, 1);
//   seasonCodeStr = rawSeasonValue.substring(1, 2);

//   let formattedSeasonList = []; 
//   if (Array.isArray(seasonList) && seasonList.length > 0) {
//     formattedSeasonList = seasonList.map(item => ({
//       year_cd: String(item.year_cd),
//       sesn_cd: String(item.sesn_cd),
//       year_nm: String(item.year_nm),
//       season_code: String(item.season_code)
//     }));
//   }
//   // else (seasonList가 유효한 배열이 아니거나 비어있는 경우)는 targetYear가 currentYear로 유지됨

//   const matchedSeason = formattedSeasonList.find(
//     s => s.season_code === rawSeasonValue
//   );

//   if (matchedSeason) {
//     targetYear = parseInt(matchedSeason.year_nm);
//   }
// }
// // else (rawSeasonValue가 유효하지 않은 경우)는 targetYear가 currentYear로 유지됨

// const seasonCode = parseInt(seasonCodeStr);

// let targetDate;
// let effectiveTargetYear = targetYear; // 날짜 계산에 사용될 실제 연도

// // 겨울 시즌 (seasonCode 7 또는 8)에만 다음 해로 넘어가도록 effectiveTargetYear 조정
// if (seasonCode === 7 || seasonCode === 8) { // 겨울 (WT) 또는 가을 (FA)
//     effectiveTargetYear = targetYear + 1; // 선택된 연도의 다음 해로 설정
// }

// // 계절 코드(seasonCode)에 따라 목표 날짜를 설정합니다.
// // 이제는 effectiveTargetYear를 사용합니다.
// if (seasonCode === 7 || seasonCode === 8) { // 가을 (FA) / 겨울 (WT)
//   targetDate = new Date(effectiveTargetYear, 1, 28); // 2월 28일
// } else if (seasonCode === 5 || seasonCode === 6) { // 가을 (FA) / 겨울 (WT)
//   targetDate = new Date(effectiveTargetYear, 11, 31); // 12월 31일
// } else if (seasonCode === 3 || seasonCode === 4) { // 여름 (SM)
//   targetDate = new Date(effectiveTargetYear, 7, 31); // 8월 31일
// } else if (seasonCode === 1 || seasonCode === 2) { // 봄 (SP)
//   targetDate = new Date(effectiveTargetYear, 4, 15); // 5월 15일
// } else if (seasonCode === 0) { // NO 시즌 (사계절)
//    targetDate = new Date(effectiveTargetYear, 0, 1); // 해당 연도 1월 1일 (예시)
// }
// else {
//   // 일치하는 계절 코드가 없거나 seasonCode가 NaN인 경우
//   const tempDate = new Date(today.getTime());
//   targetDate = new Date(tempDate.setDate(tempDate.getDate() + 90));
// }

// // 결과를 YYYY-MM-DD 형식의 문자열로 반환
// const year = targetDate.getFullYear();
// const month = String(targetDate.getMonth() + 1).padStart(2, '0');
// const day = String(targetDate.getDate()).padStart(2, '0');

// return `${year}-${month}-${day}`;