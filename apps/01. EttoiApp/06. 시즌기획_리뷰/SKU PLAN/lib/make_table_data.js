const rawData = formatDataAsArray(get_season_data.data);

  // season 목록을 추출 (중복 제거)
  const var_season_list = [...new Set(rawData.map(item => item.year_season))];

  // 결과 데이터를 저장할 객체
  const formattedData = {};
  const category_totals = {}; // 카테고리별 전체 합산 저장용

  // 데이터를 변환
  rawData.forEach(row => {
    const { year_season, cat_nm, item_raw_nm, sku, tot_in_qty, tot_in_amt, tot_sale_qty, tot_sal_amt } = row;

    if (!formattedData[cat_nm]) {
      formattedData[cat_nm] = [];
      category_totals[cat_nm] = {};

      // 시즌별 카테고리 초기화
      var_season_list.forEach(season => {
        category_totals[cat_nm][season] = {
          total_in_amt: 0,
          total_sale_amt: 0,
        };
      });
    }

    let item = formattedData[cat_nm].find(item => item.item_raw_nm === item_raw_nm);

    if (!item) {
      // 기본 값으로 모든 시즌 데이터 초기화
      item = { item_raw_nm: item_raw_nm };
      var_season_list.forEach((season, index) => {
        const seasonIndex = index + 1;
        item[`season_${seasonIndex}_sku`] = 0;
        item[`season_${seasonIndex}_tot_in_qty`] = 0;
        item[`season_${seasonIndex}_tot_in_amt`] = 0;
        item[`season_${seasonIndex}_tot_sale_qty`] = 0;
        item[`season_${seasonIndex}_tot_sale_amt`] = 0;
        item[`season_${seasonIndex}_tot_in_amt_ratio`] = 0;
        item[`season_${seasonIndex}_tot_sale_amt_ratio`] = 0;
      });
      formattedData[cat_nm].push(item);
    }

    // 시즌 인덱스를 계산하여 데이터 추가
    const seasonIndex = var_season_list.indexOf(year_season) + 1;

    if (seasonIndex > 0) {
      item[`season_${seasonIndex}_sku`] = sku;
      item[`season_${seasonIndex}_tot_in_qty`] = parseInt(tot_in_qty, 10);
      item[`season_${seasonIndex}_tot_in_amt`] = parseInt(tot_in_amt, 10);
      item[`season_${seasonIndex}_tot_sale_qty`] = parseInt(tot_sale_qty, 10);
      item[`season_${seasonIndex}_tot_sale_amt`] = parseInt(tot_sal_amt, 10);

      // 카테고리 전체 합산 계산
      category_totals[cat_nm][year_season].total_in_amt += parseInt(tot_in_amt, 10);
      category_totals[cat_nm][year_season].total_sale_amt += parseInt(tot_sal_amt, 10);
    }
  });

  // 카테고리별 전체 합산 행 추가 및 비중 계산
  Object.keys(formattedData).forEach(cat_nm => {
    // 전체 합산 행 추가
    const totalRow = { item_raw_nm: "전체" };
    var_season_list.forEach((season, index) => {
      const seasonIndex = index + 1;
      totalRow[`season_${seasonIndex}_sku`] = 0;
      totalRow[`season_${seasonIndex}_tot_in_qty`] = 0;
      totalRow[`season_${seasonIndex}_tot_in_amt`] = 0;
      totalRow[`season_${seasonIndex}_tot_sale_qty`] = 0;
      totalRow[`season_${seasonIndex}_tot_sale_amt`] = 0;

      formattedData[cat_nm].forEach(item => {
        totalRow[`season_${seasonIndex}_sku`] += item[`season_${seasonIndex}_sku`] || 0;
        totalRow[`season_${seasonIndex}_tot_in_qty`] += item[`season_${seasonIndex}_tot_in_qty`] || 0;
        totalRow[`season_${seasonIndex}_tot_in_amt`] += item[`season_${seasonIndex}_tot_in_amt`] || 0;
        totalRow[`season_${seasonIndex}_tot_sale_qty`] += item[`season_${seasonIndex}_tot_sale_qty`] || 0;
        totalRow[`season_${seasonIndex}_tot_sale_amt`] += item[`season_${seasonIndex}_tot_sale_amt`] || 0;
      });
    });
    formattedData[cat_nm].push(totalRow);

    // 비중 계산
    formattedData[cat_nm].forEach(item => {
      if (item.item_raw_nm !== "전체") {
        var_season_list.forEach((season, index) => {
          const seasonIndex = index + 1;
          const totalInAmt = category_totals[cat_nm][season].total_in_amt;
          const totalSaleAmt = category_totals[cat_nm][season].total_sale_amt;

          item[`season_${seasonIndex}_tot_in_amt_ratio`] =
            totalInAmt > 0 ? item[`season_${seasonIndex}_tot_in_amt`] / totalInAmt : 0;
          item[`season_${seasonIndex}_tot_sale_amt_ratio`] =
            totalSaleAmt > 0 ? item[`season_${seasonIndex}_tot_sale_amt`] / totalSaleAmt : 0;
        });
      }
    });

    // category_list에 따른 정렬
    const categoryOrder = formatDataAsArray(category_list.data).filter(item => item.cat_nm === cat_nm)[0].item_nm_list;

    formattedData[cat_nm].sort((a, b) => {
      // "전체"는 항상 마지막에 위치
      if (a.item_raw_nm === "전체") return 1;
      if (b.item_raw_nm === "전체") return -1;

      // categoryOrder에 따라 정렬
      const indexA = categoryOrder.indexOf(a.item_raw_nm);
      const indexB = categoryOrder.indexOf(b.item_raw_nm);
      return indexA - indexB;
    });
  });

  return formattedData;