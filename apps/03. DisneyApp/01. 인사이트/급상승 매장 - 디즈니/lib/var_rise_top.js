const _data = {{rise_top.data}}

const _ret_val = _data.map(item => {

  const _list_str_format = item.daily_sales_qty_array.replace(/(\d{4}-\d{2}-\d{2})/g, '"$1"')

  const _list = JSON.parse(_list_str_format)

  // 리스트에서 판매량만 불러온 뒤 최댓값, 최솟값을 구함

  const _sales = _list.reduce((acc, cur) => {
    acc.push(cur[1])
    return acc
  }, [])

  item.sales = _sales
  
  const _count = _list.length
  const _max = Math.max(..._sales)
  const _min = Math.min(..._sales)
  
  // viewBox 크기 지정
  
  const _height = 300
  const _width = 500
  const _max_width = _width + 150
  
  // 포인트들의 포지션 지정
  
  const _points = []

  const _avg_num = item.avg_week_sales_qty

  const _xs = []
  const _ys = []
  
  for(let i=0; i<_sales.length; i++) {
    const _cur = _sales[i]
    
    const _x = Math.round((_width / (_count - 1)) * i)
    _xs.push(_x)
    
    const _y = _height - Math.round((_height * 0.9) * ((_cur - _min) / (_max - _min))) - _height * 0.05
    _ys.push(_y)
    
    _points.push(`${_x},${_y}`)
  }

  const _avg = _height - Math.round((_height * 0.9) * ((_avg_num - _min) / (_max - _min))) - _height * 0.05

  item.xs = _xs
  item.ys = _ys
  
  const _html = `
  <svg viewBox="0 0 ${_max_width} ${_height}" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg" style="width: 100%; height: 100%;">

    <rect width="100%" height="100%" fill="white"/>
  
    <line x1="0" y1="${_avg}" x2="${_width + 40}" y2="${_avg}"
    stroke="#BBBBBB" stroke-dasharray="20, 20" stroke-width="10"/>
    <text x="${_width + 60}" y="${_avg + 35}" font-size="80" fill="#BBBBBB">${_avg_num}</text>
    
    <polyline points="
      ${_points.join(' ')}"
      stroke="red" stroke-width="10" fill="none"
      stroke-linejoin="round" stroke-linecap="round"
    />
        
  </svg>
  `
  
  const _base64Svg = btoa(unescape(encodeURIComponent(_html)))
  
  const _src = `data:image/svg+xml;base64,${_base64Svg}`
  
  item.src = _src
  
  return item
  
})

return _ret_val





