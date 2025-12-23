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
    report_description: {{mergeAnswers.value}} ,
	screenshot_1: {{JSON.stringify(fileDropzone3.value ?? []) }} ,
    file_attachments:{{JSON.stringify(fileDropzone4.value ?? []) }},
	app_link: {{ url1.value }},
	affected_app_version: {{ url.hashParams?.version ?? '' }},
	submitted_at: {{ moment() }} ,
	submitter_email: {{ current_user.email }},
	submitter_name: {{ current_user.fullName }},
    app_name: {{ url.hashParams?.app_name ?? '' }}
}

"
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
      '{"channel":"C096YNEVCAK","blocks":"[\\n  {\\n    \\"type\\": \\"header\\",\\n    \\"text\\": {\\n      \\"type\\": \\"plain_text\\",\\n      \\"text\\": \\"🚨 새로운 문의가 들어왔습니다.\\"\\n    }\\n  },\\n  {\\n    \\"type\\": \\"section\\",\\n    \\"text\\": {\\n      \\"type\\": \\"mrkdwn\\",\\n      \\"text\\": \\"*담당자:* <@U05G93Z9FCL>\\"\\n    }\\n  },\\n  {\\n    \\"type\\": \\"divider\\"\\n  },\\n  {\\n    \\"type\\": \\"section\\",\\n    \\"fields\\": [\\n      {\\n        \\"type\\": \\"mrkdwn\\",\\n        \\"text\\": \\"*문의 제목:*\\\\n{{result.value?.report_title ?? \'테스트\'}}\\"\\n      },\\n{\\n        \\"type\\": \\"mrkdwn\\",\\n        \\"text\\": \\"*문의 유형:*\\\\n{{result.value?.category ?? \'테스트\'}}\\"\\n      },\\n      {\\n        \\"type\\": \\"mrkdwn\\",\\n        \\"text\\": \\"*문의 작성자:*\\\\n{{result.value?.submitter_name ?? \'테스트\'}}\\"\\n      },\\n      {\\n        \\"type\\": \\"mrkdwn\\",\\n        \\"text\\": \\"*작성자 메일:*\\\\n{{result.value?.submitter_email ?? \'테스트\'}}\\"\\n      }\\n    ]\\n  },\\n  {\\n    \\"type\\": \\"section\\",\\n    \\"text\\": {\\n      \\"type\\": \\"mrkdwn\\",\\n      \\"text\\": \\"*문의 관리:* <https://agabang.cleave.work/app/reports_management//admin/reports-management#id={{result.value?.id ?? 7}}|문의 바로가기>\\"\\n    }\\n  },\\n  {\\n    \\"type\\": \\"context\\",\\n    \\"elements\\": [\\n      {\\n        \\"type\\": \\"mrkdwn\\",\\n        \\"text\\": \\"📋 문의 ID: {{result.value?.id ?? \'테스트\'}} | 📅 접수 시간: {{result.value?.submitted_at ?? \'테스트\'}}\\"\\n      }\\n    ]\\n  }\\n]"}'
    }
    path="/chat.postMessage"
    requestBodyMetadata=""
    resourceDisplayName="bug report"
    resourceName="d85c5a28-e8f9-4ebe-bade-8ec0a807b734"
    showSuccessToaster={false}
  />
  <State id="result" />
  <State
    id="questions"
    value="{
 error: {
   q_1: {
     question: '문제가 발생한 메뉴/기능명과 설정한 조회 조건(기간, 카테고리 등)을 알려주세요.',
     description: '예) 영업MD > 정상판매현황 > 매장별 판매에서 2024년 12월~2025년 1월, 시즌언더 카테고리 조회 시'
   },
   q_2: {
     question: '구체적으로 어떤 수치나 현상이 잘못되었고, 왜 오류라고 생각하시는지 설명해주세요.',
     description: '예) 판매율이 150%로 표시되는데 실제로는 불가능한 수치 / 전년 동기 대비 출고 수량이 -30,000여 개인데, 이건 차이가 너무 큼'
   },
   q_3: {
     question: '올바른 결과는 어떻게 나와야 한다고 생각하시나요? (예상 수치나 정상 동작)',
     description: '예) 판매율은 85% 정도가 정상 / 입고 수량이 ERP 상 3000개로 확인됨'
   },
   q_4: {
     question: '마지막으로 덧붙이고 싶으신 말이 있으신가요?',
     description: '추가적인 상황 설명을 자유롭게 작성해주세요.'
   }
 },
 feature: {
   q_1: {
     question: '어떤 기능의 추가나 개선이 필요한지 구체적으로 알려주세요.',
     description: '예) 영업MD > 이월 매출현황 실판가 기준과 실출고가 기준 할인율을 각각 표시 / 엑셀 다운로드 시 매장 코드 포함'
   },
   q_2: {
     question: '개선이 필요한 이유와 개선 후 어떤 업무에 활용할 예정인지 설명해주세요.',
     description: '예) 현재는 할인율 구분이 안되어 정확한 수익성 분석이 어려움. 개선되면 매장별 수익성 비교 분석에 활용 예정'
   },
   q_3: {
     question: '최종적으로 어떤 형태의 기능이나 결과가 나오기를 원하시나요?',
     description: '예) 매장코드와 매장명이 함께 표시되는 드롭다운 메뉴 / 카테고리별로 색상 구분된 표'
   },
   q_4: {
     question: '마지막으로 덧붙이고 싶으신 말이 있으신가요?',
     description: '추가적인 상황 설명을 자유롭게 작성해주세요.'
   }
 },
 tutorial: {
   q_1: {
     question: '데이터 해석에 어려움이 있는 건지, 기능 사용 방법을 모르는 건지 알려주세요.',
     description: '예) 월별 달성율 숫자의 의미를 모르겠음 / 복합 조건 설정하는 방법을 모르겠음 / 베스트&워스트 선정이 기준인지 궁금함'
   },
   q_2: {
     question: '어떤 결과를 얻기 위해 어떤 방법들을 시도해보셨나요?',
     description: '예) 매장별 판매 현황을 보려고 날짜를 1월로 설정하고 카테고리를 시즌언더로 선택했는데 원하는 데이터가 안 나옴'
   },
   q_3: {
     question: '최종적으로 어떤 결과를 얻고 싶으신가요?',
     description: '예) 특정 매장의 월별 판매 추이를 확인하고 싶음 / 시즌별 상품 판매율 순위를 알고 싶음 / 전년 대비 입고량 변화를 분석하고 싶음'
   },
   q_4: {
     question: '마지막으로 덧붙이고 싶으신 말이 있으신가요?',
     description: '관련 업무 상황, 참고할 만한 다른 화면이나 데이터 등을 자유롭게 작성해주세요.'
   }
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
