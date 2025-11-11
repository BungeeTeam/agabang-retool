<PlaygroundQuery
  id="shared_season_list"
  adhocResourceType={null}
  data={null}
  resourceType="jdbc"
>
  <SqlQuery
    _additionalScope={[]}
    allowedGroupIds={[]}
    allowedGroups={[]}
    dataArray={[]}
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    events={[
      {
        type: "datasource",
        event: "success",
        method: "trigger",
        params: {},
        waitMs: "0",
        pluginId: "season_item_list",
        targetId: null,
        waitType: "debounce",
      },
    ]}
    importedQueryDefaults={{ variable0: "01" }}
    importedQueryInputs={{ variable0: "01" }}
    privateParams={[]}
    query={include("./lib/shared_season_list.sql", "string")}
    resourceTypeOverride=""
    retoolVersion="3.114.3"
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    watchedParams={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
</PlaygroundQuery>
