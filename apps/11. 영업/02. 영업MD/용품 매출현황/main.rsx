<App>
  <Include src="./functions.rsx" />
  <Include src="./src/salesBySalesType.rsx" />
  <Include src="./src/inSeasonSales.rsx" />
  <Include src="./src/offSeasonSales.rsx" />
  <Include src="./src/suppliesSales.rsx" />
  <Include src="./src/SuppliesSales.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <DocumentTitle id="$customDocumentTitle" value="용품 매출현황" />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrame1.rsx" />
  <Include src="./sidebar.rsx" />
</App>
