

select
    CASE WHEN t1.net_out_qty <= 10000 THEN toDate(now()- INTERVAL 1 DAY)
        WHEN toDate(now()) > toDate('{{yearSelect2.selectedItem?.season_end_dt }}') THEN toDate('{{yearSelect2.selectedItem?.season_end_dt }}')
        ELSE last_day(toDate(concat(t1.ym, '01')) + INTERVAL 1 MONTH)  END as outEndDate
FROM (
    SELECT
    substring(d.wrk_dt,1,6) as ym,
    SUM(CASE WHEN d.io_type = 'O' THEN d.out_qty ELSE 0 END) as out_total,
    SUM(CASE WHEN d.io_type = 'R' THEN d.out_qty ELSE 0 END) as return_total,
    SUM(CASE WHEN d.io_type = 'O' THEN d.out_qty ELSE 0 END) -
    SUM(CASE WHEN d.io_type = 'R' THEN d.out_qty ELSE 0 END) as net_out_qty
FROM agabang.dsoutrtn d
JOIN (
    SELECT DISTINCT shop_cd, CASE WHEN br_cd = '79' THEN 'DS'
                              WHEN biz_cd = 'A2' THEN 'A1' ELSE biz_cd END as biz_cd, onoff_flag
    FROM agabang_dw.dim_shop
) s ON d.shop_cd = s.shop_cd
WHERE d.br_cd = '{{ brandMultiSelect2.value}}'
  AND d.sesn_cd = '{{ yearSelect2.selectedItem?.season_cd }}'
  AND d.year_cd IN ({{ yearSelect2.selectedItem?.year_codes.replace(/\[|\]/g, '').split(',').map(item => `'${item.trim()}'`).join(',') }})
  AND toDate(d.wrk_dt) >= '{{yearSelect2.selectedItem?.last_season_end_dt }}' 
  AND d.out_qty > 0
  AND s.biz_cd = '{{bizMultiSelect2.value }}'
  AND s.onoff_flag = '오프라인'
GROUP BY ym
ORDER BY out_total DESC
limit 1
     ) as t1;