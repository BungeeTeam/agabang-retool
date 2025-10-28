const shopListFromDW = {{ formatDataAsArray(shopListQuery2.data) }}
const shopListFromRetool = {{ formatDataAsArray(shopList2.data) }}

const result = shopListFromDW.map(obj => {
  const found = shopListFromRetool.find(item => item.shop_cd === obj.shop_cd)
  return {
    ...obj,
    is_checked: found?.is_checked || false,
    default_qty: found?.default_qty || 0
  }
})

return result