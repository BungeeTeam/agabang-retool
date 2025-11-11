<GlobalFunctions>
  <SqlQuery
    id="rise_top"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/rise_top.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <RESTQuery
    id="teams_send"
    bodyType="json"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    notificationDuration={4.5}
    query="/api/v1/dags/ettoi_rapid_rise_dag/dagRuns"
    resourceDisplayName="Airflow Dag Run"
    resourceName="af6b89ac-0b7d-4095-806f-95e3f2d7bf1a"
    runWhenModelUpdates={false}
    successMessage="메시지가 전송됩니다"
    transformer="// Query results are available as the `data` variable
return data"
    type="POST"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <Function
    id="var_rise_top"
    funcBody={include("./lib/var_rise_top.js", "string")}
  />
  <State id="var_sty_data" />
  <State id="var_brand_code" value="79" />
</GlobalFunctions>
