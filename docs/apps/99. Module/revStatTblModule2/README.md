# revStatTblModule2 모듈 구성 문서

## 개요

`revStatTblModule2`는 Retool의 Global Widget 모듈로, 매출 데이터를 다양한 관점에서 집계하고 분석하여 표시하는 재사용 가능한 컴포넌트입니다. 이 모듈은 사업부별, 온오프라인별, 유통채널별, 팀별, 담당자별, 상품 종목별 등 다양한 차원에서 매출 현황을 분석할 수 있는 기능을 제공합니다.

## 파일 구조

```
revStatTblModule2/
├── main.rsx                    # 메인 모듈 레이아웃 (2142 lines)
├── functions.rsx               # 전역 함수 및 State 정의
├── metadata.json               # 모듈 메타데이터
├── src/                        # 서브 컴포넌트
│   ├── bizModalFrame.rsx       # 사업부 상세 모달
│   ├── onoffModalFrame.rsx     # 온오프라인 상세 모달
│   ├── salesTypeDetailDrawer.rsx  # 유통채널 상세 Drawer
│   ├── salesTypeTblExpandedRow.rsx  # 확장 행 컴포넌트
│   ├── styleTabContainer.rsx   # 스타일별 탭 컨테이너
│   └── tpModalFrame.rsx        # 유통채널 상세 모달
└── lib/                        # 데이터 가공 JavaScript 함수들
    ├── salesByArea.js          # 지역별 매출 집계
    ├── salesByBiz.js           # 사업부별 매출 집계
    ├── salesByFirstLevel.js    # 1차 분류별 매출 집계
    ├── salesByGb.js            # 판매구분별 매출 집계
    ├── salesByOnoff.js         # 온오프라인별 매출 집계
    ├── salesBySalesType.js     # 판매유형별 매출 집계
    ├── salesBySeason.js        # 시즌별 매출 집계
    ├── salesBySecondLevel.js   # 2차 분류별 매출 집계
    ├── salesBySecondLevelWithBiz.js  # 사업부별 2차 분류 매출 집계
    ├── salesByShop.js          # 매장별 매출 집계
    ├── salesByStyle.js         # 스타일별 매출 집계
    ├── salesBySubBrand.js      # 서브브랜드별 매출 집계
    ├── salesBySupply.js        # 공급처별 매출 집계
    ├── salesByTeam.js          # 팀별 매출 집계
    ├── salesByType.js          # 유통채널별 매출 집계
    └── salesByUser.js          # 담당자별 매출 집계
```

---

## 1. 입력 데이터 (GlobalWidgetProp)

모듈은 외부에서 다음 3개의 입력 데이터를 받습니다:

### 1.1 inputData

**타입**: `GlobalWidgetProp`  
**기본값**: `{{ testQuery.data }}`  
**설명**: 메인 매출 데이터. 월별 또는 기간별 매출 정보를 포함합니다.

**데이터 구조 예시**:
```javascript
[
  {
    time_unit: 2025,  // 연도
    biz_cd: "A1",
    biz_nm: "아가방",
    br_cd: "AG",
    br_nm: "아가방",
    tp_group_nm: "직영",
    team_cd: "01",
    team_nm: "팀1",
    user_cd: "U001",
    user_nm: "홍길동",
    area_cd: "A01",
    area_nm: "서울",
    onoff_flag: "오프라인",
    rev: 1000,  // 매출 (백만원 단위)
    target_sales: 1200  // 목표 매출 (백만원 단위)
  },
  // ...
]
```

### 1.2 inputDataByStyle

**타입**: `GlobalWidgetProp`  
**기본값**: `undefined`  
**설명**: 스타일별 상세 매출 데이터. 상품 종목별 분석에 사용됩니다.

**데이터 구조 예시**:
```javascript
[
  {
    time_unit: 2025,
    biz_cd: "A1",
    biz_nm: "아가방",
    sales_type: "정상",
    first_lv_class: "의류",
    second_lv_class: "기초류",
    it: "IT001",
    it_nm: "상품명",
    onoff_flag: "오프라인",
    rev: 500
  },
  // ...
]
```

### 1.3 inputDateRange

**타입**: `GlobalWidgetProp`  
**기본값**: `{"start": "2024-09-01", "end": "2024-12-31"}`  
**설명**: 조회 기간 정보. `thisYear` State 계산에 사용됩니다.

**데이터 구조**:
```javascript
{
  start: "2024-09-01",  // 시작일 (YYYY-MM-DD)
  end: "2024-12-31"     // 종료일 (YYYY-MM-DD)
}
```

---

## 2. 전역 State 및 함수

### 2.1 State

**위치**: `functions.rsx`

#### thisYear
- **계산 로직**: `inputDateRange.value.start`의 연도와 현재 연도 중 작은 값
- **용도**: 연도별 컬럼 표시 및 계산에 사용

#### selectedRow
- **기본값**: `{"team_cd": "01", "biz_cd": "A1"}`
- **용도**: 테이블 행 선택 시 저장되는 선택된 행 데이터

#### selectedSalesRow
- **기본값**: `{"team_cd": "01", "biz_cd": "A1"}`
- **용도**: 매출 상세 분석 시 사용되는 선택된 행 데이터

### 2.2 전역 JavaScript 함수

**위치**: `metadata.json`의 `preloadedAppJavaScript`

#### groupBySum(arr, groupKeys, sumKeys)
- **기능**: 배열을 그룹화하여 합계 계산
- **파라미터**:
  - `arr`: 입력 배열
  - `groupKeys`: 그룹화할 키 배열
  - `sumKeys`: 합계를 계산할 키 배열
- **반환**: 그룹화된 객체 배열

#### pivotData(data, groupKeys, pivotKey, sumKeys)
- **기능**: 데이터를 피벗 테이블 형태로 변환
- **파라미터**:
  - `data`: 입력 데이터
  - `groupKeys`: 그룹화할 키 배열
  - `pivotKey`: 피벗할 키 (연도 등)
  - `sumKeys`: 합계를 계산할 키 배열
- **반환**: 피벗된 객체 배열

---

## 3. 데이터 가공 함수 (lib/)

모든 데이터 가공 함수는 공통 패턴을 따릅니다:

1. `inputData` 또는 `inputDataByStyle`에서 데이터 추출
2. `formatDataAsArray()`로 배열 변환
3. 필터링 (오프라인만, 선택된 사업부만 등)
4. `groupBySum()`으로 그룹화 및 합계 계산
5. `pivotData()`로 연도별 피벗 변환
6. 목표 매출 데이터 병합
7. 정렬 및 필터링

### 3.1 salesByBiz.js

**기능**: 사업부별 매출 집계

**처리 과정**:
```javascript
1. inputData에서 오프라인 데이터만 필터링
2. time_unit + biz_cd + biz_nm로 그룹화하여 rev 합계
3. 현재 연도의 목표 매출(target_sales) 별도 집계
4. time_unit을 피벗하여 연도별 컬럼 생성
5. 목표 매출 데이터 병합
```

**출력 데이터 구조**:
```javascript
[
  {
    biz_cd: "A1",
    biz_nm: "아가방",
    2025: 10000,  // 2025년 매출
    2024: 9500,   // 2024년 매출
    2023: 9000,   // 2023년 매출
    target_sales: 12000  // 목표 매출
  },
  // ...
]
```

### 3.2 salesByOnoff.js

**기능**: 온오프라인별 매출 집계

**처리 과정**:
```javascript
1. inputData 전체 데이터 사용
2. time_unit + onoff_flag로 그룹화
3. 피벗 변환 및 목표 매출 병합
4. 현재 연도 매출이 있는 데이터만 필터링
5. onoff_flag로 정렬 (오프라인 → 온라인)
```

### 3.3 salesByType.js

**기능**: 유통채널별(tp_group_nm) 매출 집계

**처리 과정**:
```javascript
1. 오프라인 데이터만 필터링
2. time_unit + tp_group_nm로 그룹화
3. 피벗 변환 및 목표 매출 병합
4. 현재 연도 매출 또는 목표 매출이 있는 데이터만 필터링
```

### 3.4 salesByTeam.js

**기능**: 팀별 매출 집계

**처리 과정**:
```javascript
1. 오프라인 데이터만 필터링
2. time_unit + team_cd + team_nm로 그룹화
3. 피벗 변환 및 목표 매출 병합
4. 현재 연도 매출 또는 목표 매출이 있는 데이터만 필터링
5. 목표 매출 기준 내림차순 정렬
```

### 3.5 salesByUser.js

**기능**: 담당자별 매출 집계

**처리 과정**:
- `salesByTeam.js`와 유사하지만 `user_cd`, `user_nm`으로 그룹화

### 3.6 salesByArea.js

**기능**: 지역별 매출 집계

**처리 과정**:
```javascript
1. selectedRow.value.onoff_flag에 따라 필터링
2. time_unit + area_cd + area_nm로 그룹화
3. 피벗 변환 및 목표 매출 병합
4. 2025년 매출 기준 내림차순 정렬
```

### 3.7 salesByStyle.js

**기능**: 스타일별 매출 집계 (시즌, 연령, 아이템 등)

**처리 과정**:
```javascript
1. inputDataByStyle에서 오프라인 데이터만 필터링
2. selectedRow.value.biz_cd로 사업부 필터링
3. it_nm, it_gb_nm, item_nm이 있는 데이터만 필터링
4. styleTabContainer.currentViewKey에 따라 다른 그룹화:
   - season: year_cd, year_nm
   - season_detail: season_nm, season_seq, year_cd, year_nm
   - it: it, it_nm
   - it_gb: it, it_nm, it_gb, it_gb_nm
   - item: it, it_nm, it_gb, it_gb_nm, item, item_nm
5. 시즌별 상세의 경우 season_seq 계산 (겨울=0, 가을=1, 여름=2, 봄=3, 사계절=4)
6. 피벗 변환
7. 현재 연도 매출이 있는 데이터만 필터링
8. viewConfig에 정의된 정렬 함수로 정렬
```

### 3.8 salesBySecondLevel.js

**기능**: 2차 분류별 매출 집계

**처리 과정**:
```javascript
1. inputDataByStyle에서 오프라인 데이터만 필터링
2. selectedRow.value.biz_cd로 사업부 필터링
3. time_unit + sales_type + first_lv_class + second_lv_class로 그룹화
4. 피벗 변환
5. first_lv_class, second_lv_class로 정렬
```

### 3.9 salesBySecondLevelWithBiz.js

**기능**: 사업부별 2차 분류 매출 집계 (전년 대비 신장율 포함)

**처리 과정**:
```javascript
1. inputDataByStyle에서 오프라인 데이터만 필터링
2. transformSalesData:
   - biz_cd + time_unit + second_lv_class로 그룹화
   - second_lv_class를 컬럼명으로 사용하여 피벗
3. calculateYoYGrowth:
   - 최신 연도와 전년도 데이터 추출
   - 각 카테고리별 전년 대비 신장율 계산
   - 신장율 = ((올해매출 - 작년매출) / 작년매출) * 100
```

**출력 데이터 구조**:
```javascript
[
  {
    biz_cd: "A1",
    biz_nm: "아가방",
    sale_yr: 2025,
    기초류: 1000,
    외의류: 2000,
    발육: 500,
    기초류신장율: 10.5,  // 전년 대비 신장율 (%)
    외의류신장율: -5.2,
    // ...
  },
  // ...
]
```

---

## 4. 프론트엔드 컴포넌트 구조

### 4.1 메인 레이아웃

**위치**: `main.rsx`

모듈은 다음과 같은 섹션으로 구성됩니다:

1. **사업부별 매출 현황** (`typeStatTbl`)
2. **온오프라인 매출 현황** (`typeStatTbl3`)
3. **유통채널, 팀, 담당자별 매출 현황** (`salesTabbedContainer`)
4. **상품 종목별 매출상세** (`salesBySecondLevelTbl`)

### 4.2 테이블 공통 구조

모든 테이블은 다음 컬럼 구조를 공유합니다:

#### 기본 컬럼
- **분류 컬럼**: 사업부명, 온오프라인, 유통채널 등 (각 테이블마다 다름)
- **{{thisYear}}실적**: 현재 연도 매출 (예: 25실적)
- **{{thisYear}}목표**: 현재 연도 목표 매출
- **목표달성율**: (실적 / 목표) * 100
- **목표차액**: 실적 - 목표
- **{{thisYear-1}}실적**: 전년도 매출
- **{{thisYear-1}}대비신장율**: ((올해 / 작년) - 1) * 100
- **{{thisYear-1}}대비신장액**: 올해 - 작년
- **{{thisYear-2}}실적**: 2년 전 매출
- **{{thisYear-2}}대비신장율**: ((올해 / 2년전) - 1) * 100
- **{{thisYear-2}}대비신장액**: 올해 - 2년전

#### 스타일링
- **목표달성율**: 1 미만일 때 빨간색 배경, 1 이상일 때 초록색 배경
- **신장율**: 양수일 때 초록색, 음수일 때 빨간색
- **목표차액**: 양수일 때 초록색, 음수일 때 빨간색

### 4.3 사업부별 매출 현황 테이블

**ID**: `typeStatTbl`  
**데이터**: `{{ salesByBiz.value }}`

**특징**:
- 행 클릭 시 `bizModalFrame` 모달 표시
- 선택된 행은 `selectedRow` State에 저장

### 4.4 온오프라인 매출 현황 테이블

**ID**: `typeStatTbl3`  
**데이터**: `{{ salesByOnoff.value }}`

**특징**:
- 행 클릭 시 `onoffModalFrame` 모달 표시
- 온라인 매출은 "온라인 전용 매장의 매출"임을 주석으로 표시

### 4.5 유통채널, 팀, 담당자별 매출 현황

**컨테이너**: `salesTabbedContainer`  
**탭 구조**:
1. **유통채널별** (`typeStatTbl2`): `salesByType.value`
2. **팀별** (`typeStatTbl26`): `salesByTeam.value`
3. **담당자별** (`typeStatTbl27`): `salesByUser.value`

**특징**:
- 각 탭의 테이블은 Summary Row 표시
- 행 클릭 시 `tpModalFrame` 모달 표시

### 4.6 상품 종목별 매출상세 테이블

**ID**: `salesBySecondLevelTbl`  
**데이터**: `{{ salesBySecondLevelWithBiz.value }}`

**컬럼 구조**:
- **사업부**: biz_nm
- **기초류, 외의류, 발육, 섬유공산품, 시즌용품, 일반용품위탁, 하드류, 기타**: 각 카테고리별 매출
- 각 컬럼의 caption에 신장율 표시 (예: "10.5%")
- 신장율이 양수면 초록색, 음수면 빨간색 텍스트

---

## 5. 데이터 흐름

### 5.1 전체 데이터 흐름도

```
[외부 앱]
    ↓
[inputData, inputDataByStyle, inputDateRange 전달]
    ↓
[모듈 로드]
    ↓
[functions.rsx 실행]
    ├─ thisYear State 계산
    ├─ selectedRow State 초기화
    └─ 데이터 가공 함수들 정의
    ↓
[각 함수 실행]
    ├─ formatDataAsArray()
    ├─ 필터링
    ├─ groupBySum()
    ├─ pivotData()
    └─ 목표 매출 병합
    ↓
[테이블 컴포넌트에 데이터 바인딩]
    ↓
[사용자 인터랙션]
    ├─ 행 클릭 → 모달 표시
    ├─ 셀 클릭 → 상세 쿼리 실행
    └─ 엑셀 다운로드
```

### 5.2 데이터 가공 파이프라인

각 데이터 가공 함수는 다음 파이프라인을 따릅니다:

```
원본 데이터 (inputData/inputDataByStyle)
    ↓
formatDataAsArray() → 배열 변환
    ↓
필터링 (오프라인만, 선택된 사업부만 등)
    ↓
groupBySum() → 그룹화 및 합계 계산
    ↓
pivotData() → 연도별 피벗 변환
    ↓
목표 매출 병합 (현재 연도 데이터에서)
    ↓
추가 필터링 및 정렬
    ↓
최종 결과 (테이블에 표시)
```

### 5.3 상호작용 흐름

#### 행 클릭 시:
```
사용자가 테이블 행 클릭
    ↓
selectedRow State 업데이트
    ↓
해당 모달/드로어 표시
    ↓
모달 내부에서 selectedRow.value 사용하여 상세 데이터 조회
```

#### 셀 클릭 시:
```
사용자가 매출 셀 클릭
    ↓
testQuery 실행 (상세 데이터 조회)
    ↓
상세 정보 표시
```

---

## 6. 주요 특징

### 6.1 재사용성

- Global Widget로 설계되어 여러 앱에서 재사용 가능
- `inputData`, `inputDataByStyle`, `inputDateRange`만 전달하면 동작

### 6.2 데이터 가공의 일관성

- 모든 가공 함수가 동일한 패턴 사용 (`groupBySum` → `pivotData`)
- 일관된 데이터 구조로 유지보수 용이

### 6.3 확장성

- 새로운 집계 함수 추가 시 `lib/`에 JavaScript 파일 추가
- `functions.rsx`에 Function 정의만 추가하면 사용 가능

### 6.4 사용자 경험

- 목표달성율, 신장율 등에 색상 코딩으로 직관적 표시
- 모달/드로어를 통한 상세 정보 제공
- 엑셀 다운로드 기능 제공

---

## 7. 사용 예시

### 7.1 모듈 사용 방법

```rsx
<Module
  id="revStatTblModule2"
  inputData="{{ monthlySalesQuery.data }}"
  inputDataByStyle="{{ monthlySalesByStyleQuery.data }}"
  inputDateRange="{{ dateRange.value }}"
  name="revStatTblModule2"
  pageUuid="c2c2b498-f99c-11ef-b77a-2ba139bbf501"
/>
```

### 7.2 데이터 형식 요구사항

**inputData**는 최소한 다음 필드를 포함해야 합니다:
- `time_unit`: 연도 (숫자)
- `rev`: 매출 (숫자, 백만원 단위)
- `target_sales`: 목표 매출 (숫자, 백만원 단위)
- `onoff_flag`: "오프라인" 또는 "온라인"
- 집계 기준 필드 (biz_cd, team_cd, user_cd 등)

**inputDataByStyle**은 다음 필드를 포함해야 합니다:
- `time_unit`: 연도
- `biz_cd`: 사업부 코드
- `onoff_flag`: "오프라인" 또는 "온라인"
- `second_lv_class`: 2차 분류 (기초류, 외의류 등)
- `rev`: 매출

---

## 8. 모달 및 드로어

### 8.1 bizModalFrame

- **트리거**: 사업부별 테이블 행 클릭
- **기능**: 선택된 사업부의 상세 매출 정보 표시

### 8.2 onoffModalFrame

- **트리거**: 온오프라인 테이블 행 클릭
- **기능**: 선택된 온오프라인 구분의 상세 매출 정보 표시

### 8.3 tpModalFrame

- **트리거**: 유통채널/팀/담당자 테이블 행 클릭
- **기능**: 선택된 유통채널/팀/담당자의 상세 매출 정보 표시

### 8.4 salesTypeDetailDrawer

- **트리거**: 특정 셀 클릭 또는 이벤트
- **기능**: 판매 유형별 상세 정보를 Drawer 형태로 표시

---

## 요약

`revStatTblModule2` 모듈은:

1. **입력**: `inputData`, `inputDataByStyle`, `inputDateRange` 3개의 입력 데이터
2. **가공**: 16개의 JavaScript 함수로 다양한 차원의 매출 집계
3. **표시**: 4개의 주요 테이블 섹션으로 구성된 UI
4. **상호작용**: 모달/드로어를 통한 상세 정보 제공 및 엑셀 다운로드

이 모듈은 매출 데이터를 다양한 관점에서 분석할 수 있는 강력한 도구이며, 재사용 가능한 구조로 설계되어 여러 앱에서 활용할 수 있습니다.

