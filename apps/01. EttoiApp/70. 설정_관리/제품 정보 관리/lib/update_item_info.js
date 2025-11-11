function transformKeys(data) {
  return data.map(item => {
    const newItem = {};
    Object.keys(item).forEach(key => {
      // 괄호 안의 영어 부분 추출
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

// Date 객체 여부 확인 함수
function isDate(value) {
  return Object.prototype.toString.call(value) === '[object Date]';
}

// 테이블 데이터 가져오기 (테이블 컴포넌트 이름에 맞게 수정)
const tableDataValue = item_info_temp_data.value;

// 데이터가 배열인지 확인하고, 비어 있지 않은지 확인
if (!Array.isArray(tableDataValue) || tableDataValue.length === 0) {
  console.error('tableDataValue가 배열이 아니거나 비어 있습니다.');
  return;
}

const tableData = transformKeys(tableDataValue);

// 'tableData'가 비어 있지 않은지 확인
if (tableData.length === 0) {
  console.error('tableData가 비어 있습니다.');
  return;
}

// 배치 사이즈 설정
const batchSize = 500;

// 'id' 필드를 제외하고 나머지 필드 가져오기
const fields = Object.keys(tableData[0]).filter(field => field !== 'id');
const fieldNames = fields.join(', ');

// ON CONFLICT 구문에서 사용할 업데이트 구문 생성 (필드마다 업데이트하도록)
const updateQuery = fields.filter(field => field !== 'sty_cd').map(field => `${field} = EXCLUDED.${field}`).join(', ');

// 0.5초씩 쉬는 함수
const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));

// 데이터 삽입 함수
const insertDataInBatches = async () => {
  for (let i = 0; i < tableData.length; i += batchSize) {
    // 배치 데이터 가져오기
    const batchData = tableData.slice(i, i + batchSize);

    // 각 행의 값을 처리하여 VALUES 생성
    const valueRows = batchData.map(row => {
      const values = fields.map(field => {
        let value = row[field];

        if (value === undefined || value === null) {
          return 'NULL';
        } else if (typeof value === 'number') {
          return value;
        } else if (typeof value === 'boolean') {
          // Boolean 값 처리
          return value ? 'TRUE' : 'FALSE';
        } else if (isDate(value)) {
          // Date 값 처리
          const formattedDate = value.toISOString().slice(0, 19).replace('T', ' ');
          return `'${formattedDate}'`;
        } else if (typeof value === 'string') {
          const trimmedValue = value.trim();
          if (trimmedValue === '') {
            return 'NULL';
          } else if (trimmedValue.toUpperCase() === 'TRUE' || trimmedValue.toUpperCase() === 'FALSE') {
            return trimmedValue.toUpperCase();
          } else {
            // 문자열 내의 따옴표를 이스케이프 처리
            const escapedValue = trimmedValue.replace(/'/g, "''");
            return `'${escapedValue}'`;
          }
        } else {
          // 그 외의 경우 문자열로 변환하여 따옴표로 감쌈
          const stringValue = String(value).replace(/'/g, "''");
          return `'${stringValue}'`;
        }
      });
      return `(${values.join(', ')})`;
    });

    // 전체 INSERT 쿼리 구성
    const insertQuery = `
      INSERT INTO item_md_info (${fieldNames})
      VALUES ${valueRows.join(', ')}
      ON CONFLICT (sty_cd)
      DO UPDATE SET ${updateQuery};
    `;

    console.log(insertQuery);

    // SQL Query에 동적으로 쿼리를 설정하고 실행
    insert_query.setValue(insertQuery);

    // 0.5초 대기
    await sleep(500);

    // SQL 트리거
    query_insert_item.trigger();
  }
  await trigger_airflow_manual_dag.trigger()
};

// 비동기 함수 호출
insertDataInBatches().then(() => {
  // 정보 정리
  fileDropzone2.clearValue();
  item_info_temp_data.setValue([]);
  query_get_info.trigger();
  modalFrame_bulk_edit.setHidden(true);
  utils.showNotification({
    title: '업데이트 성공',
    description: '업데이트 내용이 반영되었습니다',
    notificationType: 'success',
  });
});