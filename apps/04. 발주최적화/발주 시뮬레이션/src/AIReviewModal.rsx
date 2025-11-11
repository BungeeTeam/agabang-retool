<ModalFrame
  id="AIReviewModal"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
  size="large"
>
  <Header>
    <Text
      id="modalTitle1"
      value="### AI를 통해 발주최적화 리뷰하기"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton1"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ ordered: [{ border: "transparent" }] }}
      styleVariant="outline"
    >
      <Event
        event="click"
        method="setHidden"
        params={{ ordered: [{ hidden: true }] }}
        pluginId="AIReviewModal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <TextArea
      id="reviewPrompt"
      autoResize={true}
      hidden="{{ isHidden.value }}"
      label="📝 요청 내용"
      labelPosition="top"
      minLines={2}
      placeholder="Enter value"
      value={
        '이번에 우리 회사에서 {{ seasonSelect.value }}시즌의 카테고리별 발주량 예측 모델을 검토해 보고자해. 각 카테고리별로 제안된 다음 시즌의 발주량이 적절하게 기획되었는지 살펴봐.\n\n**비즈니스 컨텍스트:**\n- 업종: 한국 유아복 패션 소매업\n- 목표: 과거 시즌 데이터를 활용한 다음 시즌 발주량 최적화\n- 주요 고려사항: 재고 과다/부족 최소화, 계절성, 트렌드 변화, 경제 상황, 시즌성 등 다양한 외부 사항\n\n**현재 모델 개요:**\n- 이 모델은 매장간 판매율 분포와 특성 시즌의 카테고리별 판매율을 살펴보고, 카테고리별로 사람이 설정한 바람직한 "목표판매율"을 맞추기 위해 늘리거나 줄여야 하는 최적 수량을 제안해 줍니다\n\n**데이터 특성:**\n- 시즌 코드의 첫번째 자리는 연도를 의미하고, 알파벳 순서대로 최신년도를 나타냅니다. 시즌 코드의 두번째 자리는 계절을 나타내고 1, 3, 5, 7 순으로 봄, 여름, 가을, 겨울을 의미합니다. 예를 들면 시즌코드가 R1이면 2024년의 봄 시즌을 의미합니다.\n- 해당 데이터는 {{ seasonSelect.value }}시즌의 카테고리별 주요 지표와 "목표판매율"을 달성하기 위한 최적 수량을 포함하고 있습니다.'
      }
    />
    <Button
      id="button2"
      hidden="{{ isHidden.value }}"
      iconBefore="bold/interface-edit-magic-wand"
      text="AI에게 검토 요청하기"
    >
      <Event
        event="click"
        method="setValue"
        params={{ ordered: [{ value: "{{ !isHidden.value}}" }] }}
        pluginId="isHidden"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="sendMessage"
        params={{
          ordered: [
            {
              options: {
                ordered: [
                  {
                    message:
                      '{{ reviewPrompt.value + "<data>" + JSON.stringify(simulTbl.data) + "</data>"}} ',
                  },
                  { username: "{{ current_user.fullName }}" },
                ],
              },
            },
          ],
        }}
        pluginId="orderOptChat"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Chat
      id="orderOptChat"
      _actionDisabled={{ ordered: [{ "1a": "" }] }}
      _actionHidden={{ ordered: [{ "1a": "" }] }}
      _actionIcon={{ ordered: [{ "1a": "line/interface-align-front" }] }}
      _actionIds={["1a"]}
      _actionLabel={{ ordered: [{ "1a": "Copy" }] }}
      _actionType={{ ordered: [{ "1a": "copy" }] }}
      _defaultUsername="{{ current_user.fullName }}"
      _headerButtonHidden={{ ordered: [{ "2b": "" }, { "3c": "" }] }}
      _headerButtonIcon={{
        ordered: [
          { "2b": "line/interface-download-button-2" },
          { "3c": "line/interface-delete-bin-2" },
        ],
      }}
      _headerButtonIds={["2b", "3c"]}
      _headerButtonLabel={{
        ordered: [{ "2b": "Download" }, { "3c": "Clear history" }],
      }}
      _headerButtonType={{
        ordered: [{ "2b": "download" }, { "3c": "clearHistory" }],
      }}
      _sessionStorageId="a376f18a-75c1-4448-9e70-c513bc134492"
      assistantName="아가방AI"
      avatarFallback="{{ current_user.fullName }}"
      avatarImageSize={32}
      avatarSrc="{{ current_user.profilePhotoUrl }}"
      disableSubmit=""
      emptyDescription="Send a message to chat with AI"
      emptyTitle="No messages here yet"
      hidden="{{ !isHidden.value }}"
      margin="0"
      placeholder="Type a message"
      queryTargetId="openAIAPI"
      showAvatar={true}
      showEmptyState={true}
      showHeader={true}
      showTimestamp={true}
      style={{ ordered: [{ background: "automatic" }] }}
      title="Chat"
    >
      <Event
        event="clickAction"
        method="copyToClipboard"
        params={{ ordered: [{ value: "{{ currentMessage.value }}" }] }}
        pluginId="orderOptChat"
        targetId="1a"
        type="util"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickHeader"
        method="exportData"
        pluginId="orderOptChat"
        targetId="2b"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickHeader"
        method="clearHistory"
        pluginId="orderOptChat"
        targetId="3c"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Chat>
  </Body>
</ModalFrame>
