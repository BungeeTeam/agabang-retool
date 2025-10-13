// FILTER by selected options
let arrData = formatDataAsArray({{ periodicSalesByStyleQuery.data }}).filter(i=> i.sales_type === '용품')

arrData =  arrData.filter(item => item.rev && item?.rev > 0)

// by biz_div
arrData = arrData.filter(item => {{ bizMultiSelect3.value }}.includes(item.biz_cd))                       

//  by brand
arrData = arrData.filter(item => {{ brandMultiSelect3.value }}.includes(item.br_cd))


//  by sub-brand
arrData = arrData.filter(item => {{ subBrandMultiSelect2.value }}.includes(item.sub_br_cd))


return arrData