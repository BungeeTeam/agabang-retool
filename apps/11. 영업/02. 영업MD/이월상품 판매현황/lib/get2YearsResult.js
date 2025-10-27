// 시작 알림
utils.showNotification({ title: '데이터 로드 시작', description: '데이터를 불러오고 있습니다. 잠시만 기다려 주세요...', status: 'info', duration: 3 });

// 쿼리에 필요한 날짜 및 연도 코드 변수를 준비합니다.

// 1. 현재 기간 변수
// getSeasonEndDate 쿼리가 특정 값을 설정하는 경우, 해당 값을 사용하기 위해 먼저 실행할 수 있습니다.
// 만약 이 쿼리가 다른 로직에 영향을 주지 않는다면 Promise.all 안으로 넣어도 됩니다.
await Promise.all([
  //getSeasonEndDate.trigger(),
  getOutEndDate.trigger()
]);

let outEndDate = getOutEndDate.data[0].outEndDate
let seasonEndDate = moment(yearSelect2.selectedItem?.last_season_end_dt).format('YYYY-MM-DD');
let saleEndDate = moment(endDate.value)?.format('YYYY-MM-DD');
let YearCodes = yearSelect2.selectedItem.year_codes.replace(/\[|\]/g, '').split(',').map(item => `'${item.trim()}'`).join(',');

// 2. 전년 동기 기간 변수 (로직 오류 수정)
let prevOutEndDate = moment(outEndDate).subtract(1, 'year').format('YYYY-MM-DD');
let prevSaleEndDate = moment(saleEndDate).subtract(1, 'year').format('YYYY-MM-DD');
let prevSeasonEndDate = moment(seasonEndDate).subtract(1, 'year').format('YYYY-MM-DD');
let prevYearCodes = yearSelect2.selectedItem.prev_year_codes.replace(/\[|\]/g, '').split(',').map(item => `'${item.trim()}'`).join(',');


// Promise.all을 사용하여 6개의 주요 쿼리를 병렬로 실행하여 성능을 최적화합니다.
try {
  const [
    resultCurSale,
    resultCurOut,
    resultPrevSale,
    resultPrevOut,
    resultCurOnlineWarehouse,
    resultPrevOnlineWarehouse
  ] = await Promise.all([
    // 1. 현재 판매 데이터 쿼리
    getShopSaleByCategory.trigger({
      additionalScope: {
        p_year_codes: YearCodes,
        p_endDate: saleEndDate,
        p_seasonEndDate: seasonEndDate
      }
    }),
    // 2. 현재 출고 데이터 쿼리
    getShopOutByCategory.trigger({
      additionalScope: {
        p_year_codes: YearCodes,
        p_endDate: saleEndDate,
        p_seasonEndDate: seasonEndDate,
        p_outEndDate: outEndDate
      }
    }),
    // 3. 전년 동기 판매 데이터 쿼리
    getShopSaleByCategory.trigger({
      additionalScope: {
        p_year_codes: prevYearCodes,
        p_endDate: prevSaleEndDate,
        p_seasonEndDate: prevSeasonEndDate
      }
    }),
    // 4. 전년 동기 출고 데이터 쿼리
    getShopOutByCategory.trigger({
      additionalScope: {
        p_year_codes: prevYearCodes,
        p_endDate: prevSaleEndDate,
        p_seasonEndDate: prevSeasonEndDate,
        p_outEndDate: prevOutEndDate
      }
    }),
    // 5. 현재 온라인 창고 데이터 쿼리
    getOnlineWarehouseByCategory.trigger({
      additionalScope: {
        p_year_codes: YearCodes,
        p_endDate: saleEndDate,
        p_seasonEndDate: seasonEndDate,
        p_outEndDate: outEndDate
      }
    }),
    // 6. 전년 동기 온라인 창고 데이터 쿼리
    getOnlineWarehouseByCategory.trigger({
      additionalScope: {
        p_year_codes: prevYearCodes,
        p_endDate: prevSaleEndDate,
        p_seasonEndDate: prevSeasonEndDate,
        p_outEndDate: prevOutEndDate
      }
    })
  ]);

  // 모든 쿼리가 성공적으로 완료된 후, 최종 결과를 변수에 저장합니다.
  varResult.setValue({
    curSale: resultCurSale,
    prevSale: resultPrevSale,
    curOut: resultCurOut,
    prevOut: resultPrevOut,
    curOnlineWarehouse: resultCurOnlineWarehouse,
    prevOnlineWarehouse: resultPrevOnlineWarehouse
  });

  // 완료 알림
  utils.showNotification({ title: '완료', description: '데이터 로드가 성공적으로 완료되었습니다.', status: 'success' });

} catch (error) {
  // 쿼리 실행 중 하나라도 실패할 경우 에러 알림을 표시합니다.
  console.error("데이터 로드 중 에러 발생:", error);
  utils.showNotification({ title: '오류 발생', description: '데이터를 불러오는 중 문제가 발생했습니다. 콘솔을 확인해 주세요.', status: 'error' });
}

//  utils.showNotification({ title: '잠시만 기다려 주세요...', description: '데이터를 불러오고 있습니다.', status: 'info' });

//  await getSeasonEndDate.trigger(); 

//  let seasonEndDate = moment(yearSelect2.selectedItem?.season_end_dt).format('YYYY-MM-DD')
//  let saleEndDate = moment(endDate.value)?.format('YYYY-MM-DD');
//  let YearCodes = yearSelect2.selectedItem.year_codes.replace(/\[|\]/g, '') .split(',').map(item => `'${item.trim()}'`).join(',');


//  utils.showNotification({ title: '잠시만 기다려 주세요...', description: '판매 데이터를 불러오고 있습니다.', status: 'info' });

//  //  현재 데이터 조회
//  let resultCurSale = await getShopSaleByCategory.trigger({
//    additionalScope: {
//      p_year_codes: YearCodes,
//      p_endDate: saleEndDate,
//      p_seasonEndDate: seasonEndDate
//    }
//  });

//  utils.showNotification({ title: '잠시만 기다려 주세요...', description: '출고 데이터를 불러오고 있습니다.', status: 'info' });

//  let resultCurOut = await getShopOutByCategory.trigger({
//    additionalScope: {
//      p_year_codes: YearCodes,
//      p_endDate: saleEndDate,
//      p_seasonEndDate: seasonEndDate
//    }
//  });



//  // 전년 데이터 조회 (1년 전 날짜 계산)

//  let prevSaleEndDate = moment(saleEndDate).subtract(1, 'years').subtract(2, 'days').format('YYYY-MM-DD');
//  let prevSeasonEndDate = moment(seasonEndDate).subtract(1, 'years').subtract(2, 'days').format('YYYY-MM-DD')
//  let prevYearCodes = yearSelect2.selectedItem.prev_year_codes.replace(/\[|\]/g, '') .split(',').map(item => `'${item.trim()}'`).join(',');

//  utils.showNotification({ title: '잠시만 기다려 주세요...', description: '전년 동기 판매 데이터를 불러오고 있습니다.', status: 'info' });

//  let resultPrevSale = await getShopSaleByCategory.trigger({
//    additionalScope: {
//        p_year_codes: prevYearCodes,
//        p_endDate: prevSaleEndDate,
//        p_seasonEndDate: prevSeasonEndDate
//    }
//  });

//  utils.showNotification({ title: '잠시만 기다려 주세요...', description: '전년 동기 출고 데이터를 불러오고 있습니다.', status: 'info' });

//  let resultPrevOut = await getShopOutByCategory.trigger({
//      additionalScope: {
//        p_year_codes: prevYearCodes,
//        p_endDate: prevSaleEndDate,
//        p_seasonEndDate: prevSeasonEndDate
//      }
//    });

//  // 쿼리 종료 후
//  utils.showNotification({ title: '완료', description: '데이터 로드가 완료되었습니다.', status: 'success' });
  
//  // 📢 최종 변수 저장
//  varResult.setValue({
//    curSale: resultCurSale,
//    prevSale: resultPrevSale,
//    curOut: resultCurOut,
//    prevOut:resultPrevOut
//  });