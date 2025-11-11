const getCompleteChangedData = () => {
  const changesetObject = {{table3.changesetObject}};
  const tableData = {{table3.data}};
  
  return Object.keys(changesetObject).map(index => {
    const change = changesetObject[index];
    const originalRow = tableData[parseInt(index)]; // 미리 가져온 데이터 사용
    
    return {
      id: originalRow?.id || null,
      biz_cd: originalRow?.biz_cd || change.biz_cd,
      biz_nm: originalRow?.biz_nm || change.biz_nm,
      tp_cd: originalRow?.tp_cd || change.tp_cd,
      tp_nm: originalRow?.tp_nm || change.tp_nm,
      tp_group_nm: change.tp_group_nm || originalRow?.tp_group_nm
    };
  });
};

return getCompleteChangedData();