// Retool JS 쿼리: get_season_bucket
function getSeasonBucket(combinedCode) {
  // 입력값 검증
  if (!combinedCode || combinedCode.length < 4) {
    console.log("Invalid input code:", combinedCode);
    return { error: "유효하지 않은 코드입니다." };
  }

  const yearMap = {
    'S': '25', // 2025
    'R': '24', // 2024
    'Q': '23', // 2023
    'P': '22'  // 2022
  };
  const seasonMap = {
    '1': 'SP', '2': 'SP', // 봄
    '3': 'SM', '4': 'SM', // 여름
    '5': 'FA', '6': 'FA', // 가을
    '7': 'WT', '8': 'WT', // 겨울
    '0': 'NO'  // 무시즌
  };
  const brandMap = {
    '01': '아가방',
    '07': '에뜨와',
    '79': '디즈니'
  };

  // 코드 분해
  const brandCode = combinedCode.slice(0, 2);
  const yearChar = combinedCode.charAt(2);   // 3번째 글자 (R)
  const seasonChar = combinedCode.charAt(3); // 4번째 글자 (5)
  
  // 디버깅용 로그
  console.log("combinedCode:", combinedCode);
  console.log("brandCode:", brandCode);
  console.log("yearChar:", yearChar, "seasonChar:", seasonChar);
  
  // 매핑된 값과 원본 코드 분리
  const yearName = yearMap[yearChar] || 'XX';  // "24" 같은 연도 이름
  const seasonName = seasonMap[seasonChar] || 'NO';  // "FA" 같은 시즌 이름
  const brandName = brandMap[brandCode] || '알수없음';
  
  console.log("yearName:", yearName, "seasonName:", seasonName);
  console.log("brandName:", brandName);
  
  // 객체로 개별 값 반환
  return {
    yearName: yearName,       // 연도 이름 (예: "24")
    yearCode: yearChar,       // 코드의 3번째 글자 (예: "R")
    seasonName: seasonName,   // 시즌 이름 (예: "FA")
    seasonCode: seasonChar,   // 코드의 4번째 글자 (예: "5")
    brandCode: brandCode,     // 브랜드 코드 (예: "79")
    brandName: brandName,     // 브랜드 이름 (예: "디즈니")
    fullCode: combinedCode    // 전체 코드
  };
}

// Retool에서의 실행 코드
const combinedCode = sel_sty.value.sty_cd + sel_sty.value.col_cd;
console.log("Input combined code:", combinedCode);
return getSeasonBucket(combinedCode);