// groupBySum 함수는 전역에서 사용

  const data = {{ tabs1.value ==='합계' ? mergeCurOutSale.value : mergeCurOutSale.value.filter(i => i.onoff_flag === tabs1.value )}}

  const keys = ["biz_cd", "biz_nm", "br_cd", "br_nm", 
                "season_cd", "season_nm",
                "onoff_flag",
                "shop_cd","shop_nm",
               "tp_cd", "tp_nm"]

  const sumKeys = ["sale_tag","sale_qty","sale_amt","net_out_qty","net_out_tag","net_out_amt","ttl_out_qty","ttl_rtn_qty","ttl_out_amt","ttl_rtn_amt","ttl_out_tag","ttl_rtn_tag"]

  const groupedArr = groupBySum(data, keys, sumKeys)

return groupedArr
