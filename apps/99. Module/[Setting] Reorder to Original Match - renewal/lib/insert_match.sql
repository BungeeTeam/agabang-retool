INSERT INTO item_reorder_match 
  (reorder_sty_cd, sty_cd)
VALUES
  ('{{reorder_sty_cd_select.value}}', '{{sty_cd_select.value}}')
ON CONFLICT (reorder_sty_cd)
DO UPDATE SET
  sty_cd = EXCLUDED.sty_cd;