# Retool 앱 IDE 수정 가이드

## 핵심 원칙: lib/ 폴더 파일들은 반드시 참조되어야 함

### 문제 상황
- `lib/` 폴더에 코드 파일을 작성했지만 Retool에서 인식되지 않음
- 파일이 존재하지만 누락되는 현상 발생

### 원인
**`lib/` 폴더의 모든 코드 파일들은 다음 파일들 중 하나에서 반드시 참조되어야 합니다:**

## 1. functions.rsx (가장 중요)
- **SqlQuery**: SQL 파일들을 `<SqlQuery>` 컴포넌트로 정의
- **JavascriptQuery**: JavaScript 파일들을 `<JavascriptQuery>` 컴포넌트로 정의
- **RESTQuery**: REST API 관련 파일들

### 예시:
```rsx
<SqlQuery
  id="my_query"
  query={include("./lib/my_query.sql", "string")}
  resourceDisplayName="clickhouse-dw"
  resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
/>
```

## 2. main.rsx
- **CSS 파일**: `css={include("./lib/style.css", "string")}`
- **HTML 파일**: `html={include("./lib/template.html", "string")}`

### 예시:
```rsx
<AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
<HTML css={include("./lib/html1.css", "string")} html={include("./lib/html1.html", "string")} />
```

## 3. src/ 폴더 내 파일들
- **차트 설정**: JSON 파일들을 차트 컴포넌트에서 참조
- **기타 리소스**: 필요에 따라 다른 컴포넌트에서 참조

### 예시:
```rsx
<PlotlyChart
  data={include("../lib/chart1.data.json", "string")}
  layout={include("../lib/chart1.layout.json", "string")}
/>
```

## 4. 기타 파일들
- **header.rsx**: 필요시 lib 파일 참조 가능
- **metadata.json**: 설정 파일 (일반적으로 lib 파일 직접 참조 안함)
- **.positions.json**: 레이아웃 파일 (일반적으로 lib 파일 직접 참조 안함)

## 중요 규칙

### ✅ 올바른 방법
1. `lib/` 폴더에 파일 작성
2. `functions.rsx`에 해당하는 Query 컴포넌트 추가
3. 적절한 `resourceName` 사용 (임의 지정 금지!)

### ❌ 잘못된 방법
1. `lib/` 폴더에만 파일 작성하고 참조하지 않음
2. `resourceName`을 임의로 지정
3. 파일 경로를 잘못 지정

## resourceName 규칙

### ClickHouse 데이터베이스
```
resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
resourceDisplayName="clickhouse-dw"
```

### Retool DB
```
resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
resourceDisplayName="retool_db"
```

### JavaScript Query
```
resourceName="JavascriptQuery"
```

### REST API
```
resourceName="REST-WithoutResource"
```

## 체크리스트

새로운 lib 파일을 추가할 때:

- [ ] 파일이 `lib/` 폴더에 올바르게 위치하는가?
- [ ] `functions.rsx`에 적절한 Query 컴포넌트가 추가되었는가?
- [ ] 올바른 `resourceName`을 사용했는가?
- [ ] 파일 경로가 정확한가? (`./lib/filename.sql`)
- [ ] 다른 파일에서 해당 쿼리를 참조할 수 있는가?

## 결론

**Retool 앱을 IDE로 수정할 때 가장 중요한 규칙:**
> `lib/` 폴더의 모든 코드 파일은 반드시 `functions.rsx`, `main.rsx`, 또는 `src/` 폴더의 파일에서 참조되어야 하며, 그렇지 않으면 Retool에서 인식되지 않습니다.

이는 Retool의 아키텍처 특성으로, 파일 시스템에 존재하는 파일이라도 명시적으로 참조되지 않으면 애플리케이션에 포함되지 않기 때문입니다.
