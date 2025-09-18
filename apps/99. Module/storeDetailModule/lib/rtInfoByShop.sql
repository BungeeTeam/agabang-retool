SELECT 
  CASE 
    WHEN SUM(ord_qty) = 0 THEN 0
    ELSE SUM(CASE WHEN ord_fix_yn = 'Y' THEN fr_qty ELSE 0 END) / SUM(ord_qty) 
    END AS rt_ratio
FROM agabang.shrtord
WHERE fr_shop_cd = '{{ selectedRow.value?.shop_cd }}' AND '{{ startDate.value }}' <= toDate(ord_dt) AND toDate(ord_dt) <= '{{ endDate.value }}'