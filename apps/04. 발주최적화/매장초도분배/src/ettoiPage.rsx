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
        '[{"key":"is_checked","value":"{{ !shopTbl2.selectedRow.is_checked }}"}]'
      }
      changesetObject="{{ styTbl2.changesetArray[0] }}"
      doNotThrowOnNoOp={true}
      editorMode="gui"
      filterBy={
        '[{"key":"shop_cd","value":"{{ shopTbl2.selectedRow.shop_cd }}","operation":"="}]'
      }
      isMultiplayerEdited={false}
      query={include("../lib/updateRetoolDB2.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      tableName="dim_shop"
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
      bulkUpdatePrimaryKey="shop_cd"
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
      tableName="dim_shop"
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
    />
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
      query={include("../lib/getSelectedGroupShop2.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      warningCodes={[]}
    />
  </Folder>
  <Folder id="loadData">
    <State id="brcd2" value={'"07"'} />
    <State id="bizcd2" value="{}" />
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
    <State id="selectedRow2" value="{}" />
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
        pluginId="bizcd2"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="selectRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="bizcd2"
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
              src: 'const fileName = brcd2.value + "_" + seasonSelect2.value + "시즌_초도분배(ERP상신용)"\n\nconst originData = distPlan2.value\nlet result = []\noriginData.map(obj => {\n  const distPlan = obj?.distStrategy\n  if (distPlan) {\n    const distWithInfo = distPlan.map(item => {\n      const newObj = {}\n      newObj.shop_cd = item.shop_cd\n      newObj.sty_cd = obj.sty_cd\n      newObj.col_cd = obj.col_cd\n      newObj.size_cd = obj.size_cd\n      newObj.plan_qty = item?.plan_qty || 0\n      return newObj\n    })\n  \nresult.push(...distWithInfo.filter(obj => obj.plan_qty > 0))\n  }\n})\n\nconst changes = finalTbl2.changesetArray\nif(changes) {\n  console.log("r: ", result[0])\n\n  changes.map(change => {\n    console.log("ch: ", change)\n    const shopCd = change["shop_cd"]\n    const styCd = change["sty_cd"]\n    const colCd = change["col_cd"]\n    const numericKeys = Object.keys(change).filter(key => typeof change[key] === \'number\')\n    console.log("numericKeys: ", numericKeys)\n    numericKeys.forEach(size => {\n      result = result.map(obj => {\n        if (obj.shop_cd === shopCd && obj.sty_cd === styCd && obj.col_cd === colCd && obj.size_cd === size) {\n          obj["plan_qty"] = change[size]\n        }\n        return obj\n      })\n    })\n  })\n}\n\nconsole.log(result.length)\nif (result.length > 0) {\n  utils.changeLocale("ko")\n  utils.exportData(result, fileName, "xlsx")  \n}',
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
        '{{ (() => {\n  const selectedData = shopPlan2.value\n  const groupKeys = ["shop_cd", "shop_nm", "sty_cd", "col_cd", "sales_qty", "related_info"]\n  const pivottedData = pivotData(selectedData, groupKeys, "size_cd", ["plan_qty"])\n  return pivottedData.sort((a, b) => b?.sales_qty || 0 - a?.sales_qty || 0)\n})()\n}}'
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
        size={57.90625}
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
        size={133.09375}
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
        size={73.671875}
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
        size={57.46875}
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
        pluginId="bizcd2"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</Screen>
