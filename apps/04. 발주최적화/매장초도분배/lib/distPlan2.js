let styList = {{ formatDataAsArray(styQuery2.data) }}
const distData = {{ orderDistQuery2.data }}
const minQty = {{ minNumberInput2.value }}
const shopList = {{ shopListCombined2.value }}
const fixedShopList = shopList.filter(shop => shop.default_qty > 0)
const fixedShopCodes = fixedShopList.map(obj => obj.shop_cd)
const activeShopList = shopList.filter(shop => !fixedShopCodes.includes(shop.shop_cd) && shop.is_checked === true)
const shopTypeList = ["severe_overstock", "overstock", "optimal", "understock"]
const distRatio = {{ distRatio2.value }}

// determine which info a style is aligned with
styList = styList.map(obj => {
  if (!obj?.large_cat) {
    return 
  }
  const related_items = obj.related_items.slice(1, -1)?.length > 0 ? obj.related_items.slice(1, -1)?.split(', ') : []
  if (related_items?.length > 0) {
    return {...obj, related_info: {"sty_cd": related_items}}
  }
  else {
    const lastSeasonCatInfo = {{ lastSeasonCatQuery2.data }}
    const isSmallCat = lastSeasonCatInfo.find(item => item.large_cat === obj.large_cat && item.middle_cat === obj.middle_cat && item.small_cat === obj.small_cat)
    if (isSmallCat) {
      return {...obj, related_info: {"small_cat": isSmallCat}}
    } else {
      const isMiddleCat = lastSeasonCatInfo.find(item => item.large_cat === obj.large_cat && item.middle_cat === obj.middle_cat)
      if (isMiddleCat) {
        return {...obj, related_info: {"middle_cat": isMiddleCat}}  
      } else {
        return {...obj, related_info: {"large_cat": obj.large_cat}}  
      }
    }
  }
})

// get distribution info upto each assigned info
styList = styList.map(obj => {
  const distStrategy = []
  let plan_qty = Math.floor((obj?.plan_qty || 0) * distRatio)
  if (plan_qty <= 1) {
    return obj
  }
  
  // 0. Distribute to fixed shops first
  fixedShopList.map(shop => {
    if (plan_qty - shop.default_qty > 0) {
      distStrategy.push({...shop, plan_qty: shop.default_qty})
      plan_qty -= shop.default_qty  
    }
  })
  //  console.log("obj", obj)
  const related_info = obj?.related_info
  if(!related_info) {
    return
  }
  let dist
  if ("sty_cd" in related_info) {
    const cond = related_info["sty_cd"]
    dist = distData.filter(item => cond.includes(item.sty_cd))
  } else if ("small_cat" in related_info) {
    const cond = related_info["small_cat"]
    dist = distData
      .filter(item => item.sty_cd === "-")
      .filter(item => {
        return Object.keys(cond).every(key => {
          return item[key] === cond[key]
        })
      })
  } else if ("middle_cat" in related_info) {
    const cond = related_info["middle_cat"]
    dist = distData
      .filter(item => item.sty_cd === "-" && item.small_cat === "-")
      .filter(item => item.large_cat === cond.large_cat && item.middle_cat === cond.middle_cat)
  } else if ("large_cat" in related_info) {
    const cond = related_info["large_cat"]
    dist = distData
      .filter(item => item.sty_cd === "-" && item.small_cat === "-" && item.middle_cat === "-")
      .filter(item => item.large_cat === cond.large_cat)
  } 
  console.log("dist", dist)
  
  if (!dist || dist.length === 0) {
    // if no matched, then large cat with the most revenue is assigned
    const catList = distData
      .filter(item => item.sty_cd === "-" && item.small_cat === "-" && item.middle_cat === "-")
    console.log("catList", catList)
    const catSummary = catList.reduce((acc, cat) => {
      acc[cat.large_cat] = (acc[cat.large_cat] || 0) + (cat?.sales_qty || 0)
      return acc
    }, {})
    console.log("catSummary", catSummary)
    const maxKey = Object.keys(catSummary)
      .reduce((a, b) => catSummary[a] > catSummary[b] ? a : b)
    dist = distData
      .filter(item => item.sty_cd === "-" && item.small_cat === "-" && item.middle_cat === "-")
      .filter(item => item.large_cat === maxKey)
  }

  /* Distribution Logic */
  const summaryQty = {}
  dist.forEach(item => {
    summaryQty[item.segment] = summaryQty?.[item.segment] || {}
    summaryQty[item.segment]["num"] = (summaryQty[item.segment]["num"] || 0) + 1;
    summaryQty[item.segment]["sales_qty"] = (summaryQty[item.segment]["sales_qty"] || 0) + item.sales_qty;
    summaryQty["ttl"] = (summaryQty["ttl"] || 0) + item.sales_qty;
  })
  
  shopTypeList.forEach(type => {
    if (summaryQty?.[type]) {
      summaryQty[type]["ratio"] = summaryQty[type]["sales_qty"] > 0 ? summaryQty[type]["sales_qty"] / summaryQty["ttl"] : 0
    }
  })
  
  const targetShopList = activeShopList.map(shop => {
    const cat = dist.find(obj => obj.shop_cd === shop.shop_cd)
    shop.segment = cat?.segment || "overstock"
    shop.in_qty = cat?.in_qty || 0
    shop.sales_qty = cat?.sales_qty || 0
    shop.ratio = cat?.ratio
    return shop
  })

  const targetLength = targetShopList.length
  
  //  console.log("0. initial plan_qty: ", plan_qty, obj.sty_cd, obj.col_cd, obj.size_cd )
  //  console.log("1. summary: ", summaryQty )
  
  // Determine the min qty for all shops
  const minDistQty = Math.min(Math.floor(plan_qty / targetLength), minQty)
  //  console.log("minDistQty", minDistQty)

  const distSummary = {}
  activeShopList.forEach(shop => {
    if (distSummary?.[shop.segment]) {
      distSummary[shop.segment]["num"] = (distSummary[shop.segment]["num"] || 0) + 1
    } else {
      distSummary[shop.segment] = {}
    }
  })

  // 1. Assgin the min qty for all type shops first
  let r = plan_qty - targetLength * minDistQty
  //  console.log("remainder", r)
  shopTypeList.forEach(type => {
    if (distSummary?.[type]) {
      distSummary[type]["common_min_qty"] = minDistQty
      distSummary[type]["type_dist_qty"] = Math.floor(r * summaryQty[type]["ratio"])
      distSummary[type]["type_min_qty"] = Math.floor(distSummary[type]["type_dist_qty"] / distSummary[type]["num"])
      distSummary[type]["remainder"] = distSummary[type]["type_dist_qty"] - distSummary[type]["type_min_qty"] * distSummary[type]["num"]
    }
  })
  //  console.log(targetLength, "target_shop_summary", distSummary)

  // 2. Distribute the initial qty upto the plan
  shopTypeList.forEach(type => {
    const distPlan = distSummary[type]
    if (distPlan) {
      let remainder = distPlan.remainder
      const baseQty = distPlan.common_min_qty + distPlan.type_min_qty
      //  console.log(type, distPlan, baseQty)
      const shopListByType = targetShopList
        .filter(obj => obj.segment === type)
        .sort((a, b) => b.sales_qty - a.sales_qty)
      for (let i = 0; i < shopListByType.length; i++) {
        if (i < remainder) {
          const shop = shopListByType[i];
          distStrategy.push({...shop, plan_qty: 1 + baseQty})  
        } else {
          const shop = shopListByType[i];
          distStrategy.push({...shop, plan_qty: baseQty})  
        }
      }
    }
  })
  //  console.log('strategy', distStrategy)
  
  // Get distribution stats.
  const distByQty = {}
  dist.forEach(item => {
    distByQty[item.sales_qty] = (distByQty[item.sales_qty] || 0) + 1;
  })

  const distByRatio = {}
  dist.forEach(item => {
    const ratio = Number(item.ratio.toFixed(2))
    distByRatio[ratio] = (distByRatio[ratio] || 0) + 1;
  })  

  return {...obj, actualPlanQty: plan_qty, summaryQty, distStrategy, distByQty, distByRatio}  
})


return styList