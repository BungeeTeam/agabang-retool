with
    '{{ dateRange1.value.start }}' as startDate,
    '{{ dateRange1.value.end }}' as endDate,
    addYears(startDate, -1) as prevStartDate,
    addYears(endDate, -1) as prevEndDate,
    sales as(
        select
            toYear(sale_dt) as yearUnit,
            year_cd, year_nm,
            sales_type,
            sum(sales_price) as rev
        from agabang_dw.daily_shop_sales_by_dimension
        where sale_dt between startDate and endDate
        and br_cd = '{{ brand_code.value }}'
        group by yearUnit,
             year_cd, year_nm,
             sales_type
        ),

        prevSales as(
        select
            toYear(sale_dt) as yearUnit,
            year_cd, year_nm,
            char(ascii(year_cd) + 1) AS prev_year_cd,
            sales_type,
            sum(sales_price) as rev
        from agabang_dw.daily_shop_sales_by_dimension
        where sale_dt between prevStartDate and prevEndDate
        and br_cd = '{{ brand_code.value }}'
        group by yearUnit,
             year_cd, year_nm,
             sales_type
        )
select
    A.sales_type as saled_type,
    B.sales_type as saled_type_prev,
    sum(A.rev) as cur_rev,
    sum(B.rev) as prev_rev
from sales as A
join prevSales as B on A.year_cd = B.prev_year_cd and A.sales_type = B.sales_type
-- where A.sales_type != '용품'
GROUP BY saled_type, saled_type_prev
ORDER BY A.sales_type desc , cur_rev desc
;