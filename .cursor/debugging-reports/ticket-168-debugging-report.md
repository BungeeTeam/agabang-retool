# 티켓 168 디버깅 리포트

## 티켓 정보
- **티켓 ID**: 168
- **제목**: 판가맵에서 상품이 보이지 않습니다.
- **내용**: 판가맵에서 상품이 보이지 않습니다. 수정부탁드립니다.
- **앱 이름**: 02. AgabangApp/05. 시즌기획_리뷰/03. 수량 판매가 검토 - 아가방
- **제출 시간**: 2025-12-30 11:08:18
- **사용자**: project@cleave.work (userId: 1)

## 사용자 로그 분석

티켓 제출 시간(11:08:18) 기준 30분 전(10:38:18)부터의 사용자 로그를 확인했습니다.

### 주요 활동
- **11:06:08**: 판가맵 페이지 접속 및 초기 쿼리 실행
  - `season_list`, `get_size_info`, `category_list`, `get_category_list_new` 쿼리 실행
- **11:06:09 ~ 11:07:06**: 여러 필터 조건으로 `get_item_list` 및 `get_competitor_item_list` 쿼리 반복 실행
  - 조끼 (25WT/24WT/23WT)
  - 배내저고리 (배내류)
  - 우주복 (우주복)
  - 티셔츠/블라우스 (TOP, 26FA/25FA/24FA)

### 쿼리 실행 파라미터 (최종 실행 기준)
- `brand_code.value`: '01'
- `select_category.value`: '21'
- `select_category_item2.value`: 'TOP'
- `var_season_list.value`: ['26FA', '25FA', '24FA']
- `select_category_item.value`: ['티셔츠', '블라우스']

## 문제 분석

### 판가맵 앱 구조
판가맵 앱은 다음 구조로 동작합니다:
1. `get_item_list` 쿼리 실행 → 상품 리스트 조회
2. `set_price_list` JavaScript 쿼리 실행 → 가격 리스트 생성
3. `ListViewBeta`에서 가격별로 상품 그룹화하여 표시

### 상품 표시 조건
`container_price_product.rsx`의 `ListViewBeta`에서 상품이 표시되는 조건:
```javascript
data="{{ formatDataAsArray(get_item_list.data).filter(item => 
  Number(item.item_price) === var_price_list.value[i] && 
  item.year_sesn_nm_eng == var_season_list.value[0]
)}}"
```

### 잠재적 문제점
1. **쿼리 결과가 비어있을 수 있음**
   - `get_item_list` 쿼리가 실행되었지만 결과가 비어있을 수 있습니다
   - 필터 조건(`select_category.value`, `select_category_item2.value`, `select_category_item.value`)이 데이터와 맞지 않을 수 있습니다

2. **필터 조건 불일치**
   - `get_item_list` 쿼리의 WHERE 조건:
     - `F.id = '{{ select_category.value }}'` (대분류)
     - `dim.middle_cat = '{{ select_category_item2.value }}'` (중분류)
     - `dim.small_cat in ( {{ select_category_item.value?.map(item => `'${item}'`).join(", ") }} )` (소분류)
   - 이 조건들이 데이터와 맞지 않으면 결과가 비어있을 수 있습니다

3. **시즌 필터 조건 불일치**
   - `var_season_list.value[0]`이 `get_item_list` 쿼리 결과의 `year_sesn_nm_eng`와 일치하지 않으면 상품이 표시되지 않습니다

4. **가격 리스트 생성 문제**
   - `set_price_list` JavaScript 쿼리가 `get_item_list.data`가 비어있으면 빈 가격 리스트를 생성할 수 있습니다
   - 이 경우 `var_price_list.value[i]`가 없어서 상품이 표시되지 않습니다

## 재현 방법

1. 판가맵 페이지 접속
2. 필터 조건 설정:
   - 시즌: 26FA, 25FA, 24FA
   - 대분류: 21
   - 중분류: TOP
   - 소분류: 티셔츠, 블라우스
3. `get_item_list` 쿼리 실행
4. 결과 확인: 상품이 표시되지 않음

## 권장 조치사항

1. **쿼리 결과 확인**
   - `get_item_list` 쿼리가 실제로 데이터를 반환하는지 확인
   - 필터 조건이 데이터와 일치하는지 확인

2. **필터 조건 검증**
   - `select_category.value`, `select_category_item2.value`, `select_category_item.value`가 실제 데이터와 일치하는지 확인
   - `dim_style` 테이블의 `middle_cat`, `small_cat` 값과 일치하는지 확인

3. **에러 처리 개선**
   - 쿼리 결과가 비어있을 때 사용자에게 알림 표시
   - 필터 조건이 맞지 않을 때 안내 메시지 표시

4. **디버깅 정보 추가**
   - 쿼리 실행 결과를 로그로 남기기
   - 필터 조건과 쿼리 결과를 비교하여 불일치 원인 파악

## 추가 확인 필요 사항

1. 실제 `get_item_list` 쿼리 실행 결과 확인
2. `dim_style` 테이블의 `middle_cat`, `small_cat` 값 확인
3. `retooldb_item_md_category` 테이블의 `id = 21`인 카테고리 확인
4. 해당 필터 조건으로 실제 데이터가 존재하는지 확인

## 실제 원인 분석 (데이터 검증 완료)

### 데이터 검증 결과

MCP를 통해 실제 데이터베이스를 조회한 결과:

1. **카테고리 정보 확인**
   - `retooldb_item_md_category` 테이블에서 `id = 21`은 **"시즌의류(B)"** 카테고리입니다.

2. **dim_style 테이블 데이터 존재 여부**
   - `br_cd = '01'`, `middle_cat = 'TOP'`, `small_cat IN ('티셔츠', '블라우스')` 조건에 맞는 데이터: **1,701개 존재**
   - 이 중 `item_md_category_id = 21`인 상품도 존재합니다.

3. **시즌 정보 확인**
   - `retooldb_code_season` 테이블에 '26FA', '25FA', '24FA' 시즌이 모두 존재합니다.

4. **핵심 문제 발견**
   - `item_md_category_id = 21`인 상품들(`dim_style`에 존재)이 **`agabang.plcoszcd` 테이블에 존재하지 않습니다**.
   - 예시 상품 코드: `01T721010`, `01T521002`, `01T521004`, `01T521009`, `01T721001` 등
   - 이 상품들은 모두 `plcoszcd` 테이블에 **NOT_EXISTS** 상태입니다.

### 정확한 문제 원인

**`get_item_list` 쿼리는 `agabang.plcoszcd` 테이블을 기준으로 시작하는데, 해당 필터 조건(`item_md_category_id = 21`)에 맞는 상품들이 `plcoszcd` 테이블에 존재하지 않기 때문에 쿼리 결과가 0개가 됩니다.**

```65:70:agabang-retool/apps/99. Module/05. 시즌기획_리뷰/판가맵/lib/get_item_list.sql
where --B.br_cd = brand_code
        dim.br_cd = brand_code
                and C.year_sesn_nm_eng in ( {{ var_season_list.value?.map(item => `'${item}'`).join(", ") }} )
                and F.id = '{{ select_category.value }}'
                and dim.middle_cat = '{{ select_category_item2.value }}'
                and dim.small_cat in ( {{ select_category_item.value?.map(item => `'${item}'`).join(", ") }} )
```

쿼리는 `agabang.plcoszcd` 테이블(별칭 A)에서 시작하므로, 이 테이블에 해당 상품이 없으면 결과가 나오지 않습니다.

### 검증 쿼리 결과

- **조건 1**: `dim_style`에 `br_cd='01'`, `middle_cat='TOP'`, `small_cat IN ('티셔츠', '블라우스')` → **1,701개 존재**
- **조건 2**: 위 조건 + `plcoszcd` 조인 + 시즌 필터 → **28개 존재**
- **조건 3**: 위 조건 + `item_md_category_id = 21` → **0개 존재** ❌

### 결론

**버그의 정확한 원인**: `item_md_category_id = 21` (시즌의류(B)) 카테고리의 상품들이 `agabang.plcoszcd` 테이블에 존재하지 않아 쿼리 결과가 0개가 되고, 따라서 판가맵에 상품이 표시되지 않습니다.

### 가능한 원인

1. **데이터 동기화 문제**: `dim_style`에는 있지만 `plcoszcd`에는 아직 동기화되지 않음
2. **입고 전 상품**: 아직 입고되지 않은 상품이 `dim_style`에만 등록됨
3. **데이터 불일치**: 두 테이블 간의 데이터 불일치 문제

### 권장 해결 방안

1. **데이터 확인**: `item_md_category_id = 21`인 상품들이 실제로 입고되었는지 확인
2. **쿼리 수정 검토**: `plcoszcd`가 아닌 다른 테이블을 기준으로 하거나, LEFT JOIN을 사용하여 `dim_style`에 있는 상품도 표시할 수 있도록 수정
3. **사용자 안내**: 해당 카테고리의 상품이 아직 입고되지 않았거나 데이터 동기화가 필요함을 안내

