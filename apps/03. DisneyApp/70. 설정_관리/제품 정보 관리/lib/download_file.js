// 현재 날짜와 시간을 가져오는 함수
const getCurrentDateTime = () => {
  const now = new Date();
  
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줍니다.
  const day = String(now.getDate()).padStart(2, '0');
  
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const seconds = String(now.getSeconds()).padStart(2, '0');
  
  return `${year}${month}${day}_${hours}${minutes}${seconds}`;
};

//  // table1은 테이블 컴포넌트의 이름입니다. 사용 중인 테이블의 이름에 맞춰 변경하세요.
//  const tableData = item_table.exportData()

//  // 테이블 데이터가 있는지 확인
//  if (!tableData || tableData.length === 0) {
//    console.log('No data available in the table');
//    return;
//  }

//  // 데이터를 시트 형태로 변환
//  const ws = XLSX.utils.json_to_sheet(tableData);

//  // 새로운 워크북 생성
//  const wb = XLSX.utils.book_new();
//  XLSX.utils.book_append_sheet(wb, ws, "제품정보");

//  // 파일 이름에 현재 날짜와 시간을 포함
//  const fileName = `제품정보_${getCurrentDateTime()}.xlsx`;

//  // 워크북을 엑셀 파일로 변환하여 다운로드
//  XLSX.writeFile(wb, fileName);

// 파일 이름에 현재 날짜와 시간을 포함
const fileName = `제품정보_${getCurrentDateTime()}`;
item_table.exportData({fileName: fileName, fileType:"xlsx", includeHiddenColumns: false})

// 다음 스텝으로 이동 
steppedContainer1.setCurrentView('Step 2')
