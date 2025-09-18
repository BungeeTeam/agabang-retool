let result = await get_sales_data_new.trigger({
  additionalScope: {
    p_season_code: `${season_select.value}`,
    p_deadline_date: `${moment(date_select.value)}`,
  }
})

return result;