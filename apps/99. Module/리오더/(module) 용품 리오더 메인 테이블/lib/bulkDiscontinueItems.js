// bulkDiscontinueItems.js (additionalScope 사용하도록 수정)
async function processBulkDiscontinue() {
  // 1. 단종 처리할 항목 목록 가져오기 (selectedReorderItems.value 사용)
  const itemsToDiscontinue = selectedReorderItems.value || [];
  console.log("단종 처리할 항목 수:", itemsToDiscontinue.length);
  console.log("단종 처리할 항목 데이터:", JSON.stringify(itemsToDiscontinue, null, 2));

  // 2. 선택된 항목 유효성 검사
  if (!itemsToDiscontinue || itemsToDiscontinue.length === 0) {
    return { status: "info", message: "단종 처리할 항목이 선택되지 않았습니다." };
  }

  // (유효성 검사 등은 기존 로직 유지)
  // const validItems = ...
  // if (validItems.length === 0) ...

  try {
    // 3. 단종 처리 쿼리 실행 (additionalScope 사용)
    console.log(`discontinuedProductsQuery 트리거 (additionalScope 사용), ${itemsToDiscontinue.length}개 항목`);
    await discontinuedProductsQuery.trigger({
      // additionalScope 객체 안에 전달할 데이터를 넣습니다.
      // SQL 쿼리에서는 여기서 정의한 이름(예: discontinuedItemsList)으로 참조합니다.
      additionalScope: {
        discontinuedItemsList: itemsToDiscontinue
      },
      // onSuccess, onFailure 콜백 등 필요시 추가 가능
    });

    // 4. 성공 메시지 반환 및 데이터 리프레시 (기존 로직 유지)
    console.log("단종 처리 쿼리 요청 성공 (additionalScope 사용)");
    try {
      await get_discontinued_products.trigger();
      await get_item_list.trigger();
      console.log("데이터 리프레시 완료");
    } catch (refreshError) {
      console.error("데이터 리프레시 중 오류 발생:", refreshError);
    }

    return {
      status: "success",
      message: `${itemsToDiscontinue.length}개 항목에 대한 단종 처리가 성공적으로 요청되었습니다.`
    };

  } catch (error) {
    // 5. 오류 처리 (기존 로직 유지)
    console.error("단종 처리 중 오류 발생:", error);
    return {
      status: "error",
      message: `단종 처리 중 오류가 발생했습니다: ${error.message}`,
      error: error
    };
  }
}

return processBulkDiscontinue();