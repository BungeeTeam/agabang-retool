<Screen
  id="ettoiPage"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title="Default Page"
  urlSlug="agabangPage2"
>
  <Folder id="ops">
    <SqlQueryUnified
      id="updateRetoolDB2"
      actionType="UPDATE_BY"
      changeset={
        '[{"key":"is_checked","value":"{{ !shopTbl2.selectedRow?.is_checked }}"}]'
      }
      changesetObject="{{ styTbl2.changesetArray[0] }}"
      doNotThrowOnNoOp={true}
      editorMode="gui"
      filterBy={
        '[{"key":"shop_cd","value":"{{ shopTbl2.selectedRow?.shop_cd }}","operation":"="},{"key":"biz_cd","value":"{{ bizcd2.value }}","operation":"="}]'
      }
      isMultiplayerEdited={false}
      query={include("../lib/updateRetoolDB2.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      tableName="dim_shop_v2"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="refresh"
        params={{ ordered: [] }}
        pluginId="shopTbl2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="updateDefaultQty2"
      actionType="BULK_UPDATE_BY_KEY"
      bulkUpdatePrimaryKey="idx"
      changesetIsObject={true}
      changesetObject="{{ defaultShopTbl2.changesetArray }}"
      editorMode="gui"
      enableTransformer={true}
      filterBy={
        '[{"key":"shop_cd","value":"{{ defaultShopTbl2.changesetArray.map(row => row.shop_cd) }}","operation":"IN"}]'
      }
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      records="{{ defaultShopTbl2.changesetArray }}"
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="dim_shop_v2"
      updateSetValueDynamically={true}
    >
      <Event
        event="success"
        method="trigger"
        params={{
          ordered: [
            {
              options: {
                ordered: [
                  { onSuccess: null },
                  { onFailure: null },
                  { additionalScope: null },
                ],
              },
            },
          ],
        }}
        pluginId="shopList2"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="updateShopWithRevenue2"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/updateShopWithRevenue2.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="updateShopByGroup2"
      query={include("../lib/updateShopByGroup2.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="shopList2"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="resetShopStatus2"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/resetShopStatus2.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <SqlQuery
      id="effectiveShops2"
      enableTransformer={true}
      isMultiplayerEdited={false}
      query={include("../lib/effectiveShops2.sql", "string")}
      queryTimeout="120000"
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      warningCodes={[]}
    />
    <SqlQuery
      id="getGroupInfo2"
      query={include("../lib/getGroupInfo2.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      warningCodes={[]}
    />
    <SqlQuery
      id="getSelectedGroupShop2"
      enableTransformer={true}
      isMultiplayerEdited={false}
      query={include("../lib/getSelectedGroupShop2.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      warningCodes={[]}
    />
  </Folder>
  <Folder id="loadData">
    <State id="brcd2" value={'"07"'} />
    <State id="selectedShop2" value="" />
    <State id="bizcd2" value={'"A4"'} />
    <State id="selectedRow2" value="{}" />
    <SqlQuery
      id="styQuery2"
      enableTransformer={true}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("../lib/styQuery2.sql", "string")}
      queryTimeout="120000"
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      showSuccessToaster={false}
      transformer={
        'let arrData = formatDataAsArray(data)\n\nconst largeCat = {{ largeCatSelect2.value }}\narrData = arrData.filter(item => item.it === largeCat)\n\nconst middleCat = {{ middleCatSelect2.value }}\nif (middleCat !== "-1") {\n  arrData = arrData.filter(item => item.it_gb === middleCat)\n}\n\nconst smallCat = {{ smallCatSelect2.value }}\nif (smallCat !== "-1") {\n  arrData = arrData.filter(item => item.item === smallCat)\n}\n\nconst styCd = {{ stySelect2.value }}\nif (styCd.length > 0) {\n  arrData = arrData.filter(item => styCd.includes(item.sty_cd))\n}\n\nconst sizeCd = {{ sizeSelect2.value }}\nif (sizeCd !== "-1") {\n  arrData = arrData.filter(item => item.size_cd === sizeCd)\n}\n\nreturn formatDataAsObject(arrData)'
      }
      warningCodes={[]}
      watchedParams={[
        "brcd2.value",
        'seasonSelect2.value || "-"',
        "largeCatSelect2.value",
        "middleCatSelect2.value",
        "smallCatSelect2.value",
        "stySelect2.value",
        "sizeSelect2.value",
      ]}
    />
    <SqlQuery
      id="seasonQuery2"
      isMultiplayerEdited={false}
      query={include("../lib/seasonQuery2.sql", "string")}
      queryTimeout="120000"
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      warningCodes={[]}
    />
    <SqlQuery
      id="catInfoQuery2"
      enableTransformer={true}
      isMultiplayerEdited={false}
      query={include("../lib/catInfoQuery2.sql", "string")}
      queryTimeout="120000"
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      resourceTypeOverride=""
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    />
    <Function
      id="shopListCombined2"
      funcBody={include("../lib/shopListCombined2.js", "string")}
    />
    <SqlQueryUnified
      id="shopList2"
      isMultiplayerEdited={false}
      query={include("../lib/shopList2.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      warningCodes={[]}
    />
    <SqlQuery
      id="shopListQuery2"
      actionType=""
      bulkUpdatePrimaryKey=""
      cacheKeyTtl="3600"
      doNotThrowOnNoOp={false}
      editorMode="sql"
      enableBulkUpdates={false}
      enableCaching={true}
      filterBy=""
      isMultiplayerEdited={false}
      query={include("../lib/shopListQuery2.sql", "string")}
      queryTimeout="100000"
      recordId=""
      records=""
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      resourceTypeOverride=""
      tableName=""
      warningCodes={[]}
    />
  </Folder>
  <Folder id="distributionLogic">
    <Function
      id="distPlan2"
      funcBody={include("../lib/distPlan2.js", "string")}
    />
    <SqlQuery
      id="lastSeasonCatQuery2"
      enableTransformer={true}
      isMultiplayerEdited={false}
      query={include("../lib/lastSeasonCatQuery2.sql", "string")}
      queryTimeout="120000"
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    />
    <Function
      id="shopPlan2"
      funcBody={include("../lib/shopPlan2.js", "string")}
    />
    <SqlQuery
      id="orderDistQuery2"
      enableTransformer={true}
      isMultiplayerEdited={false}
      query={include("../lib/orderDistQuery2.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    />
  </Folder>
  <Include src="./header2.rsx" />
  <Include src="./distDrawerFrame2.rsx" />
  <Include src="./groupSelectModal2.rsx" />
  <Include src="./shopSelectDrawer2.rsx" />
  <Include src="./shopSelectionModal2.rsx" />
  <Frame
    id="$main2"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    type="main"
  >
    <Include src="./container5.rsx" />
    <Spacer id="spacer12" />
    <Text
      id="text47"
      value="###### 1. 초도 관련 매장 분배 설정"
      verticalAlign="center"
    />
    <Button
      id="button6"
      margin="4px 4px"
      submitTargetId=""
      text="조건 설정하기"
    >
      <Event
        event="click"
        method="show"
        params={{ ordered: [] }}
        pluginId="shopSelectDrawer2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Spacer id="spacer11" />
    <Text
      id="text58"
      value="###### 2. 매장별 초도 배분 검토"
      verticalAlign="center"
    />
    <Table
      id="shopStat2"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ groupBySum(shopPlan2.value, ['shop_cd', 'shop_nm', 'large_cat', 'middle_cat', 'small_cat', 'tp_nm', 'team_nm', 'user_nm', 'related_info'], ['in_qty', 'sales_qty', 'plan_qty'])
  .sort((a, b) => b.sales_qty - a.sales_qty) }}"
      defaultFilterOperator="or"
      defaultFilters={{
        0: {
          ordered: [
            { id: "1b6a8" },
            { columnId: "77e78" },
            { operator: "includes" },
            { value: "" },
            { disabled: false },
          ],
        },
        1: {
          ordered: [
            { id: "4ce03" },
            { columnId: "83dbc" },
            { operator: "includes" },
            { value: "" },
            { disabled: false },
          ],
        },
      }}
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[{ object: { columnId: "de51e", direction: "desc" } }]}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableExpandableRows={true}
      enableSaveActions={true}
      margin="0"
      rowHeight="xsmall"
      showBorder={true}
      showHeader={true}
      showSummaryRow={true}
    >
      <Include src="./shopStat2ExpandedRow.rsx" />
      <Column
        id="83dbc"
        alignment="left"
        editable={false}
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="shop_cd"
        label="매장코드"
        placeholder="Enter value"
        position="left"
        size={58}
        summaryAggregationMode="none"
      />
      <Column
        id="77e78"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="left"
        size={127.578125}
        summaryAggregationMode="none"
      />
      <Column
        id="36d93"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="plan_qty"
        label="분배수량"
        placeholder="Enter value"
        position="center"
        size={57.484375}
        summaryAggregationMode="sum"
      />
      <Column
        id="1cc5f"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="large_cat"
        label="대분류"
        placeholder="Select option"
        position="center"
        size={86.859375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="0e21a"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="middle_cat"
        label="중분류"
        placeholder="Enter value"
        position="center"
        size={47.109375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="81f1e"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="small_cat"
        label="소분류"
        placeholder="Enter value"
        position="center"
        size={47.109375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="bbefa"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="유통채널"
        placeholder="Enter value"
        position="center"
        size={78.21875}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="7121d"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="team_nm"
        label="팀명"
        placeholder="Enter value"
        position="center"
        size={41.796875}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="b4de1"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="user_nm"
        label="담당자명"
        placeholder="Enter value"
        position="center"
        size={57.484375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="88c2f"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="in_qty"
        label="입고수량"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="sum"
      />
      <Column
        id="de51e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="sales_qty"
        label="판매수량"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="sum"
      />
      <Column
        id="17720"
        alignment="left"
        format="json"
        groupAggregationMode="none"
        hidden="true"
        key="related_info"
        label="Related info"
        placeholder="Enter value"
        position="center"
        size={0}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          params={{
            ordered: [{ options: { ordered: [{ fileType: "csv" }] } }],
          }}
          pluginId="shopStat2"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="expandRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="selectedShop2"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="selectRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="selectedShop2"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Spacer id="spacer9" />
    <Text
      id="text48"
      value="###### 3. 스타일별 초도 배분 검토"
      verticalAlign="center"
    />
    <Table
      id="styTbl2"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ styQuery2.data }}"
      defaultFilterOperator="or"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      margin="0"
      rowHeight="xsmall"
      showBorder={true}
      showHeader={true}
      showSummaryRow={true}
    >
      <Column
        id="adcf1"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="large_cat"
        label="대분류"
        placeholder="Select option"
        position="left"
        size={97.6875}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="0969e"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="middle_cat"
        label="중분류"
        placeholder="Enter value"
        position="left"
        size={75.453125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="dbdaf"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="small_cat"
        label="소분류"
        placeholder="Enter value"
        position="left"
        size={79.734375}
        summaryAggregationMode="none"
      />
      <Column
        id="1e7fc"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        key="sty_cd"
        label="스타일코드"
        placeholder="Enter value"
        position="center"
        size={91.390625}
        summaryAggregationMode="countDistinct"
      />
      <Column
        id="2b7c3"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="스타일명"
        placeholder="Enter value"
        position="center"
        size={132.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="df09a"
        alignment="left"
        format="tag"
        formatOptions={{
          automaticColors: false,
          color:
            " {{ JSON.parse(retoolContext.configVars.var_color_dict)[item] }}",
        }}
        groupAggregationMode="none"
        key="col_nm"
        label="색상명"
        placeholder="Select option"
        position="center"
        size={77.71875}
        summaryAggregationMode="none"
      />
      <Column
        id="f21d7"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="col_cd"
        label="색상코드"
        placeholder="Enter value"
        position="center"
        size={64.25}
      />
      <Column
        id="f1aed"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="size_cd"
        label="사이즈코드"
        placeholder="Enter value"
        position="center"
        size={74.3125}
      />
      <Column
        id="6a607"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="size_nm"
        label="사이즈명"
        placeholder="Enter value"
        position="center"
        size={69.625}
        summaryAggregationMode="none"
      />
      <Column
        id="e383a"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="plan_dt"
        label="기획일자"
        placeholder="Enter value"
        position="center"
        size={86.84375}
        summaryAggregationMode="none"
      />
      <Column
        id="6721f"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="plan_qty"
        label="기획수량"
        placeholder="Enter value"
        position="center"
        size={86.984375}
        summaryAggregationMode="sum"
      />
      <Column
        id="16177"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="related_items"
        label="매칭상품"
        placeholder="Enter value"
        position="center"
        referenceId="related_items"
        size={100}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="7520b"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="run"
          params={{
            ordered: [
              {
                src: 'const fileName = brcd2.value + "_" + seasonSelect2.value + "시즌_초도분배"\n\nconst originData = distPlan2.value\nconst result = []\noriginData.map(obj => {\n  const distPlan = obj?.distStrategy\n  if (distPlan) {\n    const distWithInfo = distPlan.map(item => {\n      item.large_cat = obj.large_cat\n      item.middle_cat = obj.middle_cat\n      item.small_cat = obj.small_cat\n      item.sty_cd = obj.sty_cd\n      item.col_cd = obj.col_cd\n      item.size_cd = obj.size_cd\n      return item\n    })\n  \nresult.push(...distWithInfo.filter(obj => obj.plan_qty > 0))\n  }\n})\nconsole.log(result.length)\nif (result.length > 0) {\n  utils.changeLocale("ko")\n  utils.exportData(result, fileName, "csv")  \n}',
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="selectRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="distDrawerFrame2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="distDrawerFrame2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="selectRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentRow }}" }] }}
        pluginId="selectedRow2"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentRow }}" }] }}
        pluginId="selectedRow2"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Spacer id="spacer10" />
    <Text
      id="text57"
      value="###### 4. 최종 검토 및 엑셀 다운"
      verticalAlign="center"
    />
    <Text
      id="text62"
      value={
        '표에서 직접 원하는 수치를 더블클릭하면 수정이 가능하며, 수정된 값은 "엑셀 출력하기" 버튼을 누르면 반영이 됩니다.'
      }
      verticalAlign="center"
    />
    <Button
      id="button7"
      margin="4px 4px"
      submitTargetId=""
      text="엑셀 출력하기"
    >
      <Event
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: 'const fileName = brcd2.value + "_" + seasonSelect2.value + "시즌_초도분배(ERP상신용)"\n\nconst originData = distPlan2.value\nlet result = []\noriginData.map(obj => {\n  const distPlan = obj?.distStrategy\n  if (distPlan) {\n    const distWithInfo = distPlan.map(item => {\n      const newObj = {}\n      newObj.shop_cd = String(item.shop_cd)      // 문자열로 변환\n      newObj.sty_cd = String(obj.sty_cd)         // 문자열로 변환\n      newObj.col_cd = String(obj.col_cd)         // 문자열로 변환\n      newObj.size_cd = String(obj.size_cd)       // 문자열로 변환\n      newObj.plan_qty = item?.plan_qty || 0\n      return newObj\n    })\n  \nresult.push(...distWithInfo.filter(obj => obj.plan_qty > 0))\n  }\n})\n\n// finalTbl2의 현재 표시된 데이터 가져오기 (필터링된 데이터)\nconst currentDisplayedData = finalTbl2.data || []\n\n// 현재 표시된 데이터의 키(shop_cd, sty_cd, col_cd 조합) 생성\nconst displayedKeys = new Set(\n  currentDisplayedData.map(row => \n    `${String(row.shop_cd)}-${String(row.sty_cd)}-${String(row.col_cd)}`\n  )\n)\n\nconst changes = finalTbl2.changesetArray\nif(changes) {\n  console.log("r: ", result[0])\n\n  // finalTbl2의 원본 데이터에서 모든 사이즈 정보 가져오기\n  const selectedData = shopPlan2.value\n  const allSizes = [...new Set(selectedData.map(item => item.size_cd).filter(Boolean))].sort()\n\n  // 현재 표시된 데이터에 해당하는 변경사항만 필터링\n  const filteredChanges = changes.filter(change => {\n    const shopCd = String(change["shop_cd"])\n    const styCd = String(change["sty_cd"])\n    const colCd = String(change["col_cd"])\n    const key = `${shopCd}-${styCd}-${colCd}`\n    return displayedKeys.has(key)\n  })\n\n  filteredChanges.map(change => {\n    console.log("ch: ", change)\n    const shopCd = String(change["shop_cd"])      // 문자열로 변환 \n    const styCd = String(change["sty_cd"])        // 문자열로 변환\n    const colCd = String(change["col_cd"])        // 문자열로 변환\n    const numericKeys = Object.keys(change).filter(key => typeof change[key] === \'number\')\n    console.log("numericKeys: ", numericKeys)\n    \n    // 해당 shop_cd, sty_cd, col_cd 조합의 원본 데이터에서 모든 사이즈 찾기\n    const originalRowData = selectedData.filter(\n      item => String(item.shop_cd) === shopCd && \n               String(item.sty_cd) === styCd && \n               String(item.col_cd) === colCd\n    )\n    \n    // 모든 사이즈에 대해 처리 (변경된 사이즈는 change에서, 변경되지 않은 사이즈는 원본에서)\n    allSizes.forEach(size => {\n      const sizeStr = String(size)\n      const isChanged = numericKeys.includes(sizeStr)\n      \n      if (isChanged) {\n        // 변경된 사이즈: change에서 값 가져오기\n        const newQty = change[sizeStr]\n        // result에 해당 항목이 있는지 확인하고 업데이트 또는 추가\n        const existingIndex = result.findIndex(\n          obj => obj.shop_cd === shopCd && \n                 obj.sty_cd === styCd && \n                 obj.col_cd === colCd && \n                 obj.size_cd === sizeStr\n        )\n        \n        if (existingIndex >= 0) {\n          // 기존 항목 업데이트\n          result[existingIndex].plan_qty = newQty\n        } else if (newQty > 0) {\n          // 새 항목 추가 (plan_qty > 0인 경우만)\n          result.push({\n            shop_cd: shopCd,\n            sty_cd: styCd,\n            col_cd: colCd,\n            size_cd: sizeStr,\n            plan_qty: newQty\n          })\n        }\n      } else {\n        // 변경되지 않은 사이즈: 원본 데이터에서 값 가져오기\n        const originalItem = originalRowData.find(item => String(item.size_cd) === sizeStr)\n        if (originalItem && originalItem.plan_qty > 0) {\n          // result에 해당 항목이 있는지 확인하고 없으면 추가\n          const existingIndex = result.findIndex(\n            obj => obj.shop_cd === shopCd && \n                   obj.sty_cd === styCd && \n                   obj.col_cd === colCd && \n                   obj.size_cd === sizeStr\n          )\n          \n          if (existingIndex < 0) {\n            // 원본에 있지만 result에 없는 경우 추가\n            result.push({\n              shop_cd: shopCd,\n              sty_cd: styCd,\n              col_cd: colCd,\n              size_cd: sizeStr,\n              plan_qty: originalItem.plan_qty\n            })\n          }\n        }\n      }\n    })\n  })\n}\n\n// plan_qty가 0인 항목 제거\nresult = result.filter(obj => obj.plan_qty > 0)\n\nconsole.log(result.length)\nif (result.length > 0) {\n  utils.changeLocale("ko")\n  utils.exportData(result, fileName, "xlsx")  \n}',
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Table
      id="finalTbl2"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data={
        '{{ (() => {\n    const selectedData = shopPlan2.value\n    const groupKeys = ["shop_cd", "shop_nm", "sty_cd", "col_cd", "sales_qty", "related_info"]\n    const allSizes = [...new Set(selectedData.map(item => item.size_cd).filter(Boolean))].sort() // 모든 사이즈 표시\n    const pivottedData = pivotData(selectedData, groupKeys, "size_cd", ["plan_qty"])\n    const normalizedData = pivottedData.map(row => {\n      const newRow = { ...row }\n      allSizes.forEach(size => {\n        if (!(size in newRow)) {\n          newRow[size] = 0\n        }\n      })\n      newRow.idx = `${newRow.shop_cd}${newRow.sty_cd}${newRow.col_cd}`\n      return newRow\n    })\n    return normalizedData.sort((a, b) => b?.sales_qty || 0 - a?.sales_qty || 0)\n    //  return pivottedData.sort((a, b) => b?.sales_qty || 0 - a?.sales_qty || 0)\n  })()\n  }}'
      }
      defaultFilterOperator="or"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[{ object: { columnId: "7afab", direction: "desc" } }]}
      dynamicColumnFormatOptions={{ decimal: { ordered: [] } }}
      dynamicColumnProperties={{
        formatByIndex: "decimal",
        labelByIndex: "{{ item }}",
        editableByIndex: "{{ item }}",
      }}
      dynamicColumnsEnabled={true}
      emptyMessage="No rows found"
      heightType="auto"
      includeRowInChangesetArray={true}
      margin="0"
      primaryKeyColumnId="2289c"
      rowHeight="xsmall"
      showBorder={true}
      showHeader={true}
      showSummaryRow={true}
    >
      <Include src="./finalTbl2ExpandedRow.rsx" />
      <Column
        id="83dbc"
        alignment="left"
        editable="false"
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="shop_cd"
        label="매장코드"
        placeholder="Enter value"
        position="left"
        size={57.671875}
        summaryAggregationMode="none"
      />
      <Column
        id="77e78"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="left"
        size={113.125}
        summaryAggregationMode="none"
      />
      <Column
        id="52305"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="sty_cd"
        label="스타일코드"
        placeholder="Enter value"
        position="center"
        size={77.703125}
        summaryAggregationMode="none"
      />
      <Column
        id="eac68"
        alignment="left"
        editable="false"
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="col_cd"
        label="칼라코드"
        placeholder="Enter value"
        position="center"
        size={57.484375}
        summaryAggregationMode="none"
      />
      <Column
        id="7afab"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="sales_qty"
        label="Sales qty"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="17720"
        alignment="left"
        editable="true"
        editableOptions={{ object: {} }}
        format="json"
        groupAggregationMode="none"
        hidden="true"
        key="related_info"
        label="Related info"
        placeholder="Enter value"
        position="center"
        size={318.40625}
        summaryAggregationMode="none"
      />
      <Column
        id="2289c"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="idx"
        label="Idx"
        placeholder="Enter value"
        position="center"
        referenceId="column7"
        size={66.6875}
        summaryAggregationMode="none"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3aab0"
        icon="bold/interface-arrows-round-left"
        label="Refresh"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="refresh"
          pluginId="finalTbl2"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="expandRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="selectedShop2"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</Screen>
