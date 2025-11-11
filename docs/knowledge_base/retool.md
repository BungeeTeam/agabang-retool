# Retool 환경 가이드

## 개요

이 프로젝트는 **Retool** 플랫폼 위에서 구축된 애플리케이션입니다. Retool은 내부 도구를 빠르게 구축할 수 있는 low-code 플랫폼으로, 데이터베이스 쿼리, API 호출, UI 컴포넌트를 연결하여 애플리케이션을 만듭니다.

## Retool에서의 JavaScript 코드

Retool에서 JavaScript 코드는 크게 **2가지 종류**로 나뉩니다:

1. **Query** (쿼리)
2. **Transform** (트랜스포머)

이 두 가지는 코드 작성 방법이 다르며, 특히 **앱 내 다른 데이터를 참조할 때의 문법이 다릅니다**.

---

## 1. Query (쿼리)

### 정의

Query는 데이터를 가져오거나 처리하는 실행 가능한 코드 블록입니다. 주로 다음과 같은 형태로 사용됩니다:

- **JavascriptQuery**: JavaScript로 작성된 쿼리
- **SqlQuery**: SQL 쿼리
- **RESTQuery**: REST API 호출

### 특징

- **`{{ }}` 사용하지 않음**: Query 내부의 JavaScript 코드에서는 `{{ }}` 문법을 **사용하지 않습니다**.
- 직접 변수 참조: 앱 내 다른 컴포넌트의 데이터를 참조할 때는 변수명을 직접 사용하거나, 파라미터로 전달받습니다.

### 예시

```javascript
// ❌ 잘못된 예시 (Query에서)
const data = {{ salesByBiz.value }}  // Query에서는 {{ }} 사용하면 안 됨

// ✅ 올바른 예시 (Query에서)
// Query는 외부에서 데이터를 받아서 처리하는 구조
// 데이터는 파라미터나 전역 변수로 전달받음
const data = salesByBiz.value  // {{ }} 없이 직접 참조
const currentYear = thisYear.value
```

**실제 사용 예시** (JavascriptQuery):

```javascript
// Query 코드는 {{ }} 없이 작성
// Retool이 자동으로 앱 내 변수를 주입해줌
utils.changeLocale("ko")

const data = salesByBiz.value  // {{ }} 없이 사용
const currentYear = thisYear.value
const fileName = text1.value.slice(6)
```

---

## 2. Transform (트랜스포머)

### 정의

Transform은 쿼리 결과를 변환하거나 가공하는 코드입니다. 주로 다음과 같은 곳에서 사용됩니다:

- **SqlQuery의 `transformer` 속성**: SQL 쿼리 결과를 변환
- **JavascriptQuery의 `transformer` 속성**: JavaScript 쿼리 결과를 변환
- **컴포넌트의 `valueOverride`**: 컴포넌트 표시 값을 변환

### 특징

- **`{{ }}` 사용**: Transform 내부에서는 `{{ }}` 문법을 사용하여 앱 내 다른 데이터를 참조합니다.
- 실시간 바인딩: `{{ }}`로 감싼 표현식은 앱의 상태가 변경될 때마다 자동으로 재계산됩니다.

### 예시

```javascript
// ✅ 올바른 예시 (Transform에서)
transformer="let arrData = formatDataAsArray(data)

const bizLists = {{ bizMultiSelect.value }}
const brLists = {{ brandMultiSelect.value }}

arrData = arrData.filter(item => 
  bizLists.includes(item.biz_cd) && 
  brLists.includes(item.br_cd)
)

return formatDataAsObject(arrData)"
```

**실제 사용 예시** (SqlQuery의 transformer):

```javascript
// apps/11. 영업/01. 영업/매장목표매출/functions.rsx
<SqlQuery
  id="monthlySalesQuery"
  transformer="let arrData = formatDataAsArray(data)

const bizLists = {{ bizMultiSelect.value }}
const brLists = {{ brandMultiSelect.value }}

arrData = arrData.filter(item => 
  bizLists.includes(item.biz_cd) && 
  brLists.includes(item.br_cd)
)

return formatDataAsObject(arrData)"
/>
```

---

## 주요 차이점 요약

| 구분 | Query | Transform |
|------|-------|-----------|
| **용도** | 데이터 가져오기/처리 | 데이터 변환/가공 |
| **`{{ }}` 사용** | **사용하지 않음** | **사용함** |
| **실행 시점** | 명시적으로 실행 (트리거) | 쿼리 실행 후 자동 실행 |
| **데이터 접근** | 변수명 직접 참조 (예: `salesByBiz.value`) | `data` 변수 (쿼리 결과) + `{{ }}`로 앱 데이터 참조 |
| **반환값** | 쿼리 결과 | 변환된 데이터 |

---

## 실제 코드 예시

### 예시 1: JavascriptQuery (Query)

```javascript
// apps/99. Module/revStatTblModule2/lib/bizExcelDownload.js
// Query 타입: JavascriptQuery

utils.changeLocale("ko")

// Query에서는 {{ }} 없이 직접 변수 참조
const data = salesByBiz.value
const currentYear = thisYear.value
const fileName = text1.value.slice(6)

// 데이터 처리
const exportData = data.map(row => {
  // ... 변환 로직
})

// 결과 반환
utils.exportData(exportData, fileName, "xlsx")
```

### 예시 2: SqlQuery의 Transformer (Transform)

```javascript
// apps/11. 영업/01. 영업/매장목표매출/functions.rsx
<SqlQuery
  id="monthlySalesQuery"
  query={include("./lib/monthlySalesQuery.sql", "string")}
  transformer="
    // data는 SQL 쿼리 결과
    let arrData = formatDataAsArray(data)
    
    // {{ }}를 사용하여 앱 내 다른 컴포넌트 참조
    const bizLists = {{ bizMultiSelect.value }}
    const brLists = {{ brandMultiSelect.value }}
    
    // 데이터 필터링
    arrData = arrData.filter(item => 
      bizLists.includes(item.biz_cd) && 
      brLists.includes(item.br_cd)
    )
    
    return formatDataAsObject(arrData)
  "
/>
```

### 예시 3: Function (Transform과 유사)

```javascript
// apps/99. Module/revStatTblModule2/lib/salesByBiz.js
// Function은 Transform과 유사하게 동작

const currentYear = {{ thisYear.value }}  // {{ }} 사용
const data = {{ inputData.value }}        // {{ }} 사용

const arrData = formatDataAsArray(data)
// ... 데이터 처리
return result
```

---

## 주의사항

### 1. `{{ }}` 사용 시점

- **Query (JavascriptQuery)**: `{{ }}`를 **사용하지 않음**. 변수명을 직접 참조
- **Transform**: `{{ }}`를 **사용함**. 앱 내 데이터 참조 시 필수
- **일반 JavaScript 코드**: `{{ }}` 없이 순수 JavaScript 문법 사용

### 2. 데이터 접근 방법

```javascript
// Transform에서
transformer="
  const queryResult = data  // 쿼리 결과는 data 변수로 접근
  const appState = {{ someState.value }}  // 앱 상태는 {{ }}로 접근 (필수)
  return transformedData
"

// Query에서
const queryResult = someQuery.data  // {{ }} 없이 직접 참조
const appState = someState.value    // {{ }} 없이 직접 참조
```

### 3. 실행 순서

1. **Query 실행** → 데이터 가져오기
2. **Transform 실행** → 데이터 변환
3. **결과 반환** → 컴포넌트에 바인딩

---

## 참고 자료

- [Retool 공식 문서](https://docs.retool.com/)
- 프로젝트 내 실제 사용 예시:
  - `apps/99. Module/revStatTblModule2/lib/bizExcelDownload.js` - JavascriptQuery 예시
  - `apps/11. 영업/01. 영업/매장목표매출/functions.rsx` - Transformer 예시

---

## 요약

- **Query**: 데이터를 가져오거나 처리하는 실행 코드
  - **`{{ }}` 사용하지 않음**: 변수명을 직접 참조 (예: `salesByBiz.value`)
- **Transform**: 쿼리 결과를 변환하는 코드
  - **`{{ }}` 사용함**: 앱 내 데이터 참조 시 필수 (예: `{{ bizMultiSelect.value }}`)
- **차이점**: 
  - 실행 시점: Query는 명시적 실행, Transform은 자동 실행
  - 문법: Query는 `{{ }}` 없이, Transform은 `{{ }}` 사용

Retool에서 코드를 작성할 때는 이 두 가지 컨텍스트를 구분하여 적절한 문법을 사용해야 합니다.

---

## 3. functions.rsx 파일 작성 규칙

### 3.1 파일 구조

모든 Retool 앱과 모듈은 `functions.rsx` 파일을 포함하며, 이 파일은 **Retool 특유의 XML 형식**을 따라야 합니다.

**기본 구조**:
```xml
<GlobalFunctions>
  <!-- State, Query, Function 등이 여기에 정의됨 -->
</GlobalFunctions>
```

### 3.2 주요 컴포넌트 타입

#### State (상태)
```xml
<State
  id="stateId"
  value="{{ expression }}"
/>
```

#### Function (함수)
```xml
<Function
  id="functionId"
  funcBody={include("./lib/functionFile.js", "string")}
/>
```

#### SqlQuery (SQL 쿼리)
```xml
<SqlQuery
  id="queryId"
  enableTransformer={true}
  query={include("./lib/queryFile.sql", "string")}
  resourceDisplayName="clickhouse-dw"
  resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
  transformer="return formatDataAsArray(data)"
  warningCodes={[]}
/>
```

#### JavascriptQuery (JavaScript 쿼리)
```xml
<JavascriptQuery
  id="queryId"
  notificationDuration={4.5}
  query={include("./lib/queryFile.js", "string")}
  resourceName="JavascriptQuery"
  showSuccessToaster={false}
/>
```

### 3.3 JavascriptQuery 작성 규칙

#### 필수 속성
- `id`: 쿼리의 고유 식별자
- `query`: `include("./lib/filename.js", "string")` 형식으로 파일 참조
- `resourceName`: `"JavascriptQuery"` (고정값)

#### 일반적으로 사용되는 속성
- `notificationDuration={4.5}`: 알림 지속 시간 (초)
- `showSuccessToaster={false}`: 성공 토스트 표시 여부

#### 선택적 속성
- `isMultiplayerEdited={false}`: 멀티플레이어 편집 여부
- `errorTransformer`: 에러 변환 로직
- `transformer`: 결과 변환 로직
- `runWhenPageLoads={true}`: 페이지 로드 시 자동 실행
- `runWhenPageLoadsDelay="2000"`: 자동 실행 지연 시간 (ms)

#### 예시 (최소 구성)
```xml
<JavascriptQuery
  id="bizExcelDownload"
  notificationDuration={4.5}
  query={include("./lib/bizExcelDownload.js", "string")}
  resourceName="JavascriptQuery"
  showSuccessToaster={false}
/>
```

#### 예시 (전체 구성)
```xml
<JavascriptQuery
  id="download_images_zip"
  errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
  notificationDuration={4.5}
  query={include("./lib/download_images_zip.js", "string")}
  resourceName="JavascriptQuery"
  showSuccessToaster={false}
  transformer="// Query results are available as the `data` variable
return data"
  workflowActionType={null}
  workflowBlockUuid={null}
  workflowRunId={null}
/>
```

### 3.4 SqlQuery 작성 규칙

#### 필수 속성
- `id`: 쿼리의 고유 식별자
- `query`: `include("./lib/filename.sql", "string")` 형식으로 파일 참조
- `resourceDisplayName`: 리소스 표시 이름
- `resourceName`: 리소스 UUID

#### 일반적으로 사용되는 속성
- `enableTransformer={true}`: Transformer 사용 여부
- `transformer`: 데이터 변환 로직 (문자열 또는 `include()` 사용)
- `warningCodes={[]}`: 경고 코드 배열

#### Transformer 작성 방법

**방법 1: 인라인 문자열**
```xml
<SqlQuery
  id="monthlySalesQuery"
  enableTransformer={true}
  transformer="let arrData = formatDataAsArray(data)
const bizLists = {{ bizMultiSelect.value }}
return formatDataAsObject(arrData)"
/>
```

**방법 2: 여러 줄 문자열 (긴 코드)**
```xml
<SqlQuery
  id="shopSalesByBrandQuery"
  enableTransformer={true}
  transformer={
    'function groupBySum(arr, groupKeys, sumKeys) {
  // ... 함수 코드
}

let arrData = formatDataAsArray(data)
if ({{ brandTabbedContainer.currentViewKey }} !== "-1") {
  arrData = arrData.filter(item => item.br_cd === {{ brandTabbedContainer.currentViewKey }})
}
return formatDataAsObject(arrData)'
  }
/>
```

### 3.5 Function 작성 규칙

```xml
<Function
  id="functionId"
  funcBody={include("./lib/functionFile.js", "string")}
/>
```

**주의사항**:
- `funcBody`는 항상 `include()` 함수를 사용하여 외부 파일 참조
- 파일 경로는 `"./lib/filename.js"` 형식
- 두 번째 인자는 항상 `"string"`

### 3.6 모듈에서의 특수 사항

모듈(`apps/99. Module/`)에서는 다음과 같은 특징이 있습니다:

1. **GlobalWidgetProp 사용**: 모듈은 외부에서 데이터를 받기 위해 `GlobalWidgetProp`을 사용합니다.
   ```xml
   <GlobalWidgetProp id="inputData" defaultValue="{{ testQuery.data }}" />
   <GlobalWidgetProp id="inputDataByStyle" />
   <GlobalWidgetProp
     id="inputDateRange"
     value={'{\n  "start": "2024-09-01",\n  "end": "2024-12-31"\n}'}
   />
   ```

2. **State에서 inputData 참조**: 모듈 내 State는 `inputData`, `inputDateRange` 등을 참조할 수 있습니다.
   ```xml
   <State
     id="thisYear"
     value="{{ new Date().getFullYear() <= moment(inputDateRange.value.start).year() ? new Date().getFullYear() : moment(inputDateRange.value.start).year() }}"
   />
   ```

3. **Function에서 inputData 참조**: Function 내부 JavaScript 코드에서도 `{{ }}`를 사용하여 `inputData` 등을 참조합니다.
   ```javascript
   // lib/salesByBiz.js
   const currentYear = {{ thisYear.value }}
   const data = {{ inputData.value }}
   ```

### 3.7 작성 시 주의사항

1. **XML 형식 준수**: 모든 태그는 올바르게 닫혀야 합니다.
2. **속성 값 형식**:
   - 문자열: `"value"` 또는 `'value'`
   - 숫자: `{4.5}` 또는 `{true}`
   - 표현식: `{{ expression }}`
   - include: `{include("./lib/file.js", "string")}`
3. **들여쓰기**: 일관된 들여쓰기 사용 (보통 2칸)
4. **속성 순서**: 일반적으로 `id` → `notificationDuration` → `query` → `resourceName` → 기타 속성 순서

### 3.8 실제 예시 비교

#### ✅ 올바른 예시
```xml
<JavascriptQuery
  id="bizExcelDownload"
  notificationDuration={4.5}
  query={include("./lib/bizExcelDownload.js", "string")}
  resourceName="JavascriptQuery"
  showSuccessToaster={false}
/>
```

#### ❌ 잘못된 예시
```xml
<!-- include 문법 오류 -->
<JavascriptQuery
  id="bizExcelDownload"
  query="./lib/bizExcelDownload.js"  <!-- include() 사용해야 함 -->
/>

<!-- 필수 속성 누락 -->
<JavascriptQuery
  id="bizExcelDownload"
  query={include("./lib/bizExcelDownload.js", "string")}
  <!-- resourceName 누락 -->
/>

<!-- XML 형식 오류 -->
<JavascriptQuery
  id="bizExcelDownload"
  query={include("./lib/bizExcelDownload.js", "string")}
  <!-- 닫는 태그 누락 -->
```

### 3.9 모듈 functions.rsx 체크리스트

모듈의 `functions.rsx`를 작성할 때 확인해야 할 사항:

- [ ] `<GlobalFunctions>` 태그로 감싸져 있는가?
- [ ] JavascriptQuery에 `resourceName="JavascriptQuery"`가 있는가?
- [ ] `include()` 함수를 올바르게 사용하고 있는가? (`{include("./lib/file.js", "string")}`)
- [ ] 필수 속성들이 모두 포함되어 있는가?
- [ ] XML 형식이 올바른가? (모든 태그가 닫혀있는가?)
- [ ] 모듈인 경우 `GlobalWidgetProp`이 정의되어 있는가? (main.rsx에서)

