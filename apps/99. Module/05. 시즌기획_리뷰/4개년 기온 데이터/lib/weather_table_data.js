// weather_table_data 코드 (Plotly + 테이블 데이터 동시 생성)

// 1. 입력 데이터 가져오기
const rawData = get_weather.data;
console.log('Input data for transformer:', rawData);

// 입력 데이터 유효성 검사
if (!rawData || !Array.isArray(rawData) || rawData.length === 0) {
  console.warn('Raw data is empty or not an array. Returning empty structures.');
  return {
    plotlyTracesMax: [], plotlyTracesMin: [], plotlyTracesAvg: [],
    tableDataMax: [], tableDataMin: [], tableDataAvg: [] // 테이블용 빈 데이터도 반환
  };
}

// 2. 연도별/기간별 데이터 그룹화 및 정렬 준비
const endYear = moment(dateRange_day.value.end || moment()).year();
const oldestYear = endYear - 3;
const uniqueYears = [...new Set(rawData.map(row => row.comparison_year))].sort((a, b) => a - b);
const displayYears = uniqueYears.filter(year => year >= oldestYear && year <= endYear);
const uniquePeriods = [...new Set(rawData.map(row => row.period_start))]
  .sort((a, b) => new Date(a) - new Date(b)); // 날짜/시간 정렬 보장

console.log('Unique Years:', uniqueYears);
console.log('Display Years:', displayYears);
console.log('Unique Periods:', uniquePeriods);

// 3. Plotly Trace 객체 생성 준비
const tracesMax = [];
const tracesMin = [];
const tracesAvg = [];

// 4. 테이블용 데이터 구조 초기화
const tableFormattedData = {
  temp_min: [],
  temp_max: [],
  temp_avg: [],
  // 필요시 rain_amount, snow_amount 추가
};

// 5. 기간별 루프 시작 (테이블 데이터 생성)
uniquePeriods.forEach(period => {
  const periodLabel = moment(period).format('YYYY-MM-DD'); // 표의 날짜 컬럼 기준
  const tempMinEntry = { '날짜': periodLabel };
  const tempMaxEntry = { '날짜': periodLabel };
  const tempAvgEntry = { '날짜': periodLabel };

  displayYears.forEach(year => {
    const yearKey = `${year}년`;
    const tempRecord = rawData.find(record => {
      return (
        record.comparison_year === year &&
        moment(record.period_start).format('YYYY-MM-DD') === periodLabel
      );
    });

    // 테이블용 데이터 할당
    tempMinEntry[yearKey] = tempRecord ? tempRecord.temp_min : null;
    tempMaxEntry[yearKey] = tempRecord ? tempRecord.temp_max : null;
    tempAvgEntry[yearKey] = tempRecord ? tempRecord.temp_avg : null;
  });

  tableFormattedData.temp_min.push(tempMinEntry);
  tableFormattedData.temp_max.push(tempMaxEntry);
  tableFormattedData.temp_avg.push(tempAvgEntry);
});


// 6. 연도별 루프 시작 (Plotly Trace 생성)
displayYears.forEach(year => {
  const yearData = rawData.filter(row => row.comparison_year === year);
  yearData.sort((a, b) => new Date(a.period_start) - new Date(b.period_start));

  const lineStyle = { shape: 'spline', smoothing: 0.7 };
  if (year === oldestYear) {
    lineStyle.dash = 'dot'; // 가장 오래된 해 점선 스타일 유지
  }

  tracesMax.push({
    x: yearData.map(row => row.period_start), y: yearData.map(row => row.temp_max),
    type: 'scatter', mode: 'lines', name: `${year}년`, line: lineStyle
  });
  tracesMin.push({
    x: yearData.map(row => row.period_start), y: yearData.map(row => row.temp_min),
    type: 'scatter', mode: 'lines', name: `${year}년`, line: lineStyle
  });
  tracesAvg.push({
    x: yearData.map(row => row.period_start), y: yearData.map(row => row.temp_avg),
    type: 'scatter', mode: 'lines', name: `${year}년`, line: lineStyle
  });
});

// 7. 최종 결과 반환 (Plotly + 테이블 데이터)
console.log('Final Transformed Data (Table - temp_max):', tableFormattedData.temp_max);
console.log('Final Transformed Data (Plotly - tracesMax):', tracesMax);

return {
  // Plotly 차트용 데이터
  plotlyTracesMax: tracesMax,
  plotlyTracesMin: tracesMin,
  plotlyTracesAvg: tracesAvg,
  // 테이블용 데이터
  tableDataMax: tableFormattedData.temp_max,
  tableDataMin: tableFormattedData.temp_min,
  tableDataAvg: tableFormattedData.temp_avg
};