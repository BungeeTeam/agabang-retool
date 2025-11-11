<GlobalFunctions>
  <Folder id="archive">
    <State id="varGroupName" />
    <SqlQueryUnified
      id="getGroupList"
      enableTransformer={true}
      query={include("./lib/getGroupList.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="insertGroup"
      actionType="INSERT"
      changeset={
        '[{"key":"shop_cd","value":"{{ flexShopTbl.newRows?.shop_cd }}"},{"key":"shop_nm","value":"{{ flexShopTbl.newRows?.shop_nm }}"},{"key":"remark","value":"{{ flexShopTbl.newRows?.remark }}"}]'
      }
      changesetIsObject={true}
      changesetObject="{{ varGroupName.value }}"
      editorMode="gui"
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="channel_groups"
      updateSetValueDynamically={true}
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getGroupList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="success"
        method="hide"
        params={{ ordered: [] }}
        pluginId="modalFrameAddGroup_archive"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="success"
        method="clearValue"
        params={{ ordered: [] }}
        pluginId="group_nm"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="deleteGroup"
      confirmationMessage="채널 그룹을 정말 삭제하시겠습니까?"
      isMultiplayerEdited={false}
      query={include("./lib/deleteGroup.sql", "string")}
      requireConfirmation={true}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      successMessage="그룹이 삭제되었습니다"
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getGroupList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
  </Folder>
  <Folder id="excludedShop">
    <SqlQueryUnified
      id="getExcludedShopList"
      query={include("./lib/getExcludedShopList.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      resourceTypeOverride=""
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="updateExcludedShopInfo"
      actionType="UPDATE_BY"
      changeset={'[{"key":"id","value":""}]'}
      changesetIsObject={true}
      changesetObject="{{ excludedShopTbl.changesetArray[0] }}"
      doNotThrowOnNoOp={true}
      editorMode="gui"
      enableTransformer={true}
      filterBy={
        '[{"key":"id","value":"{{ excludedShopTbl.changesetArray[0]?.id || \\"\\"}}","operation":"="}]'
      }
      isMultiplayerEdited={false}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      tableName="excluded_shop"
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getExcludedShopList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="insertExcludedShopInfo"
      actionType="INSERT"
      changesetIsObject={true}
      changesetObject="{{ varInsertExcludedShopInfo.value }}"
      confirmationMessage="저장하시겠습니까?"
      editorMode="gui"
      enableTransformer={true}
      notificationDuration={4.5}
      query={include("./lib/insertExcludedShopInfo.sql", "string")}
      requireConfirmation={true}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="excluded_shop"
      updateSetValueDynamically={true}
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getExcludedShopList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="deletShopHandoverInfo"
      confirmationMessage="삭제하시겠습니까?"
      query={include("./lib/deletShopHandoverInfo.sql", "string")}
      requireConfirmation={true}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      warningCodes={[]}
    >
      <Event
        event="success"
        method="showNotification"
        params={{
          ordered: [
            {
              options: {
                ordered: [
                  { notificationType: "info" },
                  { duration: "4.5" },
                  { title: "삭제되었습니다" },
                ],
              },
            },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getShopHandoverList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <State id="varInsertExcludedShopInfo" />
  </Folder>
  <Folder id="shopHandover">
    <SqlQueryUnified
      id="getShopHandoverList"
      query={include("./lib/getShopHandoverList.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      resourceTypeOverride=""
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="updateShopHandoverInfo"
      actionType="UPDATE_BY"
      changeset={'[{"key":"id","value":""}]'}
      changesetIsObject={true}
      changesetObject="{{ shopHandoverTbl.changesetArray[0] }}"
      doNotThrowOnNoOp={true}
      editorMode="gui"
      enableTransformer={true}
      filterBy={
        '[{"key":"id","value":"{{ shopHandoverTbl.changesetArray[0]?.id || \\"\\"}}","operation":"="}]'
      }
      isMultiplayerEdited={false}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      resourceTypeOverride=""
      runWhenModelUpdates={false}
      tableName="shop_handover"
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getShopHandoverList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="insertShopHandoverInfo"
      actionType="INSERT"
      changesetIsObject={true}
      changesetObject="{{ varInsertShopHandoverInfo.value }}"
      confirmationMessage="저장하시겠습니까"
      editorMode="gui"
      enableTransformer={true}
      notificationDuration={4.5}
      query={include("./lib/insertShopHandoverInfo.sql", "string")}
      queryFailureConditions={
        '[{"condition":"{{ data.message === \\"Insert into shop_handover failed: you must satisfy the constraint \'Shop handover prev shop cd key\'\\"\\n }}","message":"이전 매장 정보가 중복된 것으로 보입니다. 기존 내용을 업데이트해 주시면 감사하겠습니다."}]'
      }
      requireConfirmation={true}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="shop_handover"
      updateSetValueDynamically={true}
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getShopHandoverList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <State id="varInsertShopHandoverInfo" />
    <SqlQueryUnified
      id="deleteExcluedShopInfo"
      confirmationMessage="삭제하시겠습니까?"
      notificationDuration={4.5}
      query={include("./lib/deleteExcluedShopInfo.sql", "string")}
      requireConfirmation={true}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      updateSetValueDynamically={true}
      warningCodes={[]}
    />
    <State id="varTutorial" />
  </Folder>
  <Folder id="flexShop">
    <SqlQueryUnified
      id="getFlexShopList"
      query={include("./lib/getFlexShopList.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="updateFlexShopInfo"
      actionType="UPDATE_BY"
      changesetIsObject={true}
      changesetObject="{{ flexShopTbl.changesetArray[0] }}"
      doNotThrowOnNoOp={true}
      editorMode="gui"
      filterBy={
        '[{"key":"id","value":"{{ flexShopTbl.changesetArray[0]?.id || \\"\\"}}","operation":"="}]'
      }
      notificationDuration={4.5}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="flex_shop"
      updateSetValueDynamically={true}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getFlexShopList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <SqlQueryUnified
      id="insertFlexShopInfo"
      actionType="INSERT"
      changeset={
        '[{"key":"shop_cd","value":"{{ flexShopTbl.newRows?.shop_cd }}"},{"key":"shop_nm","value":"{{ flexShopTbl.newRows?.shop_nm }}"},{"key":"remark","value":"{{ flexShopTbl.newRows?.remark }}"}]'
      }
      changesetIsObject={true}
      changesetObject="{{ varInsertFlexShopInfo.value }}"
      editorMode="gui"
      enableTransformer={true}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="flex_shop"
      updateSetValueDynamically={true}
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getFlexShopList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <State id="varSelectedFlexShopInfo" />
    <State id="varInsertFlexShopInfo" />
    <SqlQueryUnified
      id="deleteFlexShopInfo"
      confirmationMessage="삭제하시겠습니까?"
      query={include("./lib/deleteFlexShopInfo.sql", "string")}
      requireConfirmation={true}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      warningCodes={[]}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getFlexShopList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
  </Folder>
  <Folder id="channelGroupMapping">
    <SqlQuery
      id="channelListQuery"
      enableTransformer={true}
      isMultiplayerEdited={false}
      notificationDuration={4.5}
      query={include("./lib/channelListQuery.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      showSuccessToaster={false}
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    />
    <SqlQueryUnified
      id="getChannelMappingList"
      enableTransformer={true}
      isMultiplayerEdited={false}
      query={include("./lib/getChannelMappingList.sql", "string")}
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
    />
    <Function
      id="transformer1"
      funcBody={include("./lib/transformer1.js", "string")}
    />
    <SqlQueryUnified
      id="upsertChannelGroupInfo"
      actionType="BULK_UPSERT_BY_KEY"
      bulkUpdatePrimaryKey="id"
      changesetIsObject={true}
      changesetObject="{{ table3.changesetArray[0] }}"
      doNotThrowOnNoOp={true}
      editorMode="gui"
      filterBy={
        '[{"key":"id","value":"{{ table3.changesetArray[0]?.id || \\"\\"}}","operation":"="}]'
      }
      notificationDuration={4.5}
      records="{{ updatedRows.value }}"
      resourceDisplayName="retool_db"
      resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
      runWhenModelUpdates={false}
      showSuccessToaster={false}
      showUpdateSetValueDynamicallyToggle={false}
      tableName="channel_group_mapping"
      updateSetValueDynamically={true}
    >
      <Event
        event="success"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getChannelMappingList"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </SqlQueryUnified>
    <Function
      id="updatedRows"
      funcBody={include("./lib/updatedRows.js", "string")}
    />
  </Folder>
  <SqlQuery
    id="getAllShopList"
    query={include("./lib/getAllShopList.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    warningCodes={[]}
  />
  <JavascriptQuery
    id="setDefaulthidden"
    notificationDuration={4.5}
    query={include("./lib/setDefaulthidden.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
</GlobalFunctions>
