// production_temp_data에서 데이터를 가져옵니다.
const data = production_temp_data.value;

// 엑셀 필드와 데이터베이스 필드의 매핑을 정의합니다.
const mappings = {
  '브랜드코드': 'br_cd',
  'STY NO': 'sty_cd',
  '소재': 'fabric',
  '생산지': 'prod_country',
  '납기': 'deli_dt',
  '조정납기': 'adj_deli_dt',
  '디자이너': 'designer_nm',
  '품평점수': 'preview_score',
  '품평등급': 'preview_grade',
  '품평의견': 'opinion',
  '아이템': 'item_raw_nm',
  '성별': 'sex_nm',
  '카테고리': 'cat_raw_nm',
  '품평NO': 'preview_cd',
  '컨셉': 'concept',
  '매핑카테고리ID': 'item_md_category_id',
  '매핑카테고리': 'cat_nm',
  '상태': 'status',
  '칼라1': 'color_1_nm',
  '칼라1수량': 'color_1_qty',
  '칼라2': 'color_2_nm',
  '칼라2수량': 'color_2_qty',
  '칼라3': 'color_3_nm',
  '칼라3수량': 'color_3_qty',
  '칼라4': 'color_4_nm',
  '칼라4수량': 'color_4_qty',
  '칼라5': 'color_5_nm',
  '칼라5수량': 'color_5_qty',
  '판가': 'sale_price',
  '판가검토': 'sale_price_final',
  '2nd원가(V-)': 'cost_price_final',
  '샘플원가(-V)': 'cost_price'
};

// 필드별 데이터 타입 정의
const fieldTypes = {
  'sale_price': 'Int32',
  'sale_price_final': 'Int32',
  'cost_price': 'Int32',
  'cost_price_final': 'Int32',
  'item_md_category_id': 'Int32',
  'color_1_qty': 'Int32',
  'color_2_qty': 'Int32',
  'color_3_qty': 'Int32',
  'color_4_qty': 'Int32',
  'color_5_qty': 'Int32',
  'preview_score': 'Float32',
  'adj_deli_dt': 'Date',
  'deli_dt': 'Date'
};

// 행 식별 정보 생성 함수
const getRowIdentifier = (row) => {
  const styNo = row['STY NO'] ? String(row['STY NO']).trim() : '';
  const itemNm = row['아이템'] ? String(row['아이템']).trim() : '';
  
  if (styNo) {
    return itemNm ? `STY NO: ${styNo} (${itemNm})` : `STY NO: ${styNo}`;
  } else {
    return itemNm ? `아이템: ${itemNm}` : 'STY NO 없음';
  }
};

// 데이터 검증 함수들
const validators = {
  Int32: (value, fieldName, row) => {
    if (value === null || value === undefined || value === '') return { valid: true };
    
    const numValue = Number(value);
    if (isNaN(numValue) || !Number.isInteger(numValue)) {
      return {
        valid: false,
        error: `[${getRowIdentifier(row)}] '${fieldName}' 필드: '${value}'는 숫자가 아닙니다. 숫자로 입력해주세요.`
      };
    }
    
    if (numValue < -2147483648 || numValue > 2147483647) {
      return {
        valid: false,
        error: `[${getRowIdentifier(row)}] '${fieldName}' 필드: '${value}'는 범위를 벗어났습니다. (-2,147,483,648 ~ 2,147,483,647 범위 내로 입력해주세요)`
      };
    }
    
    return { valid: true };
  },
  
  Float32: (value, fieldName, row) => {
    if (value === null || value === undefined || value === '') return { valid: true };
    
    const numValue = Number(value);
    if (isNaN(numValue)) {
      return {
        valid: false,
        error: `[${getRowIdentifier(row)}] '${fieldName}' 필드: '${value}'는 숫자가 아닙니다. 숫자로 입력해주세요.`
      };
    }
    
    return { valid: true };
  },
  
  Date: (value, fieldName, row) => {
    if (value === null || value === undefined || value === '') return { valid: true };
    
    // MM/DD 형식 처리
    const dateParts = value.split('/');
    if (dateParts.length === 2) {
      const month = parseInt(dateParts[0]);
      const day = parseInt(dateParts[1]);
      
      if (month < 1 || month > 12) {
        return {
          valid: false,
          error: `[${getRowIdentifier(row)}] '${fieldName}' 필드: 월은 1-12 사이여야 합니다. (현재값: ${month})`
        };
      }
      
      if (day < 1 || day > 31) {
        return {
          valid: false,
          error: `[${getRowIdentifier(row)}] '${fieldName}' 필드: 일은 1-31 사이여야 합니다. (현재값: ${day})`
        };
      }
      
      const testDate = new Date(2024, month - 1, day);
      if (testDate.getMonth() !== month - 1 || testDate.getDate() !== day) {
        return {
          valid: false,
          error: `[${getRowIdentifier(row)}] '${fieldName}' 필드: '${value}'는 유효하지 않은 날짜입니다. MM/DD 형식으로 입력해주세요.`
        };
      }
      
      return { valid: true };
    }
    
    // 다른 날짜 형식 처리
    const dateObj = new Date(value);
    if (isNaN(dateObj.getTime())) {
      return {
        valid: false,
        error: `[${getRowIdentifier(row)}] '${fieldName}' 필드: '${value}'는 유효하지 않은 날짜입니다. MM/DD 또는 표준 날짜 형식으로 입력해주세요.`
      };
    }
    
    return { valid: true };
  },
  
  String: (value, fieldName, row) => {
    // String 타입은 대부분 허용, 길이만 체크
    if (value && typeof value === 'string' && value.length > 1000) {
      return {
        valid: false,
        error: `[${getRowIdentifier(row)}] '${fieldName}' 필드: 텍스트가 너무 깁니다. (최대 1000자)`
      };
    }
    return { valid: true };
  }
};

// 데이터 검증 함수
const validateData = (data) => {
  const errors = [];
  
  data.forEach((row, rowIndex) => {
    if (!row) return;
    
    // 필수 필드 체크 (sty_cd)
    if (!row['STY NO'] || String(row['STY NO']).trim() === '') {
      errors.push(`[${getRowIdentifier(row)}] 'STY NO' 필드는 필수입니다.`);
      return; // STY NO가 없으면 해당 행은 더 이상 검증하지 않음
    }
    
    // 각 필드별 데이터 타입 검증
    for (const [excelField, dbField] of Object.entries(mappings)) {
      const fieldType = fieldTypes[dbField];
      if (!fieldType) continue; // 타입이 정의되지 않은 필드는 스킵
      
      let value = row[excelField];
      if (value !== null && value !== undefined) {
        value = String(value).trim();
        
        // 콤마 제거 (숫자 필드의 경우)
        if (['Int32', 'Float32'].includes(fieldType) && value.includes(',')) {
          value = value.replace(/,/g, '');
        }
        
        // 하이픈을 null로 처리
        if (value === '-') {
          value = null;
        }
      }
      
      const validator = validators[fieldType];
      if (validator) {
        const result = validator(value, excelField, row);
        if (!result.valid) {
          errors.push(result.error);
        }
      }
    }
  });
  
  return errors;
};

// INSERT 문에 사용할 필드 목록을 생성합니다.
const dbFields = Object.values(mappings);

// 각 행의 값을 저장할 배열을 초기화합니다.
const valuesList = [];

// sty_cd 중복 체크를 위한 Set
const seenStyCds = new Set();
// 중복된 sty_cd를 저장할 배열
const duplicateStyCdsInInput = [];

// 0.5초씩 쉬는 함수
const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));

try {
  // 데이터 검증 실행
  const validationErrors = validateData(data);
  
  if (validationErrors.length > 0) {
    // 오류가 있는 경우 사용자에게 알림
    const errorMessage = validationErrors.slice(0, 10).join('\n'); // 최대 10개 오류만 표시
    const additionalErrors = validationErrors.length > 10 ? `\n\n... 외 ${validationErrors.length - 10}개 오류` : '';
    
    utils.showNotification({
      title: '다음 오류를 수정 후 다시 업로드해주세요:',
      description: `${errorMessage}${additionalErrors}`,
      notificationType: 'error',
      duration: 30000 // 30초 동안 표시
    });
    
    console.error('검증 오류:', validationErrors);
    return; // 검증 실패 시 업로드 중단
  }

  // 데이터 처리를 시작합니다.
  data.forEach((row, index) => {
    // 각 필드의 값을 저장할 배열을 초기화합니다.
    const valueRow = [];
    let currentStyCd = null; // 현재 row의 sty_cd를 저장할 변수

    if (row) {
      // 각 매핑에 대해 값을 처리합니다.
      for (const [excelField, dbField] of Object.entries(mappings)) {
        let value = row[excelField] ? String(row[excelField]).trim() : null;

        // 'STY NO' 필드의 값을 미리 저장합니다.
        if (excelField === 'STY NO') {
          currentStyCd = value;
        }

        // '납기' 필드의 경우 날짜 형식을 변환합니다.
        if ((excelField === '납기' || excelField === '조정납기') && value) {
          let convertedDate = null;

          // 'MM/DD' 형식인지 확인합니다.
          const dateParts = value.split('/');
          if (dateParts.length === 2) {
            let month = dateParts[0].padStart(2, '0');
            let day = dateParts[1].padStart(2, '0');

            convertedDate = `2024-${month}-${day}`;
            // 날짜 유효성을 확인합니다.
            const dateObj = new Date(convertedDate);
            if (isNaN(dateObj.getTime())) {
              convertedDate = null;
            }
          } else {
            // 다른 형식의 날짜 처리
            const dateObj = new Date(value);
            if (!isNaN(dateObj.getTime())) {
              const year = dateObj.getFullYear();
              const month = (dateObj.getMonth() + 1).toString().padStart(2, '0');
              const day = dateObj.getDate().toString().padStart(2, '0');
              convertedDate = `${year}-${month}-${day}`;
            } else {
              convertedDate = null;
            }
          }

          value = convertedDate;
        }

        // '수량' 의 경우 콤마를 제거합니다.
        if ((excelField === '칼라1수량' || excelField === '칼라2수량' || excelField === '칼라3수량' || 
             excelField === '칼라4수량' || excelField === '칼라5수량' || excelField === '판가' || 
             excelField === '판가검토' || excelField === '샘플원가(-V)' || excelField === '2nd원가(V-)') && value) {
          if (value === '-') {
            value = null;
          } else if (value.indexOf(',') >= 0) {
            value = value.replace(/,/g, "");
          }
        }

        // 값이 있는 경우 작은따옴표를 이스케이프합니다.
        if (value !== null && value !== undefined) {
          value = value.replace(/'/g, "''");
          value = `'${value}'`;
        } else {
          value = 'NULL';
        }

        valueRow.push(value);
      }

      // 'STY_CD'가 NULL인 경우 해당 행을 건너뜁니다.
      if (valueRow[dbFields.indexOf('sty_cd')] === 'NULL') {
        console.warn(`Skipping row ${index + 1} due to NULL STY NO.`);
        return;
      }

      // STY_CD 중복 체크
      if (seenStyCds.has(currentStyCd)) {
        duplicateStyCdsInInput.push({
          sty_cd: currentStyCd,
          original_row_index: index + 1 // 원본 데이터에서의 행 번호
        });
        // 중복된 STY_CD를 가진 행은 valuesList에 추가하지 않습니다.
        console.error(`ERROR: Duplicate STY NO found in input data: '${currentStyCd}' at row ${index + 1}. This will cause 'command cannot affect row a second time' error.`);
        // 이 경우 해당 행을 건너뛰는 것이 오류를 방지하는 방법이 될 수 있습니다.
        // return; // 주석을 해제하면 중복된 행을 건너뜁니다.
      } else {
        seenStyCds.add(currentStyCd);
        valuesList.push(`(${valueRow.join(', ')})`);
      }
    }
  });

  // 디버깅 로그: 최종 valuesList의 길이와 중복된 STY_CD 목록
  console.log(`Final valuesList size: ${valuesList.length}`);
  if (duplicateStyCdsInInput.length > 0) {
    console.error('--- Detected Duplicate STY NOs in input data ---');
    duplicateStyCdsInInput.forEach(dup => {
      console.error(`STY NO: '${dup.sty_cd}', Original Row Index: ${dup.original_row_index}`);
    });
    console.error('--- Please review your input data ---');
    // 오류를 명확히 하기 위해 여기서 throw new Error를 추가할 수도 있습니다.
    // throw new Error('입력 데이터에 중복된 STY NO가 존재합니다. SQL 쿼리 실행이 중단됩니다.');
  }

  // 값이 없는 경우 쿼리를 실행하지 않습니다.
  if (valuesList.length === 0) {
    utils.showNotification({
      title: '업로드 실패',
      description: '유효한 데이터가 없습니다. STY NO가 입력된 행이 있는지 확인해주세요.',
      notificationType: 'error',
    });
    return;
  }

  // 업데이트할 필드 목록 생성 (STY_CD 제외)
  const updateFields = dbFields.filter(field => field !== 'sty_cd');

  // UPDATE 절 생성
  const updateClause = updateFields.map(field => {
    return `${field} = EXCLUDED.${field}`;
  }).join(',\n');

  // 최종 INSERT 쿼리 생성
  const insertQuery = `
INSERT INTO item_md_info (${dbFields.join(', ')})
VALUES
${valuesList.join(',\n')}
ON CONFLICT (sty_cd) DO UPDATE SET
${updateClause};
`;

  console.log('Generated SQL Query (first 500 chars):', insertQuery.substring(0, 500) + (insertQuery.length > 500 ? '...' : ''));
  console.log('Generated SQL Query length:', insertQuery.length);

  var_update_production_query.setValue(insertQuery);

  // 0.5초 대기
  await sleep(500);

  // SQL 트리거
  update_production_query.trigger();

  // 알림
  fileDropzone3.clearValue();
  production_temp_data.setValue([]);
  query_get_info.trigger();
  modalFrame_production_upload.setHidden(true);
  utils.showNotification({
    title: '업데이트 성공',
    description: '업데이트 내용이 반영되었습니다',
    notificationType: 'success',
  });

} catch (error) {
  console.error('업로드 중 오류 발생:', error);
  utils.showNotification({
    title: '업로드 오류',
    description: `처리 중 오류가 발생했습니다: ${error.message}`,
    notificationType: 'error',
  });
}

//  // production_temp_data에서 데이터를 가져옵니다.
//  const data = production_temp_data.value;

//  // 엑셀 필드와 데이터베이스 필드의 매핑을 정의합니다.
//  const mappings = {
//    '브랜드코드': 'br_cd',
//    'STY NO': 'sty_cd',
//    '소재': 'fabric',
//    '생산지': 'prod_country',
//    '납기': 'deli_dt',
//    '조정납기': 'adj_deli_dt',
//    '디자이너': 'designer_nm',
//    '품평점수': 'preview_score',
//    '품평등급': 'preview_grade',
//    '품평의견': 'opinion',
//    '아이템': 'item_raw_nm',
//    '성별': 'sex_nm',
//    '카테고리': 'cat_raw_nm',
//    '품평NO': 'preview_cd',
//    '컨셉': 'concept',
//    '매핑카테고리ID': 'item_md_category_id',
//    '매핑카테고리': 'cat_nm',
//    '상태': 'status',
//    '칼라1': 'color_1_nm',
//    '칼라1수량': 'color_1_qty',
//    '칼라2': 'color_2_nm',
//    '칼라2수량': 'color_2_qty',
//    '칼라3': 'color_3_nm',
//    '칼라3수량': 'color_3_qty',
//    '칼라4': 'color_4_nm',
//    '칼라4수량': 'color_4_qty',
//    '칼라5': 'color_5_nm',
//    '칼라5수량': 'color_5_qty',
//    '판가': 'sale_price',
//    '판가검토': 'sale_price_final',
//    '2nd원가(V-)': 'cost_price_final',
//    '샘플원가(-V)': 'cost_price'
//    };

//  // INSERT 문에 사용할 필드 목록을 생성합니다.
//  const dbFields = Object.values(mappings);

//  // 각 행의 값을 저장할 배열을 초기화합니다.
//  const valuesList = [];

//  // sty_cd 중복 체크를 위한 Set
//  const seenStyCds = new Set();
//  // 중복된 sty_cd를 저장할 배열
//  const duplicateStyCdsInInput = [];

//  // 0.5초씩 쉬는 함수
//  const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));

//  // 데이터 처리를 시작합니다.
//  data.forEach((row, index) => {
//    // 각 필드의 값을 저장할 배열을 초기화합니다.
//    const valueRow = [];
//      let currentStyCd = null; // 현재 row의 sty_cd를 저장할 변수

//    // 각 매핑에 대해 값을 처리합니다.
//    for (const [excelField, dbField] of Object.entries(mappings)) {
//      let value = row[excelField] ? String(row[excelField]).trim() : null;

//      // 'STY NO' 필드의 값을 미리 저장합니다.
//      if (excelField === 'STY NO') {
//          currentStyCd = value;
//      }

//      // '납기' 필드의 경우 날짜 형식을 변환합니다.
//      if ( ( excelField === '납기' || excelField === '조정납기' ) && value) {
//        let convertedDate = null;

//        // 'MM/DD' 형식인지 확인합니다.
//        const dateParts = value.split('/');
//        if (dateParts.length === 2) {
//          let month = dateParts[0].padStart(2, '0');
//          let day = dateParts[1].padStart(2, '0');

//          convertedDate = `2024-${month}-${day}`;
//          // 날짜 유효성을 확인합니다.
//          const dateObj = new Date(convertedDate);
//          if (isNaN(dateObj.getTime())) {
//            convertedDate = null;
//          }
//        } else {
//          // 다른 형식의 날짜 처리
//          const dateObj = new Date(value);
//          if (!isNaN(dateObj.getTime())) {
//            const year = dateObj.getFullYear();
//            const month = (dateObj.getMonth() + 1).toString().padStart(2, '0');
//            const day = dateObj.getDate().toString().padStart(2, '0');
//            convertedDate = `${year}-${month}-${day}`;
//          } else {
//            convertedDate = null;
//          }
//        }

//        value = convertedDate;
//      }

//      // '수량' 의 경우 콤마를 제거합니다.
//      if ( ( excelField === '칼라1수량' || excelField === '칼라2수량'  || excelField === '칼라3수량' || excelField === '칼라4수량' || excelField === '칼라5수량' || excelField === '판가' || excelField === '판가검토' || excelField === '샘플원가(-V)' || excelField === '2nd원가(V-)' ) && value ) {
//        value = value.replace(",", "")
//      }

//      // 값이 있는 경우 작은따옴표를 이스케이프합니다.
//      if (value !== null && value !== undefined) {
//        value = value.replace(/'/g, "''");
//        value = `'${value}'`;
//      } else {
//        value = 'NULL';
//      }

//      valueRow.push(value);
//    }

//    // 'STY_CD'가 NULL인 경우 해당 행을 건너뜁니다.
//    if (valueRow[dbFields.indexOf('sty_cd')] === 'NULL') {
//          console.warn(`Skipping row ${index + 1} due to NULL STY NO.`);
//      return;
//    }

//      // STY_CD 중복 체크
//      if (seenStyCds.has(currentStyCd)) {
//          duplicateStyCdsInInput.push({
//              sty_cd: currentStyCd,
//              original_row_index: index + 1 // 원본 데이터에서의 행 번호
//          });
//          // 중복된 STY_CD를 가진 행은 valuesList에 추가하지 않습니다.
//          // 또는, 여기에 오류를 발생시켜 사용자에게 알릴 수 있습니다.
//          console.error(`ERROR: Duplicate STY NO found in input data: '${currentStyCd}' at row ${index + 1}. This will cause 'command cannot affect row a second time' error.`);
//          // 이 경우 해당 행을 건너뛰는 것이 오류를 방지하는 방법이 될 수 있습니다.
//          // return; // 주석을 해제하면 중복된 행을 건너뜁니다.
//      } else {
//          seenStyCds.add(currentStyCd);
//          valuesList.push(`(${valueRow.join(', ')})`);
//      }
//  });

//  // 디버깅 로그: 최종 valuesList의 길이와 중복된 STY_CD 목록
//  console.log(`Final valuesList size: ${valuesList.length}`);
//  if (duplicateStyCdsInInput.length > 0) {
//      console.error('--- Detected Duplicate STY NOs in input data ---');
//      duplicateStyCdsInInput.forEach(dup => {
//          console.error(`STY NO: '${dup.sty_cd}', Original Row Index: ${dup.original_row_index}`);
//      });
//      console.error('--- Please review your input data ---');
//      // 오류를 명확히 하기 위해 여기서 throw new Error를 추가할 수도 있습니다.
//      // throw new Error('입력 데이터에 중복된 STY NO가 존재합니다. SQL 쿼리 실행이 중단됩니다.');
//  }

//  // 값이 없는 경우 쿼리를 실행하지 않습니다.
//  if (valuesList.length === 0) {
//    console.error('유효한 데이터가 없습니다.');
//    throw new Error('유효한 데이터가 없습니다.');
//  }

//  // 업데이트할 필드 목록 생성 (STY_CD 제외)
//  const updateFields = dbFields.filter(field => field !== 'sty_cd');

//  // UPDATE 절 생성
//  const updateClause = updateFields.map(field => {
//    return `${field} = EXCLUDED.${field}`;
//  }).join(',\n');

//  // 최종 INSERT 쿼리 생성
//  const insertQuery = `
//  INSERT INTO item_md_info (${dbFields.join(', ')})
//  VALUES
//  ${valuesList.join(',\n')}
//  ON CONFLICT (sty_cd) DO UPDATE SET
//  ${updateClause};
//  `;

//  console.log('Generated SQL Query (first 500 chars):', insertQuery.substring(0, 500) + (insertQuery.length > 500 ? '...' : ''));
//  console.log('Generated SQL Query length:', insertQuery.length);

//  var_update_production_query.setValue(insertQuery)

//  // 0.5초 대기
//  await sleep(500);

//  // SQL 트리거
//  update_production_query.trigger();

//  // 알림
//  fileDropzone3.clearValue();
//  production_temp_data.setValue([]);
//  query_get_info.trigger();
//  modalFrame_production_upload.setHidden(true);
//  utils.showNotification({
//    title: '업데이트 성공',
//    description: '업데이트 내용이 반영되었습니다',
//    notificationType: 'success',
//  });