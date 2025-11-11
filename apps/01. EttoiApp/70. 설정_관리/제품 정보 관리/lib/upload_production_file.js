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
  const targetSheetName = "진행";

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
    range: "A1:FZ1000", // A1에서 FZ1000 범위만 지정 (필요한 열 개수에 맞게 설정)
  });

  let headerRowIndex = -1;
  for (let i = 0; i < jsonData.length; i++) {
    console.log(`jsonData[${i}] : --${jsonData[i]}--`)
    if (jsonData[i].includes('STY NO')) {
      headerRowIndex = i;
      break;
    }
  }

  if (headerRowIndex === -1) {
    console.error("'STY NO' 헤더를 찾을 수 없습니다.");
    utils.showNotification({
      title: '"STY NO" 헤더를 찾을 수 없습니다.',
      description: `엑셀 파일에 'STY NO' 헤더가 포함되어 있는지 확인해주세요.`,
      notificationType: 'error',
      duration: 30000
    });
    return;
  }

  const headerRow = jsonData[headerRowIndex];
  const desiredHeaders = ['STY NO', '카테고리', '아이템', '상품명', '품평NO', '성별', '소재', '생산지', '납기', '조정납기', '품평의견', '디자이너', '품평점수', '품평등급', '컨셉', '상태', '강제시즌', '칼라1', '칼라1수량', '칼라2', '칼라2수량', '칼라3', '칼라3수량', '칼라4', '칼라4수량', '칼라5', '칼라5수량', '판가', '판가검토', '2nd원가(V-)', '샘플원가(-V)'];
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
      notificationType: 'error',
      duration: 30000
    });
    return; // 처리 중단
  }

  // 누락된 헤더가 있으면 경고만 표시 (처리는 계속)
  if (warningMessages.length > 0) {
    utils.showNotification({
      title: '헤더 확인 요청',
      description: warningMessages.join('\n\n'),
      notificationType: 'warning',
      duration: 30000
    });
  }

  const dataRows = jsonData.slice(headerRowIndex + 1);

  // STY NO 중복 여부를 확인하기 위해 카운트 맵 생성
  const styNoCount = {};
  dataRows.forEach(row => {
    const styNo = row[columnIndices['STY NO']] ? row[columnIndices['STY NO']].trim() : '';
    if (styNo) {
      styNoCount[styNo] = (styNoCount[styNo] || 0) + 1;
    }
  });

  let unmappedItems = []; // 매핑되지 않은 항목들 추적

  let data = dataRows.map((row, idx) => {
    const rowData = {};

    if (row[8] != '07R776406' && row[8] != '07R084411') {
      // console.log(rowData)
      //return null
    }
    
    for (const header of desiredHeaders) {
      const index = columnIndices[header];
      rowData[header] = index !== undefined ? row[index]?.trim() : '';

      if (row[8] == '07S125004') {
        //  console.log(header)
        //  console.log(index)
        //  console.log(row[index])
        //  console.log("====")
      }
    }

    if (rowData['STY NO'] == '07S125004') {
      //  console.log(rowData)
    }

    // 'STY NO' 값이 빈 경우 제외
    if (rowData['STY NO'].trim() === '') {
      return null;
    }

    // '상태' 값이 'RE'인 경우, 중복된 'STY NO'만 제외
    if (rowData['상태'].trim() === 'RE' && styNoCount[rowData['STY NO']] > 1) {
      return null;
    }

    // '상태' 값이 'REORDER'인 경우, 중복된 'STY NO'만 제외
    if (rowData['상태'].trim() === 'REORDER' && styNoCount[rowData['STY NO']] > 1) {
      return null;
    }

    // '상태' 값이 'SPOT'인 경우, 중복된 'STY NO'만 제외
    if (rowData['상태'].trim() === 'SPOT' && styNoCount[rowData['STY NO']] > 1) {
      return null;
    }

    // '상태' 값이 '추가'인 경우, 중복된 'STY NO'만 제외
    if (rowData['상태'].trim() === '추가' && styNoCount[rowData['STY NO']] > 1) {
      return null;
    }

    // '상태' 값이 'RE'인 경우, 중복된 'STY NO'만 제외
    if (rowData['컨셉'].trim() === 'RE' && styNoCount[rowData['STY NO']] > 1) {
      return null;
    }

    // item_code (STY NO의 4번째 문자) 추출
    const itemCode = rowData['STY NO'].substring(4, 5);
    rowData['브랜드코드'] = rowData['STY NO'].substring(0, 2);
    
    // 카테고리와 item_code를 기반으로 id와 cat_nm 가져오기
    let matchedCategory = null;
    for (let i = 0; i < categoryData.id.length; i++) {
      const originCatArray = categoryData.origin_cat_nm[i];
      const categoryItemCode = categoryData.item_code[i];

      if (originCatArray.includes(rowData['카테고리']) && categoryItemCode === itemCode) {
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
        'STY NO': rowData['STY NO'],
        품명: rowData['상품명'] || rowData['아이템'] || '', // 품명 정보 추가
        카테고리: rowData['카테고리'],
        itemCode: itemCode,
        rowIndex: idx + headerRowIndex + 2 // Excel 행 번호 (1부터 시작, 헤더 다음)
      });
    }

    return rowData;
  }).filter(row => row !== null);


     // === 매핑카테고리ID 오류 검사 ===  
 
  if (unmappedItems.length > 0) {
    // 오류 예시 (최대 10개) - 행번호, STY NO, 카테고리, 5번째 코드 표시
    const examples = unmappedItems.slice(0, 10).map((item) => {
      const sty = item['STY NO'];
      const cat = item.카테고리;
      const code = item.itemCode;
      return `행 ${item.rowIndex}: STY NO ${sty} (카테고리="${cat}", 코드=${code})`;
    });

    let unmappedErrorMessage = `품번 5번째 코드와 카테고리명이 매칭되지 않습니다.\n`;
    unmappedErrorMessage += `총 ${unmappedItems.length}개 품번에 오류가 있습니다.\n`;
    unmappedErrorMessage += `오류 예시:\n- ${examples.join('\n- ')}\n\n`;
    unmappedErrorMessage += `| !! 해결방법!! 메인 화면 → '어떻게 사용하나요?' → 사용설명서 참고`;

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
    notificationType: 'error',
    duration: 30000
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
//    const targetSheetName = "진행";

//    if (!workbook.SheetNames.includes(targetSheetName)) {
//      console.error(`시트 "${targetSheetName}"을(를) 찾을 수 없습니다.`);
//      throw new Error(`시트 "${targetSheetName}"을(를) 찾을 수 없습니다.`);
//    }

//    const worksheet = workbook.Sheets[targetSheetName];
//    const jsonData = XLSX.utils.sheet_to_json(worksheet, {
//      header: 1,
//      defval: '',
//      raw: false,
//      range: "A1:FZ1000", // A1에서 Z1000 범위만 지정 (필요한 열 개수에 맞
//    });

//    let headerRowIndex = -1;
//    for (let i = 0; i < jsonData.length; i++) {
//      if (jsonData[i].includes('STY NO')) {
//        headerRowIndex = i;
//        break;
//      }
//    }

//    if (headerRowIndex === -1) {
//      console.error("'STY_NO' 헤더를 찾을 수 없습니다.");
//      throw new Error("'STY_NO' 헤더를 찾을 수 없습니다.");
//    }

//    const headerRow = jsonData[headerRowIndex];
//    const desiredHeaders = ['STY NO', '카테고리', '아이템', '상품명', '품평NO', '성별', '소재', '생산지', '납기', '조정납기', '품평의견', '디자이너', '품평점수', '품평등급', '컨셉', '상태', '강제시즌', '칼라1', '칼라1수량', '칼라2', '칼라2수량', '칼라3', '칼라3수량', '칼라4', '칼라4수량', '칼라5', '칼라5수량', '판가', '판가검토','2nd원가(V-)','샘플원가(-V)'];
//    const columnIndices = {};

//    //  for (let i = 0; i < headerRow.length; i++) {
//    //    let header = headerRow[i].replace(/[\r\n]+/g, '');
//    //    if (desiredHeaders.includes(header)) {
//    //      columnIndices[header] = i;
//    //    }
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

//  //  if (duplicateHeaders.size > 0) {
//  //    utils.showNotification({
//  //      title: '중복 헤더 감지됨',
//  //      description: `다음 헤더가 중복되어 있습니다: ${[...duplicateHeaders].join(', ')}`,
//  //      notificationType: 'warning'
//  //    });
//  //  }

//  //    const missingHeaders = desiredHeaders.filter(header => !(header in columnIndices));
//  //    if (missingHeaders.length > 0) {
//  //      const missingHeadersMessage = `다음 헤더를 찾을 수 없습니다: ${missingHeaders.join(', ')}`;
  
//  //      // Retool 토스트 알림으로 표시
//  //      utils.showNotification({
//  //        title: '헤더 누락 경고',
//  //        description: missingHeadersMessage,
//  //        notificationType: 'error' // warning, info, error, success 중 하나 선택
//  //      });
//  //    }

//    const dataRows = jsonData.slice(headerRowIndex + 1);

//    // STY NO 중복 여부를 확인하기 위해 카운트 맵 생성
//    const styNoCount = {};
//    dataRows.forEach(row => {
//      const styNo = row[columnIndices['STY NO']] ? row[columnIndices['STY NO']].trim() : '';
//      if (styNo) {
//        styNoCount[styNo] = (styNoCount[styNo] || 0) + 1;
//      }
//    });

//    let data = dataRows.map(row => {
//      const rowData = {};

//      if (row[8] != '07R776406' && row[8] != '07R084411'){
//        // console.log(rowData)
//        //return null
//      }
    
//      for (const header of desiredHeaders) {
//        const index = columnIndices[header];
//        rowData[header] = index !== undefined ? row[index] : '';

//        if ( row[8] == '07S125004') {
//          //  console.log(header)
//          //  console.log(index)
//          //  console.log(row[index])
//          //  console.log("====")
//        }
//      }

//      if (rowData['STY NO'] == '07S125004'){
//        //  console.log(rowData)
//      }

//      // 'STY NO' 값이 빈 경우 제외
//      if (rowData['STY NO'].trim() === '') {
//        return null;
//      }

//      // '상태' 값이 'RE'인 경우, 중복된 'STY NO'만 제외
//      if (rowData['상태'].trim() === 'RE' && styNoCount[rowData['STY NO']] > 1) {
//        return null;
//      }

//      // '상태' 값이 'REORDER'인 경우, 중복된 'STY NO'만 제외
//      if (rowData['상태'].trim() === 'REORDER' && styNoCount[rowData['STY NO']] > 1) {
//        return null;
//      }

//      // '상태' 값이 'SPOT'인 경우, 중복된 'STY NO'만 제외
//      if (rowData['상태'].trim() === 'SPOT' && styNoCount[rowData['STY NO']] > 1) {
//        return null;
//      }

//      // '상태' 값이 '추가'인 경우, 중복된 'STY NO'만 제외
//      if (rowData['상태'].trim() === '추가' && styNoCount[rowData['STY NO']] > 1) {
//        return null;
//      }

//      // '상태' 값이 'RE'인 경우, 중복된 'STY NO'만 제외
//      if (rowData['컨셉'].trim() === 'RE' && styNoCount[rowData['STY NO']] > 1) {
//        return null;
//      }


//      // item_code (STY NO의 4번째 문자) 추출
//      const itemCode = rowData['STY NO'].substring(4, 5);
//      rowData['브랜드코드'] = rowData['STY NO'].substring(0, 2)
    
//      // 카테고리와 item_code를 기반으로 id와 cat_nm 가져오기
//      let matchedCategory = null;
//      for (let i = 0; i < categoryData.id.length; i++) {
//        const originCatArray = categoryData.origin_cat_nm[i];
//        const categoryItemCode = categoryData.item_code[i];

//        if (originCatArray.includes(rowData['카테고리']) && categoryItemCode === itemCode) {
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

//    //console.log(data);

//    production_temp_data.setValue(data);
//    steppedContainer2.setCurrentView('Step 3');

//  } catch (error) {
//    console.error("XLSX 파일을 파싱하는 중 오류가 발생했습니다:", error);
//    throw new Error("XLSX 파일을 파싱할 수 없습니다.");
//  }