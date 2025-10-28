const distributionPlan = {{ distPlan2.value }}

let result = []
distributionPlan.map(obj => {
  const distPlan = obj?.distStrategy
  if (distPlan) {
    const distWithInfo = distPlan.map(item => {
      item.large_cat = obj.large_cat
      item.middle_cat = obj.middle_cat
      item.small_cat = obj.small_cat
      item.sty_cd = obj.sty_cd
      item.col_cd = obj.col_cd
      item.size_cd = obj.size_cd
      item.related_info = obj.related_info
      return item
    })
    result.push(...distWithInfo.filter(obj => obj.plan_qty > 0))
  }
})

return result