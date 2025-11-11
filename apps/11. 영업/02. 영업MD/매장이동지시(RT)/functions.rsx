<GlobalFunctions>
  <SqlQuery
    id="seasonList"
    isImported={true}
    notificationDuration={4.5}
    playgroundQueryName="style_season_code"
    playgroundQueryUuid="386defec-d203-42c7-807b-0f418b7bced5"
    query={include("./lib/seasonList.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    retoolVersion="3.114.3"
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    updateSetValueDynamically={true}
    warningCodes={[]}
  />
  <SqlQuery
    id="yearList"
    isImported={true}
    notificationDuration={4.5}
    playgroundQueryName="style_year_code"
    playgroundQueryUuid="cf24dc36-552e-4fb8-85ea-084c4085fe7f"
    query={include("./lib/yearList.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    updateSetValueDynamically={true}
    warningCodes={[]}
  />
  <SqlQuery
    id="brandList"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/brandList.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="itList"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/itList.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="itGbList"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/itGbList.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="tpList"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/tpList.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="shopList"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/shopList.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    warningCodes={[]}
  />
  <SqlQuery
    id="rtListQuery"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/rtListQuery.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="/*
SELECTION ALGORITHM
*/
const getUniquePairsByKey = (arr, keys) => {
  return arr.reduce((acc, obj) => {
      const pairObj = {}
      keys.forEach(key => { pairObj[key] = obj[key] })
      const isExisted = acc.some(item => {
        return JSON.stringify(item) === JSON.stringify(pairObj)
      })
      
      if (!isExisted) {
        acc.push(pairObj)
      }
  
      return acc
    }, [])
}

// Get the appropriate amount to receive
const rtList = formatDataAsArray(data)

// Get the unique pairs by receivers
const selectedKeys = ['sty_cd', 'col_cd', 'size_cd']

const targetStyles = getUniquePairsByKey(rtList, selectedKeys)

// Select shops to send and receive
const result = []
for (const idx in targetStyles) {
  const style = targetStyles[idx]
  const targets = rtList
    .filter(item => {
      return selectedKeys.every(key => item[key] === style[key])
    })
  //  console.log('t', targets)
  
  const senders = getUniquePairsByKey(targets, ['shop_cd', 'stock_qty', 'tot_rt_in_qty', 'tot_rt_out_qty'])
  let recievers = getUniquePairsByKey(targets, ['shop_cd_b', 'tot_sales_qty_b'])

  const sortedSenders = senders
    .map(item => {
      if (item.tot_rt_out_qty === 0) {
        item.rt_ratio = item.tot_rt_in_qty
      } else {
        item.rt_ratio = item.tot_rt_in_qty / item.tot_rt_out_qty
      }
      return item
    })
    .sort((a, b) => { return b.rt_ratio - a.rt_ratio })
  recievers = recievers.map(obj => {
    const qty = Math.round(obj.tot_sales_qty_b * 0.30)
    if (qty >= 3) {
      return {...obj, receiveQty: 3}
    } else {
      return  {...obj, receiveQty: qty}
    }
  })
  
  // select shops per receiver's sales capacity
  console.log('senders', sortedSenders)
  console.log('recievers', recievers)

  for (const idx in sortedSenders) {
    const sender = sortedSenders[idx]
    const shopCdToSend = sender.shop_cd
    
    for (let i = 0; i < recievers.length; i++) {
      const receiver = recievers[i];
      
      if (receiver.receiveQty <= 0) continue;
      
      const shopCdToReceive = receiver.shop_cd_b;
      const matchedPair = targets.find(ele => 
        ele.shop_cd === shopCdToSend && ele.shop_cd_b === shopCdToReceive
      );
      if (matchedPair) {
        receiver.receiveQty -= 1;
        result.push({...matchedPair, sendQty: 1 })
        break;
      }
    }
  }
}

return result"
    warningCodes={[]}
  />
  <State id="itemCount" value="8" />
  <State id="selectedItem" value="{}" />
  <Function
    id="resultForExcel"
    funcBody={include("./lib/resultForExcel.js", "string")}
  />
</GlobalFunctions>
