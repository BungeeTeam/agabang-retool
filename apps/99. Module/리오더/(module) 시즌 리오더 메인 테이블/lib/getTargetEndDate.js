// 이 Transformer는 select_season.value에 따라 특정 날짜를 계산하여 반환합니다.

// 현재 날짜를 가져옵니다.
const today = new Date();
const currentYear = today.getFullYear();

// select_season.value는 "S3"와 같은 문자열 형태라고 가정합니다.
// 만약 select_season.value가 null 또는 undefined일 수 있다면, 기본값이나 안전한 처리가 필요합니다.
const rawSeasonValue = {{ select_season.value }}; // Retool 컴포넌트 값 참조

let seasonCodeStr;
if (typeof rawSeasonValue === 'string' && rawSeasonValue.length >= 2) {
  seasonCodeStr = rawSeasonValue.substring(1, 2); // 'S3'에서 '3' 추출
} else {
  // 유효하지 않은 select_season.value 일 경우, 기본 처리
  // 예를 들어, 현재 날짜로부터 90일 후를 기본값으로 사용하거나 오류 처리
  seasonCodeStr = ''; // 빈 문자열로 두어 parseInt에서 NaN이 되도록 함
}

const seasonCode = parseInt(seasonCodeStr);

let targetDate;

// 계절 코드에 따라 목표 날짜를 설정합니다.
if (seasonCode === 7 || seasonCode === 8) {
  // 가장 가까운 미래의 2월 28일
  targetDate = new Date(currentYear, 1, 28); // 2월은 1 (0부터 시작)
  // 현재 날짜가 2월 28일을 지났으면 내년으로 설정
  if (targetDate < today) {
    targetDate.setFullYear(currentYear + 1);
  }
} else if (seasonCode === 5 || seasonCode === 6) {
  // 가장 가까운 미래의 12월 31일
  targetDate = new Date(currentYear, 11, 31); // 12월은 11
  // 현재 날짜가 12월 31일을 지났으면 내년으로 설정
  if (targetDate < today) {
    targetDate.setFullYear(currentYear + 1);
  }
} else if (seasonCode === 3 || seasonCode === 4) {
  // 가장 가까운 미래의 8월 31일
  targetDate = new Date(currentYear, 7, 31); // 8월은 7
  // 현재 날짜가 8월 31일을 지났으면 내년으로 설정
  if (targetDate < today) {
    targetDate.setFullYear(currentYear + 1);
  }
} else if (seasonCode === 1 || seasonCode === 2) {
  // 가장 가까운 미래의 5월 15일
  targetDate = new Date(currentYear, 4, 15); // 5월은 4
  // 현재 날짜가 5월 15일을 지났으면 내년으로 설정
  if (targetDate < today) {
    targetDate.setFullYear(currentYear + 1);
  }
} else {
  // 일치하는 계절 코드가 없거나 seasonCode가 NaN인 경우,
  // 원래 코드처럼 현재 날짜로부터 90일 후를 기본값으로 합니다.
  const tempDate = new Date(today.getTime()); // 오늘 날짜 복사
  targetDate = new Date(tempDate.setDate(tempDate.getDate() + 90));
}

// 결과를 YYYY-MM-DD 형식의 문자열로 반환
const year = targetDate.getFullYear();
const month = String(targetDate.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
const day = String(targetDate.getDate()).padStart(2, '0');

return `${year}-${month}-${day}`;