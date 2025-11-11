const updates = item_table.changesetArray;

const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));


console.log(updates)
for (let i = 0; i < updates.length; i++) {
  const update = updates[i];

  // 동적 쿼리를 생성하기 위해 컬럼과 값을 추출
  let setClause = Object.keys(update)
    .filter(col => col !== 'id')  // 'id'는 조건절에 사용하므로 제외
    .map(col => `${col} = '${update[col]}'`)
    .join(', ');

  // 동적 SQL 쿼리 생성
  let query = `
    UPDATE item_md_info
    SET ${setClause}
    WHERE id = ${update.id};
  `;

  // 동적 쿼리 세팅
  update_query.setValue(query)
  console.log(query)
  
  // 동적 SQL 쿼리를 실행합니다.
  await update_changes_query.trigger();
}