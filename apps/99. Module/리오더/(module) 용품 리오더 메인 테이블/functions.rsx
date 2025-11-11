<GlobalFunctions>
  <Folder id="main_table">
    <SqlQuery
      id="get_item_list"
      enableTransformer={true}
      isMultiplayerEdited={false}
      notificationDuration="3"
      query={include("./lib/get_item_list.sql", "string")}
      queryTimeout="50000"
      queryTriggerDelay=""
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      runWhenModelUpdates={false}
      runWhenPageLoads={true}
      runWhenPageLoadsDelay="1000"
      showSuccessToaster={false}
      successMessage="리오더 점검 대상 조회가 완료되었습니다."
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="filterOutDiscontinuedItemsAndReorderHistoryItems"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQuery>
    <JavascriptQuery
      id="filterOutDiscontinuedItemsAndReorderHistoryItems"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include(
        "./lib/filterOutDiscontinuedItemsAndReorderHistoryItems.js",
        "string"
      )}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getColorList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </JavascriptQuery>
    <SqlQuery
      id="get_series_names"
      enableTransformer={true}
      isMultiplayerEdited={false}
      query={include("./lib/get_series_names.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="filterOutDiscontinuedItemsAndReorderHistoryItems"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQuery>
    <SqlQueryUnified
      id="get_discontinued_products"
      enableTransformer={true}
      isMultiplayerEdited={false}
      playgroundQueryName="Country Search"
      playgroundQueryUuid="45e0661d-db94-43c5-85a6-796c1a8218d6"
      query={include("./lib/get_discontinued_products.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="filterOutDiscontinuedItemsAndReorderHistoryItems"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="get_reorder_moq_leadtime_info"
      enableTransformer={true}
      query={include("./lib/get_reorder_moq_leadtime_info.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    />
    <JavascriptQuery
      id="getColorList"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/getColorList.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getNotificationItems"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </JavascriptQuery>
    <SqlQuery
      id="get_manufacturer_stock"
      enableTransformer={true}
      isMultiplayerEdited={false}
      query={include("./lib/get_manufacturer_stock.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    />
    <State id="clicked_item_sty_cd" />
  </Folder>
  <Folder id="bulk_reorder">
    <SqlQueryUnified
      id="insertReorderSimulationTargets"
      actionType="INSERT"
      changeset={
        '[{"key":"timestamp","value":"{{ new Date() }}"},{"key":"content","value":"{{ selectedReorderItems.value }}"},{"key":"user_name","value":"{{ current_user.email }}"},{"key":"br_cd","value":"{{ var_brand_code.value }}"}]'
      }
      editorMode="gui"
      filterBy={
        '[{"key":"content","value":"{{ selectedReorderItems.value }}","operation":"="}]'
      }
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showUpdateSetValueDynamicallyToggle={false}
      successMessage="리오더 시뮬레이션으로 이동합니다."
      tableName="reorder_supplies_simulation_targets"
      updateSetValueDynamically={true}
    />
    <JavascriptQuery
      id="getSelectedItems"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/getSelectedItems.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    >
      <Event
        event="success"
        method="setValue"
        params={{ ordered: [{ value: "{{ getSelectedItems.data }}" }] }}
        pluginId="selectedReorderItems"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </JavascriptQuery>
    <State id="selectedReorderItems" value="[]" />
  </Folder>
  <Folder id="discontinued_items">
    <JavascriptQuery
      id="bulkDiscontinueItems"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/bulkDiscontinueItems.js", "string")}
      resourceName="JavascriptQuery"
      showSuccessToaster={false}
    />
    <SqlQueryUnified
      id="discontinuedProductsQuery"
      actionType="BULK_INSERT"
      changeset={'[{"key":"is_discontinued","value":"true"}]'}
      changesetIsObject={true}
      changesetObject="{{
  {
    is_discontinued: true ,
    discontinued_date: new Date().toISOString(),
    discontinued_by: current_user ? current_user.email : 'system'
  }
}}"
      editorMode="gui"
      filterBy={
        '[{"key":"sty_cd","value":"{{ table_main_list.selectedSourceRows[i].sty_cd }}","operation":"="},{"key":"col_cd","value":"{{ table_main_list.selectedSourceRows[i].col_cd }}","operation":"="}]'
      }
      isMultiplayerEdited={false}
      query={include("./lib/discontinuedProductsQuery.sql", "string")}
      records={
        "{{ selectedReorderItems.value.map(item => ({\n  sty_cd: item.sty_cd,\n  sty_nm: item.sty_nm,\n  col_cd: item.col_cd,\n  col_nm: item.col_nm,\n  is_discontinued: \"TRUE\",\n  discontinued_date: new Date().toLocaleDateString('en-CA', { timeZone: 'Asia/Seoul' }),\n  discontinued_by: current_user.email\n}))\n}}"
      }
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      tableName="discontinued_products"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_discontinued_products"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="success"
        method="clearSelection"
        params={{ ordered: [] }}
        pluginId="table_main_list"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="remove_from_discontinued_items_list"
      actionType="UPDATE_BY"
      changeset={'[{"key":"is_discontinued","value":"false"}]'}
      editorMode="gui"
      filterBy={
        '[{"key":"sty_cd","value":"{{ table_discontinued_items.selectedSourceRow.sty_cd }}","operation":"="},{"key":"col_cd","value":"{{ table_discontinued_items.selectedSourceRow.col_cd }}","operation":"="}]'
      }
      notificationDuration={4.5}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="discontinued_products"
      updateSetValueDynamically={true}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_discontinued_products"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="filterOutDiscontinuedItemsAndReorderHistoryItems"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
  </Folder>
  <Folder id="filters">
    <JavascriptQuery
      id="get_brand_list"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/get_brand_list.js", "string")}
      resourceName="JavascriptQuery"
      runWhenPageLoads={true}
      showSuccessToaster={false}
    >
      <Event
        event="success"
        method="setValue"
        params={{ ordered: [{ value: "{{ get_brand_list.data.brandList }}" }] }}
        pluginId="var_brand_list"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </JavascriptQuery>
    <State
      id="var_brand_list"
      value={
        '[\n      { br_nm: "전체", value: "all" },\n      { br_nm: "아가방", value: "agabang" },\n      { br_nm: "기타", value: "etc" },\n]'
      }
    />
    <SqlQuery
      id="get_items_by_brand"
      enableTransformer={true}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/get_items_by_brand.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      showSuccessToaster={false}
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
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
        pluginId="format_small_cat_options"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQuery>
    <Function
      id="CategorizedSalesTransformer"
      funcBody={include("./lib/CategorizedSalesTransformer.js", "string")}
    />
    <SqlQuery
      id="season_list"
      isMultiplayerEdited={false}
      query={include("./lib/season_list.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      warningCodes={[]}
    />
    <Function
      id="getTargetEndDate"
      funcBody={include("./lib/getTargetEndDate.js", "string")}
    />
    <Function
      id="getSeasonList"
      funcBody={include("./lib/getSeasonList.js", "string")}
    />
  </Folder>
  <Folder id="TeamsAlert">
    <SqlQuery
      id="prodctionList"
      isMultiplayerEdited={false}
      query={include("./lib/prodctionList.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      warningCodes={[]}
    />
    <WorkflowRun
      id="sendTeamsAlert"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      queryFailureConditions={'[{"condition":"","message":""}]'}
      resourceName="WorkflowRun"
      successMessage="Teams 알림이 전송되었습니다!"
      workflowId="d1b1b488-dbc9-41be-8418-c27f227ae06a"
      workflowParams={include("./lib/sendTeamsAlert.json", "string")}
    />
    <JavascriptQuery
      id="getNotificationItems"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/getNotificationItems.js", "string")}
      resourceName="JavascriptQuery"
      runWhenPageLoadsDelay="30000"
      showSuccessToaster={false}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="insertNotificationItemsToDB"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </JavascriptQuery>
    <SqlQueryUnified
      id="insertNotificationItemsToDB"
      actionType="UPDATE_OR_INSERT_BY"
      changeset={
        '[{"key":"created_at","value":"{{ Date() }}"},{"key":"items","value":"{{ getNotificationItems.data }}"},{"key":"brand_code","value":"{{ var_brand_code.value }}"},{"key":"type","value":"season"}]'
      }
      editorMode="gui"
      filterBy={
        '[{"key":"brand_code","value":"{{ var_brand_code.value }}","operation":"="},{"key":"type","value":"season","operation":"="}]'
      }
      notificationDuration={4.5}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="reorder_notification_items"
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <Function
      id="prepareApiPayload"
      funcBody={include("./lib/prepareApiPayload.js", "string")}
    />
    <RESTQuery
      id="test_TeamsTriggerForManuTeam"
      body="{{ prepareApiPayload.value }}"
      bodyType="raw"
      cookies={'[{"key":"","value":""}]'}
      headers={'[{"key":"Content-Type","value":"application/json"}]'}
      isMultiplayerEdited={false}
      resourceDisplayName="테스트 생산팀 팀즈봇 트리거 - 용품"
      resourceName="35e563ac-115c-45a9-b28b-602459e54b58"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      successMessage={
        "Teams \"클리브 프로젝트 - 번지 테스트 채널\"에 메시지를 발송했습니다. ({{ prepareApiPayload.value.items.length > 0 ? (prepareApiPayload.value.items.length === 1 ? prepareApiPayload.value.items[0].style_name : `${prepareApiPayload.value.items[0].style_name} 외 ${prepareApiPayload.value.items.length - 1}개`) : '' }})"
      }
      type="POST"
    />
    <RESTQuery
      id="agabang_TeamsTriggerForManuTeam"
      body="{{ prepareApiPayload.value }}"
      bodyType="raw"
      cookies={'[{"key":"","value":""}]'}
      headers={'[{"key":"Content-Type","value":"application/json"}]'}
      isMultiplayerEdited={false}
      resourceDisplayName="아가방 생산팀 팀즈봇 트리거"
      resourceName="be9df6eb-e9b7-4bb9-b099-6316b2cc1a97"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      successMessage={
        "Teams \"클리브 프로젝트 - 아가방 생산\" 채널에 메시지를 발송했습니다. ({{ prepareApiPayload.value.items.length > 0 ? (prepareApiPayload.value.items.length === 1 ? prepareApiPayload.value.items[0].style_name : `${prepareApiPayload.value.items[0].style_name} 외 ${prepareApiPayload.value.items.length - 1}개`) : '' }})"
      }
      type="POST"
    />
    <RESTQuery
      id="ettoi_TeamsTriggerForManuTeam"
      body="{{ prepareApiPayload.value }}"
      bodyType="raw"
      cookies={'[{"key":"","value":""}]'}
      headers={'[{"key":"Content-Type","value":"application/json"}]'}
      isMultiplayerEdited={false}
      notificationDuration="5"
      queryFailureConditions={
        '[{"condition":"","message":"생산팀 확인 요청 Teams 메시지 발송에 실패했습니다."}]'
      }
      resourceDisplayName="에뜨와 생산팀 팀즈봇 트리거"
      resourceName="66b04c9e-9728-45d5-bf35-b72c3eb5ea26"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      successMessage={
        "Teams \"클리브 프로젝트 - 에뜨와 생산\" 채널에 메시지를 발송했습니다. ({{ prepareApiPayload.value.items.length > 0 ? (prepareApiPayload.value.items.length === 1 ? prepareApiPayload.value.items[0].style_name : `${prepareApiPayload.value.items[0].style_name} 외 ${prepareApiPayload.value.items.length - 1}개`) : '' }})"
      }
      type="POST"
    />
    <Function
      id="prepareApiPayloadForTest"
      funcBody={include("./lib/prepareApiPayloadForTest.js", "string")}
    />
    <WorkflowRun
      id="sendTeamsAlertForTest"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      queryFailureConditions={'[{"condition":"","message":""}]'}
      resourceName="WorkflowRun"
      successMessage="Teams 알림이 정상적으로 전송되었습니다!"
      workflowId="d1b1b488-dbc9-41be-8418-c27f227ae06a"
      workflowParams={include("./lib/sendTeamsAlertForTest.json", "string")}
    />
  </Folder>
  <Folder id="reorder_history">
    <SqlQueryUnified
      id="get_reorder_history"
      enableTransformer={true}
      query={include("./lib/get_reorder_history.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="filterOutDiscontinuedItemsAndReorderHistoryItems"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="remove_from_reorder_history_table"
      actionType="UPDATE_BY"
      changeset={'[{"key":"exclude_at_reorder_target_list","value":"false"}]'}
      editorMode="gui"
      enableBulkUpdates={true}
      filterBy={
        '[{"key":"group_id","value":"{{ table_reorder_history.selectedSourceRow.group_id }}","operation":"="}]'
      }
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="reorder_md_decision"
      updateSetValueDynamically={true}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_reorder_history"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
  </Folder>
</GlobalFunctions>
