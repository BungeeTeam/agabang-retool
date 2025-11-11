const _season_data = season_select.data?.[0]?.sesn_cd ?? null;

const isValidDate = (date) => {
  return date && !isNaN(Date.parse(date));
};

// 1. deadline_date
const deadlineValue = isValidDate(urlparams?.hash?.deadline_date)
  ? urlparams.hash.deadline_date
  : new Date().toISOString().split("T")[0];
console.log("deadlineValue: " + deadlineValue);

// 2. year_sesn_cd
const seasonValue = urlparams?.hash?.year_sesn_cd ?? _season_data;
console.log("seasonValue: " + seasonValue);

// 3. hide_columns
const hideColumns = urlparams?.hash?.hide_columns !== undefined 
  ? Boolean(urlparams.hash.hide_columns)
  : true;
console.log("hideColumns: " + hideColumns);

// 4. comparison_basis
const comparisonBasisRaw = urlparams?.hash?.comparison_basis ?? null;
const comparisonBasis = comparisonBasisRaw;
console.log("comparisonBasis: ", comparisonBasis);

// 값 설정
await season_select.setValue(seasonValue);
await date_select.setValue(deadlineValue);
await inventory_columns_toggle.setValue(hideColumns);
await comparison_basis_select.setValue(comparisonBasis);

await salesByColor.trigger();