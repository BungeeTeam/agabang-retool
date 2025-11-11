WITH item_styles AS (
  SELECT 
    sty_cd,
    sty_nm,
    large_cat,
    REGEXP_REPLACE(sty_nm, '\\s', '') AS cleaned_sty_nm -- 공백 제거 버전 따로 저장
   FROM dim_style
    WHERE br_cd = '{{ var_brand_code.value }}'
    AND substring(sty_cd, 3, 1) >= 'J'
    AND season_cd = '0'
    AND it in (6, 8)
),
series_candidates AS (
  SELECT
    sty_cd,
    sty_nm,
    cleaned_sty_nm,
    REGEXP_REPLACE(cleaned_sty_nm, '([가-힣]+)[0-9]{1,2}(종|SET).*', '\\1') AS cleaned_nm
  FROM item_styles
),
      
series_extraction AS (
  SELECT
    sty_cd,
    sty_nm,
    cleaned_nm,
    multiIf(
      cleaned_nm LIKE '%베이직%', REGEXP_REPLACE(cleaned_nm, '(.+?)베이직.*', '\\1'),
cleaned_nm LIKE '%미니%', REGEXP_REPLACE(cleaned_nm, '(.+?)미니.*', '\\1'),
cleaned_nm LIKE '%기본%', REGEXP_REPLACE(cleaned_nm, '(.+?)기본.*', '\\1'),
cleaned_nm LIKE '%리플%', REGEXP_REPLACE(cleaned_nm, '(.+?)리플.*', '\\1'),
cleaned_nm LIKE '%양면%', REGEXP_REPLACE(cleaned_nm, '(.+?)양면.*', '\\1'),
cleaned_nm LIKE '%린넨%', REGEXP_REPLACE(cleaned_nm, '(.+?)린넨.*', '\\1'),
cleaned_nm LIKE '%뱀부%', REGEXP_REPLACE(cleaned_nm, '(.+?)뱀부.*', '\\1'),
cleaned_nm LIKE '%밤부%', REGEXP_REPLACE(cleaned_nm, '(.+?)밤부.*', '\\1'),
cleaned_nm LIKE '%무연사%', REGEXP_REPLACE(cleaned_nm, '(.+?)무연사.*', '\\1'),
cleaned_nm LIKE '%실크%', REGEXP_REPLACE(cleaned_nm, '(.+?)실크.*', '\\1'),
cleaned_nm LIKE '%심플%', REGEXP_REPLACE(cleaned_nm, '(.+?)심플.*', '\\1'),
cleaned_nm LIKE '%체크%', REGEXP_REPLACE(cleaned_nm, '(.+?)체크.*', '\\1'),
cleaned_nm LIKE '%프릴%', REGEXP_REPLACE(cleaned_nm, '(.+?)프릴.*', '\\1'),
cleaned_nm LIKE '%레이스%', REGEXP_REPLACE(cleaned_nm, '(.+?)레이스.*', '\\1'),
cleaned_nm LIKE '%플라워%', REGEXP_REPLACE(cleaned_nm, '(.+?)플라워.*', '\\1'),
cleaned_nm LIKE '%어깨%', REGEXP_REPLACE(cleaned_nm, '(.+?)어깨.*', '\\1'),
cleaned_nm LIKE '%손목%', REGEXP_REPLACE(cleaned_nm, '(.+?)손목.*', '\\1'),
cleaned_nm LIKE '%무릎%', REGEXP_REPLACE(cleaned_nm, '(.+?)무릎.*', '\\1'),
cleaned_nm LIKE '%후드%', REGEXP_REPLACE(cleaned_nm, '(.+?)후드.*', '\\1'),
cleaned_nm LIKE '%배색%', REGEXP_REPLACE(cleaned_nm, '(.+?)배색.*', '\\1'),
cleaned_nm LIKE '%거즈%', REGEXP_REPLACE(cleaned_nm, '(.+?)거즈.*', '\\1'),
cleaned_nm LIKE '%무지%', REGEXP_REPLACE(cleaned_nm, '(.+?)무지.*', '\\1'),
cleaned_nm LIKE '%토끼%', REGEXP_REPLACE(cleaned_nm, '(.+?)토끼.*', '\\1'),
cleaned_nm LIKE '%애착인형%', REGEXP_REPLACE(cleaned_nm, '(.+?)애착인형.*', '\\1'),
cleaned_nm LIKE '%딸랑이%', REGEXP_REPLACE(cleaned_nm, '(.+?)딸랑이.*', '\\1'),
cleaned_nm LIKE '%꽈배기%', REGEXP_REPLACE(cleaned_nm, '(.+?)꽈배기.*', '\\1'),
cleaned_nm LIKE '%스페셜%', REGEXP_REPLACE(cleaned_nm, '(.+?)스페셜.*', '\\1'),
cleaned_nm LIKE '%오가닉%', REGEXP_REPLACE(cleaned_nm, '(.+?)오가닉.*', '\\1'),  
cleaned_nm LIKE '%끈%', REGEXP_REPLACE(cleaned_nm, '(.+?)끈.*', '\\1'),
cleaned_nm LIKE '%우븐%', REGEXP_REPLACE(cleaned_nm, '(.+?)우븐.*', '\\1'),
cleaned_nm LIKE '%면%', REGEXP_REPLACE(cleaned_nm, '(.+?)면.*', '\\1'),
cleaned_nm LIKE '%코사지%', REGEXP_REPLACE(cleaned_nm, '(.+?)코사지.*', '\\1'),
cleaned_nm LIKE '%발광%', REGEXP_REPLACE(cleaned_nm, '(.+?)발광.*', '\\1'),
cleaned_nm LIKE '%삑삑이%', REGEXP_REPLACE(cleaned_nm, '(.+?)삑삑이.*', '\\1'),
cleaned_nm LIKE '%라운드%', REGEXP_REPLACE(cleaned_nm, '(.+?)라운드.*', '\\1'),
cleaned_nm LIKE '%사각%', REGEXP_REPLACE(cleaned_nm, '(.+?)모달.*', '\\1'),
cleaned_nm LIKE '%모달%', REGEXP_REPLACE(cleaned_nm, '(.+?)모달.*', '\\1'),
cleaned_nm LIKE '%골지%', REGEXP_REPLACE(cleaned_nm, '(.+?)골지.*', '\\1'),
cleaned_nm LIKE '%스판%', REGEXP_REPLACE(cleaned_nm, '(.+?)스판.*', '\\1'),
cleaned_nm LIKE '%오가닉%', REGEXP_REPLACE(cleaned_nm, '(.+?)오가닉.*', '\\1'),
cleaned_nm LIKE '%자가드%', REGEXP_REPLACE(cleaned_nm, '(.+?)자가드.*', '\\1'),
cleaned_nm LIKE '%쟈가드%', REGEXP_REPLACE(cleaned_nm, '(.+?)쟈가드.*', '\\1'),
cleaned_nm LIKE '%입체%', REGEXP_REPLACE(cleaned_nm, '(.+?)입체.*', '\\1'),
cleaned_nm LIKE '%분리형%', REGEXP_REPLACE(cleaned_nm, '(.+?)분리형.*', '\\1'),
cleaned_nm LIKE '%웜내의%', REGEXP_REPLACE(cleaned_nm, '(.+?)웜내의.*', '\\1'),
cleaned_nm LIKE '%수플레%', REGEXP_REPLACE(cleaned_nm, '(.+?)수플레.*', '\\1'),
cleaned_nm LIKE '%단말%', REGEXP_REPLACE(cleaned_nm, '(.+?)단말.*', '\\1'),
cleaned_nm LIKE '%수피마%', REGEXP_REPLACE(cleaned_nm, '(.+?)수피마.*', '\\1'),
cleaned_nm LIKE '%꼬리%', REGEXP_REPLACE(cleaned_nm, '(.+?)꼬리.*', '\\1'),
cleaned_nm LIKE '%3부%', REGEXP_REPLACE(cleaned_nm, '(.+?)3부.*', '\\1'),
cleaned_nm LIKE '%5부%', REGEXP_REPLACE(cleaned_nm, '(.+?)5부.*', '\\1'),
cleaned_nm LIKE '%7부%', REGEXP_REPLACE(cleaned_nm, '(.+?)7부.*', '\\1'),
cleaned_nm LIKE '%10부%', REGEXP_REPLACE(cleaned_nm, '(.+?)10부.*', '\\1'),
cleaned_nm LIKE '%낮잠%', REGEXP_REPLACE(cleaned_nm, '(.+?)낮잠.*', '\\1'),
cleaned_nm LIKE '%긴팔%', REGEXP_REPLACE(cleaned_nm, '(.+?)긴팔.*', '\\1'),
cleaned_nm LIKE '%배내%', REGEXP_REPLACE(cleaned_nm, '(.+?)배내.*', '\\1'),
cleaned_nm LIKE '%신생아%', REGEXP_REPLACE(cleaned_nm, '(.+?)신생아.*', '\\1'),
cleaned_nm LIKE '%신생%', REGEXP_REPLACE(cleaned_nm, '(.+?)신생.*', '\\1'),
cleaned_nm LIKE '%발달이%', REGEXP_REPLACE(cleaned_nm, '(.+?)발달이.*', '\\1'),
cleaned_nm LIKE '%선물용%', REGEXP_REPLACE(cleaned_nm, '(.+?)선물용.*', '\\1'),
cleaned_nm LIKE '%여아%', REGEXP_REPLACE(cleaned_nm, '(.+?)여아.*', '\\1'),
cleaned_nm LIKE '%남아%', REGEXP_REPLACE(cleaned_nm, '(.+?)남아.*', '\\1'),
cleaned_nm LIKE '%반소%', REGEXP_REPLACE(cleaned_nm, '(.+?)반소.*', '\\1'),
cleaned_nm LIKE '%속싸보%', REGEXP_REPLACE(cleaned_nm, '(.+?)속싸보.*', '\\1'),
cleaned_nm LIKE '%겉싸보%', REGEXP_REPLACE(cleaned_nm, '(.+?)겉싸보.*', '\\1'),
cleaned_nm LIKE '%이불%', REGEXP_REPLACE(cleaned_nm, '(.+?)이불.*', '\\1'),
cleaned_nm LIKE '%차렵%', REGEXP_REPLACE(cleaned_nm, '(.+?)차렵.*', '\\1'),
cleaned_nm LIKE '%손수건%', REGEXP_REPLACE(cleaned_nm, '(.+?)손수건.*', '\\1'),
cleaned_nm LIKE '%반팔%', REGEXP_REPLACE(cleaned_nm, '(.+?)반팔.*', '\\1'),
cleaned_nm LIKE '%긴소%', REGEXP_REPLACE(cleaned_nm, '(.+?)긴소.*', '\\1'),
cleaned_nm LIKE '%민소매%', REGEXP_REPLACE(cleaned_nm, '(.+?)민소매.*', '\\1'),
cleaned_nm LIKE '%반타이즈', REGEXP_REPLACE(cleaned_nm, '(.+?)반타이즈.*', '\\1'),
cleaned_nm LIKE '%비치가운', REGEXP_REPLACE(cleaned_nm, '(.+?)비치가운.*', '\\1'),
cleaned_nm LIKE '%한복%', REGEXP_REPLACE(cleaned_nm, '(.+?)한복.*', '\\1'),
cleaned_nm LIKE '%방수%', REGEXP_REPLACE(cleaned_nm, '(.+?)방수.*', '\\1'),
cleaned_nm LIKE '%하이삭스%', REGEXP_REPLACE(cleaned_nm, '(.+?)하이삭스.*', '\\1'),
cleaned_nm LIKE '%인견%', REGEXP_REPLACE(cleaned_nm, '(.+?)인견.*', '\\1'),
cleaned_nm LIKE '%내의%', REGEXP_REPLACE(cleaned_nm, '(.+?)내의.*', '\\1'),
cleaned_nm LIKE '%바디%', REGEXP_REPLACE(cleaned_nm, '(.+?)바디.*', '\\1'),
cleaned_nm LIKE '%어글리운동화%', REGEXP_REPLACE(cleaned_nm, '(.+?)어글리운동화.*', '\\1'),
cleaned_nm LIKE '%아쿠아슈즈%', REGEXP_REPLACE(cleaned_nm, '(.+?)아쿠아슈즈.*', '\\1'),
cleaned_nm LIKE '%보행기화%', REGEXP_REPLACE(cleaned_nm, '(.+?)보행기화.*', '\\1'),
cleaned_nm LIKE '%턱받이%', REGEXP_REPLACE(cleaned_nm, '(.+?)턱받이.*', '\\1'),
cleaned_nm LIKE '%티셔츠%', REGEXP_REPLACE(cleaned_nm, '(.+?)티셔츠.*', '\\1'),
cleaned_nm LIKE '%런닝%', REGEXP_REPLACE(cleaned_nm, '(.+?)런닝.*', '\\1'),
cleaned_nm LIKE '%상하%', REGEXP_REPLACE(cleaned_nm, '(.+?)상하.*', '\\1'),
cleaned_nm LIKE '%오픈%', REGEXP_REPLACE(cleaned_nm, '(.+?)오픈.*', '\\1'),
cleaned_nm LIKE '%니트%', REGEXP_REPLACE(cleaned_nm, '(.+?)니트.*', '\\1'),
cleaned_nm LIKE '%올인원%', REGEXP_REPLACE(cleaned_nm, '(.+?)올인원.*', '\\1'),
cleaned_nm LIKE '%오버니삭스%', REGEXP_REPLACE(cleaned_nm, '(.+?)오버니삭스.*', '\\1'),
cleaned_nm LIKE '%팬티%', REGEXP_REPLACE(cleaned_nm, '(.+?)팬티.*', '\\1'),
cleaned_nm LIKE '%조끼%', REGEXP_REPLACE(cleaned_nm, '(.+?)조끼.*', '\\1'),
cleaned_nm LIKE '%레깅스%', REGEXP_REPLACE(cleaned_nm, '(.+?)레깅스.*', '\\1'),
cleaned_nm LIKE '%타이즈%', REGEXP_REPLACE(cleaned_nm, '(.+?)타이즈.*', '\\1'),
cleaned_nm LIKE '%반타이즈%', REGEXP_REPLACE(cleaned_nm, '(.+?)반타이즈.*', '\\1'),
cleaned_nm LIKE '%보낭%', REGEXP_REPLACE(cleaned_nm, '(.+?)보낭.*', '\\1'),
cleaned_nm LIKE '%드로즈%', REGEXP_REPLACE(cleaned_nm, '(.+?)드로즈.*', '\\1'),
cleaned_nm LIKE '%우주복%', REGEXP_REPLACE(cleaned_nm, '(.+?)우주복.*', '\\1'),
cleaned_nm LIKE '%운동화%', REGEXP_REPLACE(cleaned_nm, '(.+?)운동화.*', '\\1'),
cleaned_nm LIKE '%수영복%', REGEXP_REPLACE(cleaned_nm, '(.+?)수영복.*', '\\1'),
cleaned_nm LIKE '%우비%', REGEXP_REPLACE(cleaned_nm, '(.+?)우비.*', '\\1'),
cleaned_nm LIKE '%롬퍼%', REGEXP_REPLACE(cleaned_nm, '(.+?)롬퍼.*', '\\1'),
cleaned_nm LIKE '%양말%', REGEXP_REPLACE(cleaned_nm, '(.+?)양말.*', '\\1'),
cleaned_nm LIKE '%장말%', REGEXP_REPLACE(cleaned_nm, '(.+?)장말.*', '\\1'),
cleaned_nm LIKE '%베이비%', REGEXP_REPLACE(cleaned_nm, '(.+?)베이비.*', '\\1'),
cleaned_nm LIKE '%손발%', REGEXP_REPLACE(cleaned_nm, '(.+?)손발.*', '\\1'),
cleaned_nm LIKE '%타월%', REGEXP_REPLACE(cleaned_nm, '(.+?)타월.*', '\\1'),
cleaned_nm LIKE '%거즈%', REGEXP_REPLACE(cleaned_nm, '(.+?)거즈.*', '\\1'),
cleaned_nm LIKE '%쪽쪽이%', REGEXP_REPLACE(cleaned_nm, '(.+?)쪽쪽이.*', '\\1'),
cleaned_nm LIKE '%냉감%', REGEXP_REPLACE(cleaned_nm, '(.+?)냉감.*', '\\1'),
cleaned_nm LIKE '%애착인형%', REGEXP_REPLACE(cleaned_nm, '(.+?)애착인형.*', '\\1'),
cleaned_nm LIKE '%블랭킷%', REGEXP_REPLACE(cleaned_nm, '(.+?)블랭킷.*', '\\1'),
cleaned_nm LIKE '%숯베개%', REGEXP_REPLACE(cleaned_nm, '(.+?)숯베개.*', '\\1'),
cleaned_nm LIKE '%힙시트%', REGEXP_REPLACE(cleaned_nm, '(.+?)힙시트.*', '\\1'),
cleaned_nm LIKE '%목베개%', REGEXP_REPLACE(cleaned_nm, '(.+?)목베개.*', '\\1'),
cleaned_nm LIKE '%앞치마%', REGEXP_REPLACE(cleaned_nm, '(.+?)앞치마.*', '\\1'),
cleaned_nm LIKE '%헤어밴드%', REGEXP_REPLACE(cleaned_nm, '(.+?)헤어밴드.*', '\\1'),
cleaned_nm LIKE '%워머%', REGEXP_REPLACE(cleaned_nm, '(.+?)워머.*', '\\1'),
cleaned_nm LIKE '%요%', REGEXP_REPLACE(cleaned_nm, '(.+?)요.*', '\\1'),
cleaned_nm LIKE '%수유쿠션%', REGEXP_REPLACE(cleaned_nm, '(.+?)수유쿠션.*', '\\1'),
cleaned_nm LIKE '%무릎%', REGEXP_REPLACE(cleaned_nm, '(.+?)무릎.*', '\\1'),
cleaned_nm LIKE '%단품%', REGEXP_REPLACE(cleaned_nm, '(.+?)단품.*', '\\1'),
cleaned_nm LIKE '%산후%', REGEXP_REPLACE(cleaned_nm, '(.+?)산후.*', '\\1'),
cleaned_nm LIKE '%미아방지%', REGEXP_REPLACE(cleaned_nm, '(.+?)미아방지.*', '\\1'),
cleaned_nm LIKE '%스카프%', REGEXP_REPLACE(cleaned_nm, '(.+?)스카프.*', '\\1'),
cleaned_nm LIKE '%인형담요%', REGEXP_REPLACE(cleaned_nm, '(.+?)인형담요.*', '\\1'),
cleaned_nm LIKE '%목욕가운%', REGEXP_REPLACE(cleaned_nm, '(.+?)목욕가운.*', '\\1'),
cleaned_nm LIKE '%손싸개%', REGEXP_REPLACE(cleaned_nm, '(.+?)손싸개.*', '\\1'),
cleaned_nm LIKE '%짱구베개%', REGEXP_REPLACE(cleaned_nm, '(.+?)짱구베개.*', '\\1'),
cleaned_nm LIKE '%타올싸보%', REGEXP_REPLACE(cleaned_nm, '(.+?)타올싸보.*', '\\1'),
cleaned_nm LIKE '%버선%', REGEXP_REPLACE(cleaned_nm, '(.+?)버선.*', '\\1'),
cleaned_nm LIKE '%턱받이%', REGEXP_REPLACE(cleaned_nm, '(.+?)턱받이.*', '\\1'),
  -- 기본값
  NULL
)  AS raw_series_name
  FROM series_candidates
  WHERE cleaned_nm NOT LIKE '%사은품%'
    AND cleaned_nm NOT LIKE '%스티커%'
    AND cleaned_nm NOT LIKE '%럭키박스%'
    AND cleaned_nm NOT LIKE '%쇼핑백%'
    AND cleaned_nm NOT LIKE '%유니폼%'
    AND cleaned_nm NOT LIKE '%판촉%'
    AND cleaned_nm NOT LIKE '%베이비뵨%'
),
cleaned_series AS (
   SELECT
     sty_cd,
     sty_nm,
     TRIM(BOTH ' ' FROM REGEXP_REPLACE(REGEXP_REPLACE(raw_series_name, '[\\(\\)]', ''), '(RE|re|N|OD)', '')) AS series_name
   FROM series_extraction
   WHERE raw_series_name IS NOT NULL
     AND raw_series_name != cleaned_nm
 ),
 -- 최종 시리즈명 후보와 각 시리즈명별 아이템 수를 계산하는 CTE 추가
 final_series_candidates_with_count AS (
   SELECT
     sty_cd,
     sty_nm,
     CASE
       WHEN position(' ', series_name) > 0 THEN substring(series_name, 1, position(' ', series_name) - 1)
       ELSE series_name
     END AS final_series_name,
     -- 동일한 최종 시리즈명을 가진 아이템 수를 계산 (윈도우 함수 사용)
     COUNT(*) OVER (PARTITION BY final_series_name) AS series_count
   FROM cleaned_series
   WHERE series_name IS NOT NULL -- series_name 이 NULL 이 아닌 경우만 고려
 )

 -- 최종 결과 선택: 시리즈명별 아이템 수가 2개 이상이고, 특정 키워드를 포함하지 않는 경우만 필터링
 SELECT
   sty_cd,
   sty_nm,
   final_series_name AS series_name -- 최종 컬럼명은 series_name 으로 유지
 FROM final_series_candidates_with_count
 WHERE series_count >= 2 -- 해당 시리즈명으로 집계된 아이템 수가 2개 이상인 경우만 필터링
   AND final_series_name NOT LIKE '%사은품%'
   AND final_series_name NOT LIKE '%기저귀%'
   AND final_series_name NOT LIKE '%옷걸%'
   AND final_series_name NOT LIKE '%유모차%'
   AND final_series_name NOT LIKE '%젖병%'
   AND final_series_name NOT LIKE '%젖꼭지%'
   AND final_series_name NOT LIKE '%판촉%';