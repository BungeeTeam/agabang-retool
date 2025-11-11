const transform_data = formatDataAsArray(get_item_list.data);

let price_list = [];
transform_data.forEach(item => {

  let price = Number(item.item_price);
  if ( price == null ) {
    price = 0;
  }
  
  if ( ! price_list.includes(price) ){
    price_list.push(price)
  } 
});

if ( get_competitor_item_list.data != undefined ) {
  const transform_comp_data = formatDataAsArray(get_competitor_item_list.data);
  transform_comp_data.forEach(item => {
  
    let price = Number(item.item_price);
    if ( price == null ) {
      price = 0;
    }
    
    if ( ! price_list.includes(price) ){
      price_list.push(price)
    } 
  });
}

const sorted_price_list = price_list.sort((a, b) => a - b);
var_price_list.setValue(sorted_price_list)

return sorted_price_list