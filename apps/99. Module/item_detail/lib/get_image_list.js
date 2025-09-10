// 헬퍼 함수: ClickHouse 구조 대응
function unwrap(val) {
  if (val && typeof val === "object") return val["0"];
  return val;
}
// 1. 스타일 입력값
const sty_cd = sel_sty.value?.sty_cd || "";
const col_cd = sel_sty.value?.col_cd || "";
const style_color = sty_cd + col_cd;
// 2. get_item_detail은 객체이므로 직접 꺼내기
const row = get_item_detail.data || {};

// 브랜드 코드 처리 - 문자열 형태로 통일
let br_cd = sel_sty.value?.br_cd || brand_code.value;
if (br_cd !== undefined && br_cd !== null) {
  br_cd = br_cd.toString();
}

const sty_nm = unwrap(row.sty_nm);
const col_nm = unwrap(row.col_nm);
console.log({ sty_cd, col_cd, style_color, br_cd, sty_nm, col_nm });
// 3. 필수값 검증
if (!sty_cd || !col_cd || !br_cd) {
  console.error("필수 입력값 누락");
  return [];
}

// 4. 연도 및 시즌 코드 추출
let year_code, season_code;

// 스타일 코드가 브랜드 코드로 시작하는지 확인
if (sty_cd.startsWith(br_cd)) {
  // 예: "79S121301"에서 브랜드 코드가 "79"인 경우
  const offset = br_cd.length;
  year_code = sty_cd.substring(offset, offset + 1);  // "S"
  season_code = sty_cd.substring(offset + 1, offset + 2);  // "1"
} else {
  // 기존 형식: "01S117001"에서 연도 코드와 시즌 코드 추출
  year_code = sty_cd.substring(2, 3);  // "S"
  season_code = sty_cd.substring(3, 4);  // "1"
}

console.log(`추출된 값: year_code=${year_code}, season_code=${season_code}`);

const year_map = { J: 2016, K: 2017, L: 2018, M: 2019, N: 2020, O: 2021, P: 2022, Q: 2023, R: 2024, S: 2025, T: 2026 };
const year = year_map[year_code];
if (!year) {
  console.error(`지원되지 않는 year_code: ${year_code}`);
  return [];
}

// 5. 시즌 계산 - 숫자 0도 지원하도록 수정
const season_map = {
  '0': { category: "ss", name: "spring" }, // 0도 봄 시즌으로 처리
  '1': { category: "ss", name: "spring" },
  '2': { category: "ss", name: "spring" }, // 추가
  '3': { category: "ss", name: "summer" },
  '4': { category: "ss", name: "summer" }, // 추가
  '5': { category: "fw", name: "fall" },
  '6': { category: "fw", name: "fall" },   // 추가
  '7': { category: "fw", name: "winter" },
  '8': { category: "fw", name: "winter" }  // 추가
};

const season = season_map[season_code];
if (!season) {
  console.error(`지원되지 않는 season_code: ${season_code}`);
  return [];
}
const { category: season_category, name: season_name } = season;

// 6. 브랜드별 이미지 URL 구성
if (br_cd == "7" || br_cd == "07") {
  return [
    { title: "썸네일", url: `https://item.nextmom.co.kr/magaline_img/goods/ettoi/${year}/thumb/${style_color}.jpg` },
    { title: "에뜨와 상단", url: `https://item.nextmom.co.kr/magaline_img/goods/ettoi/${year}/ettoi_${year}_${season_name}.jpg` },
    { title: "상세페이지", url: `https://item.nextmom.co.kr/magaline_img/goods/ettoi/${year}/${style_color}.jpg` },
    { title: "모델핏", url: `https://item.nextmom.co.kr/magaline_img/goods/ettoi/${year}/${season_category}_model.jpg` },
    { title: "사이즈표", url: `https://item.nextmom.co.kr/magaline_img/goods/ettoi/${year}/ettoi_bottom_new.jpg` }
  ];
}

if (br_cd == "1" || br_cd == "01") {
  const baseUrl = `https://item.nextmom.co.kr/magaline_img/goods/agabang/${year}`;
  const modelUrl = year < 2025
    ? `${baseUrl}/${season_category}_model.jpg`
    : `${baseUrl}/agabang_${season_category}_model.jpg`;
  
  // sel_sty.value.item과 br_cd 조건 확인
  const detailPageUrl = (sty_cd.substring(4, 7) === '610') //유모차는 별도 링크 사용하는 것으로 파악됨
    ? `https://item.nextmom.co.kr/magaline_img/goods/aga_stroller/${sty_cd}_1.png`
    : `${baseUrl}/${style_color}.jpg`;

  return [
    { title: "썸네일", url: `${baseUrl}/thumb/${style_color}.jpg` },
    { title: "상세페이지", url: detailPageUrl },
    { title: "모델핏", url: modelUrl },
    { title: "사이즈표", url: `${baseUrl}/agabang_bottom_new.jpg` }
  ];
}

if (br_cd == "79") {
  return [
    { title: "썸네일", url: `https://item.nextmom.co.kr/magaline_img/goods/agabang/${year}/thumb/${style_color}.jpg` },
    { title: "상세페이지", url: `https://item.nextmom.co.kr/magaline_img/goods/agabang/${year}/${style_color}.jpg` },
    { title: "모델핏", url: `https://item.nextmom.co.kr/magaline_img/goods/agabang/${year}/disney_model_${season_category}.jpg` },
    { title: "사이즈표", url: `https://item.nextmom.co.kr/magaline_img/goods/agabang/${year}/agabang_bottom_new.jpg` }
  ];
}

// fallback
console.error(`브랜드 코드 [${br_cd}]에 해당하는 이미지 경로가 없습니다.`);
return [];