// var_brand_code 값 가져오기
const brandCode = var_brand_code.value;

// 브랜드 코드에 따라 브랜드 목록 설정
let brandList = [];

// 브랜드 코드에 따른 조건 분기
switch (brandCode) {
  // 브랜드 코드가 '01'인 경우
  case '01':
    brandList = [
      { br_nm: "전체", value: "all" },
      { br_nm: "아가방", value: "agabang" },
      //  { br_nm: "기타", value: "etc" },
    ];
    break;
    
  // 브랜드 코드가 '07'인 경우
  case '07':
    brandList = [
      { br_nm: "전체", value: "all" },
      { br_nm: "에뜨와", value: "ettoi" },
      { br_nm: "리우드", value: "liewood" },
    ];
    break;
    
  // 브랜드 코드가 '79'인 경우 (새로 추가)
  case '79':
    brandList = [
      { br_nm: "전체", value: "all" },
      { br_nm: "디즈니", value: "disney" },
    ];
    break;
    
  // 예외 처리: 기본값 설정
  default:
    brandList = [
      { br_nm: "전체", value: "all" }
    ];
    console.log(`알 수 없는 브랜드 코드: ${brandCode}, 기본값 사용`);
}

// 변경 확인 로그
console.log(`브랜드 코드 ${brandCode}에 따라 브랜드 목록이 업데이트되었습니다.`);
console.log("업데이트된 브랜드 목록:", brandList);

// 성공적으로 실행됨을 반환
return {
  brandList
};