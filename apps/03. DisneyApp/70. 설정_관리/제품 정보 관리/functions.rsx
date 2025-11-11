<GlobalFunctions>
  <SqlQueryUnified
    id="query_get_info"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    query={include("./lib/query_get_info.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    resourceTypeOverride=""
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <State
    id="variable1"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
    value={
      '{{{\n"keywords":\n[\'기초복\', \'유아복\', \'토들러\', \'기획외의\', \'기획내의\', \'기초ACC\', \'정상ACC\', \'출산용품\', \'침구류\', \'기타\', \'목욕위생류\', \'발육류\', \'방수류\', \'완구류\', \'토들러ACC\'],\n"colors":\n["FECACA","FCD6BB","FDE68A","A7F3D0","BFDBFE","C7D2FE","EECFF3","EECFF3","EECFF3","EECFF3","EECFF3","EECFF3","EECFF3","EECFF3"]\n}}}'
    }
  />
  <SqlQueryUnified
    id="update_category"
    confirmationMessage="변경된 정보를 저장하시겠습니까?"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/update_category.sql", "string")}
    requireConfirmation={true}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    successMessage="변경되었습니다."
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
      pluginId="query_get_info"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <SqlQueryUnified
    id="query3"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    query={include("./lib/query3.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <JavascriptQuery
    id="download_file"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/download_file.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <JavascriptQuery
    id="upload_file"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/upload_file.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="setCurrentView"
      params={{ ordered: [{ viewKey: "step 3 " }] }}
      pluginId="steppedContainer1"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="check_item_info_temp"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </JavascriptQuery>
  <State
    id="item_info_temp_data"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
  />
  <JavascriptQuery
    id="check_item_info_temp"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/check_item_info_temp.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQueryUnified
    id="query_insert_item"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/query_insert_item.sql", "string")}
    queryThrottleTime="1000"
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <State
    id="insert_query"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
  />
  <JavascriptQuery
    id="update_item_info"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/update_item_info.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
    successMessage="업데이트가 완료되었습니다"
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQueryUnified
    id="update_changes_query"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/update_changes_query.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    resourceTypeOverride=""
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQueryUnified
    id="query_backup_item_info"
    confirmationMessage="정말로 적용하시겠습니까?"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/query_backup_item_info.sql", "string")}
    requireConfirmation={true}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    successMessage="백업을 완료하고 업데이트를 시작합니다."
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
      pluginId="update_item_info"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <JavascriptQuery
    id="update_changes"
    confirmationMessage="수정사항을 저장하시겠습니까?"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/update_changes.js", "string")}
    requireConfirmation={true}
    resourceName="JavascriptQuery"
    successMessage="업데이트가 완료되었습니다"
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
      pluginId="query_get_info"
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
  <State
    id="var_item_list"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
    value="['3PCS','7부내의','CDG','CT','JK','JP','OPS','PT','SW','TS','VT','겉싸보','구두','내의','니트모','담요','딸랑이','레깅스','면기저귀','모빌','모자','목도리','목욕가운','무릎보호대','바디수트','발육기구 부속물','방수요','방수패드','배내가운','배내바디수트','배내우주복','배내저고리','베개류','보행기화','봉제완구','부츠','사출 딸랑이류','상하','속싸보','손수건','손싸개','수면조끼','수유쿠션','슬림내의','슬림우주복','신생모','신생아양말','신생앙양말','실내조끼','요','요패드','우주복','운동화','유아토들러모','유아토들러양말','이불','인형','장갑','타올','타올싸보','턱받이','포대기','헤어ACC']"
  />
  <JavascriptQuery
    id="upload_production_file"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/upload_production_file.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="setCurrentView"
      params={{ ordered: [{ viewKey: "step 3 " }] }}
      pluginId="steppedContainer2"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="check_production_temp"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </JavascriptQuery>
  <State
    id="production_temp_data"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
  />
  <JavascriptQuery
    id="update_production"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/update_production.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
    successMessage="업데이트가 완료되었습니다"
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <JavascriptQuery
    id="check_production_temp"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/check_production_temp.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQueryUnified
    id="update_production_query"
    confirmationMessage=""
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/update_production_query.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    resourceTypeOverride=""
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    successMessage="성공적으로 적용되었습니다."
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
      pluginId="trigger_airflow_manual_dag"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <State
    id="var_update_production_query"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
  />
  <SqlQueryUnified
    id="get_item_id_category"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/get_item_id_category.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <State
    id="var_config"
    value="{
  br_cd: '79'
}"
  />
  <State id="var_brand_code" value="79" />
  <S3Query
    id="s3_upload_file"
    actionType="upload"
    bucketName="agabang-file"
    isMultiplayerEdited={false}
    resourceDisplayName="s3-agabang"
    resourceName="90497f58-753e-4796-a084-fefd4ba65928"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    uploadData="{{ fileDropzone3.value[0].base64Data }}"
    uploadFileName="uploaded_from_users/brand_code={{var_brand_code.value}}/{{ fileDropzone3.value[0].name }}"
    uploadFileType="{{ fileDropzone3.value[0].type }}"
    useRawUploadFileType={true}
  />
  <RESTQuery
    id="trigger_airflow_manual_dag"
    bodyType="json"
    query="z__manual_update_dw_dim_style/dagRuns"
    resourceDisplayName="AirflowDAGRun - Manual run"
    resourceName="8ef755f8-13c4-4d85-a5ea-5bab23c18e13"
    runWhenModelUpdates={false}
    type="POST"
  />
  <S3Query
    id="formDownload"
    actionType="download"
    bucketName="agabang-file"
    fileKey="excel-form-samples/디즈니_기획현황표_업로드양식_예시.xlsx"
    isMultiplayerEdited={false}
    resourceDisplayName="s3-agabang"
    resourceName="90497f58-753e-4796-a084-fefd4ba65928"
    runWhenModelUpdates={false}
  />
  <SqlQuery
    id="season_list"
    isImported={true}
    playgroundQueryName="season_list_with_ 0code"
    playgroundQueryUuid="f2f42278-caaf-4ea9-aeac-dcdc9a7076c5"
    query={include("./lib/season_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    retoolVersion="3.148.10"
    warningCodes={[]}
  />
  <SqlQuery
    id="get_latest_seasons"
    enableTransformer={true}
    importedQueryInputs={{
      ordered: [
        { variable0: "{{ var_brand_code.value }}" },
        { variable1: "2" },
      ],
    }}
    isImported={true}
    playgroundQueryName="get_latest_seasons"
    playgroundQueryUuid="c13b268b-11f4-4fa8-ac73-f0b48d384738"
    query={include("./lib/get_latest_seasons.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    retoolVersion="3.148.10"
    transformer="return formatDataAsArray(data).map(i=>i.year_season_cd)"
    warningCodes={[]}
  />
</GlobalFunctions>
