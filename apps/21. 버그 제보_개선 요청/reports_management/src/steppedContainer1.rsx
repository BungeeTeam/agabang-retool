<Container
  id="steppedContainer1"
  _align="center"
  _direction="vertical"
  _gap="0px"
  _justify="space-between"
  _type="stack"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
  showHeader={true}
  showHeaderBorder={false}
  transition="slide"
>
  <Header>
    <Steps
      id="steps1"
      horizontalAlign="center"
      itemMode="static"
      navigateContainer={true}
      style={{ ordered: [] }}
      targetContainerId="steppedContainer1"
      value="{{ self.values[0] }}"
    >
      <Option id="5f780" value="Step 1" />
      <Option id="c5302" value="Step 2" />
      <Option id="6874b" value="Step 3" />
    </Steps>
  </Header>
  <View
    id="f53b0"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="문의 유형 선택"
    viewKey="Step 10"
  >
    <Spacer id="spacer20" />
    <Container
      id="stack12"
      _align="center"
      _direction="vertical"
      _flexWrap={true}
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <View id="210f0" viewKey="View 1">
        <Text
          id="text23"
          horizontalAlign="center"
          value="#### 문의 유형을 선택해 주세요"
          verticalAlign="center"
        />
        <Select
          id="select4"
          emptyMessage="No options"
          itemMode="static"
          label=""
          labelPosition="top"
          overlayMaxHeight={375}
          showClear={true}
          showSelectionIndicator={true}
          style={{
            ordered: [
              { borderRadius: "40px" },
              { fontSize: "16px" },
              { fontWeight: "500" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
        >
          <Option
            id="e0b71"
            caption="잘못된 수치, 작동하지 않는 기능, 시스템 오류 등의 문제가 있어요"
            color="{{ theme.automatic[5] }}"
            label="오류 신고"
            value="error"
          />
          <Option
            id="4ad42"
            caption="사용성 개선을 위해 데이터 표시 형식 변경, 문구 변경, 속도 개선, 추가 기능이 필요해요"
            color="{{ theme.automatic[0] }}"
            label="기능 개선 요청"
            value="feature"
          />
          <Option
            id="96823"
            caption="사용 방법, 데이터 해석, 설정 방법, 권한 부여 등에 궁금함이 있어요"
            color="{{ theme.automatic[2] }}"
            label="사용 방법 문의"
            value="tutorial"
          />
        </Select>
        <Text
          id="text24"
          horizontalAlign="center"
          style={{
            ordered: [
              { fontSize: "15px" },
              { fontWeight: "400" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          value="어떤 문제로 찾아오셨나요? 문의 유형을 선택 후 다음을 눌러주세요."
          verticalAlign="center"
        />
        <Spacer id="spacer21" />
      </View>
    </Container>
    <Container
      id="stack13"
      _flexWrap={true}
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <View id="210f0" viewKey="View 1">
        <Button
          id="nextButton10"
          disabled="{{ !select4.value }}"
          hidden="{{ steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconAfter="bold/interface-arrows-right-alternate"
          style={{ ordered: [] }}
          text="다음"
        >
          <Event
            event="click"
            method="showNextVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <Button
          id="prevButton9"
          disabled="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length }}"
          hidden="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconBefore="bold/interface-arrows-left-alternate"
          maintainSpaceWhenHidden={true}
          styleVariant="outline"
          text="이전"
        >
          <Event
            event="click"
            method="showPreviousVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </View>
  <View id="d531a" label="관련 페이지 입력" viewKey="Step 1">
    <Spacer id="spacer8" />
    <Include src="./stack4.rsx" />
    <Container
      id="stack2"
      _flexWrap={true}
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <View id="210f0" viewKey="View 1">
        <Button
          id="nextButton2"
          disabled="{{ !url1.value }}"
          hidden="{{ steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconAfter="bold/interface-arrows-right-alternate"
          style={{ ordered: [] }}
          text="다음"
        >
          <Event
            event="click"
            method="showNextVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <Button
          id="prevButton2"
          disabled="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length }}"
          hidden="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconBefore="bold/interface-arrows-left-alternate"
          maintainSpaceWhenHidden={true}
          styleVariant="outline"
          text="이전"
        >
          <Event
            event="click"
            method="showPreviousVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </View>
  <View
    id="60222"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="문의 상세 기입"
    viewKey="Step 11"
  >
    <Include src="./steppedContainer2.rsx" />
  </View>
  <View
    id="8156a"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="사진 첨부"
    viewKey="Step 7"
  >
    <FileDropzone
      id="fileDropzone3"
      _isUpgraded={true}
      accept="['png','jpeg','jpg','gif','svg']"
      appendNewSelection={true}
      iconBefore="bold/programming-browser-search"
      label=""
      labelPosition="top"
      maxCount={20}
      maxSize="250mb"
      placeholder="png, jpeg, jpg, gif, svg 파일만 업로드 가능합니다."
      selectionType="multiple"
    />
    <Spacer id="spacer12" />
    <Text
      id="text20"
      horizontalAlign="center"
      value="#### (선택) 사진을 첨부해주세요
사진 파일을 드래그해서 아래 박스로 가져오거나 혹은 박스를 눌러 폴더에서 직접 사진 파일을 추가해 주세요"
      verticalAlign="center"
    />
    <Container
      id="stack8"
      _flexWrap={true}
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <View id="210f0" viewKey="View 1">
        <Button
          id="nextButton7"
          disabled=""
          hidden=""
          iconAfter="bold/interface-arrows-right-alternate"
          text="다음"
        >
          <Event
            event="click"
            method="showNextVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <Button
          id="prevButton7"
          disabled="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length }}"
          hidden="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconBefore="bold/interface-arrows-left-alternate"
          maintainSpaceWhenHidden={true}
          styleVariant="outline"
          text="이전"
        >
          <Event
            event="click"
            method="showPreviousVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </View>
  <View
    id="088ec"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="파일 첨부"
    viewKey="Step 8"
  >
    <FileDropzone
      id="fileDropzone4"
      _isUpgraded={true}
      accept="['xlsx','docx','pdf','txt','pptx']"
      appendNewSelection={true}
      iconBefore="bold/programming-browser-search"
      label=""
      labelPosition="top"
      maxCount={20}
      maxSize="250mb"
      placeholder="xlsx, docx, pdf, txt, pptx 파일만 업로드 가능합니다."
      selectionType="multiple"
    />
    <Spacer id="spacer13" />
    <Text
      id="text21"
      horizontalAlign="center"
      value="#### (선택) 문서 파일을 첨부해주세요
파일을 드래그해서 아래 박스로 가져오거나 혹은 박스를 눌러 폴더에서 직접 사진 파일을 추가해 주세요"
      verticalAlign="center"
    />
    <Container
      id="stack9"
      _flexWrap={true}
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <View id="210f0" viewKey="View 1">
        <Button
          id="nextButton8"
          disabled=""
          hidden=""
          iconAfter="bold/interface-arrows-right-alternate"
          text="다음"
        >
          <Event
            event="click"
            method="showNextVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <Button
          id="prevButton8"
          disabled="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length }}"
          hidden=""
          iconBefore="bold/interface-arrows-left-alternate"
          maintainSpaceWhenHidden={true}
          styleVariant="outline"
          text="이전"
        >
          <Event
            event="click"
            method="showPreviousVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </View>
  <View
    id="5ba8f"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="기본 정보 입력"
    viewKey="Step 6"
  >
    <Container
      id="stack11"
      _align="center"
      _direction="vertical"
      _flexWrap={true}
      _gap="0px"
      _justify="center"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
    >
      <View id="210f0" viewKey="View 1">
        <TextInput
          id="textInput3"
          label="제목"
          labelPosition="top"
          labelWidth="10"
          placeholder="요청 내용을 한 줄로 간단히 설명해 주세요"
        />
        <RadioGroup
          id="radioGroup1"
          groupLayout="singleColumn"
          itemMode="static"
          label="우선순위"
          labelPosition="top"
          value=""
        >
          <Option
            id="05794"
            caption="서비스 이용 불가 (로그인 불가, 데이터 로딩 오류 등 서비스 핵심 기능이 전혀 작동하지 않아요)

"
            label="p0"
            value="매우 높음"
          />
          <Option
            id="c49c5"
            caption="특정 기능 사용 불가/매우 어려움 (예: 카테고리 선택, 파일 업로드 등 특정 중요 기능 사용이 안되거나 매우 어려워요)"
            label="p1"
            value="높음"
          />
          <Option
            id="6e2e0"
            caption="기능은 사용 가능하나 불편함 (예: 검색 결과가 느리거나, 화면이 깨지는 등 이용에 불편함이 있어요)"
            label="p2"
            value="보통"
          />
          <Option
            id="e019c"
            caption="경미한 오류 또는 개선 필요 (사용에 큰 지장 없는 오타, UI 정렬 등 사소한 오류나 개선 제안이에요)"
            disabled={false}
            hidden={false}
            label="p3"
            value="낮음"
          />
          <Option
            id="c6eb5"
            caption="사용에 지장 없음 (사용에는 문제없지만 새로운 아이디어나 제안이 있어요)"
            disabled={false}
            hidden={false}
            label="p4"
            value="매우 낮음"
          />
        </RadioGroup>
      </View>
    </Container>
    <Spacer id="spacer14" />
    <Text
      id="text22"
      horizontalAlign="center"
      value="#### 마지막 단계입니다!
기본 정보 입력 후 '최종 제출' 버튼을 눌러주세요."
      verticalAlign="center"
    />
    <Container
      id="stack10"
      _flexWrap={true}
      _gap="0px"
      _justify="center"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <View id="210f0" viewKey="View 1">
        <Button
          id="nextButton9"
          disabled="{{ !textInput3.value || !radioGroup1.value}}"
          hidden=""
          iconAfter="bold/mail-send-email"
          text="최종 제출"
        >
          <Event
            event="click"
            method="showNextVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="click"
            method="run"
            params={{
              ordered: [
                {
                  src: "insertReports.trigger();\n//  slackNewReportsAlert.trigger();",
                },
              ],
            }}
            pluginId=""
            type="script"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </View>
  <View
    id="09ea8"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="제출 완료"
    viewKey="Step 9"
  >
    <Spacer id="spacer16" />
    <Spacer id="spacer15" />
    <Include src="./stack1.rsx" />
  </View>
  <Footer>
    <Button
      id="prevButton1"
      disabled="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length }}"
      hidden="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
      iconBefore="bold/interface-arrows-left-alternate"
      styleVariant="outline"
      text="이전"
    >
      <Event
        event="click"
        method="showPreviousVisibleView"
        params={{ ordered: [{ wrap: false }] }}
        pluginId="steppedContainer1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Button
      id="nextButton1"
      disabled="{{ steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length }}"
      hidden="{{ steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
      iconAfter="bold/interface-arrows-right-alternate"
      text="다음"
    >
      <Event
        event="click"
        method="showNextVisibleView"
        params={{ ordered: [{ wrap: false }] }}
        pluginId="steppedContainer1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Footer>
</Container>
