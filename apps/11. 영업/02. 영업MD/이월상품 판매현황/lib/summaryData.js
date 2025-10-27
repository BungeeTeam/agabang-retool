// groupBySum 함수는 전역에서 사용


  //  const curdata = {{ tabs1.value ==='합계' ? mergeCurOutSale.value : mergeCurOutSale.value.filter(i => i.onoff_flag === tabs1.value )}}
const curdata = {{ groupByCategory.value }}

  //  const prevData = {{ tabs1.value ==='합계' ? mergePrevOutSale.value : mergePrevOutSale.value.filter(i => i.onoff_flag === tabs1.value )}}
const prevData = {{ mergePrevOutSale.value }}

  const sumKeys = ["sale_tag","sale_qty","sale_amt","net_out_qty","net_out_tag","net_out_amt","ttl_out_qty","ttl_rtn_qty","ttl_out_amt","ttl_rtn_amt","ttl_out_tag","ttl_rtn_tag"]
  const keys = ["biz_cd", "biz_nm", "br_cd", "br_nm", "season_cd", "season_nm"]
  const groupedCurArr = groupBySum(curdata, keys, sumKeys)
  const groupedPrevArr = groupBySum(prevData, keys, sumKeys)

function generateResultRow(unit, curItem, prevItem, calcFn) {
  const row = { sale_unit: unit };
  sumKeys.forEach(key => {
    row[key] = calcFn(curItem[key] || 0, prevItem[key] || 0);
  });
  return row;
}

const cur = generateResultRow('조회기간', groupedCurArr[0], groupedPrevArr[0], (cur, _) => cur);
const prev = generateResultRow('전년동기', groupedCurArr[0], groupedPrevArr[0], (_, prev) => prev);
const diffAmt = generateResultRow('증감대비', groupedCurArr[0], groupedPrevArr[0], (cur, prev) => cur - prev);
//const diffRate = generateResultRow('증감율', groupedCurArr[0], groupedPrevArr[0], (cur, prev) => prev === 0 ? 0 : (cur / prev) - 1);

//return [cur, prev, diffAmt, diffRate];
return [cur, prev, diffAmt]; 