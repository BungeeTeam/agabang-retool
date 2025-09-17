<PlaygroundQuery
  id="season_list_without_0code"
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
    events={null}
    importedQueryDefaults={{}}
    importedQueryInputs={{}}
    isMultiplayerEdited={false}
    privateParams={[]}
    query={include("./lib/season_list_without_0code.sql", "string")}
    retoolVersion="3.148.10"
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    watchedParams={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
</PlaygroundQuery>
