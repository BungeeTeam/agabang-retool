// get_item_id_category 쿼리 결과를 temporary state에 저장
const categoryData = get_item_id_category.data;

// 파일 확인 및 처리 시작
const uploadedFiles = fileDropzone3.value;

if (!uploadedFiles || uploadedFiles.length === 0) {
  console.log('파일이 업로드 되지 않았습니다');
  utils.showNotification({
    title: '파일 업로드 필요',
    description: '엑셀 파일을 먼저 업로드해주세요.',
    notificationType: 'warning',
    duration: 30000
  });
  return;
}

// 파일을 읽기 위한 Blob 생성
const file = uploadedFiles[0];
const reader = new FileReader();

// xlsx 데이터를 ArrayBuffer로 변환
const binaryString = atob(file.base64Data);
const len = binaryString.length;
const bytes = new Uint8Array(len);

for (let i = 0; i < len; i++) {
  bytes[i] = binaryString.charCodeAt(i);
}

try {
  const workbook = XLSX.read(bytes.buffer, { type: 'array' });
  const targetSheetName = "기획현황";

  if (!workbook.SheetNames.includes(targetSheetName)) {
    console.error(`시트 "${targetSheetName}"을(를) 찾을 수 없습니다.`);
    
    const availableSheets = workbook.SheetNames.join(', ');
    utils.showNotification({
      title: `"${targetSheetName}" 시트를 찾을 수 없습니다.`,
      description: `현재 파일의 시트명: ${availableSheets} → "${targetSheetName}"으로 변경해주세요.`,
      notificationType: 'error',
      duration: 30000
    });
    return;
  }

  const worksheet = workbook.Sheets[targetSheetName];
  const jsonData = XLSX.utils.sheet_to_json(worksheet, {
    header: 1,
    defval: '',
    raw: false,
    range: "A1:FZ1000", // A1에서 Z1000 범위만 지정 (필요한 열 개수에 맞게 설정)
  });

  let headerRowIndex = -1;
  for (let i = 0; i < jsonData.length; i++) {
    console.log(`jsonData[${i}] : --${jsonData[i]}--` )
    if (jsonData[i].includes(' 품번 ') || jsonData[i].includes('품번')) {
      headerRowIndex = i;
      break;
    }
  }
  
  if (headerRowIndex === -1) {
    console.error("'품번' 헤더를 찾을 수 없습니다.");
    utils.showNotification({
      title: '"품번" 헤더를 찾을 수 없습니다.',
      description: `엑셀 파일에 '품번' 헤더가 포함되어 있는지 확인해주세요.`,
      notificationType: 'error',
      duration: 30000
    });
    return;
  }

  const headerRow = jsonData[headerRowIndex];
  const desiredHeaders = ['품번','품평번호','품평점수','품평등급','품평의견', '소재세부','성별','대분류','중분류','소분류','예상TAG가(원)','확정TAG가(원)','디자이너','MD제안납기','확정납기','색상','기획량'];
  const columnIndices = {};

  // === 헤더 중복 검사 개선 ===
  const seenHeaders = new Set();
  const duplicateHeaders = new Set();
  const headerPositions = {}; // 각 헤더의 위치 정보 저장

  for (let i = 0; i < headerRow.length; i++) {
    let header = headerRow[i].replace(/[\r\n]+/g, '').trim();
    
    // 헤더 위치 정보 저장
    if (!headerPositions[header]) {
      headerPositions[header] = [];
    }
    headerPositions[header].push(i + 1); // Excel 열 번호 (1부터 시작)
    
    if (seenHeaders.has(header)) {
      duplicateHeaders.add(header);
    } else {
      seenHeaders.add(header);
    }

    if (desiredHeaders.includes(header)) {
      columnIndices[header] = i; // 가장 마지막 항목이 저장됨
    }
  }

  const missingHeaders = desiredHeaders.filter(header => !(header in columnIndices));

  // === 오류 메시지 수집 ===
  const errorMessages = [];
  const warningMessages = [];
  const referencedDuplicates = [...duplicateHeaders].filter(header => desiredHeaders.includes(header));

  if (referencedDuplicates.length > 0) {
    let duplicateDetails = referencedDuplicates.map(header => {
      const positions = headerPositions[header];
      const columnLetters = positions.map(pos => {
        // 숫자를 Excel 열 문자로 변환 (A, B, C...)
        let letter = '';
        let num = pos;
        while (num > 0) {
          num--;
          letter = String.fromCharCode(65 + (num % 26)) + letter;
          num = Math.floor(num / 26);
        }
        return letter;
      });
      return `"${header}" (${columnLetters.join(', ')}열)`;
    });
    
    errorMessages.push(`❌ 중복된 헤더가 있습니다:\n${duplicateDetails.join('\n')}\n→ 중복된 헤더를 제거하거나 이름을 변경해주세요.`);
  }

  if (missingHeaders.length > 0) {
    warningMessages.push(`⚠️ 누락된 헤더가 있습니다:\n${missingHeaders.join(', ')}\n→ 의도된 것이 아니라면 해당 헤더들을 확인해주세요.`);
  }

  // 중복 헤더가 있으면 처리 중단 (이건 반드시 수정해야 함)
  if (errorMessages.length > 0) {
    utils.showNotification({
      title: '엑셀 파일 수정 필요',
      description: errorMessages.join('\n\n'),
      notificationType: 'error'
    });
    return; // 처리 중단
  }

  // 누락된 헤더가 있으면 경고만 표시 (처리는 계속)
  if (warningMessages.length > 0) {
    utils.showNotification({
      title: '헤더 확인 요청',
      description: warningMessages.join('\n\n'),
      notificationType: 'warning'
    });
  }

  const dataRows = jsonData.slice(headerRowIndex + 1);

  // STY NO 중복 여부를 확인하기 위해 카운트 맵 생성
  const styNoCount = {};
  dataRows.forEach(row => {
    const styNo = row[columnIndices['품번']] ? row[columnIndices['품번']].trim() : '';
    if (styNo) {
      styNoCount[styNo] = (styNoCount[styNo] || 0) + 1;
    }
  });

  let alreadyStyCds = []
  let unmappedItems = []; // 매핑되지 않은 항목들 추적

  let data = dataRows.map((row, idx) => {
    const rowData = {};

    const nextDatas = new Array(dataRows.length - (idx+1)).fill().map(()=>{return {}});

    for (const header of desiredHeaders) {
      const index = columnIndices[header];
      rowData[header] = index !== undefined ? row[index]?.trim() : '';

      // 중복되는 sty_cd의 컬러값을 가져 오기 위해 현재 이후 데이터를 모두 가져옴
      for(let _idx=0; _idx<(nextDatas.length); ++_idx){
        let next_idx = idx+(_idx+1)
        if(next_idx < dataRows.length ){
          nextDatas[_idx][header] = index !== undefined ? dataRows[next_idx][index]?.trim() : '';
        }
      }
    }

    // 'STY NO' 값이 빈 경우 제외
    if (rowData['품번'].trim() === '') {
      return null;
    }
    
    const findData = alreadyStyCds.find(ele => {
      return ele === rowData['품번']
    })

    if(findData) return

    for(let init_pos=2; init_pos<=5; init_pos++){
      rowData[`색상${init_pos}`]='';
      rowData[`기획량${init_pos}`]='';
    }

    // 품평번호들을 저장할 배열 초기화
    const previewCodes = [rowData['품평번호']]; // 첫 번째 품평번호

    let color_pos = 2
    for(let _idx=0; _idx<nextDatas.length; ++_idx){
      let _next_data = nextDatas[_idx]
      if(_next_data['품번'] === rowData['품번']){
        const findData = alreadyStyCds.find(ele => {
          return ele === rowData['품번']
        })
        if(!findData){
          alreadyStyCds.push(rowData['품번'])
        }

        rowData[`색상${color_pos}`] = _next_data[`색상`]
        rowData[`기획량${color_pos}`] = _next_data[`기획량`]

        // 해당 색상의 품평번호를 배열에 추가
        if(_next_data['품평번호']) {
          previewCodes.push(_next_data['품평번호']);
        }

        color_pos++;
        if(color_pos>5){
          break;
        }
      }
    }

    // 품평번호들을 /로 연결하여 저장
    rowData['품평번호'] = previewCodes.filter(code => code && code.trim() !== '').join('/');

    // item_code (STY NO의 4번째 문자) 추출
    const itemCode = rowData['품번']?.trim().substring(4, 5);
    rowData['브랜드코드'] = var_brand_code.value

    // 카테고리와 item_code를 기반으로 id와 cat_nm 가져오기
    let matchedCategory = null;
    for (let i = 0; i < categoryData.id.length; i++) {
      const originCatArray = categoryData.origin_cat_nm[i];
      const categoryItemCode = categoryData.item_code[i];

      if (originCatArray.includes(rowData['대분류']?.trim()) && categoryItemCode === itemCode) {
        matchedCategory = {
          id: categoryData.id[i],
          cat_nm: categoryData.cat_nm[i]
        };
        break; // 첫 번째 매치를 찾으면 중단
      }
    }

    if (matchedCategory) {
      rowData['매핑카테고리ID'] = matchedCategory.id;
      rowData['매핑카테고리'] = matchedCategory.cat_nm;
    } else {
      rowData['매핑카테고리ID'] = null;
      rowData['매핑카테고리'] = null;
      
      // === 매핑되지 않은 항목 추적 ===
      unmappedItems.push({
        품번: rowData['품번'],
        품명: rowData['중분류'] || rowData['소분류'] || '', // 품명 정보 추가
        대분류: rowData['대분류'],
        itemCode: itemCode,
        rowIndex: idx + headerRowIndex + 2 // Excel 행 번호 (1부터 시작, 헤더 다음)
      });
    }

    return rowData;
  }).filter(row => row !== null);

   // === 매핑카테고리ID 오류 검사 ===  
  
  if (unmappedItems.length > 0) {
    // 처음 3개 오류 항목을 예시로 사용
    const exampleCodes = unmappedItems.slice(0, 3).map(item => item.품번);

    let unmappedErrorMessage = `대분류코드와 대분류명이 매칭되지 않습니다.\n`;
    unmappedErrorMessage += `총 ${unmappedItems.length}개 품번에 오류가 있습니다.\n`;
    unmappedErrorMessage += `오류 예시: ${exampleCodes.join(', ')}\n\n`;
    unmappedErrorMessage += `| !! 해결방법!! `;
    unmappedErrorMessage += `메인 화면 → '어떻게 사용하나요?' → 사용설명서 참고`;

    utils.showNotification({
      title: '엑셀 파일 수정 필요',
      description: unmappedErrorMessage,
      notificationType: 'error',
      duration: 30000
    });
    return; // 처리 중단
  }

  // 모든 검증을 통과한 경우에만 데이터 저장
  production_temp_data.setValue(data);
  steppedContainer2.setCurrentView('Step 3');

  // 성공 메시지
  utils.showNotification({
    title: '파일 처리 완료',
    description: `${data.length}개의 데이터가 성공적으로 처리되었습니다.`,
    notificationType: 'success'
  });

} catch (error) {
  console.error("XLSX 파일을 파싱하는 중 오류가 발생했습니다:", error);
  
  utils.showNotification({
    title: '파일 처리 오류',
    description: `파일을 파싱할 수 없습니다: ${error.message}`,
    notificationType: 'error'
  });
  
  throw new Error("XLSX 파일을 파싱할 수 없습니다.");
}


//  // get_item_id_category 쿼리 결과를 temporary state에 저장
//  const categoryData = get_item_id_category.data;

//  // 파일 확인 및 처리 시작
//  const uploadedFiles = fileDropzone3.value;

//  if (!uploadedFiles || uploadedFiles.length === 0) {
//    console.log('파일이 업로드 되지 않았습니다');
//    return;
//  }

//  // 파일을 읽기 위한 Blob 생성
//  const file = uploadedFiles[0];
//  const reader = new FileReader();

//  // xlsx 데이터를 ArrayBuffer로 변환
//  const binaryString = atob(file.base64Data);
//  const len = binaryString.length;
//  const bytes = new Uint8Array(len);

//  for (let i = 0; i < len; i++) {
//    bytes[i] = binaryString.charCodeAt(i);
//  }

//  try {
//    const workbook = XLSX.read(bytes.buffer, { type: 'array' });
//    const targetSheetName = "기획현황";

//    if (!workbook.SheetNames.includes(targetSheetName)) {
//      console.error(`시트 "${targetSheetName}"을(를) 찾을 수 없습니다.`);
//      throw new Error(`시트 "${targetSheetName}"을(를) 찾을 수 없습니다.`);
//    }

//    const worksheet = workbook.Sheets[targetSheetName];
//    const jsonData = XLSX.utils.sheet_to_json(worksheet, {
//      header: 1,
//      defval: '',
//      raw: false,
//      range: "A1:FZ1000", // A1에서 Z1000 범위만 지정 (필요한 열 개수에 맞게 설정)
//    });

//    let headerRowIndex = -1;
//    for (let i = 0; i < jsonData.length; i++) {
//      console.log(`jsonData[${i}] : --${jsonData[i]}--` )
//      if (jsonData[i].includes(' 품번 ') || jsonData[i].includes('품번')) {
//        headerRowIndex = i;
//        break;
//      }
//    }
  
//    if (headerRowIndex === -1) {
//      console.error("'품번' 헤더를 찾을 수 없습니다.");
//      throw new Error("'품번' 헤더를 찾을 수 없습니다.");
//    }

//    const headerRow = jsonData[headerRowIndex];
//    const desiredHeaders = ['품번','품평번호','품평점수','품평등급','품평의견', '소재세부','성별','대분류','중분류','소분류','예상TAG가(원)','확정TAG가(원)','디자이너','MD제안납기','확정납기','색상','기획량'];
//    const columnIndices = {};

//    //  for (let i = 0; i < headerRow.length; i++) {
//    //    let header = headerRow[i].replace(/[\r\n]+/g, '')?.trim();
//    //    //  console.log(`header : [${header}]`)
//    //    if (desiredHeaders.includes(header)) {
//    //      columnIndices[header] = i;
//    //    }
//    //  }

//    //  const missingHeaders = desiredHeaders.filter(header => !(header in columnIndices));
//    //  if (missingHeaders.length > 0) {
//    //    const missingHeadersMessage = `다음 헤더를 찾을 수 없습니다: ${missingHeaders.join(', ')}`;
  
//    //    // Retool 토스트 알림으로 표시
//    //    utils.showNotification({
//    //      title: '헤더 누락 경고',
//    //      description: missingHeadersMessage,
//    //      notificationType: 'error' // warning, info, error, success 중 하나 선택
//    //    });
//    //  }
//    const seenHeaders = new Set();
//  const duplicateHeaders = new Set();

//  for (let i = 0; i < headerRow.length; i++) {
//    let header = headerRow[i].replace(/[\r\n]+/g, '').trim();
  
//    if (seenHeaders.has(header)) {
//      duplicateHeaders.add(header);
//    } else {
//      seenHeaders.add(header);
//    }

//    if (desiredHeaders.includes(header)) {
//      columnIndices[header] = i; // 가장 마지막 항목이 저장됨
//    }
//  }
//    const missingHeaders = desiredHeaders.filter(header => !(header in columnIndices));

//  const alertMessages = [];

//  const referencedDuplicates = [...duplicateHeaders].filter(header => desiredHeaders.includes(header));

//  if (referencedDuplicates.length > 0) {
//    alertMessages.push(`중복된 헤더: ${referencedDuplicates.join(', ')}`);
//  }

//  if (missingHeaders.length > 0) {
//    alertMessages.push(` / 누락된 헤더: ${missingHeaders.join(', ')}`);
//  }

//  if (alertMessages.length > 0) {
//    utils.showNotification({
//      title: '헤더 확인 필요',
//      description: alertMessages.join('\n'),
//      notificationType: 'error'
//    });
//  }
//    const dataRows = jsonData.slice(headerRowIndex + 1);

//    // STY NO 중복 여부를 확인하기 위해 카운트 맵 생성
//    const styNoCount = {};
//    dataRows.forEach(row => {
//      const styNo = row[columnIndices['품번']] ? row[columnIndices['품번']].trim() : '';
//      if (styNo) {
//        styNoCount[styNo] = (styNoCount[styNo] || 0) + 1;
//      }
//    });

//    let alreadyStyCds = []
//    let data = dataRows.map((row, idx) => {
//      const rowData = {};

//      const nextDatas = new Array(dataRows.length - (idx+1)).fill().map(()=>{return {}});

//      for (const header of desiredHeaders) {
//        const index = columnIndices[header];
//        rowData[header] = index !== undefined ? row[index]?.trim() : '';

//        // 중복되는 sty_cd의 컬러값을 가져 오기 위해 현재 이후 데이터를 모두 가져옴
//        for(let _idx=0; _idx<(nextDatas.length); ++_idx){
//          let next_idx = idx+(_idx+1)
//          if(next_idx < dataRows.length ){
//            nextDatas[_idx][header] = index !== undefined ? dataRows[next_idx][index]?.trim() : '';
//          }
//        }
//      }

//      // 'STY NO' 값이 빈 경우 제외
//      if (rowData['품번'].trim() === '') {
//        return null;
//      }
    
//      const findData = alreadyStyCds.find(ele => {
//        return ele === rowData['품번']
//      })

//      if(findData) return

//      for(let init_pos=2; init_pos<=5; init_pos++){
//        rowData[`색상${init_pos}`]='';
//        rowData[`기획량${init_pos}`]='';
//      }

//      // 품평번호들을 저장할 배열 초기화
//      const previewCodes = [rowData['품평번호']]; // 첫 번째 품평번호

//      let color_pos = 2
//      for(let _idx=0; _idx<nextDatas.length; ++_idx){
//        let _next_data = nextDatas[_idx]
//        if(_next_data['품번'] === rowData['품번']){
//          const findData = alreadyStyCds.find(ele => {
//            return ele === rowData['품번']
//          })
//          if(!findData){
//            alreadyStyCds.push(rowData['품번'])
//          }

//          rowData[`색상${color_pos}`] = _next_data[`색상`]
//          rowData[`기획량${color_pos}`] = _next_data[`기획량`]

//          // 해당 색상의 품평번호를 배열에 추가
//          if(_next_data['품평번호']) {
//            previewCodes.push(_next_data['품평번호']);
//          }

//          color_pos++;
//          if(color_pos>5){
//            break;
//          }
//        }
//      }

//      // 품평번호들을 /로 연결하여 저장
//      rowData['품평번호'] = previewCodes.filter(code => code && code.trim() !== '').join('/');

//      // item_code (STY NO의 4번째 문자) 추출
//      //  const itemCode = rowData['STY NO'].substring(4, 5);
//      const itemCode = rowData['품번']?.trim().substring(4, 5);
//      //  rowData['브랜드코드'] = rowData['품번'].substring(0, 2)
//      rowData['브랜드코드'] = var_brand_code.value

//      // 카테고리와 item_code를 기반으로 id와 cat_nm 가져오기
//      let matchedCategory = null;
//      for (let i = 0; i < categoryData.id.length; i++) {
//        const originCatArray = categoryData.origin_cat_nm[i];
//        const categoryItemCode = categoryData.item_code[i];

//        //  if (originCatArray.includes(rowData['카테고리']) && categoryItemCode === itemCode) {
//        if (originCatArray.includes(rowData['대분류']?.trim()) && categoryItemCode === itemCode) {
//          matchedCategory = {
//            id: categoryData.id[i],
//            cat_nm: categoryData.cat_nm[i]
//          };
//        }
//      }

//      if (matchedCategory) {
//        rowData['매핑카테고리ID'] = matchedCategory.id;
//        rowData['매핑카테고리'] = matchedCategory.cat_nm;
//      } else {
//        rowData['매핑카테고리ID'] = null;
//        rowData['매핑카테고리'] = null;
//      }

//      return rowData;
//    }).filter(row => row !== null);

//    //  console.log(data);

//    production_temp_data.setValue(data);
//    steppedContainer2.setCurrentView('Step 3');

//  } catch (error) {
//    console.error("XLSX 파일을 파싱하는 중 오류가 발생했습니다:", error);
//    throw new Error("XLSX 파일을 파싱할 수 없습니다.");
//  }