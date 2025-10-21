<GlobalFunctions>
  <SqlQueryUnified
    id="get_season_month"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/get_season_month.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    resourceTypeOverride=""
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQueryUnified
    id="update_season_month"
    confirmationMessage="저장하시겠습니까?"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/update_season_month.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_season_month"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <JavascriptQuery
    id="update_chages"
    confirmationMessage="저장하시겠습니까?"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/update_chages.js", "string")}
    requireConfirmation={true}
    resourceName="JavascriptQuery"
    successMessage="저장되었습니다"
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_season_month"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </JavascriptQuery>
  <State
    id="update_query"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
  />
</GlobalFunctions>
