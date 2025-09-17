<App>
  <Include src="./functions.rsx" />
  <Include src="./src/all_reports.rsx" />
  <Include src="./src/admin.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <Include src="./src/form.rsx" />
  <Include src="./src/dashboard.rsx" />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrame1.rsx" />
  <Include src="./src/modalFrameAdmin.rsx" />
  <Include src="./src/modalFrameReportsDetailUser.rsx" />
</App>
