# Data Flow Documentation

**생성일시:** 2025-10-01 10:08:39 KST  
**소스 디렉토리:** `apps/21. 버그 제보_개선 요청/아이템맵AG-CS자동화-test/lib`  
**총 SQL 파일 수:** 12개  
**총 테이블 수:** 87개

## 📊 전체 테이블 목록

1. `CUM_IN_DATA`
2. `FIRST_IN_DATE`
3. `SIZE_DATA`
4. `SIZE_DATA_EACH`
5. `_category`
6. `agabang`
7. `agabang_dw`
8. `avg_rate`
9. `avg_sale_qty`
10. `avg_sale_rate`
11. `br_cd`
12. `cat_nm`
13. `coalesce`
14. `code_season`
15. `col_cd`
16. `col_nm`
17. `concat`
18. `cost_prce`
19. `cum_in_amt`
20. `cum_in_qty`
21. `cust_nm`
22. `d_date`
23. `daily_data_by_color`
24. `daily_sales_by_color`
25. `daily_sales_by_size`
26. `daily_shop_sales_by_dimension`
27. `daily_shop_sales_by_size`
28. `deli_dt`
29. `designer_nm`
30. `dim_style`
31. `dim_style_color`
32. `f_sale_prce`
33. `fabric`
34. `filtered_daily_shop_sale_by_size`
35. `fin_date`
36. `fout_date`
37. `int_sale_qty`
38. `item_md_category`
39. `item_nm`
40. `item_raw_nm`
41. `mark_up`
42. `memo`
43. `nation`
44. `period_sales`
45. `plan_qty`
46. `plbrcd`
47. `preview_grade`
48. `preview_score`
49. `prod_comp`
50. `prod_country`
51. `prod_final_price`
52. `prod_sales_stock_by_color`
53. `prod_sales_stock_by_size`
54. `retooldb_item_md_info`
55. `return_per`
56. `round`
57. `sale_1`
58. `sale_2`
59. `sale_amt`
60. `sale_qty`
61. `sale_rate_raw`
62. `sale_week_1`
63. `sale_week_2`
64. `sales_price`
65. `sales_qty`
66. `season_cd`
67. `season_comparison`
68. `season_nm`
69. `sel_category`
70. `sex_nm`
71. `size_cd`
72. `size_data`
73. `sty_cd`
74. `sty_nm`
75. `tag_prce`
76. `tot_in_qty`
77. `tot_in_tag_amt`
78. `tot_sale_amt`
79. `tot_sale_amt_per`
80. `tot_sale_qty`
81. `tot_sale_qty_per`
82. `value`
83. `week_sale_qty`
84. `year_cd`
85. `year_nm`
86. `year_sesn_cd`
87. `year_sesn_nm_kor`

## 📁 파일별 테이블 상세

### IDE_test.sql

- `agabang_dw`
- `code_season`

### code_brand.sql

- `agabang`
- `plbrcd`

### code_season.sql

- `code_season`

### get_category_list.sql

- `item_md_category`

### get_category_list_new.sql

- `_category`
- `item_md_category`

### get_daily_sales_by_style.sql

- `agabang_dw`
- `avg_rate`
- `avg_sale_qty`
- `avg_sale_rate`
- `d_date`
- `daily_data_by_color`
- `daily_sales_by_color`
- `prod_sales_stock_by_color`
- `retooldb_item_md_info`
- `round`
- `tot_in_qty`

### get_item_detail.sql

- `agabang_dw`
- `cat_nm`
- `designer_nm`
- `fabric`
- `prod_comp`
- `prod_country`
- `prod_final_price`
- `prod_sales_stock_by_color`
- `retooldb_item_md_info`
- `sty_cd`
- `sty_nm`

### get_item_list_new.sql

- `CUM_IN_DATA`
- `FIRST_IN_DATE`
- `SIZE_DATA`
- `SIZE_DATA_EACH`
- `agabang_dw`
- `br_cd`
- `cat_nm`
- `coalesce`
- `col_cd`
- `col_nm`
- `concat`
- `cost_prce`
- `cum_in_amt`
- `cum_in_qty`
- `cust_nm`
- `daily_sales_by_size`
- `daily_shop_sales_by_size`
- `deli_dt`
- `designer_nm`
- `dim_style`
- `dim_style_color`
- `f_sale_prce`
- `fabric`
- `filtered_daily_shop_sale_by_size`
- `fin_date`
- `fout_date`
- `int_sale_qty`
- `item_nm`
- `item_raw_nm`
- `mark_up`
- `memo`
- `nation`
- `plan_qty`
- `preview_grade`
- `preview_score`
- `prod_country`
- `prod_sales_stock_by_size`
- `return_per`
- `round`
- `sale_1`
- `sale_2`
- `sale_amt`
- `sale_qty`
- `sale_week_1`
- `sale_week_2`
- `sales_price`
- `sales_qty`
- `season_cd`
- `season_nm`
- `sel_category`
- `sex_nm`
- `size_cd`
- `size_data`
- `sty_cd`
- `sty_nm`
- `tag_prce`
- `tot_in_qty`
- `tot_in_tag_amt`
- `tot_sale_amt`
- `tot_sale_amt_per`
- `tot_sale_qty`
- `tot_sale_qty_per`
- `value`
- `week_sale_qty`
- `year_cd`
- `year_nm`
- `year_sesn_cd`
- `year_sesn_nm_kor`

### get_item_size_detail.sql

- `agabang_dw`
- `prod_sales_stock_by_size`

### get_latest_seasons.sql

- `agabang_dw`
- `daily_shop_sales_by_dimension`
- `period_sales`
- `season_comparison`

### query_avg_sale_rate.sql

- `agabang_dw`
- `d_date`
- `daily_data_by_color`
- `retooldb_item_md_info`
- `sale_rate_raw`

### season_list.sql

- `agabang_dw`
- `code_season`


## 🔍 분석 요약

- **분석 대상:** apps/21. 버그 제보_개선 요청/아이템맵AG-CS자동화-test/lib 디렉토리의 모든 SQL 파일
- **처리된 파일:** 12개
- **발견된 고유 테이블:** 87개
- **문서 생성일시:** 2025-10-01 10:08:39 KST

---
*이 문서는 docScribe에 의해 자동 생성되었습니다.*
