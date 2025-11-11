// 파일 확인
const uploadedFiles = fileDropzone2.value;

// 파일이 업로드되지 않았으면 중단
if (!uploadedFiles || uploadedFiles.length === 0) {
  console.log('파일이 업로드 되지 않았씁니다');
  return;
}

// 파일을 읽기 위한 Blob 생성
const file = uploadedFiles[0]; // 첫 번째 파일을 가져옵니다.
const reader = new FileReader();

// xlsx 데이터를 ArrayBuffer로 변환
const binaryString = atob(file.base64Data);
const len = binaryString.length;
const bytes = new Uint8Array(len);

for (let i = 0; i < len; i++) {
  bytes[i] = binaryString.charCodeAt(i);
}


// 파일을 읽었을 때 처리할 내용
try {
  
  // 파일 읽기
  const workbook = XLSX.read(bytes.buffer, { type: 'array' });

  // 첫 번째 시트의 이름 가져오기
  const firstSheetName = workbook.SheetNames[0];

  // 첫 번째 시트를 JSON 형식으로 변환
  const worksheet = workbook.Sheets[firstSheetName];
  const jsonData = XLSX.utils.sheet_to_json(worksheet, {
    defval: '',    // 빈 셀에 빈 문자열 할당
    raw: false     // 날짜 등의 데이터를 파싱하여 실제 값으로 변환
  });
  console.log(jsonData)
  
  // 데이터를 테이블에 반영
  item_info_temp_data.setValue(jsonData);

  // 다음 스텝으로 이동 
  steppedContainer1.setCurrentView('Step 3')

  } catch (error) {
    console.error("XLSX 파일을 파싱하는 중 오류가 발생했습니다:", error);
    throw new Error("XLSX 파일을 파싱할 수 없습니다.");
}
