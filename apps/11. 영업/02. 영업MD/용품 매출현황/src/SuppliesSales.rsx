<Screen
  id="SuppliesSales"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title="용품 매출현황"
  urlSlug=""
>
  <Folder id="archive">
    <Function
      id="getPeriodicSalesByStyleQuery"
      funcBody={include("../lib/getPeriodicSalesByStyleQuery.js", "string")}
    />
    <Function
      id="groupByItGbSubBrand_backup"
      funcBody={include("../lib/groupByItGbSubBrand_backup.js", "string")}
    />
  </Folder>
  <JavascriptQuery
    id="SuppliesSetValue"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("../lib/SuppliesSetValue.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
  <SqlQuery
    id="getSalesByShop"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("../lib/getSalesByShop.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="let arrData = formatDataAsArray(data)
//  arrData = arrData.filter(item => item.cur_amt && item?.cur_amt > 0)

// by biz_div
arrData = arrData.filter(item => {{ bizMultiSelect.value }}.includes(item.biz_cd))                       

//  by brand
arrData = arrData.filter(item => {{ brandMultiSelect.value }}.includes(item.br_cd))


//  by sub-brand
arrData = arrData.filter(item => {{ subBrandMultiSelect.value }}.includes(item.sub_br_cd))


return arrData"
    warningCodes={[]}
  />
  <SqlQuery
    id="getOutByShop"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("../lib/getOutByShop.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <Function
    id="groupByItGb"
    funcBody={include("../lib/groupByItGb.js", "string")}
  />
  <Function
    id="groupByItem"
    funcBody={include("../lib/groupByItem.js", "string")}
  />
  <Function
    id="groupBySubBrand"
    funcBody={include("../lib/groupBySubBrand.js", "string")}
  />
  <State id="selectedRow_old" />
  <Function
    id="filterBySelectedRow"
    funcBody={include("../lib/filterBySelectedRow.js", "string")}
  />
  <Include src="./modalFrameShopList.rsx" />
  <Include src="./sidebar1.rsx" />
  <Frame
    id="$main2"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 8px"
    sticky={null}
    type="main"
  />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Tabs
      id="tabs1"
      itemMode="static"
      navigateContainer={true}
      targetContainerId="container1"
      value="{{ self.values[0] }}"
    >
      <Option id="519b8" label="중분류별" value="Tab 1" />
      <Option id="528ab" label="소분류별" value="Tab 2" />
      <Option id="7366f" label="서브브랜드별" value="서브브랜드" />
    </Tabs>
    <DateRange
      id="dateRange"
      dateFormat="yyyy-MM-dd"
      endPlaceholder="종료일자"
      firstDayOfWeek={0}
      iconBefore="bold/interface-calendar-remove"
      label=""
      labelPosition="top"
      loading=""
      startPlaceholder="시작일자"
      textBefore="조회기간"
      textBetween="~"
      value={{
        ordered: [
          {
            start:
              '{{ moment().subtract(1, "days").startOf("month").format("YYYY-MM-DD") }}',
          },
          { end: '{{ moment().subtract(1, "days").format("YYYY-MM-DD") }} }}' },
        ],
      }}
    >
      <Event
        event="submit"
        method="trigger"
        params={{
          ordered: [
            {
              options: {
                object: {
                  onSuccess: null,
                  onFailure: null,
                  additionalScope: null,
                },
              },
            },
          ],
        }}
        pluginId="getSalesByShop"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="SuppliesSetValue"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </DateRange>
    <Switch
      id="switch1"
      label="원가 보기"
      labelAlign="right"
      labelPosition="left"
    />
    <Include src="./container1.rsx" />
  </Frame>
</Screen>
