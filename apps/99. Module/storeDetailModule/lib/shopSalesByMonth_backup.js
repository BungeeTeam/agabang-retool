function processSalesDataAllOrByBrCd(salesData, targetBrCd) {
   const currentYear = {{ moment(startDate.value).year() }};
   const result = [];
  
   for (let i = 0; i < 3; i++) {
     const year = currentYear - i;
     const yearStrShort = String(year).slice(2);
     const yearStrLong = String(year);
     const targetYearData = salesData.filter(item => item.year_month.startsWith(yearStrLong));
  
     let yearlyTotal = 0;
     const monthlySales = {};
     let currentBrCd = targetBrCd;
  
     if (targetBrCd === '-1') {
       yearlyTotal = targetYearData.reduce((sum, item) => sum + Number(item.sales_price), 0);
       targetYearData.forEach(item => {
         const [y, m] = item.year_month.split('-');
         const month = parseInt(m);
         monthlySales[month] = (monthlySales[month] || 0) + Number(item.sales_price);
       });
       currentBrCd = '전체';
     } else {
       const brCdOfYear = targetYearData.filter(item => item.br_cd === targetBrCd);
       yearlyTotal = brCdOfYear.reduce((sum, item) => sum + Number(item.sales_price), 0);
       targetYearData.forEach(item => {
         if (item.br_cd === targetBrCd) {
           const [y, m] = item.year_month.split('-');
           const month = parseInt(m);
           monthlySales[month] = (monthlySales[month] || 0) + Number(item.sales_price);
         }
       });
     }
  
     const monthlyResult = {
       '구분': `${yearStrShort}년 실적`,
       'br_cd': currentBrCd,
       'total': yearlyTotal,
       'jan': monthlySales[1] || null,
       'feb': monthlySales[2] || null,
       'mar': monthlySales[3] || null,
       'apr': monthlySales[4] || null,
       'may': monthlySales[5] || null,
       'jun': monthlySales[6] || null,
       'jul': monthlySales[7] || null,
       'aug': monthlySales[8] || null,
       'sep': monthlySales[9] || null,
       'oct': monthlySales[10] || null,
       'nov': monthlySales[11] || null,
       'dec': monthlySales[12] || null,
     };
  
     result.push(monthlyResult);
   }
  
   return result;
 }

 function summarizeData(data, targetBrCd) {
  const currentYear = {{ moment(startDate.value).year() }};
  const yearStrShort = String(currentYear).slice(2);
  
  // 기본 구조 생성
  const defaultResult = {
    '구분': `${yearStrShort}년 목표`,
    br_cd: targetBrCd === '-1' ? '전체' : targetBrCd,
    total: null,
    jan: null, feb: null, mar: null, apr: null,
    may: null, jun: null, jul: null, aug: null,
    sep: null, oct: null, nov: null, dec: null
  };
  
  // 데이터가 없거나 빈 배열인 경우 기본값 반환
  if (!data || data.length === 0) {
    return defaultResult;
  }
  
  if (targetBrCd === '-1') {
    // 전체 합산
    const result = { 
      '구분': `${yearStrShort}년 목표`,
      br_cd: '전체' 
    };

    data.forEach(item => {
      for (const [key, value] of Object.entries(item)) {
        if (key === 'br_cd') continue;
        const num = Number(value) || 0;
        result[key] = (result[key] || 0) + num;
      }
    });
    
    // 0인 값들을 null로 변환
    for (const [key, value] of Object.entries(result)) {
      if (key !== '구분' && key !== 'br_cd' && Number(value) === 0) {
        result[key] = null;
      }
    }
    
    return result;
  } else {
    // 특정 br_cd 1개만 추출
    const target = data.find(item => item.br_cd === targetBrCd);

    if (!target) {
      // 해당 br_cd가 없으면 기본값 반환
      return defaultResult;
    }

    const result = {
      ...target,
      br_cd: targetBrCd,
      '구분': `${yearStrShort}년 목표`
    };
    
    // 0인 값들을 null로 변환
    for (const [key, value] of Object.entries(result)) {
      if (key !== '구분' && key !== 'br_cd' && Number(value) === 0) {
        result[key] = null;
      }
    }

    return result;
  }
}

const salesData = formatDataAsArray({{ shopSalesByBrandByMonth.data }})
const targetBrCd = {{ tabs2.value }}
const targetData = {{ shopTargetSalesByMonth.data }};
const transformed = processSalesDataAllOrByBrCd(salesData,targetBrCd);
const targetFinal = summarizeData(targetData,targetBrCd)

// 연도 정보 동적으로 가져오기
const currentYear = {{ moment(startDate.value).year() }};
const prevYear1 = currentYear - 1;
const prevYear2 = currentYear - 2;
const prevYear1Short = String(prevYear1).slice(2);
const prevYear2Short = String(prevYear2).slice(2);

const saleGrowth_01 = {
      '구분': `${prevYear1Short}년 신장액`,
      'br_cd': transformed[0]?.br_cd,
      'total': transformed[0]?.total-transformed[1]?.total || null,
      'jan': (transformed[0]?.jan - transformed[1]?.jan) || null,
      'feb': (transformed[0]?.feb - transformed[1]?.feb) || null,
      'mar': (transformed[0]?.mar - transformed[1]?.mar) || null,
      'apr': (transformed[0]?.apr - transformed[1]?.apr) || null,
      'may': (transformed[0]?.may - transformed[1]?.may) || null,
      'jun': (transformed[0]?.jun - transformed[1]?.jun) || null,
      'jul': (transformed[0]?.jul - transformed[1]?.jul) || null,
      'aug': (transformed[0]?.aug - transformed[1]?.aug) || null,
      'sep': (transformed[0]?.sep - transformed[1]?.sep) || null,
      'oct': (transformed[0]?.oct - transformed[1]?.oct) || null,
      'nov': (transformed[0]?.nov - transformed[1]?.nov) || null,
      'dec': (transformed[0]?.dec - transformed[1]?.dec) || null,
}

const saleGrowth_02 = {      
      '구분': `${prevYear2Short}년 신장액`,
      'br_cd': transformed[0]?.br_cd,
      'total': transformed[0]?.total-transformed[2]?.total || null,
      'jan': (transformed[0]?.jan - transformed[2]?.jan) || null,
      'feb': (transformed[0]?.feb - transformed[2]?.feb) || null,
      'mar': (transformed[0]?.mar - transformed[2]?.mar) || null,
      'apr': (transformed[0]?.apr - transformed[2]?.apr) || null,
      'may': (transformed[0]?.may - transformed[2]?.may) || null,
      'jun': (transformed[0]?.jun - transformed[2]?.jun) || null,
      'jul': (transformed[0]?.jul - transformed[2]?.jul) || null,
      'aug': (transformed[0]?.aug - transformed[2]?.aug) || null,
      'sep': (transformed[0]?.sep - transformed[2]?.sep) || null,
      'oct': (transformed[0]?.oct - transformed[2]?.oct) || null,
      'nov': (transformed[0]?.nov - transformed[2]?.nov) || null,
      'dec': (transformed[0]?.dec - transformed[2]?.dec) || null,
}

const saleGrowthRate_01 = {
      '구분': `${prevYear1Short}년 신장율`,
      'br_cd': transformed[0]?.br_cd,
      'total': (transformed[0]?.total/transformed[1]?.total) - 1 || null,
      'jan': (transformed[0]?.jan/transformed[1]?.jan)-1 || null,
      'feb': (transformed[0]?.feb /transformed[1]?.feb)-1 || null,
      'mar': (transformed[0]?.mar / transformed[1]?.mar)-1 || null,
      'apr': (transformed[0]?.apr / transformed[1]?.apr)-1 || null,
      'may': (transformed[0]?.may / transformed[1]?.may)-1 || null,
      'jun': (transformed[0]?.jun / transformed[1]?.jun)-1 || null,
      'jul': (transformed[0]?.jul / transformed[1]?.jul)-1 || null,
      'aug': (transformed[0]?.aug / transformed[1]?.aug)-1 || null,
      'sep': (transformed[0]?.sep / transformed[1]?.sep)-1 || null,
      'oct': (transformed[0]?.oct / transformed[1]?.oct)-1 || null,
      'nov': (transformed[0]?.nov / transformed[1]?.nov)-1 || null,
      'dec': (transformed[0]?.dec / transformed[1]?.dec)-1 || null,
}

const saleGrowthRate_02 = {
      '구분': `${prevYear2Short}년 신장율`,
      'br_cd': transformed[0]?.br_cd,
      'total': (transformed[0]?.total/transformed[2]?.total) - 1 || null,
      'jan': (transformed[0]?.jan/transformed[2]?.jan)-1 || null,
      'feb': (transformed[0]?.feb /transformed[2]?.feb)-1 || null,
      'mar': (transformed[0]?.mar / transformed[2]?.mar)-1 || null,
      'apr': (transformed[0]?.apr / transformed[2]?.apr)-1 || null,
      'may': (transformed[0]?.may / transformed[2]?.may)-1 || null,
      'jun': (transformed[0]?.jun / transformed[2]?.jun)-1 || null,
      'jul': (transformed[0]?.jul / transformed[2]?.jul)-1 || null,
      'aug': (transformed[0]?.aug / transformed[2]?.aug)-1 || null,
      'sep': (transformed[0]?.sep / transformed[2]?.sep)-1 || null,
      'oct': (transformed[0]?.oct / transformed[2]?.oct)-1 || null,
      'nov': (transformed[0]?.nov / transformed[2]?.nov)-1 || null,
      'dec': (transformed[0]?.dec / transformed[2]?.dec)-1 || null,
}

// targetFinal이 있을 때만 목표 관련 계산
const saleTargetRate = targetFinal ? {
      '구분': '목표달성율',
      'br_cd': transformed[0]?.br_cd,
      'total': (transformed[0]?.total/targetFinal?.total) || null,
      'jan': (transformed[0]?.jan / targetFinal?.jan) || null,
      'feb': (transformed[0]?.feb /targetFinal?.feb) || null,
      'mar': (transformed[0]?.mar / targetFinal?.mar) || null,
      'apr': (transformed[0]?.apr / targetFinal?.apr) || null,
      'may': (transformed[0]?.may / targetFinal?.may) || null,
      'jun': (transformed[0]?.jun / targetFinal?.jun) || null,
      'jul': (transformed[0]?.jul / targetFinal?.jul) || null,
      'aug': (transformed[0]?.aug / targetFinal?.aug) || null,
      'sep': (transformed[0]?.sep / targetFinal?.sep) || null,
      'oct': (transformed[0]?.oct / targetFinal?.oct) || null,
      'nov': (transformed[0]?.nov / targetFinal?.nov) || null,
      'dec': (transformed[0]?.dec / targetFinal?.dec) || null,
} : null;
  
const saleTarget = targetFinal ? {
      '구분': '목표차액',
      'br_cd': transformed[0]?.br_cd,
      'total': (transformed[0]?.total- targetFinal?.total) || null,
      'jan': (transformed[0]?.jan - targetFinal?.jan) || null,
      'feb': (transformed[0]?.feb - targetFinal?.feb) || null,
      'mar': (transformed[0]?.mar - targetFinal?.mar) || null,
      'apr': (transformed[0]?.apr - targetFinal?.apr) || null,
      'may': (transformed[0]?.may - targetFinal?.may) || null,
      'jun': (transformed[0]?.jun - targetFinal?.jun) || null,
      'jul': (transformed[0]?.jul - targetFinal?.jul) || null,
      'aug': (transformed[0]?.aug - targetFinal?.aug) || null,
      'sep': (transformed[0]?.sep - targetFinal?.sep) || null,
      'oct': (transformed[0]?.oct - targetFinal?.oct) || null,
      'nov': (transformed[0]?.nov - targetFinal?.nov) || null,
      'dec': (transformed[0]?.dec - targetFinal?.dec) || null,
} : null;

// targetFinal이 있는 경우와 없는 경우 분리
const sort = targetFinal ? [
  transformed[0],
  targetFinal,
  saleTargetRate,
  saleTarget,
  transformed[1],
  saleGrowthRate_01,
  saleGrowth_01,
  transformed[2],
  saleGrowthRate_02,
  saleGrowth_02
] : [
  transformed[0],
  targetFinal,
  saleTargetRate,
  saleTarget,
  transformed[1],
  saleGrowthRate_01,
  saleGrowth_01,
  transformed[2],
  saleGrowthRate_02,
  saleGrowth_02
];

return sort//.filter(i => i && (i.total !== null || i.total !== 0))


// function processSalesDataAllOrByBrCd(salesData, targetBrCd) {
//    const currentYear = {{ moment().year() }};
//    const result = [];
  
//    for (let i = 0; i < 3; i++) {
//      const year = currentYear - i;
//      const yearStrShort = String(year).slice(2);
//      const yearStrLong = String(year);
//      const targetYearData = salesData.filter(item => item.year_month.startsWith(yearStrLong));
  
//      let yearlyTotal = 0;
//      const monthlySales = {};
//      let currentBrCd = targetBrCd;
  
//      if (targetBrCd === '-1') {
//        yearlyTotal = targetYearData.reduce((sum, item) => sum + Number(item.sales_price), 0);
//        targetYearData.forEach(item => {
//          const [y, m] = item.year_month.split('-');
//          const month = parseInt(m);
//          monthlySales[month] = (monthlySales[month] || 0) + Number(item.sales_price);
//        });
//        currentBrCd = '전체';
//      } else {
//        const brCdOfYear = targetYearData.filter(item => item.br_cd === targetBrCd);
//        yearlyTotal = brCdOfYear.reduce((sum, item) => sum + Number(item.sales_price), 0);
//        targetYearData.forEach(item => {
//          if (item.br_cd === targetBrCd) {
//            const [y, m] = item.year_month.split('-');
//            const month = parseInt(m);
//            monthlySales[month] = (monthlySales[month] || 0) + Number(item.sales_price);
//          }
//        });
//      }
  
//      const monthlyResult = {
//        '구분': `${yearStrShort}년 실적`,
//        'br_cd': currentBrCd,
//        'total': yearlyTotal,
//        'jan': monthlySales[1] || null,
//        'feb': monthlySales[2] || null,
//        'mar': monthlySales[3] || null,
//        'apr': monthlySales[4] || null,
//        'may': monthlySales[5] || null,
//        'jun': monthlySales[6] || null,
//        'jul': monthlySales[7] || null,
//        'aug': monthlySales[8] || null,
//        'sep': monthlySales[9] || null,
//        'oct': monthlySales[10] || null,
//        'nov': monthlySales[11] || null,
//        'dec': monthlySales[12] || null,
//      };
  
//      result.push(monthlyResult);
//    }
  
//    return result;
//  }

//  function summarizeData(data, targetBrCd) {
//    const currentYear = {{ moment().year() }};
//    const yearStrShort = String(currentYear).slice(2);
    
//    if (targetBrCd === '-1') {
//      // 전체 합산
//      const result = { 
//        '구분': `${yearStrShort}년 목표`,
//        br_cd: '전체' 
//      };
  
//      data.forEach(item => {
//        for (const [key, value] of Object.entries(item)) {
//          if (key === 'br_cd') continue;
//          const num = Number(value) || 0;
//          result[key] = (result[key] || 0) + num;
//        }
//      });
//      // 0인 값들을 null로 변환
//    for (const [key, value] of Object.entries(result)) {
//      if (key !== '구분' && key !== 'br_cd' && Number(value) === 0) {
//        result[key] = null;
//      }
//    }
//      return result;
//    } else {
//    // 특정 br_cd 1개만 추출
//    const target = data.find(item => item.br_cd === targetBrCd);

//    if (!target) {
//      console.warn(`br_cd ${targetBrCd}에 해당하는 데이터가 없습니다.`);
//      return null;
//    }

//    const result = {
//      ...target,
//      br_cd: targetBrCd,
//      '구분': `${yearStrShort}년 목표`
//    };
    
//    // 0인 값들을 null로 변환
//    for (const [key, value] of Object.entries(result)) {
//      if (key !== '구분' && key !== 'br_cd' && Number(value) === 0) {
//        result[key] = null;
//      }
//    }

//    return result;
//  }
// }

//  const salesData = formatDataAsArray({{ shopSalesByBrandByMonth.data }})
//  const targetBrCd = {{ tabs2.value }}
//  const targetData = {{ shopTargetSalesByMonth.data }};
//  const transformed = processSalesDataAllOrByBrCd(salesData,targetBrCd);
//  const targetFinal = summarizeData(targetData,targetBrCd)

//  // 연도 정보 동적으로 가져오기
//  const currentYear = {{ moment(startDate.value).year() }};
//  const prevYear1 = currentYear - 1;
//  const prevYear2 = currentYear - 2;
//  const prevYear1Short = String(prevYear1).slice(2);
//  const prevYear2Short = String(prevYear2).slice(2);

//  const saleGrowth_01 = {
//        '구분': `${prevYear1Short}년 신장액`,
//        'br_cd': transformed[0]?.br_cd,
//        'total': transformed[0]?.total-transformed[1]?.total || null,
//  'jan': (transformed[0]?.jan - transformed[1]?.jan) || null,
//  'feb': (transformed[0]?.feb - transformed[1]?.feb) || null,
//  'mar': (transformed[0]?.mar - transformed[1]?.mar) || null,
//  'apr': (transformed[0]?.apr - transformed[1]?.apr) || null,
//  'may': (transformed[0]?.may - transformed[1]?.may) || null,
//  'jun': (transformed[0]?.jun - transformed[1]?.jun) || null,
//  'jul': (transformed[0]?.jul - transformed[1]?.jul) || null,
//  'aug': (transformed[0]?.aug - transformed[1]?.aug) || null,
//  'sep': (transformed[0]?.sep - transformed[1]?.sep) || null,
//  'oct': (transformed[0]?.oct - transformed[1]?.oct) || null,
//  'nov': (transformed[0]?.nov - transformed[1]?.nov) || null,
//  'dec': (transformed[0]?.dec - transformed[1]?.dec) || null,
//      }
  
//  const saleGrowth_02 = {      
//        '구분': `${prevYear2Short}년 신장액`,
//        'br_cd': transformed[0]?.br_cd,
//        'total': transformed[0]?.total-transformed[2]?.total || null,
//  'jan': (transformed[0]?.jan - transformed[2]?.jan) || null,
//  'feb': (transformed[0]?.feb - transformed[2]?.feb) || null,
//  'mar': (transformed[0]?.mar - transformed[2]?.mar) || null,
//  'apr': (transformed[0]?.apr - transformed[2]?.apr) || null,
//  'may': (transformed[0]?.may - transformed[2]?.may) || null,
//  'jun': (transformed[0]?.jun - transformed[2]?.jun) || null,
//  'jul': (transformed[0]?.jul - transformed[2]?.jul) || null,
//  'aug': (transformed[0]?.aug - transformed[2]?.aug) || null,
//  'sep': (transformed[0]?.sep - transformed[2]?.sep) || null,
//  'oct': (transformed[0]?.oct - transformed[2]?.oct) || null,
//  'nov': (transformed[0]?.nov - transformed[2]?.nov) || null,
//  'dec': (transformed[0]?.dec - transformed[2]?.dec) || null,
//      }
  
//  const saleGrowthRate_01 = {
//        '구분': `${prevYear1Short}년 신장율`,
//        'br_cd': transformed[0]?.br_cd,
//        'total': (transformed[0]?.total/transformed[1]?.total) - 1 || null,
//  'jan': (transformed[0]?.jan/transformed[1]?.jan)-1 || null,
//  'feb': (transformed[0]?.feb /transformed[1]?.feb)-1 || null,
//  'mar': (transformed[0]?.mar / transformed[1]?.mar)-1 || null,
//  'apr': (transformed[0]?.apr / transformed[1]?.apr)-1 || null,
//  'may': (transformed[0]?.may / transformed[1]?.may)-1 || null,
//  'jun': (transformed[0]?.jun / transformed[1]?.jun)-1 || null,
//  'jul': (transformed[0]?.jul / transformed[1]?.jul)-1 || null,
//  'aug': (transformed[0]?.aug / transformed[1]?.aug)-1 || null,
//  'sep': (transformed[0]?.sep / transformed[1]?.sep)-1 || null,
//  'oct': (transformed[0]?.oct / transformed[1]?.oct)-1 || null,
//  'nov': (transformed[0]?.nov / transformed[1]?.nov)-1 || null,
//  'dec': (transformed[0]?.dec / transformed[1]?.dec)-1 || null,
//      }
  
//  const saleGrowthRate_02 = {
//        '구분': `${prevYear2Short}년 신장율`,
//        'br_cd': transformed[0]?.br_cd,
//        'total': (transformed[0]?.total/transformed[2]?.total) - 1 || null,
//  'jan': (transformed[0]?.jan/transformed[2]?.jan)-1 || null,
//  'feb': (transformed[0]?.feb /transformed[2]?.feb)-1 || null,
//  'mar': (transformed[0]?.mar / transformed[2]?.mar)-1 || null,
//  'apr': (transformed[0]?.apr / transformed[2]?.apr)-1 || null,
//  'may': (transformed[0]?.may / transformed[2]?.may)-1 || null,
//  'jun': (transformed[0]?.jun / transformed[2]?.jun)-1 || null,
//  'jul': (transformed[0]?.jul / transformed[2]?.jul)-1 || null,
//  'aug': (transformed[0]?.aug / transformed[2]?.aug)-1 || null,
//  'sep': (transformed[0]?.sep / transformed[2]?.sep)-1 || null,
//  'oct': (transformed[0]?.oct / transformed[2]?.oct)-1 || null,
//  'nov': (transformed[0]?.nov / transformed[2]?.nov)-1 || null,
//  'dec': (transformed[0]?.dec / transformed[2]?.dec)-1 || null,
//      }

  
//  const saleTargetRate = {
//        '구분': '목표달성율',
//        'br_cd': transformed[0]?.br_cd,
//        'total': (transformed[0]?.total/targetFinal?.total) || null,
//  'jan': (transformed[0]?.jan / targetFinal?.jan) || null,
//  'feb': (transformed[0]?.feb /targetFinal?.feb) || null,
//  'mar': (transformed[0]?.mar / targetFinal?.mar) || null,
//  'apr': (transformed[0]?.apr / targetFinal?.apr) || null,
//  'may': (transformed[0]?.may / targetFinal?.may) || null,
//  'jun': (transformed[0]?.jun / targetFinal?.jun) || null,
//  'jul': (transformed[0]?.jul / targetFinal?.jul) || null,
//  'aug': (transformed[0]?.aug / targetFinal?.aug) || null,
//  'sep': (transformed[0]?.sep / targetFinal?.sep) || null,
//  'oct': (transformed[0]?.oct / targetFinal?.oct) || null,
//  'nov': (transformed[0]?.nov / targetFinal?.nov) || null,
//  'dec': (transformed[0]?.dec / targetFinal?.dec) || null,
//  }
    
//    const saleTarget = {
//        '구분': '목표차액',
//        'br_cd': transformed[0]?.br_cd,
//        'total': (transformed[0]?.total- targetFinal?.total) || null,
// 'jan': (transformed[0]?.jan - targetFinal?.jan) || null,
// 'feb': (transformed[0]?.feb - targetFinal?.feb) || null,
// 'mar': (transformed[0]?.mar - targetFinal?.mar) || null,
// 'apr': (transformed[0]?.apr - targetFinal?.apr) || null,
// 'may': (transformed[0]?.may - targetFinal?.may) || null,
// 'jun': (transformed[0]?.jun - targetFinal?.jun) || null,
// 'jul': (transformed[0]?.jul - targetFinal?.jul) || null,
// 'aug': (transformed[0]?.aug - targetFinal?.aug) || null,
// 'sep': (transformed[0]?.sep - targetFinal?.sep) || null,
// 'oct': (transformed[0]?.oct - targetFinal?.oct) || null,
// 'nov': (transformed[0]?.nov - targetFinal?.nov) || null,
// 'dec': (transformed[0]?.dec - targetFinal?.dec) || null,
//      }


// const sort = [
//  transformed[0],
//  targetFinal,
//  saleTargetRate,
//  saleTarget,
//  transformed[1],
//  saleGrowthRate_01,
//  saleGrowth_01,
//  transformed[2],
//  saleGrowthRate_02,
//  saleGrowth_02
// ];

// return sort.filter(i => i.total !== null || i.total !== 0 )