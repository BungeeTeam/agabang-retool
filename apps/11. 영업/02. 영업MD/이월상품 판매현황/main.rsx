<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrame1.rsx" />
  <Include src="./sidebar.rsx" />
  <Include src="./src/splitPaneFrame1.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 2px"
    sticky={null}
    type="main"
  >
    <Text
      id="text15"
      value="##### {{ brandMultiSelect2.selectedLabel }} {{ yearSelect2.selectedItem.year_nm }} {{ yearSelect2.selectedItem.season_nm }} 이월 판매현황 요약 "
      verticalAlign="center"
    />
    <Text
      id="text20"
      disableMarkdown={true}
      value="* 판매: 전년도 {{ yearSelect2.selectedItem.season_nm }} 정상 시즌마감일({{ yearSelect2.selectedItem.last_season_end_dt }})부터 판매마감일({{ moment(endDate.value).format('YYYY-MM-DD')}})까지
* 출고: 전년도 {{ yearSelect2.selectedItem.season_nm }} 정상 시즌마감일({{ yearSelect2.selectedItem.last_season_end_dt }})부터 초도출고 마감일/올해 정상 시즌마감일({{ getOutEndDate.data[0].outEndDate }})까지"
      verticalAlign="center"
    />
    <Include src="./src/tabbedContainer1.rsx" />
  </Frame>
</App>
