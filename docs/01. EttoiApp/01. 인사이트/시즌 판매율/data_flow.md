# Data Flow Documentation

**생성일시:** 2025-10-01 10:13:31 KST  
**소스 디렉토리:** `apps/01.%20EttoiApp/01.%20%EC%9D%B8%EC%82%AC%EC%9D%B4%ED%8A%B8/%EC%8B%9C%EC%A6%8C%20%ED%8C%90%EB%A7%A4%EC%9C%A8/lib`  
**총 SQL 파일 수:** 15개  
**총 테이블 수:** 116개

## 📊 전체 테이블 목록

1. `COUNT`
2. `RAW_SALES`
3. `ROUND`
4. `ROW_NUMBER`
5. `SALE_GB_SALES`
6. `SALE_GB_TREND`
7. `SHOP_IN`
8. `SHOP_IN_TOTAL`
9. `SHOP_IN_TREND`
10. `SHOP_SALES`
11. `SHOP_SALES_TOTAL`
12. `SHOP_SALES_TREND`
13. `agabang_dw`
14. `amt_sales_ratio`
15. `arrayMap`
16. `arrayStringConcat`
17. `avg_rate`
18. `avg_sale_qty`
19. `avg_sale_rate`
20. `base_tbl`
21. `base_tbl_agg`
22. `base_tbl_size_agg`
23. `br_cd`
24. `cat_nm`
25. `category_cum`
26. `category_inout`
27. `category_last_week`
28. `category_monthly`
29. `category_this_week`
30. `code_season`
31. `code_season_cur`
32. `code_season_prev`
33. `col_cd`
34. `col_nm`
35. `concat`
36. `cost_price`
37. `cum_sale_data`
38. `cum_sale_qty`
39. `d_date`
40. `daily_data_by_color`
41. `daily_data_by_size`
42. `daily_sales_by_color`
43. `daily_shop_dsoutrtn_by_size`
44. `daily_shop_sales_by_color`
45. `daily_shop_sales_by_dimension`
46. `designer_nm`
47. `dim_style`
48. `fabric`
49. `filtered_data`
50. `filtered_dim`
51. `fitered_cum_sales`
52. `gini`
53. `groupArray`
54. `it_gb`
55. `item`
56. `large_cat`
57. `middle_cat`
58. `online_sale_qty`
59. `online_sales_ratio`
60. `ord_qty`
61. `ord_tag_amt`
62. `plan_qty`
63. `plan_tag_amt`
64. `prod_comp`
65. `prod_country`
66. `prod_final_price`
67. `prod_sales_stock_by_color`
68. `prod_sales_stock_by_size`
69. `qty_sales_ratio`
70. `rank`
71. `replaceAll`
72. `retooldb_item_md_info`
73. `return_ratio`
74. `round`
75. `s_col_cd`
76. `s_sty_cd`
77. `saleTbl`
78. `sale_amt`
79. `sale_amt_tot`
80. `sale_dt`
81. `sale_gb`
82. `sale_per_tot`
83. `sale_per_trend`
84. `sale_qty`
85. `sale_qty_tot`
86. `sale_trend`
87. `sales_qty`
88. `season_cd`
89. `season_nm`
90. `shop_cd`
91. `shop_gini`
92. `shop_nm`
93. `shop_online`
94. `shop_sales_qty`
95. `shop_sales_ratio`
96. `shop_tbl`
97. `size_array`
98. `size_cd`
99. `size_nm`
100. `size_seq`
101. `size_tp`
102. `small_cat`
103. `sty_cd`
104. `sty_nm`
105. `tag_price`
106. `toJSONString`
107. `toString`
108. `tot_in_cost_amt`
109. `tot_in_qty`
110. `tot_in_tag_amt`
111. `tot_inventory`
112. `tot_sale_amt`
113. `tot_sale_qty`
114. `total_in_qty`
115. `year_cd`
116. `year_nm`

## 📁 파일별 테이블 상세

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

### get_item_size_detail.sql

- `agabang_dw`
- `prod_sales_stock_by_size`

### get_item_status.sql

- `COUNT`
- `ROUND`
- `ROW_NUMBER`
- `agabang_dw`
- `amt_sales_ratio`
- `base_tbl`
- `base_tbl_agg`
- `base_tbl_size_agg`
- `col_cd`
- `col_nm`
- `daily_data_by_size`
- `daily_shop_sales_by_color`
- `dim_style`
- `gini`
- `groupArray`
- `online_sale_qty`
- `online_sales_ratio`
- `prod_sales_stock_by_size`
- `qty_sales_ratio`
- `rank`
- `return_ratio`
- `sale_amt`
- `sale_amt_tot`
- `sale_gb`
- `sale_per_tot`
- `sale_qty`
- `sale_qty_tot`
- `sales_qty`
- `shop_cd`
- `shop_gini`
- `shop_online`
- `shop_sales_qty`
- `shop_sales_ratio`
- `shop_tbl`
- `size_array`
- `size_cd`
- `size_nm`
- `size_seq`
- `size_tp`
- `sty_cd`
- `sty_nm`
- `tag_price`
- `toJSONString`
- `tot_in_cost_amt`
- `tot_in_qty`
- `tot_in_tag_amt`
- `tot_inventory`
- `tot_sale_amt`
- `tot_sale_qty`

### get_item_status2.sql

- `COUNT`
- `ROUND`
- `ROW_NUMBER`
- `agabang_dw`
- `amt_sales_ratio`
- `base_tbl`
- `base_tbl_agg`
- `base_tbl_size_agg`
- `col_cd`
- `col_nm`
- `daily_data_by_size`
- `daily_shop_sales_by_color`
- `dim_style`
- `gini`
- `groupArray`
- `online_sale_qty`
- `online_sales_ratio`
- `prod_sales_stock_by_size`
- `qty_sales_ratio`
- `rank`
- `return_ratio`
- `sale_amt`
- `sale_amt_tot`
- `sale_gb`
- `sale_per_tot`
- `sale_qty`
- `sale_qty_tot`
- `sales_qty`
- `shop_cd`
- `shop_gini`
- `shop_online`
- `shop_sales_qty`
- `shop_sales_ratio`
- `shop_tbl`
- `size_array`
- `size_cd`
- `size_nm`
- `size_seq`
- `size_tp`
- `sty_cd`
- `sty_nm`
- `tag_price`
- `toJSONString`
- `tot_in_cost_amt`
- `tot_in_qty`
- `tot_in_tag_amt`
- `tot_inventory`
- `tot_sale_amt`
- `tot_sale_qty`

### get_latest_season.sql

- `agabang_dw`
- `daily_shop_sales_by_dimension`

### get_online_sales.sql

- `RAW_SALES`
- `SALE_GB_SALES`
- `SALE_GB_TREND`
- `agabang_dw`
- `arrayMap`
- `arrayStringConcat`
- `concat`
- `cum_sale_qty`
- `daily_shop_sales_by_color`
- `groupArray`
- `replaceAll`
- `sale_dt`
- `sale_gb`
- `sale_trend`
- `toString`

### get_sales_data_cur.sql

- `agabang_dw`
- `category_inout`
- `category_last_week`
- `category_monthly`
- `category_this_week`
- `daily_sales_by_color`
- `dim_style`
- `filtered_dim`
- `fitered_cum_sales`

### get_sales_data_new.sql

- `agabang_dw`
- `category_cum`
- `category_inout`
- `category_last_week`
- `category_monthly`
- `category_this_week`
- `cum_sale_data`
- `daily_sales_by_color`
- `dim_style`
- `filtered_data`

### get_sales_data_prev.sql

- `agabang_dw`
- `category_inout`
- `category_last_week`
- `category_monthly`
- `category_this_week`
- `daily_sales_by_color`
- `dim_style`
- `filtered_dim`
- `fitered_cum_sales`

### get_shop_sales.sql

- `SHOP_IN`
- `SHOP_IN_TOTAL`
- `SHOP_IN_TREND`
- `SHOP_SALES`
- `SHOP_SALES_TOTAL`
- `SHOP_SALES_TREND`
- `agabang_dw`
- `arrayMap`
- `col_cd`
- `cum_sale_qty`
- `daily_shop_dsoutrtn_by_size`
- `daily_shop_sales_by_color`
- `groupArray`
- `round`
- `sale_dt`
- `sale_per_trend`
- `sale_trend`
- `shop_cd`
- `shop_nm`
- `sty_cd`
- `toString`
- `total_in_qty`

### middle_cat_cur.sql

- `agabang_dw`
- `category_inout`
- `category_last_week`
- `category_monthly`
- `category_this_week`
- `daily_sales_by_color`
- `dim_style`
- `filtered_dim`
- `fitered_cum_sales`

### middle_cat_prev.sql

- `agabang_dw`
- `category_inout`
- `category_last_week`
- `category_monthly`
- `category_this_week`
- `daily_sales_by_color`
- `dim_style`
- `filtered_dim`
- `fitered_cum_sales`

### salesByColor.sql

- `COUNT`
- `ROUND`
- `ROW_NUMBER`
- `agabang_dw`
- `br_cd`
- `col_cd`
- `col_nm`
- `cost_price`
- `daily_sales_by_color`
- `daily_shop_sales_by_color`
- `dim_style`
- `gini`
- `it_gb`
- `item`
- `large_cat`
- `middle_cat`
- `online_sale_qty`
- `online_sales_ratio`
- `ord_qty`
- `ord_tag_amt`
- `plan_qty`
- `plan_tag_amt`
- `prod_sales_stock_by_color`
- `rank`
- `s_col_cd`
- `s_sty_cd`
- `saleTbl`
- `season_cd`
- `season_nm`
- `shop_cd`
- `shop_gini`
- `shop_online`
- `shop_sales_qty`
- `shop_sales_ratio`
- `shop_tbl`
- `small_cat`
- `sty_cd`
- `sty_nm`
- `tag_price`
- `tot_sale_qty`
- `year_cd`
- `year_nm`

### season_list_new.sql

- `agabang_dw`
- `code_season`
- `code_season_cur`
- `code_season_prev`


## 🔍 분석 요약

- **분석 대상:** apps/01.%20EttoiApp/01.%20%EC%9D%B8%EC%82%AC%EC%9D%B4%ED%8A%B8/%EC%8B%9C%EC%A6%8C%20%ED%8C%90%EB%A7%A4%EC%9C%A8/lib 디렉토리의 모든 SQL 파일
- **처리된 파일:** 15개
- **발견된 고유 테이블:** 116개
- **문서 생성일시:** 2025-10-01 10:13:31 KST

---
*이 문서는 docScribe에 의해 자동 생성되었습니다.*
