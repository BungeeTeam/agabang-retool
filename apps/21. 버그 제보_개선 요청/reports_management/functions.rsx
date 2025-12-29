<GlobalFunctions>
  <SqlQueryUnified
    id="getReportsQuery"
    enableTransformer={true}
    query={include("./lib/getReportsQuery.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="showModal"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <State id="varSelectedRow" />
  <State
    id="statusList"
    value="[
'접수 대기',
'담당자 지정',
'처리 진행 중',
'보류',
'해결 완료',
'처리 완료'
]"
  />
  <State id="varChangedArray" />
  <SMTPQuery
    id="mail"
    body="###### 안녕하세요, {{ varSelectedRow.value?.submitter_name }} 님 접수하신 문의에 새로운 답변이 등록되어 알려드립니다.

**📝 문의 제목:** {{ varSelectedRow.value?.report_title }}

**💬 새 답변 내용:**

{{ textOnly.value }}

---

추가 궁금한 점이 있으시거나 답변에 대한 피드백이 있으시면 언제든 답글을 남겨주세요.

**👉 [답변 확인 및 추가 문의하기](https://agabang.cleave.work/app/reports_management/all_reports#id={{ varSelectedRow.value?.id }})**

감사합니다.

임채원 매니저 드림"
    bodyType="markdown"
    isMultiplayerEdited={false}
    replyToEmail="team@cleave.work"
    resourceDisplayName="transaction email"
    resourceName="af865bfe-2089-4d9c-ba4a-991ec515bd4b"
    resourceTypeOverride=""
    showReplyTo={true}
    subject="[Cleave] 문의에 새 답변이 등록되었습니다"
    successMessage="메일 발송 완료"
    toEmail="{{ varSelectedRow.value?.submitter_email }}"
  >
    <Event
      event="success"
      method="setValue"
      params={{ ordered: [{ value: "''" }] }}
      pluginId="richTextEditor2"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
  </SMTPQuery>
  <JavascriptQuery
    id="getImages"
    notificationDuration={4.5}
    query={include("./lib/getImages.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <SqlQueryUnified
    id="updateReplies"
    actionType="INSERT"
    changeset={
      '[{"key":"contents","value":"{{ textArea2.value }}"},{"key":"user_reports_id","value":"{{varSelectedRow.value?.id }}"},{"key":"sumitter_name","value":"{{current_user.fullName }}"},{"key":"sumitter_email","value":"{{current_user.email }}"},{"key":"file_attachments","value":"{{ fileButton1.value }}"}]'
    }
    changesetObject="{{ richTextEditor1.value }}"
    editorMode="gui"
    isMultiplayerEdited={false}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    tableName="replies"
    warningCodes={[]}
  />
  <SqlQueryUnified
    id="updateQuery2"
    actionType="UPDATE_BY"
    bulkUpdatePrimaryKey="id"
    changeset={
      '[{"key":"admin_category","value":"{{ keyValue2.changeset[\'관리자 카테고리\'] || \'\' }}"}]'
    }
    changesetObject="{{ keyValue2.changeset }}"
    editorMode="gui"
    filterBy={
      '[{"key":"id","value":"{{ varSelectedRow.value.id || \\"\\"}}","operation":"="}]'
    }
    notificationDuration={4.5}
    records="{{(() => {
 const currentDateTime = new Date();

const changedArr = table3.changesetArray;

const result = changedArr.map(item => {
  if (item.status === '처리 완료' || item.status === '해결 완료') {
    return {
      ...item,
      resolved_at: currentDateTime,
      last_updated_at: currentDateTime
    };
  }

  return {
    ...item,
    last_updated_at: currentDateTime
  };
});

return result;

})()}}"
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    tableName="user_reports"
    updateSetValueDynamically={true}
  />
  <SqlQueryUnified
    id="getReplies"
    enableTransformer={true}
    isMultiplayerEdited={false}
    query={include("./lib/getReplies.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
  />
  <SqlQueryUnified
    id="updateRepliesAdmin"
    actionType="INSERT"
    changeset={
      '[{"key":"contents","value":"{{ richTextEditor2.value }}"},{"key":"user_reports_id","value":"{{ varSelectedRow.value?.id }}"},{"key":"sumitter_name","value":"{{current_user.fullName }}"},{"key":"sumitter_email","value":"{{current_user.email }}"}]'
    }
    changesetObject="{{ richTextEditor1.value }}"
    editorMode="gui"
    isMultiplayerEdited={false}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    tableName="replies"
  />
  <JavascriptQuery
    id="showModal"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/showModal.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <Function id="textOnly" funcBody={include("./lib/textOnly.js", "string")} />
  <State id="varSelected" />
  <OpenAPIQuery
    id="updateTs"
    isMultiplayerEdited={false}
    method="post"
    notificationDuration={4.5}
    operationId="chat_postMessage"
    parameterDynamicStates={
      '{"attachments":false,"blocks":false,"channel":false,"icon_emoji":false,"icon_url":false,"link_names":false,"mrkdwn":false,"parse":false,"reply_broadcast":false,"text":false,"thread_ts":false,"unfurl_links":false,"unfurl_media":false,"username":false}'
    }
    parameterMetadata={'{"channel":{"label":"ai-아가방-retool-noti"}}'}
    parameters={
      '{"channel":"C096YNEVCAK","thread_ts":"{{ varSelectedRow.value.slack_message_ts}}","blocks":"[\\n  {\\n    \\"type\\": \\"section\\",\\n    \\"text\\": {\\n      \\"type\\": \\"mrkdwn\\",\\n      \\"text\\": \\" *{{current_user.fullName ?? \'\'}}님 댓글*\\\\n{{updateReplies.data?.result[0].contents ?? \'\'}}\\"\\n    }\\n  }\\n]"}'
    }
    path="/chat.postMessage"
    requestBodyMetadata=""
    resourceDisplayName="bug report"
    resourceName="d85c5a28-e8f9-4ebe-bade-8ec0a807b734"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="formatFiles"
    notificationDuration={4.5}
    query={include("./lib/formatFiles.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="downloadFiles"
    notificationDuration={4.5}
    query={include("./lib/downloadFiles.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="formatFiles2"
    notificationDuration={4.5}
    query={include("./lib/formatFiles2.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <JavascriptQuery
    id="downloadFiles2"
    notificationDuration={4.5}
    query={include("./lib/downloadFiles2.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
  />
  <SqlQueryUnified
    id="getFileAttachments"
    enableTransformer={true}
    query={include("./lib/getFileAttachments.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    resourceTypeOverride=""
    transformer="const arrData = formatDataAsArray(data)

return arrData"
    warningCodes={[]}
  />
</GlobalFunctions>
