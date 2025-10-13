let data;

if ({{ tabsOnOff.value }} === '합계')  {
 data = {{ periodicSalesByStyleQuery.data }};
} else {
 data = {{ periodicSalesByStyleQuery.data }}.filter(
  i => i.onoff_flag === {{ tabsOnOff.value }}
 );
}

return data;