function transformKeys(data) {
  return data.map(item => {
    const newItem = {};
    Object.keys(item).forEach(key => {
      // 정규식을 사용하여 괄호 안의 영어 부분 추출
      const match = key.match(/\(([^)]+)\)$/);
      if (match) {
        const newKey = match[1]; // 괄호 안의 영어 부분
        newItem[newKey] = item[key];
      } else {
        // 괄호가 없으면 원래 키 사용
        newItem[key] = item[key];
      }
    });
    return newItem;
  });
}

// 테이블 데이터 가져오기 (테이블 컴포넌트 이름에 맞게 수정)
const tableDataValue = item_info_temp_data.value; 
const tableData = transformKeys(tableDataValue);
console.log(tableData)

// 중복 sty_cd 확인
const styCdMap = {};
const result = [];

// 스타일 중복 및 카테고리 검증
tableData.forEach(row => {
  const styNo = row.sty_cd;
  const category = row.cat_nm;

  // sty_cd 중복 여부 확인
  if (styCdMap[styNo]) {
    result.push({
      "sty_no": styNo,
      "msg": "같은 스타일이 여러개 있습니다."
    });
  } else {
    styCdMap[styNo] = true;
  }

  // category가 keywords 목록에 없는 경우
  if (!variable1.value.keywords.includes(category)) {
    result.push({
      "sty_no": styNo,
      "msg": `'${category}' 는 없는 카테고리입니다.`
    });
  }
  
});

// 결과 출력
return result;