WITH
    toDate('{{dateRange5.value?.start}}') as start_date,
    toDate('{{dateRange5.value?.end}}') as end_date,
    addYears(start_date,-1) as last_start_date,
    addYears(end_date,-1) as last_end_date,
    YEAR(end_date) as this_yr,
    YEAR(last_end_date) as last_yr

SELECT
biz_cd, biz_nm,
br_cd, br_nm,
sub_br_cd, sub_br_nm,
shop_cd, shop_nm,
tp_cd, tp_nm,
it_gb, it_gb_nm,
item , item_nm,
onoff_flag,
  sum(CASE WHEN YEAR(sale_dt) = this_yr THEN sales_qty ELSE 0 END) as cur_qty, -- 올해 판매수량
  sum(CASE WHEN YEAR(sale_dt) = last_yr THEN sales_qty ELSE 0 END) as prev_qty, -- 작년 판매수량
  sum(CASE WHEN YEAR(sale_dt) = this_yr THEN tag_price * sales_qty  ELSE 0 END)/1000000 as cur_tag, -- 올해 tag 판매금액
  sum(CASE WHEN YEAR(sale_dt) = last_yr THEN tag_price * sales_qty ELSE 0 END)/1000000 as prev_tag, -- 작년 tag 판매금액
  sum(CASE WHEN YEAR(sale_dt) = this_yr THEN sales_price ELSE 0 END)/1000000 as cur_amt, -- 올해 실판매금액
  sum(CASE WHEN YEAR(sale_dt) = last_yr THEN sales_price ELSE 0 END)/1000000 as prev_amt, -- 작년 실판매금액
  sum(CASE WHEN YEAR(sale_dt) = this_yr THEN cost_price * sales_qty ELSE 0 END)/1000000 as cur_cost, -- 올해 원가
  sum(CASE WHEN YEAR(sale_dt) = last_yr THEN cost_price * sales_qty ELSE 0 END)/1000000 as prev_cost -- 작년 원가
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE  YEAR(sale_dt) >= last_yr
and (sale_dt between start_date and end_date OR sale_dt between last_start_date and last_end_date)
and sales_type = '용품'
GROUP BY
biz_cd, biz_nm,
br_cd, br_nm,
sub_br_cd, sub_br_nm,
shop_cd, shop_nm,
tp_cd, tp_nm,
it_gb, it_gb_nm,
item , item_nm,
onoff_flag;