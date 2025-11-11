<GlobalFunctions>
  <SqlQueryUnified
    id="delete_review_item"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/delete_review_item.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    transformer="// Query results are available as the `data` variable
return data"
    updateSetValueDynamically={true}
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_image_list"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <State
    id="sel_s3_key"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
    value=""
  />
  <JavascriptQuery
    id="s3_multi_upload"
    confirmationMessage="이 파일들을 업로드 하시겠습니까?"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/s3_multi_upload.js", "string")}
    queryDisabled="{{ upload_file_dropzone.value.length > 100 }}"
    queryDisabledMessage="한번에 100개까지만 가능합니다."
    requireConfirmation={true}
    resourceName="JavascriptQuery"
    successMessage="파일 업로드가 성공했습니다"
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <S3Query
    id="s3_upload_old"
    actionType="upload"
    bucketName="ettoi-image"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    resourceDisplayName="s3-ettoi"
    resourceName="ec4549d0-dbcf-4c34-b40b-cd4c4d45d67d"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    successMessage="{{ fileDropzone1.value[i].name }} 업로드 성공"
    transformer="// Query results are available as the `data` variable
return data"
    uploadData="{{upload_file_dropzone.value[i].base64Data }}"
    uploadFileName="item_review/{{sel_folder.value}}/{{upload_file_dropzone.value[i].name}}"
    uploadFileType="{{upload_file_dropzone.value[i].type}}"
    useRawUploadFileType={true}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="update_item_image_each"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </S3Query>
  <SqlQueryUnified
    id="update_item_image_each"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/update_item_image_each.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showUpdateSetValueDynamicallyToggle={false}
    successMessage="{{s3_upload.data.fileName}} 파일이 업로드 되었습니다"
    transformer="// Query results are available as the `data` variable
return data"
    updateSetValueDynamically={true}
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_image_list"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <SqlQueryUnified
    id="get_folder_list"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    query={include("./lib/get_folder_list.sql", "string")}
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
    id="get_image_list"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/get_image_list.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    transformer="// Query results are available as the `data` variable
return data"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQueryUnified
    id="update_item_image"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration="0.5"
    query={include("./lib/update_item_image.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showUpdateSetValueDynamicallyToggle={false}
    successMessage="{{s3_upload.data.fileName}} 파일이 업로드 되었습니다"
    transformer="// Query results are available as the `data` variable
return data"
    updateSetValueDynamically={true}
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="get_folder_list"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <S3Query
    id="delete_image"
    actionType="delete"
    bucketName="agabang-image"
    fileKey="{{sel_s3_key.value}}"
    resourceDisplayName="s3-agabang"
    resourceName="90497f58-753e-4796-a084-fefd4ba65928"
    runWhenModelUpdates={false}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="delete_review_item"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </S3Query>
  <S3Query
    id="s3_upload"
    actionType="upload"
    bucketName="agabang-image"
    resourceDisplayName="s3-agabang"
    resourceName="90497f58-753e-4796-a084-fefd4ba65928"
    runWhenModelUpdates={false}
    uploadData="{{upload_file_dropzone.value[i].base64Data }}"
    uploadFileName="item_review/{{sel_folder.value}}/{{upload_file_dropzone.value[i].name}}"
    uploadFileType="{{upload_file_dropzone.value[i].type}}"
    useRawUploadFileType={true}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="update_item_image_each"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </S3Query>
  <State id="var_brand_code" value="'07'" />
  <SqlQuery
    id="get_matched_preview_cd_and_item"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/get_matched_preview_cd_and_item.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    showSuccessToaster={false}
    transformer="// 품평번호를 키로 하는 객체 생성
const mapping = {};

for (let i = 0; i < data.preview_cd.length; i++) {
  const preview_cd = data.preview_cd[i];
  const sty_nm = data.sty_nm[i] || '';
  const sty_cd = data.sty_cd[i] || '';
  const col_nm = data.col_nm[i] || '';
  const color_qty = data.color_qty[i] || 0;
  
  // 각 품평번호에 대한 표시 텍스트 생성
  mapping[preview_cd] = {
    sty_nm: sty_nm,
    sty_cd: sty_cd,
    col_nm: col_nm,
    color_qty: color_qty,
    // 미리 포맷팅된 텍스트
    display_text: `${sty_nm} ${col_nm} (${sty_cd})`
  };
}

// 원본 데이터와 매핑 객체 모두 반환
return {
  ...data,  // 원본 데이터 유지
  mapping: mapping  // 품평번호별 매핑 추가
};"
    warningCodes={[]}
  />
  <RESTQuery
    id="trigger_airflow_manual_dag"
    bodyType="json"
    query="z__manual_update_review_image_ettoi/dagRuns?"
    resourceDisplayName="AirflowDAGRun - Manual run"
    resourceName="8ef755f8-13c4-4d85-a5ea-5bab23c18e13"
    runWhenModelUpdates={false}
    type="POST"
  />
</GlobalFunctions>
