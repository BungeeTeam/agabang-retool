<Screen
  id="form"
  _customShortcuts={[]}
  _hashParams={[]}
  _searchParams={[]}
  title="버그 제보/개선 요청"
  urlSlug=""
>
  <State
    id="insertData"
    value="{
	category: {{select4.selectedLabel}} ,
	report_title: {{textInput3.value}},
	user_priority: {{radioGroup1.value}},
    report_description: {{textArea1.value}} ,
    file_attachments:{{JSON.stringify(fileInput1.value ?? []) }},
	app_link: {{ url1.value }},
	affected_app_version: {{ url.hashParams?.version ?? '' }},
	submitted_at: {{ moment() }} ,
	submitter_email: {{ current_user.email }},
	submitter_name: {{ current_user.fullName }},
    app_name: {{ url.hashParams?.app_name ?? '' }}
}"
  />
  <Function
    id="mergeAnswers"
    funcBody={include("../lib/mergeAnswers.js", "string")}
  />
  <SqlQueryUnified
    id="insertReports"
    actionType="INSERT"
    changeset={'[{"key":"id","value":""}]'}
    changesetIsObject={true}
    changesetObject="{{ insertData.value }}"
    editorMode="gui"
    enableTransformer={true}
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showUpdateSetValueDynamicallyToggle={false}
    successMessage="제출이 완료되었습니다."
    tableName="user_reports"
    updateSetValueDynamically={true}
  >
    <Event
      event="success"
      method="setValue"
      params={{ ordered: [{ value: "{{ insertReports.data.result[0] }}" }] }}
      pluginId="result"
      type="state"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="slackNewReportsAlert"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQueryUnified>
  <OpenAPIQuery
    id="slackNewReportsAlert"
    isMultiplayerEdited={false}
    method="post"
    operationId="chat_postMessage"
    parameterDynamicStates={
      '{"attachments":false,"blocks":false,"channel":false,"icon_emoji":false,"icon_url":false,"link_names":false,"mrkdwn":false,"parse":false,"reply_broadcast":false,"text":false,"thread_ts":false,"unfurl_links":false,"unfurl_media":false,"username":false}'
    }
    parameterMetadata={'{"channel":{"label":"ai-아가방-retool-noti"}}'}
    parameters={
      '{"channel":"C096YNEVCAK","blocks":"[\\n  {\\n    \\"type\\": \\"header\\",\\n    \\"text\\": {\\n      \\"type\\": \\"plain_text\\",\\n      \\"text\\": \\"🚨 새로운 문의가 들어왔습니다.\\"\\n    }\\n  },\\n  {\\n    \\"type\\": \\"section\\",\\n    \\"text\\": {\\n      \\"type\\": \\"mrkdwn\\",\\n      \\"text\\": \\"*담당자:* <@U05G93Z9FCL>\\"\\n    }\\n  },\\n  {\\n    \\"type\\": \\"divider\\"\\n  },\\n  {\\n    \\"type\\": \\"section\\",\\n    \\"fields\\": [\\n      {\\n        \\"type\\": \\"mrkdwn\\",\\n        \\"text\\": \\"*문의 제목:*\\\\n{{result.value?.report_title ?? \'테스트\'}}\\"\\n      },\\n{\\n        \\"type\\": \\"mrkdwn\\",\\n        \\"text\\": \\"*문의 유형:*\\\\n{{result.value?.category ?? \'테스트\'}}\\"\\n      },\\n      {\\n        \\"type\\": \\"mrkdwn\\",\\n        \\"text\\": \\"*문의 작성자:*\\\\n{{result.value?.submitter_name ?? \'테스트\'}}\\"\\n      },\\n      {\\n        \\"type\\": \\"mrkdwn\\",\\n        \\"text\\": \\"*앱 이름:*\\\\n{{result.value?.app_name ?? \'테스트\'}}\\"\\n      }\\n    ]\\n  },\\n  {\\n    \\"type\\": \\"section\\",\\n    \\"text\\": {\\n      \\"type\\": \\"mrkdwn\\",\\n      \\"text\\": \\"*문의 내용:*\\\\n{{result.value?.report_description ?? \'내용 없음\'}}\\"\\n    }\\n  },\\n  {\\n    \\"type\\": \\"section\\",\\n    \\"text\\": {\\n      \\"type\\": \\"mrkdwn\\",\\n      \\"text\\": \\"*문의 관리:* <https://agabang.cleave.work/app/reports_management//admin/reports-management#id={{result.value?.id ?? 7}}|문의 바로가기>\\"\\n    }\\n  },\\n  {\\n    \\"type\\": \\"context\\",\\n    \\"elements\\": [\\n      {\\n        \\"type\\": \\"mrkdwn\\",\\n        \\"text\\": \\"📋 문의 ID: {{result.value?.id ?? \'테스트\'}} | 📅 접수 시간: {{result.value?.submitted_at ?? \'테스트\'}}\\"\\n      }\\n    ]\\n  }\\n]"}'
    }
    path="/chat.postMessage"
    requestBodyMetadata=""
    resourceDisplayName="bug report"
    resourceName="d85c5a28-e8f9-4ebe-bade-8ec0a807b734"
    showSuccessToaster={false}
  >
    <Event
      event="success"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="updateSlackInfo"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </OpenAPIQuery>
  <SqlQueryUnified
    id="updateSlackInfo"
    actionType="UPDATE_BY"
    changeset={
      '[{"key":"slack_message_ts","value":"{{ slackNewReportsAlert.data?.ts }}"},{"key":"slack_channel_id","value":"{{ slackNewReportsAlert.data?.channel }}"}]'
    }
    editorMode="gui"
    filterBy={'[{"key":"id","value":"{{ result.value?.id }}","operation":"="}]'}
    notificationDuration={4.5}
    queryDisabled="{{ slackNewReportsAlert.data?.ts.lenth >= 0}}"
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    runWhenModelUpdates={false}
    showSuccessToaster={false}
    showUpdateSetValueDynamicallyToggle={false}
    tableName="user_reports"
    updateSetValueDynamically={true}
  />
  <State id="result" />
  <State
    id="questions"
    value="{
 error: {
     question: '어떤 문제가 발생했나요?',
     description: '구체적으로 어떤 수치나 현상이 잘못되었고, 왜 오류라고 생각하시는지 설명해주세요.',
      placeholder: '- 어떤 문제가 발생했나요?
- 언제부터 이 문제가 발생했나요?
- 어떤 메뉴/화면에서 발생했나요?
- 어떤 조건(기간, 브랜드, 매장 등)으로 조회했을 때 발생했나요?
- 예상했던 결과는 무엇이고, 실제로는 어떻게 표시되나요?
- 화면 캡처나 엑셀 파일이 있다면 첨부해주세요.'
   },
 feature: {
     question: '어떤 기능을 개선하면 좋을까요?',
     description: '개선 요청사항과 개선이 필요한 맥락을 함께 설명해주세요.',
placeholder:'- 현재 어떤 불편함이 있나요?
- 어떻게 개선되면 좋을까요?
- 어떤 업무 상황에서 필요한 기능인가요?
- 참고할 만한 예시나 화면이 있다면 첨부해주세요.'
   },
 tutorial: {
     question: '무엇이 궁금하신가요?',
     description: '예) 월별 달성율 숫자의 의미를 모르겠음 / 복합 조건 설정하는 방법을 모르겠음 / 베스트&워스트 선정이 기준인지 궁금함',
placeholder:'- 어떤 기능/메뉴에 대한 문의인가요?
- 어떤 작업을 하려고 하시나요?
- 현재 어디까지 진행하셨나요?
- 화면 캡처가 있다면 첨부해주세요.'
   }
}"
  />
  <JavascriptQuery
    id="formatUrl"
    notificationDuration={4.5}
    query={include("../lib/formatUrl.js", "string")}
    resourceName="JavascriptQuery"
    runWhenPageLoads={true}
    showSuccessToaster={false}
  />
  <Frame
    id="$main3"
    enableFullBleed={true}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Include src="./steppedContainer1.rsx" />
  </Frame>
</Screen>
