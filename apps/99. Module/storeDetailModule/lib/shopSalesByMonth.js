
// --- 1. 전역 설정 (Global Configuration) ---
const YEARS_TO_PROCESS = 3;
const MONTH_KEYS = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
const ALL_BRANCHES_CODE = '-1';

// --- 2. 지표 설정 (Metric Configuration) ---
const METRIC_CONFIG = [
    {
        key: 'sales',
        sourceField: 'sales_price',
        label: '실적',
        isPrimary: true,
    },
    {
        key: 'tag',
        sourceField: 'tag_price',
        label: 'TAG가',
    },
    {
        key: 'costRate',
        label: '원가율',
        isDerived: true,
        isRate: true,
        calculation: {
            numerator: 'cost',
            denominator: 'tag',
        },
    },
    {
        key: 'cost',
        sourceField: 'cost_price',
        label: '원가',
    },
];

// --- 3. 헬퍼 함수 (Helper Functions) ---

const nullifyZero = value => (isNaN(value) || value === 0) ? null : value;

const createEmptyMonthlyRecord = () => {
    const record = { total: 0 };
    MONTH_KEYS.forEach(key => record[key] = 0);
    return record;
};

function aggregateAllMetricsByYear(filteredData, config) {
    const dataByYear = new Map();
    const sumFields = config.filter(m => !m.isDerived);

    filteredData.forEach(item => {
        const year = parseInt(item.year_month.split('-')[0], 10);
        const monthIndex = parseInt(item.year_month.split('-')[1], 10) - 1;
        const monthKey = MONTH_KEYS[monthIndex];

        if (!dataByYear.has(year)) {
            const yearRecord = {};
            sumFields.forEach(field => {
                yearRecord[field.key] = createEmptyMonthlyRecord();
            });
            dataByYear.set(year, yearRecord);
        }

        const yearData = dataByYear.get(year);
        sumFields.forEach(field => {
            const value = Number(item[field.sourceField]) || 0;
            yearData[field.key][monthKey] += value;
            yearData[field.key].total += value;
        });
    });

    return dataByYear;
}

function getConsolidatedTarget(targetData, targetBrCd) {
    if (!targetData || targetData.length === 0) return null;

    if (targetBrCd === ALL_BRANCHES_CODE) {
        const totalTarget = createEmptyMonthlyRecord();
        targetData.forEach(item => {
            Object.keys(totalTarget).forEach(key => {
                totalTarget[key] += (Number(item[key]) || 0);
            });
        });
        return totalTarget;
    } else {
        return targetData.find(item => item.biz_cd === targetBrCd) || null;
    }
}

function createMetricRow(base, compare, label, operator, isRate = false) {
    const result = { '구분': label, 'br_cd': base.br_cd };
    if (!base || !compare) return null;

    ['total', ...MONTH_KEYS].forEach(key => {
        const baseVal = base[key] || 0;
        const compareVal = compare[key] || 0;

        if (compareVal === 0 && isRate) {
            result[key] = null;
        } else {
            result[key] = nullifyZero(operator(baseVal, compareVal));
        }
    });
    return result;
}

function createDataRow(label, brCd, data) {
    const row = { '구분': label, 'br_cd': brCd };
    ['total', ...MONTH_KEYS].forEach(key => {
        row[key] = nullifyZero(data?.[key]);
    });
    return row;
}

/**
 * 특정 연도에 해당하는 리포트 행들의 묶음(Block)을 생성합니다.
 * @param {number} year - 생성할 연도 (e.g., 2025)
 * @param {object} context - 리포트 생성에 필요한 데이터 및 설정값
 * @returns {Array<object>} 해당 연도의 모든 리포트 행 배열
 */
function createYearlyReportBlock(year, context) {
    const { currentYear, aggregatedData, targetData, targetBrCd, branchDisplayName, currentSalesRow } = context;

    const yearSlice = String(year).slice(2);
    const yearData = aggregatedData.get(year);
    if (!yearData) return [];

    const yearlyReportRows = [];

    // Step 1: 해당 연도의 모든 기본 지표 행(실적, 원가, 정가 등)을 미리 생성
    const yearRows = {};
    METRIC_CONFIG.filter(m => !m.isDerived).forEach(metric => {
        if (yearData[metric.key]) {
            yearRows[metric.key] = createDataRow(
                `${yearSlice}년 ${metric.label}`,
                branchDisplayName,
                yearData[metric.key]
            );
        }
    });

    // Step 2: 순서에 맞춰 리포트 행 추가
    const salesRowForYear = yearRows.sales;
    if (!salesRowForYear) return [];

    yearlyReportRows.push(salesRowForYear);

    // '목표/신장률' 관련 행 추가
    if (year === currentYear) {
        const consolidatedTarget = getConsolidatedTarget(targetData, targetBrCd);
        if (consolidatedTarget) {
            const targetRow = createDataRow(`${yearSlice}년 목표`, branchDisplayName, consolidatedTarget);
            yearlyReportRows.push(
                targetRow,
                createMetricRow(salesRowForYear, targetRow, '목표달성율', (a, b) => a / b, true),
                createMetricRow(salesRowForYear, targetRow, '목표차액', (a, b) => a - b)
            );
        }
    } else {
        yearlyReportRows.push(
            createMetricRow(currentSalesRow, salesRowForYear, `${yearSlice}년 대비 신장율`, (a, b) => a / b - 1, true),
            createMetricRow(currentSalesRow, salesRowForYear, `${yearSlice}년 대비 신장액`, (a, b) => a - b)
        );
    }

    // TAG가', '원가율', '원가' 행 추가
    if (yearRows.tag) yearlyReportRows.push(yearRows.tag);
    if (yearRows.cost && yearRows.tag) {
        yearlyReportRows.push(
            createMetricRow(yearRows.cost, yearRows.tag, `${yearSlice}년 원가율`, (a, b) => a / b, true)
        );
    }
  if (yearRows.cost) yearlyReportRows.push(yearRows.cost);

    return yearlyReportRows;
}


// --- 4. 메인 실행 로직 (Main Execution Logic) ---
const salesData = formatDataAsArray({{ shopSalesByBrandByMonth.data }});
const targetBrCd = {{ tabs2.value }};
const targetData = {{ shopTargetSalesByMonth.data }};
const currentYear = {{ moment(startDate.value).year() }};

const finalReport = [];
const isTotal = targetBrCd === ALL_BRANCHES_CODE;
const branchDisplayName = isTotal ? '전체' : targetBrCd;

// 1. 데이터 준비
const relevantSalesData = isTotal ? salesData : salesData.filter(item => item.br_cd === targetBrCd);
const aggregatedData = aggregateAllMetricsByYear(relevantSalesData, METRIC_CONFIG);

// 2. 리포트 생성
const currentYearAggregatedData = aggregatedData.get(currentYear);
if (!currentYearAggregatedData) return [];

const currentSalesRow = createDataRow(
    `${String(currentYear).slice(2)}년 실적`,
    branchDisplayName,
    currentYearAggregatedData.sales
);

// 리포트 생성에 필요한 모든 정보를 context 객체로 묶어서 전달
const reportContext = {
    currentYear,
    aggregatedData,
    targetData,
    targetBrCd,
    branchDisplayName,
    currentSalesRow
};

for (let i = 0; i < YEARS_TO_PROCESS; i++) {
    const year = currentYear - i;
    const yearlyReportBlock = createYearlyReportBlock(year, reportContext);
    finalReport.push(...yearlyReportBlock);
}

return finalReport.filter(row => row);