<App>
  <Include src="./functions.rsx" />
  <UrlFragments
    id="$urlFragments"
    value={{
      ordered: [
        { bizMultiSelect: "{{ JSON.stringify(bizMultiSelect.value) }}" },
        { brandMultiSelect: "{{ JSON.stringify(brandMultiSelect.value) }}" },
        { tpSelect: "{{ tpSelect.value }}" },
        { teamSelect: "{{ teamSelect.value }}" },
        { userSelect: "{{ userSelect.value }}" },
        { areaSelect: "{{ areaSelect.value }}" },
        { searchText: "{{ searchText.value }}" },
      ],
    }}
  />
  <Include src="./header.rsx" />
  <Include src="./sidebar.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="0"
    sticky={null}
    type="main"
  >
    <DateRange
      id="dateRange"
      dateFormat="yyyy-MM-dd"
      endPlaceholder="종료일자"
      firstDayOfWeek={0}
      iconBefore="bold/interface-calendar-remove"
      label=""
      labelPosition="top"
      loading=""
      showClear={true}
      startPlaceholder="시작일자"
      textBefore="조회기간"
      textBetween="~"
      value={{
        ordered: [
          {
            start:
              '{{ moment().subtract(1, "days").startOf("month").format("YYYY-MM-DD") }}',
          },
          { end: '{{ moment().subtract(1, "days").format("YYYY-MM-DD") }}' },
        ],
      }}
    >
      <Event
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="periodicSalesQuery"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </DateRange>
    <TextInput
      id="searchText"
      iconBefore="bold/interface-search"
      label=""
      labelPosition="top"
      placeholder="매장명, 매장코드로 검색해 보세요"
      showClear={true}
      style={{ ordered: [] }}
      textBefore="검색"
    />
    <Module
      id="storeDetailModule1"
      endDate="{{ dateRange.value?.end }}"
      inputData="{{ periodicSalesQuery.data }}"
      inputDataByStyle=""
      margin="4px 8px"
      name="storeDetailModule"
      pageUuid="f4960172-fb37-11ef-af6c-1f09ee775f43"
      startDate="{{ dateRange.value?.start }}"
      v_shop_cd=""
    />
  </Frame>
</App>
