# 이월상품 판매현황 앱 - 데이터 흐름 및 로직 정리

## 1. 개요
이 앱은 시즌 종료 후 판매되는 이월상품의 판매율을 추적하는 대시보드입니다.
- **이월**: 상품이 신상으로 출시된 시즌이 종료된 이후의 판매
- **판매율**: (판매량 / 출고량) × 100

## 2. 전체 데이터 흐름도

```
사용자 인터랙션 (사이드바)
    ↓
[get2YearsResult.js] - 메인 데이터 로더
    ↓
┌─────────────────────────────────────────────────┐
│ 1단계: 기본 정보 조회                            │
│ - getOutEndDate.sql: 출고 마감일 계산            │
│ - yearSelect2: 시즌 선택                        │
└─────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────┐
│ 2단계: 6개 쿼리 병렬 실행 (Promise.all)        │
│                                                 │
│ 현재년도 데이터:                                │
│ - getShopSaleByCategory: 현재 판매 (온+오프라인) │
│ - getShopOutByCategory: 현재 출고 (오프라인만)    │
│ - getOnlineWarehouseByCategory: 온라인 창고     │
│                                                 │
│ 전년 동기 데이터:                               │
│ - getShopSaleByCategory: 전년 판매 (온+오프라인) │
│ - getShopOutByCategory: 전년 출고 (오프라인만)   │
│ - getOnlineWarehouseByCategory: 전년 온라인창고  │
└─────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────┐
│ 3단계: 데이터 병합 및 가공                       │
│                                                 │
│ 현재년도:                                       │
│ ├─ processCurrentOnlineWarehouse.js: 온라인 전처리│
│ ├─ mergeCurOutSale.js: 온라인+오프라인 모두 병합│
│ │   (출고 9개 필드 + 판매 3개 필드)             │
│ └─ groupByCategory.js: 탭별 처리               │
│                                                 │
│ 전년 동기:                                      │
│ ├─ processPrevOnlineWarehouse.js: 온라인 전처리 │
│ ├─ mergePrevOutSale.js:                         │
│ │   - 온라인+오프라인 모두 병합                 │
│ │   - 탭별 온라인 처리 (온라인/합계) 포함        │
│ └─ groupByGrade.js / groupByShop.js: 등급/매장별│
│                                                 │
│ 요약:                                           │
│ └─ summaryData.js: 전년 대비 비교              │
└─────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────┐
│ 4단계: UI 표시 (탭별 필터링)                     │
│                                                 │
│ 합계 탭: 전체 판매 + (오프라인 출고 + 온라인 창고)│
│ 오프라인 탭: 오프라인만 (판매+출고)             │
│ 온라인 탭: 온라인 판매 + 온라인 창고 출고       │
└─────────────────────────────────────────────────┘
```

### 핵심 병합 로직 요약

**데이터 소스 (3가지)**:
1. **판매 데이터** (`getShopSaleByCategory`): 온라인+오프라인 모두 포함
2. **출고 데이터** (`getShopOutByCategory`): 오프라인만 (본사→매장)
3. **온라인 창고 데이터** (`getOnlineWarehouseByCategory`): 온라인만 (창고 이동)

**병합 전략**:
- **1단계**: 판매 + 출고 병합 (mergeCurOutSale.js / mergePrevOutSale.js 1단계)
  - 오프라인 출고는 출고 데이터에 있음
  - 온라인 출고는 아직 없음 (출고 데이터에 온라인 없음)
- **2단계**: 탭별 온라인 처리 (groupByCategory.js / mergePrevOutSale.js 2단계)
  - **오프라인**: 그대로 사용
  - **온라인**: 온라인 창고 데이터로 출고량 교체
  - **합계**: 전체 - 소스온라인 출고 + 타겟온라인 출고

## 3. 핵심 로직 상세 설명

### 3.1 출고 데이터의 복잡성과 해결 방법

출고 데이터가 시점마다 변화하는 이유:
1. **시즌 초반**: 초도 분배 (본사 → 매장)
2. **시즌 중**: 행사 진행으로 인한 추가 출고
3. **시즌 종료 후**: 전면 반품 (매장 → 본사)

**해결 방법**: `getShopOutByCategory.sql`에서 구간별 필터링
```sql
-- net_period_flag: 순출고 기간 (시즌종료일 ~ 출고마감일)
-- ttl_period_flag: 전체 출고기간 (시즌종료일 ~ 판매마감일)
```

### 3.2 온라인/오프라인 통합 로직 ⚠️ 복잡

#### 데이터 소스의 특성

1. **판매 데이터** (`getShopSaleByCategory`):
   - 온라인+오프라인 모두 포함
   - `daily_shop_sales_by_dimension` 테이블에서 조회
   - `sales_type='이월'` 조건 적용

2. **출고 데이터** (`getShopOutByCategory`):
   - 오프라인만 포함 (본사→매장)
   - `dsoutrtn` 테이블에서 조회
   - 온라인 데이터 없음

3. **온라인 창고 데이터** (`getOnlineWarehouseByCategory`):
   - 온라인만 포함 (창고 이동)
   - `dsmove` + `dsin` 테이블에서 조회
   - 판매 데이터는 별도

#### 탭별 병합 전략

**오프라인 탭**:
```
출고 데이터 (오프라인만)
    ↓
판매 데이터와 병합 (16개 기준 컬럼)
    ↓
오프라인 데이터만 필터링
    ↓
카테고리별 집계
```

**온라인 탭**:
```
[판매] 온라인 데이터 추출 (data에서 onoff_flag='온라인')
    ↓
[출고] 온라인 창고 데이터 (online_data)
    ↓
출고량만 교체 (판매량은 그대로)
    ↓
카테고리별 집계
```

**합계 탭** (가장 복잡):
```javascript
// 1단계: 전체 데이터 합산
전체 = groupBySum(전체 판매 + 전체 출고)

// 2단계: 소스 온라인 출고 추출 (빼줄 값)
소스온라인 = 전체 데이터 중 onoff_flag='온라인' 출고량

// 3단계: 타겟 온라인 출고 추출 (더해줄 값)
타겟온라인 = 온라인 창고 데이터 출고량

// 4단계: 최종 계산
최종출고 = 전체출고 - 소스온라인출고 + 타겟온라인출고

// 이유: 판매량은 전체 그대로, 
//      출고량은 (오프라인 출고 + 온라인 창고 출고)로 교체
```

#### 왜 이렇게 복잡한가?

- **온라인 판매**는 `sales` 테이블에 있음 (조건: `sales_type='이월'`)
- **온라인 출고**는 본사 창고 이동 기준 (`dsmove`, `dsin`)
- **오프라인 출고**는 본사→매장 이동 (`dsoutrtn`)
- 각각 다른 데이터 소스여서 통합 로직 필요

### 3.3 전년 동기 비교 로직

전년 동기 데이터 계산 방식:
```javascript
// 전년 동일 시즌의 데이터를 1년 뺀 날짜로 조회
prevSeasonEndDate = moment(seasonEndDate).subtract(1, 'year')
prevYearCodes = yearSelect2.selectedItem.prev_year_codes
```

## 4. 파일별 역할 정리

### 4.1 SQL 쿼리 파일들

#### `getSeasonEndDate.sql`
- **목적**: 이월상품이 될 수 있는 시즌 목록 조회
- **출력**: season_end_dt, year_codes, prev_year_codes 등
- **특징**: 
  - sales_type='이월' 조건으로 필터링
  - 전년도 year_codes와 prev_year_codes 자동 계산

#### `getOutEndDate.sql`
- **목적**: 출고 마감일 산정 (복잡한 비즈니스 로직)
- **로직**:
  ```sql
  CASE 
    WHEN net_out_qty <= 10000 THEN 어제
    WHEN 오늘 > 시즌종료일 THEN 시즌종료일
    ELSE 초도 출고가 가장 많은 월의 말일
  END
  ```

#### `getShopSaleByCategory.sql`
- **목적**: 판매 데이터 조회
- **기간**: 시즌종료일 ~ 판매마감일
- **조건**: sales_type='이월'
- **출력**: sale_tag, sale_qty, sale_amt

#### `getShopOutByCategory.sql`
- **목적**: 출고/반품 데이터 조회
- **복잡한 기간 처리**:
  - net_period_flag: 순출고 기간 (시즌종료일 ~ 출고마감일)
  - ttl_period_flag: 전체 출고 기간 (시즌종료일 ~ 판매마감일)
- **출력**: net_out_qty, ttl_out_qty, ttl_rtn_qty 등

#### `getOnlineWarehouseByCategory.sql`
- **목적**: 온라인 창고(3000) 이동 데이터
- **조인**: dsmove + dsin 테이블
- **출력**: 온라인 출고/반품 수량 및 금액
- **기간**: `seasonEndDate ~ endDate` (판매마감일까지 조회)
  - 오프라인과 달리 기간 플래그가 없어 `net`, `ttl` 구분 없이 전체 기간 조회
  - `ttl_out_qty`는 전체 기간 출고량 의미

### 4.2 JavaScript 처리 파일들

#### `get2YearsResult.js` ⭐ 핵심
- **역할**: 모든 데이터를 로드하는 진입점
- **프로세스**:
  1. 출고마감일 조회
  2. 6개 쿼리 병렬 실행 (현재+전년, 판매+출고+온라인)
  3. 결과를 varResult 변수에 저장

#### `mergeCurOutSale.js` ⚠️ 중요
- **역할**: 현재년도 **온라인+오프라인** 판매 + 출고 데이터 병합
- **병합 방식**: full outer join (Map 기반)
  ```javascript
  // 16개 기준 컬럼으로 키 생성
  mergeFields = ["biz_cd", "biz_nm", "br_cd", ..., "category_name", "item_grade"]
  key = "biz_cd|biz_nm|br_cd|..." (파이프 구분자)
  
  // 출고 전용 필드 (9개)
  outFields = ["net_out_qty", "net_out_tag", "net_out_amt", 
               "ttl_out_qty", "ttl_rtn_qty", ...]
  
  // 판매 전용 필드 (3개)
  saleFields = ["sale_tag", "sale_qty", "sale_amt"]
  ```
- **주의**: 
  - 온라인+오프라인 모두 병합됨
  - 출고 데이터는 오프라인만 있으므로 온라인 부분은 출고량 0
  - 탭별 구분은 `groupByCategory.js`에서 처리

#### `mergePrevOutSale.js` ⚠️ 중요
- **역할**: 전년 동기 온라인+오프라인 병합 + 탭별 온라인 처리 포함
- **1단계** (1-55줄): `mergeCurOutSale.js`와 동일하게 온라인+오프라인 모두 병합
- **2단계** (58-184줄): **탭 선택에 따라 온라인 데이터 처리**
  
  **오프라인 탭 (71-74줄)**:
  ```javascript
  data.filter(i => i.onoff_flag === '오프라인')
  // 온라인 데이터 필터링 후 그룹핑
  ```
  
  **온라인 탭 (76-101줄)**: 
  ```javascript
  // 판매량: data의 온라인 데이터 사용
  // 출고량: online_data(온라인창고)로 덮어쓰기
  netOutKeys.forEach(netKey => {
    item[netKey] = targetData[netKey] || 0; // 창고 출고로 교체
  });
  ```
  
  **합계 탭 (104-138줄)**: 
  ```javascript
  // 전체 합계 = 전체 데이터 - 소스온라인 출고 + 타겟온라인 출고
  item[netKey] = initialValue - sourceValue + targetValue;
  // 이유: 판매량은 전체 사용, 출고량은 오프라인+온라인창고
  ```
  
- **특징**: 현재년도(`groupByCategory.js`)와 달리, 전년 동기는 이 파일에서 탭별 처리까지 완료

#### `processCurrentOnlineWarehouse.js` / `processPrevOnlineWarehouse.js`
- **역할**: 온라인 창고 데이터 전처리
- **처리**: 브랜드 필터 → 카테고리별 그룹화
- **출력**: `["br_cd", "year_cd", "season_cd", "category_name"]` 기준 집계

#### `groupByCategory.js` ⚠️ 핵심
- **역할**: 탭별로 다른 데이터 병합 로직 적용
- **입력**: 
  - `mergeCurOutSale.value` (현재) / `mergePrevOutSale.value` (전년)
  - `processCurrentOnlineWarehouse.value` (현재) / `processPrevOnlineWarehouse.value` (전년)
  
- **탭별 처리 로직** (18-86줄):
  
  **1. 오프라인 탭**:
  - `data.filter(i => i.onoff_flag === '오프라인')` 
  - 오프라인만 그룹핑
  
  **2. 온라인 탭**:
  - 판매량: data의 온라인 판매 데이터
  - 출고량: online_data로 출고량 교체
  - Map 기반 매칭: `br_cd-year_cd-season_cd-category_name`
  
  **3. 합계 탭** (가장 복잡):
  ```javascript
  // 전체 합산
  allGrouped = groupBySum(data, keys, sumKeys);
  
  // 소스 온라인 출고 (빼줄 값)
  onlineSourceMap = groupBySum(온라인만 필터, ...)
  
  // 타겟 온라인 출고 (더해줄 값)  
  onlineTargetMap = groupBySum(online_data, ...)
  
  // 최종: 전체 - 소스온라인 + 타겟온라인
  item[netKey] = initialValue - sourceValue + targetValue;
  ```
  
- **소계/총계 추가** (88-184줄):
  - 등급별 소계 추가 (`item_grade` 기준)
  - 총계 행 추가

#### `groupByGrade.js` / `groupByShop.js`
- **역할**: 등급별/매장별 집계
- **입력**: `mergeCurOutSale.value` (현재년도만)
- **사용처**: splitPaneFrame1의 상세 테이블
- **참고**: 전년 동기는 `mergePrevOutSale.value`를 직접 사용

#### `summaryData.js`
- **역할**: 전년 대비 요약 테이블 생성
- **입력**: 
  - `groupByCategory.value` (현재년도, 탭별 처리됨)
  - `mergePrevOutSale.value` (전년 동기, 탭별 처리됨)
- **출력**: [조회기간, 전년동기, 증감대비] 3행
- **특징**: 탭 변경 시 자동으로 재계산 (ReTool의 반응형 특성)

## 5. 사용자 인터랙션 흐름

### 5.1 사이드바 필터

1. **사업부 선택** (`bizMultiSelect2`)
   - 전체 매장 정보에서 사업부 필터링
   - change 이벤트 → get2YearsResult 트리거

2. **브랜드 선택** (`brandMultiSelect2`)
   - 선택된 사업부의 브랜드만 표시
   - change 이벤트 → get2YearsResult 트리거

3. **기준년도 선택** (`yearSelect2`)
   - getSeasonEndDate 데이터에서 선택
   - 기본값: getDefaultSeason (최근 30일 판매량 기준)
   - 변경 시 → get2YearsResult 트리거

4. **판매마감일** (`endDate`)
   - 기본값: 어제
   - 변경 시 → get2YearsResult 트리거

5. **기간 누적 출고/반품 보기** (`switch1`)
   - true: ttl_out_qty, ttl_rtn_qty 표시
   - false: net_out_qty만 표시

### 5.2 메인 컨텐츠

#### 탭 구조 (`tabbedContainer1`)
- **합계**: 오프라인+온라인 통합 (기본)
- **오프라인**: 오프라인만
- **온라인**: 온라인만

#### 테이블들

**table20 (요약 테이블)**
- 데이터: summaryData
- 표시: 조회기간 vs 전년동기 vs 증감대비

**table2 (등급별 판매현황)**
- 데이터: groupByCategory
- 행 클릭 → splitPaneFrame1 팝업
- 표시 컬럼: 등급, 대분류, 판매수량, 판매율 등

### 5.3 상세 조회 (splitPaneFrame1)

테이블 행 클릭 시:
1. `varSelectedRow`에 선택 행 저장
2. `toggleButton1` = true (사이드바 확장)
3. `splitPaneFrame1` 표시
4. 선택된 등급/카테고리별 매장 목록 표시

데이터 로드 (`shopDetailData.js`):
- category_name이 '소계' → 등급별 집계
- category_name이 '총계' → 매장별 집계
- 일반 카테고리 → 해당 카테고리 매장만

## 6. 주요 비즈니스 로직

### 6.1 판매율 계산
```
판매율(금액) = 판매금액 / 순출고금액
판매율(수량) = 판매수량 / 순출고수량
```

### 6.2 할인율 계산
```
할인율(판매) = 1 - (판매금액 / 실판매금액)
할인율(출고) = 1 - (순출고금액실판가 / 순출고금액TAG)
```

### 6.3 재고 계산
```
재고금액 = 순출고금액 - 판매금액
재고수량 = 순출고수량 - 판매수량
```

### 6.4 순출고 vs 전체출고
- **순출고** (net): 출고 - 반품 (정확한 재고 반영)
- **전체출고** (ttl): 기간 중 모든 출고량 (누적 분석용)

## 7. 데이터 소스 테이블

1. **agabang_dw.daily_shop_sales_by_dimension**
   - 매장별 일별 판매 데이터
   - sales_type='이월' 필터로 이월상품만 추출

2. **agabang.dsoutrtn**
   - 본사 창고 출고/반품 데이터
   - io_type='O'(출고), 'R'(반품)

3. **agabang.dsmove**
   - 본사 창고 간 이동 데이터
   - 온라인 창고(3000) 이동 추적용

4. **agabang.dsin**
   - 본사 창고 입고 데이터
   - 온라인 창고 기준으로 추가 입고 확인

5. **agabang_dw.dim_style**
   - 상품 마스터 (카테고리, 등급 정보)

6. **agabang_dw.dim_shop**
   - 매장 마스터 (사업부, 브랜드, 채널 정보)

## 8. 성능 최적화 포인트

1. **병렬 실행**: 6개 쿼리를 Promise.all로 동시 실행
2. **캐싱**: getSeasonEndDate, getShopSaleByCategory에 캐시 적용
3. **전역 함수**: groupBySum 함수를 preloadedAppJavaScript에 정의하여 재사용

## 9. 향후 개선 가능 사항

1. **온라인 출고 기간 처리 개선** (개선됨): 
   - 기간이 `outEndDate`에서 `endDate`로 수정되어 전체 기간 조회 가능
   - 향후 기간 플래그 추가 시 `net`, `ttl` 명확히 구분 가능

2. 출고 마감일 계산 로직이 복잡함 → 별도 저장 프로시저 고려
3. 온라인/오프라인 통합 로직이 여러 파일에 분산 → 중앙화 고려
4. 전년 동기 비교를 위한 별도 쿼리 구조 고려 (효율성 개선)
