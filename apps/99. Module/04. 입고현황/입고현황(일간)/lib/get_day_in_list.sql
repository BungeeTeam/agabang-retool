-- 입고 전용 뷰 생성 예시
-- CREATE VIEW agabang_dw.daily_inbound_only_new AS
SELECT
    A.comp_cd,
    B.br_cd,
    toDate(A.in_dt) AS in_dt,
    A.sty_cd,
    -- countDistinct(A.sty_cd) as sty_cnt,
    A.col_cd,
    A.size_cd,
    A.in_qty,
    B.tag_prce * A.in_qty AS in_amt
FROM agabang.dsin AS A
JOIN agabang.plstycd AS B ON A.comp_cd = B.comp_cd AND A.sty_cd = B.sty_cd
WHERE A.io_type = 'I'  -- 입고분만
  AND B.br_cd = '{{ brand_code.value }}'
  AND toDate(A.in_dt) >= today() - INTERVAL 1 MONTH