with org_tbl as (
  select
    *,
    (days_since_sale - min_days_since_sale) / (max_days_since_sale - min_days_since_sale) as scaled_days_since_sale,
    (tot_sales_qty - min_tot_sales_qty) / (max_tot_sales_qty - min_tot_sales_qty) as scaled_tot_sales_qty,
    (tot_col_sales_qty - min_tot_col_sales_qty) / (max_tot_col_sales_qty - min_tot_col_sales_qty) as scaled_tot_col_sales_qty,
    (tot_col_stock_qty - min_tot_col_stock_qty) / (max_tot_col_stock_qty - min_tot_col_stock_qty) as scaled_tot_col_stock_qty
  from agabang_dw.daily_rt_basic
  where year_cd in ('{{ yearSelect.value.join("', '") }}') 
  and season_cd in ('{{ seasonSelect.value.join("', '") }}')
  and br_cd in ('{{ brandSelect.value.join("', '") }}')
  and it in ('{{ itSelect.value.join("', '") }}')
  and stock_qty >= {{ minHoldInput.value }}
  and biz_cd = '{{ bizSelect.value }}'
  and days_after_in >= {{ durationNumberInput.value }}
  and (days_since_sale is null or days_since_sale >= {{ durationNumberInput.value }})
  and sales_ratio >= 0
  and (
    sales_ratio * 100 <= {{ salesPercentNumberInput.value }} or tot_col_sales_ratio * 100 <= {{ salesPercentNumberInput.value }} 
  )
  and tot_sales_qty <= {{ salesNumberInput.value }}
  and inventory_qty <= {{ inventoryInput.value }}
  and (days_since_out is null or days_since_out >= 7)
  and item != '760'
  and shop_cd not in (
    select shop_cd
    from agabang.slshophold
    where trmn_yn = 'N' and hold_tp = 'S'
    and toDate(str_dt) <= today() and toDate(end_dt) >= today()
  )
  and sty_nm not like '%끈나시%'
  order by br_cd, year_cd, season_cd, sty_cd, col_cd, size_cd
),
reco_tbl as (
  select 
    *, 
    abs(sales_ratio - sales_ratio_b) as sales_ratio_diff,
    abs(tot_col_sales_ratio - tot_col_sales_ratio_b) as tot_col_sales_ratio_diff,
    abs(tot_sty_sales_ratio - tot_sty_sales_ratio_b) as tot_sty_sales_ratio_diff,
    abs(tot_item_sales_ratio - tot_item_sales_ratio_b) as tot_item_sales_ratio_diff,
    abs(scaled_days_since_sale - scaled_days_since_sale_b) as scaled_days_since_sale_diff,
    abs(scaled_tot_sales_qty - scaled_tot_sales_qty_b) as scaled_tot_sales_qty_diff,
    abs(scaled_tot_col_sales_qty - scaled_tot_col_sales_qty_b) as scaled_tot_col_sales_qty_diff,
    abs(scaled_tot_col_stock_qty - scaled_tot_col_stock_qty_b) as scaled_tot_col_stock_qty_diff
  from org_tbl as A
  left join (
    select 
      sty_cd,
      col_cd,
      size_cd,
      tp_cd as tp_cd_b,
      tp_nm as tp_nm_b,
      shop_cd as shop_cd_b,
      shop_nm as shop_nm_b,
      stock_qty as stock_qty_b,
      tot_sales_qty as tot_sales_qty_b,
      tot_col_sales_qty as tot_col_sales_qty_b,
      tot_col_stock_qty as tot_col_stock_qty_b,
      lsale_dt as lsale_dt_b,
      sales_ratio as sales_ratio_b,
      tot_col_sales_ratio as tot_col_sales_ratio_b,
      tot_sty_sales_ratio as tot_sty_sales_ratio_b,
      tot_item_sales_ratio as tot_item_sales_ratio_b,
      (days_since_sale - min_days_since_sale) / (max_days_since_sale - min_days_since_sale) as scaled_days_since_sale_b,
      (tot_sales_qty - min_tot_sales_qty) / (max_tot_sales_qty - min_tot_sales_qty) as scaled_tot_sales_qty_b,
      (tot_col_sales_qty - min_tot_col_sales_qty) / (max_tot_col_sales_qty - min_tot_col_sales_qty) as scaled_tot_col_sales_qty_b,
      (tot_col_stock_qty - min_tot_col_stock_qty) / (max_tot_col_stock_qty - min_tot_col_stock_qty) as scaled_tot_col_stock_qty_b
    from agabang_dw.daily_rt_basic
    where tot_sales_qty >= {{ minSalesInput.value }}
    and stock_qty <= {{ stockInput.value }}
    and tp_cd not in ('{{ tpMultiSelect.value.join("', '") }}')
    and shop_cd not in ('{{ shopMultiSelect.value.join("', '") }}')
    and (rt_in_dt is null or dateDiff(
            'day',
            toDate(rt_in_dt),
            today()
        ) >= 7)
    and days_since_sale <= {{ salesPeriodInput.value }}
    and shop_cd not in (
      select shop_cd
      from agabang.slshophold
      where trmn_yn = 'N' and hold_tp = 'R'
      and toDate(str_dt) <= today() and toDate(end_dt) >= today()
    )
  ) as B
  on A.sty_cd = B.sty_cd and A.col_cd = B.col_cd and A.size_cd = B.size_cd
  where shop_cd_b is not null and concat(shop_cd, shop_nm, sty_cd, sty_nm, shop_cd_b, shop_nm_b) like '%{{ searchInput.value }}%'
),
reco_tbl_w_score as (
  select 
    *,
    case
      when size_cnt = 1 and col_cnt = 1 then sales_ratio_diff * 2 + tot_item_sales_ratio_diff + scaled_days_since_sale_diff + scaled_tot_sales_qty_diff * 2 + scaled_tot_col_stock_qty_diff
      when size_cnt > 1 and col_cnt = 1 then sales_ratio_diff + tot_col_sales_ratio_diff + tot_item_sales_ratio_diff + scaled_days_since_sale_diff + scaled_tot_sales_qty_diff + scaled_tot_col_sales_qty_diff + scaled_tot_col_stock_qty_diff
      when size_cnt = 1 and col_cnt > 1 then sales_ratio_diff + tot_sty_sales_ratio_diff + tot_item_sales_ratio_diff + scaled_days_since_sale_diff + scaled_tot_sales_qty_diff + scaled_tot_col_stock_qty_diff 
  else sales_ratio_diff + tot_col_sales_ratio_diff + tot_sty_sales_ratio_diff + tot_item_sales_ratio_diff + scaled_days_since_sale_diff + scaled_tot_sales_qty_diff + scaled_tot_col_sales_qty_diff + scaled_tot_col_stock_qty_diff
    end as tot_score
  from reco_tbl
),
reco_tbl_w_rank as (
  select 
    *,
    row_number () over (
      partition by shop_cd, sty_cd, col_cd, size_cd 
      order by tot_score desc
    ) as rn
  from reco_tbl_w_score
  where tot_score >= {{ minScoreInput.value }}
)
select * from reco_tbl_w_rank
where rn <= 5
order by sty_cd, col_cd, size_cd, shop_cd, rn