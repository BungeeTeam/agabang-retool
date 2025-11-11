select
  --distinct shop_cd, shop_nm, tp_nm, tp_cd, br_cd, biz_cd, biz_nm
  *
from agabang_dw.daily_shop_sales_by_dimension
where shop_nm = '남양주이마트 아가방2'
and biz_cd = 'DS' 
and tp_nm = '디즈니팝업'